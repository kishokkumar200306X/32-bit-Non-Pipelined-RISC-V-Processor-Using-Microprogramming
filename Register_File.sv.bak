`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2023 06:38:40 PM
// Design Name: 
// Module Name: RegisterFile
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


module Register_File(
   input  clk,
   input  rst,
   input  wrt_en,
   input logic [4:0] reg1_addr,
   input logic [4:0] reg2_addr,
   input logic [4:0] reg_wrt_addr,
   input logic [31:0] reg_wrt_data,
         
   output logic [31:0] reg1_data,
   output logic [31:0] reg2_data
   );

    logic [31:0] register [31:0];

    assign register[0]=32'b00000000_00000000_00000000_00000000;

    always_ff @(posedge clk)
    begin
        if(rst) 
        begin
            for (int i=1; i<32; i+=1)
            begin
                register[i] <= 32'b0;
            end
        end
        else if(wrt_en && (reg_wrt_addr!=(5'b00000))) 
        begin
            register[reg_wrt_addr] <= reg_wrt_data;
        end
    end
 
    assign reg1_data = register[reg1_addr];
    assign reg2_data = register[reg2_addr];

endmodule
