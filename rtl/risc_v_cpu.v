module risc_v_cpu (
    input  wire        clk,
    input  wire        reset
);

    // ==========================================
    // Program Counter
    // ==========================================

    wire [31:0] pc;
    reg  [31:0] next_pc;

    program_counter pc_unit (
        .clk     (clk),
        .reset   (reset),
        .next_pc (next_pc),
        .pc      (pc)
    );


    // ==========================================
    // Instruction Memory
    // ==========================================

    wire [31:0] instruction;

    instruction_memory imem (
        .address    (pc),
        .instruction(instruction)
    );


    // ==========================================
    // Instruction Fields
    // ==========================================

    wire [6:0] opcode = instruction[6:0];
    wire [4:0] rs1    = instruction[19:15];
    wire [4:0] rs2    = instruction[24:20];
    wire [4:0] rd     = instruction[11:7];

    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];


    // ==========================================
    // Control Unit
    // ==========================================

    wire       reg_write;
    wire       alu_src;
    wire       mem_write;
    wire       mem_to_reg;
    wire       branch;
    wire       jump;

    wire [3:0] alu_sel;
    wire [2:0] imm_type;

    control_unit control (
        .opcode    (opcode),
        .funct3    (funct3),
        .funct7    (funct7),

        .reg_write (reg_write),
        .alu_src   (alu_src),
        .mem_write (mem_write),
        .mem_to_reg(mem_to_reg),
        .branch    (branch),
        .jump      (jump),

        .alu_sel   (alu_sel),
        .imm_type  (imm_type)
    );


    // ==========================================
    // Register File
    // ==========================================

    wire [31:0] rs1_data;
    wire [31:0] rs2_data;

    reg [31:0] write_back_data;

    register_file registers (
        .clk       (clk),
        .reset     (reset),

        .rs1       (rs1),
        .rs2       (rs2),

        .read_data1(rs1_data),
        .read_data2(rs2_data),

        .reg_write (reg_write),
        .rd        (rd),
        .write_data(write_back_data)
    );


    // ==========================================
    // Immediate Generator
    // ==========================================

    wire [31:0] immediate;

    immediate_generator imm_gen (
        .instruction(instruction),
        .imm_type   (imm_type),
        .immediate  (immediate)
    );


    // ==========================================
    // ALU Input Selection
    // ==========================================

    wire [31:0] alu_b;

    assign alu_b = alu_src ? immediate : rs2_data;


    // ==========================================
    // ALU
    // ==========================================

    wire [31:0] alu_result;
    wire        alu_zero;

    alu alu_unit (
        .a      (rs1_data),
        .b      (alu_b),
        .alu_sel(alu_sel),

        .result (alu_result),
        .zero   (alu_zero)
    );


    // ==========================================
    // Data Memory
    // ==========================================

    wire [31:0] memory_read_data;

    data_memory dmem (
        .clk       (clk),
        .reset     (reset),

        .mem_write (mem_write),
        .address   (alu_result),
        .write_data(rs2_data),

        .read_data (memory_read_data)
    );


    // ==========================================
    // Write Back
    // ==========================================

    always @(*) begin

        if (mem_to_reg)
            write_back_data = memory_read_data;
        else
            write_back_data = alu_result;

    end


    // ==========================================
    // Branch Unit
    // ==========================================

    wire take_branch;

    branch_unit branch_logic (
        .rs1_data    (rs1_data),
        .rs2_data    (rs2_data),

        .funct3      (funct3),
        .branch      (branch),

        .take_branch (take_branch)
    );


    // ==========================================
    // Next PC Logic
    // ==========================================

    always @(*) begin

        // Default: next instruction
        next_pc = pc + 32'd4;

        // Conditional branch
        if (take_branch)
            next_pc = pc + immediate;

        // JAL
        if (jump)
            next_pc = pc + immediate;

    end

endmodule
