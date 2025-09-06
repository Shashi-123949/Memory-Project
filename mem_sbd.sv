class mem_sbd extends uvm_scoreboard;
  mem_tx tx;
  `uvm_component_utils(mem_sbd)
  
  bit[`WIDTH-1:0] mem_reg[int];
  
  uvm_analysis_imp #(mem_tx,mem_sbd) analysis_imp;
  
function void build_phase(uvm_phase phase);
    analysis_imp=new("analysis_imp",this);
endfunction

function new(string name="",uvm_component parent);
  super.new(name,parent);
endfunction

  
  function void write(mem_tx t);
      t.print();
   // this.tx=t;
    $cast(tx,t);
    
    //$display("tx=%p",tx);
    // `uvm_info("SCOREBOARD", $sformatf("Received tx: %p", tx), UVM_LOW)
    if(tx.wr_rd==1)
      mem_reg[tx.addr]=tx.wdata;// store the tb wdata into the 	temp registers(mem_reg)
	
        
	else begin
      //if(tx.wr_rd==0)begin
      if(tx.rdata ==mem_reg[tx.addr])
		mem_common::num_matches++;
        
		else 
		mem_common::mismatches++;
    end
endfunction 

endclass
