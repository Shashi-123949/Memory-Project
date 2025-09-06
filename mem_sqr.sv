//typedef uvm_sequencer#(sample_tx)sample_seqr;

class mem_seqr extends uvm_sequencer#(mem_tx);
  `uvm_component_utils(mem_seqr);
	
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
      `uvm_info("SEQ","SEQ BUILD PHASE",UVM_NONE);//verbosity
	endfunction
	
//	task body();
//	//generate one write tx
//	`uvm_do_with(req.{req.wr_rd==1'b1;})
//	
//	//generate one read tx
//	`uvm_do_with(req.{req.wr_rd==1'b0;})
//	endtask
	
endclass





