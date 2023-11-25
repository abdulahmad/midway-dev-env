	.file	"diagdtst.asm"
	.title	"<<< diagnostic routines >>>"
	.width	132
	.option	b,d,l,t
	.mnolist

**************************************************************************
*									    			*
*			diagnostic routines				 		*
*									 			*
*	copyright (c) 1990 williams electronics games, inc.		 	*
*	all rights reserved.						 			*
*									    			*
**************************************************************************
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

;MJL
pic_command	.equ	01600000h	;PIC Command Port
pic_data	.equ	pic_command	;PIC Data Port
;MJL END

**************************************************************************
*									    			*
*	defs and refs							 			*
*									    			*
**************************************************************************

	.def	powertst
	.def	diagcputest, powercmos
	.def	read_dip, forcedip
	.def	burnin
	.def	checkdipfree

	.if	printer
	.else
	.def	switchtest, conv_plot, diptest, colorbar
	.endif


	.ref	duxpal

	.ref	circle, hvline, string, rectangle, point, dscrclr
	.ref	stringcenter,rectangle2
	.ref	sndres
	.ref	new_fac_stuf

	.ref	rom_name, cmos_val, fac_set, warmset, pcmosret
	.ref	cmoslock, cmosunlock, cpu_ret, clscrach, f_adc_s
	.ref	dipinit, irqled
	.ref	wc_bytei, rc_bytei, wipeout, rc_longi, wc_longi
	.ref	clr_aud, store_audit
	.ref	usa_1, usa_2, usa_3, usa_4, usa_electitle
	.ref	german_1, german_2, german_3, german_4, german_5
	.ref	german_electitle
	.ref	french_1, french_2, french_3, french_4, french_electitle

	.ref	kill_aud, get_aud
	.ref	cktest, main_init, diag_myoinit
	.ref	initdata, idatalen

	.ref	dipcointab, set_coin_adj
	.ref	get_cspt, put_adj, cred_p, no_creds
;	.ref	blastmess	
	.if	printer
	.ref	offtime,pbadguy
	.endif

;MJL
	.ref	_read_pic_data
	.ref	_serial_number
	.ref	dec_to_asc
	.ref	copy_string
	.ref	copy_rom_string
	.ref	concat_string
	.ref	message_buffer
	.ref	f_nosound
	.ref	send_code_a3
;MJL END

**************************************************************************
*									    			*
*			some ram for you				 			*
*									    			*
**************************************************************************
	.bss	swset1,32		; for switch test
	.bss	swset2,32
	.bss	swprev1,32
	.bss	swprev2,32

	.bss	dipval,16

	.bss	forcedip,16		; for forcing the use of the dip
	.bss	cerrors,32
	.bss	cpasses,32

	.bss	dipflag,16		;Flag to not make stupid sound 1st pass

;MJL
	.bss	_snd_status,32
	.bss	_b6_save,32		; Temporary register fer me
	.bss	_temporary,32		; Another temp fer me
	.bss	_snd_diag_code,16	; Temporary storage for sound diag code
	.bss	_snd_chip_count,16	; Temporary register fer me
;MJL END

**************************************************************************
*									    			*
*	useful macros							 			*
*									    			*
**************************************************************************

but_mac	$macro	x,y,radius,color,mask,shift,extend
	.word	:x:	
	.word	:y:
	.word	:radius:
	.long	:color:
	.long	:mask:
	.word	:shift:
	.word	:extend:
        $endm

str_mac	$macro	x,y,string,color,dir
	.word	:x:	
	.word	:y:
	.long	:string:
	.word	:color:
	.word	:dir:
        $endm

vecmac	$macro	color,x1,y1,x2,y2
	.word	:color:
	.word	:x1:
	.word	:y1:
	.word	:x2:
	.word	:y2:
	$endm

dotmac	$macro	color,x,y
	.word	:color:
	.word	:x:
	.word	:y:
	$endm

rectmac	$macro	color,x,y,w,h
	.word	:w:
	.word	:h:
	.word	:x:
	.word	:y:
	.word	:color:
	$endm

chipmac	$macro	num,x1,y1,x2,y2,x3,y3,string,dir,x4,y4,stuffed
	.word	:num:
	.word	:x1:
	.word	:y1:
	.word	:x2:
	.word	:y2:
	.word	:x3:
	.word	:y3:
	.long	:string:
	.word	:dir:
	.word	:x4:
	.word	:y4:
	.word	:stuffed:
	$endm

cmnum		equ	0
cmloc		equ	cmnum+16
cmxloc		equ	cmloc
cmyloc		equ	cmloc+16
cmsize		equ	cmloc+32
cmxsize		equ	cmsize
cmysize		equ	cmsize+16
cmoffset		equ	cmsize+32
cmstring		equ	cmoffset+32
cmdir		equ	cmstring+32
cmpinloc		equ	cmdir+16
cmstuffed	equ	cmpinloc+32
cmend		equ	cmstuffed+16


**************************************************************************
*											     *
* ram_chip: macro defines a ram chip record.					     *
* 											     *
*       chip_no	  -- chip number							     *
*       width	  -- chip cell size in bits (must be > 0)		     *
*       interleave -- distance between adjacent cells on chip (in bits)  *
*       start_addr -- address of first cell on chip				     *
*       end_addr   -- address of last cell on chip				     *
*											     *
**************************************************************************

ram_chip $macro tab_link,chip_no, width, interleave, start_addr, end_addr		

	.word  :width:
	.word  :interleave:
	.word  :chip_no:
	.long  :start_addr:
	.long  :end_addr:
	.long	:tab_link:
	$endm

ram_wdth		equ	000h		    ; offsets into ram chip record
ram_itlv 	equ	010h
ram_nmbr 	equ	020h
ram_sadr 	equ	030h
ram_eadr 	equ	050h
ram_link		equ	070h
ram_size 	equ	090h

rom_cksm		equ	000h
rom_map		equ	010h
rom_wdth		equ	020h		    ; offsets into rom chip record
rom_itlv 	equ	030h
rom_nmbr 	equ	040h
rom_sadr 	equ	050h
rom_eadr 	equ	070h
rom_link		equ	090h
rom_size 	equ	0b0h

dog_count	equ	8000h	;every 32k

;****************************************************************************
;* rom_chip: macro defines a rom chip record.						   *
;*												   *
;*	chip_no    -- chip number								   *
;*	width	   -- chip cell size in bits (must be > 0)			   *
;*	interleave -- distance between adjacent cells on chip (in bits)    *
;*	start_addr -- address of first cell on chip 				   *
;*	end_addr   -- address of last cell on chip					   *
;*	check_sum  -- dataio check sum for chip					   *
;*	map        -- 0 = first image bank, 1 = second                     *
;****************************************************************************

rom_chip $macro tab_link,chip_no, width, interleave, start_addr, end_addr, check_sum,map

	.word	:check_sum:
	.word	:map:
        .word  :width:
        .word  :interleave:
        .word  :chip_no:
        .long  :start_addr:
        .long  :end_addr:
	.long	:tab_link:

	$endm


random_seed 	equ 5a5a5a5ah		 ; ram tests: pseudo-random sequence
zero_extend 	equ 1fh			 ; parameters
sign_extend 	equ 20h
;pal_select  	equ 0ffdch			 ; enable video palette map access
pal_select  	equ 0005ch			 ; enable video palette map access

cpu_error_snd	.set	8


        .text
        .even

**************************************************************************
*											     *
* 	powercmos									     *
* 											     *
* 	check the cmos and do a lot of other stuff -- show the	     *
* 	power up messages								     *
* 											     *
* 	entry	nothing									     *
* 	exit	nothing									     *
*											     *
**************************************************************************
powercmos:	
	dint
*
* halt dma
*
	clr  a14
        	move a14, @dmactrl
        	move a14, @dmactrl

	movi	syscinit,a1
	move	a1,@syscopy,w
	move	a1,@sysctrl,w

;	calla	wdogdis			; get rid of watch dog

	clr	a13			; used to decide whether pause or not
	fcall	initcolr,b5		; fix up the colors
	fcall	dscrclr,b6		; make sure of screen
	movi	rom_name,a0
	fcall	stringcenter,b6		; get width of string
	addi	[30,0],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6

;MJL
	callr	_read_pic_data


	movi	sndrevprompt,a0		; sound revision prompt
	fcall	stringcenter,b6
	addi	[120,0],a1
	clr	a2
	movi	trog_purple,a3
	fcall	string,b6
	move	a0,@watchdog,w
	movi	coin_counters,a0
	movi	030h,a1				; yank down the reset
	move	a1,*a0,w
	movi	10000,a1			; hold it fer a while
	dsjs	a1,$
	movi	020h,a1				; let it go
	move	a1,*a0,w
	movi	10000,a1
	dsjs	a1,$
	move	a1,a3
	calla	send_code_a3

; ED - when you get your next set of SOUND ROMS you can turn this code on
; and it should work.  I tried it with wrestling sound roms and it worked
; with them.  I talked to Matt and he said your next set of sound ROMS would
; have this feature enabled.
	.if 1
;	movb	a0,@sound
	move	a0,@watchdog,w
	movi	2500000,a1			; wait fer a while
_swait_lp
	move	a0,@watchdog,w
	dsjs	a1,_swait_lp
	clr	a3			; turn on the sounds
	move	a3,@f_nosound,w
	movi	999,a3			; send revision request sound call
	calla	send_code_a3
	movi	1000000,a2
_sndrev_loop
	movb	a0,@watchdog
	move	@soundirq,a1,w
	btst	b_sdav,a1		; got a response ?
	jrz	_snd_response		; br = yes
	dsjs	a2,_sndrev_loop
_snd_timeout
	movi	sndtimeout,a0		; if we get here we never got a response
	fcall	stringcenter,b6		; tell operator about it
	addi	[135,0],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	jruc	_sndrev_done		; then we be done
_snd_response
	move	@sound,a0,w
	move	a0,@_snd_chip_count,w	; put up sound revision
	move	a0,a1
	andi	0ffh,a1
	cmpi	0ffh,a1
	jrz	_snd_timeout
	andi	0f0h,a1
	cmpi	0d0h,a1
	jrz	_proto_version
	movi	sndreleaseprompt,a4
	jruc	_do_snd_version
_proto_version
	movi	sndprotoprompt,a4
_do_snd_version
	calla	copy_rom_string
	move	@_snd_chip_count,a0,w
	andi	0fh,a0
	movk	15,a1
	calla	dec_to_asc
	calla	concat_string
	movi	message_buffer,a0
	fcall	stringcenter,b6
	addi	[135,0],a1
	clr	a2
	movi	trog_white,a3
	fcall	string,b6
_sndrev_done
	.endif

	movi	gamesnprompt,a0		; put up game serial number
	fcall	stringcenter,b6
	addi	[160,0],a1
	clr	a2
	movi	trog_purple,a3
	fcall	string,b6
	move	@_serial_number,a0,l	; serial number put here by _get_serial_number
	movi	1000000,a1
	calla	dec_to_asc
	calla	copy_string
	movi	message_buffer,a0
	fcall	stringcenter,b6
	addi	[175,0],a1
	clr	a2
	movi	trog_white,a3
	fcall	string,b6

;MJL END

	calla	cmos_val		; checksum audits/adjustments
	jreq	cmosok

*
* bad checksum on powerup ----> factory set
*
	movi	adj_smoke,a0
	calla	get_adj

	push	a0			; save smoke setting !!
	calla	fac_set			; bummer, baby!  reset to factory
	pull	a0			; a0 = smoke setting !
	cmpi	0edb0H,a0		; was smoke active ?
	jrne	fac_no_smoke		; no

	movi	0edb0H,a1	 	; yes, reactivate him !!!
	movi	adj_smoke,a0
	calla	put_adj
	calla	f_adc_s			; make checksums kosher !

fac_no_smoke
	calla	clr_aud
	movk	1,a13			; flag error
	calla	cmos_val		; try again
	jreq	cmosb1
	movi	cmos_bad,a0
	fcall	stringcenter,b6
	addi	[50,0],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	movi	cmos_unfac,a0
	fcall	stringcenter,b6
	addi	[65,0],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	jruc	cmos1
cmosb1
	movi	cmos_facres,a0
	fcall	stringcenter,b6
	addi	[50,0],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	jruc	cmos1
cmosok
	movi	cmos_ok,a0
	fcall	stringcenter,b6
	addi	[50,0],a1
	clr	a2
	movi	trog_green,a3
	fcall	string,b6

cmos1
	calla	cred_p			;check out credits, this will clear
					;if necessary.  thanx linky!

	callr	read_dip
	andi	dip_cmoscoin,a0
	jrnz	cmos3			; br = using cmos coinage

	movi	cmos_dip,a0
	fcall	stringcenter,b6
	addi	[110,0],a1
	clr	a2
	movi	trog_white,a3
	fcall	string,b6
	
	callr	set_dip_coinage
	jruc	cmos4

cmos3
;
;        using cmos here
;
	movi	cmos_cmos,a0
	fcall	stringcenter,b6
	addi	[110,0],a1
	clr	a2
	movi	trog_white,a3
	fcall	string,b6
cmos4	
;	callr	plotcoinage		; plot some coinage 
	move	@switch,a0,l		; check slam switch
	not	a0
	andi	00080000h,a0
	jrz	cmosret
	movi	cmos_tilt,a0
	fcall	stringcenter,b6
	addi	[205,0],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	movk	1,a13			; flag error
cmosret
	move	a13,a13
	jrz	ctmp0

	calla	menu_move_sound
;	movi	0fd43h,a0
;	move	a0,@sound,w
;	movi	0ff43h,a0
;	move	a0,@sound,w		; let him hear it

	movi	cmos_wait,a0
	fcall	stringcenter,b6
	addi	[230,0],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
*
* get the state of switch port #1
*
	move	@switch,a0,l		; hangout for a while
	andi	button_bits,a0
	move	a0,@swset1,l
*
* get the state of switch port #2
*
	move	@switch+32,a0,l
;	andi	10h,a0
	andi	000000077H,a0		; only look at button bits
	move	a0,@swset2,l

ctmp1
;*************
	move	a0,@watchdog		; reset
;*************

	move	@switch,a0,l		; gotta see if time to leave
	move	@swset1,a1,l
	andi	button_bits,a0
	cmp	a0,a1
	jrne	ctmp2			; change in buttons ---> exit

	move	@switch+32,a0,l
	andi	000000077H,a0		; only look at button bits
	move	@swset2,a1,l
	cmp	a0,a1			; compare to the old value
	jreq	ctmp1			; same = loop
	jruc	ctmp2			; change ---> exit

ctmp0

;**************
;	pause	200000h,b6

	movi	200h,a0
ctmp_wait
	move	a0,@watchdog		;reset
	pause	1000h,b6
	dsjs	a0,ctmp_wait
;**************

ctmp2
	jauc	pcmosret




**************************************************************************
*											     *
* initcolr: initialize colors; routine loads palette 0 with the color    *
* 											     *
*           palette used by diagnostic tests.					     *
*											     *
**************************************************************************
* from nba jam
initcolr
	clr  a14
        	move a14, @dmactrl
        	move a14, @dmactrl

	movi	colram,a0,l		; palette location
	movi	duxpal,a1,l

	move	*a1+,a2,w		; length of palette
lplp1
	move	*a1+,*a0+,w
	dsjs	a2,lplp1		; keep on chuggin, baby

	clr     a14
	move    a14,@dmactrl
	move    a14,@dmactrl
	move    a14, @cmapsel
	move    a14, @cmapsel

	fret b5

**************************************************************************
*											     *
* set_dip_coinage - setup coinage according to the dipswitches		     *
*											     *
**************************************************************************
set_dip_coinage
	mmtm	sp,a0,a1,a2,a6

;****************************
	callr	read_dip
	andi	dip_cmoscoin,a0		; using cmos coinage ?
	jrne	sdc_x			; yes, ignore dipswitch setting
;****************************

	callr	read_dip
	move	a0,a2
	andi	dip_country,a0

; mortal kombat change (5-22-92)
;	srl	3,a0			; change to to multiple of 32
	srl	7,a0			; change to to multiple of 32

	addi	dipcointab,a0
	move	*a0,a1,l		; pointer to right coin table

	andi	dip_coinage,a2
	cmpi	dip_coinage,a2		; check for freeplay
	jrz	cmos21

; change for mortal kombat (5-22-92)
;	sll	2,a2			; shift into 3rd nibble
	srl	5,a2			; shift into 3rd nibble (change for mk)

	add	a2,a1
	move	*a1,a1,w		; which coin table to use

	movi	adjprice,a0
	calla	get_adj			;get the coin select number being used.
	cmp	a0,a1			;did we change coin modes
	jreq	sdc_samec
	calla	no_creds		;clear credits
	calla	cred_p			;link-out!
sdc_samec
	movi	adjprice,a0		; master pricing
	calla	put_adj			; stuff it in cmos
	movi	adjfrepl,a0
	clr	a1			; make sure no freeplay
	calla	put_adj
cmos20
	movi	adj1st6,a0		;make them untouched please
	movk	1,a1
	calla	put_adj

	calla	cmosunlock
	calla   f_adc_s			;checksum the adjustments
	calla	cmoslock

	calla	get_cspt
	calla	set_coin_adj		; set the adjustments up in cmos

	calla	cmosunlock
	calla   f_adc_s			;checksum the adjustments
	calla	cmoslock

	jruc	sdc_x
cmos21
	movi	adjfrepl,a0
	movk	1,a1			; freeplay, dude!
	calla	put_adj
	jruc	cmos20
sdc_x
	mmfm	sp,a0,a1,a2,a6
	rets

**************************************************************************
*											     *
* 	plotcoinage									     *
* 											     *
* 	plot out the current coinage on the screen				     *
*											     *
**************************************************************************
plotcoinage:
	.if	printer
	rets
	.else
	movi	adjfrepl,a0
	calla	get_adj
	jrnz	pcfree
pc1
	movi	adjprice,a0
	calla	get_adj			; get the current pricing
        calla   get_cspt
        move    *a6(cs_list),a7,l	
        jrz	pcnohead		; no header, believe it or not
	movi	[130,0],a8		; base address for string
pcnexthead
        move    *a7+,a0,l		; pickup the next pointer
	jrz	pcnohead

	fcall	stringcenter,b6
	add	a8,a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6
	addi	[12,0],a8		; move down a line

	jruc	pcnexthead
	jruc	pcnohead
pcfree
	movi	ducoin7,a0
	fcall	stringcenter,b6
	addi	[130,0],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6

pcnohead
	rets
	.endif

**************************************************************************
*									    *
*									 *
*	cpu testing routines						 *
*									 *
*									    *
**************************************************************************

