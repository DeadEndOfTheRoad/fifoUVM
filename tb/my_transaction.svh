class my_transaction extends uvm_sequence_item;
    `uvm_object_utils(my_transaction)

    rand bit wr_en;
    rand bit rd_en;
    rand logic [WIDTH-1:0] wr_data;
    
    logic [WIDTH-1:0] rd_data;

    function new(string name = "");
        super.new(name);
    endfunction;
endclass