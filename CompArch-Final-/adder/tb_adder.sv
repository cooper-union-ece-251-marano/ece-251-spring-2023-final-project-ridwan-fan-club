//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Manhim Liu and Vaibhav Hariani
// 
//     Create Date: 2023-05-08
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "adder.sv"

module test_full_adder;
  reg [31:0] x;
  reg [31:0] y;
  reg cin;
  wire [31:0] sumout;
  wire cout;
  integer i;
  integer j;
  
  thirty_two_bit_adder ma (x,y,cin,sumout,cout);
  initial begin
    x = 0;
    y = 0;
    cin = 0;
    $monitorb("x=%0h",x, " y=%0h",y, " carry in =",cin, " sumout= %0h",sumout, " carryout= ",cout);

    for (i = 2**32-10; i <2**32; i = i + 1) begin
      #10 for (j=2**32-10; j <2**32; j = j + 1) begin
        #10 x <= i;
        y <= j;
        cin = 0;
      end
    end
    
    for (i = 2**32-10; i <2**32; i = i + 1) begin
      #10 for (j = 2**32-10; j <2**32; j = j + 1) begin
        #10 x <= i;
        y <= j;
        cin = 1;
      end
    end
  end
endmodule 

`endif


    