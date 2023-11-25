**************************************************************************
*											     *
*  video game project:	  Mortal Kombat 3							*
* 											     *
*  program by:		  Edward J. Boon						     *
* 											     *
*  module: mkani - animation routines								*
* 											     *
*  copyright (c) 1994 midway manufacturing							*
*											     *
**************************************************************************
 	.file	"mkani.asm"
	.title	" <<< utilities >>> "

	.width	132
	.option	b,d,l
	.mnolist
*
* get the system stuff
*
	.include	dispequ.asm		; display processor equates
	.include	sysequ.asm		; sys.inc and gsp.inc
	.include	macros.hdr		; macros
	.include	mainequ.asm

;	.include	imgtbl.glo
;	.include	bgndtbl.glo
;	.include	diagaudn.asm

	.even
	.text


**************************************************************************
*											     *
*  find_ani_part2 - find the 2nd part of an animation.			     *
* 											     *
*  input: a9 = animation table offset							     *
*											     *
**************************************************************************
find_ani2_part2
	calla	get_char_ani2
	jruc	find_part2

find_ani_part2
	calla	get_char_ani

find_part2
	move	*a9+,a0,l
	jrne	find_part2
	rets

find_ani_part_a14
	push	a14
	calla	get_char_ani
	pull	a14

find_part_a14
	dec	a14
	jreq	fpa9
	callr	find_part2		; 1st call = part 2
	jruc	find_part_a14
fpa9	rets

**************************************************************************
*											     *
*  find_ani_last_frame - Returns a9 = last frame in an animation table   *
* 											     *
*  Input: a9 = animation table offset							     *
*											     *
**************************************************************************
find_ani_last_frame
	calla	get_char_ani

find_last_frame
	move	*a9+,a0,l
	jrne	find_last_frame

	subi	64,a9		; a9 = last frame of sequence
	rets


ani2	move	a0,*a8(oshape),l	; define current shape !
	move	*a8(oflags),a4,w	; a4 = flags
	move	*a8(oimg),a1,l		; a1 = multipart ram
	
an2	move	*a0+,a5,l		; a5 = img header
	jreq	an9			; zero ---> done

	move	*a5(isag),*a1+,l	; ram entry #1 = sag
	move	*a5(isize),a6,l
	move	a6,*a1+,l		; ram entry #2 = y:x size

	move	*a5(icontrol),a2,w
	andi	0ffcfH,a2		; clear the "flip" bits
	move	a4,a3
	andi	00030H,a3		; look only at the "flip" bits
	or	a3,a2
	move	a2,*a1+,w		; ram entry #3 = control word

	move	*a5(ianioffx),a2,w
	move	*a5(ianioffy),a3,w	; grab animation point offsets
	btst	b_fliph,a4		; horz flip ?
	jreq	an3			; no

	neg	a2			; yes, reverse x
	move	a6,a7
	zext	a7,w			; a6 = [0,x] size
	addxy	a7,a2

an3	btst	b_flipv,a4		; vert flip ?
	jreq	an4

	neg	a3			; reverse ani y
	sra	16,a6
	add	a6,a3

an4	move	a2,*a1+,w		; ram entry #4 = dx
	move	a3,*a1+,w		; ram entry #5 = dy
	jruc	an2

an9	clr	a0
	move	a0,*a1,l		; flag: end of multipart pieces
	clrc
	rets

anx	setc
	rets



do_first_a9_frame
	calla	get_char_ani		; a9 = frame #1
	jruc	do_next_a9_frame

do_next_a11_for_a10
	mmtm	sp,a8,a9
	move	a10,a8	
	move	a11,a9			; borrow these variables
	callr	do_next_a9_frame	; do it
	move	a8,a10
	move	a9,a11			; update em
	mmfm	sp,a8,a9
	rets

**************************************************************************
*											     *
*  do_next_a9_frame - standard "advance to next frame" routine		     *
* 											     *
*  input: a9 = animation table pointer						     *
* 											     *
*  returns: zero ---> end of animation reached !!				     *
* 	carry ---> skip sleep flag							     *
*											     *
**************************************************************************
do_next_a9_frame
	move	*a9+,a0,l
	jreq	gnf9			; zero = done

	cmpi	ani_lastcom,a0		; animation command ?
	jrls	gnf8			; yes, do it
	callr	ani2

	move	a9,a9			; dont set "zero" flag
	clrc
