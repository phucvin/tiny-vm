; fib(40)

; $3 always stores the top of the stack (which grows down)
    li $3 0x00000080

; push return address
    li $1 end
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; push argument n=2 to stack
    li $1 0x1
    li $0 0x4
    sub $3 $3 $0
    sw $1 $3
; call fib
    li $0 fib
    jr $0
end:
    li $6 0xab
; pop value from stack
    lw $4 $3
    li $0 0x4
    add $3 $3 $0
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
; pop return address from stack to $2
    lw $2 $3
    li $0 0x4
    add $3 $3 $0
; push random result to stack
    li $1 0xfc
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