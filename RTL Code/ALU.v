module alu (A,B,Op, alu_out,zero_flag);
input[2:0]Op;
input[31:0] A,B;
output reg zero_flag;
output reg [31:0] alu_out;
always @(*) begin
    case (Op)
        3'b000:  alu_out = A & B;
        3'b001:  alu_out = A | B;
        3'b010:  alu_out = A + B;
        3'b011: $display("Not Used");
        3'b100:  alu_out = A - B ;
        3'b101:  alu_out = A * B;
        3'b110: alu_out = (A<B);
        3'b111: $display("Not Used");
        default:  alu_out =31'b0; 
    endcase
         zero_flag = ~|(alu_out); 
end 
endmodule