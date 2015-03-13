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

assign data1_o = registers[sourceReg1_i];
assign data2_o = registers[sourceReg2_i];

initial begin
	registers[0] = 8'b00001000;
	registers[1] = 8'b00000111;
	registers[2] = 8'b00000110;
	registers[3] = 8'b00000101;
	registers[4] = 8'b00000100;
	registers[5] = 8'b00000011;
	registers[6] = 8'b00000010;
	registers[7] = 8'b00000001;
end

always_ff @ (posedge clk)
begin
	if (writeFlag_i == 1)
	begin
		registers[destReg_i] <= data_i;
	end
end

endmodule
