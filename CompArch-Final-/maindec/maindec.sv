`ifndef MAINDEC
`define MAINDEC
`timescale 1ns/100ps

module maindec
(
//Opcodes are typically 7 bits for RISC-V, but no functions implemented exceed 6. 
//MSB @ 1 is an error for this processor.

input  logic [6:0] opcode,
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [1:0] aluop);

logic [5:0] controls;
assign {regdst,ALUsrc,Mem_Reg,Reg_Write,MemRead,MemWrite,Branch,ALUOP,jump}
= controls;

always @* begin
        case(opcode)
            7'b0110011: controls <= 9'b1001000000; // Data Processing
            7'b000011: controls <= 9'b0111100100; // LW
            7'b0100011: controls <= 9'b0100010100; // SW
            7'b0000011: controls <= 9'b0000001010; // BEQ
            7'b0001101: controls <= 9'b101000000; // ADDI
            7'b1101111: controls <= 9'b0000000001; // JAL
            default:   controls <= 9'bxxxxxxxxx; // illegal operation
        endcase
    end

endmodule
`endif

    

