interface fifo_if;
  logic clk;
  logic rst;
  logic wr_en;
  logic rd_en;
  logic full;
  logic empty;
endinterface

// Assertion Module
module fifo_asserts(fifo_if intf);
  // Ensure full is high when FIFO is full (write not allowed)
  property no_write_when_full;
    @(posedge intf.clk) disable iff(intf.rst)
      intf.full |-> !intf.wr_en;
  endproperty
  assert property(no_write_when_full)
    else $error("Assertion Failed: Write attempted when FIFO is full");

  // Ensure empty is high when FIFO is empty (read not allowed)
  property no_read_when_empty;
    @(posedge intf.clk) disable iff(intf.rst)
      intf.empty |-> !intf.rd_en;
  endproperty
  assert property(no_read_when_empty)
    else $error("Assertion Failed: Read attempted when FIFO is empty");

  // Optional: full and empty are never high together
  property not_full_and_empty;
    @(posedge intf.clk) disable iff(intf.rst)
      !(intf.full && intf.empty);
  endproperty
  assert property(not_full_and_empty)
    else $error("Assertion Failed: FIFO can't be full and empty at the same time");
endmodule

// Bind assertion module to FIFO
bind fifo fifo_asserts a1(.intf(intf));
