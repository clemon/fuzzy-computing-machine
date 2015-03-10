// Quartus II Verilog Template
// Single port RAM with single read/write address and initial contents 
// specified with an initial block

module datamem
#(parameter ADDR_WIDTH=8)
(
	input [7:0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input writemem, readmem, clk,
	output [7:0] q
);

	// Declare the RAM variable
	reg [7:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	initial 
	begin
		ram[1] = 8'd19;
		ram[2] = 8'd61;
		ram[3] = 8'd23;

		ram[6] = 8'h05;

		ram[32] = 8'h12;
		ram[33] = 8'h34;
		ram[34] = 8'h56;
		ram[35] = 8'h78;
		ram[36] = 8'h9a;
		ram[37] = 8'hbc;
		ram[38] = 8'hde;	
		ram[39] = 8'hf0;	
		ram[40] = 8'h11;	
		ram[41] = 8'h22;	
		ram[42] = 8'h33;	
		ram[43] = 8'h44;	
		ram[44] = 8'h55;	
		ram[45] = 8'h66;	
		ram[46] = 8'h77;	
		ram[47] = 8'h88;
		ram[48] = 8'h99;
		ram[49] = 8'haa;
		ram[50] = 8'hde;
		ram[51] = 8'had;
		ram[52] = 8'hbe;
		ram[53] = 8'hef;
		ram[54] = 8'h02;	
		ram[55] = 8'h46;	
		ram[56] = 8'h8a;	
		ram[57] = 8'hce;	
		ram[58] = 8'h13;	
		ram[59] = 8'h57;	
		ram[60] = 8'h9a;	
		ram[61] = 8'hcf;	
		ram[62] = 8'h39;	
		ram[63] = 8'haa;
		ram[64] = 8'hbc;
		ram[65] = 8'hf1;
		ram[66] = 8'h00;
		ram[67] = 8'hf0;
		ram[68] = 8'h57;	
		ram[69] = 8'h68;
		ram[70] = 8'h9a;	
		ram[71] = 8'h56;	
		ram[72] = 8'hbe;	
		ram[73] = 8'hde;	
		ram[74] = 8'hfe;	
		ram[75] = 8'hed;	
		ram[76] = 8'h03;	
		ram[77] = 8'h69;
		ram[78] = 8'hcf;
		ram[79] = 8'h25;
		ram[80] = 8'h8a;	
		ram[81] = 8'hd1;	
		ram[82] = 8'h47;	
		ram[83] = 8'had;	
		ram[84] = 8'h15;	
		ram[85] = 8'h9d;	
		ram[86] = 8'h01;	
		ram[87] = 8'h23;
		ram[88] = 8'h34;
		ram[89] = 8'h56;
		ram[90] = 8'h78;	
		ram[91] = 8'h9a;	
		ram[92] = 8'hbc;	
		ram[93] = 8'hde;	
		ram[94] = 8'hf0;	
		ram[95] = 8'h00;
	
		ram[128] =  8'd2;
		ram[129] = -8'd23;
		ram[130] = -8'd33;
		ram[131] =  8'd63;
		ram[132] =  8'd18;
		ram[133] =  8'd23;		
		ram[134] = -8'd52;
		ram[135] =  8'd28;
		ram[136] =  8'd9;
		ram[137] = -8'd8;
		ram[138] =  8'd6;
		ram[139] =  8'd105;
		ram[140] =  8'd94;
		ram[141] = -8'd83;
		ram[142] =  8'd55;
		ram[143] =  8'd100;		
		ram[144] = -8'd3;
		ram[145] = -8'd72;
		ram[146] =  8'd65;
		ram[147] = -8'd47;	
	
	end 

	always @ (*)
	begin
		// Write
		if (writemem) begin
			ram[addr] = data;
			$display("\nStoring: %d at %d", data, addr);
		end
	end


	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = (readmem)? ram[addr] : 8'bxxxxxxxx;

endmodule