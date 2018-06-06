; ******************************************************************************
data_seg segment
    ; ARR DW 0881H, 0b28H, 926bH, 17d2H, 9557H, 1af5H, 921aH, 1892H, 1f33H, 011fH, 9841H, 13f8H, 1813H, 1a18H, 853aH, 08a5H, 8fcfH, 11efH, 0b31H, 084bH, 9608H, 1ed6H, 891eH, 8f89H, 1709H, 0437H, 8d44H, 9a8dH, 80faH, 15a0H, 9075H, 96b0H, 0e24H, 1f2eH, 953fH, 00f5H, 9320H, 8b93H, 80cbH, 9480H, 107dH, 8110H, 14e1H, 1654H, 0f16H, 9b2fH, 86bbH, 11a6H, 0943H, 1029H
    ARR DW 0026H, 0018H, 001CH, 002CH, 001FH, 0023H, 000DH, 002AH, 0027H, 0022H, 002FH, 0025H, 0005H, 0007H, 0030H, 0016H, 000AH, 0009H, 0013H, 0004H, 0002H, 0019H, 0015H, 002EH, 0020H, 0028H, 0021H, 000EH, 001BH, 0024H, 0012H, 0011H, 001EH, 0031H, 000CH, 0006H, 0032H, 001AH, 002DH, 0017H, 001DH, 000BH, 000FH, 002BH, 0010H, 0001H, 0008H, 0029H, 0014H, 0003H
    ; ARR DW 0001H, 0002H, 0003H, 0004H, 0005H, 0006H, 0007H, 0008H, 0009H, 000AH, 000BH, 000CH, 000DH, 000EH, 000FH, 0010H, 0011H, 0012H, 0013H, 0014H, 0015H, 0016H, 0017H, 0018H, 0019H, 001AH, 001BH, 001CH, 001DH, 001EH, 001FH, 0020H, 0021H, 0022H, 0023H, 0024H, 0025H, 0026H, 0027H, 0028H, 0029H, 002AH, 002BH, 002CH, 002DH, 002EH, 002FH, 0030H, 0031H, 0032H
    ; ARR DW 0032H, 0031H, 0030H, 002FH, 002EH, 002DH, 002CH, 002BH, 002AH, 0029H, 0028H, 0027H, 0026H, 0025H, 0024H, 0023H, 0022H, 0021H, 0020H, 001FH, 001EH, 001DH, 001CH, 001BH, 001AH, 0019H, 0018H, 0017H, 0016H, 0015H, 0014H, 0013H, 0012H, 0011H, 0010H, 000FH, 000EH, 000DH, 000CH, 000BH, 000AH, 0009H, 0008H, 0007H, 0006H, 0005H, 0004H, 0003H, 0002H, 0001H
    CNT EQU 50
data_seg ends
; ******************************************************************************
stack_seg segment stack
    ST DB 800h DUP(0)
    TOP EQU 800h
stack_seg ends
; ******************************************************************************
code_seg segment
    assume cs:code_seg, ds:data_seg, ss:stack_seg
start:
    mov ax, data_seg
    mov ds, ax             ; set data segment
    mov ax, stack_seg
    mov ss, ax             ; set stack segment
    mov sp, TOP            ; set the top of the stack

    mov bp, sp
    push OFFSET ARR
    push CNT
    call quiciksort
    mov sp, bp

    int 21h                ; exit

quiciksort proc near
    push bp
    push si
    mov si, sp

    mov ax, ss:[si+6]
    shl ax, 1
    sub ax, 2
    add ax, ss:[si+8]

    mov bp, sp
    push ss:[si+8]         ; bg
    push ax                ; ed
    call goqs
    mov sp, bp

    pop bp
    pop si
    ret
quiciksort endp

