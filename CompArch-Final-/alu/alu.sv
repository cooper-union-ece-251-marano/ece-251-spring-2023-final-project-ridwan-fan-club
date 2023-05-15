`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk,
    input  logic [(n-1):0] a, b,
    input  logic [3:0]  alucontrol,
    output logic [(n-1):0] result,
    output logic        zero
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] condinvb, sum;
    logic [(2*n-1):0] HiLo;

    assign zero = (result == {n{1'b0}}); // zero result control signal
    assign condinvb = alucontrol[1] ? ~b : b;
    assign sumSlt = a + condinvb + alucontrol[1]; // (a-b using 2s complement) test if a == b, if b<a, then sumSlt will have neg bit[31]

    // initialize the internal HiLo register used in multiplying two 32-bit numbers = a 64-bit number.
    initial
        begin
            HiLo = 64'b0;
        end

    always @(a,b,alucontrol) begin
        case (alucontrol)
            4'b0001: result = a + b;            //add
            4'b0011: result = sumSlt;            // sub
            4'b0100: begin                       // slt
                if (a[31] != b[31])
					if (a[31] > b[31])
						result = 1;
					else
						result = 0;
				else
					if (a < b)
						result = 1;
					else
						result = 0;
            end
            4'b0101: result = a | b;             // or
            4'b0110: result = a & b;             // and
            4'b0111: result = a ^ b;           // xor
        endcase
    end

    //Multiply and divide results are only stored at clock falling edge.

    always @(negedge clk) begin
        case(alucontrol)
        4'b0010: 
        begin
            HiLo <= a * b;
            result <= HiLo[31:0];
        end
            
        4'b1010:
        begin
            HiLo <= a * b;
            result <= HiLo[63:32];
        end

            4'b1000: result = a / b;    //div
            4'b1001: result = a % b;
        endcase				
    end

endmodule

`endif // ALU