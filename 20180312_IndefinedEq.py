# 思考1.8(10)


def Bezout(a, b):
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


def solve(a, b, c):
    # ax + by = c
    s, t, gcd = Bezout(int(a), int(b))
    if c % gcd != 0:
        raise Exception("No Solution")
        
    Special = (s*int(c)//gcd, t*int(c)//gcd)
    General = (
        '{} - t * {}'.format(Special[0], b//gcd),
        '{} + t * {}'.format(Special[1], a//gcd)
    )
    return Special, General


def main():
    s, g = solve(77, 63, 40)
    print(s, g)


if __name__ == '__main__':
    main()
