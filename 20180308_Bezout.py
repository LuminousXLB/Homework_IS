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
