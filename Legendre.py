from ModularArith import MPower
from PrimeFactorize import factorize
from functools import reduce


def jacobi(a, m):
    if m % 2 == 0:
        raise 'm必须为奇数'

    if a == 1:
        return 1
    elif a == -1:
        exp = (m-1) % 4
        return 1 if exp == 1 else -1
    elif a == 2:
        exp = (m**2 - 1) // 8
        return -1 if exp % 2 else 1
    elif a > m
        return jacobi(a % m, m)
    else:
        fact = factorize(a)
        if len(fact):
            return reduce(lambda x, y: x*y, [legendre(pa, p) for pa in a])

    return ((-1)**((a-1)*(m-1)//4))*legendre(m % a, a)
