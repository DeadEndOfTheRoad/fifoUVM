package my_pkg;
    
    import uvm_pkg::*;
    import parameter_pkg::*;
    `include "uvm_macros.svh"

    
    `include "my_dut_config.svh"
    `include "my_transaction.svh"
    typedef uvm_sequencer #(my_transaction) my_sequencer;
    `include "my_sequence.svh"
    `include "seq_of_commands.svh"
    `include "my_subscriber.svh"
    `include "my_monitor.svh"
    `include "my_driver.svh"
    `include "my_agent.svh"
    `include "my_env.svh"
    `include "my_test.svh"

endpackage


