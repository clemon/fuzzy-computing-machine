module MEM_WB(
		input clk,
		input [7:0] data1_i,
		input [7:0] alu_reg_i,
		input writeReg_i,
		input [7:0] q_i,
		input [2:0] reg1_i, reg2_i,
		input [3:0] opcode_i,
		input [2:0] imm_i,
		input [2:0] regD_i,
		input [7:0] meDat_i,
		output reg [7:0] data1_o,
		output reg [7:0] alu_reg_o,
		output reg writeReg_o,
		output reg [7:0] q_o,
		output reg [2:0] reg1_o, reg2_o,
		output reg [3:0] opcode_o,
		output reg [2:0] imm_o,
		output reg [2:0] regD_o,
		output reg [7:0] meDat_o
	);

always_ff @ (posedge clk)
begin
	data1_o    <= data1_i;
	alu_reg_o  <= alu_reg_i;
	writeReg_o <= writeReg_i;
	q_o        <= q_i;
	reg1_o     <= reg1_i;
	reg2_o     <= reg2_i;
	opcode_o   <= opcode_i;
	imm_o  	   <= imm_i;
	regD_o <= regD_i;
	meDat_o <= meDat_i;
end

endmodule