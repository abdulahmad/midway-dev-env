****************************************************************************
*                                                                          *
*  PIC SECURITY STUFF                                                      *
*                                                                          *
*  Security source for WWF-UNIT's PIC                                      *
*                                                                          *
*  Version 1.00                                                            *
*  Written by:   Michael J. Lynch                                          *
*  Copyright (c) 1994 by Williams Electronics Games Inc.                   *
*  All rights reserved                                                     *
*                                                                          *
*     TTTTT   OOO  PPPP         SSS   EEEEE   CCC   RRRR  EEEEE TTTTT      *
*       T    O   O P   P       S   S  E      C   C  R   R E       T        *
*       T    O   O P   P       S      E      C      R   R E       T        *
*       T    O   O PPPP         SSS   EEEE   C      RRRR  EEEE    T        *
*       T    O   O P               S  E      C      R R   E       T        *
*       T    O   O P           S   S  E      C   C  R  R  E       T        *
*       T     OOO  P            SSS   EEEEE   CCC   R   R EEEEE   T        *
*                                                                          *
*                                                                          *
*                    Company Confidential Information                      *
*                        NEED TO KNOW BASIS ONLY                           *
*                                                                          *
* USE OR DISCLOSURE STRICTLY PROHIBITED UNLESS APPROVED IN WRITING FROM    *
* WILLIAMS ELECTRONICS GAMES INC.                                          *
*                                                                          *
* Unapproved use or disclosure will result in severe torture!!!!!          *
*                                                                          *
****************************************************************************

	.width	132
	.option	b,d,l,t
	.mnolist

	.include	macros.hdr
	.include	"dispequ.asm"		;display processor equates
	.include	"sysequ.asm"		;system equates
	.include	"mainequ.asm"
	.include	"imgtbl.glo"
	.include	"stringh.asm"
	.include	"diagsequ.asm"
	.include	"diagmequ.asm"
	.include	"dipequ.asm"
	.include	"diagaudn.asm"

pic_command	.equ	01600000h	;PIC Command Port
pic_data	.equ	pic_command	;PIC Data Port

WRESTLE		.equ	0

	.if	WRESTLE=1
game_number	.equ	430		; Wrestlemania Game Number
	.else
game_number	.equ	439		; Mortal Kombat 3 Game Number
	.endif


*
* Globals available to outside modules for displaying PIC information
* Only needed in menus!!
*
	.globl	go_hardware
	.globl	mess_hardware
	.globl	hardware_help
	.globl	copy_string
	.globl	dec_to_asc
	.globl	_serial_number
	.globl	_man_date
	.globl	message_buffer
	.globl	_read_pic_data
	.globl	InitPIC
	.globl	copy_rom_string
	.globl	concat_string

*
* Symbol references made by go_hardware
*
	.ref	binbcd
	.ref	clr_scrn
	.ref	l_mess
	.ref	top_box
	.ref	force_main
	.ref	rd15font
	.ref	rd7font
	.ref	strcnrm
	.ref	force_main

*
* Y Positions of Hardware information screen items
*
willy_y		.equ	80
unit_y		.equ	willy_y+50
serial_y	.equ	unit_y+40
man_y		.equ	serial_y+40

mbuff_size	.equ	40


*
* Local Storage for stuff in this module
*

	.bss	_pic_raw,128		;Working buffers for PIC decoding
	.bss	_pic_temp,64

	.bss	_man_date,32		;Date of manufacture (composite)

	.bss	_serial_number,32	;Game Serial Number  (Hexidecimal)
	.bss	_month,32	 	;Date of manufacture (month: 1-12)
	.bss	_day,32		 	;Date of manufacture (date: 1-31)
	.bss	_year,32	 	;Date of manufacture (year: 00-99)

	.bss	_setup_mess,12*16	;Used for built messages
	.bss	_setup_mess_msg,8*40	;Used for built message strings

	.bss	message_buffer,	16*mbuff_size ;null terminated string
	.bss	message_buffer2, 16*mbuff_size

	.text



***************************************************************
* InitPIC - Initializes the PIC Microcontroller
*
InitPIC
	clr	a0			;Reset the PIC
	move	a0,@coin_counters,w
	movi	10,a0			;Hold RESET fer a bit
	dsjs	a0,$
	movi	010h,a0			;Set no command request
	move	a0,@pic_command,w
	movi	020h,a0			;Allow PIC to run
	move	a0,@coin_counters,w
	movi	200000000,a1
