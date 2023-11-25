**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mkladder.asm = 1 player ladder							*
* 											     *
*  copyright (c) 1995 williams electronics games, inc.			     *
*											     *
**************************************************************************
	.file	"mkladder.asm"
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
	.include	stringh.asm
	.include	imgtbl.glo


entries_easy	.set	8
entries_med	.set	10
entries_hard	.set	12

last_hard_entry	.set	(entries_easy+entries_med+entries_hard-1)*16+16+16
last_med_entry	.set	(entries_easy+entries_med-1)*16+16
last_easy_entry	.set	(entries_easy-1)*16

pandown		.set	030000H


mk_ladder
	calla	murder_myoinit_score
	movk	14,a11
	calla	do_a11_background   	; portal bgnd
	movi	03cH,a3
	calla	send_code_a3	    	; start 1 player map tune
	movk	1,a0
	move	a0,@f_novel,w

	move	@map_start,a0,l		; have we set our map start yet ??
	jreq	lad2			; no, let the player pick their path !

	jsrp	setup_close_ladder	; yes, close up
	jruc	lad1p

lad2	movk	6,a0
	calla	randu
	dec	a0
	sll	5,a0
	addi	rom_maps_tbl,a0
	move	*a0,a0,l
	move	a0,@ladder_base,l	; random ladder base !!!

	jsrp	setup_distant_ladders
	jsrp	ladder_switch_scan

	clr	a0
	move	a0,@map_position,w
	move	a0,@perform,w		; zero performance
	callr	init_map_start
	jsrp	spin_the_mk_badge
	jsrp	pan_to_picked_tower
	jsrp	zoom_in
	jsrp	pan_down
	callr	set_match_1_diff	; set difficulty

lad1p	movi	03dH,a3
	calla	send_code_a3	   	; end 1 player map tune

;************* new
;	sleep	020H
	sleep	01eH
	calla	murder_myoinit_score
	calla	clr_scrn
	sleep	3			; avoid glitch between transitions
;************* new

	retp


setup_close_ladder
	movi	build_left_tower,a7
	move	@ladder_order,a0,w
	move	a0,a11
	jreq	scl3
	movi	build_middle_tower,a7
	dec	a0
	jreq	scl3
	movi	build_right_tower,a7
scl3	call	a7

	movi	001000100H,a0
	move	a0,@ladder_scale,l		; full scale from now on !!

	move	@map_position,a1,w
	dec	a1
	jrnn	scl4
	clr	a1				; position 1&0 ---> bottom

scl4	movi	96,a3				; blocks are 96 pixels tall
	mpys	a3,a1

	move	a11,a0
	sll	4,a0
	addi	mhe_close_ladder_y,a0
	move	*a0,a0,w
	add	a1,a0				; lineup at the point we are at !!
	move	a0,@ladder_y+16,w
	movi	scrrgt/2*010000H,a0
	move	a0,@ladder_x,l
	movi	ladder_irq,a0
	move	a0,@call_every_tick,l	; ladder IRQ ---> go !!

	callr	get_current_1st_obj
	clr	a0
scl5	move	a0,*a1(oyvel),l
	move	*a1,a1,l
	jrne	scl5				; stop all other vels
	move	a0,@f_novel,w			; and allow normal vels

	callr	get_player_ochar_a5
	movi	000b40088H,a4
	calla	gso_dmawnz_ns_coor
	calla	insobj2a8
	move	a8,a9
	callr	solid_backdrop_box
	calla	insobj2a8
	sleep	012H

	move	@map_position,a0,w
	jreq	scl8				; 1st spot = dont move

	move	*a8(oypos),a10,w
	movi	-030000H,a0
	move	a0,*a8(oyvel),l
	move	a0,*a9(oyvel),l
scl7	sleep	1
	move	*a8(oypos),a5,w
	sub	a10,a5
	abs	a5
	cmpi	96,a5
	jrlo	scl7			; travel 1 box distance

	clr	a0
	move	a0,*a8(oyvel),l
	move	a0,*a9(oyvel),l
scl8	sleep	020H
	jruc	l_retp


