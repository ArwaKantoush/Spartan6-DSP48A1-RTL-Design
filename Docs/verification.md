# Verification & Synthesis Flow

## QuestaSim Simulation
* Driven by automated testbench `Code/Testbench/DSP_tb.v`.
* Verified via DO-script `Code/Script/run.do`.
* Covers directed arithmetic cases, pipeline register latencies, reset cycles, and carry cascade propagation.

## Vivado Implementation Flow
* **Target Board/FPGA:** `xc7a200tffg1156-3`
* **Timing Constraint:** 100 MHz clock frequency defined in `constraints/DSP.xdc`.
* **DRC & Linting:** 0 Critical Warnings, 0 Errors.
