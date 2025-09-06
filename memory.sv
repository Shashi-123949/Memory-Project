module mem(clk,rst,addr,wr_rd,wdata,rdata,valid,ready);
	parameter WIDTH=`WIDTH;
	parameter DEPTH=`DEPTH;
	//parameter ADDR_WIDTH=$clog2(DEPTH);
	parameter ADDR_WIDTH=`ADDR_WIDTH;
	
	input clk,rst,valid,wr_rd; 
	input [ADDR_WIDTH-1:0]addr;
	input [WIDTH-1:0]wdata;
	output reg [WIDTH-1:0]rdata;
	output reg ready;

	reg [WIDTH-1:0]mem[DEPTH-1:0];
	integer i;

	always@(posedge clk) 
	  if(rst==1)begin 
		rdata=0;
		ready=0;
		for(i=0;i<DEPTH;i++) mem[i]=0;
	  end
	  else begin 
	      if(valid==1)begin
	      	 ready=1;
	        if(wr_rd==1)mem[addr]=wdata;
	        else rdata=mem[addr];
	      end
	   else ready=0;
	  end

endmodule



