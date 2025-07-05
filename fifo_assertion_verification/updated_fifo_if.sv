
interface fifo_if #(parameter ADDR_WIDTH = 2, DATA_WIDTH = 8);
    logic clk, rst;
    logic wr_en, rd_en;
    logic full, empty;
    logic [DATA_WIDTH-1:0] din, dout;
    logic [ADDR_WIDTH-1:0] wr_ptr, rd_ptr;
endinterface
