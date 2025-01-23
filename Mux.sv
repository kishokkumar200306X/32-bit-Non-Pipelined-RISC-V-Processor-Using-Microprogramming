`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2023 08:23:35 PM
// Design Name: 
// Module Name: Mux
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


module Mux(
    input logic signed [31:0] mux_in1,
    input logic signed [31:0] mux_in2,
    input logic sel,
    output logic signed [31:0] mux_out
    );

    always_comb 
    begin
        unique case(sel)
            1'b0:
                mux_out <= mux_in1;
            1'b1:
                mux_out <= mux_in2;
        endcase
    end
endmodule
