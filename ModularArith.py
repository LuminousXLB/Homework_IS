from Euler import Euler


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


if __name__ == '__main__':
    print(MFactorial(1000000000, 1000000001))
