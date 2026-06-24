`timescale 1ns/1ps

module alu_tb;

  logic [7:0] a, b;
  logic [2:0] sel;
  logic [7:0] result;
  logic       zero, carry, overflow, negative;

  // Instantiate the ALU (device under test)
  alu dut (
    .a(a),
    .b(b),
    .sel(sel),
    .result(result),
    .zero(zero),
    .carry(carry),
    .overflow(overflow),
    .negative(negative)
  );

  // Task to apply inputs, wait, and print results
  task apply_test(logic [7:0] in_a, logic [7:0] in_b, logic [2:0] in_sel, string op_name);
    a   = in_a;
    b   = in_b;
    sel = in_sel;
    #5; // wait for combinational logic to settle
    $display("OP=%-4s A=%3d (%b) B=%3d (%b) | RESULT=%3d (%b) Z=%b C=%b OV=%b N=%b",
              op_name, a, a, b, b, result, result, zero, carry, overflow, negative);
  endtask

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_tb);

    $display("---------------------------------------------------------------");
    $display(" Starting 8-bit ALU Testbench");
    $display("---------------------------------------------------------------");

    // ADD tests
    apply_test(8'd10,  8'd20,  3'b000, "ADD");   // normal add
    apply_test(8'd200, 8'd100, 3'b000, "ADD");   // causes carry-out
    apply_test(8'd127, 8'd1,   3'b000, "ADD");   // signed overflow (127+1)

    // SUB tests
    apply_test(8'd30,  8'd10,  3'b001, "SUB");   // normal sub
    apply_test(8'd10,  8'd30,  3'b001, "SUB");   // borrow / negative result
    apply_test(8'd128, 8'd1,   3'b001, "SUB");   // signed overflow case

    // Logic ops
    apply_test(8'hF0,  8'h0F,  3'b010, "AND");
    apply_test(8'hF0,  8'h0F,  3'b011, "OR");
    apply_test(8'hAA,  8'h55,  3'b100, "XOR");
    apply_test(8'h0F,  8'h00,  3'b101, "NOT");

    // Shifts
    apply_test(8'b10000001, 8'd0, 3'b110, "SHL"); // MSB shifted into carry
    apply_test(8'b10000001, 8'd0, 3'b111, "SHR"); // LSB shifted into carry

    // Zero flag check
    apply_test(8'd5, 8'd5, 3'b001, "SUB");        // 5-5=0, zero flag should be 1

    $display("---------------------------------------------------------------");
    $display(" Testbench Complete");
    $display("---------------------------------------------------------------");
    $finish;
  end

endmodule
