module Control_unit (
    input  [5:0] opcode_cu,funct_cu,
    input zero,
    output[2:0] ALUControl,
    output jump,memwrite,regwrite,regdest,alusrc,memtoreg,pcsrc
);
// Internal Connections
wire branch;
wire [1:0]ALUOp;
assign pcsrc= zero & branch;
main_decoder U_maindecoder(
.opcode(opcode_cu),
.alu_op(ALUOp),
.jump(jump),
.memwrite(memwrite),
.regwrite(regwrite),
.regdest(regdest),
.alusrc(alusrc),
.memtoreg(memtoreg),
.branch(branch)
);
alu_decoder U_aludecoder (
.alu_op(ALUOp),
.funct(funct_cu),
.alu_control(ALUControl)
);
endmodule