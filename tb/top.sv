module top;
    
    import uvm_pkg::*;
    import my_pkg::*;
    import parameter_pkg::*;

    fifo_if vif();

    initial begin
        vif.clk = 0;
        forever #5 vif.clk = ~vif.clk;
    end

    initial begin
        vif.rstn = 1;
        #3;
        vif.rstn = 0;
        #3;
        vif.rstn = 1;
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
        uvm_config_db #(virtual fifo_if)::set(null, "uvm_test_top", "vif", vif);
        run_test("my_test");
    end

endmodule
