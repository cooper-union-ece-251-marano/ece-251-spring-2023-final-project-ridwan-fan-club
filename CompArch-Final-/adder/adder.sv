//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Manhim Liu and Vaibhav Hariani
// 
//     Create Date: 2023-05-08
//     Module Name: Adder
//     Description: simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module full_adder (x, y, cin, sumout, cout);
  input x,y;
  input cin;
  output sumout;
  output cout;
  wire xored;
  xor(xored,x,y);
  xor(sumout,xored,cin);
  wire anded;
  and(anded,x,y);
  wire anded1;
  and(anded1,cin,xored);
  or(cout,anded,anded1);
endmodule 

module adder(x, y, sumout);
  input [31:0] x;
  input [31:0] y;
  output [31:0] sumout;
  wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30,w31,w32;

  full_adder s0 (x[0],y[0],0,sumout[0],w1);
  full_adder s1 (x[1],y[1],w1,sumout[1],w2);
  full_adder s2 (x[2],y[2],w2,sumout[2],w3);
  full_adder s3 (x[3],y[3],w3,sumout[3],w4);
  full_adder s4 (x[4],y[4],w4,sumout[4],w5);
  full_adder s5 (x[5],y[5],w5,sumout[5],w6); 
  full_adder s6 (x[6],y[6],w6,sumout[6],w7);
  full_adder s7 (x[7],y[7],w7,sumout[7],w8);
  full_adder s8 (x[8],y[8],w8,sumout[8],w9);
  full_adder s9 (x[9],y[9],w9,sumout[9],w10);
  full_adder s10 (x[10],y[10],w10,sumout[10],w11);
  full_adder s11 (x[11],y[11],w11,sumout[11],w12);
  full_adder s12 (x[12],y[12],w12,sumout[12],w13);
  full_adder s13 (x[13],y[13],w13,sumout[13],w14);
  full_adder s14 (x[14],y[14],w14,sumout[14],w15);
  full_adder s15 (x[15],y[15],w15,sumout[15],w16);
  full_adder s16 (x[16],y[16],w16,sumout[16],w17);
  full_adder s17 (x[17],y[17],w17,sumout[17],w18);
  full_adder s18 (x[18],y[18],w18,sumout[18],w19);
  full_adder s19 (x[19],y[19],w19,sumout[19],w20);
  full_adder s20 (x[20],y[20],w20,sumout[20],w21);
  full_adder s21 (x[21],y[21],w21,sumout[21],w22);
  full_adder s22 (x[22],y[22],w22,sumout[22],w23);
  full_adder s23 (x[23],y[23],w23,sumout[23],w24);
  full_adder s24 (x[24],y[24],w24,sumout[24],w25);
  full_adder s25 (x[25],y[25],w25,sumout[25],w26);
  full_adder s26 (x[26],y[26],w26,sumout[26],w27);
  full_adder s27 (x[27],y[27],w27,sumout[27],w28);
  full_adder s28 (x[28],y[28],w28,sumout[28],w29);
  full_adder s29 (x[29],y[29],w29,sumout[29],w30);
  full_adder s30 (x[30],y[30],w30,sumout[30],w31);
  full_adder s31 (x[31],y[31],w31,sumout[31],w32);
endmodule 

`endif