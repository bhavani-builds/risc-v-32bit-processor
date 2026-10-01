`timescale 1ns/1ps

module risc_v_cpu_tb;

    reg clk;
    reg reset;

    // ==========================================
    // Instantiate CPU
    // ==========================================

    risc_v_cpu dut (
        .clk   (clk),
        .reset (reset)
    );


    // ==========================================
    // Clock Generation
    // ==========================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // ==========================================
    // Test
    // ==========================================

    initial begin

        $dumpfile("risc_v_cpu.vcd");
        $dumpvars(0, risc_v_cpu_tb);

        // Reset CPU
        reset = 1'b1;

        #20;

        reset = 1'b0;

        // Allow processor to execute program
        #100;

        // ======================================
        // Display Register Values
        // ======================================

        $display("--------------------------------");
        $display("RISC-V CPU TEST");
        $display("--------------------------------");

        $display("x1 = %d", dut.registers.registers[1]);
        $display("x2 = %d", dut.registers.registers[2]);
        $display("x3 = %d", dut.registers.registers[3]);
        $display("x4 = %d", dut.registers.registers[4]);
        $display("x5 = %d", dut.registers.registers[5]);
        $display("x6 = %d", dut.registers.registers[6]);
        $display("x7 = %d", dut.registers.registers[7]);

        $display("--------------------------------");

        // ======================================
        // Basic Checks
        // ======================================

        if (dut.registers.registers[1] == 32'd10)
            $display("PASS: x1 = 10");
        else
            $display("FAIL: x1 expected 10");

        if (dut.registers.registers[2] == 32'd20)
            $display("PASS: x2 = 20");
        else
            $display("FAIL: x2 expected 20");

        if (dut.registers.registers[3] == 32'd30)
            $display("PASS: x3 = 30");
        else
            $display("FAIL: x3 expected 30");

        if (dut.registers.registers[4] == 32'd10)
            $display("PASS: x4 = 10");
        else
            $display("FAIL: x4 expected 10");

        $display("--------------------------------");

        $finish;

    end

endmodule
