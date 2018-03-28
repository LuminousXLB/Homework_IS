def MAdd(a, b, m):
    r1 = a % m
    r2 = b % m
    return (r1+r2) % m


def MMultiply(a, b, m):
    r1 = a % m
    r2 = b % m
    return (r1*r2) % m
