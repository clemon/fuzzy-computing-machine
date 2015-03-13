module mux(
	input [7:0] input1,
	input [7:0] input2,
	input sel,
	output reg [7:0] muxout
);

always_comb begin

	if(sel)
		muxout = input2;
	else
		muxout = input1;
		
end
endmodule