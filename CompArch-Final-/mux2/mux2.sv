//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Manhim Liu and Vaibhav Hariani
// 
//     Create Date: 2023-05-05
//     Module Name: mux2
//     Description: 2 32-bit input multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`ifndef MUX2
`define MUX2

`timescale 1ns/100ps

module mux2
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [(n-1):0] D0, D1,
    input  logic S,
    output logic [(n-1):0] Y
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign Y = S ? D1 : D0;
endmodule

`endif // MUX2