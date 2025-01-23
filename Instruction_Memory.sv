`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 06:31:54 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory#(parameter inst_addr_width=9)(
    input logic [31:0] pc,
    output logic [31:0] instruction
    );
    
    logic [31:0] Inst_mem [2**(inst_addr_width)-1:0];
             
    assign Inst_mem[0]   = 32'h00007033;//      and  r0,r0,r0           ALUResult = h0 = r0          
    assign Inst_mem[1]   = 32'h00100093;//      addi r1,r0, 1           ALUResult = h1 = r1
    assign Inst_mem[2]   = 32'h00200113;//      addi r2,r0, 2           ALUResult = h2 = r2
    assign Inst_mem[3]   = 32'h00308193;//      addi r3,r1, 3           ALUResult = h4 = r3
    assign Inst_mem[4]   = 32'h00408213;//      addi r4,r1, 4           ALUResult = h5 = r4
    assign Inst_mem[5]   = 32'h00510293;//      addi r5,r2, 5           ALUResult = h7 = r5
    assign Inst_mem[6]   = 32'h00610313;//      addi r6,r2, 6           ALUResult = h8 = r6
    assign Inst_mem[7]   = 32'h00718393;//      addi r7,r3, 7           ALUResult = hB = r7
    assign Inst_mem[8]   = 32'h00208433;//      add  r8,r1,r2           ALUResult = h3 = r8
    assign Inst_mem[9]   = 32'h404404b3;//      sub  r9,r8,r4           ALUResult = hfffffffe = -2 = r9
    assign Inst_mem[10]  = 32'h00310533;//      add  r10,r2,r3          ALUResult = h6 = r10
    assign Inst_mem[11]  = 32'h0041e5b3;//      or   r11 = r3 | r4      ALUResult = h5 = r11
    //SB type
    assign Inst_mem[12]  = 32'h02b20263;//      beq r4,r11,36           ALUResult = 00000000       branch taken to inst_mem[21]
    assign Inst_mem[13]  = 32'h00108413;//      addi r8,r1,1            ALUResult = h2 = r8
    assign Inst_mem[14]  = 32'h00419a63;//      bne r3,r4,20            ALUReuslt = ffffffff       branch taken to inst_mem[19] 
    assign Inst_mem[15]  = 32'h00308413;//      addi  r8,r1,3           ALUReuslt = h4 = r8
    assign Inst_mem[16]  = 32'h0014c263;//      blt r9,r1,4             ALUResult = 00000001       branch taken to inst_mem[17]   
    assign Inst_mem[17]  = 32'h00408413;//      addi  r8,r1,4           ALUReuslt = h5 = r8
    assign Inst_mem[18]  = 32'h00b3da63;//      bge r7,r11,20           ALUResult = 00000001       branch taken to inst_mem[23]   
    assign Inst_mem[19]  = 32'h00208413;//      addi  r8,r1,2           ALUResult = h2 = r8
    assign Inst_mem[20]  = 32'hfe5166e3;//      bltu r2, r5, -24        ALUResult = 00000001       branch taken to inst_mem[15]     
    assign Inst_mem[21]  = 32'h00008413;//      add  r8,r1,0            ALUResult = h1 = r8
    assign Inst_mem[22]  = 32'hfc74fee3;//      bgeu  r9,r7,-36         ALUResult = 00000001       branch taken to inst_mem[13] 
    assign Inst_mem[23]  = 32'h0083e6b3;//      or  r13 = r7 | r8       ALUResult = hf = r13
    
    assign Inst_mem[24] = 32'h001020a3; //      store r1 in memory[1]
    assign Inst_mem[25] = 32'h00202123; //      store r2 in memory[2]
    assign Inst_mem[26] = 32'h003021a3; //      store r3 in memory[3]
    assign Inst_mem[27] = 32'h00402223; //      store r4 in memory[4]
    assign Inst_mem[28] = 32'h005022a3; //      store r5 in memory[5]
    assign Inst_mem[29] = 32'h00602323; //      store r6 in memory[6]
    assign Inst_mem[30] = 32'h007023a3; //      store r7 in memory[7]
    assign Inst_mem[31] = 32'h00802423; //      store r8 in memory[8]
    assign Inst_mem[32] = 32'h009024a3; //      store r9 in memory[9]
    assign Inst_mem[33] = 32'h00a02523; //      store r10 in memory[10]
    assign Inst_mem[34] = 32'h00b025a3; //      store r11 in memory[11]
    assign Inst_mem[35] = 32'h00c02623; //      store r12 in memory[12]
    assign Inst_mem[36] = 32'h00d026a3; //      store r13 in memory[13]
    assign Inst_mem[37] = 32'h00e02723; //      store r14 in memory[14]
    assign Inst_mem[38] = 32'h00f027a3; //      store r15 in memory[15]
     
    always_comb 
    begin
        instruction <= Inst_mem[pc[31:2]];
    end  
endmodule

