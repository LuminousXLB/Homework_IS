
# tpl = '''
# |      | 0    | 1    | 2    | 3    | 4    | 5    |
# | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
# | 0    |      |      |      |      |      |      |
# | 1    |      |      |      |      |      |      |
# | 2    |      |      |      |      |      |      |
# | 3    |      |      |      |      |      |      |
# | 4    |      |      |      |      |      |      |
# | 5    |      |      |      |      |      |      |
# '''
from GCD import isCoprime


def SumTable(mod, *cusfield):
    tbl = []
    field = range(0, mod)
    if len(cusfield):
        field = cusfield[0]

    for r in field:
        row = []
        for c in field:
            row.append((r+c) % mod)
        tbl.append(row)
    return tbl


def ProTable(mod, *cusfield):
    tbl = []
    field = range(0, mod)
    if len(cusfield):
        field = cusfield[0]

    for r in field:
        row = []
        for c in field:
            row.append((r*c) % mod)
        tbl.append(row)
    return tbl


def TableRender(field, table, corner=''):
    dim = len(field)
    ret = []
    # Header
    row = [str(corner)]
    row.extend([str(item) for item in field])
    ret.append('|{}|'.format('|'.join(row)))
    # Separator
    ret.append('|{}|'.format('|'.join([' ---- ']*(len(field)+1))))
    # data
    for i in range(0, len(field)):
        row = [str(field[i])]
        row.extend([str(item) for item in table[i]])
        ret.append('|{}|'.format('|'.join(row)))
    return '\n'.join(ret)


def mdWriter(string):
    with open('tbl.md', 'a', encoding='utf-8') as f:
        f.write(string)
        f.write('\n\n\n')


if __name__ == '__main__':
    F21 = list(filter(lambda x: isCoprime(x, 21), range(0, 21)))
    F37 = list(filter(lambda x: isCoprime(x, 37), range(0, 37)))

    mdWriter(TableRender(F21, ProTable(21, F21), '21'))
    mdWriter(TableRender(F37, ProTable(37, F37), '37'))
    # # mdWriter(TableRender(range(0, 37), ProTable(37), 'Z/37Z: *'))