_pwait_loop
	move	@soundirq,a0,w
	btst	12,a0
	jrz	_pnwait
	move	a0,@watchdog,w
	dsjs	a1,_pwait_loop
_pnwait
	movi	010h,a0
	move	a0,@pic_command,w
	movi	2000000,a1
_pwait_loop1
	move	@soundirq,a0,w
	btst	12,a0
	jrnz	_pwait_done
	move	a0,@watchdog,w
	dsjs	a1,_pwait_loop1
_pwait_done
	rets

******************************************************************************
*                                                                            *
* _pic_bin2bcd - Converts a hex number in A7 to BCD and puts it in A3        *
*                                                                            *
* ENTRY                                                                      *
*         A7 - Binary number to be converted                                 *
*         B6 - Return Address                                                *
*                                                                            *
* EXIT                                                                       *
*         A3 - Converted Number (BDC)                                        *
*                                                                            *
* USES                                                                       *
*         A0 - A1                                                            *
*                                                                            *
* Written by:  Michael J. Lynch                                              *
*                                                                            *
******************************************************************************
_pic_bin2bcd:
	clr	a3
	movi	100000,a0
_bin2bcd_loop:
	sll	4,a3
	move	a7,a1
	divu	a0,a1
	or	a1,a3
	mpyu	a0,a1
	sub	a1,a7
	move	a0,a1
	movk	10,a0
	divu	a0,a1
	move	a1,a0
	jrnz	_bin2bcd_loop
	fret	b6


******************************************************************************
*                                                                            *
* _bcd2hex - Converts a 32 bit (8 digit) BCD Number to Hexidecimal           *
*                                                                            *
* ENTRY                                                                      *
*         A0 - BCD Number to be converted                                    *
*         B6 - Return Address                                                *
*                                                                            *
* EXIT                                                                       *
*         A2 - Converted Number (hex)                                        *
*                                                                            *
* USES                                                                       *
*         A1 - Multiplier                                                    *
*         A3 - Temporary                                                     *
*         A4 - Digit Counter                                                 *
*                                                                            *
* Written by:  Michael J. Lynch                                              *
*                                                                            *
******************************************************************************
_bcd2hex:
	clr	a2		; Start with 0
	movk	1,a1		; Starting Multiplier
	movk	8,a4		; Number of BCD digits to convert
_b2h_loop:			; Main BCD to hex conversion loop
	move	a0,a3		; Put BCD number in temporary register
	andi	0fh,a3		; get rid of bits not interested in
	mpyu	a1,a3		; multiply by current multiplier
	add	a3,a2		; Accumulate into final register
	srl	4,a0		; Shift to next BCD digit
	movk	10,a3		; Calculate next multiplier (mult = mult * 10)
	mpyu	a3,a1		; New Multiplier
	dsjs	a4,_b2h_loop	; Keep going until 8 BCD digits are done
	fret	b6		; return



******************************************************************************
*                                                                            *
* _read_pic_data - reads the encoded information from the PIC, decodes it to *
* memory, and checks for the proper game number.  If the game number is not  *
* correct, this routine hangs (don't bitch - that's what management wants!). *
*                                                                            *
* If the game number is ok, this routine returns and the serial number and   *
* manufacture date information will be valid in the global memory area above *
* for use by the application.                                                *
*                                                                            *
* USES                                                                       *
*         A1 - A10 and B6                                                    *
*                                                                            *
* Written by:  Michael J. Lynch                                              *
*                                                                            *
******************************************************************************
_read_pic_data:
	setf	8,0
	setf	32,0,1
	movk	16,a9		; Number of bytes of data to read
	movi	_pic_raw,a1	; address at which to store raw data from PIC
	movk	010h,a8		; Send Request Serial Number Data Command
	move	a8,@pic_command
_rp_data_loop:
	setf	16,0
	clr	a8
	move	a8,@pic_command
	movi	1000000,a2	; Wait for PIC to acknowledge 