**************************************************************************
*											     *
* 	burnin										     *
* 											     *
* 	factory burnin test -- exits by reseting the game		     *
* 											     *
* 	entry	nothing									     *
* 	exit	nothing									     *
* 											     *
* 	call	jauc									     *
*											     *
**************************************************************************
burnin:
	movi	audauto,a0		; zero out burnin audit
	calla	kill_aud
burnloop
	dint
;	calla	wdogdis			; later on woof woof
	fcall	cputest,sp

burnsp:
	setf	16,1,0
	setf	32,1,1
	movi	stckst,sp,l		; might help to restore the stack ptr

	movi	syscinit,a0
	move	a0,@sysctrl,w		; initialize system control register
	move	a0,@syscopy,w		; keep a copy in ram

	movi	audauto,a0
	calla	aud1			; another one worked
	jruc	burnloop

**************************************************************************
*									    *
*	diagcputest							 *
*									 *
*	diagnostic call for the cpu test				 *
*									 *
*	entry								 *
*		nothing							 *
*									 *
*	exit								 *
*		jumps to *mainlp* after setting everything up		 *
*									 *
*	call								 *
*		jauc							 *
*									    *
**************************************************************************

diagcputest:
;	calla	wdogdis
	dint
	fcall	cputest,sp
diagsp:
;
	setf	16,1,0			; word no sign extend
	setf	32,1,1			; long word
	movi	stckst,sp,l
	calla	clscrach
	movi	syscinit,a0
	move	a0,@syscopy,w
	move	a0,@sysctrl,w		; get everybody happy

;MJL
	callr	_read_pic_data
;MJL END

	calla	main_init
	calla	diag_myoinit

;MJL
	clr	a3			; make the sound card shut up for now
	calla	send_code_a3
;MJL END

****	calla	color_start		;fire up the colors

	eint				;enable interrupts and we're off

	movk	1,a0
	move	a0,@displayon		;enable the display system
	create	pid_diag,cpu_ret
	movi	gs_diag,a0
	move	a0,@gstate,w
	jauc	mainlp

**************************************************************************
*									    *
*	powercputest							 *
*									 *
*	check out the cpu on power on					 *
*									 *
*	entry								 *
*		nothing							 *
*									 *
*	exit								 *
*		jumps to *pontest*					 *
*									 *
*	call								 *
*		jauc							 *
*									    *
**************************************************************************

powercputest:
	dint

	clr  a14
        	move a14, @dmactrl
        	move a14, @dmactrl

	.if	yunit
	move	@dipswitch,a0,l		; check for power on bypass
	not	a0
	andi	2000h,a0
	janz	pontest

	.else if tunit
	move	@dipswitch,a0,l		; check for power on bypass
	not	a0
	andi	200h,a0
	janz	pontest
	.endif

	fcall	cputest,sp
	jauc	pontest

**************************************************************************
*											     *
* 	cputest										     *
* 											     *
* 	the actual cpu test stuff							     *
* 											     *
* 	entry	sp	return address						     *
* 	exit	who knows								     *
* 	call	fcall	cputest,sp							     *
*											     *
**************************************************************************

;MJL
	.if 0
cput_x	.equ	25	;text x position
cput_y1	.equ	128	;text row 1 y position
cput_y2	.equ	140	;text row 2 y position
cput_y3	.equ	152	;text row 3 y position
cput_clr .equ	[cput_y1,cput_x]	;clear start
cput_clrs .equ	[cput_y3-cput_y1+15,200-cput_x]
	.else
cput_x	.equ	180	;text x position
cput_y1	.equ	118	;text row 1 y position
cput_y2	.equ	130	;text row 2 y position
cput_y3	.equ	142	;text row 3 y position
cput_clr .equ	[cput_y1,cput_x]	;clear start
cput_clrs .equ	[cput_y3-cput_y1+10,389-cput_x]
	.endif
;MJL END

*
* snagged from nba jam to work on the t-unit (ejb - 2/5/93)
*
cputest
	move	a0,@watchdog		;reset
	fcall	initcolr,b5		;hey! it looks better this way
	fcall	dscrclr,b6		;blow the screen or it looks too ugly

	clr	b0
;	movi	0fffch,a13
	movi	syscinit,a13
	move	a13,@sysctrl,w		;make sure we're writing to bit map
	movi	vramchips,a14		;verify bit map
	fcall	ramcheck,b5

;	enable video palette map access

	movi	pal_select,a13
	move	a13,@sysctrl,w
	movi	palchips,a14		;verify object palette ram
	fcall	ramcheck,b5
	move	b0,a12
	
;	disable video palette map access

;	movi	0fffch,a13
	movi	syscinit,a13
	move	a13,@sysctrl,w
	fcall	initcolr,b5		;reload the colors
	fcall	dscrclr,b6

	fcall	cpudraw,b5		;show the cpu
;MJL
;	fcall	get_irom_mode,b11
	movi	cpu,a10			;we got this far, cpu must be ok
;	move	a0,a0
;	jrz	cp1o1
;	movi	ncpu,a10
;MJL END
cp1o1
	movi	1,a11
	fcall	chipout,b5
;MJL 
;	fcall	get_irom_mode,b11	;a0 = 0=masked roms, 1=daughterboard
	movi	vramtab,a9
;	move	a0,a0
;	jrz	cpt1
;	movi	vramtabnew,a9
;MJL END
cpt1
	fcall	chiptable,b5		;plot out the chip table

	move	a12,a12
	jrz	psramck
pbadram
	movi	rambadmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	jruc	pcpubad

psramck
	movi	sramcheck,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6

	clr	b0
;MJL
;	fcall	get_irom_mode,b11
	movi	sramchips,a14		;verify scratch rams
;	move	a0,a0
;	jrz	psr45
;	movi	sramchipsnew,a14
;MJL END
psr45
	fcall	ramcheck,b5
	move	b0,a12
	
	movi	cput_clr,a0
	movi	cput_clrs,a1
	movi	trog_black,a2
	fcall	rectangle,b6

	move	a12,a12
	jrnz	pbadram

promck
	movi	romcmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6

	movi	cpuexit1_mess,a0
	movi	[cput_y2,cput_x],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6

	movi	cpuexit2_mess,a0
	movi	[cput_y3,cput_x],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6

	clr	b0			;keep the stats here

;MJL
;	fcall	get_irom_mode,b11
	movi	promchips,a14
;	move	a0,a0
;	jrz	fcgrt1
;	movi	promchipsnew,a14
;MJL END
fcgrt1
	fcall	romcheck,b5
;MJL
	jrnz	promabort
;	fcall	get_irom_mode,b11	;a0 = 0=masked roms, 1=daughterboard
	movi	iromchips,a14
;	move	a0,a0
;	jrz	iroc_12
;	movi	iromchipsnew,a14
;MJL END
iroc_12
	fcall	romcheck,b5
promabort
	move	b0,a12
	movi	cput_clr,a0
	movi	cput_clrs,a1
	movi	trog_black,a2
	fcall	rectangle,b6

	move	a12,a12
	jrnz	pbadrom

*we check on the dma here
pdmack
	movi	dmacmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6

	fcall	dmacheck,b5		;check the dma
	movi	dma,a10
	move	a0,a11
	move	a0,a12
	inc	a11			;green/red
	fcall	chipout,b5

	movi	cput_clr,a0
	movi	cput_clrs,a1
	movi	trog_black,a2
	fcall	rectangle,b6

	move	a12,a12
;MJL
;	jrz	pcpugood
	jrz	psndtest
;MJL END
	movi	dmabadmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	jruc	pcpubad

;MJL
psndtest
	movi	sndcmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6
	fcall	sndcheck,b6
	move	a0,a12
	movi	cput_clr,a0
	movi	cput_clrs,a1
	movi	trog_black,a2
	fcall	rectangle,b6
	move	a12,a12
	jrz	ppictest
	movi	sndbadmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	jruc	pcpubad
ppictest
	movi	piccmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_yellow,a3
	fcall	string,b6
	fcall	piccheck,b5
	movi	pic,a10
	move	a0,a11
	move	a0,a12
	inc	a11
	fcall	chipout,b5
	movi	cput_clr,a0
	movi	cput_clrs,a1
	movi	trog_black,a2
	fcall	rectangle,b6
	move	a12,a12
	jrz	pcpugood
	movi	picbadmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6
	jruc	pcpubad
;MJL END


pbadrom
	movi	cput_clr,a0
	movi	cput_clrs,a1
	movi	trog_black,a2
	fcall	rectangle,b6
	movi	rombadmess,a0
	movi	[cput_y1,cput_x],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6

pcpubad
	movi	cpupause,a0
	movi	[cput_y2,cput_x],a1
	clr	a2
	movi	trog_red,a3
	fcall	string,b6

pcpuwait
	move	a0,@watchdog		;reset
	movi	cpu_error_snd,a0
	move	a0,@sound,w

; mk
	move	a13,b5
	pause	10000,b6
	move	@switch,a0,l
	andi	button_bits,a0
	move	a0,@swset1,l
	move	@switch+32,a0,l
	andi	10h,a0
	move	a0,@swset2,l
	movi	-1,b0			; assume don't timeout
	cmpi	diagsp,sp
	jrz	pcputmp1
	cmpi	burnsp,sp
	jrz	pcputmp1
	movi	200000h,b0

;**********************************************************
; nba jam
;	move	a13,b5
;	pause	10000,b6
;	fcall	fudge_switches_diag,b6
;	andi	buttons|start_bits,a0
;	move	a0,b1
;	movi	-1,b0			; assume don't timeout
;	cmpi	diagsp,sp
;	jrz	pcputmp1
;	cmpi	burnsp,sp
;	jrz	pcputmp1
;	movi	200000h,b0
;**********************************************************

pcputmp1
	move	a0,@watchdog		;reset
	move	b0,b0
	jrn	pcpunotimeout
	dec	b0
	jrz	pcpuret			; timeout here
pcpunotimeout

; mk
	move	@switch,a0,l		; gotta see if time to leave
	move	@swset1,a1,l
	andi	button_bits,a0
	cmp	a0,a1
	jrnz	pcpuret
	move	@switch+32,a0,l
	andi	10h,a0
	move	@swset2,a1,l
	cmp	a0,a1
	jrnz	pcpuret
	jruc	pcputmp1

; nba jam
;	fcall	fudge_switches_diag,b6
;	andi	buttons|start_bits,a0
;	move	b1,a1
;	cmp	a0,a1
;	jrnz	pcpuret
;	jruc	pcputmp1

pcpugood
	clr	a0
	jruc	pcpurealret
pcpuret
	movk	1,a0
pcpurealret
	move	a0,a0
	fret	sp

;*************************************************************
;        movi	pal_select, a13
;        move	a13,@sysctrl,w
;        movi	palchips, a14		; verify video palette map rams
;        fcall	ramcheck, b5
;	move	b0,a12
;	
;;	disable video palette map access
;
;	movi	0fffch,a13
;        move	a13,@sysctrl,w
;        fcall	initcolr, b5			; display cpu board
;	fcall	dscrclr,b6
;
;	fcall	cpudraw,b5
;	movi	cpu,a10			; we got this far, cpu must be ok
;	movi	1,a11
;	fcall	chipout,b5
;
;	movi	vramtab,a9
;	fcall	chiptable,b5		; plot out the chip table
;
;	move	a12,a12
;	jrz	pdmack
;pbadram
;	movi	rambadmess,a0
;	movi	[128,130],a1
;	clr	a2
;	movi	trog_red,a3
;	fcall	string,b6
;	jruc	pcpubad
;
;pdmack
;	movi	dmacmess,a0
;	movi	[128,130],a1
;	clr	a2
;	movi	trog_yellow,a3
;	fcall	string,b6
;
;	fcall	dmacheck,b5		; check the dma
;	movi	dma,a10
;	move	a0,a11
;	move	a0,a12
;	inc	a11			; green/red
;	fcall	chipout,b5
;
;	movi	[128,130],a0
;	movi	[10,260],a1
;	movi	trog_black,a2
;	fcall	rectangle,b6
;
;	move	a12,a12
;	jrz	psramck
;	movi	dmabadmess,a0
;	movi	[128,130],a1
;	clr	a2
;	movi	trog_red,a3
;	fcall	string,b6
;	jruc	pcpubad
;
;psramck
;	movi	sramcheck,a0
;	movi	[128,130],a1
;	clr	a2
;	movi	trog_yellow,a3
;	fcall	string,b6
;
;	clr	b0
;        movi	sramchips,a14			; verify scratch rams
;        fcall	ramcheck, b5
;        move	b0,a12
;	
;	movi	[128,130],a0
;	movi	[10,260],a1
;	movi	trog_black,a2
;	fcall	rectangle,b6
;
;	move	a12,a12
;	jrnz	pbadram
;
;promck
;	movi	romcmess,a0
;	movi	[128,130],a1
;	clr	a2
;	movi	trog_yellow,a3
;	fcall	string,b6
;
;	movi	txt_abort,a0
;	movi	[072H,130],a1
;	clr	a2
;	movi	trog_blue,a3
;	fcall	string,b6
;
;	clr	b0
;	movi	promchips,a14
;	fcall	romcheck,b5
;	move	b0,b0
;;	jrnz	pbadrom			; for now, woof woof
;
;	clr	b0			; check roms
;	movi	iromchips,a14
;	fcall	romcheck,b5
;
;promabort
;	move	b0,a12
;	movi	[128,130],a0
;	movi	[10,260],a1
;	movi	trog_black,a2
;	fcall	rectangle,b6
;
;	move	a12,a12
;	jrz	pcpugood
;
;pbadrom
;	movi	[128,130],a0
;	movi	[10,260],a1
;	movi	trog_black,a2
;	fcall	rectangle,b6
;	movi	rombadmess,a0
;	movi	[128,130],a1
;	clr	a2
;	movi	trog_red,a3
;	fcall	string,b6
;
;pcpubad
;	movi	cpupause,a0
;	movi	[143,130],a1
;	clr	a2
;	movi	trog_red,a3
;	fcall	string,b6
;
;pcpuwait
;
;;	movi	0fd43h,a0
;;	move	a0,@sound,w
;;	movi	0ff43h,a0
;;	move	a0,@sound,w		; let him hear it
;
;	move	a13,b5
;	pause	10000,b6
;	move	@switch,a0,l
;	andi	button_bits,a0
;	move	a0,@swset1,l
;	move	@switch+32,a0,l
;	andi	10h,a0
;	move	a0,@swset2,l
;	movi	-1,b0			; assume don't timeout
;	cmpi	diagsp,sp
;	jrz	pcputmp1
;	cmpi	burnsp,sp
;	jrz	pcputmp1
;	movi	200000h,b0
;pcputmp1
;	move	b0,b0
;	jrn	pcpunotimeout
;	dec	b0
;	jrz	pcpuret			; timeout here
;pcpunotimeout
;	move	@switch,a0,l		; gotta see if time to leave
;	move	@swset1,a1,l
;	andi	button_bits,a0
;	cmp	a0,a1
;	jrnz	pcpuret
;	move	@switch+32,a0,l
;	andi	10h,a0
;	move	@swset2,a1,l
;	cmp	a0,a1
;	jrnz	pcpuret
;	jruc	pcputmp1
;
;pcpugood
;	clr	a0
;	jruc	pcpurealret
;pcpuret
;	movk	1,a0
;pcpurealret
;	move	a0,a0
;	fret	sp
;

dmacmess
	.STRING	"CHECKING CUSTOM",0
	.even
dmabadmess
;	.STRING	"CUSTOM CHIP U99 BAD",0
	.STRING	"CUSTOM CHIP UE13 BAD",0
	.even

romcmess
	.STRING	"CHECKING ROMS",0
	.even

txt_abort
	.STRING	"PRESS START TO ABORT",0
	.even

rombadmess
	.STRING	"ROM CHIPS BAD",0
	.even

rambadmess
	.STRING	"RAM CHIPS BAD",0
	.even

cpugood
	.STRING	"CPU BOARD OK",0
	.even

cpupause
	.STRING	"PRESS ANY BUTTON",0
	.even

cpuexit1_mess
	.STRING "HOLD START BUTTON",0
	.even
cpuexit2_mess
	.STRING "TO EXIT.",0
	.even

**************************************************************************
*								         *
* 	cpudraw								 *
* 									 *
* 	plot the cpu board and draw all the chips			 *
* 									 *
* 	entry								 *
* 		b5	return address					 *
* 									 *
* 	exit								 *
* 		nothing							 *
*								         *
**************************************************************************
cpudraw:
;MJL
;	fcall	get_irom_mode,b11	;a0 = 0=masked roms, 1=daughterboard
	movi	cpu_vecs,a9		; point at vector table
;	move	a0,a0
;	jrz	cpudlp1
;	movi	cpu_vecs_new,a9
;MJL END
cpudlp1
	move	*a9+,a2,w		; get color
	jrz	cpud1
	move	*a9+,a0,l		; start point
	move	*a9+,a1,l		; end point
	fcall	hvline,b6
	jruc	cpudlp1
cpud1
	move	b5,a13
	fcall	chipplot,b5		; plot all the chips

	movi	boardstring1_ded,a0
	move	@dipswitch,a1,w		; read it in
	not	a1			; invert it for true bits
	andi	0100H,a1			; 8 meg parts ???
	jreq	cpud2			; nope.....
	movi	boardstring1_kit,a0

;MJL
;cpud2	movi	[25,11],a1
cpud2	movi	[15,270],a1
;MJL END
	clr	a2
	movi	trog_white,a3
	fcall	string,b6

	movi	boardstring2,a0
;MJL
;	movi	[37,17],a1
	movi	[25,275],a1
;MJL END
	fcall	string,b6

	movi	boardstring3,a0
;MJL
;	movi	[49,13],a1
	movi	[35,271],a1
;MJL END
	fcall	string,b6

	move	a13,b5
	fret	b5

;MJL
	.if 0
boardstring1_ded
	.STRING	"A-17266-40029",0
	.even

boardstring1_kit
	.STRING	"A-17747-40029",0
	.even

	.else

boardstring1_ded
	.STRING	"A-18968-40039",0
	.even

boardstring1_kit
	.STRING	"A-18968-40039",0
	.even

	.endif
;MJL END

boardstring2
	.STRING	"MORTAL",0
	.even

;MJL
	.if 0
boardstring3
	.string	"KOMBAT 2",0
	.even

	.else

boardstring3
	.string	"KOMBAT 3",0
	.even

	.endif
;MJL END

**************************************************************************
*											     *
* 	chiptable									     *
* 											     *
* 	update a list of chips, based on their values in a12		     *
* 											     *
* 	entry										     *
* 		a9	pointer to table						     *
* 		a12	list of on/off bits					     *
* 		b5	return address						     *
* 											     *
* 	exit	nothing									     *
*											     *
**************************************************************************
chiptable:
	move	b5,a14
