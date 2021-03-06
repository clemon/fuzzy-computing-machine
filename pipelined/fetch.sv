module fetch (
	input clk,    // Clock
	input start_i,
	input [15:0] start_address_i,
	input branch_i,	// whether or not to branch
	input [15:0] branchloc_i,//Where to branch
	output reg [15:0] pc
);

reg [7:0] next;
reg started;

always_comb
begin
	next = pc + 1;
	if (start_i == 1)
		next = start_address_i;
	else if (branch_i == 1)
		next = branchloc_i;
end

always_ff @ (posedge clk)
begin
	pc <= next;
end
	
endmodule
