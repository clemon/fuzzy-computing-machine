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
		output wire  imm_flag,
		output reg [15:0] jmpLoc
	);

	reg [1:0] form;
	reg [7:0] instr;
	reg [2:0] r1i; 
	reg [2:0] r2i;  
	reg [2:0] ro;  
	
	reg [15:0] jmpLabels [3:0];
	

	initial begin	
		jmpLabels[0] = 8'd10;
	end
	
	always_comb begin

		// Defaults
		form  = 2'bxx;
		instr = 8'bxxxxxxxx;
		r1i   = 3'bxxx;
		r2i   = 3'bxxx;
		ro    = 3'bxxx;
		jmpLoc = 8'dx;

		case (pc)
			// Product
			0: instr = 8'b01000000;
			1: instr = 8'b01101001;
			2: instr = 8'b01000010;
			3: instr = 8'b00001000;
			4: instr = 8'b01010100;
			5: instr = 8'b01000100;
			6: instr = 8'b00001000;
			7: instr = 8'b01000000;
			8: instr = 8'b11011001;
			9: instr = 8'b01110110;
			10: instr = 8'b01011010;
			11: instr = 8'b11011001;
			12: instr = 8'b01000001;
			13: instr = 8'b10101101;
			14: instr = 8'b11011010;
			15: instr = 8'b01000111;
			16: instr = 8'b00001100;
			17: instr = 8'b01010100;
			18: instr = 8'b11011001;
			19: instr = 8'b01110110;
			20: instr = 8'b01011010;
			21: instr = 8'b11011001;
			22: instr = 8'b01000001;
			23: instr = 8'b10101101;
			24: instr = 8'b01001011;
			25: instr = 8'b01101101;
			26: instr = 8'b00111001;
			27: instr = 8'b01001001;
			28: instr = 8'b01101101;
			29: instr = 8'b01010011;
			30: instr = 8'b00110001;
			/*
			50: instr = 8'b01001000;
			51: instr = 8'b00001000;
			52: instr = 8'b01011000;
			53: instr = 8'b01001001;
			54: instr = 8'b10010100;
			55: instr = 8'b01101010;

			56: instr = 8'b01001110;
			57: instr = 8'b01001111;
			58: instr = 8'b11010100;
			59: instr = 8'b11010110;
			60: instr = 8'b01111011;
			61: instr = 8'b01011011;
			62: instr = 8'b01111011;
			63: instr = 8'b01011011;
			64: instr = 8'b01111011;
			65: instr = 8'b01011011;
			66: instr = 8'b11010101;
			67: instr = 8'b01101001;

			68: instr = 8'b01001111;
			69: instr = 8'b11010110;
			70: instr = 8'b01101100;
			71: instr = 8'b00110100;

			72: instr = 8'b01000001;
			73: instr = 8'b01101111;
			74: instr = 8'b01010011;
			75: instr = 8'b01010111;

			//loop:
			76: instr = 8'b01001110;
			77: instr = 8'b11010100;
			78: instr = 8'b01000111;
			79: instr = 8'b10010100;
			80: instr = 8'b01000011;
			81: instr = 8'b01111001;

			82: inst = 8'b01010101;

			83: instr = 8'b01001010;
			84: instr = 8'b01101001;

			85: inst = 8'b10110001;
			86: inst = 8'b11010000;
			87: inst = 8'b01101001;

			88: inst = 8'b01001110;
			89: inst = 8'b11010100;
			90: inst = 8'b01101001;
			91: inst = 8'b00001000;
			92: inst = 8'b01011100;
			93: inst = 8'b11010110;
			94: inst = 8'b00111101;
			95: inst = 8'b01101100;

			96: inst = 8'b01000001;
			97: inst = 8'b01101101;
			98: inst = 8'b01010101;

			99: inst = 8'b01011100;
			100: inst = 8'b00001101;

			//innerloop:
			101: inst = 8'b01000100;
			102: inst = 8'b01101000;

			103: inst = 8'b01001110;
			104: inst = 8'b11010100;
			105: inst = 8'b10110100; 

			106: inst = 8'b01011101;
			107: inst = 8'b00011101;

			108: inst = 8'b01011110;

			109: inst = 8'b01001000;
			110: inst = 8'b01101001;

			111: inst = 8'b10111101;

			112: inst = 8'b01011001;
			113: inst = 8'b01000011;
			114: inst = 8'b10010100;
			115: inst = 8'b01101000;
			116: inst = 8'b01011100;

			117: inst = 8'b11010010;

			//match:
			118: inst = 8'b01000100;
			119: inst = 8'b01101000;

			120: inst = 8'b11011110;
			121: inst = 8'b01000011;
			122: inst = 8'b01101100;
			123: inst = 8'b10111100;

			//finish:
			124: inst = 8'b01010011;
			125: inst = 8'b01001111;
			126: inst = 8'b01101111;
			127: inst = 8'b00110011;
			*/
	
		endcase
		
		// Switch on opcode to determine format
		case (instr[7:4])
			`LB_OP   : form = `M_FORM;
			`LHB_OP  : form = `M_FORM;
			`JMP_OP  : form = `C_FORM;
			`STR_OP  : form = `M_FORM;
			`LIM_OP  : form = `C_FORM;
			`MVB_OP  : form = `M_FORM;
			`MVF_OP  : form = `M_FORM;
			`ADD_OP  : form = `M_FORM;
			`SUB_OP  : form = `M_FORM;
			`SFT_OP  : form = `I_FORM;
			`BNE_OP  : form = `M_FORM;
			`BEQ_OP  : form = `M_FORM;
			`BLT_OP  : form = `M_FORM;
			`INC_OP  : form = `I_FORM;
			`HALT_OP : form = `X_FORM;
			`TBA_OP  : form = `X_FORM;
		endcase
		
		if (form == `C_FORM)
			jmpLoc = jmpLabels[instr[3:0]];
		else if (form == `M_FORM)
			jmpLoc = jmpLabels[{2'b11, instr[1:0]}];

		$display("\nForamt: %d", form);
		$display("OPCODE: %b", opcode);

		// Registers
		case (form)
			`C_FORM: begin 
				ro = (instr[0] == 0) ? 3'b010 : 3'b011;
			end
			`I_FORM: begin
				r1i = instr[3:1];
				r2i = r1i + 1; 	// Get seq. reg.
				ro  = r1i;

				$display("Reg1_i: %b Reg2_i: %b", reg1_i, reg2_i);
			end
			`M_FORM: begin
				if (instr[7:4] == `MVB_OP) begin
					r1i = {1'b1, instr[1:0]};
					ro = {1'b0, instr[3:2]};
				end
				else begin	
					r1i = {1'b0, instr[3:2]};
					r2i = r1i + 1;
					ro  = {1'b1, instr[1:0]};
				end

				$display("Reg1_i: %b Reg2_i: %b", reg1_i, reg2_i);
			end
			default: begin end
		endcase

		$display("Reg_o: %b", reg_o);

	end

	assign format   = form;
	assign opcode   = instr[7:4];
	assign reg1_i   = r1i;
	assign reg2_i   = r2i;
	assign reg_o    = ro;
	assign imm 	    = instr[3:1];
	assign imm_flag = instr[0];

endmodule