setup_distant_ladders
	tsound	039H			; shao: Choose your destiny

	movi	txt_ladder,a8
	movi	0000800c8H,a9
	jsrp	pds_centered

	movk	1,a0
	move	a0,@ladder_order,w

	movi	004000400H,a0
	move	a0,@ladder_scale,l
	movi	0140000H,a0
	move	a0,@ladder_y,l

	movi	scrrgt/2*010000H,a0
	move	a0,@ladder_x,l
	clr	a0
	move	a0,@ladder_x_vel,l
	move	a0,@ladder_left_x,w
	move	a0,@ladder_right_x,w

	callr	build_middle_tower
	callr	build_left_tower
	callr	build_right_tower

	movi	ladder_irq,a0
	move	a0,@call_every_tick,l	; ladder IRQ ---> go !!

	movi	MKCOIN_01,a5
	movi	000d000b3H+068H,a4		; START AT NOVICE !!!
	calla	gso_dmawnz_ns_coor
	calla	insobj2a8
	move	a8,a9
;	movi	TXT_MASTER,a5
	movi	TXT_NOVICE,a5
	calla	gso_dmawnz_ns

	move	*a9(oypos),a1,w
	addi	010H,a1
	move	a1,*a8(oypos),w
	move	*a9(ozpos),a1,w
	inc	a1
	move	a1,*a8(ozpos),w

	move	*a9(oxpos),a0,w
	move	*a9(osize),a1,w
	sra	1,a1
	add	a0,a1				; a1 = center spot !!
	move	*a8(osizex),a0,w
	sra	1,a0
	sub	a0,a1
	move	a1,*a8(oxpos),w
	calla	insobj2a8
	swap	a8,a9
	create	pid_bani,badge_spinner	; a8 = text  / a9 = coin

l_retp	retp



build_middle_tower
	move	@ladder_base,a7,l
	addi	last_hard_entry,a7

	movk	entries_hard-1,a10  	; # of entries
	move	*a7,a0,w
	subk	16,a7			; moving backwards
	movi	baklst1,b4		; list to insert the mug shots !!
	callr	get_a_brick
	calla	insobja8

lad3	move	a8,a9
	move	a10,a0
	movi	baklst1,b4		; list to insert the mug shots !!
	move	*a7,a0,w
	subk	16,a7			; moving backwards
	callr	get_a_brick
	clr	a0
	move	a0,*a8(olink),l
	move	a8,*a9(olink),l		; at the end of the list
	dsj	a10,lad3
	rets

build_left_tower
	move	@ladder_base,a7,l
	addi	last_med_entry,a7

	movk	entries_med-1,a10  	; # of entries
	movi	baklst2,b4		; mugshots = baklst3 !!
	move	*a7,a0,w
	subk	16,a7			; moving backwards
	callr	get_a_brick
	movi	baklst3,b4
	move	a8,a0
	calla	insobj_v		; stone list = baklst2

lad5	move	a8,a9
	move	*a7,a0,w
	subk	16,a7			; moving backwards
	movi	baklst2,b4		; list to insert the mug shots !!
	callr	get_a_brick
	clr	a0
	move	a0,*a8(olink),l
	move	a8,*a9(olink),l		; at the end of the list
	dsj	a10,lad5
	rets

build_right_tower
	move	@ladder_base,a7,l
	addi	last_easy_entry,a7

	movk	entries_easy-1,a10  	; # of entries
	clr	a0
	movi	baklst4,b4		; mugshots = baklst3 !!

	move	*a7,a0,w
	subk	16,a7			; moving backwards
	callr	get_a_brick
	movi	baklst5,b4
	move	a8,a0
	calla	insobj_v		; stone list = baklst2

lad7	move	a8,a9
	movi	baklst4,b4		; list to insert the mug shots !!
	move	*a7,a0,w
	subk	16,a7			; moving backwards
	callr	get_a_brick
	clr	a0
	move	a0,*a8(olink),l
	move	a8,*a9(olink),l		; at the end of the list
	dsj	a10,lad7
	rets

;***************************************************
;***************************************************

ladder_switch_scan
;	movk	1,a11			; start position = center !!
	movk	2,a11			; start position = NOVICE !!!!!

	clr	a10			; debounce
	movi	m_p1action,a2		; player 1 port 1 mask
	movi	switch,a3
	move	@p1_state,a7,w
	cmpi	ps_active,a7
	jreq	lad91
	movi	m_p2action,a2		; player 2 port 1 mask
	movi	switch+8,a3
