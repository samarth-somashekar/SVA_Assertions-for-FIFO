
bind fifo fifo_assertions #(
    .ADDR_WIDTH(2),
    .DATA_WIDTH(8)
) fifo_assert (
    .vif(fifo_tb.dut_if)
);
