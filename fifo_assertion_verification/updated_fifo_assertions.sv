
module fifo_assertions #(parameter ADDR_WIDTH = 2, DATA_WIDTH = 8) (
    fifo_if #(ADDR_WIDTH, DATA_WIDTH) vif
);

    assert_no_write_when_full: assert property (
        @(posedge vif.clk) disable iff (vif.rst)
        (vif.wr_en && vif.full) |-> ##1 $stable(vif.wr_ptr)
    );

    assert_no_read_when_empty: assert property (
        @(posedge vif.clk) disable iff (vif.rst)
        (vif.rd_en && vif.empty) |-> ##1 $stable(vif.rd_ptr)
    );

endmodule
