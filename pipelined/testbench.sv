module testbench();

reg	clk;
reg	start;
reg 	[15:0] start_address;

wire	[15:0] PC;
wire	[7:0] r0;
wire	[7:0] r1;
wire	[7:0] r2;
wire	[7:0] r3;
wire	[7:0] r4;
wire	[7:0] r5;
wire	[7:0] r6;
wire	[7:0] r7;

wire	[2:0] reg1;
wire	[7:0] reg1Data;
wire	[2:0] reg2;
wire	[7:0] reg2Data;
wire	[2:0] regD;
wire	[7:0] regDestData;

wire	[3:0] opcode_instr;
wire	[2:0] imm;
wire	imm_flag;
wire	[3:0] aluInst;
wire	[7:0] aluOutput;
wire	branchTakenFlag;
wire	overflowFlag;
wire	[7:0] overflowOutput;
wire	[15:0] branchLocFinal;
wire	[1:0] format_instr;
wire	[15:0] jmpLoc;
wire	[7:0] memAddrReadWrite;
wire	[7:0] memResult;
wire	readMemFlag;
wire	[7:0] regFileDataIn;
wire	writeMemFlag;
wire	writeRegFlag;

wire	[1:0] IFID_format;
wire	[2:0] IFID_imm;
wire	IFID_immFlag;
wire	[15:0] IFID_jmpLoc;
wire	[3:0] IFID_opcode;
wire	[2:0] IFID_reg1;
wire	[2:0] IFID_reg2;
wire	[2:0] IFID_regD;

wire	[3:0] IDEX_aluOp;
wire	[7:0] IDEX_dataDestReg;
wire	[7:0] IDEX_dataReg1;
wire	[7:0] IDEX_dataReg2;
wire	[2:0] IDEX_imm;
wire	[3:0] IDEX_opcode;
wire	IDEX_readMemFlag;
wire	[2:0] IDEX_reg1;
wire	[2:0] IDEX_reg2;
wire	IDEX_writeMemFlag;
wire	IDEX_writeRegFlag;
wire	[15:0] IDEX_jmpLoc;
wire	[2:0] IDEX_regD;

wire	[7:0] EXMEM_aluOutput;
wire	[7:0] EXMEM_dataDestReg;
wire	[7:0] EXMEM_dataReg1;
wire	[7:0] EXMEM_dataReg2;
wire	[2:0] EXMEM_imm;
wire	[3:0] EXMEM_opcode;
wire	EXMEM_readMemFlag;
wire	[2:0] EXMEM_reg1;
wire	[2:0] EXMEM_reg2;
wire	EXMEM_writeMemFlag;
wire	EXMEM_writeRegFlag;
wire	[2:0] EXMEM_regD;

wire	[7:0] MEMWB_aluOutput;
wire	[7:0] MEMWB_dataReg1;
wire	[2:0] MEMWB_imm;
wire	[7:0] MEMWB_memResult;
wire	[3:0] MEMWB_opcode;
wire	MEMWB_writeRegFlag;
wire	[2:0] MEMWB_regD;

initial begin
	// Regfile Waveform
	clk = 0;
	#5	start_address 	= 16'b0000000000000000;
		start = 1;
	#15 	start		= 0;
	
end

always begin
	#5 clk = ~clk;
end

fetch	b2v_inst(
	.clk(clk),
	.start_i(start),
	.branch_i(branchTakenFlag),
	.branchloc_i(branchLocFinal),
	.start_address_i(start_address),
	.pc(PC));


mux_0	b2v_inst11(
	.sel(EXMEM_readMemFlag),
	.input1(EXMEM_dataDestReg),
	.input2(EXMEM_dataReg1),
	.muxout(memAddrReadWrite));


datamem	b2v_inst12(
	.writemem(EXMEM_writeMemFlag),
	.readmem(EXMEM_readMemFlag),
	.clk(clk),
	.addr(memAddrReadWrite),
	.data(EXMEM_dataReg1),
	.q(memResult));
	defparam	b2v_inst12.ADDR_WIDTH = 8;


EX_MEM	b2v_inst13(
	.clk(clk),
	.write_mem_i(IDEX_writeMemFlag),
	.write_reg_i(IDEX_writeRegFlag),
	.read_mem_i(IDEX_readMemFlag),
	.aluOut_i(aluOutput),
	.data1_i(IDEX_dataReg1),
	.data2_i(IDEX_dataReg2),
	.dataD_i(IDEX_dataDestReg),
	.imm_i(IDEX_imm),
	.opcode_i(IDEX_opcode),
	.reg1_i(IDEX_reg1),
	.reg2_i(IDEX_reg2),
	.write_mem_o(EXMEM_writeMemFlag),
	.write_reg_o(EXMEM_writeRegFlag),
	.read_mem_o(EXMEM_readMemFlag),
	.aluOut_o(EXMEM_aluOutput),
	.data1_o(EXMEM_dataReg1),
	
	.dataD_o(EXMEM_dataDestReg),
	.imm_o(EXMEM_imm),
	.opcode_o(EXMEM_opcode),
	.reg1_o(EXMEM_reg1),
	.reg2_o(EXMEM_reg2),
	.regD_i(IDEX_regD),
	.regD_o(EXMEM_regD));


