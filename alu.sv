`timescale 1ns/1ps

module alu (
  input  logic [7:0] a,
  input  logic [7:0] b,
  input  logic [2:0] sel,        // 3-bit opcode
  output logic [7:0] result,
  output logic       zero,
  output logic       carry,
  output logic       overflow,
  output logic       negative
);

  logic [8:0] temp_result;   // 9 bits to catch carry-out for ADD/SUB

  always @(*) begin
    // Defaults so every signal is always driven (avoids latches / unknowns)
    temp_result = 9'd0;
    result      = 8'd0;
    carry       = 1'b0;
    overflow    = 1'b0;

    case (sel)
      3'b000: begin // ADD
        temp_result = a + b;
        result      = temp_result[7:0];
        carry       = temp_result[8];
        overflow    = (a[7] == b[7]) && (result[7] != a[7]);
      end

      3'b001: begin // SUB
        temp_result = a - b;
        result      = temp_result[7:0];
        carry       = (a < b) ? 1'b1 : 1'b0;
        overflow    = (a[7] != b[7]) && (result[7] != a[7]);
      end

      3'b010: begin // AND
        result   = a & b;
      end

      3'b011: begin // OR
        result   = a | b;
      end

      3'b100: begin // XOR
        result   = a ^ b;
      end

      3'b101: begin // NOT (on A)
        result   = ~a;
      end

      3'b110: begin // SHL (shift left by 1)
        result   = a << 1;
        carry    = a[7];   // bit shifted out
      end

      3'b111: begin // SHR (shift right by 1)
        result   = a >> 1;
        carry    = a[0];   // bit shifted out
      end

      default: begin
        result = 8'b0;
      end
    endcase

    // Flags common to all operations
    zero     = (result == 8'b0) ? 1'b1 : 1'b0;
    negative = result[7];
  end

endmodule

