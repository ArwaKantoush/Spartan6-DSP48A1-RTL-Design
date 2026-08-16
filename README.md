# Spartan-6 DSP48A1 Slice RTL Design & Verification

![Verilog](https://img.shields.io/badge/Language-Verilog-blue.svg)
![EDA Tools](https://img.shields.io/badge/EDA-QuestaSim%20%7C%20Vivado-red.svg)
![FPGA Target](https://img.shields.io/badge/Target-Xilinx%20Artix--7%20xc7a200t-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📌 Overview
This project presents a fully parameterized RTL implementation of the **Spartan-6 DSP48A1** slice in Verilog HDL. The DSP48A1 is a high-performance arithmetic block capable of performing wide multiply, multiply-accumulate (MAC), pre-add/subtract, and post-add/subtract operations optimized for digital signal processing algorithms.

---

## 🏗️ Architecture & Features

The design supports dynamic configuration via dynamic control pins (`OPMODE`) and static configuration via synthesis-time parameters:

- **18-bit Pre-Adder / Subtractor:** Supports operations like $D \pm B$ prior to multiplication.
- **18x18 Multiplier:** Produces a 36-bit product.
- **48-bit Post-Adder / Subtractor / Accumulator:** Supports wide dynamic additions/subtractions.
- **Flexible Pipelining:** Configurable input, intermediate, and output pipeline register stages ($A0, A1, B0, B1, C, D, M, P, \text{CYI}, \text{CYO}$).
- **Reset Configuration:** Supports selectable synchronous (`SYNC`) or asynchronous (`ASYNC`) active-high resets.
- **Cascading Support:** Dedicated 18-bit `BCIN`/`BCOUT` and 48-bit `PCIN`/`PCOUT` cascade routes for cascading multiple DSP slices.

---

## ⚙️ Parameters (Generics)

| Parameter | Default | Allowed Values | Description |
| :--- | :---: | :---: | :--- |
| `WIDTH_18` | `18` | Integer | Width of ports A, B, D, BCIN, BCOUT |
| `WIDTH_48` | `48` | Integer | Width of ports C, PCIN, PCOUT, P |
| `A0REG` | `0` | `0`, `1` | Pipeline stages for port A |
| `A1REG` | `1` | `0`, `1` | Pipeline stages for port A |
| `B0REG` | `0` | `0`, `1` | Pipeline stages for port B |
| `B1REG` | `1` | `0`, `1` | Pipeline stages for port B |
| `CREG`, `DREG`, `MREG`, `PREG` | `1` | `0`, `1` | Pipeline registers for C, D, Multiplier, and P |
| `CARRYINREG`, `CARRYOUTREG` | `1` | `0`, `1` | Pipeline registers for carry input/output |
| `OPMODEREG` | `1` | `0`, `1` | Pipeline register for OPMODE control vector |
| `CARRYINSEL` | `"OPMODE5"` | `"OPMODE5"`, `"CARRYIN"` | Carry input multiplexer select |
| `B_INPUT` | `"DIRECT"` | `"DIRECT"`, `"CASCADE"` | Selects B direct input vs BCIN cascade |
| `RSTTYPE` | `"SYNC"` | `"SYNC"`, `"ASYNC"` | Reset behavior mode |

---

## 🗂️ OPMODE Truth Table Reference

| Bits | Functionality |
| :--- | :--- |
| `OPMODE[1:0]` | **X Mux Select:** `00` (Zero), `01` (Multiplier Output M), `10` (P Accumulator), `11` (Concatenated $\{D[11:0], A[17:0], B[17:0]\}$) |
| `OPMODE[3:2]` | **Z Mux Select:** `00` (Zero), `01` (PCIN), `10` (P Accumulator), `11` (Port C) |
| `OPMODE[4]` | **Pre-Adder Bypass:** `0` (Bypass, use B), `1` (Use Pre-Adder Output) |
| `OPMODE[5]` | **Forced Carry-In:** Carried when `CARRYINSEL = "OPMODE5"` |
| `OPMODE[6]` | **Pre-Adder Operation:** `0` (Addition: $D + B$), `1` (Subtraction: $D - B$) |
| `OPMODE[7]` | **Post-Adder Operation:** `0` (Addition: $Z + X + \text{CIN}$), `1` (Subtraction: Z - (X + CIN) |

---

## 📁 Repository Structure

```text
├── Code/
│   ├── RTL/
│   │   ├── DSP.v              # Top-level DSP48A1 core module
│   │   └── DSP_REG.v          # Configurable pipeline register module
│   ├── Script/
│   │   └── run.do             # QuestaSim automation script
│   └── Testbench/
│       └── DSP_tb.v           # Self-checking verification testbench
├── constraints/
│   └── DSP.xdc                # Vivado timing constraints (100 MHz clock)
├── Docs/
│   ├── DSP.md                 # Detailed top module port & parameter specifications
│   ├── DSP_REG.md             # Register module specifications
│   ├── architecture.md        # DSP architecture and OPMODE mapping
│   └── verification.md        # Simulation test plan & implementation results
├── .gitignore
└── README.md
```

## 🧪 Simulation & Verification

The design was verified using a self-checking testbench on Mentor Graphics QuestaSim covering corner cases, arithmetic operations, pipelined timing, and resets.

### Running Simulation via QuestaSim:

Bash
```

vsim -do tb/run.do

```

## 🛠️ Synthesis & Implementation Results

Tool: AMD Xilinx Vivado Design Suite
Target Device: xc7a200tffg1156-3
Clock Frequency: $100\text{ MHz}$ ($T = 10.0\text{ ns}$)
Timing Slack: Setup & Hold slack met with $0$ failing endpoints.
DRC / Linting: Passed with 0 Critical Warnings and 0 Errors.

## 👤 Author

Arwa Ashraf Kantoush
