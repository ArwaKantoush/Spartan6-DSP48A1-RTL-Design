module DSP_tb ();
parameter WIDTH_18 = 18;
parameter WIDTH_48 = 48;
parameter A0REG = 0;
parameter A1REG = 1;
parameter B0REG = 0;
parameter B1REG = 1;
parameter CREG = 1;
parameter DREG = 1;
parameter MREG = 1;
parameter PREG = 1;
parameter CARRYINREG = 1;
parameter CARRYOUTREG = 1;
parameter OPMODEREG = 1;
parameter CARRYINSEL = "OPMODE5";
parameter B_INPUT = "DIRECT";
parameter RSTTYPE = "SYNC";

reg CLK;
reg [7:0]OPMODE;
reg CEA;
reg CEB;
reg CEC;
reg CECARRYIN;
reg CED;
reg CEM;
reg CEOPMODE;
reg CEP;
reg RSTA;
reg RSTB;
reg RSTC;
reg RSTCARRYIN;
reg RSTD;
reg RSTM;
reg RSTOPMODE;
reg RSTP;
reg [WIDTH_18-1:0]A;
reg [WIDTH_18-1:0]B;
reg [WIDTH_18-1:0]BCIN;
reg [WIDTH_48-1:0]C;
reg [WIDTH_18-1:0]D;
reg CARRYIN;
reg [WIDTH_48-1:0]PCIN;
wire [35:0]M;
wire [WIDTH_48-1:0]P;
wire CARRYOUT;
wire CARRYOUTF;
wire [WIDTH_18-1:0]BCOUT;
wire [WIDTH_48-1:0]PCOUT;
reg [35:0]M_exp;
reg [WIDTH_48-1:0]P_exp;
reg CARRYOUT_exp;
reg CARRYOUTF_exp;
reg [WIDTH_18-1:0]BCOUT_exp;
reg [WIDTH_48-1:0]PCOUT_exp;

DSP #(
    .WIDTH_18(WIDTH_18),
    .WIDTH_48(WIDTH_48),
    .A0REG(A0REG),
    .A1REG(A1REG),
    .B0REG(B0REG),
    .B1REG(B1REG),
    .CREG(CREG),
    .DREG(DREG),
    .MREG(MREG),
    .PREG(PREG),
    .CARRYINREG(CARRYINREG),
    .CARRYOUTREG(CARRYOUTREG),
    .OPMODEREG(OPMODEREG),
    .CARRYINSEL(CARRYINSEL),
    .B_INPUT(B_INPUT),
    .RSTTYPE(RSTTYPE)
) dut (
    .CLK(CLK),
    .OPMODE(OPMODE),
    .CEA(CEA),
    .CEB(CEB),
    .CEC(CEC),
    .CECARRYIN(CECARRYIN),
    .CED(CED),
    .CEM(CEM),
    .CEOPMODE(CEOPMODE),
    .CEP(CEP),
    .RSTA(RSTA),
    .RSTB(RSTB),
    .RSTC(RSTC),
    .RSTCARRYIN(RSTCARRYIN),
    .RSTD(RSTD),
    .RSTM(RSTM),
    .RSTOPMODE(RSTOPMODE),
    .RSTP(RSTP),
    .A(A),
    .B(B),
    .BCIN(BCIN),
    .C(C),
    .D(D),
    .CARRYIN(CARRYIN),
    .PCIN(PCIN),
    .M(M),
    .P(P),
    .CARRYOUT(CARRYOUT),
    .CARRYOUTF(CARRYOUTF),
    .BCOUT(BCOUT),
    .PCOUT(PCOUT)
);

initial begin
    CLK = 1;
    forever begin
        #1 CLK = ~CLK;
    end
end