ctabloop
	move	*a9+,a10,l		; get pointer to chip record
	jrz	ctabdone
	movk	1,a11
	move	*a10(cmnum),a0,w	; get the bit number
	btst	a0,a12			; check bit number
	jrz	ctabl2
	movk	2,a11
ctabl2
	fcall	chipout,b5
	jruc	ctabloop

ctabdone
	move	a14,b5
	fret	b5

**************************************************************************
*									    *
*	chipplot							 *
*									 *
*	plot out the chip list						 *
*									 *
*	entry								 *
*		b5	ret value					 *
*									 *
*	exit								 *
*		nothing							 *
**************************************************************************

chipplot:
	move	b5,a14
;MJL
;	fcall	get_irom_mode,b11	;a0 = 0=masked roms, 1=daughterboard
	movi	cpu_chips,a10
;	move	a0,a0
;	jrz	cpplotloop
;	movi	cpu_chips_new,a10
;MJL END

cpplotloop
	clr	a11
	move	*a10,a0,l
	jrz	cpplotdone
	fcall	chipout,b5
	addi	cmend,a10
	jruc	cpplotloop

cpplotdone
	move	a14,b5
	fret	b5
	
**************************************************************************
*								         *
* 	chipout								 *
* 									 *
* 	actually plot the chip						 *
* 									 *
* 	entry								 *
* 		a10	points to chip to plot				 *
* 		a11	color of chip					 *
* 				00 = outline				 *
* 				01 = green				 *
* 				02 = red				 *
* 				03 = grey				 *
* 									 *
* 	exit								 *
* 		a10	is intact					 *
*								         *
**************************************************************************
chipout:
	move	*a10(cmloc),a5,l	; chip outline
	move	a5,a6
	move	a5,a7
	move	a5,a8
	move	*a10(cmxsize),a0,w
	add	a0,a6
	add	a0,a7
	move	*a10(cmysize),a0,w
	sll	16,a0
	add	a0,a7
	add	a0,a8
	move	a5,a0
	move	a6,a1
	movi	trog_white,a2
	fcall	hvline,b6
	move	a6,a0
	move	a7,a1
	addi	[1,0],a1
	movi	trog_white,a2
	fcall	hvline,b6
	move	a8,a0
	move	a7,a1
	movi	trog_white,a2
	fcall	hvline,b6
	move	a5,a0
	move	a8,a1
	movi	trog_white,a2
	fcall	hvline,b6
;
	move	*a10(cmstuffed),a0,w	; check for stuffed
	jrnz	conostuf
	movk	3,a11			; want it grey, dude

conostuf
	move	a11,a11			; check for filling the chip
	jrz	conofill
	move	*a10(cmloc),a0,l
	addi	00010001h,a0
	move	*a10(cmsize),a1,l
	subi	00010001h,a1		; get internal area
	move	a11,a2
	sll	4,a2
	addi	chipcolors,a2
	move	*a2,a2,w		; get me a color
	fcall	rectangle,b6
conofill
	move	*a10(cmpinloc),a1,l	; pin location
	move	a5,a0
	add	a1,a0
	movi	trog_white,a1
	fcall	point,b6

	move	*a10(cmstring),a0,l	; chip text
	move	a5,a1
	move	*a10(cmoffset),a2,l
	add	a2,a1
	move	*a10(cmdir),a2,w
	movi	trog_black,a3
	move	a11,a11			; check for color
	jrnz	coblack
	movi	trog_white,a3
coblack
	fcall	string,b6
	fret	b5

chipcolors:
	.word	trog_black
	.word	trog_green
	.word	trog_red
	.word	trog_grey

**************************************************************************
*								         *
* 	dmacheck							 *
* 									 *
* 	check the dma out						 *
* 									 *
* 	entry								 *
* 		b5	return address					 *
* 									 *
* 	exit								 *
* 		a0	dma status					 *
* 				0 = good				 *
* 				1 = bad					 *
*								         *
**************************************************************************
dmacheck
	setf	16,1,0
	move	a0,@watchdog		;reset

	movi	syscinit,a14
	move	a14,@sysctrl,w		;make sure we're writing to bit map

	clr	a14
	move	a14,@dmactrl,w
	move	a14,@dmactrl,w

	movk	dmacf4,a14
	move	a14,@dmaconf,w		;adjust window right/left border
	movi	[511,0],a14
	move	a14,@dmawindow,l	;open left to right
	movi	dmawin|dmacf4,a14
	move	a14,@dmaconf,w		;adjust window right/left border
	movi	[511,0],a14
	move	a14,@dmawindow,l	;full height window
	movi	[100h,100h],a14
	move	a14,@dmascalex,l

	movi	[1,448],a14		;blow out trademark
	move	a14,@dmahsize,l

	clr	a14
	move	a14,@dmaoffst,w		;offset
	move	a14,@dmaconst,w		;constant
	move	a14,@dmahoriz,l		;clear destination address

	movi	2000000h,a14		;dma logo location
	move	a14,@dmasagl,l

	movi	257,a14
	move	a14,@dmavert,w		;offscreen plot

	movi	0505h,a14
	move	a14,@dmacmap,w

	movi	8003h,a14		;use image rom - write always
	move	a14,@dmactrl,w		;kick off the dma

	movi	7fffh,a14		;load timeout counter
dmacwait
	move	a0,@watchdog		;reset
	move	@dmactrl,a0,w		;dma busy?
	jrnn	dmadone			;br = no, time to check
	dsjs	a14,dmacwait
	jruc	dmacbad			;dma timed out

dmadone
	clr	a0			;get back to a real palette
	move	a0,@dmacmap,w
	movi	0101000h,a0		;linear screen location of data
	movi	2000000h,a1		;dma logo location
	movi	448,a2			;number of bytes to compare
dmacloop	     
	movb	*a0,a3			;destination byte
;	sll	28,a3
;	srl	28,a3
	movb	*a1,a4			;source byte
;	sll	28,a4
;	srl	28,a4
	addk	8,a0
	addk	8,a1
	cmp	a3,a4
;We need to fix this so it works!!!! gnp 11/15/93
;;;;;	jrnz	dmacbad			;br = data error
	dsjs	a2,dmacloop
*
*check data in object palette
*
	movi	pal_select,a13
	move	a13,@sysctrl,w		;enable palette

	movi	0101000h,a0		;location
	movi	224,a2			;number of words to compare
dmacloop2
	move	*a0+,a3,w
;	andi	0f0fh,a3
	cmpi	0505h,a3
	jrnz	dmacbad
	dsjs	a2,dmacloop2
	clr	a0
	jruc	dmacret
dmacbad
	clr	a0			;get back to a real palette
	move	a0,@dmactrl,w
	move	a0,@dmactrl,w
	move	a0,@dmacmap,w
	movk	1,a0
dmacret
;	movi	0fffch,a13
	movi	syscinit,a13
	move	a13,@sysctrl,w

	setf	16,0,0

	move	a0,a0
	fret	b5

**************************************************************************
*											     *
* 	powertst									     *
* 											     *
* 	powerup self test routines							     *
* 											     *
* 	entry	nothing									     *
* 	exit	nothing									     *
*											     *
**************************************************************************
powertst
        dint
        setf 16, 0, 0
        setf 32, 0, 1
        movi	stckst,sp,l
*
* halt dma and enable cache
*
        clr  a14
        move a14, @dmactrl
        move a14, @dmactrl
        move a14, @control

	.if	0
;	reset sound board

        movi 0fb00h, a14
        move a14, @sound_board
        clr  a14
        not  a14
        move a14, @sound_board
	.endif

;	disable video palette rams, autoerase and error led

;	movi 0fffch,a13
	movi	syscinit,a13
         move a13,@sysctrl,w

;	disable watch dog

;        setf 16,1,0			;sign extension on for this
;	movi	wdistab,a1	
;	movk	1,a3
;	movi	0fffch,a2
;	move	*a1+,a0,w		
;wdogsl
;	or	a2,a0	
;        move	a0,@sysctrl,w
;	xor	a3,a0
;        move	a0,@sysctrl,w
;	move	*a1+,a0,w
;	jrnn	wdogsl
;        setf 16,0,0			;back off for begleman shit

;	initialize io registers

	movi	hesync,b2,l
	movi	initdata,b0,l
	movi	idatalen,b10
initios:
	move	*b0+,*b2+
	dsjs	b10,initios

	jruc	powercputest
pontest

;	movi	0fffbh,a0
	movi	syscinit,a0
	move	a0,@syscopy,w
         move	a0,@sysctrl,w
	jauc	POWERRET

**************************************************************************
*											     *
* 	ramcheck									     *
* 											     *
* 	check a bank of ram, given a starting table address		     *
* 											     *
* 	entry										     *
* 		a14	pointer to ram table					     *
* 		b5	return address						     *
* 											     *
* 	exit										     *
* 		b0	list of errors						     *
*											     *
**************************************************************************

; taken from nba jam (ejb 2-5-1993)

ramcheck:
	move	a0,@watchdog		;reset
	setf	16,0,0
	setf	32,0,1

;	snag next chip record

ramloop:
	clr	b2
	move	*a14(ram_sadr),a12,l	; starting address
	move	*a14(ram_eadr),a13,l	; ending address
	move	*a14(ram_itlv),a11,w	; interleave
	move	*a14(ram_wdth),a10,w	; width

;	cell count

	sub	a12,a13                   ; (end-start)/interleave+1
	divu	a11,a13
	inc	a13

;	set field sizes

	move	a11,a9			; fs1 = interleave
	andi	zero_extend,a9
	exgf	a9,1

	move	a10,a9			; fs0 = width
	andi	zero_extend,a9
	exgf	a9,0

;	fill in ascending order

	move	a13,a9                    ; xerox count
	move	a12,a8                    ; xerox start

	movi	random_seed,a7
	clr	a5
	movi	dog_count,b14

rac1	sla	1,a7			; generate a pseudo
	jrv	rac2			; random number
	movk	2,a4
	or	a4,a7

rac2	move	a7,a6
	addc	a5,a6

	move	a6,*a8+,1		; write
	dsjs	b14,rac1_nodog
	movb	a0,@watchdog		;reset
	movi	dog_count,b14		;and reload count
rac1_nodog
	dsjs	a9,rac1

					;readback in ascending order
	move	a13,a9			; xerox count
	move	a12,a8			; xerox start

	movi	random_seed,a7
	movi	dog_count,b14

rac3	sla	1,a7			; generate a pseudo
	jrv	rac4			; random number
	movk	2,a4
	or	a4,a7
rac4	move	a7,a6
	addc	a5,a6

	move	*a8,a4,0		;read
	add	a11,a8
	zext	a6

	cmp	a6,a4
	jrne	rac5			;error?

	dsjs	b14,rac5_nodog
	movb	a0,@watchdog		;reset
	movi	dog_count,b14		;and reload count
rac5_nodog
	dsjs	a9,rac3

	jruc	showstat

rac5					;error!
	setf	16,0,0			; reset fields
	setf	32,0,1
	move	*a14(ram_nmbr),a4,w	; get bit number to set
	move	a4,b1
	movk	1,b2
	sll	b1,b2
	or	b2,b0			; set that bit


showstat
	setf	16,0,0			; reset fields
	setf	32,0,1
	move	a0,@watchdog		;reset


;	b1 should be zero if the chip is cool here

	move	*a14(ram_link),a10,l
	jrz	ramnoplot
	movk	1,a11
	move	b2,b2
	jrz	ramplot
	movk	2,a11
ramplot
	move	b5,a9			; i hope this one is safe!
	move	b0,a13
	fcall	chipout,b5
	move	a13,b0
	move	a9,b5

ramnoplot
	addi	ram_size,a14		; advance to next guy
	move	*a14,a7,w
	jrnz	ramloop			; here we go again
	fret	b5


**************************************************************************
*									    			*
*	rom stuff							 			*
*									    			*
**************************************************************************

**************************************************************************
*								         *
* romcheck - routine to checksum the program and image roms.		 *
* returns								 *
* 	b0  = bits set for bad roms.					 *
* 	 z = test finished.						 *
* 	nz = test aborted by user.					 *
*								         *
**************************************************************************
	.align

romcheck:
	move	a0,@watchdog		;reset
romloop	
	clr	b2
;MJL - This was a bug
;	move	*a14(rom_cksm),a13,l	; check to see if rom socket there
	move	*a14(rom_cksm),a13,w	; check to see if rom socket there
;MJL END
	jrz	romempty
******************* jms
	move	@syscopy,a12,w
;MJL
	.if 0
	andi	1111111101111111b,a12	;clear out bank select bit
	.else
	andi	1111110011111111b,a12	;clear out bank select bit
	.endif
;MJL END
	move	*a14(rom_map),a8,w
	jrz	robl1
;MJL
	cmpi	1,a8
	jrz	set_bank_1
;MJL 03
	cmpi	3,a8
	jrz	set_bank_3
;MJL 03 END
	ori	0000001000000000b,a12	;third bank
	jruc	robl1
	.if 0
	ori	0000000010000000b,a12	;second bank
	.else
set_bank_1
	ori	0000000100000000b,a12	;second bank
;MJL 03
	jruc	robl1
set_bank_3
	ori	0000001100000000b,a12	;forth bank
;MJL 03 END
	.endif
;MJL END
robl1	move	a12,@syscopy,w
	move	a12,@sysctrl,w
******************* jms

	clr	a8			; checksum

	movi	dog_count,b14

	move	*a14(rom_sadr),a12,l	; starting address
	move	*a14(rom_eadr),a13,l	; ending address
	move	*a14(rom_itlv),a11,w	; interleave
;
;	sum up a given image rom -- the tunit way
;
	sub	a12,a13			; (( eaddr - saddr ) / interleave) + 1
	divu	a11,a13
	inc	a13
	setf	8,0,1
rcilp
	move	*a12,a7,1		;get a byte
	add	a11,a12
	add	a7,a8
	dsjs	b14,rcilp_nodog
	move	a0,@watchdog		;reset
	movi	dog_count,b14		;and reload count
rcilp_nodog
	dsjs	a13,rcilp

	setf	32,0,1

*land here from image checksum to determine if we hit it
;romckck
	move	*a14(rom_cksm),a7,w
rom_compare
	zext	a7
	zext	a8
	cmp	a7,a8
	jrz	romreloop
	move	*a14(rom_nmbr),a4,w	; get bit number to set
	move	a4,b1
	movk	1,b2
	sll	b1,b2
	or	b2,b0			; set that bit
romreloop
	move	a0,@watchdog		;reset
	move	*a14(rom_link),a10,l
	jrz	romnoplot
	movk	1,a11
	move	b2,b2
	jrz	romplot
	movk	2,a11
romplot
	move	b5,a9			; i hope this one is safe!
	move	b0,a13
	fcall	chipout,b5
	move	a13,b0
	move	a9,b5

romnoplot
	addi	rom_size,a14
*
* are we sick of this ?
*
;MJL
	.if 0
	move	@switch,a13,l
	move	a13,a8
	andi	040000H,a13		; player 1 start pressed
	jrz	romabort		; yes = sans this
	andi	0200000H,a8		; player 2 start pressed ?

	.else

	move	@coins,a13,w
	move	a13,a8
	andi	04H,a13
	jrz	romabort
	andi	020H,a8

	.endif
;MJL END
	jrz	romabort		; yes = sans this
	jruc	romloop			; neither = loop
*
* enough is enough !!
*
romabort
	move	@syscopy,a12,w
;MJL
;	andi	1111111101111111b,a12	;clear out bank select bit
	andi	1111110011111111b,a12	;clear out bank select bit
;MJL END
	move	a12,@syscopy,w
	move	a12,@sysctrl,w
	clrz
	fret	b5
romempty
	move	@syscopy,a12,w
;MJL
;	andi	1111111101111111b,a12	;clear out bank select bit
	andi	1111110011111111b,a12	;clear out bank select bit
;MJL END
	move	a12,@syscopy,w
	move	a12,@sysctrl,w
	setz
	fret	b5




	.if	printer
	.else

**************************************************************************
*											     *
* 	monitor stuff									     *
*											     *
**************************************************************************

conv_plot:
	movi	mon_recs,a9
cprlp1
	move	*a9+,a2,w		; get color
	jrz	cprdone
	move	*a9+,a0,l		; start point
	move	*a9+,a1,l		; dimensions
	fcall	rectangle,b6
	jruc	cprlp1
cprdone
	movi	mon_vecs,a9		; point at vector table
cpvlp1
	move	*a9+,a2,w		; get color
	jrz	cpvdone
	move	*a9+,a0,l		; start point
	move	*a9+,a1,l		; end point
	fcall	hvline,b6
	jruc	cpvlp1
cpvdone
	movi	mon_dots,a9		; point at dot table
cpdlp1
	move	*a9+,a1,w		; get color
	jrz	cpddone
	move	*a9+,a0,l		; get the point
	fcall	point,b6
	jruc	cpdlp1
cpddone
	rets

**************************************************************************
*									    *
*	colorbar							 *
*									    *
**************************************************************************
;colorbar:
;      =========================
;      | set palette 0 for     |
;      | color bars.	       |
;      =========================
;
;	movi	intensities_start,a0,l
;	movi	colram+(07000H),a1,l	; start at palette 8 cause of cyclers
;
;	movk	16,a2				; 5 bits / color
;	movk	8,a6			    ; # color bars
;cb3	move	*a0+,a3 			; starting color
;	move	*a0+,a4 			; color decrement
;	move	a2,a5
;cb4	move	a3,*a1+
;	sub	a4,a3
;	dsjs	a5,cb4
;	dsjs	a6,cb3
;
;	=========================
;	| display color bars	|
;	=========================
;
;	clr	a14
;	move	a14,@dmago		; halt the dma
;	.if	yunit
;	movi	1010h,a14		;a14 is also the palette increment
;	movi	7070h,a8
;	.else
;	movi	0101h,a14
;	movi	0707h,a8
;	.endif
;
;	movi	color_bars,  a3, l		; color bar table
;	movi	[16,0], a13, l			 ; position incrment
;	movi	101h,a12
;	movk	16,  a11		    ; # intensities / bar
;	movk	8,a6			;this many bars
;	clr	a2				  ; starting color
;
;cb6
;	move	*a3+,a1,l
;	jrz	cb8
;	move	a8,@dmacmap,w		;stuff palette
;	move	*a3+,a0,l
;	addk	16,a3
;	move	a11,a10
;cb7
;	fcall	rectangle, b6
;	add	a13, a0
;	add	a12, a2
;	dsjs	a10, cb7
;	add	a14,a8			;next palette please
;	dsj	a6,cb6
;
;cb8
;	clr	a14
;	move	a14,@dmacmap,w
;	rets
;
;
;intensities_start:
;
;	.word 03e0h		   ; green
;	.word 0040h		   ; bump green
;
;	.word 7c00h		   ; red
;	.word 0800h		   ; bump red
;
;	.word 001fh		   ; blue
;	.word 0002h		   ; bump blue
;
;	.word 0000h		   ; black
;	.word 0000h		   ; bump black
;
;	.word 7fffh		   ; white
;	.word 0842h		   ; bump white
;
;	.word 7fe0h		   ; yellow
;	.word 0840h		   ; bump yellow
;
;	.word 7c1fh		   ; purple
;	.word 0802h		   ; bump purple
;
;	.word 03ffh		   ; cyan
;	.word 0042h		   ; bump cyan
;
;	.long	0
;

