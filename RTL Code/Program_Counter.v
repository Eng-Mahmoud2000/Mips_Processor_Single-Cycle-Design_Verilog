module Program_Counter(PC1,PC2,clk,rst);
input [31:0] PC1;
input clk,rst;
output reg [31:0] PC2;
always @(posedge clk or negedge rst) begin
if (!rst) PC2<=32'b0;
else PC2<=PC1; 
end  
endmodule