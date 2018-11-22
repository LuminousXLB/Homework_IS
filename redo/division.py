from math import sqrt


def euclid(dividend, divisor):
    return dividend//divisor, dividend % divisor


def isDivisible(dividend, divisor):
    return dividend % divisor == 0


def isPrime(n):
    if n < 2:
        return False
    elif n == 2:
        return True
    elif n % 2 == 0:
        return False
    else:
        for probe in range(3, int(sqrt(n)+1), 2):
            if n % probe == 0:
                return False
        return True


def greateCommonDivisor(a, b):
    while b != 0:
        a, b = b, a % b
    return a


def bezout(a, b):
    q, r = a//b, a % b
    s, t, u, v = 0, 1, 1, -q
    while r != 0:
        a, b = b, r
        q, r = a//b, a % b
        s, t, u, v = u, v, s-u*q, t-v*q
    return s, t, b




def main():
    print(bezout(737, -224))


if __name__ == '__main__':
    main()
