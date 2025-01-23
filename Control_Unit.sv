module Control_Unit(
    input logic [31:0] instruction,
    output logic [3:0] operation,
    output logic wrt_en,
    output logic jump,
    output logic sel_ALUsrc,
    output logic MemRead,
    output logic MemWrt,
    output logic sel_wrtdata,
    output logic [2:0] mem_type,
    output logic branch,
    output logic [1:0] branch_type
);

    // (Your ROM initialization code remains the same)
	 logic [15:0] ROM [40:0];

    assign ROM[0]=16'b0000100000000000; //ADD
    assign ROM[1]=16'b0001100000000000; //SUB
    assign ROM[2]=16'b0101100000000000; //SLL
    assign ROM[3]=16'b1000100000000000; //SLT
    assign ROM[4]=16'b1001100000000000; //SLTU
    assign ROM[5]=16'b0100100000000000; //XOR
    assign ROM[6]=16'b0110100000000000; //SRL
    assign ROM[7]=16'b0111100000000000; //SRA
    assign ROM[8]=16'b0011100000000000; //OR
    assign ROM[9]=16'b0010100000000000; //AND

    assign ROM[10]=16'b0000101000000000; //ADDI
    assign ROM[11]=16'b1000101000000000; //SLTI
    assign ROM[12]=16'b1001101000000000; //SLIU
    assign ROM[13]=16'b0100101000000000; //XORI
    assign ROM[14]=16'b0011101000000000; //ORI
    assign ROM[15]=16'b0010101000000000; //ANDI
    assign ROM[16]=16'b0101101000000000; //SLLI
    assign ROM[17]=16'b0110101000000000; //SRLI
    assign ROM[18]=16'b0111101000000000; //SRAI

    assign ROM[19]=16'b0000101101000000; //LB
    assign ROM[20]=16'b0000101101001000; //LH
    assign ROM[21]=16'b0000101101010000; //LW
    assign ROM[22]=16'b0000101101100000; //LBU
    assign ROM[23]=16'b0000101101101000; //LHU

    assign ROM[24]=16'b0000001010000000; //SB
    assign ROM[25]=16'b0000001010001000; //SH
    assign ROM[26]=16'b0000001010010000; //SW

    assign ROM[27]=16'b0001000000000100; //BEQ
    assign ROM[28]=16'b0001000000000101; //BNE
    assign ROM[29]=16'b1000000000000110; //BLT
    assign ROM[30]=16'b1000000000000111; //BGE
    assign ROM[31]=16'b1001000000000110; //BLTU
    assign ROM[32]=16'b1001000000000111; //BGEU

    assign ROM[33]=16'b0000111000000000; //JALR
    assign ROM[34]=16'b1010100000000000; //MUL


    logic [15:0] control_output;

    assign operation = control_output[15:12];
    assign wrt_en = control_output[11];
    assign jump = control_output[10];
    assign sel_ALUsrc = control_output[9];
    assign MemRead = control_output[8];
    assign MemWrt = control_output[7];
    assign sel_wrtdata = control_output[6];
    assign mem_type = control_output[5:3];
    assign branch = control_output[2];
    assign branch_type = control_output[1:0];

    always_comb begin
        if ((instruction[6:2] == 5'b01100) ||
            (instruction[6:2] == 5'b00100 && (instruction[14:12] == 3'b101 || instruction[14:12] == 3'b001)))
        begin
            // Combinational logic for control_output based on instruction bits
            control_output = ROM[getIndex(instruction)];
        end
        else
        begin
            // Combinational logic for control_output based on other conditions
            control_output = ROM[getOtherIndex(instruction)];
        end
    end

    function integer getIndex(input logic [31:0] instr);
        // Define logic to extract the index for ROM based on instruction bits
        // Return the appropriate index
    endfunction

    function integer getOtherIndex(input logic [31:0] instr);
        // Define logic to extract the other index for ROM based on instruction bits
        // Return the appropriate index
    endfunction

endmodule
