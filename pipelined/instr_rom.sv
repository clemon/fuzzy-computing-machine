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
		 0: instr = 8'b01001010; //lim 5, 0
			1: instr = 8'b01000101; //lim 2, 1
			2: instr = 8'b10010100; //sft $i2, 0
			/*
			3: instr = 8'b01101000; //mvf $i2, $o0		//$o0 = 20
			4: instr = 8'b01001000; //lim 4, 0
			5: instr = 8'b01001011; //lim 5, 1
			6: instr = 8'b10010100; //sft $i2, 0 
			7: instr = 8'b01101001; //mvf $i2, $o1		//$o1 = 128
			8: instr = 8'b11011001; //LOOP: inc $o0, 1 //$o0 = 19
			9: instr = 8'b01010100; //mvb $i1, $o0		//$i1 holds sort-check var
			10:instr = 8'b01000000; //lim 0, 0
			11:instr = 8'b01101010; //mvf $i2, $o2
			12:instr = 8'b01010010; //mvb $i0, $o2		//$i0 = 0, used for bubble index
			13:instr = 8'b01001110; //lim 7, 0    		//BRANCH ADDRESS, BREAKLOOP
			14:instr = 8'b11010100; //inc $i2, 0
			15:instr = 8'b11010100; //inc $i2, 0
			16:instr = 8'b01101010; //mvf $i2, $o2		//move branch address into $o2
			17:instr = 8'b10110010; //beq $i0, $o2		//if sort loop has run 19 times, terminate
			18:instr = 8'b01010100; //BUBBLELOOP: mvb $i1, $o0		//$i1 = sortcheck index
			19:instr = 8'b01001100; //lim 6, 0			//BRANCH ADDRESS, LOOP
			20:instr = 8'b01101010; //mvf $i2, $o2
			21:instr = 8'b10110010; //beq $i0, $o2 (LOOP)		//If done with current bubble run, start next iteration
			22:instr = 8'b01010101; //mvb $i1, $o1		//Set up to load mem loc of first index of bubble
			23:instr = 8'b01110010; //add $i0, $o2		//$o2 = address of beginning of bubble
			24:instr = 8'b01010110; //mvb $i1, $o2
			25:instr = 8'b00000111; //lb  $i1, $o3
			26:instr = 8'b01010111; //mvb $i1, $o3		//$i1 = array[index beginning of bubble]
			27:instr = 8'b01000011; //lim 1, 1
			28:instr = 8'b01011010; //mvb $i2, $o2		//Get address of previous index
			29:instr = 8'b01111011; //add $i2, $o3		//$o3 = address of end of bubble
			30:instr = 8'b01011111; //mvb $i3, $o3
			31:instr = 8'b00001111; //lb  $i3, $o3
			32:instr = 8'b01011011; //mvb $i2, $o3		//$i2 = array[index end of bubble]
			33:instr = 8'b01001111; //lim 7, 1			//ADDRESS LABEL FOR NEXT
			34:instr = 8'b01101111; //mvf $i3, $o3
			35:instr = 8'b11110111; //bls $i1, $o3 (NEXT)	
			36:instr = 8'b00111010; //str $i2, $o2
			37:instr = 8'b11011100; //inc $o2, 0
			38:instr = 8'b00110110; //str $i1, $o2
			39:instr = 8'b11010000; //NEXT: inc $i0, 0
			40:instr = 8'b01000000; //lim 0, 0
			41:instr = 8'b01001111; //lim 7, 1
			42:instr = 8'b01101111; //mvf $i3, $o3
			43:instr = 8'b11011110; //inc $o3, 0
			44:instr = 8'b01000001; //lim 0, 1
			45:instr = 8'b10111011; //beq $i1, $o3 (BUBBLELOOP)
			
			46:instr = 8'b01001010; //lim 5, $i2 //BREAKLOOP
			47:instr = 8'b01000101; //lim 2, $i3
			48:instr = 8'b10010100; //sft $i2, 0
			49:instr = 8'b11010101; //inc $i2, 1 (decrement to get 19)
			50:instr = 8'b01101000; //mvf $i2, $o0
			51:instr = 8'b01010001; //mvb $i0, $o1
			52:instr = 8'b01010101; //mvb $i1, $o1
			53:instr = 8'b11010000; //inc $i0, 0
											//$i0 = mem address array[index + 1]
											//$i1 = mem address array[index]
			54:instr = 8'b00000001; //lb  $i0, $o1
			55:instr = 8'b00000110; //lb  $i1, $o2
			56:instr = 8'b01011001; //mvb $i2, $01
			57:instr = 8'b01011110; //mvb $i3, $o2
			58:instr = 8'b10001011; //sub $i2, $o3
			59:instr = 8'b11011001; //inc $o0, 1 (dec)
			
			
			60:instr = 8'b01001010; //lim 5, $i2 //PAIRLOOP
			61:instr = 8'b01000011; //lim 1, $i3
			62:instr = 8'b10010100; //sft $i2, 0
			63:instr = 8'b01101001; //mvf $i2, $o1
			64:instr = 8'b01000000; //lim 0, $i2
			65:instr = 8'b01011100; //mvb $i3, $o0
			66:instr = 8'b10111001; //beq $i2, $o1 (has address for ENDPAIRCHECK)
			67:instr = 8'b11010000; //inc $i0, 0
			68:instr = 8'b11010010; //inc $i1, 0
			69:instr = 8'b11011010; //inc $o1, 0 (now $o1 has address for PAIRLOOP)
			70:instr = 8'b00000010; //lb  $i0, $o2
			71:instr = 8'b01011010; //mvb $i2, $o2
			72:instr = 8'b00000110; //lb  $i1, $o2
			73:instr = 8'b01011110; //mvb $i3, $o2
			74:instr = 8'b10001010; //sub $i2, $o2
			75:instr = 8'b01011011; //mvb $i2, $o3
			76:instr = 8'b01011110; //mvb $i3, $o2
			77:instr = 8'b11011001; //inc $o0, 1 (dec)
			78:instr = 8'b11001001; //blt $i2, $o1 (PAIRLOOP)
			79:instr = 8'b01101111; //mvf $i3, $o3
			80:instr = 8'b01000000; //lim 0, 0
			81:instr = 8'b01000001; //lim 0, 1
			82:instr = 8'b10111001; //beq $i2, $o1	
			
			//WE HAVE ANSWERS
			
			83:instr = 8'b01001110; //lim 7, $i2
			84:instr = 8'b11010100; //inc $i2, 0
			85:instr = 8'b01001001; //lim 4, $i3
			86:instr = 8'b10010100; //sft $i2, 0
			87:instr = 8'b11010101; //inc $i2, 1 (dec)
			88:instr = 8'b01101001; //mvf $i2, $o1
			89:instr = 8'b01011111; //mvb $i3, $o3
			90:instr = 8'b00111101; //str $i3, $o1
			
			*/
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
		/*
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

			82: instr= 8'b01010101;

			83: instr = 8'b01001010;
			84: instr = 8'b01101001;

			85: instr= 8'b10110001;
			86: instr= 8'b11010000;
			87: instr= 8'b01101001;

			88: instr= 8'b01001110;
			89: instr= 8'b11010100;
			90: instr= 8'b01101001;
			91: instr= 8'b00001000;
			92: instr= 8'b01011100;
			93: instr= 8'b11010110;
			94: instr= 8'b00111101;
			95: instr= 8'b01101100;

			96: instr= 8'b01000001;
			97: instr= 8'b01101101;
			98: instr= 8'b01010101;

			99: instr= 8'b01011100;
			100: instr= 8'b00001101;

			//innerloop:
			101: instr= 8'b01000100;
			102: instr= 8'b01101000;

			103: instr= 8'b01001110;
			104: instr= 8'b11010100;
			105: instr= 8'b10110100; 

			106: instr= 8'b01011101;
			107: instr= 8'b00011101;

			108: instr= 8'b01011110;

			109: instr= 8'b01001000;
			110: instr= 8'b01101001;

			111: instr= 8'b10111101;

			112: instr= 8'b01011001;
			113: instr= 8'b01000011;
			114: instr= 8'b10010100;
			115: instr= 8'b01101000;
			116: instr= 8'b01011100;

			117: instr= 8'b11010010;

			//match:
			118: instr= 8'b01000100;
			119: instr= 8'b01101001;

			120: instr= 8'b11011110;
			121: instr= 8'b01000011;
			122: instr= 8'b01101100;
			123: instr= 8'b10111101;

			//finish:
			124: instr= 8'b01010011;
			125: instr= 8'b01001111;
			126: instr= 8'b01101111;
			127: instr= 8'b00110011;
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