from math import sqrt


def factorize(n):
    for d in range(int(sqrt(n)), 0, -1):
        if n % d == 0:
            s = n//d
            print(s, d)
            return (s+d)//2, (s-d)//2


def main():
    N = 567890
    a, b = factorize(N)
    print('a={},b={},a2-b2 = {}'.format(a, b, a*a-b*b))
    # a, b = fact2(N)
    # print('a={},b={},a2-b2 = {}'.format(a, b, a*a-b*b))


if __name__ == '__main__':
    main()
