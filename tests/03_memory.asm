# Test 03: lw, sw, lb, lbu, sb
# Casos: lw/sw pos y neg, lb/lbu bit7=1 en dist pos, sb en las 4 pos
.text
main:
    # sw/lw con desplazamiento positivo
    li $t0, 0x12345678
    li $s1, 0x1000          # <-- CAMBIADO A $s1
    sw $t0, 0($s1)
    lw $a0, 0($s1)
    jal print_hex

    # sw/lw con desplazamiento negativo
    li $t0, 0x87654321
    li $s1, 0x1010          # <-- CAMBIADO A $s1
    sw $t0, -4($s1)
    lw $a0, -4($s1)
    jal print_hex

    # lb y lbu sobre byte con bit 7 = 1 (0x80)
    li $t2, 0x80
    li $s1, 0x1020          # <-- CAMBIADO A $s1
    sb $t2, 1($s1)   
    lb $a0, 1($s1)   
    jal print_hex
    lbu $a0, 1($s1)  
    jal print_hex

    # sb en las 4 posiciones y lw para comprobar
    li $s1, 0x1030          # <-- CAMBIADO A $s1
    sw $zero, 0($s1) 
    li $t2, 0x11
    sb $t2, 0($s1)
    li $t2, 0x22
    sb $t2, 1($s1)
    li $t2, 0x33
    sb $t2, 2($s1)
    li $t2, 0x44
    sb $t2, 3($s1)
    lw $a0, 0($s1)   
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