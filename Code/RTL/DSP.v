module DSP #(
    parameter WIDTH_18 = 18,
    parameter WIDTH_48 = 48,
    parameter A0REG = 0,
    parameter A1REG = 1,
    parameter B0REG = 0,
    parameter B1REG = 1,
    parameter CREG = 1,
    parameter DREG = 1,
    parameter MREG = 1,
    parameter PREG = 1,
    parameter CARRYINREG = 1,
    parameter CARRYOUTREG = 1,
    parameter OPMODEREG = 1,
    parameter CARRYINSEL = "OPMODE5",
    parameter B_INPUT = "DIRECT",
    parameter  RSTTYPE = "SYNC"
) (
    input CLK,
    input [7:0]OPMODE,
    input CEA,
    input CEB,
    input CEC,
    input CECARRYIN,
    input CED,
    input CEM,
    input CEOPMODE,
    input CEP,
    input RSTA,
    input RSTB,
    input RSTC,
    input RSTCARRYIN,
    input RSTD,
    input RSTM,
    input RSTOPMODE,
    input RSTP,
    input [WIDTH_18-1:0]A,
    input [WIDTH_18-1:0]B,
    input [WIDTH_18-1:0]BCIN,
    input [WIDTH_48-1:0]C,
    input [WIDTH_18-1:0]D,
    input CARRYIN,
    input [WIDTH_48-1:0]PCIN,
    output [35:0]M,
    output [WIDTH_48-1:0]P,
    output CARRYOUT,
    output CARRYOUTF,
    output [WIDTH_18-1:0]BCOUT,
    output [WIDTH_48-1:0]PCOUT
);

wire [WIDTH_18-1:0]A0_REG,A1_REG,B_SEL,B0_REG,B1_REG,D_REG,SUM1,SUM1_SEL;
wire [35:0]MUL,M_REG;
wire [WIDTH_48-1:0]C_REG;
wire [WIDTH_48:0]P_REG;
reg [WIDTH_48-1:0]SEL_X,SEL_Z;
wire CYI_SEL,CYI;
wire [7:0]OPMODE_REG;

DSP_REG #(.WIDTH(8),.REG(OPMODEREG),.RSTTYPE(RSTTYPE)) dutOPMODE (.CLK(CLK),.rst(RSTOPMODE),.ce(CEOPMODE),.in(OPMODE),.out(OPMODE_REG));
DSP_REG #(.WIDTH(WIDTH_18),.REG(DREG),.RSTTYPE(RSTTYPE)) dutD (.CLK(CLK),.rst(RSTD),.ce(CED),.in(D),.out(D_REG));

generate
    if (B_INPUT == "DIRECT") begin : GEN_B_DIRECT
        assign B_SEL = B;
    end
    else if (B_INPUT == "CASCADE") begin : GEN_B_CASCADE
        assign B_SEL = BCIN;
    end
    else begin : GEN_B_ZERO
        assign B_SEL = 18'b0;
    end
endgenerate

DSP_REG #(.WIDTH(WIDTH_18),.REG(B0REG),.RSTTYPE(RSTTYPE)) dutB0 (.CLK(CLK),.rst(RSTB),.ce(CEB),.in(B_SEL),.out(B0_REG));
assign SUM1 = (OPMODE_REG[6] == 1'b0)? (D_REG + B0_REG) : (D_REG - B0_REG);
assign SUM1_SEL = (OPMODE_REG[4] == 1'b0)? B0_REG : SUM1;
DSP_REG #(.WIDTH(WIDTH_18),.REG(B1REG),.RSTTYPE(RSTTYPE)) dutB1 (.CLK(CLK),.rst(RSTB),.ce(CEB),.in(SUM1_SEL),.out(B1_REG));
DSP_REG #(.WIDTH(WIDTH_18),.REG(A0REG),.RSTTYPE(RSTTYPE)) dutA0 (.CLK(CLK),.rst(RSTA),.ce(CEA),.in(A),.out(A0_REG));
DSP_REG #(.WIDTH(WIDTH_18),.REG(A1REG),.RSTTYPE(RSTTYPE)) dutA1 (.CLK(CLK),.rst(RSTA),.ce(CEA),.in(A0_REG),.out(A1_REG));
assign MUL = B1_REG * A1_REG;
DSP_REG #(.WIDTH(36),.REG(MREG),.RSTTYPE(RSTTYPE)) dutM (.CLK(CLK),.rst(RSTM),.ce(CEM),.in(MUL),.out(M_REG));
always @(*) begin
    case (OPMODE_REG[1:0])
        2'b00: SEL_X = 0;
        2'b01: SEL_X = {12'b0,M_REG};
        2'b10: SEL_X = P;
        2'b11: SEL_X = {D_REG[11:0],A1_REG[17:0],B1_REG[17:0]};
        default : SEL_X = 48'b0;
    endcase
end
DSP_REG #(.WIDTH(WIDTH_48),.REG(CREG),.RSTTYPE(RSTTYPE)) dutC (.CLK(CLK),.rst(RSTC),.ce(CEC),.in(C),.out(C_REG));
always @(*) begin
    case (OPMODE_REG[3:2])
        2'b00: SEL_Z = 0;
        2'b01: SEL_Z = PCIN;
        2'b10: SEL_Z = P;
        2'b11: SEL_Z = C_REG;
        default : SEL_Z = 48'b0;
    endcase
end
generate
    if (CARRYINSEL == "OPMODE5") begin : GEN_CYI_OPMODE5
        assign CYI_SEL = OPMODE_REG[5];
    end
    else if (CARRYINSEL == "CARRYIN") begin : GEN_CYI_CARRYIN
        assign CYI_SEL = CARRYIN;
    end
    else begin : GEN_CYI_ZERO
        assign CYI_SEL = 1'b0;
    end
endgenerate
DSP_REG #(.WIDTH(1),.REG(CARRYINREG),.RSTTYPE(RSTTYPE)) dutCYI (.CLK(CLK),.rst(RSTCARRYIN),.ce(CECARRYIN),.in(CYI_SEL),.out(CYI));
assign P_REG = (OPMODE_REG[7] == 1'b0)? (SEL_Z + SEL_X + CYI) : (SEL_Z - (SEL_X + CYI));
DSP_REG #(.WIDTH(WIDTH_48),.REG(PREG),.RSTTYPE(RSTTYPE)) dutP (.CLK(CLK),.rst(RSTP),.ce(CEP),.in(P_REG[WIDTH_48-1:0]),.out(P));
DSP_REG #(.WIDTH(1),.REG(CARRYOUTREG),.RSTTYPE(RSTTYPE)) dutCYO (.CLK(CLK),.rst(RSTCARRYIN),.ce(CECARRYIN),.in(P_REG[WIDTH_48]),.out(CARRYOUT));
assign CARRYOUTF = CARRYOUT;
assign M = M_REG;
assign BCOUT = B1_REG;
assign PCOUT = P;

endmodule //DSP
