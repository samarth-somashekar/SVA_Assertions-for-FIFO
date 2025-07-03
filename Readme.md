# Parameterized FIFO Design with SystemVerilog Assertions

This project implements a parameterized FIFO (First-In First-Out) queue in SystemVerilog and verifies its correctness using simulation and SystemVerilog Assertions (SVA).

Part of Week 1 of my 1-month RTD-aligned VLSI Plan.

---

## Features

- ✅ Parameterized depth and data width
- ✅ RTL-compliant Verilog design (Icarus + VCS compatible)
- ✅ Functional testbench (write/read stimulus)
- ✅ Assertions using bind interface (no DUT modification)
- ✅ GTKWave waveform dump (`.vcd`)
- ✅ EDA Playground + VCS-tested

---

## Files

| File | Description |
|------|-------------|
| `fifo.sv` | RTL design of the FIFO (8x8 default) |
| `fifo_tb.sv` | Testbench generating write/read patterns |
| `fifo_sva_bind.sv` | Interface + bind + SVA rules |
| `fifo.vcd` | Waveform dump generated from simulation |
| `README.md` | You're reading it 😄 |

---

## How to Simulate (Icarus Verilog + GTKWave)

```bash
iverilog -o fifo.vvp fifo.sv fifo_tb.sv fifo_sva_bind.sv
vvp fifo.vvp
gtkwave fifo.vcd