gnf9	rets

gnf8	sll	5,a0
	addi	animation_commands,a0
	move	*a0,a0,l
	jump	a0			; yes ---> jump to proper address


animation_commands
	.long	gnf9
	.long	do_ani_jump
	.long	do_ani_flip
	.long	do_ani_adjustx
	.long	do_ani_adjustxy
	.long	do_ani_nosleep
	.long	do_ani_calla
	.long	do_ani_sound
	.long	do_ani_ochar_jump
	.long	do_ani_flip_vert
	.long	do_ani_offset_xy
	.long	do_ani_sladd
	.long	do_ani_slani
	.long	do_ani_swpal
	.long	do_ani_slani_sleep
	.long	do_ani_ochar_sound

do_ani_ochar_sound
	move	*a9+,a0,w
	calla	ochar_sound
	jruc	do_next_a9_frame		; and go fetch a real image


do_ani_slani_sleep
	callr	slave_ani			; animate slave
	movk	1,a0 
	move	a0,a0				; clear zero flag
	clrc					; as well as carry
	jruc	gnf9				; and then sleep

do_ani_swpal
	move	*a9,a0,l  			; grab image which has pal
	move	*a0,a0,l
	move	*a0(icmap),a0,l
;	calla	swpal
	calla	player_swpal
	jruc	do_next_a9_frame		; and go fetch a real image

do_ani_sladd
	push	a8
	calla	gmo_proc			; a0 = process which holds data
	move	a8,a10				; a10 = object
	move	a0,*a8(oslink),l		; oslink = process
	pull	a8

	move	*a9+,a0,l  			; grab image to make slave from
	move	*a8(ochar),*a10(ochar),w	; same ochar as thrower
	move	a10,*a13(p_slave),l		; projectiles are slave objects

	movi	front_z+1,a0
	move	a0,*a10(ozval),l
	move	a10,a0
	calla	match_ani_points		; lineup proj with thrower !
	move	a10,a0
	calla	insobj				; on da list...return
	jruc	do_next_a9_frame		; and go fetch a real image


do_ani_slani
	callr	slave_ani
	jruc	do_next_a9_frame		; and go fetch a real image

slave_ani
	push	a8
	move	*a13(p_slave),a10,l
	move	a10,a0
	calla	match_ani_points		; always lineup slave
	move	a10,a8
	calla	do_next_a9_frame
	pull	a8
	rets


do_ani_offset_xy
	move	*a9+,a0,w		; x offset

	move	*a8(oflags),a1,w
	btst	b_fliph,a1
	jreq	dao3
    	neg	a0			; flipped = reverse x direction
dao3	move	*a13(p_otherguy),a1,l
	move	*a1(oxpos),a3,w
	add	a0,a3
	move	a3,*a8(oxpos),w

	move	*a9+,a0,w		; y offset
	move	*a1(oypos),a3,w
	add	a0,a3
	move	a3,*a8(oypos),w
	jruc	do_next_a9_frame	; and go fetch a real image


do_ani_flip_vert
	callr	flip_multi_v
	jruc	do_next_a9_frame	; and go fetch a real image

do_ani_ochar_jump
	move	*a9+,a0,l		; grab ochar to check for
	move	*a8(ochar),a1,w
	cmp	a0,a1
	jreq	do_ani_jump		; yes, ani_jump
	addi	32,a9			; a9 ---> skip past jump
	jruc	do_next_a9_frame	; and go fetch a real image


do_ani_sound
	move	*a9+,a0,l		; a0 = sound call to make
	calla	triple_sound
	jruc	do_next_a9_frame	; and go fetch a real image

do_ani_calla
	move	*a9+,a0,l		; a0 = routine to call !!
	call	a0			; call it.
	jruc	do_next_a9_frame	; and go fetch a real image

do_ani_jump
	move	*a9,a9,l		; animation pointer jump
	jruc	do_next_a9_frame	; and go fetch a real image

do_ani_flip
	callr	flip_multi
	jruc	do_next_a9_frame	; and go fetch a real image

do_ani_adjustx
	move	*a9+,a0,w		; a0 = amount to adjust x by
	clr	a1			; a1 = amount to adjust y by
	calla	multi_adjust_xy
	jruc	do_next_a9_frame	; and go fetch a real image

