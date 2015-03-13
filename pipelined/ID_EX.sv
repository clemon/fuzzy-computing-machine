module ID_EX(
	input clk,
	
	//Inputs from control
	input [3:0] alu_op_i,
	input write_mem_i,
	input write_reg_i,
	input read_mem_i,
	
	//Inputs from regfile
	input	[7:0] data1_i,
	input [7:0] data2_i,
	input [7:0] dataD_i,
	
	//Inputs from instr_rom (through IF_ID reg
	input [2:0] reg1_i,
	input [2:0] reg2_i,
	input [15:0]jmpLoc_i,
	input [3:0] opcode_i,
	input [2:0] imm_i,
	
	
	output wire [3:0] alu_op_o,
	output wire write_mem_o,
	output wire write_reg_o,
	output wire read_mem_o,
	output wire [7:0] data1_o,
	output wire [7:0] data2_o,
	output wire [7:0] dataD_o,
	output wire [2:0] reg1_o,
	output wire [2:0] reg2_o,
	output wire [15:0]jmpLoc_o,
	output wire [3:0] opcode_o,
	output wire [2:0] imm_o
);

always_ff @ (posedge clk) begin
	alu_op_o <= alu_op_i;
	write_mem_o <= write_mem_i;
	write_reg_o <= write_reg_i;
	read_mem_o <= read_mem_i;
	data1_o <= data1_i;
	data2_o <= data2_i;
	dataD_o <= dataD_i;
	reg1_o <= reg1_i;
	reg2_o <= reg2_i;
	jmpLoc_o <= jmpLoc_i;
	opcode_o <= opcode_i;
	imm_o <= imm_i;
end

endmodule