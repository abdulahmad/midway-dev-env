**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: screen fade routines									*
* 											     *
*  copyright (c) 1994-95 Midway Manufacturing	   					*
*											     *
**************************************************************************
	.file	"mkfade.asm"
	.width	132
	.option	b,d,l,t
	.mnolist
*
* get the system stuff
*
	.include	dispequ.asm
	.include	sysequ.asm
	.include	macros.hdr
	.include	mainequ.asm
	.include	imgtbl.glo
	.text

**************************************************************************
*											     *
*  fadein_jsrp - Starts procs to fadein all palettes				     *
* 											     *
*  Input: a10 = sleep time after procs are started				     *
*											     *
**************************************************************************

fast_fadeout_jsrp
	movi	0400H,a9
	create	pid_fade,skydown
	calla	fade_all_fast
	move	a10,a0
	jruc	fade_sleep_a0


fadeout_jsrp
	calla	fade_all_sky
	move	a10,a0
	jruc	fade_sleep_a0



fast_fadein_jsrp
	push	a10
	movi	all_palettes,a0
	calla	fadeblak
	movi	0400H,a9			; sky fadein speed
	move	@irqskye,a10,w
	create	pid_fade,skyup		; fade in the sky also !!
	calla	fade_in_fast
	calla	display_on
	pull	a0
	jruc	fade_sleep_a0

;************************************

fadein_white_jsrp
	movi	sans_boonpal,a0
	calla	fadewhite		; fade all palette black (instantly)
	calla	display_on
	movi	all_palettes,a0
	calla	fadein_white		; fade in

	create	pid_fade,white_2_blax

	sleep	3
	jruc	l_retp


white_2_blax
	movi	31,a10			; full r g b !!

w2b3	move	a10,a1			; add blue
	move	a1,a0	
	sll	5,a1
	or	a1,a0			; add green
	sll	5,a1
	or	a1,a0			; add red...
	move	a0,@irqskye,w
	sleep	1
	subk	2,a10
	jrge	w2b3

	clr	a0
	move	a0,@irqskye,w		; end wid blak
	die


fadein_white
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	fadein_white_tab,a11
	jruc	fader

wtop	.set	700
dtop	.set	8

fadein_white_tab
	.word	wtop-(dtop*1)
	.word	wtop-(dtop*2)
	.word	wtop-(dtop*3)
	.word	wtop-(dtop*4)
	.word	wtop-(dtop*5)
	.word	wtop-(dtop*6)
	.word	wtop-(dtop*7)
	.word	wtop-(dtop*8)
	.word	wtop-(dtop*9)
	.word	wtop-(dtop*10)
	.word	wtop-(dtop*11)
	.word	wtop-(dtop*12)
	.word	wtop-(dtop*13)
	.word	wtop-(dtop*14)
	.word	wtop-(dtop*15)
	.word	wtop-(dtop*16)
	.word	wtop-(dtop*17)
	.word	wtop-(dtop*18)
	.word	wtop-(dtop*19)
	.word	wtop-(dtop*20)

	.word	wtop-(dtop*21)
	.word	wtop-(dtop*22)
	.word	wtop-(dtop*23)
	.word	wtop-(dtop*24)
	.word	wtop-(dtop*25)
	.word	wtop-(dtop*26)
	.word	wtop-(dtop*27)
	.word	wtop-(dtop*28)
	.word	wtop-(dtop*29)
	.word	wtop-(dtop*30)

	.word	wtop-(dtop*31)
	.word	wtop-(dtop*32)
	.word	wtop-(dtop*33)
	.word	wtop-(dtop*34)
	.word	wtop-(dtop*35)
	.word	wtop-(dtop*36)
	.word	wtop-(dtop*37)
	.word	wtop-(dtop*38)
	.word	wtop-(dtop*39)
	.word	wtop-(dtop*40)

	.word	wtop-(dtop*41)
	.word	wtop-(dtop*42)
	.word	wtop-(dtop*43)
	.word	wtop-(dtop*44)
	.word	wtop-(dtop*45)
	.word	wtop-(dtop*46)
	.word	wtop-(dtop*47)
	.word	wtop-(dtop*48)
	.word	wtop-(dtop*49)
	.word	wtop-(dtop*50)

	.word	128			; end up normal colors
	.word	-1

