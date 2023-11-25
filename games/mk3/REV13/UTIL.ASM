	.file	"util.asm"
	.title	" <<< general purpose subroutines >>>"

**************************************************************************
*												*
*	copyright (c) 1988 williams electronics games, inc.			*
*	all rights reserved.									*
*												*
**************************************************************************

	.width	132
	.option	b,d,l
	.mnolist

*	get the system stuff

	.include	"dispequ.asm"	;display processor equates
	.include	"sysequ.asm" 	;sys.inc and gsp.inc
	.include	"macros.hdr"		;macros, yeah!
	.include	"mainequ.asm"
	.include	imgtbl.glo

	.even
	.text

**************************************************************************
*												*
* clrworld - clear all world coordinates and scroll velocities.		*
*												*
**************************************************************************
clrworld
	push	a0
	clr	a0
	move	a0,@scrollx,l		;x scroll value
	move	a0,@scrolly,l		;y scroll value
	move	a0,@worldtlx,l		;top left x screen coord (world)
	move	a0,@worldtly,l		;top left y screen coord (world)
;	move	a0,@worldtl,l

	movi	scrnst,a0
	move	a0,@scrntl,l
	move	a0,@scrntl2,l
;	move	a0,@shad_scrntl,l

	movi	scrnend,a0
	move	a0,@scrnlr,l
	move	a0,@scrnlr2,l
	pull	a0
	rets

**************************************************************************
*												*
* random - generate a random number					 			*
* returns:								 			*
* a0 = 32 bit random #							 			*
*												*
**************************************************************************
random:	push	a1
	move	@rand,a0,l
	sla	1,a0
	jrv	rnd2
	ori	2,a0
rnd2:	move	a0,@rand,l
	clr	a1
	addc	a1,a0	;get last bit back to make 32
	move	@hcount,a1
	rl	a1,a0	;random rotation
	move	a0,a0	;set status bits
	mmfm	sp,a1
	rets	

**************************************************************************
*												*
* randu - generate a uniformly distributed random # between 1 and [a0]	*
* a0 = range input							 			*
* returns:								 			*
* a0 = random #								 			*
*												*
**************************************************************************
randu:	push	a1
	move	a0,a1
	callr	random
	mpyu	a1,a0
	inc	a0
	mmfm	sp,a1
	rets		
*
*get signed random # in range +/- a0
*calling parameters: a0
*returns a0
*
srand	mmtm	sp,a1
	move	a0,a1
	sll	1,a0
	calla	randu
	sub	a1,a0
	mmfm	sp,a1
	rets

**************************************************************************
*											     *
*  randper - random % routine								     *
*  calling parameters:									     *
*  a0=probability of event (0-1000) p(a0=1000) = 1; p(a0=1) = 1/1000.    *
*  returns cs if probability is true, cc for false				     *
*  returns a0 = actual random # 0-999							     *
*											     *
**************************************************************************
randper:
	mmtm	sp,a1,a2
	move	a0,a2
	calla	random
	movi	1000,a1
	mpyu	a1,a0
	cmp	a2,a0
	mmfm	sp,a1,a2
	rets		

**************************************************************************
*												*
* fillarea - fill a given square area on the screen with a color	 	*
* a1 = [color,palette]							 			*
* a3 = dag of area [ypos,xpos]						 			*
* a4 = [y,x] size of area						 			*
*												*
**************************************************************************
fillarea
	mmtm	sp,a1,a2,a4,a5
	jruc	areacon

**************************************************************************
*												*
* blnkarea - blank a given square area on the screen					*
* a3 = dag of area [ypos,xpos]									*
* a4 = [y,x] size of area									*
*												*
**************************************************************************
blnkarea
	mmtm	sp,a1,a2,a4,a5
	clr	a1			;constant 0:palette 0
areacon
	move	a4,a2
	movi	2000000h,a4		;somewhere in image rom
	movi	dmacal|0600cH,a5
	calla	qdman
	mmfm	sp,a1,a2,a4,a5
	rets
*
* yflp - set object y-flip, a8:object block ptr
*
yflp	mmtm	sp,a1,a4
	move	*a8(oflags),a4
	ori	m_fliph,a4
	jruc	stuflags
