module regfile(
	input [2:0] sourceReg1_i,
	input [2:0] sourceReg2_i,
	input [2:0] destReg_i,
	input writeFlag_i,
	input [7:0] data_i,
	input clk,
	output reg [7:0] data1_o,
	output reg [7:0] data2_o
);

reg [7:0] registers [7:0];

//assign data1_o = registers[sourceReg1_i];
//assign data2_o = registers[sourceReg2_i];

always_ff @ (posedge clk) 
begin
	if (writeFlag == 1)
	begin
		registers[destReg_i] <= data_i;
	end
end

always_comb 
begin
	data1_o = registers[sourceReg1_i];
	data2_o = registers[sourceReg2_i];
end
endmodule