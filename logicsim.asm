.model small
.stack 100h
.data

	bool db ?
	fbool db ?
	sbool db ?
	obool db ?
	fromOp db 0
	
	fyCoord1 dw 36
	fyCoord2 dw 68
	fxCoord1 dw 43
	fxCoord2 dw 76	
	syCoord1 dw 138
	syCoord2 dw 170
	sxCoord1 dw 43
	sxCoord2 dw 76	
	OpyCoord1 dw 83
	OpyCoord2 dw 115
	OpxCoord1 dw 139
	OPxCoord2 dw 171	
	ryCoord1 dw 83
	ryCoord2 dw 115
	rxCoord1 dw 244
	rxCoord2 dw 276	
	
	ftext_xcoor db 46
	ftext_ycoor db 9
	stext_xcoor db 46
	stext_ycoor db 22
	Optext_xcoor db 58
	Optext_ycoor db 15
	rtext_xcoor db 71
	rtext_ycoor db 15
	
	fx1 dw 86	
	fy1 dw 36
	fx2 dw 150
	fy2 dw 67
	sx1 dw 86	
	sy1 dw 137
	sx2 dw 150
	sy2 dw 168
	ox1 dw 278	
	oy1 dw 83
	ox2 dw 340
	oy2 dw 113
	
	text_xcoor db ?
	text_ycoor db ?	
	boxxFirstCoor dw ?
	boxxLastCoor dw ?
	boxyFirstCoor dw ?
	boxyLastCoor dw ?	
	xtemp dw ?	
	ytemp dw ?		
	x_coor dw ?
	y_coor dw ?
	
	clear db "$"	
	numstr  db "$$$$$"
	comma db ",$"
	boxColor db ?
	fontColorRed db ?
	
