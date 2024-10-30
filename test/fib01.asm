; fib(40)

; $3 always stores the top of the stack (which grows down)
li $3 0x00000080

; push 12 (stored in $1) to stack
li $1 0xc
li $0 0x4
sub $3 $3 $0
sw $1 $3

; push 41 (stored in $1) to stack
li $1 0x29
li $0 0x4
sub $3 $3 $0
sw $1 $3

; pop values from stack
lw $2 $3
li $0 0x4
add $3 $3 $0
lw $1 $3
li $0 0x4
add $3 $3 $0
add $0 $1 $2


halt
