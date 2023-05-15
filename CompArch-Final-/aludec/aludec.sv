`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    input  logic [1:0] aluop,
    output logic [3:0] alucontrol
    );
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @*
    begin
        case(aluop)
        2'b00: alucontrol <= 4'b0001;  // add (for lw/sw/addi)
        2'b01: alucontrol <= 4'b0011;  // sub (for beq)
        default:
            // for R-type instructions
            case(funct3)
            3'b000: 
                case(funct7)
                    7'b0000000: alucontrol <= 4'b0001; //add
                    7'b0000001: alucontrol <= 4'b0010; //mul(low)
                    7'b0100000: alucontrol <= 4'b0011; //sub
                    default:   alucontrol <= 4'bxxxx; //illegal
                endcase        

                3'b010: alucontrol <= 4'b0100; // slt
                3'b110: alucontrol <= 4'b0101; // or
                3'b111: alucontrol <= 4'b0110; // and
                3'b100: 
                    case(funct7)
                        7'b0000000: alucontrol <= 4'b0111; //xor
                        7'b0000001: alucontrol <= 4'b1000; //div
                        default:    alucontrol <= 4'bxxxx; //illegal
                3'b101: alucontrol <= 4'b1001; //remainder
                3'b001: alucontrol <= 4'b1010; //mulh (high)

                    endcase
                default:   alucontrol <= 4'bxxxx; //illegal
            endcase
        endcase
    end

endmodule
`endif // ALUDEC