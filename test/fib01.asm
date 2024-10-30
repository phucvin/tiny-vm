; fib(40)

; $3 always stores the top of the stack (which grows down)
    li $3 0x000004000

; push return address
    li $1 end
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; push argument n=30 to stack
    li $1 0x1e
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; call fib
    li $0 fib
    jr $0
end:
; pop value from stack to $0
    lw $0 $3
    li $1 0x4
    add $3 $3 $1
; clear all other registers and halt
    li $1 0x0
    li $2 0x0
    li $3 0x0
    halt

fib:
; pop argument n from stack
    lw $1 $3
    li $0 0x4
    add $3 $3 $0
; if n < 2 goto base_case else goto/fallthrough recursive_case
    li $2 base_case
    li $0 0x0
    beq $1 $0 $2
    li $0 0x1
    beq $1 $0 $2
recursive_case:
; push --n to stack for later use
    li $0 0x1
    sub $1 $1 $0
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; push return address
    li $2 rc01
    li $0 0x4
    sub $3 $3 $0
    sw $2 $3
; push argument n=--n to stack
    li $0 0x1
    sub $1 $1 $0
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; call fib
    li $0 fib
    jr $0
rc01:
; swap top 2 elements in stack
    li $0 0x4
    lw $1 $3
    add $3 $3 $0
    lw $2 $3
    add $3 $3 $0
    sub $3 $3 $0
    sw $1 $3
    sub $3 $3 $0
    sw $2 $3
; push return address
    li $2 rc02
    li $0 0x4
    sub $3 $3 $0
    sw $2 $3
; swap top 2 elements in stack
    li $0 0x4
    lw $1 $3
    add $3 $3 $0
    lw $2 $3
    add $3 $3 $0
    sub $3 $3 $0
    sw $1 $3
    sub $3 $3 $0
    sw $2 $3
; call fib
    li $0 fib
    jr $0
rc02:
; pop results from stack and add to $1
    lw $1 $3
    li $0 0x4
    add $3 $3 $0
    lw $2 $3
    li $0 0x4
    add $3 $3 $0
    add $1 $1 $2
; pop return address from stack to $2
    lw $2 $3
    li $0 0x4
    add $3 $3 $0
; push added result (now in $1) to stack
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; return
    jr $2
base_case:
; pop return address from stack to $2
    lw $2 $3
    li $0 0x4
    add $3 $3 $0
; push n (still in $1) to stack
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; return
    jr $2