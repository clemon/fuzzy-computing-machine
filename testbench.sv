module testbench();

reg	clk;
reg	start;
reg	[15:0] branchloc;
reg	[15:0] start_address;

wire	[3:0] aluOpCode;
wire	[7:0] aluOutput;
wire	branchTaken;
wire	[7:0] dataMemResult;
wire	[2:0] Immediate;
wire	ImmediateFlag;
wire	[1:0] InstrFormat;
wire	[3:0] InstrOpcode;
wire	[15:0] PC;
wire	readMemFlag;
wire	[7:0] reg1Data;
wire	[2:0] reg1In;
wire	[7:0] reg2Data;
wire	[2:0] reg2In;
wire	[7:0] regDestData;
wire	[2:0] regDest;
wire	[7:0] regFileDataIn;
wire	writeMemFlag;
wire	writeRegFlag;

wire [7:0] r0c;
wire [7:0] r1c;
wire [7:0] r2c;
wire [7:0] r3c;
wire [7:0] r4c;
wire [7:0] r5c;
wire [7:0] r6c;
wire [7:0] r7c;

wire [15:0] jmpLoc;
wire [7:0] memAddressReadWrite;

initial begin
	// Regfile Waveform
	clk = 1;
	#5	start_address 	= 16'b0000000000000000;
		start = 1;
	#15 	start		= 0;
	
end

always begin
	#5 clk = ~clk;
end

regfile	b2v_inst(
	.writeFlag_i(writeRegFlag),
	.clk(clk),
	.data_i(regFileDataIn),
	.destReg_i(regDest),
	.sourceReg1_i(reg1In),
	.sourceReg2_i(reg2In),
	.data1_o(reg1Data),
	.data2_o(reg2Data),
	.dataD_o(regDestData),
	.r0(r0c),
	.r1(r1c),
	.r2(r2c),
	.r3(r3c),
	.r4(r4c),
	.r5(r5c),
	.r6(r6c),
	.r7(r7c));


alu	b2v_inst1(
	.inst_i(aluOpCode),
	.reg1_i(reg1Data),
	.reg2_i(reg2Data),
	.branch_o(branchTaken),
	.reg_o(aluOutput));


mux_reg	b2v_inst2(
	.alu_i(aluOutput),
	.mem_i(dataMemResult),
	.opcode(InstrOpcode),
	.reg_i(reg1Data),
	.rom_i(Immediate),
	.muxout(regFileDataIn));


instr_rom	b2v_inst3(
	.pc(PC),
	.imm_flag(ImmediateFlag),
	.format(InstrFormat),
	.imm(Immediate),
	.opcode(InstrOpcode),
	.reg1_i(reg1In),
	.reg2_i(reg2In),
	.reg_o(regDest),
	.jmpLoc(jmpLoc));


fetch	b2v_inst4(
	.clk(clk),
	.start_i(start),
	.branch_i(branchTaken),
	.branchloc_i(jmpLoc),
	.start_address_i(start_address),
	.pc(PC));


datamem	b2v_inst5(
	.writemem(writeMemFlag),
	.readmem(readMemFlag),
	.clk(clk),
	.addr(reg1Data),
	.data(reg1Data),
	.q(dataMemResult));
	defparam	b2v_inst5.ADDR_WIDTH = 8;


control	b2v_inst7(
	.imm_flag(ImmediateFlag),
	.format(InstrFormat),
	.opcode(InstrOpcode),
	.write_mem(writeMemFlag),
	.write_reg(writeRegFlag),
	.read_mem(readMemFlag),
	.alu_inst(aluOpCode));
	
mux		b2v_inst11(
	.input1(regDestData),
	.input2(reg1Data),
	.sel(readMemFlag),
	
	.muxout(memAddressReadWrite));

	



endmodule