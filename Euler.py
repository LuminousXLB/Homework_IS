from math import sqrt
from PrimeList import PrimeList
from PrimeFactorize import factorize
from Power import power


def EulerPrime(p, alpha=1):
    if alpha == 1:
        return p-1
    elif alpha > 1:
        return power(p, alpha-1)*(p-1)


def Euler(num):
    fact = factorize(num)
    euler = 1
    if len(fact) == 0:
        euler = EulerPrime(num)
    else:
        pool = {}
        for prime in fact:
            if prime in pool:
                pool[prime] += 1
            else:
                pool[prime] = 1
        for key in pool.keys():
            euler *= EulerPrime(key, pool[key])
    return euler


def main():
    print(Euler(77))


if __name__ == '__main__':
    main()
