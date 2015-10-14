
;NUMBER GENERATOR

RANDGEN:         ; generate a rand no using the system time
RANDSTART:
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 10    
   div  cx       ; here dx contains the remainder of the division - from 0 to 9

   add  dl, '0'  ; to ascii from '0' to '9'
   mov ah, 2h   ; call interrupt to display a value in DL
   int 21h    
RET    

;INTENSITY GRADER

section .data                           ;Data segment
   userMsg db 'Please enter a number: ' ;Ask the user to enter a number
   lenUserMsg equ $-userMsg             ;The length of the message
   dispMsg db 'You have entered: '
   lenDispMsg equ $-dispMsg                 

section .bss           ;Uninitialized data
   num resb 5
	
section .text          ;Code Segment
   global _start
	
_start:                ;User prompt
   mov eax, 4
   mov ebx, 1
   mov ecx, userMsg
   mov edx, lenUserMsg
   int 80h

   ;Read and store the user input
   mov eax, 3
   mov ebx, 2
   mov ecx, num  
   mov edx, 5          ;5 bytes (numeric, 1 for sign) of that information
   int 80h
	
   ;Output the message 'The entered number is: '
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int 80h  

   ;Output the number entered
   mov eax, 4
   mov ebx, 1
   mov ecx, num
   mov edx, 5
   int 80h  
    
   ; Exit code
   mov eax, 1
   mov ebx, 0
   int 80h