goqs proc near
    push bx
    push dx
    push di
    push bp
    push si                ; snapshot registers
    mov si, sp

    mov bx, ss:[si+14]     ; inf = bg
    mov di, ss:[si+12]     ; sup = ed
    ; If the array isn't long enough, set pivot = bg
    mov ax, di
    sub ax, bx
    mov bp, ax
    sub ax, 8
    jc pivot_as_bg
    ; Otherwise, sample [bg, mid, ed] and find the median
    ; Then set the median as the pivot
    ; Step 1, calculae the addr of mid
    shr bp, 2
    mov dx, bx
    shr dx, 1              ; to ensure the consistency of parity between bx & bp
    rcl bp, 1
    add bp, bx             ; bp = mid
    ; Step 2, find the median (in no more than 3 comparisons)
    ; Compare [bx(bg)] with [di(ed)]. If [bx] > [di], exchage
    ; Then compare [bp(mid)] with [bx] and [di] individually
    ; There're 3 situations as the following axis shows
    ; ---------[bx(min)]---------[di(max)]--------->
    ;     |                 |                 |
    ;   [mid]             [mid]             [mid]
    mov ax, [di]
    cmp [bx], ax           ; cmp([bg], [ed])
    jng ins_mid
    xor bx, di             ; if [bg] > [ed]
    xor di, bx
    xor bx, di             ; exchange bg, ed
ins_mid:
    mov ax, ds:[bp]        ; ax = [mid]
    cmp ax, [bx]           ; cmp([mid], [min])
    jg mid_cmp_max         ; [mid] > [min]
                           ; [mid] <= [min]
    mov bp, bx             ; pivot = min
    jmp set_pivot
mid_cmp_max:               ; [min] < [mid]
    cmp ax, [di]           ; cmp([mid], [max])
    jg mid_gt_max          ; => pivot = max(i.e. di)
    ; [mid] <= [max]
    ; mov bp, bp           ; pivot = mid
    jmp set_pivot
mid_gt_max:
    mov bp, di             ; pivot = max
    ; Now we get the addr of pivot in bp.
set_pivot:
    ; We should then save the value of pivot in dx and fill the origin space
    ; of pivot with leftmost element of the array since the blank is at the
    ; leftmost end of the array acquiescently.
    ; What has to be awared of is that the addr of bg and ed
    ; have to be fetch again from stack, since bx and di have been updated.
    mov dx, ds:[bp]
    mov bx, ss:[si+14]     ; inf = bg
    mov di, ss:[si+12]     ; sup = ed
    mov ax, [bx]
    mov ds:[bp], ax
    jmp scan1

pivot_as_bg:
    mov dx, [bx]           ; pivot = *inf0

scan1:
    ; scan from the right end to the left
    cmp bx, di
    jnc end_of_loop        ; if inf >= sup, break
    cmp [di], dx
    jc end_of_scan1        ; if [sup] < pivot, move and go scan2
    sub di, 2
    jmp scan1              ; go back to loop scan1
end_of_scan1:
    mov ax, [di]
    mov [bx], ax           ; fill the blank with [sup]
scan2:
    ; scan from the left end to the right
    cmp bx, di
    jnc end_of_loop        ; if inf >= sup, break
    cmp dx, [bx]
    jc end_of_scan2        ; if pivot < [inf], move and check loop
    add bx, 2
    jmp scan2
end_of_scan2:
    mov ax, [bx]
    mov [di], ax
    ; scan finished, whether to loop?
    cmp bx, di
    jc scan1               ; if inf < sup, go on to loop
end_of_loop:
    mov [di], dx           ; fill the blank with pivot
                           ; where bx(inf) should be equal to di(sup)
    sub bx, 2              ; bx = inf-1
    jc end_of_recursion1   ; in case that bx comes to -2
    cmp ss:[si+14], bx
    jnc end_of_recursion1  ; if bg < inf-1, execute the call
    mov bp, sp             ; sp still equals to bp here
    push ss:[si+14]        ; dump bg
    push bx                ; dump ed
    call goqs
    mov sp, bp
end_of_recursion1:
    add di, 2              ; di = sup+1
    cmp di, ss:[si+12]
    jnc end_of_recursion2  ; if bg < blank-1, execute the call
    mov bp, sp
    push di                ; dump bg
    push ss:[si+12]        ; dump ed
    call goqs
    mov sp, bp
end_of_recursion2:
    pop si                 ; recover registers
    pop bp
    pop di
    pop dx
    pop bx
    ret

goqs endp

code_seg ends
; *******************************************************************************
end start
