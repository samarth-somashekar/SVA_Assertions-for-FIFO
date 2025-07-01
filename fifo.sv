`timescale 1ns/1ps

module fifo (
    clk,
    rst,
    wr_en,
    rd_en,
    din,
    dout,
    full,
    empty
);
    parameter WIDTH = 8;
    parameter DEPTH = 8;

    input clk;
    input rst;
    input wr_en;
    input rd_en;
    input [WIDTH-1:0] din;

    output reg [WIDTH-1:0] dout;
    output full;
    output empty;

    // Internal memory
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers and counters
    reg [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;
    reg [$clog2(DEPTH+1)-1:0] count;

    assign full = (count == DEPTH);
    assign empty = (count == 0);

    // Write logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            wr_ptr <= 0;
        else if (wr_en && !full) begin
            mem[wr_ptr] <= din;
            wr_ptr <= (wr_ptr + 1) % DEPTH;
        end
    end

    // Read logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            dout <= 0;
        end else if (rd_en && !empty) begin
            dout <= mem[rd_ptr];
            rd_ptr <= (rd_ptr + 1) % DEPTH;
        end
    end

    // Count logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else begin
            case ({wr_en && !full, rd_en && !empty})
                2'b10: count <= count + 1;
                2'b01: count <= count - 1;
                default: count <= count;
            endcase
        end
    end

endmodule
