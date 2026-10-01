module data_memory (
    input  wire        clk,
    input  wire        reset,

    input  wire        mem_write,
    input  wire [31:0] address,
    input  wire [31:0] write_data,

    output wire [31:0] read_data
);

    reg [31:0] memory [0:255];

    integer i;

    // Combinational read
    assign read_data = memory[address[9:2]];

    // Synchronous write
    always @(posedge clk) begin

        if (reset) begin

            for (i = 0; i < 256; i = i + 1)
                memory[i] <= 32'd0;

        end
        else if (mem_write) begin

            memory[address[9:2]] <= write_data;

        end

    end

endmodule
