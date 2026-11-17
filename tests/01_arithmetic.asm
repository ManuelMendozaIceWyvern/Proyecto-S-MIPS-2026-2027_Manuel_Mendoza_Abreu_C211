# Test 01: add, sub, and, or, slt, slti
# Casos: add pos/neg, sub neg, and/or bits altos, slt/slti (1 y 0, con signo)
.text
main:
    # add positivos (5 + 3 = 8)
    li $t0, 5
    li $t1, 3
    add $a0, $t0, $t1
    jal print_hex

    # add negativos (-5 + 3 = -2)
    li $t0, -5
    li $t1, 3
    add $a0, $t0, $t1
    jal print_hex

    # sub negativo (5 - (-3) = 8)
    li $t0, 5
    li $t1, -3
    sub $a0, $t0, $t1
    jal print_hex

    # and bits altos (0xFFFF0000 & 0x0000FFFF = 0)
    li $t0, 0xFFFF0000
    li $t1, 0x0000FFFF
    and $a0, $t0, $t1
    jal print_hex

    # or bits altos (0xFFFF0000 | 0x0000FFFF = 0xFFFFFFFF)
    li $t0, 0xFFFF0000
    li $t1, 0x0000FFFF
    or $a0, $t0, $t1
    jal print_hex

    # slt con signo (-1 < 1 = 1)
    li $t0, -1
    li $t1, 1
    slt $a0, $t0, $t1
    jal print_hex

    # slt con signo (1 < -1 = 0)
    li $t0, 1
    li $t1, -1
    slt $a0, $t0, $t1
    jal print_hex

    # slti con signo (-5 < -10 = 0)
    li $t0, -5
    slti $a0, $t0, -10
    jal print_hex

    # Terminar
    li $v0, 10
    syscall

# --- Subrutina para imprimir $a0 en Hex y un salto de línea ---

print_hex:
    move $t0, $a0
    li $t1, 8
loop_hex:
    srl $t2, $t0, 28
    li $t3, 10
    slt $t4, $t2, $t3
    bne $t4, $zero, is_digit
    addi $t2, $t2, 87  # 'a' - 10 = 87
    j print_hex_char
is_digit:
    addi $t2, $t2, 48  # '0'
print_hex_char:
    move $a0, $t2
    li $v0, 11
    syscall
    sll $t0, $t0, 4
    addi $t1, $t1, -1
    bne $t1, $zero, loop_hex
    # Salto de línea
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra