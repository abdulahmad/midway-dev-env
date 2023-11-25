**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mkrepell										*
* 											     *
*  copyright (c) 1994-95 Midway Manufacturing	   					*
*											     *
**************************************************************************
	.file	'mkrepell.asm'
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

;	.include	imgtbl.glo
;	.include	bgndtbl.glo
;	.include	stringh.asm
;	.include	diagaudn.asm

	.text



repell_distance		.set	>40
screen_distance		.set	>130


**************************************************************************
*											     *
*  repell - process to keep players from overlapping each other	     *
*											     *
**************************************************************************
repell
	sleep	1
	move	@f_norepell,b4,w	; repell disabled ??
	jreq	rep1
	dec	b4
	move	b4,@f_norepell,w	; for a limited time only !!

rep1	move	@p1_obj,a8,l
	move	@p2_obj,a9,l

	move	a8,a0
	callr	get_player_hilo
	move	a6,a4
	move	a7,a5	       		; a4 = high point : a5 = low point
	move	a9,a0
	callr	get_player_hilo		; a6 = high point : a7 = low point
	subi	>30,a5
	subi	>30,a7			; grace pixels
	cmp	a6,a5
	jrlt	player_above_player
	cmp	a4,a7
	jrlt	player_above_player	; allow to jump over each other

	callr	get_player_anis
	move	b4,b4
	jrne	rep2			; repell disabled ---> skip

	cmpi	repell_distance-3,a5
	jrlo	repell_now		; super close ---> repell 'em now !!
*
* process player 1 velocity 
*
rep2	move	@p1_xvel,a6,l
	jreq	rep6
	cmpi	repell_distance,a5	; a5 = x distance
	jrhs	rep6			; far apart !!!!!

	move	b4,b4
	jrne	rep6			; repell disabled ---> skip

	move	a6,a6
	jrn	rep3
    	cmp	a1,a3
	jrle	rep6			; moving right / he's to the left
	move	@p2_xvel,a0,l
	jrn	stuff_zeros		; fighting each other ---> both zero
	jruc	rep5

rep3	cmp	a1,a3
	jrge	rep6
	move	@p2_xvel,a0,l
	jrp	stuff_zeros		; fighting each other ---> both zero
rep5	sra	1,a6
	move	a6,a7
	jruc	stuff_a6a7		; i'm pushing him ---> 1/2 speed

*
* process player 2 velocity 
*
rep6	move	@p2_xvel,a7,l
	jreq	stuff_a6a7
	cmpi	repell_distance,a5	; a5 = x distance
	jrhs	stuff_a6a7		; far apart !

	move	b4,b4
	jrne	stuff_a6a7		; repell disabled ---> skip

	move	a7,a7
	jrn	rep7
    	cmp	a3,a1
	jrle	stuff_a6a7		; i'm moving away from him ---> ok
	move	@p1_xvel,a0,l
	jrn	stuff_zeros		; ---> <--- pressing, zero both vels
	jruc	rep8

rep7	cmp	a3,a1
	jrge	stuff_a6a7		; i'm moving away from him ---> ok
	move	@p1_xvel,a0,l
	jrp	stuff_zeros		; ---> <--- pressing, zero both vels
rep8	sra	1,a7
	move	a7,a6
	jruc	stuff_a6a7		; i'm pushing him ---> 1/2 speed


stuff_zeros
	clr	a6
	clr	a7
	jruc	stuff_velocities

player_above_player
	callr	get_player_anis
	move	@p1_xvel,a6,l
	move	@p2_xvel,a7,l

stuff_a6a7
	cmpi	screen_distance,a5	; too far apart ??
	jrls	stuff_velocities	; no ---> stuff velocities

; newly removed (ejbpatch)
;
;	move	b4,b4			; are we disabled ?
;	jrne	stuff_velocities	; yes ----> just do as you're told !!

	subi	screen_distance,a5	; a5 = amount we need to adjust
	cmp	a1,a3
	jrgt	stuf5

	move	a7,a7			; layout is: p2 - p1
	jrp	stuf2
	clr	a7			; p2 on left ---> can't move left
