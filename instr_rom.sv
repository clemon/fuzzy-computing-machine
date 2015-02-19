`define C_FORM 2'b00
`define I_FORM 2'b01
`define M_FORM 2'b10
`define X_FORM 2'b11

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

// How 2 computer

module instr_rom
	(
		input [15:0] pc,
		output wire [1:0] format,
		output wire [3:0] opcode,
		output wire [2:0] reg1_i, reg2_i, reg_o,
		output wire [2:0] imm,
		output wire imm_flag,
	);

	reg [1:0] form;
	reg [7:0] instr;
	reg [2:0] r1i, r2i, ro;

	always_comb begin
		// Switch on opcode to determine format
		case (instr[7:4])
			LB_OP   : form = M_FORM;
			LHB_OP  : form = M_FORM;
			JMP_OP  : form = C_FORM;
			STR_OP  : form = M_FORM;
			LIM_OP  : form = C_FORM;
			MVB_OP  : form = M_FORM;
			MVF_OP  : form = M_FORM;
			ADD_OP  : form = M_FORM;
			SUB_OP  : form = M_FORM;
			SFT_OP  : form = I_FORM;
			BNE_OP  : form = M_FORM;
			BEQ_OP  : form = M_FORM;
			BLT_OP  : form = M_FORM;
			INC_OP  : form = I_FORM;
			HALT_OP : form = X_FORM;
			TBA_OP  : form = X_FORM;
		endcase

		// Instructions go here
		case (pc)
			0: instr = 8'b00000000;
			1: instr = 8'b00000000;
			2: instr = 8'b00000000;
		endcase

		// Registers
		case (form)
			C_FORM: ro = (instr[0] == 0) ? 3'b010 : 3'b011;
			I_FORM: begin
				r1i = instr[3:1];
				r2i = r1i + 8; 	// Get seq. reg.
				ro  = r1i;
			end
			M_FORM: begin
				r1i = {1'b0, instr[3:2]};
				r2i = r1i + 8;
				ro  = {1'b1, instr[1:0]};
			end
			default: begin end
		endcase
	end

	assign format   = form;
	assign opcode   = instr[7:4];
	assign reg1_i   = r1i;
	assign reg2_i   = r2i;
	assign reg_o    = ro;
	assign imm 	    = instr[3:1];
	assign imm_flag = instr[0];

endmodule