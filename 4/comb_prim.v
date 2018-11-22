`timescale 10 ns / 1 ns

primitive comb_prim(output Y, input A, B, C, D);

table
//	D	C	B	A	:	out	;
	0	0	0	0	:	0	;
	0	0	0	1	:	0	;
	0	0	1	0	:	0	;
	0	0	1	1	:	0	;
	0	1	0	0	:	0	;
	0	1	0	1	:	0	;
	0	1	1	0	:	1	;
	0	1	1	1	:	0	;
	1	0	0	0	:	0	;
	1	0	0	1	:	0	;
	1	0	1	0	:	0	;
	1	0	1	1	:	0	;
	1	1	0	0	:	0	;
	1	1	0	1	:	0	;
	1	1	1	0	:	0	;
	1	1	1	1	:	0	;
endtable

endprimitive
