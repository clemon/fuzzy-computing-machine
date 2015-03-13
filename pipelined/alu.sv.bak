`define OP_ADD 4'b0000 //Addition
`define OP_SUB 4'b0001 //Subtract
`define OP_SFL 4'b0010 //Shift left
`define OP_SFR 4'b0011 //Shift right
`define OP_INC 4'b0100 //Increment
`define OP_DEC 4'b0101 //Decrement
`define OP_BNE 4'b0110 //Branch not equal
`define OP_BEQ 4'b0111 //Branch equal
`define OP_BLT 4'b1000 //Branch less than

module alu (
	input [3:0] inst_i,
	input [7:0] reg1_i,
	input [7:0] reg2_i,
	output reg [7:0] reg_o,
	output reg branch_o
);

reg [15:0] overflow;

always_comb begin
	// Defaults
	overflow = 0;
	branch_o = 0;
	reg_o = 0;

	unique case(inst_i)
		`OP_ADD: begin 	//0000
					overflow = reg1_i + reg2_i; 
					reg_o = overflow[7:0]; 
					end 
		`OP_SUB: reg_o = reg1_i - reg2_i;					//0001
		`OP_SFL: reg_o = reg1_i << reg2_i;					//0010
		`OP_SFR: reg_o = reg1_i >> reg2_i;					//0011
		`OP_INC: reg_o = reg1_i + 1;							//0100
		`OP_DEC: reg_o = reg1_i - 1;							//0101
		`OP_BNE: branch_o = (reg1_i == reg2_i) ? 0 : 1;	//0110
		`OP_BEQ: branch_o = (reg1_i == reg2_i) ? 1 : 0;	//0111
		`OP_BLT: branch_o = (reg1_i < reg2_i) ? 1 : 0;	//1000
	endcase
end
endmodule
