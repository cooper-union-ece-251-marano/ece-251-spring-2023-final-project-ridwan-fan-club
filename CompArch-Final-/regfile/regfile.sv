`ifndef REGFILE
`define REGFILE

`timescale 1ns/100ps

module regfile
    // n=bit length of register; r=bit length of addr of registers
    #(parameter n = 32, parameter r = 5)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, 
    input  logic        write_en, 
    input  logic [(r-1):0]  read_add_1, read_add_2, write_add, 
    input  logic [(n-1):0] write_data, 
    output logic [(n-1):0] read_data_1, read_data_2
    );
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] rf[(2**5-1):0];

    // read two ports combinationally
    // write third port on rising edge of clk if write_en

    always @(posedge clk) begin
        if (write_en) rf[write_add] <= write_data;	
    end

    assign read_data_1 = (read_add_1 != 0) ? rf[read_add_1] : 0;
    assign read_data_2 = (read_add_2 != 0) ? rf[read_add_2] : 0;
endmodule

`endif // REGFILE