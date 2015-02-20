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

module mux_reg(
	input  [7:0] alu_i,
	input  [7:0] mem_i,
	input  [7:0] rom_i,
	input  [7:0] reg_i,
	input  [3:0] opcode,
	output reg [7:0] muxout
);

always_comb begin

	case(opcode)
		`ADD_OP : muxout = alu_i;
		`SUB_OP : muxout = alu_i;
		`SFT_OP : muxout = alu_i;
		`INC_OP : muxout = alu_i;
		`LB_OP  : muxout = mem_i;
		`LHB_OP : muxout = mem_i;
		`MVB_OP : muxout = reg_i;
		`MVF_OP : muxout = reg_i;
		`LIM_OP : muxout = rom_i;
		default: muxout = 8'bxxxxxxxx;
	endcase
		
end
endmodule