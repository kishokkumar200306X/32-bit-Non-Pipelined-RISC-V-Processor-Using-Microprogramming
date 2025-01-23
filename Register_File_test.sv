`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2023 07:49:07 PM
// Design Name: 
// Module Name: Register_File_test
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


module Register_File_test();
    logic clk = 0;
    logic rst;
    logic wrt_en;
    logic [4:0] reg1_addr;
    logic [4:0] reg2_addr;
    logic [4:0] reg_wrt_addr;
    logic [31:0] reg_wrt_data;
    logic [31:0] reg1_data;
    logic [31:0] reg2_data;
    
    // Instantiate the ClockGenerator module
    //ClockGenerator #(10) clk_gen (.clk(clk));
    always #10 clk=~clk;

    // Instantiate the reg_array module, using clk from the ClockGenerator
    Register_File dut(
    .clk(clk), // Use the clk signal from the ClockGenerator module
    .rst(rst),
    .wrt_en(wrt_en),
    .reg1_addr(reg1_addr),
    .reg2_addr(reg2_addr),
    .reg_wrt_addr(reg_wrt_addr),
    .reg_wrt_data(reg_wrt_data),
    .reg1_data(reg1_data),
    .reg2_data(reg2_data)
    );

  initial begin
    rst=1;
    #15;
    rst=0;
    wrt_en = 1;
    reg1_addr = 3;
    reg2_addr = 4;
    reg_wrt_addr = 5; // Write to reg1
    reg_wrt_data = 32'h00000001; // Write 1 to reg1
    #20;
    wrt_en=0;
    #10;
    wrt_en=1;
    reg_wrt_addr=10;
    reg_wrt_data=10;
    #10;
  end

endmodule
