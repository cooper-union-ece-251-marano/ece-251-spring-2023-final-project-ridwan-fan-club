//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Manhim Liu & Vaibhav Hariani
// 
//     Create Date: 2023-05-13
//     Module Name: imem
//     Description: 32-bit RISC memory (instruction "text" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef IMEM
`define IMEM

`timescale 1ns/100ps

module imem
// n=bit length of register; r=bit length of addr to limit memory and not crash your verilog emulator
    #(parameter n = 32, parameter r = 6)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [(r-1):0] addr,
    output logic [(n-1):0] instr
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] RAM[0:(2**r-1)];

  initial
    begin
      // read memory in binary format from file, fill up RAM with instruction.
      $readmemb("file_exe",RAM);
    end
    
  assign instr = RAM[addr]; // word aligned

endmodule

`endif // IMEM