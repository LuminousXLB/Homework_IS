
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
    mdWriter(TableRender(range(0, 6), SumTable(6), 'Z/6Z: +'))
    mdWriter(TableRender(range(0, 6), ProTable(6), 'Z/6Z: *'))
    mdWriter(TableRender(range(0, 5), SumTable(5), 'Z/5Z: +'))
    mdWriter(TableRender(range(0, 5), ProTable(5), 'Z/5Z: *'))
    mdWriter(TableRender(range(0, 18), SumTable(18), 'Z/18Z: +'))
    mdWriter(TableRender(range(0, 18), ProTable(18), 'Z/18Z: *'))