fadewhite
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	clr	a14
	movi	fadewhite_tab,a11
	jruc	fader

fadewhite_tab
	.word	wtop,0ffffH

;************************************


fadein_jsrp
	push	a10
	movi	all_palettes,a0
	calla	fadeblak		; fade all palette black (instantly)
	calla	display_on
	movi	all_palettes,a0
	calla	fadein			; fade in
	movi	0800H,a9			; sky fadein speed
	move	@irqskye,a10,w
	create	pid_fade,skyup		; fade in the sky also !!
	pull	a0
	jruc	fade_sleep_a0

fade_sleep_a0
	move	a0,a0
	jreq	l_retp
	calla	prcslp
	jruc	l_retp


*
*  a0 = palette offset (double BS)
*  a5 = sleep time between fades
* a10 = red/green/blue flags
* a11 = fade table...
*
fade_this_pal
	move	a0,a6
	create	pid_fadepal,single_pal_fader
	move	a6,*a0(pa9),l
	move	a5,*a0(pa8),w
	move	a10,*a0(pa10),w
	rets


single_pal_fader

spf3	move	a9,a0
	srl	8,a0
	move	a0,a9
	sll	8,a9
	sll	6,a0
	addi	palram,a0
	move	*a0,a1,l     	; a1 = source

	move	a13,a0
	addi	pdata,a0	; a0 - dest ram for pal

	callr	newfade
	move	a9,a1		; b8-15 dest pal | b0-7 start color
	move	a13,a0
	addi	pdata,a0	; src for xfer
	move	*a0+,a2,w	; get # colors in palette
	calla	palset		; setup palette transfer

	move	a8,a0
	calla	prcslp
	move	*a11,a0,w
	jrnn	spf3
	die


*
* a0 destination ram for palette
* a1 source for palette
* a2 color multiplier
*
newfade
	mmtm	sp,a8,a9,a10,a11,a13
	move	*a11,a11,w
	move	a10,a13	    		; a13 = rgb flags
	move	a4,a9
	move	a6,a10
	move	*a1+,a14,w
	move	a14,*a0+,w

newf3	move	*a1+,a3,w   		; a3 - red
	move	a3,a5	    		; a5 - green
	move	a3,a7	    		; a7 - blue

	sll	16+1,a3
	srl	32-5,a3			; a3 = red
	sll	16+1+5,a5
	srl	32-5,a5			; a5 = green
	sll	16+1+5+5,a7
	srl	32-5,a7			; a7 = blue

	add	a11,a3
	cmpi	31,a3
	jrls	rok
   	movi	31,a3
rok	sub	a11,a5
	jrnn	gok
	clr	a5
gok	sub	a11,a7
	jrnn	bok
	clr	a7
bok	sll	10,a3
	sll	5,a5
	or	a5,a3
	or	a7,a3
	move	a3,*a0+,w
	dsjs	a14,newf3

	mmfm	sp,a8,a9,a10,a11,a13
	addk	16,a11
	rets

**************************************************************************

fade_all_sky
	movi	0800H,a9
	create	pid_fade,skydown

fade_all
	movi	all_palettes,a0
	jauc	fadeout


raiden_dimmer
	movi	death_fade_excludes,a0
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	raiden_fade_tab,a11
	jruc	fader

raiden_undimmer
	movi	death_fade_excludes,a0
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	raiden_unfade_tab,a11
	jruc	fader

**************************************************************************
*											     *
* 	fadeblak									     *
* 											     *
* 	fade a list of palettes to black, within one tick		     *
* 											     *
* 	input: a0 ptr to null terminated list **not** to fade		     *
*											     *
**************************************************************************
fadeblak
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	clr	a14
	movi	fadeblak_tab,a11
	jruc	fader