lad91	move	a2,*a13(p_store1),l	; save port mask
	move	a3,*a13(p_store2),l	; save port mask

	movi	040H*4,a0
lad92	move	a0,*a13(p_store3),w
	sleep	1
	move	a10,a10
	jreq	lad93
	dsj	a10,lad97

lad93	move	@switch,a0,l
	not	a0
	move	*a13(p_store1),a1,l
	and	a1,a0			; only look at action buttons
	jrne	lad99			; press = exit

	move	*a13(p_store2),a0,l
	move	*a0,a0,l
	not	a0			; a0 = bit state ?
	andi	00fH,a0			; only look at joystick bits
	jreq	lad97
*
* stick left
*
	movk	10,a10			; debounce speed
	btst	2,a0
	jreq	lad96

	cmpi	0,a11
	jreq	lad97			; already on left tower

	dec	a11

	movi	-068H,a1
	callr	move_dragon_logo
	jruc	lad97
*
* stick right
*
lad96	btst	3,a0
	jreq	lad97

	cmpi	2,a11
	jreq	lad97			; already on right tower
	inc	a11
	movi	068H,a1
	callr	move_dragon_logo

lad97	move	*a13(p_store3),a0,w
	dsj	a0,lad92

lad99	jruc	l_retp
	
;***************************************************
;***************************************************

spin_the_mk_badge
	movi	0447H,a3
	calla	send_code_a3		; path picked sound

	pushp	a9			; save diff text

	movi	pid_bani,a0
	calla	dallprc			; stop badge rotator dude !!!
	movi	a_badge_spin,a9
	movi	040H,a10
lad9a	sleep	1
	calla	frame_a9
	dsj	a10,lad9a
	move	a8,a0
	calla	delobjp2		; delete badge obj

	pullp	a0
	calla	delobjp2		; delete diff text

	move	a11,a0
	addi	07cH,a0
	calla	triple_sound		; Shao Kahn comment
	sleep	8
	jruc	l_retp

;***************************************************

pan_to_picked_tower
	move	a11,a0
	sll	5,a0
	addi	mhe_x_vels,a0
	move	*a0,a0,l
	move	a0,@ladder_x_vel,l
*
* wait for top brick to be centered
*
	cmpi	1,a11
	jreq	ladd8  			; hard ---> we are already centered
	callr	get_current_1st_obj
	move	a1,a10
ladd7	sleep	1
	move	*a10(oxpos),a0,w
	subi	0b0H,a0
	abs	a0
	cmpi	3,a0
	jrhi	ladd7

	clr	a0
	move	a0,@ladder_x_vel,l
	movi	scrrgt/2*010000H,a0
	move	a0,@ladder_x,l
	move	a11,@ladder_order,w
ladd8	jruc	l_retp

;****************************************************
;****************************************************


zoom_in
	callr	get_current_1st_obj
	move	*a1(oyval),a0,l
	move	a0,@ladder_y,l		; set new ladder "y"

	sleep	010H			; pause...

	move	a11,a0
	sll	5,a0
	addi	mhe_y_vels,a0
	move	*a0,a0,l
	move	a0,@ladder_y_vel,l

	tsound	019H			; zoom in sound
*
* ZOOM IN !
*
	movi	004000400H,a9
zoom3	sleep	1
	callr	avoid_dma_glitch
	move	a9,@ladder_scale,l
	subi	000100010H,a9
	cmpi	001000100H,a9
	jrne	zoom3			; gee ed, pissed off today ?

	clr	a0
	move	a0,@ladder_x_vel,l
	move	a0,@ladder_y_vel,l	; stop moving up already !!
	move	a9,@ladder_scale,l
	sleep	2			; ok now everyone is full scale
	clr	a0
	move	a0,@call_every_tick,l
	jruc	l_retp

;***********************************************************

avoid_dma_glitch
	cmpi	001a001a0H,a9
	jrne	avoid9			; no

	move	@ladder_order,a0,w
	sll	6,a0
	addi	mhe_rid_of_these,a0
	clr	a1
	move	*a0+,a2,l
	move	a1,*a2,l
	move	*a0+,a2,l		; empty these lists to avoid our
	move	a1,*a2,l		; stupid dma's errors !!

