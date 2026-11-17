# Programa mínimo: imprimir 'H' y terminar
# Solo usa addi + syscall 11 + syscall 10
addi $a0, $zero, 72    # 'H' = 72 en ASCII
addi $v0, $zero, 11    # syscall 11 = print char
syscall
addi $v0, $zero, 10    # syscall 10 = exit
syscall