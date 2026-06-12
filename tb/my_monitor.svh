class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    uvm_analysis_port #(my_transaction) aport;
    my_dut_config dut_config_0;
    virtual fifo_if vif;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(my_dut_config)::get(this, "", "dut_config", dut_config_0))
            `uvm_fatal("MY_MONITOR", "No config found")
        vif = dut_config_0.vif;
        aport = new("aport", this);
    endfunction

    task run_phase(uvm_phase phase); 
        @(posedge vif.clk);
        forever begin
            my_transaction tx;
            
            @(posedge vif.clk);
            uvm_wait_for_nba_region();
            $display("MONITOR: Time: %0t | clk = %0b | wr_en = %0b | empty = %0b",
                $time, vif.clk, vif.wr_en, vif.empty);
            tx = my_transaction::type_id::create("tx");
            
            tx.wr_en = vif.wr_en;
            tx.rd_en = vif.rd_en;
            tx.wr_data = vif.wr_data;
            tx.rd_data = vif.rd_data;
            tx.full = vif.full;
            tx.empty = vif.empty;
            
            aport.write(tx);
        end
    endtask


endclass