**************************************************************************
*											     *
* 	fadeall										     *
* 											     *
* 	fade everything using a given fade entry				     *
* 											     *
* 	entry										     *
* 		a0	list of palettes						     *
* 		a11	fade mult table						     *
* 											     *
* 	exit										     *
* 		nothing									     *
* 											     *
* 	call										     *
* 		call									     *
*											     *
**************************************************************************
fadeall:
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	jruc	fader


*slow version of fadein
*a0 = ptr to table of palettes not to fade
fadeins
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	clr	a14
	movi	fadeins_tab,a11
	jruc	fader


*slow version of fadeout
*a0 = ptr to table of palettes not to fade
;fadeouts:
;	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
;	clr	a14
;	movi	fadeouts,a11
;	jruc	fader

**************************************************************************
*											     *
* 	fadein										     *
* 											     *
* 	fade a list of palettes from black to their current colors	     *
* 											     *
* 	entry	a0 = ptr to null terminated list **not** to fade	     *
* 	exit	nothing									     *
*											     *
**************************************************************************
fadein
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	fadein_tab,a11
	jruc	fader

**************************************************************************
*											     *
* 	fadeout										     *
* 											     *
* 	fade a list of palettes down to black					     *
* 											     *
* 	entry										     *
* 		a0	ptr to null terminated list **not** to fade     *
* 											     *
* 	exit										     *
* 		nothing									     *
*											     *
**************************************************************************
join_in_fade1
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	join_in_tab1,a11
	jruc	fader

join_in_fade2
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	join_in_tab2,a11
	jruc	fader

fade_in_fast
	movi	all_palettes,a0
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	fast_fadein_tab,a11
	jruc	fader

fade_all_fast
	movi	all_palettes,a0
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	fast_fade_tab,a11
	jruc	fader

fadein_all_fast
	movi	all_palettes,a0
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	fast_fadein_tab,a11
	jruc	fader

;death_fadeout_1
;	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
;	movi	death_fadeout_tab1,a11
;	jruc	fader
;
;death_fadeout_2
;	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
;	movi	death_fadeout_tab2,a11
;	jruc	fader

fadeout_mercy
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	fadeout_mercy_tab,a11
	jruc	fader

fadeout:
	mmtm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	movi	fadeout_tab,a11

fader:
	move	a0,a6		

;* walk eugenes palette table, start proc to fade each palette *
	clr	a9		;palette slot
	dec	a9
	movi	palram-palrsiz,a2	;base of eugenes palette table
pallp:
	addi	palrsiz,a2
	inc	a9
	cmpi	numpal,a9
	jrge	pallpx

	move	*a2(palcnt),a1,w	;is palette allocated?
	jrz	pallp
	move	*a2(palid),a8,l		;ptr to palette
;*** skip fading pals in list pointed to by a6
	move	a6,a7
	jrz	skfpalx
skpallp:
	move	*a7+,a1,l
	jrz	skfpalx

	cmp	a1,a8
	jreq	pallp
	jruc	skpallp
skfpalx:
	create	pid_fade,fadeproc
	jruc	pallp
pallpx:

	mmfm	sp,a0,a1,a2,a6,a7,a8,a9,a11
	rets