avoid9	rets

mhe_rid_of_these
	.long	objlst,baklst5
	.long	baklst3,baklst5
	.long	baklst3,objlst

;**************************************************************
;**************************************************************

pan_down
	callr	create_base_objects

	callr	get_player_ochar_a5
	movi	020H,a6
	movi	-04aH,a7
	callr	base_offset_obj		; players box

	move	a8,a9
	callr	solid_backdrop_box
	callr	base_insert		; outline solid color box

	movi	010H,a11			; button exit timer !!

	clr	a0
	move	a0,@f_novel,w		; START MOVING NOW !!!
pandown4	sleep	1

	move	@switch,a0,l
	not	a0
	movi	p1b0|p1b1|p1b2|p1b3|p1b4|p1b5,a1
	move	@p1_state,a3,w
	cmpi	ps_active,a3
	jreq	pandown6
	movi	p2b0|p2b1|p2b2|p2b3|p2b4|p2b5,a1
pandown6	and	a1,a0			; look at active players buttons only
	jreq	pandown7
	dec	a11
	jreq	pandown9		; button still down ---> abort this

pandown7	move	*a10(oypos),a0,w
	cmpi	0a7H,a0
	jrgt	pandown4		; wait for pan to hit rok bottom
pandown9	movk	1,a0
	move	a0,@f_novel,w		; STOP MOVING NOW !!!
	jruc	l_retp

;**************************************

solid_backdrop_box
	movi	bpal_red,a0
	movi	0003f0034H,a3
	calla	make_solid_object

	move	*a9(oxpos),a0,w
	subk	2,a0
	move	a0,*a8(oxpos),w
	move	*a9(oypos),a0,w
	subk	2,a0
	move	a0,*a8(oypos),w		; coordinate offset
	rets


get_player_ochar_a5
	move	@p1_char,a5,w
	move	@p1_state,a0,w
	cmpi	ps_active,a0,w
	jreq	pbox3
	move	@p2_char,a5,w
pbox3	sll	5,a5
	addi	ochar_order_mugs,a5
	move	*a5,a5,l
	rets


create_base_objects
	callr	get_current_1st_obj
cbo3	move	a1,a10
	move	*a1,a1,l
	jrne	cbo3

	movi	MKBRICK2,a5
	calla	gso_dmawnz_ns
	movi	-pandown,a0
	move	a0,*a8(oyvel),l		; pan down speed
	move	*a10(oxpos),*a8(oxpos),w
	move	*a10(oypos),a0,w
	move	*a10(osizey),a1,w
	add	a1,a0
	move	a0,*a8(oypos),w		; position under last fighter brick
	clr	a0
	move	a0,*a8(olink),l		; new end of list
	move	a8,*a10(olink),l
	move	a8,a10			; new last obj
*
* create mountain objects
*
	movi	UPEVILA,a5
	movi	-075H,a6
	movi	010H,a7
	callr	base_offset_obj
	movi	UPEVILB,a5
	movi	06cH,a6
	movi	010H,a7
	callr	base_offset_obj
	rets

;**************************************************************
;**************************************************************


mhe_list
	.long	baklst2
	.long	objlst
	.long	baklst4


mhe_close_ladder_y
	.word	-0200H-96*2
	.word	-0200H-96*4
	.word	-0200H


mhe_stop
	.word	000H
	.word	000H
	.word	-0110H

move_dragon_logo
	mmtm	sp,a1,a8
	move	a11,a0
	sll	5,a0
	addi	emh_images,a0
	move	*a0,a1,l
	move	a9,a8
	calla	ani_flag		; update difficulty text
	mmfm	sp,a1,a8

	move	*a8(oxpos),a0,w
	add	a1,a0
	move	a0,*a8(oxpos),w		; move to left tower
	move	*a9(oxpos),a0,w
	add	a1,a0
	move	a0,*a9(oxpos),w		; move to left tower

	movi	043dH,a3
	jauc	send_code_a3


emh_images
	.long	TXT_WARRIOR
	.long	TXT_MASTER
	.long	TXT_NOVICE


get_current_1st_obj
	callr	get_current_objlst
	move	*a1,a1,l		; 1st obj
	rets

