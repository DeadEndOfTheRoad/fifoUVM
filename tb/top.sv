module top;
    
    import my_pkg::*;
    import parameter_pkg::*;

    fifo_if vif();

    initial begin
        vif.clk = 0;
        forever #5 vif.clk = ~vif.clk;
    end

    fifo #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
    ) dut (
        .clk(vif.clk),
        .rstn(vif.rstn),
        .wr_en(vif.wr_en),
        .rd_en(vif.rd_en),
        .wr_data(vif.wr_data),
        .rd_data(vif.rd_data),
        .full(vif.full),
        .empty(vif.empty),
        .almost_full(vif.almost_full),
        .almost_empty(vif.almost_empty),
        .count(vif.count)
    );

    initial begin
        vif.rstn = 0;
        vif.wr_en = 0;
        vif.rd_en = 0;
        #2 vif.rstn = 1;

        @(negedge vif.clk);
        vif.wr_en = 1; 
        vif.wr_data = 32'hDEADBEEF;
        
        @(negedge vif.clk);
        vif.wr_en = 1; 
        vif.wr_data = 32'hAAAABBBB;

        @(negedge vif.clk);
        vif.wr_en = 0;
        vif.rd_en = 1; 
        vif.wr_data = 32'hDEADBEEF;

        @(negedge vif.clk);
        vif.rd_en = 1; 
        vif.wr_data = 32'hAAAABBBB;
        
        #20;

        $stop;
    end

endmodule
