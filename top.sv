
 `define ADDR_WIDTH $clog2(`DEPTH)
`define WIDTH 32
`define DEPTH 256

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "memory.sv"
`include "mem_common.sv"
`include "mem_tx.sv"
`include "mem_sequence.sv"
`include "mem_sqr.sv"
`include "mem_intr.sv"
`include "mem_drv.sv"
`include "mem_mon.sv"
`include "mem_cov.sv"
`include "mem_sbd.sv"
`include "mem_agent.sv"
`include "mem_env.sv"
`include "mem_assert.sv"
`include "mem_test.sv"

module top;
  reg clk,rst;
  
 
  mem_intr pif(clk,rst);
  
  
  mem dut(.clk(pif.clk),.rst(pif.rst),.addr(pif.addr),.wdata(pif.wdata),.rdata(pif.rdata),.wr_rd(pif.wr_rd),.valid(pif.valid),.ready(pif.ready));
  
 // assert
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0);
  end
  
  
  initial begin
    clk=0;
    //always #5 clk=~clk;
    forever #5 clk=~clk;
  end
  //reset
  initial begin
    rst=1;
    repeat(2)@(posedge clk);
    rst=0;
    end
  
  initial begin
    run_test("mem_l_n_wr_rd_test");
  end
  

endmodule



