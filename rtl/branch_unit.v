module branch_unit (
    input  wire [31:0] rs1_data,
    input  wire [31:0] rs2_data,

    input  wire [2:0]  funct3,
    input  wire        branch,

    output reg         take_branch
);

    always @(*) begin

        take_branch = 1'b0;

        if (branch) begin

            case (funct3)

                // BEQ
                3'b000:
                    take_branch = (rs1_data == rs2_data);

                // BNE
                3'b001:
                    take_branch = (rs1_data != rs2_data);

                default:
                    take_branch = 1'b0;

            endcase

        end

    end

endmodule
