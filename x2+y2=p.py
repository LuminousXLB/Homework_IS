from ModularArith import MPower


def solve(p):
    if p != 2 and p % 4 != 1:
        raise '无解'
    if p % 8 != 5:
        raise 'p必须是8k+5形式的素数'

    x, y = MPower(2, (p-1)//4, p), 1
    m = (x**2+y**2)//p
    print('x = {}, y = {}, m = {}\n'.format(x, y, m))
    print('\t'.join(['u', 'v', 'x', 'y', 'm']))
    while m != 1:
        u, v = x % m, y % m
        x, y = (u*x+v*y)//m, (u*y-v*x)//m
        m = (x**2+y**2)//p
        print('{}\t{}\t{}\t{}\t{}'.format(u, v, x, y, m))
    return x, y


if __name__ == '__main__':
    solve(201101)
