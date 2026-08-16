# DSP48A1 Architecture & Operational Modes

## Data Concatenation
When `OPMODE[1:0] = 2'b11`, the 48-bit $X$ input is formed by concatenating:
$$\{D[11:0], A[17:0], B[17:0]\}$$

## OPMODE Control Reference

| Field | Description | Decoding |
| :--- | :--- | :--- |
| `OPMODE[1:0]` | **X Multiplexer Select** | `00`: 0<br>`01`: $\{12'b0, M[35:0]\}$<br>`10`: $P$ (Feedback)<br>`11`: $\{D[11:0], A[17:0], B[17:0]\}$ |
| `OPMODE[3:2]` | **Z Multiplexer Select** | `00`: 0<br>`01`: `PCIN`<br>`10`: $P$ (Feedback)<br>`11`: $C$ Port |
| `OPMODE[4]` | **Pre-Adder Bypass** | `0`: Bypass pre-adder (use $B$)<br>`1`: Select pre-adder output |
| `OPMODE[5]` | **Forced Carry-In** | Value used as CIN when `CARRYINSEL = "OPMODE5"` |
| `OPMODE[6]` | **Pre-Adder Operation** | `0`: $D + B$<br>`1`: $D - B$ |
| `OPMODE[7]` | **Post-Adder Operation** | `0`: $Z + X + \text{CIN}$<br>`1`: $Z - (X + \text{CIN})$ |
