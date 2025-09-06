class mem_agent extends uvm_agent;
  mem_seqr seqr;
  mem_drv driver;
  mem_mon monitor;
  mem_cov cov;
  
  `uvm_component_utils(mem_agent);
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
   
  function void build();
    `uvm_info("ID","ABP_AGENT","UVM_NONE")
    seqr=new("seqr",this);
    driver=new("driver",this);
    monitor=new("monitor",this);
    cov=new("cov",this);
    //env=apb::type_id::create("env",this);
  endfunction
  
  
  function void connect();
    `uvm_info("AGT","MEM_AGENT_connect","UVM_NONE")
    //super.connect_phase(phase);
    driver.seq_item_port.connect(seqr.seq_item_export);
    monitor.mem_port.connect(cov.analysis_export);
  endfunction
  
  
endclass





//sample_drv::type_id=> factory defination of sample_drv
//sample_seqr::type_id=> factory defination of sample_seqr
//sample_mon::type_id=> factory defination of sample_mon

//square => port
//circle => export or implement

//seq_item_port and seq_item_export connection is applicable for only one to one connection. Not applicable for one to many connections.

//For a sequencer uvm_sequencer has evrything 




