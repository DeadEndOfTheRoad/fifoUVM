class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    
    my_env my_env_h;
    my_dut_config dut_config_0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        dut_config_0 = my_dut_config::type_id::create("dut_config_0", this);
        my_env_h = my_env::type_id::create("my_env", this);
        
        if(!uvm_config_db #(virtual fifo_if)::get(this, "","vif", dut_config_0.vif))
            `uvm_fatal("MY_TEST", "No VIF");
        uvm_config_db #(my_dut_config)::set(this, "*", "dut_config", dut_config_0);
    endfunction: build_phase
endclass