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
`define BLS_OP  4'b1111 	// Branch less than signed

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
			
			
			/*
			0:  instr = 8'b01000000;
			1:  instr = 8'b01101001;
			2:  instr = 8'b01000010;
			3:  instr = 8'b00001000;
			4:  instr = 8'b01010100;
			5:  instr = 8'b01000100;
			6:  instr = 8'b00001000;
			7:  instr = 8'b01000000;
			8:  instr = 8'b11011001;
			9:  instr = 8'b01000001;
			10: instr = 8'b11010110;
			11: instr = 8'b01011010;
			12: instr = 8'b11011001;
			13: instr = 8'b10101101;
			14: instr = 8'b11011010;
			15: instr = 8'b01000111;
			16: instr = 8'b00001100;
			17: instr = 8'b01010100;
			18: instr = 8'b01101000;
			19: instr = 8'b01000000;
			20: instr = 8'b01000001;
			21: instr = 8'b11011001;
			22: instr = 8'b11010110;
			23: instr = 8'b01011010;
			24: instr = 8'b11011001;
			25: instr = 8'b10101101;
			26: instr = 8'b01001011;
			27: instr = 8'b01101101;
			28: instr = 8'b00111001;
			29: instr = 8'b01001001;
			30: instr = 8'b01101101;
			31: instr = 8'b01010011;
			32: instr = 8'b00110001;
			*/
			/*
			0: instr = 8'b01001110; //lim 7, $i2
			1: instr = 8'b01000101; //lim 2, $i3
			2: instr = 8'b01101100; //mvf $i3,$o0 $o0 = 2
			3: instr = 8'b00111000; //str $i2,$o0 addr[2] = 7
			4: instr = 8'b01010000; //mvb $i0, $o0
			5: instr = 8'b00000011; //lb  $i0, $o3 
			*/
			
			/*
			1:instr = 8'b01001100; //lim 6, $i2
			2:instr = 8'b11010100; //inc $i2, 0
			*/
			
			/* Testing BLS
			25:instr = 8'b01001000; //lim 4, 0
			26:instr = 8'b01001011; //lim 5, 1
			27:instr = 8'b10010100; //sft $i2, 0
			28:instr = 8'b01000001; //lim 0, 1
			29:instr = 8'b11111001; //bls $i2, $o1
			*/
		
			50: instr = 8'b01001100;
52: instr = 8'b00001000;
55: instr = 8'b01011000;
56: instr = 8'b01001001;
58: instr = 8'b10010100;
60: instr = 8'b01101010;

62: instr = 8'b01001110;
64: instr = 8'b01001111;
66: instr = 8'b11010100;
68: instr = 8'b11010110;
70: instr = 8'b01111011;
72: instr = 8'b01011011;
74: instr = 8'b01111011;
76: instr = 8'b01011011;
78: instr = 8'b01111011;
80: instr = 8'b01011011;
82: instr = 8'b11010101;
84: instr = 8'b01101001;

86: instr = 8'b01001111;
88: instr = 8'b11010110;
90: instr = 8'b01101100;
92: instr = 8'b00111000;

94: instr = 8'b01000001;
96: instr = 8'b01101111;
98: instr = 8'b01010011;
100: instr = 8'b01010111;

//loop:
102: instr = 8'b01001110;
104: instr = 8'b11010100;
106: instr = 8'b01000111;
108: instr = 8'b10010100;
110: instr = 8'b01000011;
112: instr = 8'b01111001;

114: instr = 8'b01010101;

116: instr = 8'b01001010;
118: instr = 8'b01101001;

120: instr = 8'b10110001;
122: instr = 8'b11010000;
124: instr = 8'b01100101;

126: instr = 8'b01001110;
128: instr = 8'b11010100;
130: instr = 8'b01101001;
132: instr = 8'b00001000;
134: instr = 8'b01011100;
136: instr = 8'b11010110;
138: instr = 8'b00111101;
140: instr = 8'b01101100;

142: instr = 8'b01000001;
144: instr = 8'b01101101;
146: instr = 8'b01010101;

148: instr = 8'b01011100;
150: instr = 8'b00001101;

//innerloop:
152: instr = 8'b01000100;
154: instr = 8'b01101000;

156: instr = 8'b01001110;
158: instr = 8'b11010100;
160: instr = 8'b10110100; 

162: instr = 8'b01011101;
164: instr = 8'b00011100;

166: instr = 8'b01011110;
168: instr = 8'b01011001;
170: instr = 8'b01101010;

172: instr = 8'b01001000;
174: instr = 8'b01101001;

176: instr = 8'b10111101;

178: instr = 8'b01011010;
180: instr = 8'b01101110;
182: instr = 8'b01000011;
184: instr = 8'b10010100;
186: instr = 8'b01101001;

188: instr = 8'b11010010;

190: instr = 8'b01000111;
192: instr = 8'b01101100;
194: instr = 8'b10111100;

//match:
196: instr = 8'b01000100;
198: instr = 8'b01101001;

200: instr = 8'b01011010;
202: instr = 8'b01101110;

204: instr = 8'b11011110;
206: instr = 8'b01000011;
208: instr = 8'b01101100;
210: instr = 8'b10111101;

//finish:
212: instr = 8'b01010011;
214: instr = 8'b01001111;
216: instr = 8'b01101111;
218: instr = 8'b00110011;
			
	
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
			`BLS_OP  : form = `M_FORM;
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