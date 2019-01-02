%option noyywrap
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

void emit();

bool isExpr = false;
yy_size_t expr_len = 0;
yy_size_t read_len = 0;
yy_size_t max_flt_precision = 0;

bool intExpr = true;
int64_t iExprCache = 0;
double fExprCache = 0;

bool isIntegral = true;
int64_t iCache = 0;
double fCache = 0;

%}

digit			[0-9]
nonzerodigit    [1-9]
octdigit        [0-7]
bindigit        [01]
hexdigit        [0-9|a-f|A-f]

decimalinteger	({nonzerodigit}{digit}*)|0
octinteger		0[oO]?{octdigit}+
hexinteger		0[xX]{hexdigit}+
bininteger		0[bB]{bindigit}+

autointeger		[-+]?({decimalinteger}|{hexinteger})[lL]?
handoint		[-+]?{octinteger}[lL]?
handbint		[-+]?{bininteger}[lL]?

intpart			{digit}+

pointfloat		({intpart}?[.]{intpart})|({intpart}[.])
exponentfloat	({intpart}|{pointfloat})[eE][-+]?{intpart}

floatnumber		[-+]?({pointfloat}|{exponentfloat})

expression		({autointeger}|{handoint}|{handbint}|{floatnumber})+

%%

{autointeger} {
    // parse Decimal and Hexadecimal integers

    errno = 0;
    int64_t value = strtoll(yytext, NULL, 0);

    isIntegral = true;
    iCache = value;

    if (errno == ERANGE && !isExpr) {
        // if ERANGE error exists during parsing, output it directly
        ECHO;
    } else {
        // else go to the unified processing function
        emit();
    }
}

{handoint} {
    // parse Octal integers

    errno = 0;
    bool sign = 0;
    int64_t value = 0;

    int i = 0;

    // check whether it is negative or not, and go over the sign
    if (yytext[i] == '-') {
        sign = 1;
        i++;
    } else if (yytext[i] == '+') {
        i++;
    }

    // check the leading 0, and go over it
    if (yytext[i] == '0') {
        i++;
    }

    // check whether the prefix contains o or O, which strtoll doesn't reconize
    // and go over it
    if (yytext[i] == 'o' || yytext[i] == 'O') {
        i++;
    }

    // now we comes to the real value of the octal number and Parse it
    value = strtoll(yytext + i, NULL, 8);
    if (sign) {
        value = -value;
    }

    isIntegral = true;
    iCache = value;

    if (errno == ERANGE && !isExpr) {
        ECHO;
    } else {
        emit();
    }
}

{handbint} {
    // parse Binary integers
    // Completely the same logic as the {handoint}

    errno = 0;
    bool sign = 0;
    int64_t value = 0;

    int i = 0;
    if (yytext[i] == '-') {
        sign = 1;
        i++;
    } else if (yytext[i] == '+') {
        i++;
    }

    if (yytext[i] == '0') {
        i++;
    }

    if (yytext[i] == 'b' || yytext[i] == 'B') {
        i++;
    }

    value = strtoll(yytext + i, NULL, 2);
    if (sign) {
        value = -value;
    }

    isIntegral = true;
    iCache = value;

    if (errno == ERANGE && !isExpr) {
        ECHO;
    } else {
        emit();
    }
}

{floatnumber} {
    // parse float numbers, which is really handy to use strod

    double value = strtod(yytext, NULL);

    isIntegral = false;
    fCache = value;
    emit();
}

{expression} {
    // if it comes to an expression, we set the state isExpr to true and REJECT
    // then flex will find the next best rule

    if (isExpr) {
        // however, it may take expression as the next best rule
        // so we have to REJECT it again
        REJECT;
    } else {
        isExpr = true;
        expr_len = yyleng;
        REJECT;
    }
}


%%

void printInt(int64_t value)
{
    fprintf(yyout, "%ld", value);
}

void printFloat(double value, yy_size_t len)
{
    // here we do some magic to get a pretty print of float numbers
    // read the report for details

    fprintf(yyout, "%.6f", value);

    // ***********Deprecated***********
    // char buffer[1024] = { 0 };
    // char fmt[256] = { 0 };
    // sprintf(fmt, "%%.%lug", len);
    // sprintf(buffer, fmt, value);

    // // here we seach the g-format notation to find '.' and 'e'
    // int idx_p = -1, idx_e = -1;
    // for (int i = 0; buffer[i] != '\0'; i++) {
    //     if (buffer[i] == '.') {
    //         idx_p = i;
    //     } else if (buffer[i] == 'e') {
    //         idx_e = i;
    //         break;
    //     }
    // }


    // if (idx_e > -1) {
    //     // if there is a 'e' in the notation, we will reformat it
    //     if (value > 1) {
    //         fprintf(yyout, "%.1f", value);
    //     } else {
    //         int pre = idx_e - idx_p;
    //         int eee = atoi(buffer + idx_e + 1);
    //         pre += (eee < 0) ? (-eee) : eee;

    //         char fmt[256] = { 0 };
    //         sprintf(fmt, "%%.%df", pre-1);
    //         fprintf(yyout, fmt, value);
    //     }
    // } else if (idx_p == -1) {
    //     // if there is not a '.' in the notation, we will add one
    //     fprintf(yyout, "%.1f", value);
    // } else {
    //     // otherwise, just print it
    //     fprintf(yyout, "%s", buffer);
    // }
}

void emit()
{
    if (isExpr) {
        // if it is in the Expr state
        // we first add current yyleng to read_len, which will be used to decide
        // when to finish the expression detect
        read_len += yyleng;

        // then we add integers and floats separately
        if (isIntegral) {
            iExprCache += iCache;
        } else {
            // remember to set intExpr to false when we got a float
            intExpr = false;
            fExprCache += fCache;
        }

        // this length is used to format the float result
        if(yyleng > max_flt_precision) {
            max_flt_precision = yyleng;
        }

        if (read_len == expr_len) {
            // if it comes out that read_len == expr_len, we know the expression
            // detect has finished

            // we shall print the result
            if (intExpr) {
                printInt(iExprCache);
            } else {
                printFloat(fExprCache + iExprCache, max_flt_precision + 1);
            }

            // reset the states
            intExpr = true;
            expr_len = 0;
            read_len = 0;
            iExprCache = 0;
            fExprCache = 0;


            // and remove the flag
            isExpr = false;
        }
    } else {
        // or just print
        if (isIntegral) {
            printInt(iCache);
        } else {
            printFloat(fCache, yyleng);
        }
    }
}


void main(void)
{
    yylex();
}