**************************************************************************
*											     *
* 	colorbar									     *
*											     *
**************************************************************************
col_bars
colorbar:

	movi	intensities_start, a0, l
	movi	colram+100h,a1, l

	movk	16, a2				 ; 5 bits / color
	movk	8, a6				; # color bars
cb3
	addi	0f00H,a1		;step to next palette
	move	*a0+, a3			 ; starting color
	move	*a0+, a4			 ; color decrement

	move a2,a5

cb4	move a3,*a1+
        	sub  a4,a3
        	dsjs a5,cb4
        	dsjs a6,cb3

;       =========================
;       | display color bars    |
;       =========================

        	clr	a14
        	move	a14,@dmago		; halt the dma
        	movi	0101h,a14
        	move	a14,a8

        	movi 	color_bars,a3, l 	; color bar table
        	movi 	[16,0], a13, l		; position incrment
	movi	101h,a12
        	movk   	16,a11			; # intensities / bar
	movk	8,a6			; this many bars
cb6
	clr	a2  			; starting color
	move	*a3+,a1,l
	jrz	cb8
	move	a8,@dmacmap,w		; stuff palette
	move	*a3+,a0,l
	addk	16,a3
	move	a11,a10
cb7
	fcall rectangle2, b6
         add   a13, a0
         add   a12, a2
         dsjs  a10, cb7
	add   a14,a8			; next palette please
	dsj   a6,cb6

cb8
	clr	a14
	move	a14,@dmacmap,w
	rets


intensities_start:

        .word 03e0h		  ; green
        .word 0040h		  ; bump green

        .word 7c00h		  ; red
        .word 0800h		  ; bump red

        .word 001fh		  ; blue
        .word 0002h		  ; bump blue

        .word 0000h		  ; black
        .word 0000h		  ; bump black

        .word 7fffh		  ; white
        .word 0842h		  ; bump white

        .word 7fe0h		  ; yellow
        .word 0840h		  ; bump yellow

        .word 7c1fh		  ; purple
        .word 0802h		  ; bump purple

        .word 03ffh		  ; cyan
        .word 0042h		  ; bump cyan

	.long	0


**************************************************************************
*											     *
* 	diptest										     *
* 											     *
* 	dip switch testing								     *
*											     *
**************************************************************************

diptest:
	move	a0,@watchdog		;reset

	clr	a9
	move	a9,@dipflag,w		

	movi	dip_vecs,a9		; point at vector table
dtvlp1
	move	*a9+,a2,w		; get color
	jrz	dtvdone
	move	*a9+,a0,l		; start point
	move	*a9+,a1,l		; end point
	fcall	hvline,b6
	jruc	dtvlp1
dtvdone

	movi	dip_strs,a9
	callr	str_plot
	callr	dipplot
	callr	dipstate
	pause	10000,b6
	move	@switch,a0,l
	andi	button_bits,a0
	move	a0,@swset1,l
	move	@switch+32,a0,l
;MJL
;	andi	10h,a0
	andi	01e740000H,a0		; exit buttons from coin inputs
;MJL END
	move	a0,@swset2,l

dtloop
	move	a0,@watchdog		;reset

	calla	cktest			; emergency exit
	move	@switch,a0,l		; gotta see if time to leave
	move	@swset1,a1,l
	andi	button_bits,a0
	cmp	a0,a1
	jrz	dtcks1
	rets
dtcks1
	move	@switch+32,a0,l
;MJL
;	andi	10h,a0
	andi	01e740000H,a0		; exit buttons from coin inputs
;MJL END
	move	@swset2,a1,l
	cmp	a0,a1
	jrz	dtlgo
	rets
dtlgo
	callr	read_dip
	move	@dipval,a1,w
	andi	0ffffh,a1		; fucking sign extend
	cmp	a0,a1
	jrz	dtloop

	move	a0,@dipval,w

	jruc	skipskip

	callr	set_dip_coinage

skipskip

	callr	dipplot
	callr	dipstate

;	movi	0fd8bh,a0
;	move	a0,@sound,w
;	movi	0ff8bh,a0
;	move	a0,@sound,w		; let him hear it
	
	move	@dipflag,a0,w
	jrz	dtskipsnd
	calla	menu_move_sound
dtskipsnd
	movk	1,a0
	move	a0,@dipflag,w

	jruc	dtloop

**************************************************************************
*											     *
* 	dipstate									     *
* 											     *
* 	plot out the states of all the dip switches				     *
* 											     *
* 	entry	nothing									     *
* 	exit	nothing									     *
*											     *
**************************************************************************
dipstate
	movi	[32,74],a0
	movi	[104,140],a1
	movi	trog_black,a2
	fcall	rectangle,b6
	movi	[32,284],a0
	movi	[104,111],a1
	movi	trog_black,a2
	fcall	rectangle,b6
	callr	read_dip
*
* ds1 #1 - violence on/off
*
	clr	a2
	movi	trog_white,a3
	movi	msg_violence_on,a1
	callr	read_dip
	andi	dip_violence,a0
	jrz	sd1
	movi	msg_violence_off,a1
sd1	move	a1,a0
	movi	[39,75],a1
	fcall	string,b6
*
* ds1 #2 - blood adjust
*
	clr	a2
	movi	trog_white,a3
	movi	txt_blood_yes,a1
	callr	read_dip
	andi	dip_blood,a0
	jrz	sd11
	movi	txt_blood_no,a1
sd11	move	a1,a0
	movi	[51,75],a1
	fcall	string,b6
*
* ds1 #3 - low blow
*
	clr	a2
	movi	trog_white,a3
	movi	txt_lowb_yes,a1
	callr	read_dip
	andi	dip_low_blow,a0
	jrz	sd12
	movi	txt_lowb_no,a1
sd12	move	a1,a0
	movi	[63,75],a1
	fcall	string,b6
*
* ds1 #4 - attract mode sounds
*
	clr	a2
	movi	trog_white,a3
	movi	txt_ams_yes,a1
	callr	read_dip
	andi	dip_amsounds,a0
	jrz	sd13
	movi	txt_ams_no,a1
sd13	move	a1,a0
	movi	[75,75],a1
	fcall	string,b6
*
* ds1 #5 - comic book offer
*
	movi	txt_comic_on,a1
	callr	read_dip
	andi	dip_comic,a0
	jreq	sd14
	movi	txt_comic_off,a1
sd14	move	a1,a0
	movi	[87,75],a1
	fcall	string,b6
*
* ds1 #6 - dollar bill validator
*
	movi	txt_bill_val_off,a1
	callr	read_dip
	andi	dip_bill_val,a0
	jreq	sd15
	movi	txt_bill_val_on,a1
sd15	move	a1,a0
	movi	[99,75],a1
	fcall	string,b6
*
* ds1 #7 - skip rom test on powerup ???
*
	movi	txt_do_rom_test,a1
	callr	read_dip
	andi	dip_skip_test,a0
	jreq	sd16
	movi	txt_skip_rom_test,a1
sd16	move	a1,a0
	movi	[111,75],a1
	fcall	string,b6
*
* ds1 #8 - daughter board
*
	movi	txt_8meg_off,a1
	callr	read_dip
	andi	dip_8meg,a0
	jreq	sd18
	movi	txt_8meg_on,a1
sd18	move	a1,a0
	movi	[123,75],a1
	fcall	string,b6
*
* ds2 #1 - use cmos coinage flag
*
	movi	txt_usedip,a1
	callr	read_dip
	andi	dip_cmoscoin,a0
	jrz	ds1
	movi	txt_usecmos,a1
ds1	move	a1,a0
	movi	[39,285],a1
	fcall	string,b6
*
* ds2 #2/#3/#4 - dipswitch coinage setting
*
	callr	read_dip
	andi	dip_cmoscoin,a0			;using cmos?
	jrnz	ds_sc				;br=yes, do not plot coinage

	movi	trog_white,a3
	movi	[51,285],a1
	movi	txt_coinage,a0
	fcall	string,b6
	callr	read_dip
	move	a0,a2

	andi	dip_country,a0
; mortal kombat change (5-22-92)
;	srl	3,a0			; change to multiple of 32
	srl	7,a0			; change to multiple of 32
	addi	dcointab,a0
	move	*a0,a1,l		; pointer to right coin table
	andi	dip_coinage,a2
; change for mortal kombat (5-22-92)
;	sll	3,a2			; shift to 3rd nibble (as left as possible)
	srl	4,a2			; shift to 3rd nibble (as left as possible)

	add	a2,a1
	move	*a1,a0,l		; now pointing at message
	clr	a2
	movi	[51,329],a1
	fcall	string,b6

*plot credits to start, credits to continue
	movi	dtostart,a0
	movi	[63,300],a1
	fcall	string,b6

	movi	dtocontinue,a0
	movi	[75,300],a1
	fcall	string,b6

	movi	adjcstrt,a0
	calla	get_adj			; get number needed ( in a0 )
	move	a0,a8
	cmpi	9,a8
	jrls	dsts_1
      	movk	9,a8
dsts_1
	calla	hextoasc
	move	a8,a0
	movi	[63,290],a1
	fcall	string,b6

	movi	adjccont,a0
	calla	get_adj			; get number needed ( in a0 )
	move	a0,a8
	cmpi	9,a8
	jrls	dstc_1
      	movk	9,a8
dstc_1
	calla	hextoasc
	move	a8,a0
	movi	[75,290],a1
	fcall	string,b6
ds_sc

*
* ds2 #5/#6 - country mask
*
	callr	read_dip
	andi	dip_country,a0
; mortal kombat change (5-22-92)
;	srl	3,a0			; change to to multiple of 32
	srl	7,a0			; change to to multiple of 32

	addi	dcountry_tab,a0
	move	*a0,a0,l
	movi	[05cH,285],a1
	fcall	string,b6
;	callr	showcountry		; update the 543 coinage settings
*
* ds2 #7 - # of coin counters
*
	movi	txt_1_counter,a1
	callr	read_dip
	andi	dip_counter,a0		; counter
	jrz	sd2
	movi	txt_2_counter,a1
sd2	move	a1,a0
	movi	[111,285],a1
	fcall	string,b6
*
* ds2 #8 - diagnostics
*
	movi	txt_diag,a0
	movi	[123,285],a1
	fcall	string,b6
*
* coinage tutor box !
*
	movi	txt_coin_help0,a0
	movi	[0a0H,080H],a1
	clr	a2
	movi	trog_green,a3
	fcall	string,b6

	movi	txt_coin_help1,a0
	movi	[0b0H,050H],a1
	clr	a2
	movi	trog_green,a3
	fcall	string,b6

	movi	txt_coin_help2,a0
	movi	[0c0H,050H],a1
	clr	a2
	movi	trog_green,a3
	fcall	string,b6

	movi	txt_coin_help3,a0
	movi	[0d0H,050H],a1
	clr	a2
	movi	trog_green,a3
	fcall	string,b6

	rets				


txt_bill_val_on
	.string	"BILL VALIDATOR ON",0
	.even

txt_bill_val_off
	.string	"BILL VALIDATOR OFF",0
	.even

;MJL
	.if 0

txt_comic_on
	.STRING	"COMIC OFFER ON",0
	.even

txt_comic_off
	.STRING	"COMIC OFFER OFF",0
	.even

	.else

txt_comic_on
txt_comic_off
	.STRING	"NOT USED",0
	.even

	.endif
;MJL END

;MJL
	.if 0
txt_8meg_off
	.string	"2 CIRCUIT BOARDS",0

txt_8meg_on
	.string	"1 CIRCUIT BOARD",0
	.else

txt_8meg_off
txt_8meg_on
	.string	"NOT USED",0

	.endif
;MJL END

txt_skip_rom_test
	.string	"SKIP POWERUP TEST",0

txt_do_rom_test
	.string	"DO POWERUP TEST",0

txt_diag
	.STRING	"TEST SWITCH",0
	.even

txt_coin_help0
	.STRING	"STANDARD USA PRICING:",0
	.even

txt_coin_help1
	.STRING	"USA 1:  2 TO START / 2 TO CONTINUE",0
	.even

txt_coin_help2
	.STRING	"USA 2:  2 TO START / 1 TO CONTINUE",0
	.even

txt_coin_help3
	.STRING	"USA 3:  1 TO START / 1 TO CONTINUE",0
	.even

	.endif

**************************************************************************
*											     *
* 	checkdipfree									     *
* 											     *
* 	check to see if either of the coin slots is on free play,	     *
* 	and if so return z, otherwise don't					     *
* 											     *
* 	entry	nothing									     *
* 	exit	.eq.	yes, freeplay						     *
*											     *
**************************************************************************
; make sure this is free play dipswitch setting (ejbejbejb)
checkdipfree:
	push	a0
	callr	read_dip
	andi	dip_coinage,a0
	cmpi	dip_coinage,a0
cdfret
	pull	a0
	rets

	.if	printer
	.else

**************************************************************************
*											     *
* 	dipplot										     *
* 											     *
* 	plot out the dip switches							     *
* 											     *
* 	entry	nothing									     *
* 	exit	nothing									     *
*											     *
**************************************************************************
dipplot:
	movi	[box1y+1,box1x+1],a0
	movi	[box_height-2,box_width-2],a1
	movi	trog_black,a2
	fcall	rectangle,b6	    			; blank area inside box 1

	movi	[box2y+1,box2x+1],a0
	movi	[box_height-2,box_width-2],a1
	movi	trog_black,a2
	fcall	rectangle,b6				; blank area inside box 2

	callr	read_dip
	clr	a2
diploop
	move	a2,a3
	sll	5,a3
	addi	dipytab,a3
	move	*a3,a3,l
	sll	16,a3			; got the y loc

	clr	a5
	cmpi	8,a2
	jrlo	dipl2
	movi	210,a5
dipl2
	movx	a5,a3

	btst	a2,a0			; check if bit is set
	jrnz	dipon
	movi	dp_off,a1
	addi	29,a3
	movi	trog_grey,a4
	jruc	dipstr

dipon
	movi	dp_on,a1
	addi	32,a3
	movi	trog_white,a4

dipstr
	mmtm	sp,a0,a2
	move	a1,a0			; set string
	move	a3,a1			; set location
	move	a4,a3
	clr	a2			; horizontal
	fcall	string,b6
	mmfm	sp,a0,a2
	inc	a2
	cmpi	16,a2
	jrlo	diploop
	rets


dipytab
	.long	39,51,63,75,87,99,111,123
	.long	39,51,63,75,87,99,111,123

	.endif

**************************************************************************
*											     *
* 	read_dip									     *
* 											     *
* 	read in both dip switches							     *
* 											     *
* 	entry	nothing									     *
* 	exit 	a0	dip switch							     *
*											     *
**************************************************************************
read_dip:
	mmtm	sp,a1,a2,a3
	move	@dipswitch,a0,w		; read it in

;******************** adjust for hardware guys who cant make up their minds
	move	a0,a1
	andi	00000ff00H,a1
	andi	0000000ffH,a0
	sll	8,a0
	srl	8,a1
	or	a1,a0
;******************** adjust for hardware guys who cant make up their minds

	not	a0			; invert it for true bits
	clr	a1
	movi	7,a2
rdloop
	btst	a2,a0
	jrz	rd1
	movk	7,a3
	sub	a2,a3
	bset	a3,a1
rd1
	push	a2
	addi	8,a2
	btst	a2,a0
	jrz	rd2
	movk	15,a3
	sub	a2,a3
	addi	8,a3
	bset	a3,a1
rd2
	pull	a2
	dec	a2
	jrnn	rdloop
	move	a1,a0

	mmfm	sp,a1,a2,a3
	rets

**************************************************************************
*											     *
* 	switchtest									     *
* 											     *
* 	draw out the switches -- a pretty picture				     *
* 											     *
* 	entry	nothing									     *
* 	exit	nothing									     *
*											     *
**************************************************************************
	.if	printer
	.else

switchtest:
;	calla	wdogdis
	clr	a13			; the hold me register
	move	a13,@swset1,l
	move	a13,@swset2,l
	move	a13,@swprev1,l
	move	a13,@swprev2,l

	clr	a10
	movi	but_table,a9
	callr	but_plot		; plot some buttons
	movi	joy_table,a9
	callr	joy_plot		; plot the joysticks
	movi	str_table,a9
	callr	str_plot		; plot the strings

	movi	00b90000h,a0
	movi	00b90190h,a1

	movi	trog_white,a2
	fcall	hvline,b6		; draw little white line

**************************************************************************
*											     *
*    loop    										     *
*											     *
**************************************************************************
sdloop
	move	a0,@watchdog		;reset

	move	@switch,a10,l		; grab me a switch register
	not	a10
;MJL
;	move	a10,a0
	move	@switch+32,a0,l
	not	a0
;MJL END
	andi	donemask,a0
	cmpi	donemask,a0,l		; check for done
	jrnz	sdgo
	rets
sdgo
	move	@swset1,a11,l
	cmp	a11,a10			; check for changes
	jrz	sdck2
	move	a10,@swset1,l
;MJL
;	move	@switch+32,a10,l
	move	@switch+48,a10,w
;MJL END
	not	a10
;MJL
;	andi	0ffH,a10			; look only at 1st 8 bits
	andi	0ffffH,a10 		; look only at 1st 16 bits
;MJL END
	move	a10,@swset2,l		; store in switch set #2
	jruc	sdproc

;MJL
;sdck2	move	@switch+32,a10,l
sdck2	move	@switch+48,a10,w
;MJL END
	not	a10
;MJL
;	andi	0ffH,a10
	andi	0ffffH,a10
;MJL END
	move	@swset2,a11,l
	cmp	a11,a10
	jrz	sdloop
	move	a10,@swset2,l
