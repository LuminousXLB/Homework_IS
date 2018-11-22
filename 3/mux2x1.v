`timescale 10 ns / 1 ns

module mux2x1(output dout, input sel, [1:0] din);

bufif0(dout, din[0], sel);
bufif1(dout, din[1], sel);

endmodule
