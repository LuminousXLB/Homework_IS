code_seg segment
    ; Control table - Map Scan Code to ASCII
    KEYCODE DB 71H, 77H, 65H, 72H, 74H, 79H, 75H, 69H, 6FH, 70H, 0H, 0H, 0H, 0H, 61H, 73H, 64H, 66H, 67H, 68H, 6AH, 6BH, 6CH, 0H, 0H, 0H, 0H, 0H, 7AH, 78H, 63H, 76H, 62H, 6EH, 6DH
	COUNTER DW 1
	DISABLE DB " -- Keyboard Disabled.", 0DH, 0AH, "$"
	ENABLE 	DB "Keyboard Enabled -- $"
	assume	cs:code_seg, ds:code_seg
; ====================================================================== ;
; **************** My ISR for int 09H ********************************** ;
isr_09:
	push    ax
    push    bx
    push    dx
    push    ds
    sti

    ; Receive and Respond Keyboard Interrupt
    ; -- Copied from the PPT
    in      al, 060h    ; get key code
    push    ax          ; save it
    in      al, 061h    ; get current control
    mov     ah, al      ; save PB control
    or      al, 80h     ; set keyboard bit
    out     061h, al    ; keyboard acknowledge
    xchg    ah, al      ; get back PB
    out     061h, al    ; reset PB control
    pop     ax          ; get back code
    ; -- We've got KeyCode in AL

    ; Table Driven - use BX as the index
    mov     bx, seg KEYCODE
    mov     ds, bx 		; Set DS
    xor     bx, bx
    mov     bl, al      ; Save Scan Code to BX

    ; Validate
    cmp     bx, 32h     ; BX(Scan Code) should be in [0x10, 0x32]
    jg      isr_09_ret
    sub     bx, 10h     ; Index of the item in the control table
    jl      isr_09_ret
    mov     dx, [bx + offset KEYCODE]
    ; We've got ASCII in DL

    inc     dl          ; ASCII += 1    [0x61(a), 0x7A(z)]
    cmp     dl, 'b'
    jl      isr_09_ret
    cmp     dl, 'z'
    jg      back_to_a

display:
    mov     ah, 02h     ; Ready for output, DL has ASCII in it
    int     21h

isr_09_ret:
	cli
    mov     al, 20h     ; Non-Specific EOI command
    out     20h, al
    pop     ds
    pop     dx
    pop     bx
    pop     ax
    iret

back_to_a:
	mov 	dl, 'a'
	jmp 	display
; **************** End of my ISR for int 09H *************************** ;
; ====================================================================== ;
; **************** My ISR for int 1CH ********************************** ;
isr_1c:
	push	ax
	push	bx
	push	ds
	sti

	mov		ax, seg COUNTER
	mov		ds, ax
	mov		bx, offset COUNTER
	mov		ax, [bx]
	dec 	ax
	je 		reset

	mov 	[bx], ax
	cmp 	ax, 182
	jne 	isr_1c_ret
	; Remove the interrupt mask
	in  	al, 21h
	and 	al, NOT 02h
	out 	21h, al

	mov 	dx, offset ENABLE
	mov 	ah, 9
	int 	21h
	jmp 	isr_1c_ret

reset:
	mov 	ax, 182*2
	mov 	[bx], ax
	; Set the interrupt mask
	in  	al, 21h
	or  	al, 02h
	out 	21h, al

	mov 	dx, offset DISABLE
	mov 	ah, 9
	int 	21h

isr_1c_ret:
	cli
	mov 	al, 20h ; Non-Specific EOI command
	out 	20h, al
	pop 	ds
	pop 	bx
	pop 	ax
	iret
	nop
; **************** End of my ISR for int 1CH *************************** ;
end_of_isr:
; ====================================================================== ;
	MSG 	DB 0DH, 0AH
	M1 		DB "************************************************", 0DH, 0AH
	M2 		DB "**  IMPORTANT                                 **", 0DH, 0AH
	M3 		DB "**      Run in DosBox Please                  **", 0DH, 0AH
	M4 		DB "**                                            **", 0DH, 0AH
	M5 		DB "**                    taraxacum, IS - SJTU    **", 0DH, 0AH
	M6 		DB "**                          June 6, 2018      **", 0DH, 0AH
	M7 		DB "************************************************", 0DH, 0AH, "$"
; ====================================================================== ;
; **************** Install instructions ******************************** ;
start:
	mov		ax, code_seg
	mov		ds, ax

	xor 	ax, ax
	mov 	es, ax 		; Set es = 0

	mov 	dx, offset MSG
	mov 	ah, 9
	int 	21h

    cli
    mov     bx, 9*4 	; int 09H
    mov     ax, offset isr_09
    mov     es:[bx], ax
    mov     ax, seg isr_09
    mov     es:[bx+2], ax

    mov     bx, 1ch*4 	; int 09H
    mov     ax, offset isr_1c
    mov     es:[bx], ax
    mov     ax, seg isr_1c
    mov     es:[bx+2], ax
    sti

    ; Terminate and Stay Resident
    mov     dx, offset end_of_isr
    mov     cl, 4
    shr     dx, cl
    add     dx, 11h
    mov     ah, 31h
    xor     al, al
    int     21h
; **************** End of Install instructions ************************* ;
; ====================================================================== ;
code_seg ends
	end start