sdproc

	movi	but_table,a9
	callr	but_plot
	movi	joy_table,a9
	callr	joy_update		; update the joystick info

	move	@swprev1,a1,l
	not	a1
	move	@swset1,a2,l
	not	a2
	or	a2,a1
	cmp	a1,a2
	jrnz	sdsound
	move	@swprev2,a1,l
	not	a1
	move	@swset2,a2,l
	not	a2
	or	a2,a1
	cmp	a1,a2
	jrz	sdnosound

sdsound
;	movi	0fd8bh,a0
;	move	a0,@sound,w
;	movi	0ff8bh,a0
;	move	a0,@sound,w

	calla	menu_move_sound

sdnosound
	move	@swset1,@swprev1,l
	move	@swset2,@swprev2,l

	jruc	sdloop
	rets

**************************************************************************
*											     *
* 	joy_mess									     *
* 											     *
* 	plot the status of a joystick around a circle			     *
* 											     *
* 	entry										     *
* 		a9	center of stick circle					     *
* 		a10	button mask							     *
* 		a11	color								     *
* 		a12	player number						     *
* 											     *
* 	exit	nothing									     *
*											     *
**************************************************************************
joy_mess:
	movi	trog_black,a3
	srl	1,a10
	jrnc	jm1
	move	a11,a3			; set color
jm1
	movi	txt_up,a0
	move	a9,a1			; circle center
	movi	31,a2
	sll	16,a2
	sub	a2,a1			; sub radius from y
	subi	5,a1			; sub string width from x
	clr	a2			; direction
	fcall	string,b6
;
	movi	trog_black,a3
	srl	1,a10
	jrnc	jm2
	move	a11,a3			; set color
jm2
	movi	txt_down,a0
	move	a9,a1			; circle center
	movi	018H,a2
	sll	16,a2
	add	a2,a1			; add radius to y
	subi	012H,a1			; sub string width from x
	clr	a2			; direction
	fcall	string,b6

	movi	trog_black,a3
	srl	1,a10
	jrnc	jm3
	move	a11,a3
jm3
	movi	txt_left,a0
	move	a9,a1			; circle center
	movi	5,a2
	sll	16,a2
	sub	a2,a1			; center letters
	subi	031H,a1			; sub string width from x
	clr	a2			; direction
	fcall	string,b6

	movi	trog_black,a3
	srl	1,a10
	jrnc	jm4
	move	a11,a3
jm4
	movi	txt_right,a0
	move	a9,a1			; circle center
	movi	5,a2
	sll	16,a2
	sub	a2,a1			; center letters
	addi	18,a1			; add string width from x
	clr	a2			; direction
	fcall	string,b6
	rets

**************************************************************************
*											     *
* 	but_plot									     *
* 											     *
* 	plot a button table on the screen						     *
* 											     *
* 	entry	a9	points to button table list				     *
* 		a10	settings of the switch register			     *
* 											     *
* 	exit	nothing									     *
*											     *
**************************************************************************
but_plot:
;	clr	b4
bp_0	move	*a9+,a1,l		; xy loc
	jrz	bpdone

	addi	xpadding,a1		; padding bullshit (thanx m.l)

	move	*a9+,a0,w		; radius
	move	*a9+,a6,l		; color
	move	*a9+,a11,l		; get mask
	addk	16,a9			; shift count
	move	*a9+,a8,w		; jamma extend-o-bit
	jrz	bplow
	move	@swset2,a10,l
	jruc	bpand

bplow	move	@swset1,a10,l

bpand	and	a10,a11			; mask off something useful
	jrz	bphollow
	subk	2,a0
	addi	cfill,a6		; mask in the fill bits
	jruc	bpcirc

bphollow
	mmtm	sp,a0,a1,a6
	subk	2,a0
	movi	trog_black,a6
	addi	cfill,a6
	fcall	circle,b6
	mmfm	sp,a0,a1,a6
bpcirc
	fcall	circle,b6
	jruc	bp_0
bpdone
	rets

**************************************************************************
*											     *
* 	joy_plot									     *
* 											     *
* 	plot a button table on the screen						     *
* 											     *
* 	entry	a9 --> points to button table list				     *
*											     *
**************************************************************************
joy_plot:
	move	*a9+,a1,l		; xy loc
	jrz	jpdone

	addi	xpadding,a1		; padding bullshit (thanx m.l)

	move	*a9+,a0,w		; radius
	move	*a9+,a6,l		; color
	addk	32,a9			; mask
	addk	16,a9			; shift count
	addk	16,a9			; jamma extend-o-bit
	fcall	circle,b6
	jruc	joy_plot

jpdone
	rets

**************************************************************************
*											     *
* 	joy_update									     *
* 											     *
* 	update all the stick information						     *
* 											     *
* 	entry	a9	joystick table pointer					     *
* 		a10	switch information					     *
* 											     *
* 	exit	nothing									     *
*											     *
**************************************************************************
joy_update:
	push	a12
	clr	a12
ju_loop
	move	*a9+,a1,l		; xy loc
	jrz	judone

****	addi	32,a9			
	move	*a9+,a0,w		; radius
****	addi	16,a9
	move	*a9+,a11,l		; color
****	addi	32,a9
	move	*a9+,a6,l		; mask
****	addi	32,a9
	move	*a9+,a7,w		; shift count
****	addi	16,a9
	move	*a9+,a8,w		; extend-o-bit for jamma
	jrz	julow
	move	@swset2,a10,l
	jruc	juand
julow
	move	@swset1,a10,l
juand
****	addi	16,a9
	and	a10,a6			; mask off joystick bits
	not	a7
	addk	1,a7
	srl	a7,a6			; zero base the little sucker
	mmtm	sp,a9,a10
	move	a1,a9			; center of stick here
	move	a6,a10			; button mask
	callr	joy_mess
	mmfm	sp,a9,a10
	inc	a12
	jruc	ju_loop
judone
	pull	a12
	rets

	.endif


**************************************************************************
*											     *
* 	str_plot									     *
* 											     *
* 	plot a string table on the screen						     *
* 											     *
* 	entry	a9	points to string table list				     *
*											     *
**************************************************************************

str_plot:
	move	*a9+,a1,l		; xy loc
	jrz	stdone

****	addi	32,a9			
	move	*a9+,a0,l		; string ptr
****	addi	32,a9
	move	*a9+,a3,w		; color
****	addi	16,a9
	move	*a9+,a2,w		; direction
****	addi	16,a9
	fcall	string,b6
	jruc	str_plot
stdone
	rets


;MJL
	.if 0
**************************************************************************
*											     *
* get_irom_mode returns a0 : 0 = masked roms on 1 board			     *
* 			: 1 = eproms with daughterboard			     *
*											     *
**************************************************************************
get_irom_mode

	move	@dipswitch,a0,w		; read it in
	not	a0			; invert it for true bits
*
* Hard coded !!!!
*
	andi	0100H,a0			; 8 meg parts ???

	jreq	gim6			; nope.....
	clr	a0
	jruc	gim9
gim6	movk	1,a0
gim9	fret	b11
	.endif
;MJL END

;MJL
***********************************************
* PICCHECK - Power up test for the PIC MicroController
* Checks basic communications with the PIC chip
*
piccheck
	movi	1fh,a0			;command code 0xf
	move	a0,@pic_command,w
	movi	0fh,a0
	move	a0,@pic_command,w
	movi	100000,a0		;wait for acknowledge
pic_loop
	move	a1,@watchdog,w
	move	@soundirq,a1,w
	btst	12,a1
	jrz	_got_pic_ack		;br = got acknowledge
	dsjs	a0,pic_loop
	movk	1,a0
	jruc	_piccheck_done
_got_pic_ack
	move	@pic_data,a0,w		;read the data
	movi	010h,a1
	move	a1,@pic_command,w	;tell pic we took data
	movi	100000,a1
_pic_nack_loop
	move	a2,@watchdog,w
	move	@soundirq,a2,w
	btst	12,a2
	jrnz	_got_pic_nack
	dsjs	a1,_pic_nack_loop
	movk	1,a0
	jruc	_piccheck_done
_got_pic_nack
	andi	0fh,a0
	cmpi	0fh,a0
	jrz	_pic_ok
	movk	1,a0
	jruc	_piccheck_done
_pic_ok
	clr	a0
_piccheck_done
	fret	b5



***************************************************
* SNDCHECK - Sound Subsystem Check during CPUTEST
*
sndcheck
	move	b6,@_b6_save,l
	movi	coin_counters,a0
	movi	030h,a1
	move	a1,*a0,w
	movi	8,a1
	dsjs	a1,$
	movi	020h,a1
	move	a1,*a0,w
	movi	5000000,a1
dsp_loop1
	move	a0,@watchdog,w
	move	@soundirq,a2,w
	btst	b_sdav,a2
	jrz	dsp_lp1_exit
	dsjs	a1,dsp_loop1
	movi	dsp,a10
	movk	1,a0
	move	a0,a11
	inc	a11
	fcall	chipout,b5
	movk	1,a0
	jruc	dspcheck_done
dsp_lp1_exit
	move	@sound,a0,w
	andi	0ffh,a0
	cmpi	079h,a0
	jrz	dsp_next_byte
	movi	dsp,a10
	movk	1,a0
	move	a0,a11
	inc	a11
	fcall	chipout,b5
	movk	1,a0
	jruc	dspcheck_done
dsp_next_byte
	movi	10000000,a1
dsp_loop2
	move	a0,@watchdog,w
	move	@soundirq,a2,w
	btst	b_sdav,a2
	jrz	dsp_lp2_exit
	dsjs	a1,dsp_loop2
	movi	dsp,a10
	movk	1,a0
	move	a0,a11
	inc	a11
	fcall	chipout,b5
	movk	1,a0
	jruc	dspcheck_done
dsp_lp2_exit
	movi	dsp,a10
	clr	a0
	move	a0,a11
	inc	a11
	fcall	chipout,b5
	move	@sound,a0,w
	andi	0ffh,a0
	move	a0,a14
	clr	a0
	move	a0,a0
	jrz	dsp_ok
	movk	1,a0
	jruc	dspcheck_done
dsp_ok
	clr	a0
	move	a0,@_snd_status,l
	subi	2,a14
	move	a14,@_snd_diag_code,w
	clr	a14
	move	a14,@_snd_chip_count,w
	movi	sromtab,a12,l
snd_romok_loop
	move	*a12+,a10,l
	jrz	sndrom_done
	move	@_snd_chip_count,a14,w
	move	@_snd_diag_code,a11,w
	cmp	a11,a14
	jrnz	sndchip_ok
	movk	2,a11
	move	a11,@_snd_status,l
	jruc	snd_chip_out
sndchip_ok
	movk	1,a11
snd_chip_out
	addk	1,a14
	move	a14,@_snd_chip_count,w
	fcall	chipout,b5
	move	@_snd_status,a11,l
	jrz	snd_romok_loop
	movk	1,a0
	jruc	dspcheck_done
sndrom_done
	movi	sndramtab,a12,l
snd_ramok_loop
	move	*a12+,a10,l
	jrz	sndram_done
	move	@_snd_diag_code,a14,w
	cmpi	8,a14
	jrnz	sndram_ok
	movk	2,a11
	move	a11,@_snd_status,l
	jruc	snd_ram_out
sndram_ok
	movk	1,a11
snd_ram_out
	fcall	chipout,b5
	move	@_snd_status,a11,l
	jrz	snd_ramok_loop
	movk	1,a0
	jruc	dspcheck_done
sndram_done
	clr	a0
dspcheck_done
	movi	1000000,a1
dspcheck_wait_exit_loop
	move	a2,@watchdog,w
	dsjs	a1,dspcheck_wait_exit_loop
	move	@_b6_save,b6,l
	fret	b6
;MJL END


cfill	equ	0ffff0000h

;
;	format
;
;	x,y,radius,color,mask,shift count ( for joystick stuff ), extendbit
;

trog_p1	equ	trog_red
trog_p2	equ	trog_blue
trog_p3	equ	trog_yellow
trog_p4	equ	trog_purple

**************************************************************************
*									    			*
*	y-unit defs							 			*
*									    			*
**************************************************************************

	.if	printer
	.else

atkx1	.set	078H
atkx2	.set	0130H

**************************************************************************
*											     *
*  mortal kombat joystick layout								     *
*											     *
**************************************************************************
joy_table
;MJL
	.if 0

	but_mac	atkx1-03dH,08aH,15,cfill+trog_p1,0000000fh,0,0	; j1
	but_mac	atkx2-03dH,08aH,15,cfill+trog_p2,00000f00h,8,0	; j2

	.else

	but_mac	atkx1-03dH,08aH,15,cfill+trog_red,0000000fh,0,0	; j1
	but_mac	atkx2-03dH,08aH,15,cfill+trog_red,00000f00h,8,0	; j2

	.endif
;MJL END
	.long	0

**************************************************************************
*											     *
*  mortal kombat button table for switch test					     *
*											     *
**************************************************************************
but_table:
;MJL
	.if 0
	but_mac	07eH,02aH,10,trog_p1,00040000h,0,0		; p1 start
	but_mac	0119H,02aH,10,trog_p2,00200000h,0,0		; p2 start

 	but_mac	atkx1+000H,07aH,10,trog_p1,00000010h,0,0	; p1 high punch
	but_mac	atkx1+000H,09aH,10,trog_p1,00000001h,0,1	; p1 lo punch
;***********
	but_mac	atkx1+020H,08aH,10,trog_p1,80000020h,0,0	; p1 block
;***********
	but_mac	atkx1+040H,07aH,10,trog_p1,00000040h,0,0	; p1 high kick
	but_mac	atkx1+040H,09aH,10,trog_p1,00000002h,0,1	; p1 lo kick


	but_mac	atkx2+000H,07aH,10,trog_p2,00001000h,0,0	; p2 high punch
	but_mac	atkx2+000H,09aH,10,trog_p2,00000010h,0,1	; p2 lo punch

;***********
	but_mac	atkx2+020H,08aH,10,trog_p2,00002000h,0,0	; p2 block
;***********

	but_mac	atkx2+040H,07aH,10,trog_p2,00004000h,0,0	; p2 high kick
	but_mac	atkx2+040H,09aH,10,trog_p2,00000020h,0,1	; p2 lo kick

;	but_mac	260,245,10,trog_green,01000000h,0,0	; video freeze
	but_mac  32,199,10,trog_green,00010000h,0,0	; coin left
	but_mac	 88,199,10,trog_green,00020000h,0,0	; coin right
	but_mac	144,199,10,trog_green,00800000h,0,0	; coin center
	but_mac	200,199,10,trog_green,01000000h,0,0	; fourth coin
	but_mac	256,199,10,trog_green,00400000h,0,0	; service credit
	but_mac	312,199,10,trog_green,00080000h,0,0	; slam
	but_mac	368,199,10,trog_green,00100000h,0,0	; test

	but_mac	230,240,10,trog_green,08000000h,0,0	; volume down
	but_mac	266,240,10,trog_green,10000000h,0,0	; volume up

	.else

	but_mac	07eH,02aH,10,trog_white,00000004h,0,1		; p1 start
	but_mac	0119H,02aH,10,trog_white,00000020h,0,1		; p2 start
 	but_mac	atkx1+000H,07aH,10,trog_red,00000010h,0,0		; p1 high punch
	but_mac	atkx1+000H,09aH,10,trog_red,00010000h,0,0		; p1 lo punch
	but_mac	atkx1+020H,08aH,10,trog_white,00000020h,0,0	; p1 block
	but_mac	atkx1+040H,07aH,10,trog_blue,00000040h,0,0	; p1 high kick
	but_mac	atkx1+040H,09aH,10,trog_blue,00020000h,0,0	; p1 lo kick
	but_mac	atkx2+000H,07aH,10,trog_red,00001000h,0,0		; p2 high punch
	but_mac	atkx2+000H,09aH,10,trog_red,00100000h,0,0		; p2 lo punch
	but_mac	atkx2+020H,08aH,10,trog_white,00002000h,0,0	; p2 block
	but_mac	atkx2+040H,07aH,10,trog_blue,00004000h,0,0	; p2 high kick
	but_mac	atkx2+040H,09aH,10,trog_blue,00200000h,0,0	; p2 lo kick
	but_mac  32,199,10,trog_green,00000001h,0,1		; coin left
	but_mac	 88,199,10,trog_green,00000002h,0,1		; coin right
	but_mac	144,199,10,trog_green,00000080h,0,1		; coin center
	but_mac	200,199,10,trog_green,00000100h,0,1		; fourth coin
	but_mac	256,199,10,trog_green,00000040h,0,1		; service credit
	but_mac	312,199,10,trog_green,00000008h,0,1		; slam
	but_mac	368,199,10,trog_green,00000010h,0,1		; test
	but_mac	178,240,10,trog_green,00000800h,0,1		; volume down
	but_mac	212,240,10,trog_green,00001000h,0,1		; volume up
	but_mac	atkx1-01cH,0aaH,10,trog_yellow,00040000h,0,0	; p1 run
	but_mac	atkx2-01cH,0aaH,10,trog_yellow,00400000h,0,0	; p2 run
	but_mac	55,240,10,trog_green,00002000h,0,1		; coindoor interlock
	but_mac	312,240,10,trog_green,00008000h,0,1		; bill input

	.endif
;MJL END
	.long	0


donemask	equ	00240000h			; p1 + p2 start

str_table:
;MJL
	.if 0

	str_mac	048H,040H,p1start,trog_p1,0	; p1 start
	str_mac	0e5H,040H,p2start,trog_p2,0	; p2 start

;	str_mac	275,242,video,trog_green,0	; video freeze

	str_mac	14,225,leftslot,trog_green,0	; left coin
	str_mac	69,225,rightslot,trog_green,0	; right coin
	str_mac	127,214,center,trog_green,0	; center coin
	str_mac	182,214,fourth,trog_green,0	; coin middle
	str_mac	12,214,coinmess1,trog_green,0	; bottom message
	str_mac	68,214,coinmess2,trog_green,0
	str_mac	235,214,service1,trog_green,0	; service credit
	str_mac	297,214,slam,trog_green,0	; slam
	str_mac	352,214,test,trog_green,0	; test switch
	str_mac	120,237,vdown,trog_green,0	;volume down
	str_mac	226,237,vup,trog_green,0	;volume up

	str_mac	050H,010H,txt_exit,trog_white,0	; get out message 1
