class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)

    function new(string name = "");
        super.new(name);
    endfunction

    task body;
        repeat(1000) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            assert(tx.randomize());
            finish_item(tx);
        end
    endtask
endclass