get_current_objlst
	move	a11,a1
	move	a11,a0
	sll	6,a0			; 2 longs
	sll	4,a1			; 1 word
	add	a0,a1
	addi	medium_1st,a1
	move	*a1,a1,l		; obj list
	rets

base_offset_obj
	calla	gso_dmawnz_ns
	clr	a0
	move	a0,*a8(olink),l
	movi	500,a0
	move	a0,*a8(ozpos),w		; in front of bricks
	move	*a10(oxpos),a0,w
	move	*a10(oypos),a1,w
	add	a6,a0
	add	a7,a1
	move	a0,*a8(oxpos),w
	move	a1,*a8(oypos),w

base_insert
	movi	-pandown,a0
	move	a0,*a8(oyvel),l
	callr	get_current_objlst
	move	a1,b4
	move	a8,a0
	calla	insobj_v
	rets

;*******************************************************

ladder_irq
	move	@ladder_y_vel,a0,l
	move	@ladder_y,a1,l
	add	a0,a1
	move   	a1,@ladder_y,l		; y vel (if any)

	move	@ladder_x_vel,a0,l
	move	@ladder_x,a1,l
	add	a0,a1
	move   	a1,@ladder_x,l		; x vel (if any)

	move	@ladder_scale,a9,l
	movi	192,a10
	sll	8,a10			; shift for the formula
	movi	96,a11
	sll	8,a11			; shift for the formula

	move	a9,a3
	zext	a3,w			; only look at x
	move	a11,a1
	divs	a3,a1 
	move	a1,a11			; a10 = new scaled x size
	move	a10,a1
	divs	a3,a1 
	move	a1,a10			; a11 = new scaled y size

	move	a9,a1
	zext	a1,w
	movi	019eH,a3
	sll	8,a3
	divs	a1,a3			; a3 = scaled x between towers !!
*
*  a3 = scaled x distance between towers
*  a9 = current scale
* a10 = current scale x size
* a11 = current scale y size
*
	move	@ladder_order,a1,w
	move	a1,a2
	sll	5,a1
	addi	mhe_ladder_order,a1
	move	*a1+,a0,l

	move	@ladder_x,a2,l
	sra	16,a2
	callr	process_a_ladder

	move	*a0(32+16),a1,l
	call	a1
	addi	32+16+32,a0
	callr	process_a_ladder

	move	*a0(32+16),a1,l
	call	a1
	addi	32+16+32,a0
	callr	process_a_ladder	; process 3 towers !!

	rets

*
* input: a2 = x position to center around
*        a0 = info table
*
process_a_ladder
	mmtm	sp,a0,a1,a3
	move	*a0+,a8,l		; top brick object !!
	move	*a8,a8,l
	jreq	lq9			; empty list = exit
	move	a9,*a8(oscale),l	; update to newest scale value
	move	*a0+,a1,w		; # of blocks to skip past ladder_y

	move	@ladder_y,a14,l
	sra	16,a14

	mpys	a11,a1			; add # of block heights
	add	a1,a14
 	move	a14,*a8(oypos),w	; here is our starting y position

	move	a2,a14			; a14 = x position to center on
	move	a10,a1			; a1 = scaled x size
	srl	1,a1			; 1/2 of x size
	sub	a1,a14			; center the image on the screen
	move	a14,*a8(oxpos),w

lq3	move	a9,*a8(oscale),l  	; update each object with latest scale
	move	*a8(oslink),a0,l
	move	a9,*a0(oscale),l	; update to newest scale value
	move	a9,a3
	zext	a3,w			; a3 = scale value we follow

	movi	108,a1			; a1 = full scaled x distance !!
	sll	8,a1
	divs	a3,a1			; a1 = new scaled x distance
	move	*a8(oxpos),a14,w
 	add	a1,a14
	move	a14,*a0(oxpos),w

	movk	22,a1			; a1 = full scaled y distance
	sll	8,a1
	divs	a3,a1			; a1 = new scaled x distance
	move	*a8(oypos),a14,w
	add	a1,a14
	move	a14,*a0(oypos),w

	move	a8,a7			; a7 = previous obj
	move	*a8(olink),a8,l		; grab next obj
	jreq	lq9

	move	*a7(oxpos),*a8(oxpos),w
	move	*a7(oypos),a14,w
	add	a11,a14
	move	a14,*a8(oypos),w
	jruc	lq3

