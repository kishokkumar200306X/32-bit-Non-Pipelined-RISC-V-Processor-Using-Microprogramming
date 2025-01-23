`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2023 03:54:37 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic signed [31:0] ALUin1,
    input logic signed [31:0] ALUin2,
    input logic [3:0] operation,
    
    output logic signed [31:0] ALUout,
    output logic zero
    );
    
    always_comb
    begin
        ALUout = 'b0;
        zero = 'b0;
        case(operation)
        4'b0000:        //ADD
            ALUout = ALUin1 + ALUin2;
        4'b0001:        //SUB       
            begin       
                ALUout = ALUin1 - ALUin2;
                zero = (ALUout == 1'd0);
            end
        4'b0010:        //AND
            ALUout = ALUin1 & ALUin2;
        4'b0011:        //OR
            ALUout = ALUin1 | ALUin2;
        4'b0100:        //XOR
            ALUout = ALUin1 ^ ALUin2;
        4'b0101:        //SLL
            ALUout = ALUin1 << $unsigned(ALUin2);
        4'b0110:        //SRL
            ALUout = ALUin1 >> $unsigned(ALUin2);
        4'b0111:        //SRA
            ALUout = $signed(ALUin1) >>> ALUin2;
        4'b1000:        //SLT
            ALUout = ALUin1 < ALUin2;
        4'b1001:        //SLTU
            ALUout = $unsigned(ALUin1) < $unsigned(ALUin2);
        4'b1010:        //MUL
            ALUout = $unsigned(ALUin1) * $unsigned(ALUin2);
        default: 
            ALUout = 'b0;
        endcase
    end
endmodule
