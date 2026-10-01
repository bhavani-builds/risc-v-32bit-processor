module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    assign instruction = memory[address[9:2]];

    initial begin

        // ADDI x1, x0, 10
        memory[0] = 32'h00A00093;

        // ADDI x2, x0, 10
        memory[1] = 32'h00A00113;

        // BEQ x1, x2, +8
        // Skip next instruction
        memory[2] = 32'h00208463;

        // This instruction should be skipped
        // ADDI x3, x0, 99
        memory[3] = 32'h06300193;

        // Target instruction
        // ADDI x3, x0, 30
        memory[4] = 32'h01E00193;

        // BNE x1, x2, +8
        // Should NOT branch
        memory[5] = 32'h00209463;

        // ADDI x4, x0, 40
        memory[6] = 32'h02800213;

        // NOP
        memory[7] = 32'h00000013;

    end

endmodule
