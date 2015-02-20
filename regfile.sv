module regfile(
	input [2:0] sourceReg1_i,
	input [2:0] sourceReg2_i,
	input [2:0] destReg_i,
	input writeFlag_i,
	input overFlag_i,
	input [7:0] data_i,
	input [7:0] over_i,
	input clk,
	output reg [7:0] data1_o,
	output reg [7:0] data2_o,
	output reg [7:0] dataD_o,
	output reg [7:0] r0,
	output reg [7:0] r1,
	output reg [7:0] r2,
	output reg [7:0] r3,
	output reg [7:0] r4,
	output reg [7:0] r5,
	output reg [7:0] r6,
	output reg [7:0] r7
);

reg [7:0] registers [7:0];

assign data1_o = registers[sourceReg1_i];
assign data2_o = registers[sourceReg2_i];
assign dataD_o = registers[destReg_i];
assign r0 = registers[0];
assign r1 = registers[1];
assign r2 = registers[2];
assign r3 = registers[3];
assign r4 = registers[4];
assign r5 = registers[5];
assign r6 = registers[6];
assign r7 = registers[7];

initial begin
	registers[0] = 8'b00000001;
	registers[1] = 8'b00000111;
	registers[2] = 8'b00100011;
	registers[3] = 8'b00000001;
	registers[4] = 8'b00110000;
	registers[5] = 8'b00000011;
	registers[6] = 8'b00000010;
	registers[7] = 8'b00000001;
end

always_ff @ (negedge clk)
begin
	if (writeFlag_i == 1)
	begin
		registers[destReg_i] <= data_i;

		if (overFlag_i == 1) registers[7] <= over_i;
	end
end

endmodule
