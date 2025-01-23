`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2023 10:43:41 PM
// Design Name: 
// Module Name: Datapath_tb
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


module Datapath_tb();

//logic [pc_width-1:0]pc_in;
logic clk=1'b0;
logic rst;
logic [3:0] in;
logic [3:0] out;

always #10 clk=~clk;

Datapath dut(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
);

initial begin
    rst=1;
    
    #15;
   
    rst=0;
    in = 1;

   #20;
    
   #3000;
    
end

endmodule