;MJL

	.else

	str_mac	048H,040H,p1start,trog_white,0	; p1 start
	str_mac	0e5H,040H,p2start,trog_white,0	; p2 start
	str_mac	14,225,leftslot,trog_green,0	; left coin
	str_mac	69,225,rightslot,trog_green,0	; right coin
	str_mac	127,214,center,trog_green,0	; center coin
	str_mac	182,214,fourth,trog_green,0	; coin middle
	str_mac	12,214,coinmess1,trog_green,0	; bottom message
	str_mac	68,214,coinmess2,trog_green,0
	str_mac	235,214,service1,trog_green,0	; service credit
	str_mac	297,214,slam,trog_green,0	; slam
	str_mac	352,214,test,trog_green,0	; test switch
	str_mac	120,237,vdown,trog_green,0	;volume down
	str_mac	226,237,vup,trog_green,0	;volume up
	str_mac	050H,010H,txt_exit,trog_white,0	; get out message 1
	str_mac	68,237,interlock,trog_green,0	; coindoor interlock
	str_mac	326,237,billinput,trog_green,0	; bill input

	.endif
;MJL END












	.long	0

;MJL
interlock
	.string	"INTR.",0
	.even
billinput
	.string	"BILL",0
	.even
;MJL END
txt_exit
	.STRING	"PRESS BOTH START BUTTONS TO EXIT",0
	.even

p1start
	.STRING	"PLAYER 1 START",0
p2start
	.STRING	"PLAYER 2 START",0

txt_left
	.STRING	"LEFT",0
txt_right
	.STRING	"RIGHT",0
txt_up
	.STRING	"UP",0
txt_down
	.STRING	"DOWN",0


coinmess1
	.STRING	"COIN1",0
coinmess2
	.STRING	"COIN2",0	

leftslot
	.STRING "LEFT",0
rightslot
	.STRING	"RIGHT",0

center
	.STRING	"COIN3",0
fourth
	.STRING	"COIN4",0

service1
	.STRING	"SERVICE",0
service2
	.STRING	"CREDIT",0
slam
	.STRING	"SLAM",0
test
	.STRING	"TEST",0
;MJL
;vdown
;	.STRING	"VOLUME DOWN",0
;vup
;	.STRING	"VOLUME UP",0
vdown
	.STRING	"VOL DN",0
vup
	.STRING	"VOL UP",0
;MJL END


;*******************
;video
;	.STRING	"VIDEO FREEZE",0
;*******************

	.even

	.endif


;	.if	printer
;	.else

**************************************************************************
*											     *
* 	monitor test data area								     *
*											     *
**************************************************************************
mon_vecs:
	vecmac	trog_white,004,004,394,004
	vecmac	trog_white,004,004,004,250
	vecmac	trog_white,004,250,394,250
	vecmac	trog_white,394,250,394,004
	vecmac	trog_white,060,005,060,250
	vecmac	trog_white,115,005,115,250
	vecmac	trog_white,170,005,170,250
	vecmac	trog_white,225,005,225,250
	vecmac	trog_white,280,005,280,250
	vecmac	trog_white,335,005,335,250
	vecmac	trog_white,005,54,394,54
	vecmac	trog_white,005,103,394,103
	vecmac	trog_white,005,152,394,152
	vecmac	trog_white,005,201,394,201
	.long	0

mon_recs:
	vecmac	trog_red,182,000,030,005	; top
	vecmac	trog_green,182,005,030,006
	vecmac	trog_red,182,250,030,005	; bottom
	vecmac	trog_green,182,244,030,006
	vecmac	trog_red,000,117,005,020	; left
	vecmac	trog_green,005,117,006,020
	vecmac	trog_red,394,117,005,020	; right
	vecmac	trog_green,388,117,006,020
	.long	0

mon_dots:
	dotmac	trog_white,032,029
	dotmac	trog_white,087,029
	dotmac	trog_white,142,029
	dotmac	trog_white,197,029
	dotmac	trog_white,252,029
	dotmac	trog_white,307,029
	dotmac	trog_white,362,029

	dotmac	trog_white,032,078
	dotmac	trog_white,087,078
	dotmac	trog_white,142,078
	dotmac	trog_white,197,078
	dotmac	trog_white,252,078
	dotmac	trog_white,307,078
	dotmac	trog_white,362,078

	dotmac	trog_white,032,127
	dotmac	trog_white,087,127
	dotmac	trog_white,142,127
	dotmac	trog_white,197,127
	dotmac	trog_white,252,127
	dotmac	trog_white,307,127
	dotmac	trog_white,362,127

	dotmac	trog_white,032,176
	dotmac	trog_white,087,176
	dotmac	trog_white,142,176
	dotmac	trog_white,197,176
	dotmac	trog_white,252,176
	dotmac	trog_white,307,176
	dotmac	trog_white,362,176

	dotmac	trog_white,032,225
	dotmac	trog_white,087,225
	dotmac	trog_white,142,225
	dotmac	trog_white,197,225
	dotmac	trog_white,252,225
	dotmac	trog_white,307,225
	dotmac	trog_white,362,225
	.long	0

primary_colors:
	rectmac	trog_red,0,0,395,255
	rectmac	trog_green,0,0,395,255
	rectmac	trog_blue,0,0,395,255
	.long	0

color_bars:
        rectmac	trog_black,   0+xpadding, 0, 49, 16
        rectmac	trog_black,  49+xpadding, 0, 49, 16
        rectmac	trog_black,  98+xpadding, 0, 49, 16
        rectmac	trog_black, 147+xpadding, 0, 49, 16
        rectmac	trog_black, 196+xpadding, 0, 49, 16	
        rectmac	trog_black, 245+xpadding, 0, 49, 16
        rectmac	trog_black, 294+xpadding, 0, 49, 16
        rectmac	trog_black, 343+xpadding, 0, 49, 16
	.long	0

**************************************************************************
*									    			*
*	dip switch display stuff					 			*
*									    			*
**************************************************************************
box1x		.set	20
box1y		.set	32

box2x		.set	230
box2y		.set	32
box_height	.set	104
box_width	.set	40

dip_vecs:
	vecmac	trog_red,20,32,60,32		; ds1
	vecmac	trog_red,20,32,20,138
	vecmac	trog_red,20,138,60,138
	vecmac	trog_red,60,32,60,138

	vecmac	trog_red,box2x,box2y,box2x+box_width,box2y	; ds2
	vecmac	trog_red,box2x,box2y,box2x,box2y+box_height
	vecmac	trog_red,box2x,box2y+box_height,box2x+box_width,box2y+box_height
	vecmac	trog_red,box2x+box_width,box2y,box2x+box_width,box2y+box_height
*
* box 1 white "connector" lines
*
	vecmac	trog_white,63,42,73,42	; 9
	vecmac	trog_white,63,54,73,54	; 10
	vecmac	trog_white,63,66,73,66	; 11
	vecmac	trog_white,63,78,73,78	; 12
	vecmac	trog_white,63,90,73,90	; 13
	vecmac	trog_white,63,102,73,102	; 14
	vecmac	trog_white,63,114,73,114	; 15
	vecmac	trog_white,63,126,73,126	; 16
*
* box 2 white "connector" lines
*
	vecmac	trog_white,box2x+43,box2y+10,box2x+53,box2y+10

	vecmac	trog_white,box2x+43,box2y+22,box2x+48,box2y+22
	vecmac	trog_white,box2x+48,box2y+22,box2x+48,box2y+46
	vecmac	trog_white,box2x+48,box2y+46,box2x+43,box2y+46  ; coinage
	vecmac	trog_white,box2x+48,box2y+34,box2x+53,box2y+34  ; bracket

	vecmac	trog_white,box2x+43,box2y+58,box2x+48,box2y+58
	vecmac	trog_white,box2x+48,box2y+58,box2x+48,box2y+70
	vecmac	trog_white,box2x+48,box2y+64,box2x+53,box2y+64  ; country
	vecmac	trog_white,box2x+48,box2y+70,box2x+43,box2y+70  ; bracket

	vecmac	trog_white,box2x+43,box2y+82,box2x+53,box2y+82
	vecmac	trog_white,box2x+43,box2y+94,box2x+53,box2y+94

	.long	0

dip_strs:
	str_mac	74,8,dp_title,trog_yellow,0
	str_mac	30,20,dp_ds1,trog_white,0
	str_mac	240,20,dp_ds2,trog_white,0
	str_mac	7,39,dp_dsn1,trog_white,0
	str_mac	7,51,dp_dsn2,trog_white,0
	str_mac	7,63,dp_dsn3,trog_white,0
	str_mac	7,75,dp_dsn4,trog_white,0
	str_mac	7,87,dp_dsn5,trog_white,0
	str_mac	7,99,dp_dsn6,trog_white,0
	str_mac	7,111,dp_dsn7,trog_white,0
	str_mac	7,123,dp_dsn8,trog_white,0

	str_mac	217,39,dp_dsn1,trog_white,0
	str_mac	217,51,dp_dsn2,trog_white,0
	str_mac	217,63,dp_dsn3,trog_white,0
	str_mac	217,75,dp_dsn4,trog_white,0
	str_mac	217,87,dp_dsn5,trog_white,0
	str_mac	217,99,dp_dsn6,trog_white,0
	str_mac	217,111,dp_dsn7,trog_white,0
	str_mac	217,123,dp_dsn8,trog_white,0

	str_mac	100,240,dp_ins1,trog_yellow,0
	.long	0

dp_title
;MJL
;	.STRING	"MORTAL KOMBAT 2 DIPSWITCH SETTINGS",0
	.STRING	"MORTAL KOMBAT 3 DIPSWITCH SETTINGS",0
;MJL END
	.even

dp_ins1
	.STRING	"PRESS ANY BUTTON TO EXIT",0
	.even

;MJL
	.if 0
dp_ds1
	.STRING	"UJ1",0
	.even

dp_ds2
	.STRING	"UJ2",0
	.even

dp_dsn1
	.STRING	"1",0
	.even

dp_dsn2
	.STRING	"2",0
	.even

dp_dsn3	.string	"3",0
	.even

dp_dsn4	.string	"4",0
	.even

dp_dsn5	.string	"5",0
	.even

dp_dsn6	.string	"6",0
	.even	

dp_dsn7	.string	"7",0
	.even

dp_dsn8	.string	"8",0
	.even

	.else

dp_ds1
	.STRING	"SW2",0
	.even

dp_ds2
	.STRING	"SW1",0
	.even

dp_dsn1
	.STRING	"8",0
	.even

dp_dsn2
	.STRING	"7",0
	.even

dp_dsn3	.string	"6",0
	.even

dp_dsn4	.string	"5",0
	.even

dp_dsn5	.string	"4",0
	.even

dp_dsn6	.string	"3",0
	.even	

dp_dsn7	.string	"2",0
	.even

dp_dsn8	.string	"1",0
	.even

	.endif
;MJL END

dp_on
	.STRING	"ON",0
	.even

dp_off	.string	"OFF",0
	.even

txt_usecmos
	.STRING	"CMOS COINAGE",0
	.even

txt_usedip
	.STRING	"DIPSWITCH COINAGE",0
	.even

********************************************* JAKE START
;txt_1_counter
;	.STRING	"ONE COUNTER",0
;	.even
;
;txt_2_counter
;	.STRING	"TWO COUNTERS",0
;	.even

txt_2_counter
	.STRING	"1 COUNT/COIN",0
	.even

txt_1_counter
	.STRING	"TOTALIZING",0
	.even
********************************************* JAKE END

txt_coinage
	.STRING	"PRICE:",0
	.even

dcountry_tab
	.long	dcountry_0
	.long	dcountry_1
	.long	dcountry_2
	.long	dcountry_3

dcountry_0
	.STRING	"COUNTRY - USA",0
	.even
dcountry_1
	.STRING	"GERMAN",0
	.even
dcountry_2
	.STRING	"FRENCH",0
	.even

dtostart
	.STRING	"TO START",0
	.even
dtocontinue
	.STRING	"TO CONTINUE",0
	.even

dtest_0
	.STRING	"TEST SWITCH",0
	.even

dcountry_3
dfreeze_0
msg_unused
dgcoin4
	.STRING	"UNUSED",0
	.even

ducoin7
	.STRING	"FREEPLAY",0
	.even

msg_violence_on
	.STRING	"VIOLENCE ON",0
	.even

msg_violence_off
	.STRING	"VIOLENCE OFF",0
	.even

txt_blood_yes
	.STRING	"BLOOD IN GAME",0
	.even

txt_blood_no
	.STRING	"NO BLOOD IN GAME",0
	.even

;MJL
	.if 0
txt_lowb_yes
	.STRING	"LOW BLOW IN GAME",0
	.even

txt_lowb_no
	.STRING	"NO LOW BLOWS",0
	.even
	
	.else

txt_lowb_yes
txt_lowb_no
	.STRING	"NOT USED",0
	.even

	.endif
;MJL END

txt_ams_yes
	.STRING	"ATTRACT SOUNDS ON",0
	.even

txt_ams_no
	.STRING	"NO ATTRACT SOUNDS",0
	.even



ducointab
	.long	usa_1,usa_2,usa_3,usa_4,usa_electitle,dgcoin4
	.long	dgcoin4,ducoin7

dgcointab
	.long	german_1,german_2,german_3,german_4,german_5
	.long	german_electitle,dgcoin4,ducoin7

dfcointab
	.long	french_1,french_2,french_3,french_4,french_electitle
	.long	dgcoin4,dgcoin4,ducoin7


dcointab
	.long	ducointab, dgcointab, dfcointab, ducointab

;	.endif


cmos_tilt
	.STRING	"WARNING -- SLAM SWITCH CLOSED",0
	.even
	
cmos_dip
	.STRING	"USING DIPSWITCH COINAGE",0
	.even

cmos_cmos
	.STRING	"USING CMOS COINAGE",0
	.even

cmos_wait
	.STRING	"ERRORS DETECTED -- ANY BUTTON TO CONTINUE",0
	.even

cmos_facres
	.STRING	"CMOS INVALID -- FACTORY SETTINGS RESTORED",0
	.even

cmos_bad
	.STRING	"CMOS CHIP U49 BAD",0
	.even

cmos_unfac
	.STRING	"UNABLE TO RESTORE FACTORY SETTINGS",0
	.even

cmos_ok
	.string	"CMOS OK",0
	.even

;cmos_abad
;	.STRING	"UNABLE TO RESET ALLTIME HIGHSCORE TABLE",0
;	.even
;cmos_tbad
;	.STRING	"UNABLE TO RESET DAILY HIGHSCORE TABLE",0
;	.even


**************************************************************************
*									    			*
*	cpu board information						 			*
*									    			*
**************************************************************************
* from nba jam
;MJL 
	.if 0
cpu_vecs:
	vecmac	trog_white,5,15,390,15		; board outline
	vecmac	trog_white,390,15,390,254
	vecmac	trog_white,5,253,390,253
	vecmac	trog_white,5,15,5,100
	vecmac	trog_white,5,100,15,100
	vecmac	trog_white,15,100,15,115
	vecmac	trog_white,5,115,15,115
	vecmac	trog_white,5,115,5,135
	vecmac	trog_white,5,135,15,135
	vecmac	trog_white,15,135,15,138
	vecmac	trog_white,5,138,15,138
	vecmac	trog_white,5,138,5,215
	vecmac	trog_white,5,215,15,215
	vecmac	trog_white,15,215,15,230
	vecmac	trog_white,5,230,15,230
	vecmac	trog_white,5,230,5,254

	.long	0

cpu_vecs_new:
	vecmac	trog_white,5,15,390-115,15		; board outline
	vecmac	trog_white,390-115,15,390-115,254
	vecmac	trog_white,5,253,390-115,253
	vecmac	trog_white,5,15,5,100
	vecmac	trog_white,5,100,15,100
	vecmac	trog_white,15,100,15,115
	vecmac	trog_white,5,115,15,115
	vecmac	trog_white,5,115,5,135
	vecmac	trog_white,5,135,15,135
	vecmac	trog_white,15,135,15,138
	vecmac	trog_white,5,138,15,138
	vecmac	trog_white,5,138,5,215
	vecmac	trog_white,5,215,15,215
	vecmac	trog_white,15,215,15,230
	vecmac	trog_white,5,230,15,230
	vecmac	trog_white,5,230,5,254
	vecmac	trog_white,280,70,390,70
	vecmac	trog_white,280,253,390,253
	vecmac	trog_white,280,70,280,253
	vecmac	trog_white,390,70,390,253

	.long	0
	.else
cpu_vecs:
	vecmac	trog_white,5,5,5,243		; board outline
	vecmac	trog_white,5,243,390,243
	vecmac	trog_white,390,243,390,5
	vecmac	trog_white,390,5,355,5
	vecmac	trog_white,355,5,355,10
	vecmac	trog_white,355,10,343,10
	vecmac	trog_white,343,10,343,5
	vecmac	trog_white,343,5,326,5
	vecmac	trog_white,326,5,326,10
	vecmac	trog_white,326,10,323,10
	vecmac	trog_white,323,10,323,5
	vecmac	trog_white,323,5,212,5
	vecmac	trog_white,212,5,212,10
	vecmac	trog_white,212,10,200,10
	vecmac	trog_white,200,10,200,5
	vecmac	trog_white,200,5,5,5
	.long	0
	.endif

cpuxbase	equ	5
cpuybase	equ	5

cpu_chips:
	.if 0
cram1	chipmac	0,125,25,20,45,7,11,cnamea8,1,2,2,1	; color ram
cram2	chipmac	1,125,75,20,45,7,11,cnamec8,1,2,2,1	; color ram

vram1	chipmac	2,190,25,15,38,6,2,cnamea11,1,2,2,1	; bank 1 video ram
vram2	chipmac	3,207,25,15,38,6,2,cnamea12,1,2,2,1	;   (palette)
vram3	chipmac	4,224,25,15,38,6,2,cnamea13,1,2,2,1
vram4	chipmac	5,241,25,15,38,6,2,cnamea14,1,2,2,1

vram5	chipmac	6,190,71,15,38,6,2,cnameb11,1,2,2,1	; bank 2 video ram
vram6	chipmac	7,207,71,15,38,6,2,cnameb12,1,2,2,1	;   (pixel)
vram7	chipmac	8,224,71,15,38,6,2,cnameb13,1,2,2,1
vram8	chipmac	9,241,71,15,38,6,2,cnameb14,1,2,2,1

cpu	chipmac	0,330,60,35,35,4,13,cnameb21,0,3,3,1	; cpu

dma	chipmac	0,201,120,38,38,6,16,cnamee13,0,3,3,1	; dma

prom1	chipmac	1,155,210,20,40,7,3,cnamej12,1,2,2,1	; program rom 1
prom2	chipmac	0,155,167,20,40,7,3,cnameg12,1,2,2,1	; program rom 2

irom1	chipmac	1,195,167,20,40,7,3,cnameg14,1,2,2,1	; image rom
irom2	chipmac	2,217,167,20,40,7,3,cnameg16,1,2,2,1	; image rom
irom3	chipmac	3,239,167,20,40,7,3,cnameg17,1,2,2,1	; image rom
irom4	chipmac	4,261,167,20,40,7,3,cnameg18,1,2,2,0	; image rom

