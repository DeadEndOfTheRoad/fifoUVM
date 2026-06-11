class my_driver extends uvm_driver #(my_transaction);
    `uvm_component_utils(my_driver)

    my_dut_config dut_config_0;
    virtual fifo_if vif;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(my_dut_config)::get(this, "", "dut_config", dut_config_0))
            `uvm_fatal("MY_DRIVER", "No config found")
        vif = dut_config_0.vif;
    endfunction

    task run_phase(uvm_phase phase);
        int count;
        forever begin 
            my_transaction tx;
            @(negedge vif.clk);
            seq_item_port.get_next_item(tx);
            
            if (count >= DEPTH) tx.wr_en = 0;
            if (count <= 0)     tx.rd_en = 0;

            if (tx.wr_en && !tx.rd_en) count++;
            if (tx.rd_en && !tx.wr_en) count--;

            vif.wr_en = tx.wr_en;
            vif.rd_en = tx.rd_en;
            vif.wr_data = tx.wr_data;
            @(posedge vif.clk)
                seq_item_port.item_done();
        end
    endtask
endclass