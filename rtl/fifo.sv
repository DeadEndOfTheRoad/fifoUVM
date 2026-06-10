module fifo 
    #( parameter DEPTH = 8, parameter WIDTH = 32 
    )(
         input logic clk, rstn, 
         input logic wr_en, rd_en, 
         input logic [WIDTH-1:0] wr_data, 
         output logic [WIDTH-1:0] rd_data, 
         output logic full, empty, 
         output logic almost_full, 
         output logic almost_empty, 
         output logic [$clog2(DEPTH):0] count
    );
    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;

    assign full = (count == DEPTH); 
    assign empty = (count == 0); 
    assign almost_full = (count == DEPTH-1); 
    assign almost_empty = (count == 1); 

    always_ff @(posedge clk or negedge rstn) begin 
        if (!rstn) begin 
            wr_ptr <= 0; 
            rd_ptr <= 0; 
            count <= 0; 
        end else begin 
            if (wr_en && !full) begin 
                mem[wr_ptr] <= wr_data; 
                wr_ptr <= wr_ptr + 1; 
                count <= count + 1; 
            end 
            if (rd_en && !empty) begin 
                rd_data <= mem[rd_ptr]; 
                rd_ptr <= rd_ptr + 1; 
                count <= count - 1; 
            end 
            if (wr_en && !full && rd_en && !empty) 
                count <= count; 
        end 
    end 
endmodule