irom5	chipmac	5,283,167,20,40,7,3,cnameg19,1,2,2,1	; image rom
irom6	chipmac	6,305,167,20,40,7,3,cnameg20,1,2,2,1	; image rom
irom7	chipmac	7,327,167,20,40,7,3,cnameg22,1,2,2,1	; image rom
irom8	chipmac	8,349,167,20,40,7,3,cnameg23,1,2,2,0	; image rom

irom9	chipmac	9,195,210,20,40,7,3,cnamej14,1,2,2,1	; image rom
irom10	chipmac	10,217,210,20,40,7,3,cnamej16,1,2,2,1	; image rom
irom11	chipmac	11,239,210,20,40,7,3,cnamej17,1,2,2,1	; image rom
irom12	chipmac	12,261,210,20,40,7,3,cnamej18,1,2,2,0	; image rom

irom13	chipmac	13,283,210,20,40,7,3,cnamej19,1,2,2,1	; image rom
irom14	chipmac	14,305,210,20,40,7,3,cnamej20,1,2,2,1	; image rom
irom15	chipmac	15,327,210,20,40,7,3,cnamej22,1,2,2,1	; image rom
irom16	chipmac	16,349,210,20,40,7,3,cnamej23,1,2,2,0	; image rom

sram1	chipmac	0,50,210,13,33,4,4,cnamej4,1,2,2,1	; scratch pad
sram2	chipmac	1,67,210,13,33,4,4,cnamej5,1,2,2,1	; scratch pad
sram3	chipmac	2,84,210,13,33,4,4,cnamej6,1,2,2,1	; scratch pad
sram4	chipmac	3,101,210,13,33,4,4,cnamej7,1,2,2,1	; scratch pad

	.else

cram1	chipmac	0,347,152,30,13,5,3,cnameu36,0,28,2,1	; color ram (u36)
cram2	chipmac	1,313,152,30,13,5,3,cnameu37,0,28,2,1	; color ram (u37)

vram1	chipmac	2,347,207,38,13,8,3,cnameu14,0,36,2,1	; bank 1 video ram (u14)
vram2	chipmac	3,307,207,38,13,8,3,cnameu15,0,36,2,1	;   (palette) (u15)
vram3	chipmac	4,267,207,38,13,8,3,cnameu16,0,36,2,1	; (u16)
vram4	chipmac	5,227,207,38,13,8,3,cnameu17,0,36,2,1	; (u17)

vram5	chipmac	6,347,225,38,13,8,3,cnameu10,0,36,2,1	; bank 2 video ram (u10)
vram6	chipmac	7,307,225,38,13,8,3,cnameu11,0,36,2,1	;   (pixel) (u11)
vram7	chipmac	8,267,225,38,13,8,3,cnameu12,0,36,2,1	; (u12)
vram8	chipmac	9,227,225,38,13,8,3,cnameu13,0,36,2,1	; (u13)

cpu	chipmac	0,330,50,35,35,7,13,cnameu59,0,3,3,1	; cpu (u59)

dma	chipmac	0,246,157,38,38,8,16,cnameu33,0,3,3,1	; dma (u33)

prom1	chipmac	1,220,65,40,13,9,3,cnameu63,0,38,2,1	; program rom 1 (u63)
prom2	chipmac	0,220,83,40,13,9,3,cnameu54,0,38,2,1	; program rom 2 (u54)

irom1	chipmac	1,10,122,40,13,6,3,  cnameu133,0,38,2,1	; image rom (u133)
irom2	chipmac	2,52,122,40,13,6,3,  cnameu132,0,38,2,1	; image rom (u132)
irom3	chipmac	3,94,122,40,13,6,3,  cnameu131,0,38,2,1	; image rom (u131)
irom4	chipmac	4,136,122,40,13,6,3, cnameu130,0,38,2,1	; image rom (u130)

irom5	chipmac	5,10,137,40,13,6,3,  cnameu129,0,38,2,1	; image rom (u129)
irom6	chipmac	6,52,137,40,13,6,3,  cnameu128,0,38,2,1	; image rom (u128)
irom7	chipmac	7,94,137,40,13,6,3,  cnameu127,0,38,2,1	; image rom (u127)
irom8	chipmac	8,136,137,40,13,6,3, cnameu126,0,38,2,1	; image rom (u126)

irom9	chipmac	9,10,152,40,13,6,3,  cnameu125,0,38,2,1	; image rom (u125)
irom10	chipmac	10,52,152,40,13,6,3, cnameu124,0,38,2,1	; image rom (u124)
irom11	chipmac	11,94,152,40,13,6,3, cnameu123,0,38,2,1	; image rom (u123)
irom12	chipmac	12,136,152,40,13,6,3,cnameu122,0,38,2,1	; image rom (u122)

irom13	chipmac	13,10,167,40,13,6,3, cnameu121,0,38,2,1	; image rom (u121)
irom14	chipmac	14,52,167,40,13,6,3, cnameu120,0,38,2,1	; image rom (u120)
irom15	chipmac	15,94,167,40,13,6,3, cnameu119,0,38,2,1	; image rom (u119)
irom16	chipmac	16,136,167,40,13,6,3,cnameu118,0,38,2,1	; image rom (u118)

irom17	chipmac	17,10,182,40,13,6,3, cnameu117,0,38,2,1	; image rom (u117)
irom18	chipmac	18,52,182,40,13,6,3, cnameu116,0,38,2,1	; image rom (u116)
irom19	chipmac	19,94,182,40,13,6,3, cnameu115,0,38,2,1	; image rom (u115)
irom20	chipmac	20,136,182,40,13,6,3,cnameu114,0,38,2,1	; image rom (u114)

irom21	chipmac	21,10,197,40,13,6,3, cnameu113,0,38,2,1	; image rom (u113)
irom22	chipmac	22,52,197,40,13,6,3, cnameu112,0,38,2,1	; image rom (u112)
irom23	chipmac	23,94,197,40,13,6,3, cnameu111,0,38,2,1	; image rom (u111)
irom24	chipmac	24,136,197,40,13,6,3,cnameu110,0,38,2,1	; image rom (u110)

irom25	chipmac	25,10,212,40,13,6,3, cnameu109,0,38,2,1	; image rom (u109)
irom26	chipmac	26,52,212,40,13,6,3, cnameu108,0,38,2,1	; image rom (u108)
irom27	chipmac	27,94,212,40,13,6,3, cnameu107,0,38,2,1	; image rom (u107)
irom28	chipmac	28,136,212,40,13,6,3,cnameu106,0,38,2,1	; image rom (u106)

irom29	chipmac	29,10,227,40,13,6,3, cnameu105,0,38,2,1	; image rom (u105)
irom30	chipmac	30,52,227,40,13,6,3, cnameu104,0,38,2,1	; image rom (u104)
irom31	chipmac	31,94,227,40,13,6,3, cnameu103,0,38,2,1	; image rom (u103)
irom32	chipmac	32,136,227,40,13,6,3,cnameu102,0,38,2,1	; image rom (u102)

sram1	chipmac	0,225,101,30,13,4,3,cnameu49,0,28,2,1	; scratch pad (u49)

pic	chipmac	0,177,65,40,13,9,3,cnameu64,0,38,2,1	; pic chip (u64)

srom1	chipmac	1,49,57,40,13,14,3, cnameu2,0,38,2,1	; sound rom (u2)
srom2	chipmac	2,49,72,40,13,14,3, cnameu3,0,38,2,1	; sound rom (u3)
srom3	chipmac	3,49,87,40,13,14,3, cnameu4,0,38,2,1	; sound rom (u4)
srom4	chipmac	4,49,102,40,13,14,3,cnameu5,0,38,2,1	; sound rom (u5)
srom5	chipmac	5,7,57,40,13,14,3,  cnameu6,0,38,2,1	; sound rom (u6)
srom6	chipmac	6,7,72,40,13,14,3,  cnameu7,0,38,2,1	; sound rom (u7)
srom7	chipmac	7,7,87,40,13,14,3,  cnameu8,0,38,2,1	; sound rom (u8)
srom8	chipmac	8,7,102,40,13,14,3, cnameu9,0,38,2,1	; sound rom (u9)

dsp	chipmac	0,118,77,35,35,13,13,cnameu1,0,3,3,1	; sound dsp (u1)

sndram1	chipmac	1,115,29,40,13,9,3,cnameu86,0,38,2,1	; sound ram 1 (u86)
sndram2	chipmac	2,115,44,40,13,9,3,cnameu80,0,38,2,1	; sound ram 2 (u80)
sndram3	chipmac	3,115,59,40,13,9,3,cnameu73,0,38,2,1	; sound ram 3 (u73)
	.endif

	.long	0

cpu_chips_new:
	.if 0
ncram1	chipmac	0,125,25,20,45,7,11,cnamea8,1,2,2,1	; color ram
ncram2	chipmac	1,125,75,20,45,7,11,cnamec8,1,2,2,1	; color ram

nvram1	chipmac	2,190-39,25,15,38,6,2,cnamea11,1,2,2,1	; bank 1 video ram
nvram2	chipmac	3,207-39,25,15,38,6,2,cnamea12,1,2,2,1	;   (palette)
nvram3	chipmac	4,224-39,25,15,38,6,2,cnamea13,1,2,2,1
nvram4	chipmac	5,241-39,25,15,38,6,2,cnamea14,1,2,2,1

nvram5	chipmac	6,190-39,71,15,38,6,2,cnameb11,1,2,2,1	; bank 2 video ram
nvram6	chipmac	7,207-39,71,15,38,6,2,cnameb12,1,2,2,1	;   (pixel)
nvram7	chipmac	8,224-39,71,15,38,6,2,cnameb13,1,2,2,1
nvram8	chipmac	9,241-39,71,15,38,6,2,cnameb14,1,2,2,1

ncpu	chipmac	0,330-100,60,35,35,4,13,cnameb21,0,3,3,1	; cpu

ndma	chipmac	0,201,120,38,38,6,16,cnamee13,0,3,3,1	; dma

nprom1	chipmac	1,155-62,210,20,40,7,3,cnamej12,1,2,2,1	; program rom 1
nprom2	chipmac	0,155-62,167,20,40,7,3,cnameg12,1,2,2,1	; program rom 2

nirom1	chipmac	1,195-73,167,20-3,40,7,3,cnameg14,1,2,2,1	; image rom
nirom2	chipmac	2,217-76,167,20-3,40,7,3,cnameg16,1,2,2,1	; image rom
nirom3	chipmac	3,239-79,167,20-3,40,7,3,cnameg17,1,2,2,1	; image rom
nirom4	chipmac	4,261-82,167,20-3,40,7,3,cnameg18,1,2,2,1	; image rom

nirom5	chipmac	5,283-85,167,20-3,40,7,3,cnameg19,1,2,2,1	; image rom
nirom6	chipmac	6,305-88,167,20-3,40,7,3,cnameg20,1,2,2,1	; image rom
nirom7	chipmac	7,327-91,167,20-3,40,7,3,cnameg22,1,2,2,1	; image rom
nirom8	chipmac	8,349-94,167,20-3,40,7,3,cnameg23,1,2,2,1	; image rom

nirom9	chipmac	9,195-73,210,20-3,40,7,3,cnamej14,1,2,2,1	; image rom
nirom10	chipmac	10,217-76,210,20-3,40,7,3,cnamej16,1,2,2,1	; image rom
nirom11	chipmac	11,239-79,210,20-3,40,7,3,cnamej17,1,2,2,1	; image rom
nirom12	chipmac	12,261-82,210,20-3,40,7,3,cnamej18,1,2,2,1	; image rom

nirom13	chipmac	13,283-85,210,20-3,40,7,3,cnamej19,1,2,2,1	; image rom
nirom14	chipmac	14,305-88,210,20-3,40,7,3,cnamej20,1,2,2,1	; image rom
nirom15	chipmac	15,327-91,210,20-3,40,7,3,cnamej22,1,2,2,1	; image rom
nirom16	chipmac	16,349-94,210,20-3,40,7,3,cnamej23,1,2,2,1	; image rom

nsram1	chipmac	0,50-30,210,13,33,4,4,cnamej4,1,2,2,1	; scratch pad
nsram2	chipmac	1,67-30,210,13,33,4,4,cnamej5,1,2,2,1	; scratch pad
nsram3	chipmac	2,84-30,210,13,33,4,4,cnamej6,1,2,2,1	; scratch pad
nsram4	chipmac	3,101-30,210,13,33,4,4,cnamej7,1,2,2,1	; scratch pad

nirom17	chipmac	5,283+40-12,74,20-3,40,7,11,cnameu8,1,2,2,1	; image rom
nirom18	chipmac	6,305+40-15,74,20-3,40,7,7,cnameu11,1,2,2,1	; image rom
nirom19	chipmac	7,327+40-18,74,20-3,40,7,11,cnameu6,1,2,2,1	; image rom
nirom20	chipmac	8,349+40-21,74,20-3,40,7,7,cnameu13,1,2,2,1	; image rom

nirom21	chipmac	13,283+40-12,117,20-3,40,7,7,cnameu16,1,2,2,0	; image rom
nirom22	chipmac	14,305+40-15,117,20-3,40,7,7,cnameu19,1,2,2,0	; image rom
nirom23	chipmac	15,327+40-18,117,20-3,40,7,7,cnameu14,1,2,2,0	; image rom
nirom24	chipmac	16,349+40-21,117,20-3,40,7,7,cnameu21,1,2,2,0	; image rom

nirom25	chipmac	5,283+40-12,167,20-3,40,7,11,cnameu9,1,2,2,1	; image rom
nirom26	chipmac	6,305+40-15,167,20-3,40,7,7,cnameu10,1,2,2,1	; image rom
nirom27	chipmac	7,327+40-18,167,20-3,40,7,11,cnameu7,1,2,2,1	; image rom
nirom28	chipmac	8,349+40-21,167,20-3,40,7,7,cnameu12,1,2,2,1	; image rom

nirom29	chipmac	13,283+40-12,210,20-3,40,7,7,cnameu17,1,2,2,0	; image rom
nirom30	chipmac	14,305+40-15,210,20-3,40,7,7,cnameu18,1,2,2,0	; image rom
nirom31	chipmac	15,327+40-18,210,20-3,40,7,7,cnameu15,1,2,2,0	; image rom
nirom32	chipmac	16,349+40-21,210,20-3,40,7,7,cnameu20,1,2,2,0	; image rom
	.endif
;MJL END

	.long	0


vramtab	.long	cram1,cram2
	.long	vram1,vram2,vram3,vram4,vram5,vram6
	.long	vram7,vram8
	.long	0
;MJL
sromtab	.long	srom1, srom2, srom3, srom4
;	.long	srom5, srom6, srom7, srom8
	.long	0
sndramtab
	.long	sndram1, sndram2, sndram3
	.long	0
;MJL END

;these things are not used -mdp
;promtab	.long	prom1,prom2
;	.long	0
;iromtab	.long	irom1,irom2,irom3,irom4
;	.long	irom5,irom6,irom7,irom8
;	.long	irom9,irom10,irom11,irom12
;	.long	irom13,irom14,irom15,irom16
;	.long	0
;sramtab	.long	sram1,sram2,sram3,sram4
;	.long	0

;MJL
	.if 0
vramtabnew
	.long	ncram1,ncram2
	.long	nvram1,nvram2,nvram3,nvram4,nvram5,nvram6
	.long	nvram7,nvram8
	.long	0
	.endif
;MJL END
;these things are not used -mdp
;promtabnew
;	.long	nprom1,nprom2
;	.long	0
;iromtabnew
;	.long	nirom1,nirom2,nirom3,nirom4
;	.long	nirom5,nirom6,nirom7,nirom8
;	.long	nirom9,nirom10,nirom11,nirom12
;	.long	nirom13,nirom14,nirom15,nirom16
;	.long	0
;sramtabnew
;	.long	nsram1,nsram2,nsram3,nsram4
;	.long	0

	.if 0
cnamea8
	.STRING	"UA8",0
	.even
cnamea11	
	.STRING	"UA11",0
	.even
cnamea12	
	.STRING	"UA12",0
	.even
cnamea13	
	.STRING	"UA13",0
	.even
cnamea14	
	.STRING	"UA14",0
	.even

cnameb11
	.STRING	"UB11",0
	.even
cnameb12
	.STRING	"UB12",0
	.even
cnameb13
	.STRING	"UB13",0
	.even
cnameb14
	.STRING	"UB14",0
	.even
cnameb21
	.STRING	"UB21",0
	.even

cnamec8
	.STRING	"UC8",0
	.even

cnamee13
	.STRING	"UE13",0
	.even

cnameg12	
	.STRING	"UG12",0
	.even
cnameg14
	.STRING	"UG14",0
	.even
cnameg16	
	.STRING	"UG16",0
	.even
cnameg17
	.STRING	"UG17",0
	.even
cnameg18	
	.STRING	"UG18",0
	.even
cnameg19	
	.STRING	"UG19",0
	.even
cnameg20	
	.STRING	"UG20",0
	.even
cnameg22	
	.STRING	"UG22",0
	.even
cnameg23	
	.STRING	"UG23",0
	.even

cnamej4
	.STRING	"UJ4",0
	.even
cnamej5
	.STRING	"UJ5",0
	.even
cnamej6
	.STRING	"UJ6",0
	.even
cnamej7
	.STRING	"UJ7",0
	.even
cnamej12
	.STRING	"UJ12",0
	.even
cnamej14
       	.STRING	"UJ14",0
	.even
cnamej16
	.STRING	"UJ16",0
	.even
cnamej17
	.STRING	"UJ17",0
	.even
cnamej18
	.STRING	"UJ18",0
	.even
cnamej19
	.STRING	"UJ19",0
	.even
cnamej20
	.STRING	"UJ20",0
	.even
cnamej22
	.STRING	"UJ22",0
	.even
cnamej23
	.STRING	"UJ23",0
	.even

;new

cnameu8	.STRING	"U8",0
	.even
cnameu11	.STRING	"U11",0
	.even
cnameu6	.STRING	"U6",0
	.even
cnameu13	.STRING	"U13",0
	.even

cnameu16	.STRING	"U16",0
	.even
cnameu19	.STRING	"U19",0
	.even
cnameu14	.STRING	"U14",0
	.even
cnameu21	.STRING	"U21",0
	.even

cnameu9	.STRING	"U9",0
	.even
cnameu10	.STRING	"U10",0
	.even
cnameu7	.STRING	"U7",0
	.even
cnameu12	.STRING	"U12",0
	.even

cnameu17	.STRING	"U17",0
	.even
cnameu18	.STRING	"U18",0
	.even
