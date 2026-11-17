# Test 02: addi, addiu, addu, andi, ori, lui, sll, srl, $zero
# Casos: addi neg, li/move, bit15=1, shamt=0/!=0, srl negativo, $zero
.text
main:
    # addi negativo (10 + (-3) = 7)
    li $t0, 10
    addi $a0, $t0, -3
    jal print_hex

    # addiu via li (10 + (-3) = 7)
    li $t0, 10
    addiu $a0, $t0, -3
    jal print_hex

    # addu via move (10 + 10 = 20)
    li $t0, 10
    move $t1, $t0
    addu $a0, $t0, $t1
    jal print_hex

    # andi bit15 (0xFFFF8000 & 0x8000 = 0x00008000)
    li $t0, 0xFFFF8000
    andi $a0, $t0, 0x8000
    jal print_hex

    # ori bit15 (0 | 0x8000 = 0x00008000)
    li $t0, 0
    ori $a0, $t0, 0x8000
    jal print_hex

    # lui bit15 (0x80000000)
    lui $a0, 0x8000
    jal print_hex

    # sll shamt = 0 (5)
    li $t0, 5
    sll $a0, $t0, 0
    jal print_hex

    # sll shamt != 0 (5 << 4 = 80 = 0x50)
    li $t0, 5
    sll $a0, $t0, 4
    jal print_hex

    # srl negativo (0x80000000 >> 4 = 0x08000000)
    li $t0, 0x80000000
    srl $a0, $t0, 4
    jal print_hex

    # $zero bloqueado (sigue siendo 0)
    addi $zero, $zero, 99
    addi $a0, $zero, 0
    jal print_hex

    li $v0, 10
    syscall

# --- Subrutina print_hex ---

print_hex:
    move $t0, $a0
    li $t1, 8
loop_hex:
    srl $t2, $t0, 28
    li $t3, 10
    slt $t4, $t2, $t3
    bne $t4, $zero, is_digit
    addi $t2, $t2, 87
    j print_hex_char
is_digit:
    addi $t2, $t2, 48
print_hex_char:
    move $a0, $t2
    li $v0, 11
    syscall
    sll $t0, $t0, 4
    addi $t1, $t1, -1
    bne $t1, $zero, loop_hex
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra