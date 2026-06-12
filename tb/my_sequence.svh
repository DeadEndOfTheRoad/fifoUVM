class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)

    function new(string name = "");
        super.new(name);
    endfunction

    task body;
        my_transaction tx;
        tx = my_transaction::type_id::create("tx");
        start_item(tx);
        assert(tx.randomize());
        finish_item(tx);
    endtask
endclass