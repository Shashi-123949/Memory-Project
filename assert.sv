module m_assert(clk,rst,addr,rdata,wdata,valid,ready,wr_rd);
input clk,rst,wr_rd,valid,ready;
  input [`ADDR_WIDTH-1:0]addr;
  input [`WIDTH-1:0]wdata,rdata;

//valid ready

		property valid_ready;
		@(posedge clk) (valid==1) |=> (ready==1);
		endproperty

		VALID_READY:assert property (valid_ready);
		//reset applying
		property reset;
			@(posedge clk) (rst==1) |-> (valid==0 && ready==0 && wr_rd==0 && wdata==0 && rdata==0 && addr==0);
			endproperty

			RESET: assert property(reset);
			//realising the reset
			property realise;
				@(posedge clk) (rst==0)  |-> (!$isunknown(valid) && !$isunknown(ready) && !$isunknown(addr) && !$isunknown(wdata) && !$isunknown(rdata) && !$isunknown(wr_rd));
				endproperty

				REALISE:assert property(realise);

			endmodule
