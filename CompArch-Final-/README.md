# Our Computer Architecture Final Project

This CPU is designed to implement a subset of the RISC-V instruction set. All code compiled to run on our CPU will (hopefully) also be fully functional on a complete RISC-V Processor. 

pg 1 ISA

Base Integer Instruction Set                                             
Name    FMT    Description (in Verilog)                                  
add      R     R[rd] = R[rs1] + R[rs2]
addi     I     R[rd] = R[rs1] + imm
and      R     R[rd] = R[rs1] & R[rs2]
beq      SB    if (R[rs1] == R[rs2]) --> PC = PC + {imm,1b'0}
jal      UJ    R[rd] = PC + 4, PC = PC + {imm,1b'0}
lw       I     R[rd] = {32'bM[](31),M[R[rs1] + imm](31:0)]
or       R     R[rd] = R[rs1] | R[rs2]
slt      R     R[rd] = (R[rs1] < R[rs2])? 1:0
sub      R     R[rd] = R[rs1] - R[rs2]
sw       S     M[R[rs1] + imm](31:0) = R[rs2](31:0)
xor      R     R[rd] = R[rs1] ^ R[rs2]

Arithmetic Core Instruction Set (Multiply Extension)
Name    FMT    Description (in Verilog)
mul      R     R[rd] = (R[rs1] * R[rs2])(63:0)
mulh     R     R[rd] = (R[rs1] * R[rs2])(127:64)
div      R     R[rd] = (R[rs1] / R[rs2])
rem      R     R[rd] = (R[rs1] % R[rs2])

Core Instruction Format
![Instruction Format](https://github.com/Manhimliu/CompArch-Final-/assets/132189892/cbee7ada-d159-4970-b066-f11497a474d1)


pg 2 ISA

Instructions and opcodes
![Instruction Opcodes](https://github.com/Manhimliu/CompArch-Final-/assets/132189892/0be711ab-fe93-4a79-ac1a-822afd9f746c)

Register Name and Convention
![registers](https://github.com/Manhimliu/CompArch-Final-/assets/132189892/cf4a7b5c-4a52-4198-ab21-e457d647a55c)

Memory Allocation

![memory allocation](https://github.com/Manhimliu/CompArch-Final-/assets/132189892/595e1a8f-9d49-4fa6-b6e6-319df1b32373)

Unfortunately, Vaibhav ran into a family emergency last weekend that ultimately meant that our CPU could not be completed to full specification. However, we have a semi-working assembler, which accepts all non-branch instructions and converts them to machine code. A sample .asm file is provided that demonstrates this functionality. 


