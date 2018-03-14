def gcd(n1, n2):
    # 思考1.8(5)
    while(n2 != 0):
        # print('{} = {} · {} + {}'.format(n1, n1//n2, n2, n1 % n2))
        n1, n2 = n2, n1 % n2

    return n1
