module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    assign instruction = memory[address[9:2]];

    initial begin

        // ADDI x1, x0, 10
        memory[0] = 32'h00A00093;

        // ADDI x2, x0, 20
        memory[1] = 32'h01400113;

        // ADD x3, x1, x2
        memory[2] = 32'h002081B3;

        // SW x3, 0(x0)
        memory[3] = 32'h00302023;

        // LW x4, 0(x0)
        memory[4] = 32'h00002203;

        // ADDI x5, x4, 5
        memory[5] = 32'h00520293;

        // NOP
        memory[6] = 32'h00000013;

    end

endmodule
