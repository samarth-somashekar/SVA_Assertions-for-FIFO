`timescale 1ns / 1ps

module fifo_tb;

    // Parameters
    parameter WIDTH = 8;
    parameter DEPTH = 8;

    // DUT Signals
    logic clk;
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [WIDTH-1:0] din;
    logic [WIDTH-1:0] dout;
    logic full;
    logic empty;

    // Instantiate DUT
    fifo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Clock Gen
    always #5 clk = ~clk;

    // Test Sequence
    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);

        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        #15 rst = 0;

        // Write 3 values into FIFO
        repeat (3) begin
            @(posedge clk);
            wr_en = 1;
            din = $random;
        end
        @(posedge clk);
        wr_en = 0;

        // Read 3 values
        repeat (3) begin
            @(posedge clk);
            rd_en = 1;
        end
        @(posedge clk);
        rd_en = 0;

        #20 $finish;
    end

endmodule