*
*noyflp - clear object y-flip, a8:object block ptr	
noyflp	mmtm	sp,a1,a4
	move	*a8(oflags),a4
	andni	m_fliph,a4
stuflags
	move	*a8(oimg),a1,l		;get the current image pointer
	calla	ani			;setup the "new" image
unflpd	mmfm	sp,a1,a4
	rets

**************************************************************************
*												*
* syncfull - synchronize with the full screen interrupt			 	*
*												*
**************************************************************************
syncfull
	rets

**************************************************************************
*												*
* dtime - used to dma an image									*
* a1 = [constant color,palette(stuffed in dtime)]					*
* a3 = dag [y,x]											*
* a5 = [offset,control]										*
* a14 = address of image header									*
*												*
**************************************************************************
dtime:
	mmtm	sp,a0,a1
	move	*a14(icmap),a0,l	;get the palette
	calla	findpal			;get the correct color map #
	jrnz	dtime1			;br = palette was found
	clr	a0			;default to fixed palette
dtime1
	movx	a0,a1
	calla	qdma			;queue this suckah
	mmfm	sp,a0,a1
	rets

**************************************************************************
*												*
* dmawait - wait on the dma busy bit to clear						*
*												*
**************************************************************************
dmawait	
	push	a0
dmawaitl
	move	@dmactrl,a0,w	;dma busy?
	jrn	dmawaitl	;br = yes
	pull	a0
	rets

*
*scrclr - clear the screen with eugene
*only call with interrupts disabled and the dma shut down, otherwise
*	use clr_scrn
scrclr	clr	a0
*scrfil - fill screen with a0
scrfil:
	mmtm	sp,a1,a2
	clr	a1
	move	a1,@cmapsel,w			;select color map 0
	movi	screen,a1,l
	movi	(scrne-screen)/32,a2,l
scrlp	move	a0,*a1+,l
	dsjs	a2,scrlp
	mmfm	sp,a1,a2
	rets

**************************************************************************
*												*
* setpproc - setup ti's pixel processing register's (bfile), to match	*
*	   the zunit system.						 			*
* note:	   if you want to do any special tricks, don't use this. 	 	*
*												*
**************************************************************************
setpproc
	push	a0
	movi	offsetval,b4	;set up offset register
	movi	0,b8			;set background color
	movi	scrn_ptch,a0		;get screen pitch
	move	a0,b1
	move	a0,b3
	lmo	a0,a0			;convert in temporary register
	move	a0,@convsp		;move to convsp io register
	move	a0,@convdp		;move to convdp io register
	pull	a0
	rets

************  clear screen routine  *********************

clr_scrn
	clr	a0
	mmtm	sp,a1,a2,a3
	move	@displayon,a3,w
	clr	a1
	move	a1,@displayon,w
;	callr	dmaqwait			;wait on dma
	clr	a1
	move	a1,@cmapsel,w			;select color map 0
	movi	screen,a1,l
	movi	((scrne-2000h)-screen)/32,a2,l
clrlp	move	a0,*a1+,l
	dsjs	a2,clrlp
	move	a3,@displayon,w
	mmfm	sp,a1,a2,a3
	rets

**************************************************************************
*												*
* copyobj - copies the contents of one object block to the other.		*
* a0 = ptr to destination block									*
* a8 = ptr to source block									*
*												*
**************************************************************************
copyobj
	mmtm	sp,a0,a6,a8
	movi	obsiz,a6,w	;get the size of the block in words
	addi	64,a0
	addi	64,a8		;don't copy the links
	srl	4,a6		;divide by 16		
	subk	4,a6		;subtract to account for the 1st two links
copyobjl
	move	*a8+,*a0+,w	;move a word
	dsjs	a6,copyobjl
	mmfm	sp,a0,a6,a8
	rets

**************************************************************************
*											     *
*  stop_a8 - zero velocities of object in a8					     *
*											     *
**************************************************************************
stop_a8
	mmtm	sp,a0,a1
	clr	a1			; no velocity
	move	a1,*a8(oxvel),l 	; in the "x" direction (and design)
	move	a1,*a8(oyvel),l 	; stop movement
	mmfm	sp,a0,a1
	rets

*******************************************************************

	.end
