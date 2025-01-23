`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2023 12:55:32 AM
// Design Name: 
// Module Name: Branch_Predictor
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


module Branch_Predictor(

    input logic isZero,
    input logic branchSignal,
    input logic lastBit,
    input logic [1:0] branch_type,
    output logic muxOutput
    );

    always_comb 
    begin
        case(branch_type)
            2'b00: muxOutput <= (branchSignal & isZero); // Branch Equal, JALR
            2'b01: muxOutput <= (branchSignal & !isZero); // Branch Not Equal
            2'b10: muxOutput <= (branchSignal & lastBit); // Branch Less Than, Less Than Unsigned
            2'b11: muxOutput <= (branchSignal & !lastBit); // Branch Greater Than, Greater Than Unsigned
            default: muxOutput <= 'b0;
        endcase
    end

endmodule
