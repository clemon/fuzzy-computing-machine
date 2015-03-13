module EX_MEM(
	input clk,
	
	//Inputs from control via ID_EX
	input write_mem_i,
	input write_reg_i,
	input read_mem_i,
	
	//Inputs from regfile via ID_EX
	input [7:0] data1_i,
	input [7:0] data2_i,
	
	//Input from ALU
	input [7:0] aluOut_i,
	
	//Inputs from instr_rom via ID_EX via IF_ID
	input [2:0] reg1_i,
	input [2:0] reg2_i,
	input [3:0] opcode_i,
	input [2:0] imm_i,
	
	input [7:0] dataD_i,
	
	output wire write_mem_o,
	output wire write_reg_o,
	output wire read_mem_o,
	output wire [7:0] data1_o,
	output wire [7:0] data2_o,
	output wire [7:0] aluOut_o,
	output wire [2:0] reg1_o,
	output wire [2:0] reg2_o,
	output wire [3:0] opcode_o,
	output wire [2:0] imm_o,
	
	output wire [7:0] dataD_o
);

always_ff @ (posedge clk) begin
	write_mem_o <= write_mem_i;
	write_reg_o <= write_reg_i;
	read_mem_o <= read_mem_i;
	data1_o <= data1_i;
	data2_o <= data2_i;
	aluOut_o <= aluOut_i;
	reg1_o <= reg1_i;
	reg2_o <= reg2_i;
	opcode_o <= opcode_i;
	imm_o <= imm_i;
	dataD_o <= dataD_i;
end

endmodule