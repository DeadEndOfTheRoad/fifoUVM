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

    bind dut fifo_sva # (
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) fifo_checker (
        .clk(clk),
        .rstn(rstn),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty),
        .almost_full(almost_full),
        .almost_empty(almost_empty),
        .count(count),
        .mem(mem),
        .wr_ptr(wr_ptr),
        .rd_ptr(rd_ptr)
    );

    initial begin
        vif.rstn = 0;
        vif.wr_en = 0;
        vif.rd_en = 0;
        #2 vif.rstn = 1;

        @(negedge vif.clk);
        vif.wr_en = 1; 
        vif.rd_en = 0; 
        vif.wr_data = 32'h00000000;
        
        @(negedge vif.clk);
        vif.wr_en = 1; 
        vif.rd_en = 0;
        vif.wr_data = 32'hAAAAAAAA;

        @(negedge vif.clk);
        vif.wr_en = 1;
        vif.rd_en = 1; 
        vif.wr_data = 32'hBBBBBBBB;

        @(negedge vif.clk);
        vif.wr_en = 1;
        vif.rd_en = 1; 
        vif.wr_data = 32'hCCCCCCCC;
        
        @(negedge vif.clk);
        vif.wr_en = 1;
        vif.rd_en = 1; 
        vif.wr_data = 32'hDDDDDDDD;
        
        @(negedge vif.clk);
        vif.wr_en = 1;
        vif.rd_en = 1; 
        vif.wr_data = 32'hEEEEEEEE;
        
        @(negedge vif.clk);
        vif.wr_en = 1;
        vif.rd_en = 1; 
        vif.wr_data = 32'hFFFFFFFF;
        
        @(negedge vif.clk);
        vif.wr_en = 1;
        vif.rd_en = 0; 
        vif.wr_data = 32'h11111111;
        
        for (int i = 0; i < 3; i++) begin
            @(negedge vif.clk);
            vif.wr_en = 0;
            vif.rd_en = 1; 
        end

        for (int i = 0; i < 8; i++) begin
            @(negedge vif.clk);
            vif.wr_en = 1;
            vif.rd_en = 0;
            vif.wr_data = 32'h11111111 * i;
        end

        for (int i = 0; i < 8; i++) begin
            @(negedge vif.clk);
            vif.wr_en = 0;
            vif.rd_en = 1;
        end

        @(negedge vif.clk);
        vif.wr_en = 0;
        vif.rd_en = 0;

        #20;

        $stop;
    end

endmodule
