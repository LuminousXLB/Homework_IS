from Euler import Euler
from ModularArith import MPower


def ord(modulus, base):
    eu = Euler(modulus)
    for k in range(1, eu):
        if eu % k == 0 and MPower(base, k, modulus) == 1:
            return k
    return eu


if __name__ == '__main__':
    m = 167
    res = []
    for a in range(1, m):
        if ord(m, a) == Euler(m):
            res.append(str(a))
    print('\t'.join(res))