**************************************************************************
*											     *
*  fade_irqskye - process to fade down the irqskye value along with	     *
*                 other fades.								     *
* 											     *
*  input: a11 - fade multiply table							     *
*											     *
**************************************************************************
;fade_irqskye
;	move	@irqskye,a0,w		; save original value in a10
;	move	a0,*a13(pdata),w
;
;fadesk6	move	*a11+,a2,w
;	jrn	fadesk9
;
;	push	a11
;	movi	07c00H,a4	;a4 - pre mult mask for 5 bits of red
;	movi	003e0H,a6	;a6 - pre mult mask for 5 bits of green
;	movi	0001fH,a8	;a8 - pre mult mask for 5 bits of blue
;	move	a4,a9
;	move	a6,a10
;	move	a8,a11
;	sll	7,a9		; a9 - post mult max for 5 bits of red
;	sll	7,a10		;a10 - post mult max for 5 bits of green
;	sll	7,a11		;a11 - post mult max for 5 bits of blue
;
;	move	*a13(pdata),a3,w  ; r
;	move	*a13(pdata),a5,w  ; g
;	move	*a13(pdata),a7,w  ; b
;
;	and	a4,a3
;	and	a6,a5
;	and	a8,a7
;	mpyu	a2,a3
;	mpyu	a2,a5
;	mpyu	a2,a7
;	cmp	a9,a3
;	jrle	redok2
;	move	a9,a3
;redok2
;	cmp	a10,a5
;	jrle	greenok2
;	move	a10,a5
;greenok2
;	cmp	a11,a7
;	jrle	blueok2
;	move	a11,a7
;blueok2
;	and	a9,a3
;	and	a10,a5
;	or	a5,a3
;	or	a7,a3
;	srl	7,a3
;	move	a3,@irqskye,w
;	pull	a11
;
;	sloop	1,fadesk6
;
;fadesk9	sleep	1
;	die

**************************************************************************
*											     *
* 	fadeproc									     *
* 											     *
* 	process to actually fade a palette					     *
* 											     *
* 	entry										     *
* 		a8	ptr to palette to be faded				     *
* 		a9	palette slot of palette				     *
* 		a11	fade multiplier table					     *
* 											     *
* 	exit										     *
* 		nothing									     *
*											     *
**************************************************************************
fadeproc:
	sll	24,a9		;b8-15 dest pal | b0-7 start color	
	srl	16,a9

;*****************
;	cmpi	boonpal,a8
;	jrne	dddd
;	move	a8,a8
;dddd
;*****************


fadeplp:
	;**** set up faded pal in process data space ****
	move	*a11+,a2,w	;a2 - color multiplier
	jrn	fadeprcx

	move	a13,a0
	addi	pdata,a0	;a0 - dest ram for pal
	move	a8,a1		;a1 - src for pal
	callr	fadepal

	;**** get faded palette xferred to palram ****
	move	a9,a1		;b8-15 dest pal | b0-7 start color
	move	a13,a0
	addi	pdata,a0	;src for xfer
	move	*a0+,a2,w	;get # colors in palette
	calla	palset		;setup palette transfer

	sleep	1
	jruc	fadeplp

fadeprcx:
	sleep	1		;give last xfer a chance to go
	die

**************************************************************************
*											     *
* 	fadepal										     *
* 											     *
* 	apply the color multiplier and do one iteration on the palette  *
* 											     *
* 	entry										     *
* 		a0	destination ram for palette				     *
* 		a1	source for palette					     *
* 		a2	color multiplier						     *
* 											     *
* 	exit										     *
* 		nothing									     *
* 											     *
* 	note:	each color in palette will be multiplied by a2 then     *
* 		divided by 128								     *
*											     *
**************************************************************************
fadepal:
	mmtm	sp,a8,a9,a10,a11

	move	*a1+,a14,w
	move	a14,*a0+,w
	sll	23,a14		;top bits of field are flags
	srl	23,a14		;	only 9 bits needed for # colors

	movi	07c00H,a4	;a4 - pre mult mask for 5 bits of red
	movi	003e0H,a6	;a6 - pre mult mask for 5 bits of green
	movi	0001fH,a8	;a8 - pre mult mask for 5 bits of blue

	move	a4,a9
	move	a6,a10
	move	a8,a11
	sll	7,a9		; a9 - post mult max for 5 bits of red
	sll	7,a10		;a10 - post mult max for 5 bits of green
	sll	7,a11		;a11 - post mult max for 5 bits of blue

fadelp:
	move	*a1+,a3,w	;a3 - red
	move	a3,a5		;a5 - green
	move	a3,a7		;a7 - blue
	and	a4,a3
	and	a6,a5
	and	a8,a7
	mpyu	a2,a3
	mpyu	a2,a5
	mpyu	a2,a7
	cmp	a9,a3
	jrle	redok
	move	a9,a3
redok:
	cmp	a10,a5
	jrle	greenok
	move	a10,a5