MEM_WB	b2v_inst14(
	.clk(clk),
	.writeReg_i(EXMEM_writeRegFlag),
	.alu_reg_i(EXMEM_aluOutput),
	.data1_i(EXMEM_dataReg1),
	.imm_i(EXMEM_imm),
	.opcode_i(EXMEM_opcode),
	.q_i(memResult),
	.reg1_i(EXMEM_reg1),
	.reg2_i(EXMEM_reg2),
	.writeReg_o(MEMWB_writeRegFlag),
	.alu_reg_o(MEMWB_aluOutput),
	.data1_o(MEMWB_dataReg1),
	.imm_o(MEMWB_imm),
	.opcode_o(MEMWB_opcode),
	.q_o(MEMWB_memResult),
	
	.regD_i(EXMEM_regD),
	.regD_o(MEMWB_regD));


mux_reg	b2v_inst15(
	.alu_i(MEMWB_aluOutput),
	.mem_i(MEMWB_memResult),
	.opcode(MEMWB_opcode),
	.reg_i(MEMWB_dataReg1),
	.rom_i(MEMWB_imm),
	.muxout(regFileDataIn));


instr_rom	b2v_inst2(
	.pc(PC),
	.imm_flag(imm_flag),
	.format(format_instr),
	.imm(imm),
	.jmpLoc(jmpLoc),
	.opcode(opcode_instr),
	.reg1_i(reg1),
	.reg2_i(reg2),
	.reg_o(regD));


IF_ID	b2v_inst3(
	.clk(clk),
	.immFlag_i(imm_flag),
	.format_i(format_instr),
	.imm_i(imm),
	.jmpLoc_i(jmpLoc),
	.opcode_i(opcode_instr),
	.reg1_i(reg1),
	.reg2_i(reg2),
	.regD_i(regD),
	.immFlag_o(IFID_immFlag),
	.format_o(IFID_format),
	.imm_o(IFID_imm),
	.jmpLoc_o(IFID_jmpLoc),
	.opcode_o(IFID_opcode),
	.reg1_o(IFID_reg1),
	.reg2_o(IFID_reg2),
	.regD_o(IFID_regD));


control	b2v_inst4(
	.imm_flag(IFID_immFlag),
	.format(IFID_format),
	.opcode(IFID_opcode),
	.write_mem(writeMemFlag),
	.write_reg(writeRegFlag),
	.read_mem(readMemFlag),
	.alu_inst(aluInst));


ID_EX	b2v_inst6(
	.clk(clk),
	.write_mem_i(writeMemFlag),
	.write_reg_i(writeRegFlag),
	.read_mem_i(readMemFlag),
	.alu_op_i(aluInst),
	.data1_i(reg1Data),
	.data2_i(reg2Data),
	.dataD_i(regDestData),
	.imm_i(IFID_imm),
	.jmpLoc_i(IFID_jmpLoc),
	.opcode_i(IFID_opcode),
	.reg1_i(IFID_reg1),
	.reg2_i(IFID_reg2),
	.write_mem_o(IDEX_writeMemFlag),
	.write_reg_o(IDEX_writeRegFlag),
	.read_mem_o(IDEX_readMemFlag),
	.alu_op_o(IDEX_aluOp),
	.data1_o(IDEX_dataReg1),
	.data2_o(IDEX_dataReg2),
	.dataD_o(IDEX_dataDestReg),
	.imm_o(IDEX_imm),
	.jmpLoc_o(IDEX_jmpLoc),
	.opcode_o(IDEX_opcode),
	.reg1_o(IDEX_reg1),
	.reg2_o(IDEX_reg2),
	.regD_i(IFID_regD),
	.regD_o(IDEX_regD));


alu	b2v_inst7(
	.inst_i(IDEX_aluOp),
	.reg1_i(IDEX_dataReg1),
	.reg2_i(IDEX_dataReg2),
	.branch_o(branchTakenFlag),
	.over_flag(overflowFlag),
	.over_o(overflowOutput),
	.reg_o(aluOutput));


regfile	b2v_inst8(
	.writeFlag_i(MEMWB_writeRegFlag),
	.overFlag_i(overflowFlag),
	.clk(clk),
	.data_i(regFileDataIn),
	.destReg_i(IFID_regD),
	.over_i(overflowOutput),
	.sourceReg1_i(IFID_reg1),
	.sourceReg2_i(IFID_reg2),
	.data1_o(reg1Data),
	.data2_o(reg2Data),
	.dataD_o(regDestData),
	.r0(r0),
	.r1(r1),
	.r2(r2),
	.r3(r3),
	.r4(r4),
	.r5(r5),
	.r6(r6),
	.r7(r7),
	.writeReg_i(MEMWB_regD)
	
	
	
	
	
	
	
	);


mux15	b2v_inst9(
	.input1(IDEX_jmpLoc),
	.input2(IDEX_dataDestReg),
	.sel(IDEX_opcode),
	.muxout(branchLocFinal));


endmodule