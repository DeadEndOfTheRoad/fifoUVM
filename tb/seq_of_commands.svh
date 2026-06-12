class seq_of_commands extends uvm_sequence #(my_transaction);
    `uvm_object_utils(seq_of_commands)

    rand int n;
    constraint how_many {n inside {[100:1000]};}

    function new(string name = "");
        super.new(name);
    endfunction

    task body;
        repeat(n) begin 
            my_sequence seq;
            seq = my_sequence::type_id::create("seq");
            seq.start(m_sequencer, this); 
        end
    endtask
endclass