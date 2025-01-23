`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2023 10:28:51 AM
// Design Name: 
// Module Name: Program_Counter
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


module Program_Counter(
    input logic rst,
    input logic clk,
    input logic [31:0] pc_in,
    output logic [31:0] pc_out);
    
    always_ff @(posedge clk or posedge rst)
    begin
    if (rst)
        pc_out <= 'b0;
    else
        pc_out <= pc_in;
    end
    
endmodule