lq9	mmfm	sp,a0,a1,a3
	rets


get_a_brick
	push	a7
	push	a0
	movi	MKBRICK,a5
	calla	gso_dmawnz_ns
	movi	-pandown,a0
	move	a0,*a8(oyvel),l		; pan down speed
	pull	a0
*
* check for special case
*
	sll	5,a0
	addi	ochar_order_mugs,a0
	move	*a0,a5,l
	push	a8
	calla	gso_dmawnz_ns
	movi	-pandown,a0
	move	a0,*a8(oyvel),l		; pan down speed

	move	a8,a0
	calla	insobj_v		; mug shots go on back list

	move	a8,a1
	pull	a8
	move	a1,*a8(oslink),l	; sup link to mugshots !!
	pull	a7
	rets

;***********************************************************************

mhe_ladder_order
	.long	medium_1st
	.long	hard_1st
	.long	easy_1st

medium_1st
	.long	baklst3		; med
	.word	0
	.long	med_to_hard
	.long	objlst		; hard
	.word	-2
	.long	hard_to_easy
	.long	baklst5		; easy
	.word	2

hard_1st
	.long	objlst		; hard
	.word	0
	.long	hard_to_med
	.long	baklst3		; med
	.word	2
	.long	hard_to_easy
	.long	baklst5		; easy
	.word	4

easy_1st
	.long	baklst5		; easy
	.word	0
	.long	easy_to_hard
	.long	objlst		; hard
	.word	-4
	.long	hard_to_med
	.long	baklst3		; med
	.word	-2

easy_to_hard
hard_to_med
	move	@ladder_x,a2,l
	sra	16,a2
	sub	a3,a2
	rets

med_to_hard
hard_to_easy
	move	@ladder_x,a2,l
	sra	16,a2
	add	a3,a2
	rets

mhe_x_vels
	.long	020000H
	.long	0
	.long	-020000H

mhe_y_vels
	.long	-010000H
	.long	0
	.long	-020000H

;*************************************************************************

txt_ladder
	.string	"CHOOSE YOUR DESTINY",0
	.even

set_match_1_diff
	move	@ladder_order,a0,w
	cmpi	2,a0
	jrls	smd3
    	movk	2,a0
smd3	sll	4,a0
	addi	mhe_match_1_diffs,a0
	move	*a0,a0,w
	move	a0,@diff,w
	rets

mhe_match_1_diffs
	.word	0,3,0

**************************************************************************
*											     *
*  init_map_start - Initialize the map start pointer !!!			     *
*											     *
**************************************************************************
init_map_start
	move	@ladder_base,a0,l
	jrne	ims3
	movi	map_1,a0		; safety net !!
ims3
	move	a11,a1
;	move	@ladder_order,a1,w

	jreq	diff_is_med
	cmpi	1,a1
	jreq	diff_is_hard
	jruc	diff_is_easy

diff_is_hard
	addi	16*entries_med,a0
	addk	16,a0			; skip the "-1"
diff_is_med
	addi	16*entries_easy,a0
	addk	16,a0			; skip the "-1"
diff_is_easy
	move	a0,@map_start,l
	rets

rom_maps_tbl
	.long	map_1
	.long	map_2
	.long	map_3
	.long	map_4
	.long	map_5
	.long	map_6

map_1
	.word	ft_jax
	.word	ft_tusk
	.word	ft_indian
	.word	ft_lao
	.word	ft_kano
	.word	ft_sonya
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* medium
*
	.word	ft_sg
	.word	ft_indian
	.word	ft_subzero
	.word	ft_lk
	.word	ft_tusk
	.word	ft_st
	.word	ft_kano
	.word	ft_sonya
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* hard
*
	.word	ft_st
	.word	ft_lk
	.word	ft_tusk
	.word	ft_robo2
	.word	ft_lia
	.word	ft_kano
	.word	ft_lao
	.word	ft_robo1
	.word	ft_subzero
	.word	ft_sg
	.word	ft_motaro	; hard
	.word	ft_sk
	.word	sp_end


