# Parameterized Register Module (`DSP_REG.v`)

## Description
A generic register module designed to support optional pipelining and configurable reset behavior across the DSP48A1 slice.

## Parameters
* `WIDTH`: Bit-width of the data bus (Default: `18`).
* `REG`: Pipeline control (`1`: Register enabled, `0`: Direct bypass via combinatorial logic).
* `RSTTYPE`: Reset style (`"SYNC"` for synchronous reset, `"ASYNC"` for asynchronous reset).

## Ports
* `CLK`: System clock input.
* `rst`: Active-high reset signal.
* `ce`: Active-high clock enable.
* `in`: Data input `[WIDTH-1:0]`.
* `out`: Data output `[WIDTH-1:0]`.
