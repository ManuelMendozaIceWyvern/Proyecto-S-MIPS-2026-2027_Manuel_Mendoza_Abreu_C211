# Test 05: jal, jr (llamada a procedimiento no hoja con pila)
.text
main:
    li $a0, 10
    jal func1       # Llamada a funcion no hoja
    move $a0, $v0
    jal print_hex   # Debe imprimir 15 (10 + 5)
    
    li $v0, 10
    syscall

func1:
    # Guardar $ra en la pila (push)
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    li $a0, 10
    jal func2       # Llamar a funcion hoja
    
    # Recuperar $ra de la pila (pop)
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra          # Retornar a main

func2:
    addi $v0, $a0, 5
    jr $ra          # Retornar a func1

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