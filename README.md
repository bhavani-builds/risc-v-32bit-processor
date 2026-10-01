# 32-bit RISC-V Processor Core

A 32-bit single-cycle RISC-V processor core designed and verified using Verilog HDL.

## Overview

This project implements a simplified RV32I-compatible processor datapath using synthesizable Verilog HDL.

The processor demonstrates the fundamental components of a CPU:

- Program Counter
- Instruction Memory
- Register File
- ALU
- Immediate Generator
- Control Unit
- Branch Unit
- Data Memory
- Write-Back Logic

The design is verified using simulation-based testbenches and GitHub Actions.

---

## Architecture

```text
                    ┌───────────────────────┐
                    │   Program Counter     │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │  Instruction Memory   │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │    Control Unit      │
                    └───────────┬───────────┘
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
              ▼                 ▼                 ▼
       ┌─────────────┐  ┌──────────────┐  ┌─────────────┐
       │ Register    │  │  Immediate   │  │   Branch    │
       │ File        │  │  Generator   │  │    Unit     │
       └──────┬──────┘  └──────┬───────┘  └──────┬──────┘
              │                 │                 │
              └─────────────────┼─────────────────┘
                                ▼
                         ┌─────────────┐
                         │    ALU      │
                         └──────┬──────┘
                                │
                                ▼
                       ┌────────────────┐
                       │  Data Memory   │
                       └───────┬────────┘
                               │
                               ▼
                        ┌──────────────┐
                        │  Write Back  │
                        └──────────────┘
Supported Instructions
R-Type
Instruction	Operation
ADD	Addition
SUB	Subtraction
AND	Bitwise AND
OR	Bitwise OR
XOR	Bitwise XOR
I-Type
Instruction	Operation
ADDI	Add immediate
Load / Store
Instruction	Operation
LW	Load 32-bit word
SW	Store 32-bit word
Branch
Instruction	Operation
BEQ	Branch if equal
BNE	Branch if not equal
Jump
Instruction	Operation
JAL	Jump and link
Project Structure
risc-v-32bit-processor/
│
├── rtl/
│   ├── program_counter.v
│   ├── register_file.v
│   ├── alu.v
│   ├── immediate_generator.v
│   ├── control_unit.v
│   ├── instruction_memory.v
│   ├── data_memory.v
│   ├── branch_unit.v
│   └── risc_v_cpu.v
│
├── tb/
│   └── risc_v_cpu_tb.v
│
├── program/
│   ├── program.hex
│   └── alu_test.hex
│
├── .github/
│   └── workflows/
│       └── verilog-test.yml
│
└── README.md
RTL Modules
Program Counter

Stores the current instruction address and updates the PC on every clock cycle.

Register File

Contains 32 general-purpose 32-bit registers.

x0 - x31

Register x0 is permanently maintained as zero.

ALU

Performs:

ADD
SUB
AND
OR
XOR
Signed comparison
Unsigned comparison
Logical shifts
Arithmetic right shift
Immediate Generator

Supports immediate extraction for:

I-Type
S-Type
B-Type
J-Type
Control Unit

Decodes instruction fields:

opcode
funct3
funct7

and generates datapath control signals.

Data Memory

Provides the memory interface required by:

LW
SW
Branch Unit

Determines whether:

BEQ
BNE

conditions are satisfied.

Verification

The processor is verified using Verilog testbenches.

Verification includes:

ALU operations
Register operations
Immediate instructions
Load/store operations
Branch instructions
Jump instructions
Program execution
Fibonacci algorithm execution

Example expected results:

ADD:
15 + 3 = 18

SUB:
15 - 3 = 12

AND:
15 & 3 = 3

OR:
15 | 3 = 15

XOR:
15 ^ 3 = 12
Automated CI

GitHub Actions automatically:

Checks out the repository
Installs Icarus Verilog
Compiles the RTL
Compiles the testbench
Runs the simulation
Generates a VCD waveform
Reports verification results

Workflow:

Git Push
   │
   ▼
GitHub Actions
   │
   ▼
Icarus Verilog
   │
   ▼
Compile
   │
   ▼
Simulation
   │
   ▼
PASS / FAIL
Simulation

The testbench generates:

risc_v_cpu.vcd

The waveform can be inspected using GTKWave.

Important signals include:

clk
reset
pc
instruction
rs1_data
rs2_data
alu_result
immediate
memory_read_data
write_back_data
next_pc
Technologies
Verilog HDL
RISC-V ISA concepts
RTL Design
Digital Logic
Computer Architecture
Icarus Verilog
GTKWave
GitHub Actions
Git / GitHub
Future Improvements

Planned extensions:

More RV32I instructions
SLT / SLTU
Shift instructions
LUI
AUIPC
JALR
Additional load/store instructions
CSR support
Pipeline architecture
Hazard detection
Forwarding unit
Five-stage pipeline
FPGA implementation
Hardware synthesis and timing analysis
Learning Outcomes

This project demonstrates practical understanding of:

CPU datapath design
Instruction decoding
RTL design methodology
Verilog HDL
Register-transfer-level modeling
Memory interfacing
Branch and jump control
Processor verification
Automated HDL testing
GitHub-based development workflow
Author

ECE Student | RTL Design | VLSI | Digital Design

Interested in:

VLSI Design
RTL Design
FPGA
Computer Architecture
Embedded Systems
RISC-V
