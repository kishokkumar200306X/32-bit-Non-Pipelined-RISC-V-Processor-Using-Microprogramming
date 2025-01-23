`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 12:19:00 AM
// Design Name: 
// Module Name: Datapath
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


module Datapath#(parameter pc_width = 32)(
    input logic clk, rst,
    input logic [3:0] in,
    output logic [31:0] ALU_result,
    output logic [3:0] out
    );

    logic signed [31:0] bus_A, bus_B, bus_C;
    logic [pc_width - 1:0] pc_out;
    logic [31:0] instruction;
    logic signed [31:0] reg1_data, reg2_data, ALUout;
    logic zero;
    logic [31:0] Immout;
    logic [31:0] rs2imm_mux_out;
    logic signed [31:0] memdata;
    logic signed [31:0] alu2mux_data;
    logic [31:0] br_imm_out;
    logic signed[31:0] pc_next;
    logic signed [31:0] pc_final;
    logic mux_pc2branch;
    logic signed [1:0] branch_type;
    logic wrt_en;
    logic [3:0] operation;
    logic sel_ALUsrc;
    logic MemRead, MemWrt;
    logic sel_wrtdata;
    logic [2:0] mem_type;
    logic branch;
    logic jump;
    logic [31:0] final_data;
    logic [31:0] pc_last;

    // Program counter (clk, rst)
    Program_Counter Program_Counter_blk (
        .rst(rst),
        .clk(clk),
        .pc_in(pc_last),
        .pc_out(pc_out)
    );

    // Pc+4 next pc
    Adder Adder_blk_pc(
        .add_in1(pc_out),
        .add_in2(4),
        .add_out(pc_next)
    );

    // Branch instruction adder
    Adder Adder_blk_branch(
        .add_in1(pc_out),
        .add_in2(Immout),
        .add_out(br_imm_out)
    );

    // Checking whether branch condition is satisfied
    Branch_Predictor Branch_Predictor_blk(
        .isZero(zero),
        .branchSignal(branch),
        .lastBit(ALUout[0]),
        .branch_type(branch_type),
        .muxOutput(mux_pc2branch)
    );

    // To select between branch and pc (branch)
    Mux Mux_blk_3(
        .mux_in1(pc_next),
        .mux_in2(br_imm_out),
        .mux_out(pc_final), 
        .sel(mux_pc2branch)
    );

    // To select jump
    Mux Mux_blk_jmp(
        .mux_in1(pc_final),
        .mux_in2(ALUout),
        .mux_out(pc_last),
        .sel(jump)
    );

    // Instruction memory
    Instruction_Memory Instruction_Memory_blk(
        .pc(pc_out),
        .instruction(instruction)
    );

    // Control unit
    Control_Unit Control_Unit_blk(
        .instruction(instruction),
        .wrt_en(wrt_en),
        .operation(operation),
        .sel_ALUsrc(sel_ALUsrc),
        .MemRead(MemRead),
        .MemWrt(MemWrt),
        .sel_wrtdata(sel_wrtdata),
        .mem_type(mem_type),
        .branch(branch),
        .branch_type(branch_type),
        .jump(jump)
    );

    // JALR: the pc+1 is written
    Mux mux_jmp(
        .mux_in1(bus_C),
        .mux_in2(pc_next),
        .sel(jump),
        .mux_out(final_data)
    );

    // Registers (include wrt data) (clk, rst, wrt_en)
    Register_File Register_File_blk(
        .clk(clk),
        .rst(rst),
        .wrt_en(wrt_en),
        .reg1_addr(instruction[19:15]),
        .reg2_addr(instruction[24:20]),
        .reg_wrt_addr(instruction[11:7]),
        .reg_wrt_data(final_data),
        .reg1_data(reg1_data),
        .reg2_data(reg2_data)
    ); 

    // Sign extender 
    Imm_Gen Imm_Gen_blk (
        .instruction(instruction),
        .Immout(Immout)
    );

    // MUX to select between Imm_Gen and rs2 output (sel_ALUsrc)
    Mux Mux_blk (
        .mux_in1(reg2_data),
        .mux_in2(Immout),
        .sel(sel_ALUsrc),
        .mux_out(rs2imm_mux_out)
    );

    // Assigning the outputs of reg1 and reg2 to buses
    assign bus_A = reg1_data;
    assign bus_B = rs2imm_mux_out;

    // ALU (operation)
    ALU ALU_blk(
        .ALUin1(bus_A),
        .ALUin2(bus_B),
        .ALUout(ALUout),
        .operation(operation),
        .zero(zero)
    );
    
    assign ALU_result = ALUout;

    // Data memory (memwrt, memread)
    Data_Memory Data_Memory_blk(
        .clk(clk),
        .Mem_addr(ALUout),
        .Wrt_data(reg2_data),
        .MemWrt(MemWrt),
        .MemRead(MemRead),
        .Read_data(memdata),
        .mem_type(mem_type),
        .in(in),
        .out(out)
    );

    // MUX to select from mem and ALU (sel_wrtdata)
    Mux Mux_blk_2(
        .mux_in1(ALUout),
        .mux_in2(memdata),
        .mux_out(alu2mux_data),
        .sel(sel_wrtdata)
    );

    assign bus_C = alu2mux_data;

endmodule
