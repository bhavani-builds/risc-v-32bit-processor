`timescale 1ns/1ps

module risc_v_cpu_tb;

    reg clk;
    reg reset;

    integer errors;

    // ==========================================
    // CPU
    // ==========================================

    risc_v_cpu dut (
        .clk   (clk),
        .reset (reset)
    );


    // ==========================================
    // Clock
    // ==========================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // ==========================================
    // Verification Task
    // ==========================================

    task check_register;

        input [4:0] register_number;
        input [31:0] expected_value;

        begin

            if (dut.registers.registers[register_number]
                !== expected_value) begin

                $display(
                    "FAIL: x%0d expected %0d, got %0d",
                    register_number,
                    expected_value,
                    dut.registers.registers[register_number]
                );

                errors = errors + 1;

            end
            else begin

                $display(
                    "PASS: x%0d = %0d",
                    register_number,
                    expected_value
                );

            end

        end

    endtask


    // ==========================================
    // Test
    // ==========================================

    initial begin

        errors = 0;

        // Waveform
        $dumpfile("risc_v_cpu.vcd");
        $dumpvars(0, risc_v_cpu_tb);

        // Reset
        reset = 1'b1;

        #20;

        reset = 1'b0;

        // Allow program to execute
        #150;

        $display("");
        $display("================================");
        $display("RISC-V CPU VERIFICATION");
        $display("================================");

        // ======================================
        // Register Checks
        // ======================================

        check_register(5'd1, 32'd10);
        check_register(5'd2, 32'd20);
        check_register(5'd3, 32'd30);
        check_register(5'd4, 32'd10);

        // ======================================
        // Final Result
        // ======================================

        if (errors == 0) begin

            $display("");
            $display("================================");
            $display("ALL TESTS PASSED");
            $display("================================");

        end
        else begin

            $display("");
            $display("================================");
            $display("TEST FAILED");
            $display("ERRORS = %0d", errors);
            $display("================================");

        end

        $finish;

    end

endmodule
