# Key Features

Top module

Test File

DUT File

Environment File

Scoreboard File

Agent File

Sequencer File

Driver File

Monitor File

Coverage File

Assert File

Common File

Interface File

Sequence File

Transaction File

Run File

# How It Works

# 1. mem_intr.sv (Interface)

Defines the memory interface with signals for:

wr_rd (write/read control)

addr (address bus)

wdata (write data)

rdata (read data)

valid & ready (handshaking signals)

Includes clocking blocks (bfm_cb for driving and mon_cb for monitoring) to synchronize testbench and DUT communication.

# 2. mem_mon.sv (Monitor)

Implements a UVM monitor (mem_mon) to observe memory transactions.

Samples interface signals via the monitor clocking block (mon_cb).

Captures transactions into mem_tx objects and forwards them through an analysis port for further checking.

Ensures every valid read/write operation is reported.

# 3. mem_sbd.sv (Scoreboard)

Implements a UVM scoreboard (mem_sbd) to check correctness of DUT behavior.

Maintains a reference memory model using an associative array (mem_reg).

Compares DUT read data (rdata) with expected stored data.

Tracks matches and mismatches, updating counters for result analysis.

# 4. mem_sequence.sv (Sequences)

Defines UVM sequences to generate stimulus:

mem_sequence: Issues a set of write transactions followed by corresponding read transactions from stored addresses.

mem_n_wr_n_rd_seq: A parameterized sequence generating n writes followed by n reads, configurable via uvm_config_db.

Ensures randomized and constrained memory access patterns.

# 5. mem_sqr.sv (Sequencer)

Defines a UVM sequencer (mem_seqr) to control and deliver transactions to the driver.

Acts as a link between sequences and the driver, managing transaction flow.

Includes build-phase messages for debug visibility.

# 6. mem_test.sv (Tests)

Implements UVM test classes:

mem_test: Base test that creates the environment (mem_env), runs a sequence, and prints the UVM topology.

mem_n_wr_n_rd_test: Extended test that runs a sequence with configurable number of write/read transactions.

Controls simulation execution by raising/dropping objections and applying drain time for clean shutdown.

# 7.DUT (Design Under Test):

memory.sv – The memory module implementation. It defines read/write operations, address handling, and data storage logic.

Testbench Components (UVM Environment):

# 8.Transaction Class

mem_tx.sv – Defines the memory transaction (sequence item) containing fields like address, data, operation type (read/write).

# 9.Sequence & Sequencer

mem_sequence.sv – Generates different read/write stimulus sequences.

mem_sqr.sv – Sequencer that controls the flow of sequence items to the driver.

# 10.Driver & Monitor

mem_intr.sv – Acts as the driver (interface) that drives signals to the DUT.

mem_mon.sv – Monitor to capture DUT responses and forward them to analysis components.

# 12.Test

mem_test.sv – Defines the overall test, configures the environment, and controls sequence execution.

# 13.Top 

top.sv-Instantiates DUT and connects it with the UVM testbench.

# 14.Run

run.do-Simulation script (likely for ModelSim/Questa/Synopsis) to compile and run the project.

# 15.Common

This file is used to keep all the required transactions in it.
