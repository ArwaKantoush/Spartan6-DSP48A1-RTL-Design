module DSP_REG #(
    parameter WIDTH = 18,
    parameter REG = 1,
    parameter  RSTTYPE = "SYNC"
) (
    input CLK,
    input rst,
    input ce,
    input [WIDTH-1:0]in,
    output reg [WIDTH-1:0]out
);


generate
    if (REG && RSTTYPE == "SYNC") begin : GEN_SYNC
        always @(posedge CLK) begin
            if (rst) begin
                out <= 0;
            end
            else if (ce) begin
                out <= in;
            end
        end
    end
    else if (REG && RSTTYPE == "ASYNC") begin : GEN_ASYNC
        always @(posedge CLK or posedge rst) begin
            if (rst) begin
                out <= 0;
            end
            else if (ce) begin
                out <= in;
            end
        end
    end
    else begin : GEN_BYPASS
        always @(*) begin
            out = in;
        end
    end
endgenerate

endmodule //DSP_reg
