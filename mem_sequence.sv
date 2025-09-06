class mem_sequence extends uvm_sequence #(mem_tx);
   mem_tx tx;
  `uvm_object_utils(mem_sequence);
 
//  apbt_tx tx[$];
   bit[`ADDR_WIDTH-1:0] txQ[$];  
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(5) begin
    `uvm_do_with(req,{req.wr_rd==1'b1;});
      req.print();
      txQ.push_back(req.addr);
    end
    repeat (5) begin
      `uvm_do_with(req,{req.wr_rd==1'b0; req.addr==txQ.pop_front();});
	
    end
  endtask
  
endclass


class mem_n_wr_n_rd_seq extends mem_sequence;
   int tx_num;
  `uvm_object_utils(mem_n_wr_n_rd_seq);
   bit[`ADDR_WIDTH-1:0] txQ[$];
  
  function new(string name="");
    super.new(name);
  endfunction
  task body();
    uvm_config_db#(int)::get(null," ","tx_num",tx_num);
    repeat(tx_num) begin
      `uvm_do_with(req,{req.wr_rd==1'b1;});
      //req.print();
      txQ.push_back(req.addr);
    end
    repeat(tx_num) begin
      `uvm_do_with(req,{req.wr_rd==1'b0; req.addr==txQ.pop_front();});
    end
    
  endtask
endclass

//Consecutive wr_rd
class mem_n_wr_rd_seq extends mem_sequence;
	int tx_num;
  `uvm_object_utils(mem_n_wr_rd_seq)
//bit [`AD_WI-1:0] txQ[$];

	function new(string name="");
		super.new(name);
	endfunction

	task body();
      uvm_config_db#(int)::get(null,"","tx_num",tx_num);
      repeat(tx_num)begin
		`uvm_do_with(req,{req.wr_rd==1'b1;});
          req.print();
          tx=new req;
		//txQ.push_back(req.addr);
		//end

		
        `uvm_do_with(req,{req.wr_rd==1'b0;req.addr==tx.addr;});
		end
	
	endtask
endclass

//Sequence Layering
//Write tx ==> layer=1
class mem_wr_seq extends mem_sequence;
  int tx_num;
  `uvm_object_utils(mem_wr_seq)
  rand bit[`ADDR_WIDTH-1:0] addr_temp;
  
  function new(string name=""); 
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req,{req.wr_rd==1;req.addr==addr_temp;}); 
  endtask
endclass
  
//Read tx ==> layer=2
  class mem_rd_seq extends mem_sequence;
    `uvm_object_utils(mem_rd_seq);
    rand bit [`ADDR_WIDTH-1:0]addr_temp;
  
    function new(string name="");
      super.new(name);
    endfunction
    
    task body();
      `uvm_do_with(req,{req.wr_rd==1'b0; req.addr==addr_temp;});
    endtask
  endclass
   
//2nd layer ==> write and read layering

class mem_l_wr_rd_seq extends mem_sequence;
  `uvm_object_utils(mem_l_wr_rd_seq)
  	
  mem_wr_seq wr_seq;
  mem_rd_seq rd_seq;
  rand bit[`ADDR_WIDTH-1:0]addr_temp1;
  
  function new(string name="");
    super.new(name);
  endfunction
  
//below body method will do consecutive write_read
  task body();
    begin
      `uvm_do_with(wr_seq,{wr_seq.addr_temp==addr_temp1;});
      `uvm_do_with(rd_seq,{rd_seq.addr_temp==addr_temp1;});
    end
  endtask
endclass

//3rd layer

class mem_l_n_wr_rd_seq extends mem_sequence;
  `uvm_object_utils(mem_l_n_wr_rd_seq)
  
  mem_l_wr_rd_seq seq;
  int tx_num;
  //rand bit [`ADDR_WIDTH-1:0] addr_temp1;
  rand bit [`ADDR_WIDTH-1:0] addr_temp2;
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    uvm_config_db#(int)::get(null,"","tx_num",tx_num);
    for(int i=0;i<tx_num;i++)begin
      `uvm_do_with(seq,{seq.addr_temp1==addr_temp2+2*i;});
    end
  endtask
endclass