cnameu15	.STRING	"U15",0
	.even
cnameu20	.STRING	"U20",0
	.even

	.else

cnameu1
	.string	"U1",0
	.even
cnameu2
	.string	"U2",0
	.even
cnameu3
	.string	"U3",0
	.even
cnameu4
	.string	"U4",0
	.even
cnameu5
	.string	"U5",0
	.even
cnameu6
	.string	"U6",0
	.even
cnameu7
	.string	"U7",0
	.even
cnameu8
	.string	"U8",0
	.even
cnameu9
	.string	"U9",0
	.even
cnameu10
	.string	"U10",0
	.even
cnameu11
	.string	"U11",0
	.even
cnameu12
	.string	"U12",0
	.even
cnameu13
	.string	"U13",0
	.even
cnameu14
	.string	"U14",0
	.even
cnameu15
	.string	"U15",0
	.even
cnameu16
	.string	"U16",0
	.even
cnameu17
	.string	"U17",0
	.even
cnameu33
	.string	"U33",0
	.even
cnameu36
	.string	"U36",0
	.even
cnameu37
	.string	"U37",0
	.even
cnameu49
	.string	"U49",0
	.even
cnameu54
	.string	"U54",0
	.even
cnameu59
	.string	"U59",0
	.even
cnameu63
	.string	"U63",0
	.even
cnameu64
	.string	"U64",0
	.even
cnameu73
	.string	"U73",0
	.even
cnameu80
	.string	"U80",0
	.even
cnameu86
	.string	"U86",0
	.even
cnameu133
	.string	"U133",0
	.even
cnameu132
	.string	"U132",0
	.even
cnameu131
	.string	"U131",0
	.even
cnameu130
	.string	"U130",0
	.even
cnameu129
	.string	"U129",0
	.even
cnameu128
	.string	"U128",0
	.even
cnameu127
	.string	"U127",0
	.even
cnameu126
	.string	"U126",0
	.even
cnameu125
	.string	"U125",0
	.even
cnameu124
	.string	"U124",0
	.even
cnameu123
	.string	"U123",0
	.even
cnameu122
	.string	"U122",0
	.even
cnameu121
	.string	"U121",0
	.even
cnameu120
	.string	"U120",0
	.even
cnameu119
	.string	"U119",0
	.even
cnameu118
	.string	"U118",0
	.even
cnameu117
	.string	"U117",0
	.even
cnameu116
	.string	"U116",0
	.even
cnameu115
	.string	"U115",0
	.even
cnameu114
	.string	"U114",0
	.even
cnameu113
	.string	"U113",0
	.even
cnameu112
	.string	"U112",0
	.even
cnameu111
	.string	"U111",0
	.even
cnameu110
	.string	"U110",0
	.even
cnameu109
	.string	"U109",0
	.even
cnameu108
	.string	"U108",0
	.even
cnameu107
	.string	"U107",0
	.even
cnameu106
	.string	"U106",0
	.even
cnameu105
	.string	"U105",0
	.even
cnameu104
	.string	"U104",0
	.even
cnameu103
	.string	"U103",0
	.even
cnameu102
	.string	"U102",0
	.even


sndrevprompt
	.string	"SOUND SYSTEM VERSION",0
	.even
sndprotoprompt
	.string	"PROTO ",0
	.even
sndreleaseprompt
	.string	"RELEASE ",0
	.even
sndtimeout
	.string	"TIMEOUT ON RESPONSE FROM SOUND SECTION",0
	.even
gamesnprompt
	.string	"GAME SERIAL NUMBER",0
	.even
piccmess
	.string	"CHECKING PIC CHIP",0
	.even
picbadmess
	.string	"PIC CHIP BAD",0
	.even
sndcmess
	.string	"CHECKING SOUND SECTION",0
	.even
sndbadmess
	.string	"SOUND SECTION BAD",0
	.even



	.endif

**************************************************************************
*											     *
* 	ram chip data									     *
* 											     *
* 	make sure these tables correspond with the stuff above	     *
* 											     *
*											     *
**************************************************************************
* taken from nba jams
vramchips:
;MJL
	.if 0
;	color rams

	ram_chip 0,0, 8, 16, 1800000h, 187fff0h		; ua8  (  0 - 3  )
	ram_chip 0,1, 8, 16, 1800008h, 187fff8h		; uc8  (  8 - 11 )

;	video rams
;	ram_chip $macro tab_link,chip_no, width, interleave, start_addr, end_addr 		

	ram_chip 0, 6, 8, 32, 0000018h, 03ffff8h	; ub11 ( 24 - 27 )
	ram_chip 0, 8, 8, 32, 0000010h, 03ffff0h	; ub13 ( 16 - 19 )
	ram_chip 0, 7, 8, 32, 0000008h, 03fffe8h	; ub12 (  8 - 11 )
	ram_chip 0, 9, 8, 32, 0000000h, 03fffe0h	; ub14 (  0 - 3  )

	.else

;	color rams

	ram_chip 0,1, 8, 16, 1880000h, 18ffff0h		; u37  (  0 - 7  )
	ram_chip 0,0, 7, 16, 1880008h, 18ffff8h		; u36  (  8 - 14 )

;	video rams
;	ram_chip $macro tab_link,chip_no, width, interleave, start_addr, end_addr 		

	ram_chip 0, 8, 8, 32, 0000018h, 03ffff8h	; u12
	ram_chip 0, 4, 8, 32, 0000010h, 03ffff0h	; u16
	ram_chip 0, 9, 8, 32, 0000008h, 03fffe8h	; u13
	ram_chip 0, 5, 8, 32, 0000000h, 03fffe0h	; u17
	.endif
;MJL END

	.long	0

* from nba jams
palchips:
;MJL
	.if 0
;	video palette rams
;	ram_chip $macro tab_link,chip_no, width, interleave, start_addr, end_addr 		

	ram_chip 0,2, 8, 32, 0000018h, 03ffff8h		; ua11 (  24 - 27 )
	ram_chip 0,4, 8, 32, 0000010h, 03ffff0h		; ua13 (  16 - 19  )
	ram_chip 0,3, 8, 32, 0000008h, 03fffe8h		; ua12 (  8 - 11 )
	ram_chip 0,5, 8, 32, 0000000h, 03fffe0h		; ua14 (  0 - 3  )

	.else
;	video palette rams
;	ram_chip $macro tab_link,chip_no, width, interleave, start_addr, end_addr 		

	ram_chip 0,6, 8, 32, 0000018h, 03ffff8h		; u10
	ram_chip 0,2, 8, 32, 0000010h, 03ffff0h		; u14
	ram_chip 0,7, 8, 32, 0000008h, 03fffe8h		; u11
	ram_chip 0,3, 8, 32, 0000000h, 03fffe0h		; u15

	.endif

	.long	0

;	scratch rams
sramcheck
	.STRING	"CHECKING SCRATCH RAMS",0
	.even

sramchips
;MJL
	.if 0
	ram_chip sram4,3, 4, 16, 1000004h, 13ffff4h	; uj7 (  4 - 7  )
	ram_chip sram3,2, 4, 16, 1000000h, 13ffff0h	; uj6 (  0 - 3  )
	ram_chip sram2,1, 4, 16, 1000008h, 13ffff8h	; uj5 (  8 - 11 )
	ram_chip sram1,0, 4, 16, 100000ch, 13ffffch	; uj4 ( 12 - 15 )

	.else

	ram_chip sram1,0, 16, 16, 1000000h, 13ffff0h	; u49 (0-15)

	.endif
;MJL END
	.long	0

;MJL
	.if 0
sramchipsnew
	ram_chip nsram4,3, 4, 16, 1000004h, 13ffff4h	; uj7 (  4 - 7  )
	ram_chip nsram3,2, 4, 16, 1000000h, 13ffff0h	; uj6 (  0 - 3  )
	ram_chip nsram2,1, 4, 16, 1000008h, 13ffff8h	; uj5 (  8 - 11 )
	ram_chip nsram1,0, 4, 16, 100000ch, 13ffffch	; uj4 ( 12 - 15 )
	.long	0
	.endif
;MJL END

	.even

**************************************************************************
*											     *
*  rom chip definitions and checksums							     *
*											     *
**************************************************************************
cksum1	.equ	0CCFBH
cksum2	.equ	0015EH

;cksum1	.equ	0
;cksum2	.equ	0

**************************************************************************
*											     *
*  Hey Ed! - Use this without the daughter board				     *
*											     *
**************************************************************************
promchips
;MJL
	.if 0
	rom_chip prom1,0,0,16, 0ff800000h, 0fffffff0h, cksum1,0	; uj12
	rom_chip prom2,1,0,16, 0ff800008h, 0fffffff8h, cksum2,0	; ug12

	.else

	rom_chip prom2,1,0,16, 0ff800000h, 0fffffff0h, cksum1,0	; u54
	rom_chip prom1,0,0,16, 0ff800008h, 0fffffff8h, cksum2,0	; u63

	.endif
;MJL END
	.long	0

;MJL
	.if 0
promchipsnew
	rom_chip nprom1,0,0,16, 0ff800000h, 0fffffff0h, cksum1,0	; uj12
	rom_chip nprom2,1,0,16, 0ff800008h, 0fffffff8h, cksum2,0	; ug12
	.long	0
	.endif
;MJL END

	.even

* checksum patches
	.word	0ffffH-cksum1	;1's complement of the uj12 checksum
	.word	0ffffH-cksum2	;1's complement of the ug12 checksum

;	.word	0ffffH-cksum1	;1's complement of the uj12 checksum
;	.word	0ffffH-cksum2	;1's complement of the ug12 checksum

**************************************************************************
*											     *
* 		     image rom checksum tables					     *
* 											     *
* 		note: comment out any unstuffed parts that		     *
* 			exist before the .long 0 terminator!		     *
*											     *
**************************************************************************
;rom_chip $macro tab_link,chip_no, width, interleave, start_addr, end_addr, check_sum,map

iromchips
	.even
;MJL
	.if 0
	rom_chip irom1,  1, 8,32,  2000000h, 3ffffe0h,03877H,0	; ug14 (1)
	rom_chip irom9,  9, 8,32,  2000008h, 3ffffe8h,07528H,0	; uj14 (2)
	rom_chip irom5,  5, 8,32,  2000010h, 3fffff0h,00D21H,0	; ug19 (3)
	rom_chip irom13,13, 8,32,  2000018h, 3fffff8h,059B5H,0	; uj19 (4)
	rom_chip irom2,  2, 8,32,  4000000h, 5ffffe0h,0909FH,0	; ug16 (5)
	rom_chip irom10,10, 8,32,  4000008h, 5ffffe8h,0610EH,0	; uj16 (6)
	rom_chip irom6,  6, 8,32,  4000010h, 5fffff0h,07AA4H,0	; ug20 (7)
	rom_chip irom14,14, 8,32,  4000018h, 5fffff8h,0E956H,0	; uj20 (8)
	rom_chip irom3,  3, 8,32,  2000000h, 3ffffe0h,0EA55H,1	; ug17 (9)
	rom_chip irom11,11, 8,32,  2000008h, 3ffffe8h,0F6CCH,1	; uj17 (10)
	rom_chip irom7,  7, 8,32,  2000010h, 3fffff0h,07BD4H,1	; ug22 (11)
	rom_chip irom15,15, 8,32,  2000018h, 3fffff8h,09F6CH,1	; uj22 (12)

;	rom_chip irom4,  4, 8,32,  3000000h, 3ffffe0h, 0ffffh,1	; ug18 (13)
;	rom_chip irom12,12, 8,32,  3000008h, 3ffffe8h, 0ffffh,1	; uj18 (14)
;	rom_chip irom8,  8, 8,32,  3000010h, 3fffff0h, 0ffffh,1	; ug23 (15)
;	rom_chip irom16,16, 8,32,  3000018h, 3fffff8h, 0ffffh,1	; uj23 (16)

	.else

; 2-3 mil
	rom_chip irom1,  0, 8,32,  2000000h, 3ffffe0h,0991Ah,0 	; u133
	rom_chip irom2,  1, 8,32,  2000008h, 3ffffe8h,09FA5h,0 	; u132
	rom_chip irom3,  2, 8,32,  2000010h, 3fffff0h,0056Fh,0 	; u131
	rom_chip irom4,  3, 8,32,  2000018h, 3fffff8h,0775Dh,0 	; u130

; 4-5 mil
	rom_chip irom5,  4, 8,32,  4000000h, 5ffffe0h,0de07h,0 	; u129
	rom_chip irom6,  5, 8,32,  4000008h, 5ffffe8h,0eee2h,0 	; u128
	rom_chip irom7,  6, 8,32,  4000010h, 5fffff0h,0d3c6h,0 	; u127
	rom_chip irom8,  7, 8,32,  4000018h, 5fffff8h,00f4dh,0 	; u126

; 6-7 mil
	rom_chip irom9,  8, 8,32,  2000000h, 3ffffe0h,0985dh,1 	; u125
	rom_chip irom10, 9, 8,32,  2000008h, 3ffffe8h,0f576h,1 	; u124
	rom_chip irom11,10, 8,32,  2000010h, 3fffff0h,07c81h,1 	; u123
	rom_chip irom12,11, 8,32,  2000018h, 3fffff8h,059feh,1 	; u122

; 8-9 mil
	rom_chip irom13,12, 8,32,  4000000h, 5ffffe0h,00435h,1 	; u121
	rom_chip irom14,13, 8,32,  4000008h, 5ffffe8h,0e667h,1 	; u120
	rom_chip irom15,14, 8,32,  4000010h, 5fffff0h,00493h,1 	; u119
	rom_chip irom16,15, 8,32,  4000018h, 5fffff8h,0b037h,1 	; u118

; a mil
	rom_chip irom17,16, 8,32,  2000000h, 2ffffe0h,0a83eH,2 	; u117
	rom_chip irom18,17, 8,32,  2000008h, 2ffffe8h,07b1eH,2 	; u116
	rom_chip irom19,18, 8,32,  2000010h, 2fffff0h,094a7H,2 	; u115
	rom_chip irom20,19, 8,32,  2000018h, 2fffff8h,07f0bH,2 	; u114


;MJL 03	- Ed put the checksums from u133 - u122 in this table
;for GURNEE special TEST VERSION (Paul's request)
	rom_chip irom21,20, 8,32,  4000000h, 5ffffe0h,0h,2 	; u113
	rom_chip irom22,21, 8,32,  4000008h, 5ffffe8h,0h,2 	; u112
	rom_chip irom23,22, 8,32,  4000010h, 5fffff0h,0h,2 	; u111
	rom_chip irom24,23, 8,32,  4000018h, 5fffff8h,0h,2 	; u110
	rom_chip irom25,24, 8,32,  2000000h, 3ffffe0h,0h,3 	; u109
	rom_chip irom26,25, 8,32,  2000008h, 3ffffe8h,0h,3	; u108
	rom_chip irom27,26, 8,32,  2000010h, 3fffff0h,0h,3	; u107
	rom_chip irom28,27, 8,32,  2000018h, 3fffff8h,0h,3	; u106
	rom_chip irom29,28, 8,32,  4000000h, 5ffffe0h,0h,3	; u105
	rom_chip irom30,29, 8,32,  4000008h, 5ffffe8h,0h,3	; u104
	rom_chip irom31,30, 8,32,  4000010h, 5fffff0h,0h,3	; u103
	rom_chip irom32,31, 8,32,  4000018h, 5fffff8h,0h,3	; u102
;MJL 03 END
	
	.endif
;MJL END

	.long	0		; force it to stop here

;MJL
	.if 0
iromchipsnew
	rom_chip nirom1,  1, 8,32,  2000000h, 2ffffe0h, 01c5ch,0 ; ug14 (1)
	rom_chip nirom9,  9, 8,32,  2000008h, 2ffffe8h, 0d2dch,0 ; uj14 (2)
	rom_chip nirom19,19, 8,32,  2000010h, 2fffff0h, 05419h,0 ; u6  (flying board)
	rom_chip nirom27,27, 8,32,  2000018h, 2fffff8h, 02f12h,0 ; u7 (flying board)

	rom_chip nirom2,  2, 8,32,  3000000h, 3ffffe0h, 01c1bh,0 ; ug16 (5)
	rom_chip nirom10,10, 8,32,  3000008h, 3ffffe8h, 0a24ch,0 ; uj16 (6)
	rom_chip nirom20,20, 8,32,  3000010h, 3fffff0h, 0b908h,0 ; u13 (flying board)
	rom_chip nirom28,28, 8,32,  3000018h, 3fffff8h, 02aa3h,0 ; u12 (flying board)

	rom_chip nirom17,17, 8,32,  4000000h, 4ffffe0h, 0ef43h,0 ; u8 (flying board)
	rom_chip nirom25,25, 8,32,  4000008h, 4ffffe8h, 0f31bh,0 ; u9 (flying board)
	rom_chip nirom5,  5, 8,32,  4000010h, 4fffff0h, 060b6h,0 ; ug19 (3)
	rom_chip nirom13,13, 8,32,  4000018h, 4fffff8h, 00f47h,0 ; uj19 (4)

	rom_chip nirom18,17, 8,32,  5000000h, 5ffffe0h, 0a15ch,0 ; u11 (flying board)
	rom_chip nirom26,25, 8,32,  5000008h, 5ffffe8h, 06df3h,0 ; u12 (flying board)
	rom_chip nirom6,  6, 8,32,  5000010h, 5fffff0h, 019eeh,0 ; ug20 (7)
	rom_chip nirom14,14, 8,32,  5000018h, 5fffff8h, 0da0fh,0 ; uj20 (8)

	rom_chip nirom3,  3, 8,32,  2000000h, 2ffffe0h, 076f0h,1 ; ug17 (9)
	rom_chip nirom11,11, 8,32,  2000008h, 2ffffe8h, 013d4h,1 ; uj17 (10)
	rom_chip nirom7,  7, 8,32,  2000010h, 2fffff0h, 08c03h,1 ; ug22 (11)
	rom_chip nirom15,15, 8,32,  2000018h, 2fffff8h, 0c5a5h,1 ; uj22 (12)

	rom_chip nirom4,  4, 8,32,  3000000h, 3ffffe0h, 07365h,1 ; ug18 (13)
	rom_chip nirom12,12, 8,32,  3000008h, 3ffffe8h, 0e2f8h,1 ; uj18 (14)
	rom_chip nirom8,  8, 8,32,  3000010h, 3fffff0h, 0efd1h,1 ; ug23 (15)
	rom_chip nirom16,16, 8,32,  3000018h, 3fffff8h, 0d9c7h,1 ; uj23 (16)
	.long	0		; force it to stop here
	.endif
;MJL END



	.end
