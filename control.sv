`define LB_OP   4'b0000 	// Load Byte
`define LHB_OP  4'b0001 	// Load Half Byte
`define JMP_OP  4'b0010 	// Jump
`define STR_OP  4'b0011 	// Store
`define LIM_OP  4'b0100 	// Load Immediate
`define MVB_OP  4'b0101 	// Move Back
`define MVF_OP  4'b0110 	// Move Forward
`define ADD_OP  4'b0111 	// Add
`define SUB_OP  4'b1000 	// Subtract
`define SFT_OP  4'b1001 	// Shift
`define BNE_OP  4'b1010 	// Branch Not Equals
`define BEQ_OP  4'b1011 	// Branch Equals
`define BLT_OP  4'b1100 	// Branch Less Than
`define INC_OP  4'b1101 	// Inc/Dec-rement
`define HALT_OP 4'b1110 	// Halt
`define TBA_OP  4'b1111 	// TBA

`define ALUOP_ADD 4'b0000 //Addition
`define ALUOP_SUB 4'b0001 //Subtract
`define ALUOP_SFL 4'b0010 //Shift left
`define ALUOP_SFR 4'b0011 //Shift right
`define ALUOP_INC 4'b0100 //Increment
`define ALUOP_DEC 4'b0101 //Decrement
`define ALUOP_BNE 4'b0110 //Branch not equal
`define ALUOP_BEQ 4'b0111 //Branch equal
`define ALUOP_BLT 4'b1000 //Branch less than

module control(
	input [1:0]format,
	input [1:0]imm_flag,
	input [3:0]opcode,
	output wire [3:0]alu_inst
);


always_comb begin
	case(opcode)
		`ADD_OP: alu_inst[3:0] = `ALUOP_ADD;
		`SUB_OP: alu_inst[3:0] = `ALUOP_SUB;
		`SFT_OP:	begin
						if(imm_flag)
							alu_inst[3:0] = `ALUOP_SFR;
						else
							alu_inst[3:0] = `ALUOP_SFL;
					end
		`BNE_OP: alu_inst[3:0] = `ALUOP_BNE;
		`BEQ_OP: alu_inst[3:0] = `ALUOP_BEQ;
		`BLT_OP: alu_inst[3:0] = `ALUOP_BLT;
		`INC_OP: begin
						if(imm_flag)
							alu_inst[3:0] = `ALUOP_INC;
						else
							alu_inst[3:0] = `ALUOP_DEC;
					end
		default: alu_inst[3:0] = 4'bxxxx;
	   /*`LB_OP:
		`LHB_OP:
		`JMP_OP:
		`STR_OP:
		`LIM_OP:
		`MVB_OP:
		`MVF_OP:*/
		//`HALT_OP:
		//`TBA_OP:
	endcase
end
endmodule