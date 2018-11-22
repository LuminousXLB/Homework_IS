`timescale 10 ns / 1 ns

module comb_str(output Y, input A, B, C, D);

wire ou1, ou2, ou3, ou4;

not u1(ou1, D);
not u2(ou2, ou3);
or u3(ou3, A, D);
and u4(ou4, B, C, ou1);
and u5(Y, ou2, ou4);

endmodule
