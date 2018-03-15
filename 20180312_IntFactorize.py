from math import sqrt
import json

MAX = 1000000 - 2


def gcd(n1, n2):
    while(n2 != 0):
        n1, n2 = n2, n1 % n2
    return n1


def factorize(n):
    with open('sqtable.json') as f:
        sqTable = json.loads(f.read())

    nqr = int(sqrt(n))
    for a in range(nqr+1, MAX):
        diff = sqTable[a] - n
        while diff > 0:
            dqr = int(sqrt(diff))
            if sqTable[dqr] == diff:
                b = dqr
                if (a-b) % n != 0 and (a+b) % n != 0:
                    return a, b
            elif sqTable[dqr+1] == diff:
                b = dqr+1
                if (a-b) % n != 0 and (a+b) % n != 0:
                    return a, b
            diff -= n

    raise('factorize falied')


def main():
    N = 37909
    a, b = factorize(N)
    print('N = {}; a = {}, b = {};'.format(N, a, b))
    print('a2 - b2 = {}*{}'.format((a*a-b*b)//N, N))
    print('a + b = {}, a - b = {}'.format(a+b, a-b))
    print('(n, a + b) = {}, (n, a - b) = {}'.format(gcd(N, a+b), gcd(N, a-b)))


if __name__ == '__main__':
    main()
