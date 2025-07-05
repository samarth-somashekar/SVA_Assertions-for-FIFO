
`timescale 1ns/1ps

module fifo (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [7:0] din,
    output reg [7:0] dout,
    output full,
    output empty
);
    parameter WIDTH = 8;
    parameter DEPTH = 4;
    parameter ADDR_WIDTH = 2;

    reg [WIDTH-1:0] mem [0:DEPTH-1];
    reg [ADDR_WIDTH-1:0] wr_ptr, rd_ptr;
    reg [ADDR_WIDTH:0] count;

    assign full = (count == DEPTH);
    assign empty = (count == 0);

    always @(posedge clk or posedge rst) begin
        if (rst)
            wr_ptr <= 0;
        else if (wr_en && !full)
            wr_ptr <= wr_ptr + 1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            rd_ptr <= 0;
        else if (rd_en && !empty)
            rd_ptr <= rd_ptr + 1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else begin
            case ({wr_en && !full, rd_en && !empty})
                2'b10: count <= count + 1;
                2'b01: count <= count - 1;
            endcase
        end
    end

    always @(posedge clk)
        if (wr_en && !full)
            mem[wr_ptr] <= din;

    always @(posedge clk)
        if (rd_en && !empty)
            dout <= mem[rd_ptr];
endmodule
