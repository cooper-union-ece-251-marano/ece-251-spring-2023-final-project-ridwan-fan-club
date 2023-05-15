//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: cpu
//     Description: 32-bit RISC-based CPU (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../controller/controller.sv"
`include "../datapath/datapath.sv"

module cpu
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic clk, reset,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    // cpu internal components
    logic  memtoreg;
    logic memwrite; 
    logic alusrc;
    logic regdst, regwrite;
    logic jump, branch;
    logic pcsrc, zero;
    logic [3:0] alucontrol;
    logic [6:0] opcode;
    logic [1:0] aluop;

    controller c(opcode,zero,
        memtoreg, memwrite, branch,
        alusrc,regdst, regwrite, jump,
        aluop);

    datapath dp(clk,jump,branch,memwrite,
    alusrc,regdst,memtoreg,regwrite,aluop,opcode,zero);



endmodule

`endif // CPU