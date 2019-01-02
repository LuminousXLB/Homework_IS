`timescale 10 ns / 1 ns

module comb_str(output y, input sel, A, B, C, D);

wire in0, in1, y0, y1, sel_bar;

nand #(3) nag0(in0, A, B);
nand #(4) nag1(in1, C, D);

not ng(sel_bar, sel);
and ag0(y0, sel_bar, in0);
and ag1(y1, sel, in1);
or og(y, y0, y1);

endmodule
