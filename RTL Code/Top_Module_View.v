module Top_Module_View (
    input Clk,Reset,
    output  [15:0] test
    );
// Interconnections
wire   MemWrite;
wire  [31:0] PC;
wire  [31:0] ALUOut;
wire  [31:0] WriteData;
wire  [31:0] ReadData;
wire  [31:0] Instr;

//Instantiate Instruction_Memory Unit
Instruction_Memory U_IM (
 .PC(PC),
 .RD(Instr)
 );

//Instantiate Data_Memory Unit
Data_Memory U_DM (
 .A   (ALUOut),
 .WD  (WriteData),
 .WE  (MemWrite),
 .RD  (ReadData),
 .clk (Clk),
 .rst (Reset),
 .tst (test)
 );

//Instantiate Mips_processor Module
Mips_processor U_mp (
.clk(Clk),
.reset(Reset),
.ReadData(ReadData),
.Instr(Instr),
.PC(PC),
.ALUOut(ALUOut),
.WriteData(WriteData),
.MemWrite(MemWrite)
 );

endmodule