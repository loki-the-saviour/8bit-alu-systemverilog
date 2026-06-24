# 8-bit ALU – SystemVerilog

An 8-bit Arithmetic Logic Unit designed in SystemVerilog, verified through simulation, and synthesized to gate-level netlist using Yosys on the SkyWater 130nm open-source PDK.

## Overview
This project implements a configurable 8-bit ALU supporting standard arithmetic and logic operations (add, subtract, AND, OR, XOR, shift, comparison). The design was taken through RTL design, functional simulation, and synthesis to gate-level netlist, with gate-level verification confirming functional equivalence to the RTL across all test cases.

## Tools Used
- **RTL Design & Simulation:** SystemVerilog, Icarus Verilog, EDA Playground
- **Synthesis:** Yosys 0.33 (Ubuntu 24.04 / WSL2)
- **Target PDK:** SkyWater 130nm (open-source)
- **Verification:** Gate-level simulation using simcells.v primitives

## Files
- `alu.sv` – RTL design of the 8-bit ALU
- `alu_tb.sv` – Testbench for functional verification
- `netlist.v` – Synthesized gate-level netlist (Yosys output)

## Process
1. **RTL Design & Simulation** – Designed and verified ALU functionality at RTL level using Icarus Verilog.
2. **Synthesis** – Synthesized the RTL to gate-level netlist using Yosys, targeting the SkyWater 130nm PDK.
3. **Gate-Level Verification** – Ran gate-level simulation against the same testbench to confirm functional equivalence with RTL behavior.

## How to Run
```bash
# RTL simulation
iverilog -o alu_sim alu.sv alu_tb.sv
vvp alu_sim

# View waveform (if using GTKWave)
gtkwave dump.vcd
```

## Status
RTL and synthesis stages complete with verified functional equivalence. Physical design (OpenLane: floorplanning, placement, routing) planned as next phase.
