`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2023 04:20:11 PM
// Design Name: 
// Module Name: ALU_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_test();

logic [31:0] ALUin1;
logic [31:0] ALUin2;
logic [31:0] ALUout;
logic [3:0] operation;
logic zero;

ALU ALU_blk(.ALUin1(ALUin1),.ALUin2(ALUin2),.ALUout(ALUout),.operation(operation),.zero(zero));

initial begin
ALUin1 = -2;
ALUin2 = -3;
operation = 'b1010;
end

endmodule
