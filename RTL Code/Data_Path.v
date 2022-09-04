module data_path (
    input jump,regwrite,regdest,alusrc,memtoreg,pcsrc,CLK,Reset,
    input [31:0] ReadData,Instr,
    input [2:0] alu_control,
    output zero,
    output  [31:0] PC,
    output  [31:0]  WriteData,
    output  [31:0] Aluout
);
// Internal Connections
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] SrcB;
wire [31:0] SignImm;
wire [31:0] Result;
wire [31:0] PCPlus;
wire [31:0] PCBranch;
wire [31:0] mux1out;
wire [31:0] pcjump;
wire [31:0] pc1;
wire [31:0] shiftleftoutImm;
wire [4:0] WriteReg;
wire [27:0] shiftleftout;
assign WriteData=RD2;
assign shiftleftout={Instr[25:0],2'b00};
assign pcjump={PCPlus[31:28],shiftleftout};

//Instantiate Register File Unit
 Register_File U_regfile (
 .A1(Instr[25:21]),
 .A2(Instr[20:16]),
 .A3(WriteReg),
 .WD(Result),
 .WE(regwrite),
 .RD1(RD1),
 .RD2(RD2),
 .clk(CLK),
 .rst(Reset));


//Instantiate ALU Unit
 alu U_alu (
.A(RD1),
.B(SrcB),
.Op(alu_control),
.alu_out(Aluout),
.zero_flag(zero));

//Instantiate Program_Counter Unit
Program_Counter U_pc(
.PC1(pc1),
.PC2(PC),
.clk(CLK),
.rst(Reset));

//Instantiate ALU_Mux Unit
MUX Alu_mux(
.in1(RD2),
.in2(SignImm),
.sel(alusrc),
.out(SrcB));

//Instantiate Register_Mux Unit
MUX #(.width(5))Reg_mux(
.in1(Instr[20:16]),
.in2(Instr[15:11]),
.sel(regdest),
.out(WriteReg));


//Instantiate Memory_Mux Unit
MUX Memory_mux(
.in1(Aluout),
.in2(ReadData),
.sel(memtoreg),
.out(Result));

//Instantiate PC_Mux1 Unit
MUX PC_mux1(
.in1(PCPlus),
.in2(PCBranch),
.sel(pcsrc),
.out(mux1out));

//Instantiate PC_Mux2 Unit
MUX PC_mux2(
.in1(mux1out),
.in2(pcjump),
.sel(jump),
.out(pc1));



//Instantiate Adder Unit
 Adder PC_branch (
.A(shiftleftoutImm),
.B(PCPlus),
.C(PCBranch));


//Instantiate Adder Unit
 Adder PC_plus (
.A(PC),
.B(32'd4),
.C(PCPlus));

//Instantiate SignExtend Unit
signExtend U_signextend(
.inst(Instr[15:0]),
.Signlmm(SignImm));


//Instantiate Shiftlefttwice Unit
shiftlefttwice #(.width(32))shift_signextend(
.in(SignImm),
.out(shiftleftoutImm));

endmodule