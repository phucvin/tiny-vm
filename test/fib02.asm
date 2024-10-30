; fib(40)

; $3 always stores the top of the stack (which grows down)
    li $3 0x000004000

; push return address
    li $1 end
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; $0 as argument n=30
    li $0 0x1e
; call fib
    j fib
end:
; return value is in $0, clear all other registers and halt
    li $1 0x0
    li $2 0x0
    li $3 0x0
    halt

fib:
; n is in $0
; if n < 2 goto base_case else goto/fallthrough recursive_case
    li $2 base_case
    li $1 0x0
    beq $0 $1 $2
    li $1 0x1
    beq $0 $1 $2
recursive_case:
; save $0 to stack
    li $1 0x4
    sub $3 $3 $1
    sw $0 $3
; call fib(n-1)
    li $2 rc01
    li $1 0x4
    sub $3 $3 $1
    sw $2 $3
    li $1 0x1
    sub $0 $0 $1
    j fib
rc01:
; temporarily save fib(n-1) result (currently in $0) to $2
    li $2 0x0
    add $2 $0 $2
; restore $0 (i.e. n)
    lw $0 $3
    li $1 0x4
    add $3 $3 $1
; save fib(n-1) result in $2 to stack
    li $1 0x4
    sub $3 $3 $1
    sw $2 $3
; call fib(n-2)
    li $2 rc02
    li $1 0x4
    sub $3 $3 $1
    sw $2 $3
    li $1 0x2
    sub $0 $0 $1
    j fib
rc02:
; fib(n-2) result is now in $0
; restore fib(n-1) result from stack to $2, add them to $0
    lw $2 $3
    li $1 0x4
    add $3 $3 $1
    add $0 $0 $2
; pop return address from stack to $2
    lw $2 $3
    li $1 0x4
    add $3 $3 $1
; return
    jr $2
base_case:
; set $0 to n which is already the case
; pop return address from stack to $2
    lw $2 $3
    li $1 0x4
    add $3 $3 $1
; return
    jr $2