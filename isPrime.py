from random import randint
from GCD import gcd
from ModularArith import MPower


def isPrime(n, t=2):
    if n == 1:
        raise 'n=1'
    elif n == 2 or n == 3:
        return True

    for i in range(0, t):
        b = randint(2, n-2)
        print(i, b)
        if gcd(b, n) != 1:
            return False
        elif MPower(b, n-1, n) != 1:
            return False

    return True


def main():
    print(isPrime(11))


if __name__ == '__main__':
    main()
