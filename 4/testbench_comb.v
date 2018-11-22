`timescale 10 ns / 1 ns
`include "comb_str.v"
`include "comb_dataflow.v"
`include "comb_behavior.v"
`include "comb_prim.v"

module testbench_comb();

reg A, B, C, D;
wire str, dataflow, behavior, prim;

initial begin
	{D, C, B, A} = 4'b0;
	forever
		#5 {D, C, B, A} = {D, C, B, A} + 1;
end

comb_str cstr(str, A, B, C, D);
comb_dataflow cdataflow(dataflow, A, B, C, D);
comb_behavior cbehavior(behavior, A, B, C, D);
comb_prim cprim(prim, A, B, C, D);

initial
	$monitor($time, "\tDCBA = %4b\tstr = %b\tdataflow = %b\tbehavior = %b\tprim = %b", {D, C, B, A}, str, dataflow, behavior, prim);

endmodule
