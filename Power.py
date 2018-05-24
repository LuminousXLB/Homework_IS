def power(base, exp):
    if base == 1 or exp == 0:
        return 1
    elif base == 0:
        return 0
    elif exp == 1:
        return base
    else:
        p = power(base, exp//2)
        if exp % 2 == 0:
            return p*p
        else:
            return p*p*base


def main():
    base = 0
    expo = 0
    print(base**expo, power(base, expo))
    # for i in range(1, 20):


if __name__ == '__main__':
    main()
