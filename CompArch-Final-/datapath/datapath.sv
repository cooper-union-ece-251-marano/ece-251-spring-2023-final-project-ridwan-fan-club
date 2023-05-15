//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Vaibhav Hariani & Manhim Liu
// 
//     Create Date: 2023-02-07
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 2.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../regfile/regfile.sv"
`include "../dmem/dmem.sv"
`include "../imem/imem.sv"
`include "../aludec/aludec.sv"
`include "../alu/alu.sv"
`include "../dff/dff.sv"
`include "../adder/adder.sv"
`include "../sl2/sl2.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"


module datapath
    #(parameter n = 32, parameter r = 6)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic    clk, jump, beq,mem_write,alu_src,
    input  logic    reg_dst,mem_2_reg,reg_write,
    input  logic [1:0] aluop,
    output logic [(n-1):0] opcode,
    output logic zero
    );
    //l
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] pc;
    logic [(n-1):0] pc_next,pc_plus_4;
    logic [(n-1):0] instruct;
    
    wire  [(r-1):0] reg_write_dest;
    wire  [(n-1):0] reg_write_data;
    
    wire  [(r-1):0] reg_read_add_1;
    wire  [(n-1):0] reg_read_data_1;

    wire  [(r-1):0] reg_read_add_2;
    wire  [(n-1):0] reg_read_data_2;

    wire [(n-1):0] ext_im,
    read_data_2;



    wire[3:0] alu_control;
    wire[(n-1):0] alu_output;

    wire [(n-1):0]PC_j, PC_beq;
    wire beq_control;
    wire [19:0] jump_shift;
    wire[(n-1):0] mem_read_data;

    initial begin
        pc_current <= 32'b0000;
    end
    always @(posedge clk)
    begin
        pc_current <= pc_next;
    end
//Get instruction fom imem


    imem im(.addr(pc_current),.instr(instruct));
    sl2   immsh(instruct[31:12], jump_shift); //Set jump shift
    adder pcadd1(pc, 32'b100, pc_plus_4);
    assign reg_write_dest = instruct[11:7];
    assign reg_read_add1 = instruct[19:15];
    assign reg_read_add2 = instruct[24:20];

//Register File Instantiation
    regfile regs(clk,reg_write,reg_read_add1,
    reg_read_add2,write_add,write_data,read_data_1,
    read_data_2);

//Preserve bit sign
    assign ext_im = {{20{instr[31]}},instruct[31:25],instruct[11:7]};  
//alu control
    aludec ad(instruct[14:12],instruct[31:25],aluop,alu_control);
    mux2 readdata(ext_im,reg_read_data_2,alu_src1,read_data_2);
    alu al(clk,read_data_1,read_data_2,alu_control,alu_output,zero);
//setting the next values

    assign PC_beq = pc_plus_4 + {ext_im[30:0], 2'b0};
    assign PC_j = {pc2[(n-1):(n-4)],jump_shift};
    mux2 nextr(PC_J,PC_beq,jump,pcnext);

    dmem dm (clk,write_en,ALU_out,reg_write_data,mem_read_data);

    mux2 regwrited (mem_read_data,alu_output,mem_2_reg,reg_write_data);
    assign opcode = instruct[6:0];
endmodule

`endif // DATAPATH