_rp_ack_loop:
	move	a2,a2		; Check for command timeout
	jrz	gn_bad		; WOA PIC never acknowledged - ERROR!!!!
	.if	WRESTLE=1
	move	@_watchdog_addr,a8,l
	move	a8,*a8
	move	@_soundirq_addr,a8,l
	move	*a8,a8
	.else
	move	a8,@watchdog,w
	move	@soundirq,a8,w
	.endif
	subi	1,a2
	btst	12,a8		; Data available ?
	jrnz	_rp_ack_loop	; NO
	setf	8,0		; YES
	move	@pic_data,a0	; read data
	move	a0,*a1+		; write to temp holding area
	movk	010h,a8		; Acknowledge reciept of data
	setf	16,0
	move	a8,@pic_command
	movi	1000000,a2	; Wait for PIC n acknowlegde
_rp_nack_loop:
	move	a2,a2
	jrz	gn_bad
	.if	WRESTLE=1
	move	@_watchdog_addr,a8,l
	move	a8,*a8
	move	@_soundirq_addr,a8,l
	move	*a8,a8
	.else
	move	a8,@watchdog,w
	move	@soundirq,a8,w
	.endif
	subi	1,a2
	btst	12,a8
	jrz	_rp_nack_loop
	dsj	a9,_rp_data_loop
	clr	a4		; Holding Register for X
	clr	a5		; Holding Register for Y
	setf	8,0
	movi	_pic_raw,a10
	addi	060h,a10
	move	*a10+,a4	; Get X
	move	*a10,a5		; Get Y
	setf	24,0
	clr	a7		; Calculate B-3-5-9
	movi	_pic_raw,a10
	move	*a10,a7
	subi	15732,a7
	movi	581,a0
	divu	a0,a7
	sub	a4,a7		; B359 (binary)
	fcall	_pic_bin2bcd,b6	; B359 (bcd) a1 = B359
	setf	4,0
	srl	4,a3
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addi	014h,a10
	move	a0,*a10		; Stuff the 5
	srl	4,a3
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addk	0ch,a10
	move	a0,*a10		; Stuff the 3


	movi	_pic_raw,a10
	addi	018h,a10
	move	*a10,a7,1	; Calculate 2-A-0-8-6
	subi	7463513,a7
	movi	4223,a0
	divu	a0,a7
	sub	a5,a7
	sub	a5,a7
	sub	a4,a7		; 2A086 (binary)
	fcall	_pic_bin2bcd,b6	; 2A086 (bcd)
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addk	018h,a10
	move	a0,*a10		; Stuff the 6
	srl	4,a3
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addi	020h,a10
	move	a0,*a10		; Stuff the 8
	srl	4,a3
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	move	a0,*a10		; Stuff the 0
	srl	8,a3
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addk	8,a10
	move	a0,*a10		; Stuff the 2


	setf	24,0		; Calcuate 1-7-4
	movi	038h,a10
	addi	_pic_raw,a10
	move	*a10,a7
	subi	127984,a7
	movi	7117,a0
	divu	a0,a7
	sub	a5,a7
	sub	a5,a7
	sub	a5,a7
	sub	a5,a7
	sub	a5,a7		; 174 (binary)
	fcall	_pic_bin2bcd,b6	; 174 (bcd) a1 = 174
	setf	4,0
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addk	010h,a10
	move	a0,*a10		; Stuff the 4
	srl	4,a3
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addk	01ch,a10
	move	a0,*a10		; Stuff the 7
	srl	4,a3
	move	a3,a0
	andi	0fh,a0
	movi	_pic_temp,a10
	addk	4,a10
	move	a0,*a10		; Stuff the 1

	setf	16,0
	movi	050h,a10
	addi	_pic_raw,a10
	move	*a10,a0		; This is a pointer to the date code
	move	*a10,a1
	sll	8,a1
	srl	8,a0
	andi	0ffh,a0
	andi	0ff00h,a1
	or	a1,a0
	move	a0,@_man_date,l

	setf	4,0
	movi	_pic_temp,a10
	addk	0ch,a10
	move	*a10+,a0	; Most Significant Digit (serial number)
	sll	4,a0
	move	*a10+,a1
	or	a1,a0
	sll	4,a0
	move	*a10+,a1
	or	a1,a0
	sll	4,a0
	move	*a10+,a1
	or	a1,a0
	sll	4,a0
	move	*a10+,a1
	or	a1,a0
	sll	4,a0
	move	*a10+,a1	; Least Significant Digit (serial number)
	or	a1,a0
	fcall	_bcd2hex,b6	; Convert to hex (a2 = serial # hex)
	move	a2,@_serial_number,l
	
	setf	4,0
	movi	_pic_temp,a10
	move	*a10+,a0	; Most Significant Digit (game number)
	sll	4,a0
	move	*a10+,a1
	or	a1,a0
	sll	4,a0
	move	*a10+,a1	; Least Significant Digit (game number)
	or	a1,a0
	fcall	_bcd2hex,b6	; Convert to hex

	clr	a1
	cmpi	528,a2		; Development PIC Game Number
	jrz	gn_good
	cmpi	game_number,a2		; Real Game Number (WrestleMania)
	jrz	gn_good
gn_bad:
	.if	WRESTLE=1
	movi	sec_mess_2,a0	; Level 2 Security Check failure
	fcall	stringcenter,b6
	addi	[220,0],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	lockup
	.else
	jruc	$
	.endif
gn_good:
	setf	8,0		; Stomp on memory used to decode PIC
	clr	a0
	movi	16,a1
	movi	_pic_raw,a2
_stomp_temp:
	move	a0,*a2+
	dsjs	a1,_stomp_temp
	movi	8,a1
	movi	_pic_temp,a2
_stomp_temp1:
	move	a0,*a2+
	dsjs	a1,_stomp_temp1
	setf	16,1,0			;Field0 = Word sign extend
	setf	32,0,1			;Field1 = Long word
_decode_date:
	move	@_man_date,a2,l
	move	a2,a1
	subk	1,a1
	movi	372,a0
	divu	a0,a1
	movi	372,a3
	mpyu	a1,a3
	sub	a3,a2
	addi	80,a1
	move	a1,@_year,1
	move	a2,a0
	movi	31,a1
	modu	a1,a0
	move	a0,@_day,1
	move	a2,a1
	subk	1,a1
	movi	31,a0
	divu	a0,a1
	addk	1,a1
	move	a1,@_month,1
	rets




go_hardware:
	calla	clr_scrn		; Clear the screen
	movi	m_hardware_info,a2	; Put up Title Box
	movi	trog_white,a3
	jsrp	top_box
	movi	willy_prompt,a8
	jsrp	l_mess
	movi	m_dom,a4
	calla	copy_rom_string		; Copy the Date of manufacture prompt
	move	@_month,a0
	dec	a0
	sll	5,a0
	movi	month_table,a8
	add	a0,a8
	move	*a8,a4,l
	calla	concat_rom_string	; Copy the month name
	move	@_day,a0		; Convert date to ascii
	movi	31,a1
	calla	dec_to_asc
	calla	concat_string		; Add date to string
	movi	mess_hyears,a4		; Add , 19 to string
	calla	concat_rom_string
	move	@_year,a0		; Convert year to ascii
	movi	99,a1
	calla	dec_to_asc
	calla	concat_string		; Add year to string
	movi	man_date_setup,a0	; Setup message
	callr	_setup_message
	movi	_setup_mess,a8
	jsrp	l_mess			; Print Date of Manufacture

	movi	m_serial,a4
	calla	copy_rom_string		; Copy serial number prompt
	move	@_serial_number,a0,l	; Convert serial number to ascii
	movi	1000000,a1
	calla	dec_to_asc
	calla	concat_string		; Add serial number to prompt
	movi	serial_num_setup,a0	; Setup the message
	callr	_setup_message
	movi	_setup_mess,a8
	jsrp	l_mess			; Print the Serial Number
	movi	mess_quit,a8
	jsrp	l_mess
;MJL 03
_hardware_wait_all_up:			; Wait for all switches to be released
	sleep	2
	move	@switch,a0,w
	move	@switch+16,a1,w
	and	a1,a0
	move	@coins,a1,w
	and	a1,a0
	not	a0
	jrnz	_hardware_wait_all_up
;MJL 03 END
_hardware_check_sw:			; Wait for a button to be pressed
;MJL 03
;	sleep	10
	sleep	3
;MJL 03 END
	.if	WRESTLE = 1
	move	@_switch2_addr,a0,l
	move	*a0,a0,w
	move	@_switch_addr,a1,l
	move	*a1,a1,w
	.else
	move	@(switch+010H),a0,w
	move	@switch,a1,w
	.endif
	sll	16,a0
	srl	16,a0
	sll	16,a1
	srl	16,a1
	and	a0,a1
	.if	WRESTLE = 1
	move	@_coin_addr,a0,l
	move	*a0,a0
	.else
	move	@coins,a0,w
	.endif
	ori	10h,a0			; Ignore Test Switch
	sll	16,a0
	or	a1,a0
	not	a0
	jrz	_hardware_check_sw
ret_hardware:
;MJL 03
	sleep	2
	move	@switch,a0,w
	move	@switch+16,a1,w
	and	a1,a0
	move	@coins,a1,w
	and	a1,a0
	not	a0
	jrnz	ret_hardware
;MJL 03 END
	jsrp	force_main
	retp


; a0 = pointer to mess_mac TO COPY message is copied from message_buffer
_setup_message:
	movi	_setup_mess,a1
	movk	12,a2
_sm_lp1:
	move	*a0+,*a1+
	dsjs	a2,_sm_lp1
	movi	_setup_mess_msg,a1
	movi	message_buffer,a0
	pushst
	setf	8,0
_sm_lp2:
	move	*a0+,a2
	move	a2,*a1+
	move	a2,a2
	jrnz	_sm_lp2
_sm_done
	popst
	clr	a2
	move	a2,*a1
	rets




*****************************************************************************
*
* INPUT:	a0 = number to convert
*		a1 = max value
* converts value in A0 to an decimal ASCII string in message_buffer2
* - removes leading spaces
*
*-----------------------------------------------------------------------------

dec_to_asc

	cmp	a0,a1			;a1-a0
	jrhi	not_max
	move	a1,a0			;set num to max
not_max

	calla	binbcd			;dec number in A0
	move	a0,a1
	movi	message_buffer2,a2

dec_to_asc_new_entry

	clr	a3			;leading zero flag

	andi	0f000000h,a0
	srl	6*4,a0
	jrnz	no_zero_n3
	move	a3,a3			;leading zero
	jrz	skip_zero_n3
no_zero_n3
	inc	a3
	addi	'0',a0
	movb	a0,*a2
	addk	8,a2
skip_zero_n3

	move	a1,a0
	andi	0f00000h,a0
	srl	5*4,a0
	jrnz	no_zero_n2
	move	a3,a3			;leading zero
	jrz	skip_zero_n2
no_zero_n2
	inc	a3
	addi	'0',a0
	movb	a0,*a2
	addk	8,a2
skip_zero_n2

	move	a1,a0
	andi	0f0000h,a0
	srl	4*4,a0
	jrnz	no_zero_n1
	move	a3,a3			;leading zero
	jrz	skip_zero_n1
no_zero_n1
	inc	a3
	addi	'0',a0
	movb	a0,*a2
	addk	8,a2
skip_zero_n1

	move	a1,a0


	andi	0f000h,a0
	srl	3*4,a0
	jrnz	no_zero0
	move	a3,a3			;leading zero
	jrz	skip_zero0
no_zero0
	inc	a3
	addi	'0',a0
	movb	a0,*a2
	addk	8,a2
skip_zero0

	move	a1,a0
	andi	0f00h,a0
	srl	2*4,a0
	jrnz	no_zero1
	move	a3,a3			;leading zero
	jrz	skip_zero1
no_zero1
	inc	a3
	addi	'0',a0
	movb	a0,*a2
	addk	8,a2
skip_zero1

	move	a1,a0
	andi	0f0h,a0
	srl	1*4,a0
	jrnz	no_zero2
	move	a3,a3			;leading zero
	jrz	skip_zero2
no_zero2
	inc	a3
	addi	'0',a0
	movb	a0,*a2
	addk	8,a2
skip_zero2

	move	a1,a0
	andi	0fh,a0
	addi	'0',a0
	movb	a0,*a2
	addk	8,a2
	clr	a0
	movb	a0,*a2			;null terminate string

	rets


*****************************************************************************
*
* concatenates string in message_buffer2 to string in message_buffer
*
*-----------------------------------------------------------------------------

concat_string

	movi	message_buffer-8,a2
	movi	message_buffer2-8,a3
next_char
	addk	8,a2
	movb	*a2,a0
	jrnz	next_char
	subk	8,a2

next_char2
	addk	8,a2
	addk	8,a3
	movb	*a3,*a2
	movb	*a3,a0				;NULL?
	jrnz	next_char2

	rets

*****************************************************************************
*
* INPUT:	a4 = * null terminated rom string
*
* copies string in rom to message_buffer
*
*-----------------------------------------------------------------------------

copy_rom_string

	movi	message_buffer-8,a1

	subk	8,a4

crnext_char
	addk	8,a1
	addk	8,a4
	movb	*a4,*a1
	movb	*a4,a0				;NULL ?
	jrnz	crnext_char

	rets

*****************************************************************************
*
* INPUT:	a4 = * null terminated rom string
*
* concatenates string in rom to string in message_buffer
*
*-----------------------------------------------------------------------------

concat_rom_string

	movi	message_buffer-8,a1
ccrnext_char
	addk	8,a1
	movb	*a1,a0
	jrnz	ccrnext_char

	subk	8,a1
	subk	8,a4

ccrnext_char2
	addk	8,a1
	addk	8,a4
	movb	*a4,*a1
	movb	*a4,a0				;NULL ?
	jrnz	ccrnext_char2

	rets


*****************************************************************************
*
* copies string in message_buffer2 to message_buffer
*
*-----------------------------------------------------------------------------

copy_string

	movi	message_buffer-8,a2
	movi	message_buffer2-8,a3

csnext_char
	addk	8,a2
	addk	8,a3
	movb	*a3,*a2
	movb	*a3,a0				;NULL?
	jrnz	csnext_char

	rets

	.even

mess_hardware
	.string	"HARDWARE INFO",0
	.even
m_hardware_info
	.string	"HARDWARE INFORMATION",0
	.even
willy_prompt:
	mess_mac rd15font, spacing07, 200, willy_y, trog_ppurple, strcnrm,0
	.string	"Midway Manufacturing"
	.byte	0,1
	.even
	mess_mac rd15font, spacing20, 200, unit_y, trog_pgreen, strcnrm, 0
	.string	"WOLF UNIT"
	.byte	0,0
	.even
m_dom
	.string	"DATE OF MANUFACTURE:  ",0
	.even
mess_january
	.string	"January  ",0
	.even
mess_february
	.string	"February  ",0
	.even
mess_march
	.string	"March  ",0
	.even
mess_april
	.string	"April  ",0
	.even
mess_may
	.string	"May  ",0
	.even
mess_june
	.string	"June  ",0
	.even
mess_july
	.string	"July  ",0
	.even
mess_august
	.string	"August  ",0
	.even
mess_september
	.string	"September  ",0
	.even
mess_october
	.string	"October  ",0
	.even
mess_november
	.string	"November  ",0
	.even
mess_december
	.string	"December  ",0
	.even
month_table
	.long	mess_january, mess_february, mess_march, mess_april
	.long	mess_may, mess_june, mess_july, mess_august, mess_september
	.long	mess_october, mess_november, mess_december
	.even
mess_hyears
	.string	", 19",0
	.even
man_date_setup:
	mess_mac rd7font, spacing07,200, man_y, trog_pgreen,strcnrm,0
	.byte	0
	.byte	0,0
	.even
m_serial
	.string	"SERIAL NUMBER:  ",0
	.even
serial_num_setup:
	mess_mac rd7font,spacing07,200,serial_y,trog_ppurple,strcnrm,0
	.byte	0
	.byte	0,0
	.even
mess_quit
	mess_mac rd7font,spacing07,200,230,trog_prgb,strcnrm,0
	.string	"PRESS ANY BUTTON TO QUIT"
	.byte	0,0
	.even


hardware_help
	.word	0
	.word	trog_blue
	.word	2
	.long	hdwh_sn
	.long	hdwh_man
hdwh_sn
	.string	"SERIAL NUMBER",0
	.even
hdwh_man
	.string	"MANUFACTURE DATE",0
	.even

sec_mess_2:
	.string	"LEVEL 2 SECURITY CHECK FAILURE",0
	.even

