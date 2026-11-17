# Test 04: beq, bne, j
# Casos: beq tomado/no tomado, bne tomado/no tomado, salto hacia atras (j)
.text
main:
    li $a0, 0
    li $s0, 5       # 5 iteraciones
    
loop_back:          # Etiqueta para salto hacia atrás
    addi $a0, $a0, 1
    addi $s0, $s0, -1
    beq $s0, $zero, loop_done # beq tomado al final
    j loop_back               # j hacia atrás
loop_done:
    jal print_hex   # Debe imprimir 5 (00000005)

    # bne NO tomado (1 != 1 es falso)
    li $t0, 1
    li $t1, 1
    bne $t0, $t1, skip1
    li $a0, 0xAAAA
    jal print_hex   # Imprime AAAA
skip1:
    # bne SÍ tomado (1 != 2 es verdadero)
    li $t0, 1
    li $t1, 2
    bne $t0, $t1, skip2
    li $a0, 0xBBBB  # Esto NO debe imprimirse
    jal print_hex
skip2:
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