greenok:
	cmp	a11,a7
	jrle	blueok
	move	a11,a7
blueok:
	and	a9,a3
	and	a10,a5
;	and	a11,a7	;unnecessary cause bottom bits will get >> 7

	or	a5,a3
	or	a7,a3
	srl	7,a3
	move	a3,*a0+,w
	dsjs	a14,fadelp
	
	mmfm	sp,a8,a9,a10,a11
	rets


fadeout_mercy_tab
	.word	120,112,104,96,88,80,72,64	;,56,48,40,32,24,16,8,0
;	.word						;0,0,8,16,24,32,40,48,56

	.word	64,64,64,64,64,64,64,64,64,64
	.word	64,64,64,64,64,64,64,64,64,64
	.word	64,64,64,64,64,64,64,64,64,64
	.word	64,64,64,64,64,64,64,64,64,64
	.word	64,72,80,88,96,104,112,120,128,0ffffH

fadein_tab
	.word	0,0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128,0ffffH
fadeout_tab
	.word	120,112,104,96,88,80,72,64,56,48,40,32,24,16,8,0,0ffffH
fadeins_tab
	.word	0,0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60,64,68,72,76
	.word	80,84,88,92,96,100,104,108,112,116,120,124,128,0ffffH
fadeblak_tab
	.word	0,0ffffH

fast_fade_tab
	.word	120,104,88,72,56,40,24,8,0,0ffffH
;	.word	120,104,88,72,56,40,24,8,0,0ffffH

fast_fadein_tab
	.word	0,8,24,40,56,72,88,104,128,-1

raiden_fade_tab
	.word	48,-1

raiden_unfade_tab
	.word	128,-1


join_in_tab1
	.word	56,-1

join_in_tab2
	.word	48,40,32,24,16,8,0,-1

**************************************************************************
*											     *
* skydown - fade down the sky color and die					     *
* a9 = fader speed									     *
*											     *
**************************************************************************
skydown
	movi	10000h,a8
	move	@irqskye,a10,w		; a10 = starting color o sky

skydown1

;	move	@irqskye,a0,w
	move	a10,a0			; start out with the original

	move	a8,a1
	calla	xcolor
	move	a0,@irqskye,w
	sleep	1
	sub	a9,a8
	jrgt	skydown1
	clr	a1
	jruc	skydie

**************************************************************************
*											     *
*  skyup - fade up the sky color and die						     *
* 											     *
*   a9 = fader speed									     *
*  a10 = final color we wanna end up with						     *
*											     *
**************************************************************************
skyup
	clr	a8
skyup1

;	move	@skycolor,a0,w
	move	a10,a0

	move	a8,a1
	calla	xcolor
	move	a0,@irqskye,w
	sleep	1
	add	a9,a8
	cmpi	10000h,a8
	jrle	skyup1

	movi	10000h,a1
skydie
	move	@irqskye,a0,w
	calla	xcolor
	die

**************************************************************************
*											     *
* xcolor - color value multiplier							     *
* a0 = color value									     *
* a1 = x factor (msw:integer lsw:fraction)						     *
* returns										     *
* a0 = x color value									     *
*											     *
**************************************************************************
xcolor
	mmtm	sp,a3,a4
	clr	a4
	move	a0,a3
	sll	27,a3
	srl	27,a3		;now i got 'da blues
	mpyu	a1,a3
	sll	11,a3
	srl	27,a3
	or	a3,a4
	move	a0,a3
	sll	22,a3
	srl	27,a3		;greens
	mpyu	a1,a3
	sll	11,a3		;strip garbage
	srl	27,a3
	sll	5,a3
	or	a3,a4
	move	a0,a3
	sll	17,a3
	srl	27,a3		;now reds
	mpyu	a1,a3
	sll	11,a3
	srl	27,a3
	sll	10,a3
	or	a3,a4
	move	a4,a0
	mmfm	sp,a3,a4
	rets

l_retp	retp


sans_boonpal
	.long	boonpal

all_palettes
	.long	0

;****************************

	.end

