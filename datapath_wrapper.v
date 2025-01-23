`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2023 02:41:47 PM
// Design Name: 
// Module Name: datapath_wrapper
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


module datapath_wrapper#(parameter pc_width = 32)(
    input wire clk, rst,
    input wire [3:0] in,
    output wire [3:0] out
);

    wire [31:0] ALU_result;
    
    Datapath #(pc_width) uut(
    .clk(clk),
    .rst(rst),
    .ALU_result(ALU_result),
    .in(in),
    .out(out)
    );

    

endmodule

