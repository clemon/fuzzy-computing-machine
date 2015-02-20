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
	input imm_flag,
	input [3:0]opcode,
	output reg [3:0]alu_inst,
	output reg write_mem,
	output reg write_reg,
	output reg read_mem
);

reg DEBUG = 1;

always_comb begin
	write_mem = 0;
	write_reg = 0;
	read_mem = 0;
	alu_inst[3:0] = 4'bxxxx;

	case(opcode)
		`ADD_OP: begin
				if (DEBUG) $display("control | ADD");
				alu_inst[3:0] = `ALUOP_ADD; 
			end
		`SUB_OP: begin
				if (DEBUG) $display("control | SUB");
				alu_inst[3:0] = `ALUOP_SUB; 
			end
		`SFT_OP: begin
				if(imm_flag) begin
					if (DEBUG) $display("control | SHIFT RIGHT");
					alu_inst[3:0] = `ALUOP_SFR;
				end
				else begin
					if (DEBUG) $display("control | SHIFT LEFT");
					alu_inst[3:0] = `ALUOP_SFL;
				end
			end
		`BNE_OP: begin
				if (DEBUG) $display("control | BRANCH NOT EQUAL TO");
				alu_inst[3:0] = `ALUOP_BNE;
			end
		`BEQ_OP: begin
				if (DEBUG) $display("control | BRANCH EQUAL TO");
				alu_inst[3:0] = `ALUOP_BEQ; 
			end
		`BLT_OP: begin
				if (DEBUG) $display("control | BRANCH LESS THAN");
				alu_inst[3:0] = `ALUOP_BLT; 
			end 
		`INC_OP: begin
				if(imm_flag) begin
					if (DEBUG) $display("control | INCREMENT");
					alu_inst[3:0] = `ALUOP_INC;
				end
				else begin
					if (DEBUG) $display("control | DECREMENT");
					alu_inst[3:0] = `ALUOP_DEC;
				end
			end
		`LB_OP: begin 
				if (DEBUG) $display("control | LOAD BYTE");
				write_reg = 1;
				read_mem = 1;
			end
		`LHB_OP: begin
				if (DEBUG) $display("control | LOAD HALF BYTE");
				write_reg = 1;
				read_mem = 1;
			end
		`MVB_OP: begin
				if (DEBUG) $display("control | MOVE BACK");
				write_reg = 1;
			end 
		`MVF_OP: begin
				if (DEBUG) $display("control | MOVE FORWARD");
				write_reg = 1;
			end
		`JMP_OP: begin
				if (DEBUG) $display("control | JUMP");
			end
		`STR_OP: begin
				if (DEBUG) $display("control | STORE");
				write_mem = 1;
			end
		`LIM_OP: begin
				if (DEBUG) $display("control | LOAD IMMEDIATE");
				write_reg = 1;
			end
		`TBA_OP: begin
				if (DEBUG) $display("control | TBA");
			end
		`HALT_OP: begin
				if (DEBUG) $display("control | HALT");
			end
	endcase
end
endmodule