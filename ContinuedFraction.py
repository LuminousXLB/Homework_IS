from GCD import gcd


def fracSimplify(numerator, denominator):
    c = gcd(numerator, denominator)
    return numerator//c, denominator//c


def Qsub(n1, d1, n2, d2):
    (n1, d1) = fracSimplify(n1, d1)
    (n2, d2) = fracSimplify(n2, d2)
    denominator = d1*d2
    numerator = n1*d2-n2*d1
    return fracSimplify(numerator, denominator)


def LtdContFrac(nume, deno):
    P, P_ = (1, 0)
    Q, Q_ = (0, 1)
    i = 0
    a = nume // deno
    P, P_ = (a*P+P_, P)
    Q, Q_ = (a*Q+Q_, Q)
    xn, xd = Qsub(nume, deno, a, 1)

    print('\t'.join(['i', 'a', 'x', 'P', 'Q']))
    print('{}\t{}\t{}\t{}\t{}\t'.format(i, a, '{}/{}'.format(xn, xd), P, Q))
    while xn != 0:
        i += 1
        a = xd // xn
        P, P_ = (a*P+P_, P)
        Q, Q_ = (a*Q+Q_, Q)
        xn, xd = Qsub(xd, xn, a, 1)
        print('{}\t{}\t{}\t{}\t{}\t'.format(
            i, a, '{}/{}'.format(xn, xd), P, Q))


if __name__ == '__main__':
    LtdContFrac(20180524, 23)
