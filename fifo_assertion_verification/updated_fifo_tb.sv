
`timescale 1ns/1ps

module fifo_tb;

    parameter ADDR_WIDTH = 2;
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 2**ADDR_WIDTH;

    fifo_if #(ADDR_WIDTH, DATA_WIDTH) dut_if();

    int write_count = 0;
    int read_count = 0;
    int full_hit = 0;
    int empty_hit = 0;

    fifo #(.WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) dut (
        .clk(dut_if.clk),
        .rst(dut_if.rst),
        .wr_en(dut_if.wr_en),
        .rd_en(dut_if.rd_en),
        .din(dut_if.din),
        .dout(dut_if.dout),
        .full(dut_if.full),
        .empty(dut_if.empty)
    );

    always #5 dut_if.clk = ~dut_if.clk;

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);

        dut_if.clk = 0;
        dut_if.rst = 1;
        dut_if.wr_en = 0;
        dut_if.rd_en = 0;
        dut_if.din = 0;

        #15 dut_if.rst = 0;

        repeat (3) begin
            @(posedge dut_if.clk);
            if (!dut_if.full) begin
                dut_if.wr_en = 1;
                dut_if.din = $random;
                write_count++;
            end else begin
                dut_if.wr_en = 0;
            end
            if (dut_if.full) full_hit++;
        end
        @(posedge dut_if.clk);
        dut_if.wr_en = 0;

        repeat (3) begin
            @(posedge dut_if.clk);
            if (!dut_if.empty) begin
                dut_if.rd_en = 1;
                read_count++;
            end else begin
                dut_if.rd_en = 0;
            end
            if (dut_if.empty) empty_hit++;
        end
        @(posedge dut_if.clk);
        dut_if.rd_en = 0;

        $display("\n*** Functional Coverage Summary ***");
        $display("Total Writes    : %0d", write_count);
        $display("Total Reads     : %0d", read_count);
        $display("Full Condition  : Hit %0d time(s)", full_hit);
        $display("Empty Condition : Hit %0d time(s)", empty_hit);

        #20 $finish;
    end

endmodule
