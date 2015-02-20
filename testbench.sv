module testbench();

reg	clk;
reg	start;
reg	branchFetch;
reg	[15:0] branchloc;
reg	[15:0] start_address;
wire	currentPC;

wire	[2:0] destinationRegister;
wire	[2:0] sourceRegister1;
wire	[2:0] sourceRegister2;
wire	[3:0] ALUOp;
wire	[7:0] sR1Data;
wire	[7:0] sR2Data;
wire	Immflag;
wire	[1:0] InstrFormat;
wire	[3:0] InstrOp;
wire	[15:0] PC;
wire	[2:0]	immediateData;

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
			start_address	= 8'b00000000;
	#10	start		= 1;
	#10	start 	= 0;
	
end

always begin
	#5 clk = ~clk;
end

regfile	b2v_inst(
	
	.clk(clk),
	
	.destReg_i(destinationRegister),
	.sourceReg1_i(sourceRegister1),
	.sourceReg2_i(sourceRegister2),
	.data1_o(sR1Data),
	.data2_o(sR2Data));


alu	b2v_inst1(
	.inst_i(ALUOp),
	.reg1_i(sR1Data),
	.reg2_i(sR2Data)
	
	);


control	b2v_inst2(
	.imm_flag(Immflag),
	.format(InstrFormat),
	.opcode(InstrOp),
	.alu_inst(ALUOp));


instr_rom	b2v_inst3(
	.pc(PC),
	.imm_flag(Immflag),
	.format(InstrFormat),
	
	.opcode(InstrOp),
	.reg1_i(sourceRegister1),
	.reg2_i(sourceRegister2),
	.reg_o(destinationRegister),
	.imm(immediateData));


fetch	b2v_inst4(
	.clk(clk),
	.start_i(start),
	.branch_i(branchFetch),
	.branchloc_i(branchloc),
	.start_address_i(start_address),
	.pc(PC));


endmodule