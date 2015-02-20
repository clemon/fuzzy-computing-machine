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
		jmpLabels[1] = 8'd20;
		jmpLabels[2] = 8'd30;
		jmpLabels[3] = 8'd3;
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
			// Program 1
			0: instr = 8'b00001100; //lb $i3, $o0
			1: instr = 8'b00011000; //lhb $i2, $o0
			2: instr = 8'b00100010; //jmp to 30
			3: instr = 8'b00110111; //str $i1, $o3 (7 in 1)
			4: instr = 8'b00000001; //lb $i0, $o1
			5: instr = 8'b01001001; //lim 4 into $i3
			6: instr = 8'b01101011; //mvf $i2 (35) into $o3 (was 1)
			7: instr = 8'b01010111; //mvb opposite of above kek
			8: instr = 8'b01110010;	//add
			9: instr = 8'b10000010;	//sub
			10: instr = 8'b10010100;
			11: instr = 8'b11010000;
			12: instr = 8'b11010001;
			13: instr = 8'b11010001;
			30: instr = 8'b00100011;//jmp back to 3

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