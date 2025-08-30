mys SEGMENT PARA 'full'
    ORG 0100H
    ASSUME CS: mys, DS: mys, SS: mys
start: JMP TRIANGLE

nonPrimeOrEvenSum DB 15 DUP(?)
primeOddSum DB 15 DUP(?)
MAX DB 50
i_index DW 0
j_index DW 0
squared DW 0
prime DB 1

TRIANGLE PROC NEAR
    XOR SI, SI                         ; Initialize SI to 0
    XOR DI, DI                         ; Initialize DI to 0
    MOV SI, 1
    MOV DI, 1

START_OUTER_LOOP:
START_INNER_LOOP:
    ; Calculate A^2 + B^2
    MOV AX, SI                         ; Load A into AX
    MUL AX                             ; AX = A²
    MOV squared, AX                    ; Store A²
    MOV AX, DI                         ; Load B into AX
    MUL AX                             ; AX = B²
    ADD squared, AX                    ; squared = A² + B²

    ; Find the hypotenuse by calculating the square root of squared
    CALL SQUARE_ROOT                   ; Result stored in CX (hypotenuse)
    CMP CX, 50                         ; Check if hypotenuse > 50
    JAE END_INNER_LOOP                 ; Skip inner loop if hypotenuse >= 50
    MOV AX, SI
    ADD AX, DI                         ; AX = SI + DI
    TEST AX, 1                         ; Check if sum is even (last bit 0)
    JZ EVEN_SUM                        ; Jump to EVEN_SUM if sum is even

ODD_SUM:
    CALL CHECK_PRIME				   ; Call CHECK_PRIME if the sum is odd
    CMP prime, 1                       ; Check if prime is set to 1
    JNE NOT_PRIME_ODD				   ; If prime and odd, assign to primeOddSum
    CMP i_index, 15                    ; Check if i_index < 15
    JAE END_INNER_LOOP                 ; Exit inner loop if i_index >= 15
    MOV BX, i_index
    MOV primeOddSum[BX], CL            ; Store hypotenuse in primeOddSum
    INC i_index                        ; Increment i_index
    JMP END_INNER_LOOP                 ; End loop

NOT_PRIME_ODD:
    ; If not prime but odd, assign to nonPrimeOrEvenSum
    CMP j_index, 15                    ; Check if j_index < 15
    JAE END_INNER_LOOP                 ; Exit inner loop if j_index >= 15
    MOV BX, j_index
    MOV nonPrimeOrEvenSum[BX], CL      ; Store hypotenuse in nonPrimeOrEvenSum
    INC j_index                        ; Increment j_index
    JMP END_INNER_LOOP

EVEN_SUM:
    ; Assign to nonPrimeOrEvenSum if sum is even
    CMP j_index, 15                    ; Check if j_index < 15
    JAE END_INNER_LOOP                 ; Exit inner loop if j_index >= 15
    MOV BX, j_index
    MOV nonPrimeOrEvenSum[BX], CL      ; Store hypotenuse in nonPrimeOrEvenSum
    INC j_index                        ; Increment j_index

END_INNER_LOOP:
    INC DI
    CMP DI, 50
    JB START_INNER_LOOP
    INC SI
    MOV DI, SI
    DEC MAX
    CMP MAX, 0
    JA START_OUTER_LOOP

    MOV AH, 4CH
    INT 21H
    RET
TRIANGLE ENDP

SQUARE_ROOT PROC NEAR
    MOV AX, squared                    ; Load squared value
    XOR CX, CX                         ; Clear CX (root counter)
    MOV BX, 1
L2:
    SUB AX, BX						   ; sub BX(odd numbers) from the squared value
    ADD BX, 2
    INC CX
    CMP AX, 0						   ; iterate until AX is bigger than 0
    JGE L2
    DEC CX                             ; CX now holds the integer square root
    RET
SQUARE_ROOT ENDP

CHECK_PRIME PROC NEAR
    MOV prime, 1                       ; Assume number is prime initially
    CMP CX, 2                          ; If CX < 2, not prime
    JB NOT_PRIME
    JE END_PRIME                       ; If CX == 2, its prime

    MOV BX, 2                          ; Start divisor at 2
CHECK_LOOP:
    MOV AX, CX                         ; Load CX
    XOR DX, DX                         ; Clear DX for division
    DIV BX                             ; AX / BX, remainder in DX
    CMP DX, 0                          ; Check if remainder is 0
    JE NOT_PRIME                       ; If remainder is 0, CX is not prime

    INC BX                             ; Increment divisor
    MUL BX                             ; BX * BX to check against CX
    CMP AX, CX                         ; Compare BX * BX with CX
    JA END_PRIME                       ; If BX * BX > CX, CX is prime

    MOV AX, CX                         ; Restore CX in AX
    JMP CHECK_LOOP                     ; Repeat loop

NOT_PRIME:
    MOV prime, 0                       ; Mark as not prime
END_PRIME:
    RET
CHECK_PRIME ENDP

mys ENDS
END start
