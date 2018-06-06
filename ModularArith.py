from Euler import Euler
from Bezout import Bezout
from PrimeFactorize import factorize
from functools import reduce


def MAdd(a, b, m):
    r1 = a % m
    r2 = b % m
    return (r1+r2) % m


def MMultiply(a, b, m):
    r1 = a % m
    r2 = b % m
    return (r1*r2) % m


def MPower(base, exp, mod):
    if base == 1 or exp == 0:
        return 1 % mod
    elif base == 0:
        return 0 % mod
    elif exp == 1:
        return base % mod
    else:
        p = MPower(base, exp//2, mod)
        if exp % 2 == 0:
            return p*p % mod
        else:
            return p*p*base % mod


def MFactorial(n, m):
    f = 1
    for i in range(1, n+1):
        f = f*i % m
    return f


def MPolynomial(x, polynomial, modulus):
    value = 0
    eu = Euler(modulus)
    xm = x % modulus
    for (coefficient, exponent) in polynomial:
        value += (coefficient % modulus)*MPower(xm, exponent % eu, modulus)
    return value % modulus


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
    elif a > m:
        return jacobi(a % m, m)
    else:
        fact = factorize(a)
        if len(fact) > 1:
            return reduce(lambda x, y: x*y, [jacobi(pa, m) for pa in fact])

    return ((-1)**((a-1)*(m-1)//4))*jacobi(m % a, a)


def MSqrt(a, modp):
    stat = jacobi(a, modp)
    if stat == 0:
        return [0]
    elif stat == -1:
        raise '无解'
    elif modp == 2:
        raise 'p = 2'

    if modp % 4 == 3:
        solution = MPower(a, (modp+1)//4, p)
        return [solution, -solution]

    s = modp - 1
    t = 0
    while s % 2 == 0:
        t += 1
        s //= 2
    t_save = t

    n = 2
    while jacobi(n, modp) != -1:
        n += 1
    b = MPower(n, s, modp)
    (a_inverse, dep, dep) = Bezout(a, modp)
    a_inverse = a_inverse + modp if a_inverse < 0 else a_inverse

    print(' -- ', n, s, b, a_inverse)
    x = MPower(a, (s+1)//2, modp)
    for k in range(1, t):
        y = a_inverse*x*x % modp
        j = MPower(y, 2**(t-k-1), modp)
        if j == modp-1:
            x = MMultiply(x, MPower(b, 2**(k-1), modp), modp)
        print(k, t-k-1, y, j, x)
        # print(j, x)
    return x


if __name__ == '__main__':
    # print(MPower(10, 31, 41))
    # print((20+37023) % 41)
    # print(MPower(5, 83, 167))
    print(MSqrt(103, 1601))
    # print(jacobi(3, 1601))
