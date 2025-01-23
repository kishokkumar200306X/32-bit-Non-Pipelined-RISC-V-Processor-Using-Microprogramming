module Register_File(
   input logic clk,
   input logic rst,
   input logic wrt_en,
   input logic [4:0] reg1_addr,
   input logic [4:0] reg2_addr,
   input logic [4:0] reg_wrt_addr,
   input logic [31:0] reg_wrt_data,
         
   output logic [31:0] reg1_data,
   output logic [31:0] reg2_data
);

    logic [31:0] register [0:31]; // Define an array of registers

    initial begin
        register[0] = 32'b00000000_00000000_00000000_00000000;
        for (int i = 1; i <= 31; i = i + 1) begin
            register[i] = 32'b0;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 1; i <= 31; i = i + 1) begin
                register[i] <= 32'b0;
            end
        end else if (wrt_en && (reg_wrt_addr != 5'b00000)) begin
            register[reg_wrt_addr] <= reg_wrt_data;
        end
    end
 
    assign reg1_data = register[reg1_addr];
    assign reg2_data = register[reg2_addr];

endmodule
