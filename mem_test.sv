class mem_test extends uvm_test;  
	mem_env env;
  	mem_sequence seq;

  `uvm_component_utils(mem_test);

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		env=mem_env::type_id::create("env",this);
		`uvm_info("TEST","MEM_TEST",UVM_NONE);
	endfunction

	function void end_of_eloboration();
		uvm_top.print_topology();
	endfunction
  
   
 	task run_phase(uvm_phase phase);
 		phase.raise_objection(this);
        seq=new("seq");
        seq.start(env.agent.seqr);  
 		phase.phase_done.set_drain_time(this,160);
 		phase.drop_objection(this);
	endtask	
endclass

class mem_n_wr_n_rd_test extends mem_test;    //nwr_n_rd
    mem_n_wr_n_rd_seq seq;
	int tx_num;
  `uvm_component_utils(mem_n_wr_n_rd_test)

  
  function new(string name="", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq=new("seq");
    uvm_config_db#(int)::set(null,"*","tx_num",10);
    seq.start(env.agent.seqr);
    phase.phase_done.set_drain_time(this,150);
    phase.drop_objection(this);
  endtask
    
endclass

class mem_n_wr_rd_test extends mem_test;   //consecutive wr+rd 
  mem_n_wr_rd_seq seq;
  int tx_num;
  `uvm_component_utils(mem_n_wr_rd_test)
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //Scoreboard code
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    if(mem_common::num_matches!=0 && mem_common::mismatches==0)begin
      
      `uvm_info("MEM_TEST","TEST_PASSED",UVM_MEDIUM);
    end
    else begin
   	  $display("matching=%0d",mem_common::num_matches);
      $display("mismatching=%0d",mem_common::mismatches);
      `uvm_error("MEM_TEST","TEST_FAILED");
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq=new("seq");
    uvm_config_db#(int)::set(null,"*","tx_num",8);
    seq.start(env.agent.seqr);
    phase.phase_done.set_drain_time(this,100);
    phase.drop_objection(this);
  endtask
endclass     

class mem_l_n_wr_rd_test extends mem_test;            //3rd layer
  `uvm_component_utils(mem_l_n_wr_rd_test);
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    uvm_config_db#(int)::set(null,"*","tx_num",16);
    //uvm_config_db#(uvm_object_wrapper)::set(this,"env.agent.seqr.run_phase","default_sequence",mem_mult_seq::get_type());
  endfunction
  
  //seq allows flexibility and layering of seq
  task run_phase(uvm_phase phase);
    mem_l_n_wr_rd_seq seq;
    seq = mem_l_n_wr_rd_seq::type_id::create("seq");
    phase.raise_objection(this);
    seq.addr_temp2 = 32'h10;
    seq.start(env.agent.seqr);
    phase.phase_done.set_drain_time(this,120);
    phase.drop_objection(this);
  endtask
  
  //Scoreboard code
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    if(mem_common::num_matches!=0 && mem_common::mismatches==0)begin
      
      `uvm_info("MEM_TEST","TEST_PASSED",UVM_MEDIUM);
      $display("matching=%0d",mem_common::num_matches);
      $display("mismatching=%0d",mem_common::mismatches);
      
    end
    else begin
   	  $display("matching=%0d",mem_common::num_matches);
      $display("mismatching=%0d",mem_common::mismatches);
      `uvm_error("MEM_TEST","TEST_FAILED");
    end
  endfunction
endclass    
    
    
    

