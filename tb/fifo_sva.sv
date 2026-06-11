module fifo_sva 
    #( parameter DEPTH = 8, parameter WIDTH = 32 
    )(
        input logic clk, rstn, 
        input logic wr_en, rd_en, 
        input logic [WIDTH-1:0] wr_data, 
        input logic [WIDTH-1:0] rd_data, 
        input logic full, empty, 
        input logic almost_full, 
        input logic almost_empty, 
        input logic [$clog2(DEPTH):0] count,
        input logic [WIDTH-1:0] mem [0:DEPTH-1],
        input logic [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr
    );

    AP_fifo_full_def : assert property 
        ( @(posedge clk) disable iff(!rstn)
        full == (count == DEPTH) );

    AP_fifo_empty_def : assert property 
        ( @(posedge clk) disable iff(!rstn)
        empty == (count == 0) );
    
    AP_fifo_almost_full_def : assert property 
        ( @(posedge clk) disable iff(!rstn)
        almost_full == (count == DEPTH - 1) );
    
    AP_fifo_almost_empty_def : assert property 
        ( @(posedge clk) disable iff(!rstn)
        almost_empty == (count == 1) );

    AP_fifo_count_less_than_or_equal_depth: assert property
        ( @(posedge clk) disable iff(!rstn) 
        count <= DEPTH );
    
    AP_fifo_rd_ptr_less_than_depth: assert property
        ( @(posedge clk) disable iff(!rstn)
        rd_ptr < DEPTH );
    
    AP_fifo_wr_ptr_less_than_depth: assert property
        ( @(posedge clk) disable iff(!rstn)
        wr_ptr < DEPTH );

    AP_fifo_wr_en_not_full_count_increment: assert property
        ( @(posedge clk) disable iff(!rstn)
        wr_en && !rd_en && !full |=> count == $past(count) + 1 );
    
    AP_fifo_rd_en_not_empty_count_decrement: assert property
        ( @(posedge clk) disable iff(!rstn)
        rd_en && !wr_en && !empty |=> count == $past(count) - 1);

    AP_fifo_rd_en_and_wr_en_count_stable: assert property
        ( @(posedge clk) disable iff(!rstn)
        rd_en && wr_en |=> $stable(count)); 

    AP_fifo_read_data : assert property 
        ( @(posedge clk) disable iff(!rstn)
        (rd_en && !empty) |=> rd_data == $past(mem[rd_ptr]));
    
    AP_fifo_write_data: assert property 
        ( @(posedge clk) disable iff(!rstn)
        (wr_en && !full) |=> mem[$past(wr_ptr)] == $past(wr_data));

    AP_fifo_full_no_wr_en: assert property
        ( @(posedge clk) disable iff(!rstn)
        full |-> !wr_en);
    
    AP_fifo_empty_no_rd_en: assert property
        ( @(posedge clk) disable iff(!rstn)
        empty |-> !rd_en);
    
    
    
    
        

endmodule