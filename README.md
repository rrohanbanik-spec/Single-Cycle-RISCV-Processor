# Single-Cycle RISC-V Processor (RV32I)

A fully functional RISC-V RV32I single-cycle processor implemented in Verilog and simulated using Xilinx Vivado. Built from scratch as part of a self-directed RTL design project.

---

## Architecture Overview

The processor implements the classic 5-stage single-cycle datapath from Patterson & Hennessy — *Computer Organization and Design: RISC-V Edition*.

Every instruction completes in exactly one clock cycle. The datapath consists of the following modules wired together in `top.v`:

```
PC → Instruction Memory → Register File → ALU → Data Memory → Writeback
                ↑                              ↓
           Control Unit              Branch Logic (AND + Adder)
                ↑
           ALU Control ← funct3, funct7
```

---

## Supported Instructions

| Type | Instructions |
|---|---|
| R-type | ADD, SUB, AND, OR |
| I-type | ADDI, ORI |
| Load | LW |
| Store | SW |
| Branch | BEQ |

---

## Module Breakdown

| Module | File | Description |
|---|---|---|
| Program Counter | `PC.v` | 32-bit register, resets to 0, updates on posedge clk |
| PC Adder | `PCplus4.v` | Computes PC+4 combinationally |
| Instruction Memory | `Instruction_Mem.v` | 64-word ROM, combinational read, initialized via `initial` block |
| Register File | `Reg_File.v` | 32×32-bit registers, 2 combinational read ports, 1 synchronous write port |
| Immediate Generator | `ImmGen.v` | Sign-extends immediates for I, S, B instruction types |
| Control Unit | `Control_Unit.v` | Decodes opcode, generates all datapath control signals |
| ALU Control | `ALU_Control.v` | Fine-decodes ALU operation from ALUOp + funct3 + funct7 |
| ALU | `ALU_unit.v` | Supports ADD, SUB, AND, OR with Zero flag output |
| Data Memory | `Data_Memory.v` | 64-word RAM, synchronous write, combinational read |
| Muxes | `mux.v` | ALUSrc mux, MemtoReg mux, PC select mux |
| Utilities | `utils.v` | Branch adder (PC + imm), AND gate for branch decision |
| Top Level | `top.v` | Instantiates and wires all modules |
| Testbench | `tb_top.v` | Generates clock and reset stimulus |

---

## Simulation Setup

**Tool:** Xilinx Vivado 2022.2 (XSim behavioral simulator)

**Clock period:** 10ns (toggles every 5ns)

**Reset:** Active-high, held for 12ns then released — timed to fall cleanly between clock edges to avoid simulation race conditions

**Instruction memory:** Pre-loaded with a mix of R, I, Load, Store, and Branch instructions via Verilog `initial` block

**Register file:** Pre-initialized with known values to allow manual verification of results

---

## Verified Test Program

The following instructions are loaded into instruction memory and verified against expected outputs:

```
NOP                     // I_Mem[0]  — processor warmup
add  x13, x16, x25     // I_Mem[1]  — 40 + 90 = 130 (0x82)
sub  x5,  x8,  x3      // I_Mem[2]  — 2 - 24 = -22 (0xFFFFFFEA)
and  x1,  x2,  x3      // I_Mem[3]  — 2 & 24 = 0
or   x4,  x3,  x5      // I_Mem[4]  — 24 | (-22)
addi x22, x21, 3       // I_Mem[5]  — 3 + 3 = 6
ori  x9,  x8,  1       // I_Mem[6]  — OR immediate
lw   x8,  15(x5)       // I_Mem[7]  — load from address x5+15
lw   x9,  3(x3)        // I_Mem[8]  — load from address x3+3
sw   x15, 12(x5)       // I_Mem[9]  — store to memory
sw   x14, 10(x6)       // I_Mem[10] — store to memory
beq  x9,  x9,  12      // I_Mem[11] — branch always taken (x9==x9)
```

---

## Key Design Decisions

**Combinational instruction memory read** — the instruction memory uses a combinational `assign` for the read port so the instruction is available immediately after the PC updates, with no added clock latency.

**Word-addressed memory indexing** — both instruction memory and data memory are indexed by `address >> 2` to convert byte addresses (as the RISC-V spec defines) to word indices in the Verilog array.

**Two-level ALU decode** — the main control unit generates a 2-bit `ALUOp` hint, and the ALU control module fine-decodes the exact operation using `funct3` and `funct7[30]`. This mirrors real processor design practice.

**Testbench race condition fix** — reset is released at `#12ns` rather than on a clock edge boundary. This ensures the combinational datapath has a clean settling window before the first active clock edge at `#15ns`, eliminating a simulator race condition that caused apparent one-cycle output lag.

---

## How to Simulate

1. Open Xilinx Vivado and create a new RTL project
2. Add all `.v` files as design sources
3. Add `tb_top.v` as a simulation source
4. Set `tb_top` as the simulation top
5. Run Behavioral Simulation
6. Add signals to the waveform: `PC_top`, `instruction_top`, `Rd1_top`, `Rd2_top`, `WriteBack_top`, `address_top`, `ALUOp_top`, `RegWrite_top`
7. Run all and zoom into the first 150ns to verify instruction execution

---

## What I Learned

- How to translate a datapath block diagram directly into Verilog module instantiations
- The difference between synchronous (clocked) and combinational (assign) hardware — and why mixing them carelessly creates timing bugs
- How RISC-V encodes different immediate formats across instruction types and how to reassemble scattered bits in the immediate generator
- How two-level control decode works — main control for instruction type, ALU control for exact operation
- How simulation race conditions can mimic design bugs, and how careful testbench timing prevents them
- How to systematically debug a processor by tracing signals from PC through writeback

---

## References

- Patterson & Hennessy — *Computer Organization and Design: RISC-V Edition* (2nd Ed.)
- [RISC-V ISA Specification](https://riscv.org/technical/specifications/)
- [EDA Playground](https://www.edaplayground.com/) — for quick online Verilog simulation

---

## Author

**Rohan Banik** — 2nd year VLSI student  
Built during summer 2026 as part of a self-directed RTL learning plan.
