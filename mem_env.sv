class mem_env extends uvm_env;
  mem_agent agent;
  mem_sbd sbd;
  `uvm_component_utils(mem_env);
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
   
  function void build();
    `uvm_info("ID","env","UVM_NONE")
    //agent=new("agent",this);
    agent=mem_agent::type_id::create("agent",this);
    sbd=mem_sbd::type_id::create("sbd",this);

  endfunction
  
  function void connect();
    `uvm_info("ENV","MEM_ENV_CONNECT","UVM_NONE")
    agent.monitor.mem_port.connect(sbd.analysis_imp);
  endfunction
    
endclass





