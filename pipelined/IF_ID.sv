module IF_ID(
		input clk,
		input [1:0] format_i,
		input [3:0] opcode_i,
		input [2:0] reg1_i, reg2_i, regD_i,
		input [2:0] imm_i,
		input immFlag_i,
		input [15:0] jmpLoc_i,
		input branchTaken_i,
		output reg [1:0] format_o,
		output reg [3:0] opcode_o,
		output reg [2:0] reg1_o, reg2_o, regD_o,
		output reg [2:0] imm_o,
		output reg immFlag_o,
		output reg [15:0] jmpLoc_o
	);

always_ff @ (posedge clk, posedge branchTaken_i)
begin
	if (branchTaken_i == 1) begin
		format_o  <= 'x;
		opcode_o  <= 'x;
		reg1_o    <= 'x;
		reg2_o    <= 'x;
		regD_o    <= 'x;
		imm_o     <= 'x;
		immFlag_o <= 'x;
		jmpLoc_o  <= 'x;
	end
	else begin
		format_o  <= format_i;
		opcode_o  <= opcode_i;
		reg1_o    <= reg1_i;
		reg2_o    <= reg2_i;
		regD_o    <= regD_i;
		imm_o     <= imm_i;
		immFlag_o <= immFlag_i;
		jmpLoc_o  <= jmpLoc_i;
	end
end

endmodule