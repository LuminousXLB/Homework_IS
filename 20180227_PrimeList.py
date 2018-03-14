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