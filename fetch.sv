module fetch (
	input clk,    // Clock
	input start_i,
	input [7:0] start_address_i,
	input branch_i,	// whether or not to branch
	input [7:0] branchloc_i,//Where to branch
	output reg [7:0] next
);

reg [7:0] pc;
reg started;

always_comb
begin
	if(start_i == 1)
		pc = start_address_i;	
	else begin
		if(branch_i == 1)
			pc = pc + branchloc_i;
		else
			pc = pc + 1;
	end
end

always_ff @ (posedge clk)
begin
	next <= pc;
end
	
endmodule
