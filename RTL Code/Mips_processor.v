module Mips_processor (
    input clk,reset,
    input [31:0] ReadData,Instr,
    output [31:0] PC,ALUOut,WriteData,
    output MemWrite
);
// Internal Connections
wire Jump;
wire RegWrite;
wire RegDst;
wire ALUSrc;
wire MemtoReg;
wire PCSrc;
wire [2:0] ALUControl;
wire Zero;
//Instantiate Data Path Module
data_path U_DP (
 .jump        (Jump),
 .regwrite    (RegWrite),
 .regdest     (RegDst),
 .alusrc      (ALUSrc),
 .memtoreg    (MemtoReg),
 .pcsrc       (PCSrc),
 .CLK         (clk),
 .Reset       (reset),
 .ReadData   (ReadData),
 .Instr       (Instr),
 .alu_control (ALUControl),
 .zero        (Zero),
 .PC          (PC),
 .WriteData   (WriteData),
 .Aluout      (ALUOut)
 );

 //Instantiate Control Unit Module
 Control_unit U_CU (
 .opcode_cu  (Instr[31:26]),
 .funct_cu   (Instr[5:0]),
 .zero        (Zero),
 .ALUControl  (ALUControl),
 .jump        (Jump),
 .memwrite    (MemWrite),
 .regwrite    (RegWrite),
 .regdest     (RegDst),
 .alusrc      (ALUSrc),
 .memtoreg    (MemtoReg),
 .pcsrc       (PCSrc) 
 );
endmodule