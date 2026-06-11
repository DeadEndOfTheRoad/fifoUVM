class my_dut_config extends uvm_object;
    `uvm_object_utils(my_dut_config)

    virtual fifo_if vif;

    function new(string name = "my_dut_config");
        super.new(name);
    endfunction

endclass