.code	
	main proc	
		mov ax, @data
		mov ds, ax		

		call clearScreen				
		mov ax, 13h
		int 10h					
		call initVariables
		call initShapes				
		call initLines
		call initExitButton
		call setCursor				
		call mouseListener
		
		terminate:
			mov ah, 4ch
			int 21h			
	main endp	

	clearScreen proc
		
		mov ah, 06
		mov al, 00
		mov bh, 00h
		mov ch, 00
		mov cl, 00
		mov dh, 24
		mov dl, 79
		int 10h
		
		mov ah, 02h
		mov bh, 00
		mov dh, 00
		mov dl, 00
		int 10h		
		
		ret
	clearScreen endp
	
	initVariables proc
		mov fbool, 0
		mov sbool, 0
		mov obool, 0
		mov si, 1
		mov boxColor, 7
		ret
	initVariables endp
	
	initShapes proc	
						
		call setBoxNum
		
		mov cx, boxxFirstCoor
		mov xtemp, cx
		mov dx, boxyFirstCoor
		mov ytemp, dx
		
		cmp si, 3
		je operator
		jne notOperator
		
		operator:			
			mov boxColor, 2
			jmp next
			
		notOperator:
			mov boxColor, 7
			
		next:			
			call drawBox
			inc si					
			cmp si, 5
			jl initShapes		
				
		ret
	initShapes endp

	initLines proc
		
		mov cx, fxCoord2
		mov xtemp, cx
		mov dx, fyCoord2		
		sub dx, 18
		mov ytemp, dx
		
		firstLineH:			
			mov  ah, 0ch       			;SERVICE TO DRAW PIXEL.
			mov  al, 14  				;Yellow
			mov  bh, 0        			;VIDEO PAGE.
			mov  cx, xtemp
			mov  dx, ytemp
			inc xtemp
			int  10h           			;BIOS SCREEN SERVICES.	
			mov cx, xtemp
			cmp cx, 110
			jne firstLineH
		
			mov cx, fxCoord2
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp
			mov bx, fyCoord2
			sub bx, 18
			mov boxyLastCoor, bx
			add boxyLastCoor, 2
			cmp dx, boxyLastCoor
			jne firstLineH
		
		mov cx, sxCoord2
		mov xtemp, cx
		mov dx, syCoord2		
		sub dx, 18
		mov ytemp, dx
		
		secLineH:			
			mov  ah, 0ch       		;SERVICE TO DRAW PIXEL.
			mov  al, 14  				;Yellow
			mov  bh, 0        			;VIDEO PAGE.
			mov  cx, xtemp
			mov  dx, ytemp
			inc xtemp
			int  10h           			;BIOS SCREEN SERVICES.	
			mov cx, xtemp
			cmp cx, 110
			jne secLineH
		
			mov cx, sxCoord2
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp
			mov bx, syCoord2
			sub bx, 18
			mov boxyLastCoor, bx
			add boxyLastCoor, 2
			cmp dx, boxyLastCoor
			jne secLineH
			
		mov cx, fxCoord2
		add cx, 32
		mov xtemp, cx
		mov dx, fyCoord2		
		sub dx, 18
		mov ytemp, dx
		
		firstLineV:			
			mov  ah, 0ch       			;SERVICE TO DRAW PIXEL.
			mov  al, 14  				;Yellow
			mov  bh, 0        			;VIDEO PAGE.
			mov  cx, xtemp
			mov  dx, ytemp
			inc xtemp
			int  10h           			;BIOS SCREEN SERVICES.	
			mov cx, xtemp
			mov bx, fxCoord2
			add bx, 32
			mov boxxLastCoor, bx
			add boxxLastCoor, 2
			cmp cx, boxxLastCoor
			jne firstLineV
		
			mov cx, fxCoord2
			add cx, 32
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp			
			cmp dx, 88
			jne firstLineV
			
		mov cx, fxCoord2
		add cx, 32
		mov xtemp, cx
		mov dx, fyCoord2		
		add dx, 43
		mov ytemp, dx
			
		secLineV:			
			mov  ah, 0ch       			;SERVICE TO DRAW PIXEL.
			mov  al, 14  				;Yellow
			mov  bh, 0        			;VIDEO PAGE.
			mov  cx, xtemp
			mov  dx, ytemp
			inc xtemp
			int  10h           			;BIOS SCREEN SERVICES.	
			mov cx, xtemp
			mov bx, fxCoord2
			add bx, 32
			mov boxxLastCoor, bx
			add boxxLastCoor, 2
			cmp cx, boxxLastCoor
			jne secLineV
		
			mov cx, fxCoord2
			add cx, 32
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp			
			cmp dx, 154
			jne secLineV	
							
		mov cx, fxCoord2
		add cx, 32
		mov xtemp, cx
		mov dx, fyCoord2		
		add dx, 20
		mov ytemp, dx		
		
		thirdLineH:			
			mov  ah, 0ch       			;SERVICE TO DRAW PIXEL.
			mov  al, 14  				;Yellow
			mov  bh, 0        			;VIDEO PAGE.
			mov  cx, xtemp
			mov  dx, ytemp
			inc xtemp
			int  10h           			;BIOS SCREEN SERVICES.	
			mov cx, xtemp
			cmp cx, 139
			jne thirdLineH
		
			mov cx, fxCoord2
			add cx, 32
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp
			mov bx, fyCoord2
			add bx, 20
			mov boxyLastCoor, bx
			add boxyLastCoor, 2
			cmp dx, boxyLastCoor
			jne thirdLineH
			
		mov cx, fxCoord2
		add cx, 32
		mov xtemp, cx
		mov dx, fyCoord2		
		add dx, 41
		mov ytemp, dx		
		
		fourthLineH:			
			mov  ah, 0ch       			;SERVICE TO DRAW PIXEL.
			mov  al, 14  				;Yellow
			mov  bh, 0        			;VIDEO PAGE.
			mov  cx, xtemp
			mov  dx, ytemp
			inc xtemp
			int  10h           			;BIOS SCREEN SERVICES.	
			mov cx, xtemp
			cmp cx, 139
			jne fourthLineH
		
			mov cx, fxCoord2
			add cx, 32
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp
			mov bx, fyCoord2
			add bx, 41
			mov boxyLastCoor, bx
			add boxyLastCoor, 2
			cmp dx, boxyLastCoor
			jne fourthLineH
			
		mov cx, fxCoord2
		add cx, 95
		mov xtemp, cx
		mov dx, fyCoord2		
		add dx, 32
		mov ytemp, dx		
		
		fifthLineH:			
			mov  ah, 0ch       			;SERVICE TO DRAW PIXEL.
			mov  al, 14  				;Yellow
			mov  bh, 0        			;VIDEO PAGE.
			mov  cx, xtemp
			mov  dx, ytemp
			inc xtemp
			int  10h           			;BIOS SCREEN SERVICES.	
			mov cx, xtemp
			cmp cx, 244
			jne fifthLineH
		
			mov cx, fxCoord2
			add cx, 95
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp
			mov bx, fyCoord2
			add bx, 32
			mov boxyLastCoor, bx
			add boxyLastCoor, 2
			cmp dx, boxyLastCoor
			jne fifthLineH
		
		ret
	initLines endp
	
	initExitButton proc
	
		mov boxxFirstCoor, 268
		mov boxxLastCoor, 300
		mov boxyFirstCoor, 7
		mov boxyLastCoor, 22
	
		mov cx, boxxFirstCoor
		mov xtemp, cx
		mov dx, boxyFirstCoor
		mov ytemp, dx
		
		mov boxColor, 4
		
		exitbox:
			  mov  ah, 0ch       	;SERVICE TO DRAW PIXEL.
			  mov  al, boxColor  	;Color of box
			  mov  bh, 0        	;VIDEO PAGE.
			  mov  cx, xtemp
			  mov  dx, ytemp
			  inc xtemp
			  int  10h           	;BIOS SCREEN SERVICES.	
			  mov cx, xtemp
			  cmp cx, boxxLastCoor
			  jne exitbox
		
			mov cx, boxxFirstCoor
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp
			cmp dx, boxyLastCoor
			jne exitbox
			
		mov ch, 154
		mov text_xcoor, ch
		mov dh, 1
		mov text_ycoor, dh
		
		mov fontColorRed, 04h
		
		drawExit:
			mov ah,02h  
			mov dh, text_ycoor   	;row 
			mov dl, text_xcoor     ;column
			int 10h

			mov ah,09h
			mov bl, fontColorRed   	;colour
			mov cx,1      			;no.of times
			mov al,'e'      		
			int 10h   
				
			inc text_xcoor
			
			mov ah, 02h  
			mov dh, text_ycoor   	;row 
			mov dl, text_xcoor     ;column
			int 10h

			mov ah, 09h
			mov bl, fontColorRed   ;colour
			mov cx, 1      			;no.of times
			mov al, 's'      
			int 10h   
			
			inc text_xcoor
			
			mov ah,02h  
			mov dh, text_ycoor   ;row 
			mov dl, text_xcoor     ;column
			int 10h

			mov ah,09h
			mov bl, fontColorRed   ;colour
			mov cx,1      ;no.of times
			mov al, 'c'      ;print B
			int 10h  		
		
		ret
	initExitButton endp
	
	setCursor proc 		
		mov ax, 0h
		int 33h
		mov ax, 1h
		int 33h
		mov ax, 3h
		int 33h
				
		ret
	setCursor endp
	
	mouseListener proc		
											
		mov bx, 0
		call getMouseState
		and bx, 00000001b		
		jz mouseListener
						
		mov x_coor, cx
		mov y_coor, dx
		;call display_coors				
						
		call checkFirstBox			
		call BoxClicked
		
		ret
	mouseListener endp
	
	getMouseState proc	
		
		mov ax, 3h
		int 33h	
		mov ax, 5
		int 33h
		
		ret		
	getMouseState endp		
	
	checkFirstBox proc		
		
		checkf1:
			mov dx, y_coor
			cmp dx, fy2
			jle checkf2
			jmp checkSecondBox
			
		checkf2:
			mov dx, y_coor
			cmp dx, fy1
			jge checkf3
			jmp checkSecondBox
				
		checkf3:
			mov cx, x_coor
			cmp cx, fx2
			jle checkf4
			jmp checkSecondBox
				
		checkf4:
			mov cx, x_coor
			cmp cx, fx1
			jge thisBoxClickedf
			jmp checkSecondBox
		
		thisBoxClickedf:
			call setFirstBox		
			
			cmp fbool, 0		
			je ftoggleTrue
			jne ftoggleFalse
			
			ftoggleTrue:
				mov fbool, 1
				jmp fsetBool
			
			ftoggleFalse:
				mov fbool, 0
			
			fsetBool:
				mov bh, fbool
				mov bool, bh
		
			;set cursor
			mov ax, 4
			mov cx, 143
			mov dx, 70
			int 33h
			
			mov fromOp, 0
			
			call BoxClicked
			call mouseListener		
		ret	
	checkFirstBox endp
	
	checkSecondBox proc
		
		checks1:
			mov dx, y_coor
			cmp dx, sy2
			jle checks2
			jmp checkOpBox
			
		checks2:
			mov dx, y_coor
			cmp dx, sy1
			jge checks3
			jmp checkOpBox
				
		checks3:
			mov cx, x_coor
			cmp cx, sx2
			jle checks4
			jmp checkOpBox
				
		checks4:
			mov cx, x_coor
			cmp cx, sx1
			jge thisBoxClickeds
			jmp checkOpBox
		
		thisBoxClickeds:
			call setSecondBox

			cmp sbool, 0
			je stoggleTrue
			jne stoggleFalse
			
			stoggleTrue:
				mov sbool, 1
				jmp ssetBool
			
			stoggleFalse:
				mov sbool, 0
			
			ssetBool:
				mov bh, sbool
				mov bool, bh
			
			mov ax, 4
			mov cx, 143
			mov dx, 170
			int 33h
			
			mov fromOp, 0
			
			call BoxClicked
			call mouseListener
		ret
	checkSecondBox endp
	
	checkOpBox proc
		
		checko1:
			mov dx, y_coor
			cmp dx, oy2
			jle checko2
			jmp checkEscBox
			
		checko2:			
			mov dx, y_coor
			cmp dx, oy1
			jge checko3
			jmp checkEscBox
				
		checko3:				
			mov cx, x_coor
			cmp cx, ox2
			jle checko4
			jmp checkEscBox
				
		checko4:				
			mov cx, x_coor
			cmp cx, ox1
			jge thisBoxClickedo
			jmp checkEscBox
				
		thisBoxClickedo:
			call setOperationBox
			
			AndCheck:
				cmp obool, 0
				je otoggleOr
				jne OrCheck

			OrCheck:
				cmp obool, 1
				je otoggleXor
				jne XorCheck
				
			XorCheck:
				cmp obool, 2
				je otoggleNand
				jne NandCheck
				
			NandCheck:
				cmp obool, 3
				je otoggleNor
				jne NorCheck
				
			NorCheck:
				cmp obool, 4
				je otoggleXnor
				jne XnorCheck
				
			XnorCheck:
				cmp obool, 5
				je otoggleAnd
				;jmp mouseListener
				
			otoggleAnd:
				mov obool, 0
				mov boxColor, 2
				jmp jumpNext
				
			otoggleOr:
				mov obool, 1
				mov boxColor, 4
				jmp jumpNext
			
			otoggleXor:
				mov obool, 2
				mov boxColor, 1
				jmp jumpNext
				
			otoggleNand:
				mov obool, 3
				mov boxColor, 3
				jmp jumpNext
				
			otoggleNor:
				mov obool, 4
				mov boxColor, 5
				jmp jumpNext
			
			otoggleXnor:
				mov obool, 5	
				mov boxColor, 6
						
			jumpNext:												
				
				mov ax, 4
				mov cx, 350
				mov dx, 117
				int 33h
				
				mov fromOp, 1			
				call BoxClicked											
								
				call mouseListener
		ret
	checkOpBox endp
	
	checkEscBox proc
		
		checke1:
			mov dx, y_coor
			cmp dx, 21
			jle checke2
			jmp mouseListener
			
		checke2:
			mov dx, y_coor
			cmp dx, 7
			jge checke3
			jmp mouseListener
				
		checke3:
			mov cx, x_coor
			cmp cx, 598
			jle checke4
			jmp mouseListener
				
		checke4:
			mov cx, x_coor
			cmp cx, 536
			jge thisBoxClickede
			jmp mouseListener
		
		thisBoxClickede:						
			mov ax, 4
			mov cx, 580
			mov dx, 28
			int 33h			
			call clearScreen			
			mov ah, 4ch
			int 21h
			
		ret
	checkEscBox endp
	
	setBoxNum proc
		
		FirstBox:
			cmp	si, 1
			je	setFirstBox
			jne SecondBox
		
		SecondBox:
			cmp si, 2
			je setSecondBox
			jne ThirdBox
			
		ThirdBox:
			cmp si, 3
			je setOperationBox
			jne FourthBox
			
		FourthBox:
			cmp si, 4
			je setResultBox			
		
		  ret		  
	setBoxNum endp 
	
	setFirstBox proc		
		mov cx, fxCoord1
		mov boxxFirstCoor, cx
		mov cx, fxCoord2
		mov boxxLastCoor, cx
		
		mov dx, fyCoord1
		mov boxyFirstCoor, dx
		mov dx, fyCoord2
		mov boxyLastCoor, dx
		
		mov ch, ftext_xcoor
		mov text_xcoor, ch
		mov dh, ftext_ycoor
		mov text_ycoor, dh				
		
		ret
	setFirstBox endp

	setSecondBox proc		
		mov cx, sxCoord1
		mov boxxFirstCoor, cx
		mov cx, sxCoord2
		mov boxxLastCoor, cx
		
		mov dx, syCoord1
		mov boxyFirstCoor, dx
		mov dx, syCoord2
		mov boxyLastCoor, dx
		
		mov ch, stext_xcoor
		mov text_xcoor, ch
		mov dh, stext_ycoor
		mov text_ycoor, dh

		ret
	setSecondBox endp
	
	setOperationBox proc		
		mov cx, OpxCoord1
		mov boxxFirstCoor, cx
		mov cx, OpxCoord2
		mov boxxLastCoor, cx
		
		mov dx, OpyCoord1
		mov boxyFirstCoor, dx
		mov dx, OpyCoord2
		mov boxyLastCoor, dx
		
		mov ch, Optext_xcoor
		mov text_xcoor, ch
		mov dh, Optext_ycoor
		mov text_ycoor, dh
		
		ret
	setOperationBox endp
	
	setResultBox proc		
		mov cx, rxCoord1
		mov boxxFirstCoor, cx
		mov cx, rxCoord2
		mov boxxLastCoor, cx
		
		mov dx, ryCoord1
		mov boxyFirstCoor, dx
		mov dx, ryCoord2
		mov boxyLastCoor, dx
		
		mov ch, rtext_xcoor
		mov text_xcoor, ch
		mov dh, rtext_ycoor
		mov text_ycoor, dh
		
		ret
	setResultBox endp
			
	BoxClicked proc		
		mov cx, boxxFirstCoor
		mov xtemp, cx
		mov dx, boxyFirstCoor
		mov ytemp, dx		
						
		ifOp:
			cmp 	fromOp, 1
			jne setFactors
			je draw
			
		setFactors:					
			cmp bool, 0
			je Off
			jne On			
			Off:
				mov boxColor, 7
				jmp draw				
			On:
				mov boxColor, 14									
		draw:
			call drawBox	
							
		call performOp
		
		ret
	BoxClicked endp
	
	drawBox proc
	
		colcount:
			  mov  ah, 0ch   
			  mov  al, boxColor  
			  mov  bh, 0        			;VIDEO PAGE.
			  mov  cx, xtemp
			  mov  dx, ytemp
			  inc xtemp
			  int  10h           			;BIOS SCREEN SERVICES.	
			  mov cx, xtemp
			  cmp cx, boxxLastCoor
			  jne colcount
		
			mov cx, boxxFirstCoor
			mov xtemp, cx
			inc ytemp
			mov dx, ytemp
			cmp dx, boxyLastCoor
			jne colcount		
			
		OffColor:
			cmp boxColor, 7
			je OnOff
			jne OnColor
			
		OnColor:
			cmp boxColor, 14
			je OnOff
			jne LogicGates1
			
		LogicGates1:
			cmp obool, 0
			je drawAnd
			jne LogicGates2
		
		LogicGates2:
			cmp obool, 1
			je drawOr
			jne LogicGates3
			
		LogicGates3:
			cmp obool, 2
			je drawXor						
			jne LogicGates4
			
		LogicGates4:
			cmp obool, 3
			je drawNand
			jne LogicGates5
			
		LogicGates5:
			cmp obool, 4
			je drawNor
			jne LogicGates6
			
		LogicGates6:
			cmp obool, 5
			je drawXnor
			
		OnOff:
			cmp bool, 0
			je drawOff
			jne drawOn
		
		ret
	drawBox endp
	
	performOp proc
	
		ifAndOp:			
			cmp obool, 0
			jne ifOrOp
			je performAnd
			
		ifOrOp:
			cmp obool, 1
			jne ifXorOp
			je performOr
			
		ifXorOp:
			cmp obool, 2
			jne ifNandOp
			je performXor
			
		ifNandOp:
			cmp obool, 3
			je performNand
			jne ifNorOp
		
		ifNorOp:
			cmp obool, 4
			je performNor
			jne ifXnorOp
			
		ifXnorOp:
			cmp obool, 5
			je performXnor
			jmp skip
			
		performAnd:
			cmp fbool, 0
			je ifBothZeroAnd
			jne ifBothOneAnd
			
			ifBothZeroAnd:
				cmp sbool, 0
				je returnFalse
				jne returnFalse
			
			ifBothOneAnd:
				cmp sbool, 1
				je returnTrue
				jne returnFalse
		
		performOr:
			cmp fbool, 0
			je ifBothZeroOr
			jne ifBothOneOr
			
			ifBothZeroOr:
				cmp sbool, 0
				je returnFalse
				jne returnTrue
			
			ifBothOneOr:
				cmp sbool, 1
				je returnTrue
				jne returnTrue
			
		performXor:
			cmp fbool, 0
			je ifBothZeroXor
			jne ifBothOneXor
			
			ifBothZeroXor:
				cmp sbool, 0
				je returnFalse
				jne returnTrue
			
			ifBothOneXor:
				cmp sbool, 1
				je returnFalse
				jne returnTrue
				
		performNand:
			cmp fbool, 0
			je ifBothZeroNand
			jne ifBothOneNand
			
			ifBothZeroNand:
				cmp sbool, 0
				je returnTrue
				jne returnTrue
			
			ifBothOneNand:
				cmp sbool, 1
				je returnFalse
				jne returnTrue
				
		performNor:
			cmp fbool, 0
			je ifBothZeroNor
			jne ifBothOneNor
			
			ifBothZeroNor:
				cmp sbool, 0
				je returnTrue
				jne returnFalse
			
			ifBothOneNor:
				cmp sbool, 1
				je returnFalse
				jne returnFalse
				
		performXnor:
			cmp fbool, 0
			je ifBothZeroXnor
			jne ifBothOneXnor
			
			ifBothZeroXnor:
				cmp sbool, 0
				je returnTrue
				jne returnFalse
			
			ifBothOneXnor:
				cmp sbool, 1
				je returnTrue
				jne returnFalse
				
		skip:
		ret
	performOp endp
	
	returnFalse proc
		call setResultBox
		mov cx, boxxFirstCoor
		mov xtemp, cx
		mov dx, boxyFirstCoor
		mov ytemp, dx		
		
		mov boxColor, 7
		mov bool, 0
		
		call drawBox			
		call mouseListener
		ret		
	returnFalse endp	
	
	returnTrue proc
		call setResultBox
		mov cx, boxxFirstCoor
		mov xtemp, cx
		mov dx, boxyFirstCoor
		mov ytemp, dx		
		
		mov boxColor, 14
		mov bool, 1
		
		call drawBox	
		call mouseListener
		ret		
	returnTrue endp
	
	drawAnd proc
		mov ch, Optext_xcoor
		mov text_xcoor, ch
		mov dh, Optext_ycoor
		mov text_ycoor, dh
		
		mov ah, 02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor   
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1     
		mov al, 'A'    
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh   
		mov cx,1     
		mov al,'n'     
		int 10h   

		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor   
		mov dl, text_xcoor    
		int 10h

		mov ah,09h
		mov bl,0eh 
		mov cx,1   
		mov al,'d'   
		int 10h
		
		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor   
		mov dl, text_xcoor    
		int 10h

		mov ah,09h
		mov bl,0eh 
		mov cx,1   
		mov al,''   
		int 10h
		
		ret
	drawAnd endp
	
	drawXor proc
		mov ch, Optext_xcoor
		mov text_xcoor, ch
		mov dh, Optext_ycoor
		mov text_ycoor, dh
		
		mov ah, 02h  
		mov dh, text_ycoor   
		mov dl, text_xcoor    
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1      
		mov al, 'X'      
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor   
		int 10h

		mov ah,09h
		mov bl,0eh   
		mov cx,1     
		mov al,'o'     
		int 10h   

		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh  
		mov cx,1    
		mov al,'r'   
		int 10h
		
		ret
	drawXor endp
	
	drawOr proc
		mov ch, Optext_xcoor
		mov text_xcoor, ch
		mov dh, Optext_ycoor
		mov text_ycoor, dh
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor 
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1      
		mov al, 'O'     
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh 
		mov cx,1  
		mov al,'r' 
		int 10h   

		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor   
		int 10h

		mov ah,09h
		mov bl,0eh   
		mov cx,1     
		mov al,''      
		int 10h
		
		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor   
		int 10h

		mov ah,09h
		mov bl,0eh 
		mov cx,1   
		mov al,''    
		int 10h
		
		ret
	drawOr endp
	
	drawNand proc
		mov ch, Optext_xcoor
		mov text_xcoor, ch
		mov dh, Optext_ycoor
		mov text_ycoor, dh
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1     
		mov al, 'N'    
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor   
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1     
		mov al, 'a'      
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh  
		mov cx,1    
		mov al,'n'    
		int 10h   

		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh   
		mov cx,1     
		mov al,'d'     
		int 10h
		
		ret
	drawNand endp
	
	drawNor proc
		mov ch, Optext_xcoor
		mov text_xcoor, ch
		mov dh, Optext_ycoor
		mov text_ycoor, dh
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1     
		mov al, 'N'    
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor   
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1     
		mov al, 'o'      
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh  
		mov cx,1    
		mov al,'r'    
		int 10h   

		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh   
		mov cx,1     
		mov al,''     
		int 10h
		
		ret
	drawNor endp
	
	drawXnor proc
		mov ch, Optext_xcoor
		mov text_xcoor, ch
		mov dh, Optext_ycoor
		mov text_ycoor, dh
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1     
		mov al, 'X'    
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor  
		mov dl, text_xcoor   
		int 10h

		mov ah, 09h
		mov bl, 0eh   
		mov cx, 1     
		mov al, 'n'      
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh  
		mov cx,1    
		mov al,'o'
		int 10h   

		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor 
		mov dl, text_xcoor  
		int 10h

		mov ah,09h
		mov bl,0eh   
		mov cx,1     
		mov al,'r'     
		int 10h
		
		ret
	drawXnor endp
	
	drawOff proc
		
		mov ah,02h  
		mov dh, text_ycoor   ;row 
		mov dl, text_xcoor     ;column
		int 10h

		mov ah,09h
		mov bl, 0eh   ;colour
		mov cx,1      ;no.of times
		mov al,'O'      ;print B
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor   ;row 
		mov dl, text_xcoor     ;column
		int 10h

		mov ah,09h
		mov bl,0eh   ;colour
		mov cx,1      ;no.of times
		mov al,'f'      ;print B
		int 10h   

		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor   ;row 
		mov dl, text_xcoor     ;column
		int 10h

		mov ah,09h
		mov bl,0eh   ;colour
		mov cx,1      ;no.of times
		mov al,'f'      ;print B
		int 10h   
			
		ret
	drawOff endp
	
	drawOn proc										
		
		mov ah,02h  
		mov dh, text_ycoor   ;row 
		mov dl, text_xcoor     ;column
		int 10h

		mov ah,09h
		mov bl, 0eh   ;colour
		mov cx,1      ;no.of times
		mov al,'O'      ;print B
		int 10h   
			
		inc text_xcoor
		
		mov ah, 02h  
		mov dh, text_ycoor   ;row 
		mov dl, text_xcoor     ;column
		int 10h

		mov ah,09h
		mov bl,0eh   ;colour
		mov cx,1      ;no.of times
		mov al,'n'      ;print B
		int 10h   
		
		inc text_xcoor
		
		mov ah,02h  
		mov dh, text_ycoor   ;row 
		mov dl, text_xcoor     ;column
		int 10h

		mov ah,09h
		mov bl, 0eh   ;colour
		mov cx,1      ;no.of times
		mov al, ""      ;print B
		int 10h  		
		
		ret
	drawOn endp

	display_coors proc			
	
		;SEND CURSOR TO START OF UPPER LEFT.
		  mov  ah, 2   ;SERVICE TO SET CURSOR POSITION.
		  mov  bh, 0   ;VIDE PAGE.
		  mov  dl, 0   ;X.
		  mov  dh, 0   ;Y.
		  int  10h
		  
		;CLEAR LINE.
		  mov  ah, 9
		  mov  dx, offset clear
		  int  21h
		  
		;SEND CURSOR TO START OF UPPER LEFT.
		  mov  ah, 2   ;SERVICE TO SET CURSOR POSITION.
		  mov  bh, 0   ;VIDE PAGE.
		  mov  dl, 0   ;X.
		  mov  dh, 0   ;Y.
		  int  10h
		  
		;CONVERT X TO STRING.
		  mov  ax, x_coor ;AX = PARAMETER FOR NUMBER2STRING.                                              
		  mov  si, offset numstr
		  call number2string               
		  
		;DISPLAY X.
		  mov  ah, 9
		  mov  dx, offset numstr
		  int  21h
		  
		;"-".
		  mov  ah, 9
		  mov  dx, offset comma
		  int  21h 
		  
		;CONVERT Y TO STRING.
		  mov  ax, y_coor ;AX = PARAMETER FOR NUMBER2STRING.                                              
		  mov  si, offset numstr
		  call number2string                                              
		  
		;DISPLAY Y.  
		  mov  ah, 9
		  mov  dx, offset numstr
		  int  21h         
		  		  
		ret
	display_coors endp

	number2string proc 
		  call dollars ;FILL STRING WITH $.
		  mov  bx, 10  ;DIGITS ARE EXTRACTED DIVIDING BY 10.
		  mov  cx, 0   ;COUNTER FOR EXTRACTED DIGITS.
		cycle1:       
		  mov  dx, 0   ;NECESSARY TO DIVIDE BY BX.
		  div  bx      ;DX:AX / 10 = AX:QUOTIENT DX:REMAINDER.
		  push dx      ;PRESERVE DIGIT EXTRACTED FOR LATER.
		  inc  cx      ;INCREASE COUNTER FOR EVERY DIGIT EXTRACTED.
		  cmp  ax, 0   ;IF NUMBER IS
		  jne  cycle1  ;NOT ZERO, LOOP. 
		;NOW RETRIEVE PUSHED DIGITS.
		cycle2:  
		  pop  dx        
		  add  dl, 48  ;CONVERT DIGIT TO CHARACTER.
		  mov  [ si ], dl
		  inc  si
		  loop cycle2  

		  ret
	number2string endp    

	dollars proc
		  mov  cx, 5
		  mov  di, offset numstr

		  dollars_loop:      
		  mov  bl, '$'
		  mov  [ di ], bl
		  inc  di
		  loop dollars_loop

		  ret
	dollars endp               		

end main