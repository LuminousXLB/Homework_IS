import json

pool = []

for i in range(0, 1000000):
    pool.append(i*i)
    print(i)

with open('sqtable.json', 'w', encoding='utf-8') as f:
    f.write(json.dumps(pool))
