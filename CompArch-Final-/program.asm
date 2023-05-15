#compute first twelve numbers of fibonacci sequence

       .text
       addi $r5, $r0, 12
       addi $r6, $r0, 1
       sw $r0, 0($r7)
       sw $r6, 4($r7)
       addi $r30, $r0, 1
loop:  lw $r28, 0($r7)
       lw $r29, 4($r7)
       add $r7, $r28, $r29
       sw $r7, 8($r7)
       addi $r7, $r7, 4
       sw $r29, $r28
       sw $r7, $r29
       addi $r5, $r5, -1
       slt $r31, $r30, $r5
       beq $r31, $r30, loop
       addi $r10, $r0, 10
       syscall


