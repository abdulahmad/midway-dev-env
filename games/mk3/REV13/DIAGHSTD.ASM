	.file	"diaghstd.asm"
	.title	"<<< high score to date maintanence >>>"
	.width	132
	.option	b,d,l,t
	.mnolist

**************************************************************************
*												*
*	copyright (c) 1990 williams electronics games, inc.			*
*	all rights reserved.									*
*												*
**************************************************************************

	.include	"dispequ.asm"		;display processor equates
	.include	"sysequ.asm"		;system equates
	.include	"mainequ.asm"		;game equates
	.include	"imgtbl.glo"
	.include	"bgndtbl.glo"
	.include	"stringh.asm"
	.include	 macros.hdr	; macros

	.include	"diagsequ.asm"
	.include	"diagmequ.asm"		;menu equates
	.include	"diagaudn.asm"		;auditing offsets

*
*	in this module
*
	.global		get_hscr
	.global		rc_bytei
	.global		rc_byte
	.global		rc_word
	.global		rc_wordi
	.global		rc_long
	.global		rc_longi
	.global		wc_byte
	.global		wc_bytei
	.global		wc_word
	.global		wc_wordi
	.global		wc_long
	.global		wc_longi
	.global		pt_entry
;	.global		init_tb
;	.global		init_tab	;georges power up entry
	.global		p_fork
;	.global		val_tab
	.global		rom_ptrs
	.global		e_game
	.global		set_page
	.global		a2_check
	.global		get_hsc
*

;	.def	check_inits
;	.def	init_tb, all_tab, tod_tab
;	.def	get_hsc					; init_hsr
	.def	on_hstd
	.def	char_plot
	.def	char_score,duxpal

	.ref	get_cstr
	.ref	def_page

	.bss	char_plot,64
	.bss	char_score,32
	.bss	char_num,16
	.bss	color_seq,16
	.bss	master_seq,16
	.bss	plot_color,32
	.bss	holdinits,rhs_size*4
	.bss	on_hstd,16
	.bss	temp_pal,32
	.text
	.even

duxpal:
	.word	 10
	.word	00H,07c00H,06739H,01fH,035adH,077a0H,0741aH,03a0H
	.word	00H,010H


set_page
	rets


* the rest of this OLD NARC hstd stuff is in DIAGHSTD.HLD


**************************************************************************
*												*
*	  cmos utilities									*
*												*
**************************************************************************

**************************************************************************
*												*
*	  for all of these cmos routines. 						*
*												*
*		  a7 = pointer to memory							*
*		  a0 = data to/from memory						*
*												*
**************************************************************************
*
*	****  important note on word and long word packing  ****
*	****  important note on word and long word packing  ****
*	****  important note on word and long word packing  ****
*	****  important note on word and long word packing  ****
*	****  important note on word and long word packing  ****
*
*	note that requests for words return the 2 bytes packed
*	into a word as <1st byte><2nd byte>.	this is not
*	the same way that the gsp handles a word pointed at
*	with a pointer.
*
*	long words work similarly:
*
*	   msb								   lsb
*	       <1st byte> <2nd byte> <3rd byte> <4th byte>
*
*	tough luck intel hackers!
*
*	rc_byte
*	wc_byte
*
*	these 2 routines are the only routines that ever touch
*	cmos ram.  this is done to localize the effect of
*	changes in the architecture.  all efforts to deal with
*	cmos should come through these routines.  locking
*	hardware will be easily added in the future (as well
*	as different memory mapping).
*
rc_byte
	movb	*a7,a0
	andi	byte_mask,a0
	rets

wc_byte
        .if tunit
	movb	a0,@wp_unlock	;unlock cmos for a one shot write
        .endif

	movb	a0,*a7		;write out the byte
	rets			;and return

**************************************************************************
*												*
*	  rc_bytei										*
*												*
*	  read byte pointed to by a7...increment pointer to			*
*	  "next" byte.										*
*												*
**************************************************************************
rc_bytei
	callr	rc_byte
	addi	c_byte_size,a7	  ;words separate cmos bytes.
	move	a0,a0		  ;return flags accordingly
	rets

rc_word
	mmtm	sp,a1,a7		 ;use a1 to combine bytes
	callr	rc_bytei    	 	 ;get a byte
	move	a0,a1			 ;save in a1
	andi	byte_mask,a1		 ;mask only byte
	sll	8,a1			 ;shift to high byte
	callr	rc_byte         	 ;get the 2nd byte
	andi	byte_mask,a0
	or	a1,a0			 ;a0 has the word
	mmfm	sp,a1,a7		
	rets

rc_wordi
	callr	rc_word
	addi	c_word_size,a7	  ;long separate cmos words.
	move	a0,a0		  ;return flags accordingly
	rets

rc_long
	mmtm	sp,a1,a7		 ;use a1 to combine bytes
	callr	rc_wordi    ;get a word
	move	a0,a1			 ;save in a1
	andi	word_mask,a1		 ;mask only word
	sll	16,a1			 ;shift to high word
	callr	rc_word        ;get the 2nd word
	andi	word_mask,a0
	or	a1,a0			 ;a0 has the long word
	mmfm	sp,a1,a7		
	rets

rc_longi
	callr	rc_long
	addi	c_long_size,a7	  ;double the distance for brain damij
	move	a0,a0		  ;return flags accordingly
	rets

wc_bytei
	callr	wc_byte
	addi	c_byte_size,a7
	rets

wc_word
	mmtm	sp,a0,a1,a7
	move	a0,a1		;make copy of word
	srl	8,a0		;get high byte in a0
	callr	wc_bytei  ;write the high byte
	move	a1,a0		;now get the low byte back
	callr	wc_byte ;write it
	mmfm	sp,a0,a1,a7	;and restore all we touched
	rets

wc_wordi
	callr	wc_word
	addi	c_word_size,a7
	rets

wc_long
	mmtm	sp,a0,a1,a7
	move	a0,a1		;make copy of long
	srl	16,a0		;get high word in a0
	callr	wc_wordi  ;write the high word
	move	a1,a0		;now get the low word back
	callr	wc_word ;write it
	mmfm	sp,a0,a1,a7	;and restore all we touched
	rets

wc_longi
	callr	wc_long
	addi	c_long_size,a7
	rets












