class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)

    my_sequencer my_sequencer_h;
    my_driver my_driver_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        my_sequencer_h = my_sequencer::type_id::create("my_sequencer", this);
        my_driver_h = my_driver::type_id::create("my_driver", this);
    endfunction;

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        my_driver_h.seq_item_port.connect(my_sequencer_h.seq_item_export);
    endfunction

endclass