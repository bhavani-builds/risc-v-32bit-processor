        $display("");
        $display("================================");
        $display("RISC-V FIBONACCI TEST");
        $display("================================");

        $display("x1 = %0d", dut.registers.registers[1]);
        $display("x2 = %0d", dut.registers.registers[2]);
        $display("x3 = %0d", dut.registers.registers[3]);
        $display("x4 = %0d", dut.registers.registers[4]);

        // After 10 iterations:
        // x1 = 89
        // x2 = 144
        // x3 = 0
        // x4 = 144

        check_register(5'd1, 32'd89);
        check_register(5'd2, 32'd144);
        check_register(5'd3, 32'd0);
        check_register(5'd4, 32'd144);

        if (errors == 0) begin
            $display("");
            $display("================================");
            $display("FIBONACCI TEST PASSED");
            $display("================================");
        end
        else begin
            $display("");
            $display("================================");
            $display("FIBONACCI TEST FAILED");
            $display("ERRORS = %0d", errors);
            $display("================================");
        end
