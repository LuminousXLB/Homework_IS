# 思考1.8(9)
from math import sqrt


def PrimeList(max):
    if max < 2:
        return []
    arr = [True]*(max+1)
    sup = sqrt(max)+1
    i = 3
    while i <= sup:
        if arr[i] == True:
            j = 3
            while i*j <= max:
                arr[i*j] = False
                j += 2
        i += 2
    ret = [2]
    i = 3
    while i <= max:
        if arr[i]:
            ret.append(i)
        i += 2
    return ret


def factorize(n):
    fact = []
    probe = PrimeList(int(sqrt(n)+1))
    for p in probe:
        while n % p == 0:
            fact.append(p)
            n //= p
    return fact


if __name__ == '__main__':
    N = 2*2*4*6*123*4325
    fact = factorize(N)
    print('N = {}\nfact = {}'.format(N, fact))
