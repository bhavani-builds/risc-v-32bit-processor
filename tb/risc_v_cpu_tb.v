        $display("--------------------------------");
        $display("RISC-V BRANCH TEST");
        $display("--------------------------------");

        $display("x1 = %d", dut.registers.registers[1]);
        $display("x2 = %d", dut.registers.registers[2]);
        $display("x3 = %d", dut.registers.registers[3]);
        $display("x4 = %d", dut.registers.registers[4]);

        if (dut.registers.registers[1] == 32'd10)
            $display("PASS: x1 = 10");
        else
            $display("FAIL: x1");

        if (dut.registers.registers[2] == 32'd10)
            $display("PASS: x2 = 10");
        else
            $display("FAIL: x2");

        // BEQ must skip x3 = 99
        if (dut.registers.registers[3] == 32'd30)
            $display("PASS: BEQ branch taken");
        else
            $display("FAIL: BEQ");

        // BNE must not branch
        if (dut.registers.registers[4] == 32'd40)
            $display("PASS: BNE branch not taken");
        else
            $display("FAIL: BNE");

        $display("--------------------------------");
