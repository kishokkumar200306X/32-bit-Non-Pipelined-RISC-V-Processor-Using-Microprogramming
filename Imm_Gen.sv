`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2023 10:33:47 PM
// Design Name: 
// Module Name: Imm_Gen
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


module Imm_Gen(
    input logic [31:0] instruction,
    output logic [31:0] Immout
    );

    logic [4:0] shamt;
    assign shamt = instruction[24:20];

always_comb
    case(instruction[6:0])
        7'b0000011 /*I-type load*/     : 
            Immout = {instruction[31]? {20{1'b1}}:20'b0 , instruction[31:20]};
        7'b0010011 /*I-type arithmatic*/     :
            begin 
            if((instruction[14:12]==3'b101) || (instruction[14:12]==3'b001) || instruction[14:12]==3'b101)
                Immout = {shamt[4]? {27{1'b1}}:27'b0,shamt};
            else
                Immout = {instruction[31]? {20{1'b1}}:20'b0 , instruction[31:20]};
            end
        7'b0100011 /*S-type*/    : 
            Immout = {instruction[31]? {20{1'b1}}:20'b0 , instruction[31:25], instruction[11:7]};
        7'b1100011 /*B-type*/    : 
            Immout = {instruction[31]? {20{1'b1}}:20'b0 , instruction[7], instruction[30:25],instruction[11:8],1'b0};
        7'b1100111 /*JALR*/    : 
            Immout = {instruction[31]? {20{1'b1}}:20'b0 , instruction[30:25], instruction[24:21], instruction[20]};
        default                    : 
            Immout = {32'b0};
    endcase
    
endmodule
