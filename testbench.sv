module testbench();

reg	clk;
reg	start;
reg	branchFetch;
reg	[15:0] branchloc;
reg	[15:0] start_address;
wire	currentPC;

wire	[2:0] SYNTHESIZED_WIRE_0;
wire	[2:0] SYNTHESIZED_WIRE_1;
wire	[2:0] SYNTHESIZED_WIRE_2;
wire	[3:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[1:0] SYNTHESIZED_WIRE_7;
wire	[3:0] SYNTHESIZED_WIRE_8;
wire	[15:0] SYNTHESIZED_WIRE_9;

/**
//Inputs for regfile
reg [2:0] sourceReg1;
reg [2:0] sourceReg2;
reg [2:0] destReg;
reg writeFlag;
reg [7:0] dataIn;
reg clk;
//Outputs for regfile
wire [7:0] data1;
wire [7:0] data2;

//Inputs for ALU
reg [3:0] aluOp;
reg [7:0] aluRegIn1;
reg [7:0] aluRegIn2;
reg clkFetch;
//Outputs for ALU
wire [7:0] aluOut;
wire aluBranchOut;

//Inputs for fetch
reg start;
reg [7:0] start_address;
reg branchFetch;
reg [7:0] branchloc;
//Outputs for fetch
wire [7:0] nextPC;
**/

initial begin
	// Regfile Waveform
	clk = 1;
	branchFetch = 0;
	#10	start_address 	= 16'b0000000000000101;
	#10	start		= 1;
	#10 	start		= 0;
	#30	start		= 1;
	#30	start 	= 0;
	#10	branchloc = 10;
			branchFetch = 1;
	#10	branchFetch = 0;
	#10	start = 1;
	#10	start		= 0;
			start_address	= 8'b00000001;
	#10	start		= 1;
	#10	start 	= 0;
	
end

always begin
	#5 clk = ~clk;
end

regfile	b2v_inst(
	
	.clk(clk),
	
	.destReg_i(SYNTHESIZED_WIRE_0),
	.sourceReg1_i(SYNTHESIZED_WIRE_1),
	.sourceReg2_i(SYNTHESIZED_WIRE_2),
	.data1_o(SYNTHESIZED_WIRE_4),
	.data2_o(SYNTHESIZED_WIRE_5));


alu	b2v_inst1(
	.inst_i(SYNTHESIZED_WIRE_3),
	.reg1_i(SYNTHESIZED_WIRE_4),
	.reg2_i(SYNTHESIZED_WIRE_5)
	
	);


control	b2v_inst2(
	.imm_flag(SYNTHESIZED_WIRE_6),
	.format(SYNTHESIZED_WIRE_7),
	.opcode(SYNTHESIZED_WIRE_8),
	.alu_inst(SYNTHESIZED_WIRE_3));


instr_rom	b2v_inst3(
	.pc(SYNTHESIZED_WIRE_9),
	.imm_flag(SYNTHESIZED_WIRE_6),
	.format(SYNTHESIZED_WIRE_7),
	
	.opcode(SYNTHESIZED_WIRE_8),
	.reg1_i(SYNTHESIZED_WIRE_1),
	.reg2_i(SYNTHESIZED_WIRE_2),
	.reg_o(SYNTHESIZED_WIRE_0));


fetch	b2v_inst4(
	.clk(clk),
	.start_i(start),
	.branch_i(branchFetch),
	.branchloc_i(branchloc),
	.start_address_i(start_address),
	.pc(SYNTHESIZED_WIRE_9));


endmodule