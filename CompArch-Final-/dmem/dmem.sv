//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: dmem
//     Description: 32-bit RISC memory ("data" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`ifndef DMEM
`define DMEM

`timescale 1ns/100ps

module dmem
// n=bit length of register; r=bit length of addr to limit memory and not crash your verilog emulator
    #(parameter n = 32, parameter r = 6)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic           clk, write_enable,
    input  logic [(n-1):0] d_add, d_write_data,
    output logic [(n-1):0] out_data
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] RAM[0:(2**r-1)];
//data reading
    assign out_data = RAM[d_add[(n-1):2]]; // word aligned (ignores lower 2 bits of address)

//data writing
    always @(posedge clk) // write on posedge
        if (write_enable) RAM[d_add[(n-1):2]] <= d_write_data;

endmodule

`endif // DMEM