map_2
	.word	ft_sonya
	.word	ft_jax
	.word	ft_indian
	.word	ft_tusk
	.word	ft_lao
	.word	ft_kano
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* medium
*
	.word	ft_indian
	.word	ft_sg
	.word	ft_subzero
	.word	ft_kano
	.word	ft_tusk
	.word	ft_lk
	.word	ft_st
	.word	ft_sonya
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* hard
*
	.word	ft_st
	.word	ft_sg
	.word	ft_lk
	.word	ft_tusk
	.word	ft_robo2
	.word	ft_lia
	.word	ft_lao
	.word	ft_robo1
	.word	ft_kano
	.word	ft_subzero
	.word	ft_motaro	; hard
	.word	ft_sk
	.word	sp_end


map_3
	.word	ft_indian
	.word	ft_tusk
	.word	ft_sonya
	.word	ft_jax
	.word	ft_kano
	.word	ft_subzero
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* medium
*
	.word	ft_swat
	.word	ft_subzero
	.word	ft_indian
	.word	ft_sg
	.word	ft_st
	.word	ft_lk
	.word	ft_jax
	.word	ft_sonya
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* hard
*
	.word	ft_st
	.word	ft_lk
	.word	ft_sg
	.word	ft_tusk
	.word	ft_lao
	.word	ft_robo2
	.word	ft_lia
	.word	ft_robo1
	.word	ft_subzero
	.word	ft_kano
	.word	ft_motaro	; hard
	.word	ft_sk
	.word	sp_end


map_4
	.word	ft_kano
	.word	ft_sonya
	.word	ft_jax
	.word	ft_sg
	.word	ft_swat
	.word	ft_subzero
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* medium
*
	.word	ft_lao
	.word	ft_kano
	.word	ft_jax
	.word	ft_robo2
	.word	ft_robo1
	.word	ft_sg
	.word	ft_lia
	.word	ft_sonya
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* hard
*
	.word	ft_sonya
	.word	ft_sg
	.word	ft_lia
	.word	ft_indian
	.word	ft_subzero
	.word	ft_swat
	.word	ft_jax
	.word	ft_lk
	.word	ft_tusk
	.word	ft_st
	.word	ft_motaro	; hard
	.word	ft_sk
	.word	sp_end

;******************************************

map_5
	.word	ft_lk
	.word	ft_st
	.word	ft_sg
	.word	ft_tusk
	.word	ft_lao
	.word	ft_robo2
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* medium
*
	.word	ft_lia
	.word	ft_robo2
	.word	ft_lao
	.word	ft_tusk
	.word	ft_sg
	.word	ft_st
	.word	ft_lk
	.word	ft_sonya
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* hard
*
	.word	ft_sg
	.word	ft_lk
	.word	ft_st
	.word	ft_lao
	.word	ft_sonya
	.word	ft_swat
	.word	ft_robo1
	.word	ft_st
	.word	ft_tusk
	.word	ft_lia
	.word	ft_motaro	; hard
	.word	ft_sk
	.word	sp_end

;*************************************

map_6
	.word	ft_lia
	.word	ft_robo2
	.word	ft_jax
	.word	ft_indian
	.word	ft_sonya
	.word	ft_kano
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* medium
*
	.word	ft_sonya
	.word	ft_lao
	.word	ft_tusk
	.word	ft_robo2
	.word	ft_jax
	.word	ft_sg
	.word	ft_st
	.word	ft_kano
	.word	ft_motaro
	.word	ft_sk
	.word	sp_end
*
* hard
*
	.word	ft_kano
	.word	ft_sonya
	.word	ft_subzero
	.word	ft_indian
	.word	ft_jax
	.word	ft_swat
	.word	ft_robo1
	.word	ft_sg
	.word	ft_tusk
	.word	ft_lia
	.word	ft_motaro	; hard
	.word	ft_sk
	.word	sp_end

;******************************************************
;******************************************************
;******************************************************

;	.word	ft_motaro
;	.word	ft_noob
;	.word	ft_smoke
;	.word	ft_endur2a
;	.word	ft_endur3a
;	.word	ft_sk
;	.word	ft_endur2b
;	.word	ft_endur2c
;	.word	ft_endur2d
;	.word	ft_endur2e


	.end
