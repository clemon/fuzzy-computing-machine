module mux15(
	input [15:0] input1,
	input [7:0] input2,
	input [3:0]sel,
	output reg [15:0] muxout
);

reg [15:0] jmpLabels [15:0];

	initial begin	
		jmpLabels[0] = 8'd10;
		jmpLabels[1] = 8'd22;
		jmpLabels[2] = 8'd102;
		jmpLabels[3] = 8'd152;
		jmpLabels[4] = 8'd196;
		jmpLabels[5] = 8'd212;
		jmpLabels[6] = 8'd8; //LOOP
		jmpLabels[7] = 8'd39; //NEXT
		jmpLabels[8] = 8'd18; //BUBBLELOOP
		jmpLabels[9] = 8'd46; //BREAKLOOP
		jmpLabels[10]= 8'd83; //ENDPAIRCHECK
		jmpLabels[11]= 8'd60; //PAIRLOOP
	end

always_comb begin

	if(sel == 4'b0010) begin
		muxout = input1;
		$display("I AM A JUMP %d", muxout); end
	else begin
		muxout = jmpLabels[input2[3:0]];
		$display("I AM NOT A JUMP %d", muxout); end
end
endmodule