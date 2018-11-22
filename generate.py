from pathlib import Path

head = '`timescale 10 ns / 1 ns\n'
include = '`include "{}.v"\n'

module = '''
module {};

endmodule
'''

module_lst = [
	('seq_detect', 'seq_detect( ouput reg flag, input din, clk，rst_n )'),
	('tb_seq_detect', 'tb_seq_detect()')
]

no = 'f'

for fn, mo in module_lst:
    with Path(no, fn + '.v').open('w') as f:
        f.write(head)
        if fn.find('tb_') == 0:
            f.write(include.format(fn.replace('tb_', '')))
        f.write(module.format(mo))
