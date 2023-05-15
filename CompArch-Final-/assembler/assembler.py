
## opens the assembly file to be converted to machine code.
assembly = open("assembler/assembly.asm", 'r')
output = open('assembler/output_exe', 'w')
##creating arrays to set opcodes & funccodes


instr_set_type = {"add" : "R",
                  "sub" : "R",
                  "slt" : "R",
                  "or"  : "R",
                  "and" : "R",
                  "xor" : "R",
                  "mul" : "R",
                  "div" : "R",
                  "mulh": "R",
                  "rem" : "R",
                  "lw"  : "I",
                  "addi": "I",
                  "beq" : "SB",
                  "jal" : "UJ",
                  "sw"  : "S"}
                   #Dictionary

opcodes = {"add" : "0110011",
            "sub" : "0110011",
            "slt" : "0110011",
            "or"  : "0110011",
            "and" : "0110011",
            "xor" : "0110011",
            "mul" : "0110011",
            "div" : "0110011",
            "mulh": "0110011",
            "rem" : "0110011",
            "lw"  : "0000011",
            "addi": "0001101",
            "beq" : "1100011",
            "jal" : "1101111",
            "sw"  : "0100011"}

FUNC3_dic = {"add" : "000",
            "sub" : "000",
            "slt" : "010",
            "or"  : "110",
            "and" : "111",
            "xor" : "100",
            "mul" : "000",
            "div" : "010",
            "mulh": "001",
            "rem" : "011",
            "lw"  : "010",
            "addi": "000",
            "beq" : "000",
            "sw" : "010"}

FUNC7_dic = {"add": "0000000",
            "sub" : "0000010",
            "slt" : "0000000",
            "or"  : "0000000",
            "and" : "0000000",
            "xor" : "0000000",
            "mul" : "0000001",
            "div" : "0000001",
            "mulh": "0000001",
            "rem" : "0000001",
            }

REG = {"zero": "00000",
       "ra"  : "00001",
       "sp" : "00010",
       "gp" : "00011",
       "tp" : "00100",
       "t0" : "00101",
       "t1" : "00110",
       "t2" : "00111",
       "s0" : "01000",
       "s1" : "01001",
       "a0": "01010",
       "a1": "01011",
       "a2": "01100",
       "a3": "01101",
       "a4": "01110",
       "a5": "01111",
       "a6": "10000",
       "a7" : "10001",
       "s2" : "10010",
       "s3" : "10011",
       "s4" : "10100",
       "s5" : "10101",
       "s6" : "10110",
       "s7" : "10111",
       "s8" : "11000",
       "s9" : "11001",
       "s10" : "11010",
       "s11" : "11011",
       "t3" : "11100",
       "t4" : "11101",
       "t5" : "11110",
       "t6" : "11111",
       }

def decimalToBinary(n,l):
    scale = 16
    res = bin(int(n, scale)).replace("b1","")
    res = res.replace("0b","")
    return res.zfill(l)



lineval = 0

while True:
    lineval += 1
    line = assembly.readline()
    if not line:
        break
    line = line.replace(",","")
    list = line.split()
    components = line.split() #breaks line into the components necessary
    operation = components[0]
    opcode = opcodes[operation]
    
    try:
        op_type = instr_set_type[operation]
        match op_type:
            case "R":
                FUNC3 = FUNC3_dic[operation]
                FUNC7 = FUNC7_dic[operation]
                RD = REG[components[1]]
                RS1 = REG[components[2]]
                RS2 = REG[components[3]]
                output.writelines(FUNC7+RS2+RS1+FUNC3+RD+opcode+"\n")

            case "I":
                FUNC3 = FUNC3_dic[operation]
                RD = REG[components[1]]
                if opcode == "0001101":
                    RS1 = REG[components[2]]
                    IMM = components[3]
                else:
                    immcombo = components[2].replace(")","")
                    combo = immcombo.split('(')
                    RS1 = REG[combo[1]]
                    IMM = combo[0]
                IMM = decimalToBinary(IMM,12)
                output.writelines(IMM+RS1+FUNC3+RD+opcode+"\n")

            case "UJ":
                RD = "00001" #always the case for RISC-V, only UJ is JAL
                IMM = decimalToBinary(components[1],20)
                output.writelines(IMM+RD+opcode+"\n")

            case "S":
                FUNC3 = FUNC3_dic[operation]
                RS2 = REG[components[1]]
                immcombo = components[2].replace(")","")
                combo = immcombo.split('(')
                RS1 = REG[combo[1]]
                IMM = decimalToBinary(combo[0],12)
                Imm1 = IMM[5:11]
                Imm2 = IMM[0:4]
                output.writelines(Imm1+RS2+RS1+FUNC3+Imm2+opcode+"\n")
                
            case "SB":
                FUNC3 = FUNC3_dic[operation]
                RS2 = REG[components[1]]
                RS1 = REG[components[2]]
                IMM = components[3]
                IMM = decimalToBinary(combo[0],12)
                Imm1 = IMM[4:11]
                Imm2 = IMM[0:5]
                output.writelines(Imm1+RS2+RS1+FUNC3+Imm2+opcode+"\n")

            case _:
                print("UNSUPPORTED INSTRUCTION ON LINE %d", lineval)
                break

    except:
        print("ERROR ON LINE: %d" % lineval)
        break 
           
assembly.close()
output.close()