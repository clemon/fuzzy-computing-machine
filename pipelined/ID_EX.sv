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
	input [2:0] regD_i,
	input branchTaken_i,
	
	output reg [3:0] alu_op_o,
	output reg write_mem_o,
	output reg write_reg_o,
	output reg read_mem_o,
	output reg [7:0] data1_o,
	output reg [7:0] data2_o,
	output reg [7:0] dataD_o,
	output reg [2:0] reg1_o,
	output reg [2:0] reg2_o,
	output reg [15:0]jmpLoc_o,
	output reg [3:0] opcode_o,
	output reg [2:0] imm_o,
	output reg [2:0] regD_o
);

always_ff @ (posedge clk/*, posedge branchTaken_i*/) begin
/*	if (branchTaken_i == 1) begin
		alu_op_o <= 'x;
		write_mem_o <= 'x;
		write_reg_o <= 'x;
		read_mem_o <= 'x;
		data1_o <= 'x;
		data2_o <= 'x;
		dataD_o <= 'x;
		reg1_o <= 'x;
		reg2_o <= 'x;
		jmpLoc_o <= 'x;
		opcode_o <= 'x;
		imm_o <= 'x;
		regD_o <= 'x;
	end
	else begin*/
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
		regD_o <= regD_i;
	//end
end

endmodule