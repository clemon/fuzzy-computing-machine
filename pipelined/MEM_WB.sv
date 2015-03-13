module MEM_WB(
		input clk,
		input [7:0] data1_i,
		input [7:0] alu_reg_i,
		input writeReg_i,
		input [7:0] q_i,
		input [2:0] reg1_i, reg2_i,
		input [3:0] opcode_i,
		input [2:0] imm_i,
		output wire [7:0] data1_o,
		output wire [7:0] alu_reg_o,
		output wire writeReg_o,
		output wire [7:0] q_o,
		output wire [2:0] reg1_o, reg2_o,
		output wire [3:0] opcode_o,
		output wire [2:0] imm_o
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
end

endmodule