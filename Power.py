def power(a, n):
    print('power({},{})'.format(a, n))
    if a == 0:
        return 0
    elif a == 1 or n == 0:
        return 1
    elif n == 1:
        return a
    else:
        rec = [1]*(n+1)
        rec[1] = a
        p = 0
        while p < n:
            d = 1
            rec[p+1] = rec[p]*rec[1]
            while p+2*d < n:
                rec[p+2*d] = rec[p]*rec[d]*rec[d]
                d = 2*d
                print('wtf {}'.format(p+2*d))
            p = p+d
        return rec[n]


def main():
    print(power(2, 14))
    # for i in range(1, 20):


if __name__ == '__main__':
    main()