stuf2	move	a6,a6
	jrn	stuf8
	clr	a6			; p1 on right ---> can't move right
	jruc	stuf8
     	
stuf5	move	a7,a7			; layout is: p1 - p2
	jrn	stuf6
     	clr	a7			; p2 on right ---> can't move right
stuf6	move	a6,a6
	jrp	stuf7
     	clr	a6			; p1 on left ---> can't move left
*
* if too far apart ---> adjust
*
stuf7	cmpi	3,a5
	jrls	stuff_velocities	; close enough
	srl	1,a5			; take 1/2 the error
	jruc	stuf9

stuf8	cmpi	3,a5
	jrls	stuff_velocities	; close enough
	srl	1,a5			; take 1/2 the error
	neg	a5

stuf9	move	a8,a4			; push a8
	move	a9,a8
	neg	a5
	callr	nudge_xy		; nudge player 2
	move	a4,a8			; pull a8
	neg	a5
	callr	nudge_xy		; nudge player 1

stuff_velocities
	move	a7,*a9(oxvel),l
 	move	a6,*a8(oxvel),l
	jruc	repell


repell_now
	move	b4,b4		; repell disabled ?
	jrne	repell		; yes, back to sleep

	movi	>30000,a7
	move	a7,a6
	neg	a6	      	; assume player 1 on left
	move	*a9(oxpos),a4,w
	move	*a8(oxpos),a3,w
	cmp	a3,a4
 	jrge	stuff_a6a7
	swap	a6,a7
	jruc	stuff_a6a7

nudge_xy
	move	*a8(oxpos),a2,w
	add	a5,a2
	move	a2,*a8(oxpos),w
	rets

**************************************************************************
*											     *
*  get_player_anis - get both players animation x points			     *
* 											     *
*  returns: a0 = player 1 animation y    						     *
* 	   a1 = player 1 animation x							     *
*           a2 = player 2 animation y							     *
*           a3 = player 2 animation x							     *
*           a4 = y distance								     *
*           a5 = x distance								     *
*           a8 = player 1 object								     *
*           a9 = player 2 object								     *
*											     *
**************************************************************************
get_player_anis
	move	@p1_obj,a8,l
	move	*a8(oxpos),a1,w
	move	*a8(oypos),a0,w

	move	@p2_obj,a9,l
	move	*a9(oxpos),a3,w		; a3 = p2 x
	move	*a9(oypos),a2,w		; a2 = p2 y

	move	a0,a4
	sub	a2,a4
	abs	a4			; a4 = y distance between dudes

	move	a1,a5
	sub	a3,a5
	abs	a5			; a5 = x distance between dudes
	rets

**************************************************************************
*											     *
*  get_player_hilo - get player hi and low coordinates.			     *
* 											     *
*  input:   a0 = player main object (1st on list)				     *
* 											     *
*  returns: a6 = highest y point of object (lowest coordinate value)	*
*           a7 = lowest y point of object (highest coordinate value)	*
*											     *
**************************************************************************
get_player_hilo
	mmtm	sp,a2,a3,a4,a5
	movi	>0fffffff,a6		; a6 starts off huge
	movi	->fffff,a7		; a7 starts off micro
	move	*a0(oimg),a4,l		; a4 = multipart "pieces" ram
	move	*a0(oypos),a3,w		; a3 = ani y

gphl3	move	*a4(32+16),a5,w		; a5 = y size
	move	*a4(64+16+16),a2,w 	; a2 = y ani offset

	neg	a2
	add	a3,a2			; a2 = top of piece coordinate

	cmp	a6,a2			; highest point so far ?
	jrgt	gphl4			; no
	move	a2,a6			; yes ---> keep a note o this
gphl4	add	a5,a2			; a2 = bottom of piece
	cmp	a7,a2			; lowest point so far ?
	jrlt	gphl5			; no
	move	a2,a7			; yes ---> keep a note o this
gphl5	addi	32+32+16+32,a4		; a4 ---> next piece
	move	*a4,a5,l		; anything ?
	jrne	gphl3			; yes
	mmfm	sp,a2,a3,a4,a5		; no, we've got what we came for
	rets

;******************************

	.end

