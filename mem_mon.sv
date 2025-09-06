class mem_mon extends uvm_monitor;
mem_tx tx;
  `uvm_component_utils(mem_mon);
	virtual mem_intr vif;
  uvm_analysis_port#(mem_tx) mem_port;

	function new(string name,uvm_component parent);
		super.new(name,parent);
        mem_port=new("mem_port",this);
	endfunction

     function void build_phase(uvm_phase phase);
			`uvm_info("MON","MON_BUILD_PHASE","UVM_NONE");
     endfunction

			task run();
			vif=top.pif;
			forever begin 
				@(vif.mon_cb);
              if(vif.mon_cb.valid && vif.mon_cb.ready) begin
				tx=new();
				tx.wr_rd=vif.mon_cb.wr_rd;
				tx.wdata=vif.mon_cb.wdata;
				tx.addr=vif.mon_cb.addr;
				tx.rdata=vif.mon_cb.rdata;
				tx.print();
				mem_port.write(tx);
                 end
				end
			endtask

endclass




