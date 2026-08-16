# DSP Top Module (`DSP.v`)

## Description
Top-level RTL implementation of the Spartan-6 DSP48A1 slice containing:
1. **Pre-Adder / Subtractor:** Controlled via `OPMODE[6]` and `OPMODE[4]`.
2. **18x18 Multiplier:** Computes 36-bit product $A \times B$ or $A \times (D \pm B)$.
3. **48-bit Post-Adder / Subtractor:** Dynamically driven by `OPMODE[7]` and multiplexers $X$ & $Z$.
4. **Cascading Ports:** Dedicated cascade routing (`BCIN`/`BCOUT` and `PCIN`/`PCOUT`).

## Configuration Attributes
* `A0REG`, `A1REG`, `B0REG`, `B1REG`: Pipeline stages for A and B paths.
* `CREG`, `DREG`, `MREG`, `PREG`: Pipeline registers for C, D, Multiplier, and P outputs.
* `CARRYINREG`, `CARRYOUTREG`, `OPMODEREG`: Registers for control and carry logic.
* `CARRYINSEL`: Selects between `OPMODE5` and direct `CARRYIN`.
* `B_INPUT`: Selects between `"DIRECT"` and `"CASCADE"`.
* `RSTTYPE`: Selects `"SYNC"` or `"ASYNC"` reset behavior.