initial begin
    //1
    RSTA = 1; RSTB = 1; RSTC = 1; RSTCARRYIN = 1; RSTD = 1; RSTM = 1; RSTOPMODE = 1; RSTP = 1;
    CEA = $random; CEB = $random; CEC = $random; CECARRYIN = $random; CED = $random; CEM = $random; CEOPMODE = $random; CEP = $random;
    A = $random; B = $random; BCIN = $random; C = $random; D = $random; OPMODE = $random; CARRYIN = $random; PCIN = $random;
    M_exp = 0; P_exp = 0; CARRYOUT_exp = 0; CARRYOUTF_exp = 0; BCOUT_exp = 0; PCOUT_exp = 0;
    @(negedge CLK);
    if (M!==M_exp || P!==P_exp || CARRYOUT!==CARRYOUT_exp || CARRYOUTF!==CARRYOUTF_exp || BCOUT!==BCOUT_exp || PCOUT!==PCOUT_exp) begin
        $display("ERROR!");
        $stop;
    end
    //2
    RSTA = 0; RSTB = 0; RSTC = 0; RSTCARRYIN = 0; RSTD = 0; RSTM = 0; RSTOPMODE = 0; RSTP = 0;
    CEA = 1; CEB = 1; CEC = 1; CECARRYIN = 1; CED = 1; CEM = 1; CEOPMODE = 1; CEP = 1;
    A = 20; B = 10; BCIN = $random; C = 350; D = 25; OPMODE = 8'b11011101; CARRYIN = $random; PCIN = $random;
    M_exp = 'h12c; P_exp = 'h32; CARRYOUT_exp = 0; CARRYOUTF_exp = 0; BCOUT_exp = 'hf; PCOUT_exp = 'h32;
    repeat(4) @(negedge CLK);
    if (M!==M_exp || P!==P_exp || CARRYOUT!==CARRYOUT_exp || CARRYOUTF!==CARRYOUTF_exp || BCOUT!==BCOUT_exp || PCOUT!==PCOUT_exp) begin
        $display("ERROR!");
        $stop;
    end
    //3
    OPMODE = 8'b00010000;
    M_exp = 'h2bc; P_exp = 'h0; CARRYOUT_exp = 0; CARRYOUTF_exp = 0; BCOUT_exp = 'h23; PCOUT_exp = 'h0;
    repeat(3) @(negedge CLK);
    if (M!==M_exp || P!==P_exp || CARRYOUT!==CARRYOUT_exp || CARRYOUTF!==CARRYOUTF_exp || BCOUT!==BCOUT_exp || PCOUT!==PCOUT_exp) begin
        $display("ERROR!");
        $stop;
    end
    //4
    OPMODE = 8'b00001010;
    M_exp = 'hc8; P_exp = 'h0; CARRYOUT_exp = 0; CARRYOUTF_exp = 0; BCOUT_exp = 'ha; PCOUT_exp = 'h0;
    repeat(3) @(negedge CLK);
    if (M!==M_exp || P!==P_exp || CARRYOUT!==CARRYOUT_exp || CARRYOUTF!==CARRYOUTF_exp || BCOUT!==BCOUT_exp || PCOUT!==PCOUT_exp) begin
        $display("ERROR!");
        $stop;
    end
    //5
    A = 5; B = 6; C = 350; D = 25; PCIN = 3000;
    OPMODE = 8'b10100111;
    M_exp = 'h1e; P_exp = 'hfe6fffec0bb1; CARRYOUT_exp = 1; CARRYOUTF_exp = 1; BCOUT_exp = 'h6; PCOUT_exp = 'hfe6fffec0bb1;
    repeat(3) @(negedge CLK);
    if (M!==M_exp || P!==P_exp || CARRYOUT!==CARRYOUT_exp || CARRYOUTF!==CARRYOUTF_exp || BCOUT!==BCOUT_exp || PCOUT!==PCOUT_exp) begin
        $display("ERROR!");
        $stop;
    end
    $stop;
end

initial begin
    $monitor("M=%h,M_exp=%h,P=%h,P_exp=%h,PCOUT=%h,PCOUT_exp=%h,CARRYOUT=%h,CARRYOUT_exp=%h,CARRYOUTF=%h,CARRYOUTF_exp=%h,BCOUT=%h,BCOUT_exp=%h",M,M_exp,P,P_exp,PCOUT,PCOUT_exp,CARRYOUT,CARRYOUT_exp,CARRYOUTF,CARRYOUTF_exp,BCOUT,BCOUT_exp);
end
endmodule //DSP_tb
