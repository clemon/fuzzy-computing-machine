module IF_ID(
		input clk,
		input [1:0] format_i,
		input [3:0] opcode_i,
		input [2:0] reg1_i, reg2_i, regD_i,
		input [2:0] imm_i,
		input immFlag_i,
		input [15:0] jmpLoc_i,
		output wire [1:0] format_o,
		output wire [3:0] opcode_o,
		output wire [2:0] reg1_o, reg2_o, regD_o,
		output wire [2:0] imm_o,
		output wire immFlag_o,
		output wire [15:0] jmpLoc_o
	);

always_ff @ (posedge clk)
begin
	format_o  <= format_i;
	opcode_o  <= opcode_i;
	reg1_o    <= reg1_i;
	reg2_o    <= reg2_i;
	regD_o    <= regD_i;
	imm_o     <= imm_i;
	immFlag_o <= immFlag_i;
	jmpLoc_o  <= jmpLoc_i;
end

endmodule