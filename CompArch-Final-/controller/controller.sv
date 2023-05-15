//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: controller
//     Description: 32-bit RISC-based CPU controller (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"

module controller
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic [6:0] op,
    input logic       zero,
    output logic memtoreg,memwrite,branch,alusrc,regdst,regwrite,jump,
    output logic [1:0] aluop
    );
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    
    // CPU main decoder
    maindec md(opcode, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);

endmodule

`endif // CONTROLLER