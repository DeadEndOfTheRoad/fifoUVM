interface fifo_if;
    import parameter_pkg::*;
    
    logic clk, rstn; 
    logic wr_en, rd_en; 
    logic [WIDTH-1:0] wr_data; 
    logic [WIDTH-1:0] rd_data; 
    logic full, empty; 
    logic almost_full; // count == DEPTH-1 
    logic almost_empty; // count == 1 
    logic [$clog2(DEPTH):0] count;
    
endinterface : fifo_if
