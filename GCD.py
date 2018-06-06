def gcd(n1, n2):
    # 思考1.8(5)
    while(n2 != 0):
        # print('{} = {} · {} + {}'.format(n1, n1//n2, n2, n1 % n2))
        n1, n2 = n2, n1 % n2

    return n1


def isCoprime(n1, n2):
    # 思考1.8(6)
    return gcd(n1, n2) == 1


if __name__ == '__main__':
    print(isCoprime(2, 3))
    print(isCoprime(12, 18))
