module Data_Memory #(
    parameter addr_width = 9
)(
    input logic clk,
    input logic [31:0] Mem_addr,
    input logic signed [31:0] Wrt_data,
    input logic MemWrt,
    input logic MemRead,
    input logic [2:0] mem_type,
    input logic [3:0] in,
    output logic signed [31:0] Read_data,
    output logic [3:0] out
);

    logic signed [31:0] memory [0: (1 << addr_width) - 1];

    always_comb begin
        if (MemRead) begin
            case (mem_type)
                // lb (000)
                3'b000: Read_data = memory[Mem_addr][7] ? {{24{1'b1}}, memory[Mem_addr][7:0]} : {{24{1'b0}}, memory[Mem_addr][7:0]};
                // lbu (100)
                3'b100: Read_data = {{24{1'b0}}, memory[Mem_addr][7:0]};
                // lh (001)
                3'b001: Read_data = memory[Mem_addr][15] ? {{16{1'b1}}, memory[Mem_addr][15:0]} : {{16{1'b0}}, memory[Mem_addr][15:0]};
                // lhu (101)
                3'b101: Read_data = {{16{1'b0}}, memory[Mem_addr][15:0]};
                // lw (010)
                3'b010: Read_data = memory[Mem_addr];
                default: Read_data = 32'b0; // Provide a default assignment
            endcase
        end else begin
            // Add default assignment for Read_data if MemRead is not asserted
            Read_data = 32'b0;
        end
    end

    always_ff @(posedge clk) begin
        out <= memory[in];
        if (MemWrt) begin
            case (mem_type)
                3'b000: memory[Mem_addr] <= {{24{1'b0}}, Wrt_data[7:0]};
                3'b001: memory[Mem_addr] <= {{16{1'b0}}, Wrt_data[15:0]};
                3'b010: memory[Mem_addr] <= Wrt_data;
                default: memory[Mem_addr] <= 32'b0; // Provide a default assignment
            endcase
        end
    end
endmodule
