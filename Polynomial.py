from ModularArith import MPolynomial
from Euler import Euler


def PolySimplify(polynomial, modulus):
    pol = {}
    ret = []
    eu = Euler(modulus)
    for (coefficient, exponent) in polynomial:
        exp = exponent % eu
        if exp in pol:
            pol[exp] += coefficient
        else:
            pol[exp] = coefficient

    for (e, c) in pol.items():
        coff = c % modulus
        if coff:
            ret.append((coff, e))
    return ret


def PolyFormat(polynomial):
    pol = []
    for (c, e) in sorted(polynomial, key=lambda x: x[1], reverse=True):
        if e == 0:
            pol.append('{}'.format(c, e))
        elif e == 1:
            pol.append('{}x'.format(c, e))
        else:
            pol.append('{}x^{}'.format(c, e))
    return 'f(x) = {}'.format(' + '.join(pol))


if __name__ == '__main__':
    poly = [
        (2013, 2013),
        (11, 2011),
        (25, 10),
        (13, 9),
        (1, 6),
        (4, 3),
        (20130311, 1),
        (1, 0)
    ]
    diff = [
        (2013*2013, 2013-1),
        (11*2011, 2011-1),
        (25*10, 10-1),
        (13*9, 9-1),
        (1*6, 6-1),
        (4*3, 3-1),
        (20130311*1, 1-1)
    ]
    pl = [poly, diff]
    xl = [16]
    m = 7**3
    for p in pl:
        print('\n')
        simp = PolySimplify(p, m)
        print(PolyFormat(p), ' (mod {})'.format(m))
        print(' > '+PolyFormat(simp), ' (mod {})'.format(m))
        for x in xl:
            print('\tf({}) = {}\tmod {}'.format(x, MPolynomial(x, simp, m), m))