do_ani_adjustxy
	move	*a9+,a0,w
	move	*a9+,a1,w
	calla	multi_adjust_xy
	jruc	do_next_a9_frame	; and go fetch a real image

do_ani_nosleep
	move	*a9+,a0,l		; grab frame which does not sleep
	callr	ani2
	move	a9,a9			; clear the zero flag
	setc				; flag: dont sleep please
	rets

**************************************************************************
*											     *
*  animate_a9 - animate through a sequence given				     *
* 											     *
*  a9 = [sleep time,animation offset]							     *
*											     *
**************************************************************************
animate_a9
	move	a9,a0
	srl	16,a0		; a0 = sleep time
	push	a0
	zext	a9,w		; a9 = animation offset
	calla	get_char_ani
	pull	a0
	jruc	mframew

animate2_a9
	move	a9,a0
	srl	16,a0		; a0 = sleep time
	push	a0
	zext	a9,w		; a9 = animation offset
	calla	get_char_ani2
	pull	a0
	jruc	mframew

**************************************************************************
*											     *
*  pose_a9 - Pose me according to:							     *
* 											     *
*  a9 = [longword # offset , animation offset]					     *
*											     *
**************************************************************************
pose_a9	move	a9,a0
	srl	16-5,a0		; a0 = longword offset
	push	a0
	zext	a9,w		; a9 = animation offset
	calla	get_char_ani
	jruc	pose2

pose2_a9
	move	a9,a0
	srl	16-5,a0		; a0 = longword offset
	push	a0
	zext	a9,w		; a9 = animation offset
	calla	get_char_ani2
pose2	pull	a0
	add	a0,a9
	jruc	do_next_a9_frame


pose_him_a9
	mmtm	sp,a8,a9,a13
	move	*a13(p_otherguy),a8,l	; pretend I am him
	move	*a13(p_otherproc),a13,l
	callr	pose_a9
	mmfm	sp,a8,a9,a13
	rets

**************************************************************************
*											     *
*  act_mframew - same as routine below but my action is also defined.    *
* 											     *
*  input: a1 = action being done (stuffed into p_action)			     *
*         a8 = 1st object on list							     *
*         a0 = sleep time between each frame					     *
*         a9 = table of animations							     *
*											     *
**************************************************************************
act_mframew_z
	move	a1,*a13(p_action),w
	jsrp	mframew
	clr	a1
	move	a1,*a13(p_action),w		; clear "action"
	retp

act_mframew
	move	a1,*a13(p_action),w
;	<<<<<<<< fall through >>>>>>>>>

**************************************************************************
*											     *
*  mframew - animate through a list of multipart frames.			     *
* 											     *
*  input: a8 = 1st object on list							     *
*         a0 = sleep time between each frame					     *
*         a9 = table of animations							     *
*											     *
**************************************************************************
mframew
	move	a0,-*a12,l		; save sleep time (pushp a0)
mfr5	callr	do_next_a9_frame
	jreq	mfr9
	jrc	mfr5			; carry set = skip sleep
	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp			; sleep
	jruc	mfr5
mfr9	pullp 	a0
	retp

**************************************************************************
*											     *
*  backwards_ani - walk through an animation backwards given:		     *
* 											     *
*  input: a9 = animaition table offset						     *
*         a0 = sleep time between frames						     *
*											     *
**************************************************************************
backwards_ani2
	move	a0,-*a12,l		; save sleep time (pushp a0)
	move	a9,a9
	jrn	bani2			; already got ani
	calla	get_char_ani2
	jruc	bani2

backwards_ani
	move	a0,-*a12,l		; save sleep time (pushp a0)

	move	a9,a9
	jrn	bani2			; already got ani
	calla	get_char_ani
bani2	move	a9,a10			; a10 = frame #1
bani3	addi	32,a9
	move	*a9,a0,l		; end of animation ?
	jrne	bani3			; no

bani4	move	-*a9,a0,l
	calla	ani2

	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp
	cmp	a9,a10
	jrne	bani4

	pullp	a0
	retp

**************************************************************************
*											     *
*  animate_a0_frames - walk an animation script according to..		     *
* 											     *
*  a0 = [sleep time,# of frames]							     	*
*											     *
**************************************************************************
animate_a0_frames
	pushp	a10
	move	a0,a1
	srl	16,a1
	move	a1,-*a12,l		; save sleep time (pushp a1)

	move	a0,a10
	sll	16,a10
	srl	16,a10			; a10 = # of frames

mwa05	callr	do_next_a9_frame
	jreq	mwa09			; zero = we done !!
	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp			; sleep
	dsjs	a10,mwa05

mwa09	pullp 	a0
	pullp	a10
	retp

**************************************************************************
*											     *
*  mframew_a0 - same as mframew but a0 = [sleep time, # of frames]		*
* 											     *
**************************************************************************
mframew_a0
	pushp	a10
	move	a0,a10
	sll	16,a10
	srl	16,a10			; a10 = # of frames
	srl	16,a0			; a0 = sleep time !
	move	a0,-*a12,l		; save sleep time (pushp a0)

mfa03	callr	do_next_a9_frame	; end of line ----> abort
	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp			; sleep
	move	*a9,a0,l
	jreq	mfa04	 		; end of ani reached ----> abort
	dsjs	a10,mfa03

mfa04	pullp	a0
	pullp	a10
	retp

**************************************************************************
*											     *
*  init_anirate - initialize p_anirate and zero p_anicount so we will    *
*                 animate on first call of next_anirate			     *
* 											     *
*  input: a0 = animation speed								     *
*											     *
**************************************************************************
init_anirate
	cmpi	never_ani,a0			; animate ?
	jreq	inita2				; no

	move	a0,*a13(p_anirate),w		; speed o animation
	movk	1,a0
	move	a0,*a13(p_anicount),w	; 1st call = animate !!
	rets

inita2	move	a0,*a13(p_anirate),w		; speed o animation
	move	a0,*a13(p_anicount),w	; never animate
	rets

**************************************************************************
*											     *
*  mframe_a0 - animate through a list of multipart frames and sleep time *
* 											     *
*  input: a8 = 1st object on list							     *
*         a9 = table of animations / sleep times				     *
*											     *
**************************************************************************
mframe_a0
	move	*a9+,a0,l
	jreq	mfra09
	callr	ani2

	move	*a9+,a0,w		; a0 = sleep time
	jreq	mfra09			; zero ----> return
	calla	prcslp
	jruc	mframe_a0

mfra09	retp


**************************************************************************
*											     *
*  next_anirate - animate according to p_anirate value			     *
* 											     *
*  input: a9 = animation frames to use						     *
*         *a13(p_anitab) = base animation table					     *
*											     *
**************************************************************************
next_anirate
	move	*a13(p_anicount),a0,w
	dec	a0
	move	a0,*a13(p_anicount),w
	jrne	nexta2						; not time yet

	move	*a13(p_anirate),*a13(p_anicount),w	; reload p_anirate
	move	*a9,a1,l					; grab a frame
	jreq	nexta2						; zero = skip

	move	*a8(oflags2),a1,w
	btst	b_multipart,a1
	jrne	nexta1
	jruc	frame_a9					; and rets

nexta1	callr	do_next_a9_frame
nexta2	rets


**************************************************************************
*												*
*  framew											*
*												*
*  walks through a table of frames sleeping the same amount every time.	*
*												*
*  inputs:  a9 --> table of frames (in frame_a9 format)				*
*	   a0 = sleep time between each frame						*
*												*
*		  <<<< warning: call with jsrp >>>>>				*
*												*
**************************************************************************
framew
	move	a0,-*a12,l		; save sleep time (pushp a0)
fwloop	callr	frame_a9		; do a frame
	jreq	fwdone			; carry set = we just did last frame
	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp			; sleep
	jruc	fwloop

fwdone	pullp	a0
	addi	32,a9
	calla	prcslp			; sleep
	retp


framew_a10a11
	move	a0,-*a12,l		; save sleep time (pushp a0)
fw1011	callr	frame_a10a11
	jrc	fw1011x			; carry set = we just did last frame
	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp			; sleep
	jruc	fw1011

fw1011x	pullp	a0
	calla	prcslp			; sleep
	retp


frame_a10a11
	mmtm	sp,a8,a9
	move	a10,a8
	move	a11,a9
	callr	frame_a9		; do a frame
	move	a9,a11
	mmfm	sp,a8,a9
	rets


jframea9
	move	*a8(oflags),a4,w	; ani input: a4 = flags
	jruc	frame2 			; skip range check


ani_end		.set	0
newflag		.set	000020000H		; new flag command for "frame_a9"

**************************************************************************
*											     *
*  frame_a9 - frame animator								     *
* 											     *
*  input: a8 = object to use	 returns: a9 = next frame entry	     *
*         a9 = frame list entry 	     	cc = end of list not reached	*
* 			   			cs = end of list was reached  *
*											     *
**************************************************************************
frame_a9
	move	*a8(oflags),a4,w		; ani input: a4 = flags

;	cmpi	legalbeg,a9
;	jrlt	out_of_range
;	cmpi	legalend,a9
;	jrgt	out_of_range

frame2	move	*a9+,a1,l			; get a table entry
	jrn	frame5				; negative ---> this is a frame

frame1	jreq	frame9

	movi	newflag,a0
	cmpxy	a0,a1				; new flag command ?
	jryne	frame4				; no ---> check for other command
	andni	(m_flipv+m_fliph),a4		; always assume no flip bits set
	sll	16,a1
	srl	16,a1				; a1 = new flag
	or	a1,a4				; put it in

	move	*a9,a1,l
	jrp	frame3
	addi	32,a9 				; next is ani ---> do it
	jruc	frame5

frame3	cmpi	ani_jump,a1
	jrne	frame1
       	move	*a9(32),a9,l
	jruc	frame2				; now go process a real frame
*
* got a frame ---> ani
*
frame5	calla	ani
	move	*a9,a1,l			; a1 = peek ahead
	jrn	frame8				; next lw is a frame ---> we done
frame4	cmpi	ani_end,a1
	jreq	frame6				; sequence done ---> return
	cmpi	ani_jump,a1
	jrne	frame8
	move	*a9(32),a9,l			; jump ---> next lw redirects a9
frame8	clrc					; carry clear = end not reached
	rets

frame6	setc					; carry set = end was reached
frame9	rets


do_his_next_a9_frame
	push	a8
	move	*a13(p_otherguy),a8,l
	callr	do_next_a9_frame
	pull	a8
	rets

pose_him_a0
	mmtm	sp,a8,a9
	move	*a13(p_otherguy),a8,l	; pretend I am him
	move	a0,a9
	jrn	poseh4				; neg = we already got ani
	calla	get_char_ani			; a9 = frame 1
poseh4	callr	do_next_a9_frame		; pose
	move	*a13(p_otherproc),a0,l
	move	a9,*a0(pa9),l			; pass him the new a9
	mmfm	sp,a8,a9
	rets

**************************************************************************
*											     *
*  double_mframew - animate 2 multipart objects at the same time	     *
* 											     *
*  input: a0 = sleep time between frames						     *
*         a8 = object #1									     *
*         a9 = animation #1								     *
*        a10 = object #2									     *
*        a11 = animation #2								     *
*											     *
**************************************************************************
double_mframew
	move	a0,-*a12,l		; save sleep time (pushp a0)
dmfr5	callr	double_next_a9
	jreq	mfr9			; last frame ---> exit
	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp			; sleep
	jruc	dmfr5

**************************************************************************
*											     *
*  input: a8 = object #1									     *
*         a9 = ani #1									     *
*        a10 = object #2									     *
*        a11 = ani #2									     *
*											     *
**************************************************************************
double_next_a9
	callr	do_next_a9_frame
	mmtm	sp,a8,a9,a13
	move	*a13(p_otherproc),a13,l
	move	a10,a8
	move	a11,a9			; load up the second guys
	callr	do_next_a9_frame
	pushst
	move	a9,a11
	popst
	mmfm	sp,a8,a9,a13		; restore vidal stuff
	rets

**************************************************************************
*											     *
*  flip_multi - flip a multipart object						     *
* 											     *
*  input: a8 = multipart object to flip							*
*											     *
**************************************************************************
flip_multi
	move	*a8(oflags),a4,w
	xori	m_fliph,a4
	move	a4,*a8(oflags),w	; reverse flip bit
	move	*a8(oshape),a0,l	; get current shape
	jauc	ani2			; and run through ani with flipped bit

flip_multi_v
	move	*a8(oflags),a4,w
	xori	m_flipv,a4
	move	a4,*a8(oflags),w	; reverse flip bit
	move	*a8(oshape),a0,l	; get current shape
	jauc	ani2			; and run through ani with flipped bit

flip_single
	move	*a8(oflags),a4,w
	xori	m_fliph,a4
	move	a4,*a8(oflags),w	; reverse flip bit

	move	*a8(oimg),a1,l		; get the current image pointer
	calla	ani0			; setup the "new" image
	rets

	btst	b_fliph,a4		; horz flip ?
	jreq	fsing4

	move	*a1(isizex),a0,w
	move	*a8(oxpos),a2,w
	sub	a0,a2
	move	a2,*a8(oxpos),w

fsing4	btst	b_flipv,a4		; vert flip ?
	jreq	fsing5

	move	*a1(isizey),a0,w
	move	*a8(oypos),a2,w
	sub	a0,a2
	move	a2,*a8(oypos),w

fsing5	rets




**************************************************************************
*											     *
*  ground_multi - plants a dudes feet on da ground				     *
* 											     *
*  input: a8 = 1st object of his multi-part object				     *
*											     *
**************************************************************************
ground_multi
	callr	lowest_mpart		; a1 = lowest multipart
	move	@ground_y,a0,w		; a0 = ground y
	sub	a1,a0			; a0 = distance we gotta travel

	move	*a8(oypos),a1,w
	add	a0,a1
	move	a1,*a8(oypos),w		; adjust each object
	rets


adjust_xy_a5
	push	a8
	move	a5,a8
	callr	multi_adjust_xy
	pull	a8
	rets


multi_adjust_xy
	push	a4
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	maj4
	neg	a0			; flipped image = flip x direction
maj4	move	*a8(oxpos),a2,w
	add	a0,a2
	move	a2,*a8(oxpos),w		; adjust x coordinate

	move	*a8(oypos),a2,w
	add	a1,a2
	move	a2,*a8(oypos),w		; adjust y

	pull	a4
	rets


lineup_a0_onto_a1
	push	a8
	move	a1,a8
	callr	match_ani_points
	pull	a8
	rets

**************************************************************************
*											     *
*  match_ani_points - set a multipart object's animation x to match		*
*                     another object's ani x,y						*
* 											     *
*  input: a8 = object to match with								*
*         a0 = object which changes								*
*											     *
**************************************************************************
match_ani_points
	move	*a8(oxval),*a0(oxval),l
	move	*a8(oyval),*a0(oyval),l

	move	*a8(oflags),a1,w	; my flags
	move	*a0(oflags),a2,w	; his flags

	move	*a0(oflags2),a3,w
	btst	b_multipart,a3		; multipart ?
	jreq	match_single		; no, single

	andi	m_fliph,a1
	andi	m_fliph,a2		; look only at flip bits
	cmp	a1,a2			; same direction ?
	jreq	map9			; yes, exit

	mmtm	sp,a0,a8
	move	a0,a8
	callr	flip_multi		; flip multiparter
	mmfm	sp,a0,a8

map9	rets


match_single
	andi	m_fliph,a1
	andi	m_fliph,a2		; look only at flip bits
	cmp	a1,a2			; same direction ?
	jreq	maps1			; yes, exit

	move	*a0(oflags),a2,w
	xori	m_fliph,a2
	move	a2,*a0(oflags),w	; reverse flip bit

maps1	move	*a0(oimg),a1,l
	move	*a1(ianioffx),a3,w
	move	*a1(ianioffy),a4,w	; grab animation point offsets
	move	*a0(oxpos),a5,w
	move	*a0(oypos),a6,w

	move	*a0(oflags),a2,w

	btst	b_fliph,a2		; horz flip ?
	jreq	maps2			; no
	neg	a3

	move	*a1(isizex),a1,w
	sub	a1,a5

maps2	btst	b_flipv,a2
	jreq	maps3
	neg	a4
maps3	sub	a3,a5			; ani adjust x
	sub	a4,a6			; ani adjust y
	
	move	a5,*a0(oxpos),w
	move	a6,*a0(oypos),w		; stuff ani adjusted coordinates
	rets

**************************************************************************
*											     *
*  ground_player - grounds a player according to his animation point     *
* 											     *
*  input: a8 = object										*
*											     *
**************************************************************************
ground_player
	move	*a13(p_ganiy),*a8(oypos),w	; a0 = grounded ani y
 	rets


**************************************************************************
*											     *
*  highest_mpart - finds the object on a multipart object		 		*
*                  thats highest off the ground (lowest value)			*
* 											     *
*  input: a8 = 1st obect	    returns: a0 = coordinate of highest point   *
*                                          (lowest value)                *
*											     *
**************************************************************************
highest_mpart
	mmtm	sp,a1,a2,a3,a7
	move	*a8(oypos),a1,w		; a1 = ani y
	move	*a8(oimg),a7,l		; a7 = multipart ram
	movi	0ffffH,a0		; a0 = smallest value so far

fhi2	move	*a7(32+32+16+16),a2,w	; a2 = ani y
	move	a1,a3
	sub	a2,a3	      		; a3 = y coordinate of piece
	cmp	a0,a3			; highest object so far ?
	jrge	fhi3			; no
	move	a3,a0			; yes ---> new "lowest y value"

fhi3	addi	32+32+16+32,a7
	move	*a7,a2,l		; sag ? (another piece?)
	jrne	fhi2			; yes
	mmfm	sp,a1,a2,a3,a7
	rets

**************************************************************************
*											     *
*  lowest_mpart - finds the lowest part of a multipart obj			*
* 											     *
*  input: a8 = 1st obect	    returns: a1 = coordinate of lowest point    *
*                                          (highest value)               *
*											     *
**************************************************************************
lowest_mpart 
	mmtm	sp,a0,a2,a3,a7
	move	*a8(oypos),a0,w		; a1 = ani y
	move	*a8(oimg),a7,l		; a7 = multipart ram
	clr	a1			; a1 = biggest value so far

flo2	move	*a7(32+32+16+16),a2,w	; a2 = ani y
	move	a0,a3
	sub	a2,a3	      		; a3 = y coordinate of piece
	move	*a7(32+16),a2,w		; a2 = y size
	add	a2,a3			; a3 = bottom of piece

	cmp	a1,a3			; lowest object so far ?
	jrle	flo3			; no
	move	a3,a1			; yes ---> new "highest y value"

flo3	addi	32+32+16+32,a7
	move	*a7,a2,l		; sag ? (another piece?)
	jrne	flo2			; yes
	mmfm	sp,a0,a2,a3,a7
	rets

**************************************************************************
*											     *
*  leftmost_mpart - finds the object on a multipart object list 		*
*                   thats the leftmost (smallest x)					*
* 											     *
*  input: a8 = 1st obect	    returns: a2 = leftmost coordinate			*
*											     *
**************************************************************************
leftmost_mpart 
	mmtm	sp,a0,a1,a3,a4,a7
	move	*a8(oxpos),a0,w		; a1 = ani x
	move	*a8(oimg),a7,l		; a7 = multipart ram
	movi	0ffffH,a2		; a2 = leftmost value so far

flm2	move	*a7(32+32+16),a4,w	; a4 = ani x
    	move	a0,a3
	sub	a4,a3	      		; a3 = x coordinate of piece
	cmp	a2,a3			; leftmost object so far ?
	jrge	flm3			; no
	move	a3,a2			; yes ---> new "leftmost y value"

flm3	addi	32+32+16+32,a7
	move	*a7,a4,l		; sag ? (another piece?)
	jrne	flm2			; yes

	mmfm	sp,a0,a1,a3,a4,a7
	rets

**************************************************************************
*											     *
*  rightmost_mpart - finds the object on a multipart object list 		*
*                    thats the rightmost (biggest x)					*
* 											     *
*  input: a8 = 1st obect	    returns: a3 = rightmost coordinate		*
*											     *
**************************************************************************
rightmost_mpart
	mmtm	sp,a0,a1,a2,a4,a7
	move	*a8(oxpos),a0,w		; a1 = ani x
	move	*a8(oimg),a7,l		; a7 = multipart ram

	movi	-5000,a3		; a3 = leftmost value so far

frm2	move	*a7(32+32+16),a2,w	; a2 = ani x
	move	a0,a4
	sub	a2,a4	      		; a4 = x coordinate of piece

	move	*a7(32),a2,w		; a2 = x size
	add	a2,a4			; a4 = right side of piece
	cmp	a3,a4			; rightmost object so far ?
	jrle	frm3			; no
	move	a4,a3			; yes ---> new "rightmost"

frm3	addi	32+32+16+32,a7
	move	*a7,a2,l		; sag ? (another piece?)
	jrne	frm2			; yes

	mmfm	sp,a0,a1,a2,a4,a7
	rets


	.end
