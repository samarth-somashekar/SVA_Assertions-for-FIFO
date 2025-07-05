# Parameterized FIFO with Assertion-Based Verification

##Project Overview
This project implements and verifies a configurable FIFO using SystemVerilog and SystemVerilog Assertions (SVA). It checks not only read/write behavior but also pointer safety and wrap-around.

##Features
- Parameterized FIFO (WIDTH, DEPTH, ADDR_WIDTH)
- Reusable interface for connecting DUT and TB
- Bind-based assertion injection (non-invasive)
- Assertions:
  - No write on full
  - No read on empty
  - Pointer wrap-around from DEPTH-1 → 0
- Synthesizable design, works with VCS, EDA Playground

##Files
- `fifo.sv` → FIFO RTL
- `fifo_tb.sv` → Testbench
- `fifo_if.sv` → Interface
- `fifo_assertions.sv` → SVA properties
- `fifo_sva_bind.sv` → Assertion binding

##Tools Used
- Synopsys VCS / EDA Playground
- SystemVerilog 2012

---

###Outcome
A strong example of reusable, scalable FIFO design with assertion-based validation, suitable for Tier-1 verification roles.
