module testbench();

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

initial begin
	// Regfile Waveform
	clk = 1;
	clkFetch = 0;
	writeFlag = 0;
	destReg = 3'b000;
	dataIn = 8'b00001000;
	
	#10 	sourceReg1 	= 3'b000;
			sourceReg2 	= 3'b001;
	#20 	sourceReg1 	= 3'b010;
			sourceReg2 	= 3'b011;
	#20	sourceReg1 	= 3'b100;
			sourceReg2 	= 3'b101;
	#20	sourceReg1 	= 3'b110;
			sourceReg2 	= 3'b111;
	#10	writeFlag 	= 0;
			dataIn 		= 8'b11110000;
	#10	destReg		= 3'b111;
	#10 	writeFlag 	= 1;
	#10	writeFlag	= 0;
	#10	destReg		= 3'b000;
			dataIn 		= 8'b00001111;
	#10	writeFlag	= 1;
	#10	writeFlag	= 0;
			sourceReg1	= 3'b000;
			
			
	#20 // ALU waveform
	aluOp = 4'b0000;	// OP_ADD
	
	#10	aluRegIn1 = 8'b00000000;	// 0+1
			aluRegIn2 = 8'b00000001;
	
	#10	aluRegIn1 = 8'b00001100;	// 12+21
			aluRegIn2 = 8'b00010101;
	
	#10	aluOp = 4'b0001;	// OP_SUB
	
	#10	aluRegIn1 = 8'b11100000;	// 224-1
			aluRegIn2 = 8'b00000001;
			
	#10	aluRegIn1 = 8'b00001100;	// 12-6
			aluRegIn2 = 8'b00000110;
			
	#10 	aluOp = 4'b0010;	// OP_SFL
	
	#10	aluRegIn1 = 8'b00000011;	// 3<<1
			aluRegIn2 = 8'b00000001;
			
	#10	aluRegIn1 = 8'b00000011;	// 3<<4
			aluRegIn2 = 8'b00000100;
			
	#10 	aluOp = 4'b0011;	// OP_SFR
	
	#10	aluRegIn1 = 8'b11000000;	// 192>>1
			aluRegIn2 = 8'b00000001;
			
	#10	aluRegIn1 = 8'b11000000;	// 192>>4
			aluRegIn2 = 8'b00000100;
		
	#10 	aluOp = 4'b0100;	// OP_INC
	
	#10	aluRegIn1 = 8'b00000001;	// 1++
			aluRegIn2 = 8'b00000000;
			
	#10	aluRegIn1 = 8'b11000000;	// 192++
			aluRegIn2 = 8'b00000000;
			
	#10 	aluOp = 4'b0101;	// OP_DEC
	
	#10	aluRegIn1 = 8'b00000001;	// 1--
			aluRegIn2 = 8'b00000000;
			
	#10	aluRegIn1 = 8'b11000000;	// 192--
			aluRegIn2 = 8'b00000000;
			
	#10 	aluOp = 4'b0110;	// OP_BNE
	
	#10	aluRegIn1 = 8'b00000001;	// bne 1!=1
			aluRegIn2 = 8'b00000001;
			
	#10	aluRegIn1 = 8'b00000001;	// bne 1!=0
			aluRegIn2 = 8'b00000000;
			
	#10 	aluOp = 4'b0111;	// OP_BEQ
	
	#10	aluRegIn1 = 8'b00000001;	// bne 1==1
			aluRegIn2 = 8'b00000001;
			
	#10	aluRegIn1 = 8'b00000001;	// bne 1==0
			aluRegIn2 = 8'b00000000;
			
	#10 	aluOp = 4'b1000;	// OP_BLT
	
	#10	aluRegIn1 = 8'b00000001;	// bne 1<3
			aluRegIn2 = 8'b00000011;
			
	#10	aluRegIn1 = 8'b00000001;	// bne 1<0
			aluRegIn2 = 8'b00000000;
			
	//Fetch testing
	
	branchFetch = 0;
	#50;
	#10	start_address 	= 8'b00000001;
	#10	start		= 1;
	#10 	start		= 0;
	#30	start		= 1;
	#30	start 	= 0;
	#10	branchloc = 10;
			branchFetch = 1;
	#10	branchFetch = 0;
	#10	start = 1;
	#10	start		= 0;
	
end

always begin
	#5 clk = ~clk;
	#5 clkFetch = ~clkFetch;
end

regfile	b2v_inst(
	.sourceReg1_i(sourceReg1),
	.sourceReg2_i(sourceReg2),
	.destReg_i(destReg),
	.writeFlag_i(writeFlag),
	.data_i(dataIn),
	.clk(clk),
	.data1_o(data1),
	.data2_o(data2));
	
alu	b2v_inst1(
	.inst_i(aluOp),
	.reg1_i(aluRegIn1),
	.reg2_i(aluRegIn2),
	.reg_o(aluOut),
	.branch_o(aluBranchOut)
);

fetch	b2v_inst2(
	.clk(clkFetch),    // Clock
	.start_i(start),
	.start_address_i(start_address),
	.branch_i(branchFetch),	// whether or not to branch
	.branchloc_i(branchloc),
	.next(nextPC)
);
	
endmodule