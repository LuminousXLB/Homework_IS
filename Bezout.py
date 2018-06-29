def Bezout(a, b):
    # 思考1.8(7)
    # = [q, r, s, t]
    f = [0, a, 1, 0]
    l = [0, b, 0, 1]
    while True:
        t = [f[1]//l[1], f[1] % l[1]]
        if t[1] == 0:
            return l[2], l[3], l[1]  # s, t, gcd
        else:
            t.extend([-t[0] * l[2] + f[2], -t[0] * l[3] + f[3]])
            f, l = l, t


def myBezout(a, b):
    q, r = a//b, a % b
    s, t, u, v = 0, 1, 1, -q
    while r != 0:
        a, b = b, r
        q, r = a//b, a % b
        s, t, u, v = u, v, s-u*q, t-v*q
    return s, t, b


if __name__ == '__main__':
    from random import randint
    a = randint(0xF00FFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF)
    b = randint(0xF00FFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF)
    print(a, b)
    # a, b = 1234567894534521234360, 912341233871234654321
    print(myBezout(a, b))
    print(Bezout(a, b))
