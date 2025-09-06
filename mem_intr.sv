interface mem_intr(input clk,rst);
	bit wr_rd;
	bit [`ADDR_WIDTH-1:0]addr;
	bit [`WIDTH-1:0]wdata;
	bit [`WIDTH-1:0]rdata;
	bit valid;
	bit ready;
	
	clocking bfm_cb @(posedge clk);
	  default input #0 output #1;
		input rdata;
		input ready;
		output valid;
		output addr;
		output wdata;
		output wr_rd;
	endclocking	

	clocking mon_cb @(posedge clk);
    	default input#1;
    	input rdata;
    	input ready;
    	input valid;
    	input addr;
    	input wdata;
    	input wr_rd;
	endclocking
endinterface




