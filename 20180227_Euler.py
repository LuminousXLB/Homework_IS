from math import sqrt


def PrimeList(max):
    if max < 2:
        return []
    arr = [True]*(max+1)
    sup = sqrt(max)+1
    i = 3
    while i <= sup:
        if arr[i] == True:
            j = 3
            while i*j <= max:
                arr[i*j] = False
                j += 2
        i += 2
    ret = [2]
    i = 3
    while i <= max:
        if arr[i]:
            ret.append(i)
        i += 2
    return ret


def Euler(n):
    return n*n+n+41


def main():
    with open('log.md', 'w', encoding='utf-8') as f:
        for i in range(0, 40):
            f.write('\n')
            N = Euler(i)
            probeList = PrimeList(int(sqrt(N)))
            f.write('\n因为$n={}$时$N={}$，不大于$\sqrt(N)<{}$的所有素数为{}，所以依次用{}去试除．\n\n'.format(
                i, N, int(sqrt(N)+1), str(probeList), str(probeList)))

            for item in probeList:
                f.write('{} = {} · {} + {}，\t'.format(N, N//item, item, N % item))

            f.write('\n\n根据定理1.1.7的推论，$N={}$为素数\n\n'.format(N))


if __name__ == '__main__':
    main()
