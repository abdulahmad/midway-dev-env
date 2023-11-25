**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: projectile throwing moves								*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	"mkzap.asm"
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
*  do_zap - All purpose ZAP routine. Call with:					     *
* 											     *
*  a0 = offset into table of routines							     *
* 											     *
*  Call with JSRP									     *
*											     *
**************************************************************************
do_zap
	sll	5,a0
	addi	projectile_jumps,a0
	move	*a0,a0,l
	jump	a0

projectile_jumps
	.long	do_kano_zap		; 0
	.long	do_sonya_zap		; 1
	.long	do_jax_zap1		; 2
	.long	do_jax_zap2		; 3
	.long	do_ind_zap		; 4
	.long	do_sky_ice_on		; 5
	.long	do_sky_ice_behind	; 6
	.long	do_sky_ice_front	; 7
	.long	do_sw_zap		; 8
	.long	do_robo_zap		; 9
	.long	do_robo_zap2		; a
	.long	do_robo_net		; b
	.long	do_sz_zap		; c
	.long	do_lia_anglez		; d
	.long	do_lao_zap		; e
	.long	do_robo_bomb		; f
	.long	do_bomb_mid		; 10
	.long	do_tusk_zap		; 11
	.long	do_summon		; 12
	.long	do_st_zap1		; 13
	.long	do_st_zap2		; 14
	.long	do_st_zap3		; 15
	.long	lk_zap_hi		; 16
	.long	lk_zap_lo		; 17
	.long	do_sg_zap		; 18
	.long	do_swat_bomb_hi		; 19
	.long	do_swat_bomb_lo		; 1a
	.long	do_lia_forward_zap	; 1b
	.long	do_tusk_floor		; 1c
	.long	do_sk_zap		; 1d
	.long	do_smoke_spear		; 1e
	.long	do_motaro_zap		; 1f

;***********************************************************************

do_motaro_zap
	clr 	a10
	callr	zap_init_special

	movk	6,a9
	calla	get_char_ani
	movk	4,a0
	jsrp	mframew
	sleep	4

	push	a9
	calla	find_part2
	movk	5,a0
	callr	local_ochar_sound	; photon fire
	movi	motaro_zap_proc,a7
	callr	create_proj_proc
	pull	a9

	movk	5,a0
	jsrp	mframew
	jauc	reaction_exit


motaro_zap_proc
	movk	3,a1			; anirate
	movi	0a0000H,a0
	callr	set_proj_vel
	movk	3,a11
	movi	mot_zap_call,a6
	jsrp	projectile_flight_call

	movi	000H,a11	     		; y:x adjust
	callr	make_lineup_explode
;	clr	a0
;	callr	local_ochar_sound
	jruc	delete_proj_and_die

mot_zap_call
	move	*a8(oyvel),a0,l
	addi	05000H,a0
	move	a0,*a8(oyvel),l
	rets

;***********************************************************************

do_smoke_spear
	clr 	a10
	movi	act_spear,a1
	callr	zap_init_special_act

	movi	00bH,a0
	callr	local_ochar_sound
	clr	a9
	calla	get_char_ani2
	movk	3,a0
	jsrp	mframew

;	movi	l_spear,a0
;	calla	update_tsl

	movi	019H,a0
	calla	ochar_sound

	movk	00cH,a9
	calla	get_char_ani2
	callr	get_proj_obj_m		; get an object spear projectile

;	move	*a10(oflags),a4,w
;	ori	dmaclp,a4
;	move	a4,*a10(oflags),w 	; set the "register clip bit"
;	move	a10,a0
;	callr	set_rope_clip

	move	a10,a5
	movi	-0120H,a0
	movi	028H,a1
	calla	adjust_xy_a5		; adjust to smoke's chest
	move	a10,a0
	calla	insobj			; put on object list

	movi	spear_proc,a7
	callr	create_proj_proc
	move	a13,*a0(p_store5),l	; pass smoke proc
	move	a8,*a0(p_store6),l	; pass smoke obj
	sleep	018H

waiting_for_spear2
	movi	act_proj_sd,a0		; dont change this to use
	move	a0,*a13(p_action),w	; "do_proj_sitting_duck" !!!!
	sleep	018H			; this long before i give up !

waiting_for_spear
	clr	a1
	move	a1,*a13(p_action),w	; i am not doing anything anymore
	retp

spear_proc
;	tsound	064H			; spear throw sound

	movk	4,a1			; anirate
	movi	0a0000H,a0
	callr	set_proj_vel

;	move	a0,*a13(p_store3),l	; store "velocity" here
;	calla	stop_a8			; we gonna havta do dis one by hand !!

	movk	015H,a11
	move	a11,a0
	callr	tell_world_stk

spr3	sleep	1
	calla	next_anirate
	callr	proj_onscreen_test
	jrnc	delete_proj_and_die	; offscreen = delete

;	callr	spear_clip

	move	a11,a0
	callr	tell_world_stk

;	move	*a13(p_store4),a6,w
;	move	*a8(oxpos),a5,w
;	sub	a6,a5
;	move	a5,*a8(oxpos),w		; adjust for what "spear_clip" did
	callr	proj_strike_check

;	pushst
;	move	*a13(p_store4),a6,w
;	move	*a8(oxpos),a5,w
;	add	a6,a5
;	move	a5,*a8(oxpos),w		; adjust for what "spear_clip" did
;	popst

	jrnc	spr3

	jruc	spear_hit

;*************************
;	move	a8,a0
;	callr	set_rope_clip
;	move	*a8(oflags),a4,w
;	btst	b_fliph,a4
;	jrne	spear4
;	calla	rightmost_mpart		; a3 = rightmost
;	move	*a13(p_store2),a0,l
;	move	*a0(oxpos),a0,w	   	; a0 = scorpion's x pos
;	sub	a0,a3
;	abs	a3   			; a3 = amount showing
;	movi	304,a1			; full length of rope
;	sub	a3,a1			; a1 = amount to clip
;	move	a1,*a8(ofset),w
;	move	*a8(oxpos),a0,w
;	add	a1,a0
;	move	a0,*a8(oxpos),w
;spear4
;*************************


spear_hit
	callr	dead_projectile

	calla	stop_a8
	move	*a13(p_store5),a0,l	; dude who threw me proc
	move	*a0(pwake),a1,l

	cmpi	waiting_for_spear2,a1	; is he still waiting for me ?
	jreq	sphit4				; no, act like i was blocked
	cmpi	waiting_for_spear,a1		; is he still waiting for me ?
	jrne	spear_cancelled			; no, act like i was blocked

sphit4	move	b2,b2				; blocked ??
	jrne	spear_blocked			; yes ---> skip the drag part

	movi	do_rope_pull,a7
	calla	fastxfer		; xfer scorpion ---> pull in otherguy
	move	a8,*a0(pa10),l		; pass a10 = spear proc
	move	a8,*a0(p_slave),l	; rope = your responsibility

;	tsound	065H			; spear hit
	die

spear_cancelled
	movi	r_null_speared,a7
	calla	takeover_him

spear_blocked
;	tsound	066H			; spear blocked

	movi	00e0eH,a0
	move	a0,*a8(oconst),w	; constant color to flash with
	move	*a8(oflags),a9,w	; a9 = normal flags
	move	a9,a10
	andi	0fff0H,a10
	ori	dmacnz,a10		; a10 = "white" flags

	movk	3,a11
spblk6	move	a10,a0
	jsrp	stuff_rope_flags
	move	a9,a0
	jsrp	stuff_rope_flags
	dsjs	a11,spblk6
	jruc	delete_proj_and_die	; offscreen = delete

stuff_rope_flags
	move	a0,*a8(oflags),w
	move	*a8(oimg),a2,l
	move	a0,*a2(mp_control),w	; 
	sleep	3
	retp

*
* a10 = rope obj
*
do_rope_pull
	movi	act_rope_pull,a1
	move	a1,*a13(p_action),w		; define my action

	push	a8
	movk	00cH,a9
	calla	get_char_ani2
	calla	find_part2			; a9 ---> tight rope frame
	move	a10,a8
	calla	do_next_a9_frame
	pull	a8

;	clr	a9
;	calla	get_char_ani2
;	calla	find_part2
;	calla	do_next_a9_frame

	movi	01eH,a0
	calla	pose_him_a0			; him --> 1st frame of knocked down
	move	*a13(p_otherguy),a11,l	; a11 = him

;	movk	4,a0
;	calla	create_blood_proc

	push	a10
	calla	stop_him
	calla	ground_him
	pull	a10

;	move	*a10(oflags),a4,w
;	ori	dmaclp,a4
;	move	a4,*a10(oflags),w		; set the "register clip bit"

	callr	lineup_rope_with_him

	movi	back_z-1,a0
	move	a0,*a11(ozval),l
	movi	back_z,a0
	move	a0,*a10(ozval),l
	callr	proj_in_front
	
	move	*a13(p_otherproc),a0,l
	movi	act_speared_sd,a1
	move	a1,*a0(p_action),w		; define his new action

	movk	6,a9
pull4	movi	-2,a1
	jsrp	double_shaker
	movk	2,a1
	jsrp	double_shaker			; shake it up !!
	dsj	a9,pull4

;	clr	a9
;	calla	get_char_ani2
;	calla	find_part2
;	calla	do_next_a9_frame
;	sleep	4				; do frame before starting him in

	movi	tugged_in_by_spear,a7
	calla	xfer_otherguy			; start him moving towards me

;	movi	00002007dH,a0			; [total # of entries, 1st entry]
;	calla	random_triple			; get over here / come here

	sleep	2				; time for him to start
pull5	sleep	1
	callr	lineup_rope_with_him
	move	*a11(oxvel),a0,l		; he still moving ?
	jrne	pull5				; yes, loop

	calla	delete_slave
	jsrp	robo_close_chest
	jauc	reaction_exit


lineup_rope_with_him
	push	a8
	move	a10,a8			; a8 = rope (trick the routine)
	move	*a10(oypos),a7,w
	push	a7
	calla	match_me_with_him
	pull	a7
	move	a7,*a10(oypos),w 	; dont mess with y pos
	calla	flip_multi

	movi	spear_adjustments,a0
	calla	get_his_char_word
	neg	a0
	clr	a1
	calla	multi_adjust_xy
	pull	a8
	
	move	a10,a0
	callr	set_rope_clip
*
* clip rope
*
	push	a10
	calla	get_x_dist	    	; a3 = x distance
	pull	a10

	movi	0135H,a0			; about length of rope !!
	sub	a3,a0
	abs	a0			; clip value
	move	a0,*a10(ofset),w

	move	*a10(oflags),a4,w
	btst	b_fliph,a4
	jreq	lrwh8
	neg	a0			; reverse adjustments for flip
lrwh8	move	*a10(oxpos),a1,w
	add	a0,a1
	move	a1,*a10(oxpos),w
	rets


double_shaker
	push	a8
	move	a10,a8
	clr	a0			; no x movement
	calla	multi_adjust_xy		; shake him
	move	a11,a8
	calla	multi_adjust_xy		; shake rope
	pull	a8
	sleep	2
	retp


set_rope_clip
	move	*a0(oimg),a2,l		; a2 = spear multipart ram
	move	*a2(mp_control),a4,w
	ori	dmaclp,a4
	move	a4,*a2(mp_control),w	; set the "udlr clip" bit in spear
	rets


spear_adjustments
	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H

	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H

	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H

	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H
	.word	0130H




tugged_in_by_spear
	movi	080000H,a0
	calla	towards_x_vel			; whoa, shit !!!
	calla	set_no_block		; I cant block

papa4	sleep	1
	calla	get_x_dist
	cmpi	040H,a3
	jrhi	papa4

	movi	act_speared_sd,a0
	move	a0,*a13(p_action),w

	calla	stop_me
	movi	025H,a9
	calla	pose_a9			; dizzy frames
	movk	8,a0
	calla	init_anirate

	movi	8*8,a11
papa6	sleep	1
	calla	next_anirate
	calla	is_he_airborn		; cheapo ----> get out of this !!
	jac	reaction_exit
	dsjs	a11,papa6
	jauc	reaction_exit


spear_clip
	calla	rightmost_mpart		; a3 = rightmost
	move	*a13(p_store6),a0,l
	move	*a0(oxpos),a0,w		; a0 = smoke's x pos
	sub	a0,a3
	abs	a3			; a3 = distance from smoke
	movi	0135H,a0			; about length of rope !!
	sub	a3,a0

;	push	a10
;	calla	get_x_dist	    	; a3 = x distance
;	pull	a10
;	movi	0135H,a0			; about length of rope !!
;	sub	a3,a0
;	abs	a0			; clip value
	move	a0,*a10(ofset),w

	move	*a10(oflags),a4,w
	btst	b_fliph,a4
	jreq	sclp3
	neg	a0			; reverse adjustments for flip

sclp3	move	a0,*a13(p_store4),w	; save clip amount here
	move	*a10(oxpos),a1,w
	add	a0,a1
	move	a1,*a10(oxpos),w
	rets

;***********************************************************************

do_sk_zap
	clr 	a10
	callr	zap_init_special

	movi	000030024H,a9
	jsrp	animate_a9		; lean forward
	move	a9,a11
	
	movk	1,a0
	calla	ochar_sound		; fire sound

	movi	017H,a9
	calla	get_char_ani
	callr	get_proj_obj_m
	move	a10,a0
	calla	insobj
	move	a10,a5
	movi	-014H,a0
	movi	-6,a1
	calla	adjust_xy_a5		; position at kahn's face

	movi	sk_zap_proc,a7
	callr	create_proj_proc

	sleep	010H
	move	a11,a9
	movk	4,a0
	jsrp	mframew			; straighten back up...
	retp


sk_zap_proc
	movk	3,a1			; anirate
	movi	0a0000H,a0
	callr	set_proj_vel
	movk	4,a11
	jsrp	projectile_flight

	move	*a8(oxpos),a7,w
	movi	060H,a0
	clr	a1
	calla	multi_adjust_xy
 	move	*a8(oxpos),a10,w
	move	a7,*a8(oxpos),w

 	move	*a8(oypos),a11,w
	addi	040H,a11
	movk	5,a0
	calla	create_fx				; exlosion effect
	jruc	delete_proj_and_die

;***********************************************************************

do_tusk_floor
	movi	act_floor_blade,a1
	calla	init_special_act
	movk	6,a0
	callr	local_ochar_sound

	movi	000040003H,a9
	jsrp	animate2_a9

	sleep	8

	move	*a13(p_slave),a10,l
	mmtm	sp,a9,a10
	clr	a0
	move	a0,*a13(p_slave),l
	movk	2,a9
	calla	get_char_ani2			; grab an object for blade
	callr	get_proj_obj_m
	movi	blade_proc,a7
	callr	create_proj_proc		; blade proc
	mmfm	sp,a9,a10
	move	a10,*a13(p_slave),l

	sleep	018H

	movk	3,a0
	jauc	mframew


blade_proc
	movi	pid_blade,a0
	move	a0,*a13(procid),w

	move	@ground_y,a1,w
	move	a1,*a8(oypos),w		; place the blade on the ground

	calla	flip_multi
	move	@worldtlx+16,a0,w
	addi	scrrgt/2,a0
	move	a0,*a8(oxpos),w
	clr	a1
	movi	-0c0H,a0
	calla	multi_adjust_xy
	calla	insobja8

	movk	2,a9
	calla	get_char_ani2
	movk	2,a1			; ani rate
	movi	080000H,a0
	calla	set_proj_vel		; start moving

	movk	5,a0
	callr	local_ochar_sound	; saw sound

	movi	010H,a10
blade5	sleep	1
	callr	saw_strike_check
	calla	next_anirate		; offscreen = ok here !!
	dsjs	a10,blade5

blade7	sleep	1
	callr	saw_strike_check
	callr	proj_onscreen_test	; onscreen ?
	jrnc	delete_proj_and_die
	calla	next_anirate
	jruc	blade7

saw_strike_check
	pull	a11
	calla	q_is_he_a_boss
	jrc	saws7
	movi	013H,a0
	calla	strike_check_a0
	jrc	saw_hit
saws7	jump	a11


saw_hit
	movi	pid_dead_blade,a0
	move	a0,*a13(procid),w

	movk	5,a0
	callr	local_ochar_sound	; saw sound
	calla	stop_a8

	move	*a8(oypos),a6,w
	push	a6
	move	*a13(p_otherguy),a1,l
	move	a8,a0
	calla	lineup_a0_onto_a1
	clr	a1
	movi	000H,a0
	calla	multi_adjust_xy		; right under him
	pull	a6
	move	a6,*a8(oypos),w

sawh5	sleep	1
	calla	next_anirate
	calla	q_is_he_reacting
	jrc	sawh5

	movi	0100000H,a0
	calla	set_proj_vel		; start moving
sawh3	sleep	1
	calla	next_anirate
	callr	proj_onscreen_test	; onscreen ?
	jrc	sawh3
	jrnc	delete_proj_and_die

;***********************************************************************

do_lia_forward_zap
	clr 	a10
	movi	act_lia_forward,a1
	callr	zap_init_special_act

	movk	2,a0
	callr	local_ochar_sound		; lia fireball sound

	clr	a11
	movi	000030024H,a9		; normal speed
	calla	get_his_action
	cmpi	act_react_flipk,a1
	jrne	lfz4

	movk	1,a11			; 1 = fast version
	movi	000010024H,a9		; fast speed

lfz4	jsrp	animate_a9		; lean forward !!

	movi	024H,a9
	calla	find_ani_part2
	callr	get_proj_obj_m
	movi	lia_forward_proc,a7
	callr	create_proj_proc

	movi	080000H,a1		; normal speed proj
	move	a11,a11
	jreq	lfz5
	movi	0a0000H,a1		; fast speed proj
lfz5	move	a1,*a0(pa11),l

	movi	act_proj_sd,a0
	move	a0,*a13(p_action),w	; I am a sitting duck
	sleep	020H

	movi	024H,a9
	movk	4,a0
	jauc	backwards_ani


lia_forward_proc
	movi	008H,a0
	movi	020H,a1
	calla	multi_adjust_xy
	calla	insobja8

	movi	000030001H,a0
	cmpi	080000H,a11
	jreq	lfp1
	movi	000010001H,a0		; fast fireball = fast animation
lfp1	jsrp	animate_a0_frames

	movi	00006004bH,a1
	movi	000130028H,a2
	movi	015H,a0
	callr	local_strike_check_box
	jrc	lia_forward_hit

	movk	4,a0
	calla	init_anirate
	move	a11,a0
	callr	set_proj_vel
	movi	015H,a11
	jsrp	projectile_flight

lia_forward_hit
	movk	3,a0   			; hit sound
	callr	local_ochar_sound

	move	*a13(p_otherguy),a1,l
	move	a8,a0
	calla	lineup_a0_onto_a1
	calla	flip_multi
	movi	-080H,a0
	movi	000H,a1
	calla	multi_adjust_xy
	move	@ground_y,a0,w
	subi	0e0H,a0
	move	a0,*a8(oypos),w 	; ground y
	
	movi	000040008H,a11
	calla	shake_a11
	calla	stop_a8
	movi	037H,a9
	calla	find_ani_part2
	addi	32*3,a9			; just the explode part !!
	movk	2,a0
	jsrp	mframew			; Ed BOOM again !!
	jruc	delete_proj_and_die

;***********************************************************************

do_sz_zap
	clr 	a10
	movi	act_forward_ice,a1
	callr	zap_init_special_act

	clr 	a0
	callr	local_ochar_sound

	movi	000030024H,a9		; sleep : ani offset
	jsrp	animate_a9

	movi	030H,a0
	movi	038H,a1
	move	*a13(p_slave),a5,l
	calla	adjust_xy_a5		; adjust ice to sz hands

	movi	0002d0060H,a1
	movi	000100028H,a2
	callr	ice_collision_check
	movi	0002d0060H,a1
	movi	000100028H,a2
	callr	ice_collision_check
	movi	0002d0088H,a1
	movi	000100050H,a2
	callr	ice_collision_check
	movi	0002d00a4H,a1
	movi	00010006cH,a2
	callr	ice_collision_check
	movi	0002d00b5H,a1
	movi	000100066H,a2
	callr	ice_collision_check

	movi	sz_zap_proc,a7
	callr	create_proj_proc

sz_post_zap
	sleep	010H

	movi	024H,a9
	movk	4,a14
	calla	find_ani_part_a14
	movk	4,a0
	jauc	mframew


ice_collision_check
	pull	a11
	push	a8
	move	a10,a8
	mmtm	sp,a1,a2
	calla	do_next_a9_frame
	mmfm	sp,a1,a2
	pull	a8
	movi	013H,a0
	callr	local_strike_check_box
	jrc	sz_prezap_hit
	sleep	3
	jump	a11


sz_prezap_hit
	movi	000040003H,a0
	calla	hob_ochar_sound

	movi	sz_zap_hit,a7
	callr	create_proj_proc
	jruc	sz_post_zap


sz_zap_proc
	movk	4,a0
	calla	init_anirate
	movi	0a0000H,a0
	callr	set_proj_vel
	movi	013H,a11
	jsrp	projectile_flight

sz_zap_hit
	movi	000040003H,a0
	calla	hob_ochar_sound

	callr	dead_projectile
	calla	stop_a8

	move	*a8(oypos),a7,w		; dont change y
	push	a7
	calla	match_me_with_him
	calla	flip_multi
	clr	a1
	movi	-090H,a0
	calla	multi_adjust_xy
	pull	a7
	move	a7,*a8(oypos),w		; lineup with dude we froze

	movi	024H,a9
	movk	3,a14
	calla	find_ani_part_a14	; ice hit ani

	movk	4,a0
	jsrp	mframew
	jruc	delete_proj_and_die	; offscreen = delete

;***********************************************************************

do_swat_bomb_lo
	clr 	a10
	movi	act_swat_bomb_lo,a1
	callr	zap_init_special_act
	clr	a11			; flag: low
	jruc	bomb33

do_swat_bomb_hi
	clr 	a10
	movi	act_swat_bomb_hi,a1
	callr	zap_init_special_act
	movk	1,a11			; flag: hi

bomb33	clr	a9
	calla	get_char_ani2
	movi	000030003H,a0
	jsrp	animate_a0_frames

	clr	a0
	calla	group_sound		; haya !!
	movk	1,a0
	callr	local_ochar_sound

	push	a9
	clr	a9
	calla	find_ani2_part2
	callr	get_proj_obj_m

	movi	020H,a0
	movi	020H,a1
	move	a10,a5
	calla	adjust_xy_a5		; lineup
	move	a10,a0
	calla	insobj
	pull	a9

	movi	swat_bomb_proc,a7
	callr	create_proj_proc

	callr	i_am_a_sitting_duck

	movk	4,a0
	jsrp	mframew			; finish animation !!
	sleep	010H

	clr	a9
	movk	3,a0
	jauc	backwards_ani2


swat_bomb_proc
	clr	a9
	calla	find_ani2_part2

	movi	-030000H,a0
	move	a11,a11
	jreq	bomb_lo
	movi	-060000H,a0
bomb_lo	move	a0,*a8(oyvel),l
	movi	080000H,a0
	movk	4,a1	      		; animation speed
	callr	set_proj_vel
	movi	010H,a11
	movi	bomb_call,a6
	jsrp	projectile_flight_call

	movi	000H,a11	     		; y:x adjust
	callr	make_lineup_explode

	clr	a0
	callr	local_ochar_sound

	jruc	delete_proj_and_die

bomb_call
	move	*a8(oyvel),a0,l
	addi	06000H,a0
	move	a0,*a8(oyvel),l		; gravity on hat
	rets

*
* a11 = y:x ani adjust
*
make_lineup_explode
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	makel3

	move	a11,a0
	sext	a0,w
	neg	a0
	zext	a0,w
	movx	a0,a11

makel3	move	*a8(oxpos),a10,w
	move	*a8(oypos),a0,w
	sll	16,a0
	or	a0,a10			; a10 = y:x pos to start at
	movi	010H,a0	
	jauc	create_fx		; lineup explode !!

;***********************************************************************

do_sg_zap
	clr 	a10
	movi	act_sg_zap,a1
	callr	zap_init_special_act

	movk	4,a0
	callr	local_ochar_sound		; sg prezap sound

	movi	024H,a9
	calla	get_char_ani
	movk	2,a0
	jsrp	mframew

	movk	3,a0
	callr	local_ochar_sound
	movi	sg_zap_proc,a7
	callr	create_proj_proc

	calla	do_next_a9_frame

;	movi	020H,a1			    	; sleep time
	movi	02aH,a1			    	; sleep time
	jauc	do_proj_sitting_duck		; sit there


sg_zap_proc
	calla	set_inviso

	movi	a_small_explode,a9
	move	*a9,a5,l
	move	*a5(icmap),a0,l
	calla	swpal

	movi	act_sg_zap,a0
	move	a0,*a13(p_action),w

	movi	030H,a0
	movi	030H,a1
	calla	multi_adjust_xy			; back down !!

	movk	4,a0
	move	a0,*a13(p_store2),w
	movi	0a0000H,a0
	movi	never_ani,a1			; animation speed
	callr	set_proj_vel
	movi	011H,a11
	movi	sg_trail_spawn,a6
	jsrp	projectile_flight_call
	jruc	delete_proj_and_die


sg_trail_spawn
	move	*a13(p_store2),a0,w
	dsjs	a0,stsp3
	create	pid_poof,sg_zap_trail
	movk	4,a0
stsp3	move	a0,*a13(p_store2),w
	rets

sg_zap_trail
	move	a8,a11
	move	*a9,a5,l
	calla	gso_dmawnz
	move	a11,a1
	move	a8,a0
	calla	lineup_1pwm
	movk	1,a0
	move	a0,*a8(ozpos),w
	calla	insobja8
	calla	frame_a9
	sleep	2
	clr	a0
	move	a0,*a8(ozpos),w
	movk	2,a0
	jsrp	framew
	move	a8,a0
	calla	delobjp
	jruc	local_die

;***********************************************************************

zap_air_init_special
	calla	air_init_special
	jruc	zinit3

zap_init_special_act
	calla	init_special_act
	jruc	zinit3

zap_init_special
	calla	init_special

zinit3	move	a10,a10			; flippped ??
	jreq	zinit4			; no
	calla	flip_multi
zinit4	rets

;************************************************************************

lk_zap_air
	clr 	a10
	callr	zap_air_init_special
	movi	act_lk_zap_air,a1
	move	a1,*a13(p_action),w

	clr	a0
	callr	local_ochar_sound

	movk	1,a9
	calla	get_char_ani2
	movk	2,a0
	jsrp	mframew			; fire ani
	jruc	lk_zap_entry


lk_zap_lo
	calla	am_i_airborn
	jrc	lk_zap_air

	clr 	a10
	movi	act_lk_zap_lo,a1
	callr	zap_init_special_act
	clr	a0
	callr	local_ochar_sound

	movi	000040000H,a9
	jsrp	animate2_a9
	jruc	lk_zap_entry

lk_zap_hi
	calla	am_i_airborn
	jrc	lk_zap_air

	clr 	a10
	movi	act_lk_zap_hi,a1
	callr	zap_init_special_act
	clr	a0
	callr	local_ochar_sound

	movi	000040024H,a9
	jsrp	animate_a9

lk_zap_entry
	movi	000090039H,a1
	movi	000200029H,a2
	movi	011H,a0

	push	a8
	move	*a13(p_slave),a8,l
	callr	local_strike_check_box
	pull	a8
	jrc	lk_prezap_hit

	movi	0000e0080H,a1
	movi	000130071H,a2
	callr	lk_prezap
	movi	0001000a4H,a1
	movi	00013005fH,a2
	callr	lk_prezap
	movi	0001000d0H,a1
	movi	000130071H,a2
	callr	lk_prezap

	movi	lk_zap_proc,a7
	callr	create_proj_proc

lkzap5	calla	am_i_airborn
	jrc	post_air

	callr	i_am_a_sitting_duck

	calla	am_i_short
	jrc	lkzap_short

	sleep	010H
	movi	024H,a9
	movk	3,a14
	calla	find_ani_part_a14
	movk	4,a0
	jauc	mframew

lkzap_short
	sleep	018H
	clr	a9
	calla	get_char_ani2
	movk	3,a14
	calla	find_part_a14
	movk	4,a0
	jauc	mframew

post_air
	movk	1,a9
	calla	get_char_ani2
	movk	3,a14
	calla	find_part_a14
	movk	2,a0
	jsrp	mframew
	jauc	drop_down_land


lk_zap_proc
	movi	080000H,a0
	movk	4,a1				; animation speed
	callr	set_proj_vel
	movi	011H,a11
	jsrp	projectile_flight

	movi	000010003H,a0
	calla	hob_ochar_sound			; fireball hit or blocked

	callr	make_dragon_explode
	jruc	delete_proj_and_die

lk_prezap
	pull	a11
	mmtm	a12,a1,a2
	calla	do_next_a9_frame
	sleep	4
	mmfm	a12,a1,a2
	push	a8
	move	*a13(p_slave),a8,l
	movi	011H,a0
	callr	local_strike_check_box
	pull	a8
	jrc	lk_prezap_hit
	jump	a11

lk_prezap_hit
	push	a8
	move	a10,a8
	callr	make_dragon_explode
	pull	a8
	calla	delete_slave
	jruc	lkzap5

make_dragon_explode
	movk	1,a0
	callr	local_ochar_sound

	calla	rightmost_mpart
	calla	leftmost_mpart
	sub	a2,a3
	abs	a3			; x distance of proj
	movi	000100000H,a11
	add	a3,a11
	callr	make_lineup_explode
	rets

;************************************************************************

do_st_zap1
	movk	1,a11
	movi	act_st_zap1,a1
	jruc	stz1

do_st_zap2
	movk	2,a11
	movi	act_st_zap2,a1
	jruc	stz1
 
do_st_zap3
	movk	3,a11
	movi	act_st_zap3,a1
stz1	clr 	a10
	callr	zap_init_special_act

	clr	a10
	jsrp	st_zap_jsrp
	dec	a11
	jreq	stz2
	sleep	8

	movi	32*3,a10
	jsrp	st_zap_jsrp
	dec	a11
	jreq	stz2

	sleep	8
	movi	32*3,a10
	jsrp	st_zap_jsrp
	sleep	8

stz2	callr	i_am_a_sitting_duck
	sleep	008H

	movi	024H,a9
	calla	get_char_ani
	addi	32,a9
	calla	do_next_a9_frame
	sleep	4
	subi	32*2,a9
	calla	do_next_a9_frame
	sleep	4
	retp


st_zap_jsrp
	movk	3,a0	
	callr	local_ochar_sound
	movi	024H,a9
	calla	get_char_ani
	add	a10,a9
	movk	3,a0
	jsrp	mframew			; another one !!
	movi	skull_proc,a7
	callr	create_proj_proc
	retp


skull_proc
	movi	037H,a9
	calla	get_char_ani

	movi	011H,a0
	callr	tell_world_stk

 	move	*a13(p_otherguy),a1,l
	move	*a1(ochar),a1,w
	cmpi	ft_motaro,a1
	jreq	skull3				; motaro = reflect
	calla	get_his_action
	cmpi	act_reflect,a1			; indian reflect ??
	jreq	skull3				; yes, no col check

	movi	000150057H,a1
	movi	000160052H,a2
	movi	011H,a0
	callr	local_strike_check_box
	jrc	pre_skull_hit			; prezap check

skull3	movi	080000H,a0
	movk	4,a1				; animation speed
	callr	set_proj_vel
	movi	011H,a11
	jsrp	projectile_flight

skull_hit
	movi	000230092H,a11
	jruc	skull4

pre_skull_hit
	movi	000230042H,a11
skull4	callr	make_lineup_explode

skull_die
	movi	000020006H,a0			; hit/blocked choices
	calla	hob_ochar_sound
	jruc	delete_proj_and_die

;************************************************************************

do_summon
	clr 	a10
	movi	act_floor_zap,a1
	callr	zap_init_special_act

	movi	000030012H,a9
	jsrp	animate2_a9

	movk	1,a0
	callr	local_ochar_sound

	create	pid_summon,master_summon_proc
	callr	stuff_others_a0

	movk	3,a0
	jsrp	mframew
	sleep	010H
	movk	2,a0
	jauc	mframew


stuff_others_a0
	move	*a13(p_otherguy),*a0(p_otherguy),l
	move	*a13(p_otherproc),*a0(p_otherproc),l
	rets

master_summon_proc
	move	*a8(oxpos),a11,w
	movi	-060H,a10    		; spacing
	movi	scrrgt-070H,a6
	calla	is_he_right
	jrc	sum2
    	neg	a10
    	neg	a6
sum2	add	a6,a11
	jsrp	summon_spawn
	jsrp	summon_spawn
	jsrp	summon_spawn
	die

summon_spawn
	create	pid_summon,summon_proc
	callr	stuff_others_a0
	sleep	012H
	add	a10,a11
	retp

summon_proc
	push	a11
	movi	013H,a9
	calla	get_char_ani2
	move	a9,a11
	callr	get_proj_obj_m
	pull	a11
	move	a11,*a10(oxpos),w

	move	@ground_y,a1,w
	subi	010H,a1
	move	a1,*a10(oypos),w		; on the ground
	calla	insobj
	move	a10,a8

	movk	4,a0
	jsrp	mframew
	create	pid_summon,summon_flame_animator	; let someone else do remainder

	movi	013H,a9
	calla	get_char_ani2
	move	a9,a11
	callr	get_proj_obj_m
	move	a10,a0
	calla	match_ani_points
	calla	insobj
	calla	find_part2
	calla	find_part2
	move	a10,a8

	movi	act_floor_zap,a0
	move	a0,*a13(p_action),w		; define my action for stk !!

*
* flight loop
*
	movi	-080000H,a0
	move	a0,*a8(oyvel),l
	movk	4,a0
	calla	init_anirate
	clr	a0
	move	a0,*a13(p_store1),w

sum5	sleep	1
	move	*a13(p_store1),a0,w
	jrne	sum7
	calla	q_is_he_a_boss
	jrc	sum7				; boss = no hit
	movi	012H,a0
	calla	strike_check_a0
	jrnc	sum7
	movk	1,a0
	move	a0,*a13(p_store1),w		; flag: hit
sum7	calla	next_anirate
	calla	lowest_mpart
	move	@worldtly,a0,w
	cmp	a0,a1
	jrgt	sum5
	jruc	delete_proj_and_die


summon_flame_animator
	movk	ft_st,a0
	move	a0,*a8(ochar),w
	clr	a0
	callr	local_ochar_sound	

	movi	000060006H,a11
	calla	shake_a11

	movk	4,a0
	jsrp	mframew
	jruc	delete_proj_and_die

;************************************************************************

do_tusk_zap
	calla	am_i_airborn
	jrnc	tusk_ground_zap
*
* tusk air zap !!
*
	clr 	a10
	callr	zap_air_init_special
	movi	act_tusk_zap_air,a1
	move	a1,*a13(p_action),w

	movk	1,a0
	callr	local_ochar_sound

	clr	a9
	calla	get_char_ani2
	movk	2,a0
	jsrp	mframew			; fire ani
	callr	setup_proj_obj
	move	a10,a5
	clr	a0
	movi	010H,a1
	calla	adjust_xy_a5
	movi	photon_proc,a7
	callr	create_proj_proc

	movi	060000H,a0
	calla	away_x_vel
	sleep	6			; a lil recoil for effect !!
	movi	040000H,a0
	calla	away_x_vel
	movk	4,a0
	jsrp	mframew
	jauc	drop_down_land


tusk_ground_zap
	clr 	a10
	movi	act_tusk_zap,a1
	callr	zap_init_special_act

	movi	000030024H,a9
	jsrp	animate_a9

	callr	setup_proj_obj
	move	a10,a5
	movi	010H,a0
	movi	037H,a1

	calla	adjust_xy_a5
	movi	photon_proc,a7
	callr	create_proj_proc

	movk	1,a0
	callr	local_ochar_sound
	callr	i_am_a_sitting_duck

	movk	4,a0
	jsrp	mframew
	calla	delete_slave
	movk	5,a0
	jauc	mframew

photon_proc
	movi	037H,a9
	calla	get_char_ani
	movi	0a0000H,a0
	movk	3,a1				; animation speed
	callr	set_proj_vel
	movi	011H,a11
	jsrp	projectile_flight

;	movi	000030004H,a0			; hit/blocked choices
;	calla	hob_ochar_sound

	move	*a8(oxpos),a10,w
 	move	*a8(oypos),a11,w
	movk	5,a0
	calla	create_fx				; exlosion effect
	jruc	delete_proj_and_die

;************************************************************************

do_bomb_mid
	movi	robo_bomb_mid,a11
	jruc	bomb3

do_robo_bomb
	movi	robo_bomb_full,a11

bomb3	clr 	a10
	movi	act_robo_bomb,a1
	callr	zap_init_special_act

	jsrp	robo_open_chest

	clr	a3			; a3 = # of bombs already out there !!
	move	@active,a0,l
bomb5	move	*a0(procid),a1,w
	cmpi	pid_robo_bomb,a1
	jrne	bomb4
	inc	a3
bomb4	move	*a0,a0,l		; next proc
	jrne	bomb5
	cmpi	2,a3			; only 2 allowed at once
	jrhs	bomb_dud		; too many bombs = dud

	mmtm	sp,a9,a11
	movk	4,a9
	calla	get_char_ani2
	move	a9,a11
	callr	get_proj_obj_m
	move	a10,a0
	calla	insobj
	mmfm	sp,a9,a11

	move	a10,a5
	calla	a5_front_plus_1
	move	a10,a5
	movi	000H,a0
	movi	028H,a1
	calla	adjust_xy_a5
	move	a11,a7
	callr	create_proj_proc	; let another proc handle things

bomb_dud
	calla	i_am_a_sitting_duck

	sleep	012H
	jauc	robo_close_chest	; close / retp


robo_bomb_mid
	callr	get_bomb_vel
	sra	1,a0
	jruc	rbomb4

robo_bomb_full
	callr	get_bomb_vel

rbomb4	movi	pid_robo_bomb,a14
	move	a14,*a13(procid),w	; set my id !!

	callr	set_proj_vel

	move	@ground_y,a0,w
	subi	015H,a0
	move	a0,*a13(p_ganiy),w	; set ground position

	movk	3,a0
	calla	init_anirate
	movk	4,a9
	calla	get_char_ani2		; setup for gravity loop
	clr	a1
	move	a1,*a8(oyvel),l
	callr	bomb_gravity

	movi	-050000H,a0
	callr	bomb_gravity2
	movi	-030000H,a0
	callr	bomb_gravity2
	jruc	bgrav9

bomb_gravity2
	move	a0,*a8(oyvel),l		; up again
	move	*a8(oxvel),a0,l
	sra	1,a0
	move	a0,*a8(oxvel),l		; half speed
	sll	1,a11			; = double time

bomb_gravity
	pull	a10
bgrav3	sleep	1
	calla	next_anirate
	dec	a11			; keep track o time
	move	*a8(oyvel),a0,l
	addi	08000H,a0
	move	a0,*a8(oyvel),l		; gravity
	jrn	bgrav3			; heading up ---> dont look at ground
	move	*a8(oypos),a5,w
	move	*a13(p_ganiy),a6,w
	cmp	a6,a5
	jrlt	bgrav3
*
* klang sound
*
	movk	8,a0			; klang 1 sound
	move	*a13(p_store1),a2,w
	xori	1,a2
	jreq	bgrav5
	movk	9,a0			; klang 2 sound
bgrav5 	move	a2,*a13(p_store1),w
	callr	local_ochar_sound

	move	a11,a11
	jrn	bgrav9			; time is up
	jump	a10

bgrav9	calla	stop_a8			; stop it already !!
	movi	040H*1,a11
bgrava	sleep	1
	calla	next_anirate
	dsjs	a11,bgrava

	move	@f_death,a0,w
	jrne	local_die		; no explode during fatal

	calla	q_is_he_a_boss
	jrc	delete_proj_and_die

	movk	10,a0
	calla	create_fx
	movk	00aH,a0	
	callr	local_ochar_sound	; bomb explode sound
*
* bomb collision check
*

;	move	*a13(p_otherguy),a14,l
;	move	*a14(ochar),a14,w
;	cmpi	ft_motaro,a14
;	jreq	delete_proj_and_die

	calla	set_inviso
	movi	ft_robo2,a0
	move	a0,*a8(ochar),w
	movk	5,a11
bgravb	sleep	1			; let BANG know which obj to follow
	movk	014H,a0
	calla	strike_check_a0
	jrc	delete_proj_and_die
	dsj	a11,bgravb
	jruc	delete_proj_and_die

get_bomb_vel
	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a0,w
	move	*a8(oxpos),a1,w
	sub	a0,a1
	abs	a1			; a1 = distance from him !!!
	sll	16,a1
	movi	020H,a11
	divs	a11,a1	  		; a1 = distance/time = speed
	move	a1,a0
	rets

;************************************************************************

do_lao_zap
	clr 	a10
	movi	act_lao_zap,a1
	callr	zap_init_special_act

	movk	1,a0
	callr	local_ochar_sound		; hat throw

	movi	000030024H,a9
	jsrp	animate_a9

	movi	lao_hat_proc,a7
	callr	create_proj_proc
	movk	3,a0
	jsrp	mframew

	movk	5,a0
	jauc	mframew				; get out of ani / retp


lao_hat_proc
	movi	024H,a9
	movk	4,a14
	calla	find_ani_part_a14		; hat fly ani
	move	a9,a10
	calla	do_next_a9_frame		; 1st frame right away...
	move	a10,a9

	movi	-020000H,a0			; projectile speed
	move	a0,*a8(oyvel),l			; same y vel as x
	movk	4,a1	      			; animation speed
	movi	080000H,a0
	callr	set_proj_vel  			; set speed of proj

	movk	1,a0
	move	a0,*a13(p_store2),w

	movi	011H,a11		 		; stk offset
	movi	lao_zap_call,a6
	jsrp	projectile_flight_call	; return = hit
*
* hat hit !!!!
*
hatp8	callr	dead_projectile		; everyone should use this (ejbpatch)
	movi	front_z,a0
	move	a0,*a8(ozval),l		; put hat in front of chump

	move	b2,b2
	jrne	hat_blocked		; blocked = bounce away
*
* hat hit ---> saw at the guy...
*
	movk	2,a0
	callr	local_ochar_sound	; hat hit sound

	calla	stop_a8

saw3	move	*a8(oypos),a1,w
	push	a1
	calla	match_me_with_him
	calla	flip_multi
	pull	a1
	move	a1,*a8(oypos),w			; keep the same y

	movi	-068H,a0
	clr	a1
	calla	multi_adjust_xy			; lineup
	calla	next_anirate			; keep animating hat

	sleep	1
	move	*a13(p_otherproc),a0,l
	move	*a0(pwake),a0,l
	cmpi	rhat_wake,a0			; he is still in loop !!!
	jreq	saw3	

	movk	5,a1
	movi	0b0000H,a0
	calla	set_proj_vel			; we need a speed to reverse


hat_blocked
	movk	3,a0
	callr	local_ochar_sound		; hat blocked sound

	movi	024H,a9
	movk	5,a14
	calla	find_ani_part_a14	; angle fly

	movk	4,a0
	calla	init_anirate

	movi	-050000H,a1
;****************
;	move	@rand,a0,l
;	jrn	hatp9
;	jruc	hatp9
;     	neg	a1
;hatp9
;****************
 	move	a1,*a8(oyvel),l		; up or down (random)

	calla	flip_multi
	movi	-0a0H,a0
	movi	-008H,a1
	calla	multi_adjust_xy		; lineup

	move	*a8(oxvel),a0,l
	neg	a0
	move	a0,*a8(oxvel),l
	jruc	hatpc
	
hatpa

;	tsound	053H			; hat hit sound

hatpc	calla	next_anirate
	sleep	1
	callr	proj_onscreen_test	; onscreen ?
	jrc  	hatpc			; yes ---> keep flyin'
	jruc	delete_proj_and_die


lao_zap_call
	move	*a13(p_store2),a0,w
	dec	a0
	jrne	lzc5
	create	pid_hat_ring,hat_ring_proc
	movk	2,a0
lzc5	move	a0,*a13(p_store2),w
	move	*a8(oyvel),a0,l
	addi	03000H,a0
	move	a0,*a8(oyvel),l		; gravity on hat
	rets

hat_ring_proc
	move	a8,a10

	movk	ft_lao,a0
	move	a0,*a8(ochar),w
	movk	1,a9
	calla	get_char_ani2		; hat ring ani
	move	*a9,a5,l
	calla	gso_dmawnz
	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm		; lineup wid hat !!

;	movi	048H,a0
;	movi	028H,a1
;	calla	multi_adjust_xy

	calla	insobja8

	movk	4,a0
	jsrp	framew
	move	a8,a0
	calla	delobjp
	jruc	local_die

;************************************************************************

do_lia_anglez
	move	*a13(p_action),*a13(p_store5),w	; save b4 action here
	clr 	a10
	callr	zap_air_init_special
	movi	act_lia_anglez,a1
	move	a1,*a13(p_action),w

	movk	2,a0
	callr	local_ochar_sound		; lia fireball sound

	movk	7,a9
	calla	get_char_ani2
	movk	2,a0
	jsrp	mframew

	move	*a13(p_slave),a11,l
	movi	angle_zap_proc,a7
	callr	create_proj_proc
	move	a11,*a13(p_slave),l		; restore my face !!!

	movi	l_liazap,a0
	calla	update_tsl			; mark down this event

	callr	i_am_a_sitting_duck

	movk	5,a0
	jsrp	mframew				; flash face on and off !!
	calla	delete_slave			; sans flashing face
	movk	2,a0
	jsrp	mframew				; back to normal
	movi	010000H,a0
	move	a0,*a8(oyvel),l			; head start down

	move	*a13(p_store5),a0,w		; save b4 action here
	cmpi	act_hover,a0
	jane	land_on_yer_feet

	movk	00bH,a0
	jauc	do_body_propell
	


angle_zap_proc
	callr	setup_proj_obj

	move	a10,a8
	movi	037H,a9
	calla	get_char_ani

	movi	012H,a11		 	; stk offset
	jsrp	angle_zap_jsrp
	jsrp	angle_zap_jsrp
	movi	013H,a11		 	; stk offset
	jsrp	angle_zap_jsrp
	movk	9,a0
	move	a0,a1
	calla	multi_adjust_xy		; adjust for poor animation point setting
	jsrp	angle_zap_jsrp

	movi	014H,a11		 	; stk offset
	movi	080000H,a0		; projectile speed
	move	a0,*a8(oyvel),l		; same y vel as x
	movk	4,a1	      		; animation speed
	callr	set_proj_vel  		; set speed of proj
	movi	angle_zap_call,a6
	jsrp	projectile_flight_call	; return = hit
	jruc	angle_zap_hit

angle_zap_call
	movi	088H,a5
	move	*a8(oypos),a0,w
	move	@ground_y,a1,w
	sub	a0,a1
	cmp	a5,a1			; hit ground ?
	jrhi	azc7			; no

	move	@ground_y,a1,w
	sub	a5,a1
	move	a1,*a8(oypos),w		; place on the ground

	pull	a0			; sans returning....
	calla	reset_proc_stack

	movk	3,a0   			; hit sound
	callr	local_ochar_sound

angle_zap_explode
	movi	000040008H,a11
	calla	shake_a11
	calla	stop_a8
	movi	037H,a9
	calla	find_ani_part2
	movk	2,a0
	jsrp	mframew			; Ed BOOM !!
	jruc	delete_proj_and_die

azc7	rets


angle_zap_jsrp
	calla	do_next_a9_frame
	movk	4,a10
azj4	move	a11,a0
	calla	strike_check_a0			; collision ?
	jrc	angle_zap_hit
	sleep	1
	dsjs	a10,azj4
	retp


angle_zap_hit
	movk	3,a0				; hit sound
	move	b2,b2
	jreq	azh1
	movk	4,a0				; blocked sound
azh1	callr	local_ochar_sound

	calla	reset_proc_stack
	calla	lowest_mpart			; a1 = lowest

	push	a1
	movi	rightmost_mpart,a5
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	azh3
	movi	a3_leftmost_mpart,a5
azh3	call	a5				; a3 = furthest point
	pull	a1

	move	a3,*a8(oxpos),w
	move	a1,*a8(oypos),w

	movi	-080H,a0
	move	a0,a1
	calla	multi_adjust_xy			; line things up nicely
	jruc	angle_zap_explode

;************************************************************************

do_sw_zap
	clr 	a10
	movi	act_sw_zap,a1
	callr	zap_init_special_act

	movi	000030024H,a9
	jsrp	animate_a9

	movi	swat_proj_proc,a7
	callr	create_proj_proc

	movi	018H,a1			    	; sleep time
	jauc	do_proj_sitting_duck		; sit there

swat_proj_proc
	movi	024H,a9
	calla	find_ani_part2		; part 2 = bullets ani

	calla	do_next_a9_frame
	movi	013H,a0
	callr	proj_strike_check  	; prezap check
	jrc	sw_proj_hit		; hit = exit
	sleep	3

	calla	do_next_a9_frame
	movi	014H,a0
	callr	proj_strike_check  	; prezap check
	jrc	sw_proj_hit		; hit = exit
	sleep	3

	calla	do_next_a9_frame
	movi	014H,a0
	callr	proj_strike_check  	; prezap check
	jrc	sw_proj_hit		; hit = exit
	sleep	3

	movi	0a0000H,a0		; projectile speed
	movk	4,a1	      		; animation speed
	callr	set_proj_vel		; set speed of proj
	movi	012H,a11			; ani offset
	jsrp	projectile_flight	; return = hit

sw_proj_hit
	calla	stop_a8

	movi	-0faH,a0			; x adjust
	clr	a1			; y adjust
	callr	hit_proj_lineup_x	; lineup with guy getting hit

	movi	024H,a9
	movk	3,a14
	calla	find_ani_part_a14	; part 3 = bullets hit ani
	movk	3,a0
	jsrp	mframew
	jruc	delete_proj_and_die

;**************************************************************************

do_robo_net
	clr 	a10
	movi	act_robo_net,a1
	callr	zap_init_special_act

	jsrp	robo_open_chest

;	clr	a9
;	calla	get_char_ani2
;	movk	4,a0
;	jsrp	mframew

	movi	l_net,a0
	calla	update_tsl			; mark down this event

	movk	5,a0
	callr	local_ochar_sound

	push	a9
	movk	1,a9
	calla	get_char_ani2
	move	a9,a11
	callr	get_proj_obj_m
	move	a10,a0
	calla	insobj
	pull	a9

	movi	front_z+1,a0
	move	a0,*a10(ozval),l	; behind robo
	move	a10,a5
	movi	-018H,a0
	movi	030H,a1
	calla	adjust_xy_a5
	movi	net_proc,a7
	callr	create_proj_proc	; let another proc handle things
	calla	i_am_a_sitting_duck

	sleep	01bH

	clr	a9
	calla	get_char_ani2
	movk	4,a0
	jauc	backwards_ani

net_proc
	movk	1,a9
	calla	get_char_ani2

	movi	08000H,a0
	move	a0,*a8(oyvel),l		; heading downwards

	movi	060000H,a0
	movk	2,a1	   		; animation speed
	callr	set_proj_vel
	movi	011H,a11
	jsrp	projectile_flight

	calla	stop_a8
	movk	1,a9
	calla	find_ani2_part2
	movk	4,a0
	calla	init_anirate
	move	*a13(p_otherguy),a10,l	; a10 = him

netgrab3
	push	a8
	move	a8,a0
	move	a10,a8
	calla	match_ani_points
	pull	a8
	calla	flip_multi

	movi	-020H,a0
	movi	042H,a1
	calla	multi_adjust_xy			; stay lined up over him
	sleep	1
	calla	next_anirate
	move	*a13(p_otherproc),a0,l
	move	*a0(pwake),a5,l
	cmpi	net_struggle,a5
	jreq	netgrab3
*
* net explode
*
	movi	015H,a0
	callr	local_ochar_sound

	movk	1,a9
	calla	find_ani2_part2
	calla	find_part2		; a9 ---> net explode ani
	movk	2,a0
	jsrp	mframew
	jruc	delete_proj_and_die 	; offscreen = delete

;************************************************************************

do_robo_zap2
	clr 	a10
	movi	act_robo_zap2,a1
	callr	zap_init_special_act
	movi	00cH,a0
	callr	local_ochar_sound	; target sound
	movi	rocket2_proc,a7
	jruc	rzap3

do_robo_zap
	clr 	a10
	movi	act_robo_zap,a1
	callr	zap_init_special_act
	movi	rocket1_proc,a7

rzap3	pushp	a7
	jsrp	robo_open_chest_fast

	callr	setup_proj_obj
	clr	a0
	move	a0,*a10(ozval),l	; behind robo
	move	a10,a5
	movi	7,a0
	movi	45,a1
	calla	adjust_xy_a5
	pullp	a7

	callr	create_proj_proc	; let another proc handle things
	calla	i_am_a_sitting_duck
	sleep	020H
	jauc	robo_close_chest


rocket2_proc
	movi	(pid_p1rocket2*010000H)|pid_p2rocket2,a0
	callr	p1p2_pid_stuff

	movk	4,a0
	callr	local_ochar_sound

	movi	040H*2,a0
	move	a0,*a13(p_store4),w	; timeout

	movk	3,a1			; anirate
	movi	060000H,a0		; vel
	calla	set_proj_vel

	clr	a10			; a10 = current animation
	clr	a9
	movi	012H,a11			; stk offset
	move	a11,a0
	callr	tell_world_stk

	clr	a0
	move	a0,*a13(p_store3),w	; puff counter
	move	a0,*a13(p_store2),w	; acceleration routine
	movi	rocket_routines,a0			
	move	*a0(32+16),a0,w
	move	a0,*a13(p_store1),w	; acceleration count
	calla	a8_front_plus_1		; position rocket !!
*
* setup target
*
	mmtm	sp,a8,a9
	movk	5,a9
	calla	get_char_ani2
	move	*a9,a5,l
	calla	gso_dmawnz		; create target object
	calla	insobja8
	movk	5,a0
	move	a0,*a13(p_store5),w	; ani speed
	move	a8,*a13(p_store6),l	; target obj
	move	a9,*a13(p_store7),l	; target ani
	calla	a8_front_plus_1		; target in front of players
	mmfm	sp,a8,a9

rocket2_loop
	sleep	1

	callr	update_target
	callr	point_rocket
	callr	rocket_smoke
	calla	next_anirate

;	callr	proj_onscreen_test
;	jrnc	delete_proj_and_die 	; offscreen = delete

	move	*a13(p_store1),a0,w
	dec	a0
	move	a0,*a13(p_store1),w	; update acceleration counter
	jreq	newacc			; zero = new acceleration routine

	move	*a13(p_store2),a0,w
	sll	6,a0
	addi	rocket_routines,a0
	move	*a0,a1,l
	call	a1			; call acceleration routine
	jruc	rocket2_loop

newacc	move	*a13(p_store2),a0,w
	inc	a0
	move	a0,*a13(p_store2),w
	sll	6,a0
	addi	rocket_routines,a0
	move	*a0(32+16),a0,w
	jreq	rocket_explode		; zero ----> hunt !
	move	a0,*a13(p_store1),w	; and store
	jruc	rocket2_loop

;******************************
;******************************
;******************************

rocket_routines
	.long	rr_nothing
	.word	03333H,008H
	.long	rr_up
	.word	0a000H,010H
	.long	rocket_hunt
	.word	03333H,03333H		; bs data


rocket_hunt
	pull	a7			; dont return
hunt3	move	*a13(p_otherguy),a7,l
	move	*a8(oxpos),a2,w
	move	*a8(oypos),a4,w
	move	*a7(oxpos),a1,w
	move	*a7(oypos),a3,w
	addi	040H,a3			; about at the dudes chest...
	sub	a2,a1
	sub	a4,a3			; here is our direction vector !!!
*
* if close to enemy ---> boom !!
*
	move	a1,a7
	move	a3,a14
	calla	get_rough_hypotenuse	; a14 = distance (roughly)
	cmpi	10,a14
	jrlo	rocket_explode

	movi	040000H,a14		; master normalized vel
	mpys	a14,a1
	mpys	a14,a3

	move	a1,a7
	move	a3,a14
	calla	get_rough_hypotenuse	; a14 = distance (roughly)
	sra	16,a14
	divs	a14,a1
	divs	a14,a3			; normalized vector

;	sra	2,a1
;	sra	2,a3			; lessen direction change

	move	*a8(oxvel),a5,l
	move	*a8(oyvel),a7,l
	move	a5,a0
	move	a7,a2
	sra	4,a0
	sra	4,a2			; 1/32
	sub	a0,a5
	sub	a2,a7			; take off 1/8 of old vel
	add	a1,a5
	add	a3,a7		 	; add in new vector !!
*
* normalize final velocity
*
	move	a5,a1
	move	a7,a3
	move	a1,a7
	move	a3,a14
	calla	get_rough_hypotenuse	; a14 = distance (roughly)

	sra	16,a14		; ready for divide
	divs	a14,a1
	divs	a14,a3

	movk	5,a14
	mpys	a14,a1
	mpys	a14,a3
	move	a1,*a8(oxvel),l
	move	a3,*a8(oyvel),l

	sleep	1
	callr	update_target
	callr	point_rocket
	callr	rocket_smoke
	calla	next_anirate

	move	@f_death,a0,w
	jrne	rocket_explode		; fatality started = exit

	move	*a13(p_store4),a0,w
	dec	a0
	jreq	rocket_explode
	move	a0,*a13(p_store4),w	; timeout

	jruc	hunt3


*
* update target !!
*
update_target
	move	*a13(p_otherguy),a10,l
	mmtm	sp,a8,a9
	move	*a13(p_store6),a8,l	; target obj
	move	*a13(p_store7),a9,l	; target ani
	move	*a13(p_store5),a0,w	; ani speed
	dsj	a0,targ4
	calla	frame_a9
	movk	5,a0
targ4	move	a0,*a13(p_store5),w
	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm
	movi	-010H,a0
	movi	020H,a1
	calla	multi_adjust_xy
	mmfm	sp,a8,a9
	rets



rocket_smoke
	move	*a13(p_store3),a0,w
	xori	1,a0
	move	a0,*a13(p_store3),w
	jreq	rsmoke

	push	a11
	move	a3,a11
	movk	4,a0
	calla	create_fx		; puff o smoke
	pull	a11

rsmoke	rets



rr_up	move	*a8(oyvel),a2,l
	move	*a0(32),a1,w
	zext	a1,w
	sub	a1,a2
	move	a2,*a8(oyvel),l
	rets

rr_down	move	*a8(oyvel),a2,l
	move	*a0(32),a1,w
	zext	a1,w
	add	a1,a2
	move	a2,*a8(oyvel),l

rr_nothing
	rets

rocket_explode
	move	*a13(p_otherguy),a1,l
	move	*a1(ochar),a1,w
	cmpi	ft_motaro,a1
	jreq	rexp2				; motaro = reflect

	calla	get_his_action
	cmpi	act_reflect,a1			; indian reflect ??
	jrne	rexp3				; sans

rexp2	movi	012H,a0
	calla	strike_check_a0_test
	jrc	rocket2_reflect			; yes ---> turn around

rexp3	movi	012H,a0
	callr	proj_strike_check

	callr	delete_target_obj
	jruc	rocket_explode_fx

delete_target_obj
	push	a8
	move	*a13(p_store6),a8,l
	move	a8,a0
	calla	delobjp				; rid of target obj
	pull	a8
	rets

rocket2_reflect
	callr	delete_target_obj

	move	*a13(p_otherguy),a10,l		; a10 = new originator
	callr	benedict_arnold_projectile

	move	*a8(oxpos),a5,w
	move	*a8(oypos),a6,w
	mmtm	sp,a5,a6,a8
	move	a8,a0
	move	a10,a8
	calla	match_ani_points			; match flags
	mmfm	sp,a5,a6,a8
	move	a5,*a8(oxpos),w
	move	a6,*a8(oypos),w

	jruc	rocket2_proc


rocket_explode_fx
	movk	10,a0
	callr	local_ochar_sound

	move	*a8(oxpos),a10,w
	move	*a8(oypos),a11,w
	movk	5,a0
 	calla	create_fx		; exlosion effect
	jruc	delete_proj_and_die


rocket1_proc
	movi	(pid_p1rocket1*010000H)|pid_p2rocket1,a0
	callr	p1p2_pid_stuff

;	move	a0,*a13(procid),w	; set my id

	movk	3,a0
	callr	local_ochar_sound

	movi	037H,a9
	calla	get_char_ani
	movk	4,a14
	calla	find_part_a14		; flat rocket animation

	movi	070000H,a0		; he is reacting = fast rocket
	callr	q_his_react_flag_set
	jrc	rock12
	movi	040000H,a0		; vel
rock12	movk	3,a1			; anirate
	calla	set_proj_vel
	clr	a0
	move	a0,*a13(p_store3),w	; puff counter

	movi	012H,a11
	movi	rocket1_flight_call,a6
	jsrp	projectile_flight_call
	jruc	rocket_explode_fx


rocket1_flight_call
	movk	3,a3
	callr	rocket_smoke
	move	*a8(oxvel),a0,l
	move	a0,a1
	sra	4,a1
	add	a1,a0
	abs	a0
	cmpi	0e0000H,a0		; maxed out ?
	jrls	rock1
	movi	0e0000H,a0
rock1	calla	set_proj_vel		; accelerate
	rets



point_rocket
	movi	m_fliph,a1		; neg = we want flipped
	move	*a8(oxvel),a0,l
	jrn	point1
	clr	a1			; positive = we want un-flipped
point1	move	*a8(oflags),a4,w
	andi	m_fliph,a4		; only look at flip bit
	cmp	a1,a4			; are we facing the right direction ?
	jreq	point2
       	calla	flip_multi		; no, reverse

point2	clr	a5			; a5 = master offset
	move	*a8(oxvel),a0,l
	move	*a8(oyvel),a1,l		; grab current velocities
	abs	a0
	abs	a1
*
* 12 o'clock ???
*
	move	a0,a2			; x
	move	a2,a4
	move	a2,a14
	add	a14,a2
	add	a14,a2			;  3x

	sll	2,a4			; +4x
	add	a4,a2			; =7x
	srl	1,a2			; a2 = x * 7/2
	cmp	a2,a1			; y > x * 7/2 ?????
	jrhs	point3			; yes ---> point rocket up !!
*
* 1 o'clock ??
*
	inc	a5
	cmp	a0,a1			; y > x ??
	jrhs	point3			; yes ----> point rocket at 1 o'clock
*
* 2 o'clock ??
*
	inc	a5
	move	a1,a3			; a3 = y
	move	a3,a4
	move	a3,a14
	add	a14,a3
	add	a14,a3			;  3x
	sll	2,a4			; +4x
	add	a4,a3			; =7x
	srl	1,a3			; a3 = y * 7/2
	cmp	a3,a0			; x > y * 7/2 ?????
	jrls	point3			; no ---> point rocket at 2 o'clock
*
* 3 o'clock
*
	inc	a5			; yes --> 3 oclock

point3	move	*a8(oyvel),a1,l		; grab current velocities
	jreq	point_up		; zero y = point at 3 oclock
	jrn	point_up
	addk	4,a5			; a5 ---> 90 degrees down

point_up
	push	a9
	movi	037H,a9
	calla	get_char_ani
	move	a5,a3
	inc	a5
	move	a5,a14
	calla	find_part_a14		; correct animation
	move	a9,a7			; a7 = animation we want
	pull	a9

	cmp	a7,a10			; we already on this ani ??
	jreq	point9			; yes.
	move	a7,a9
	move	a7,a10			; no, now we are

point9	rets


robo_open_chest_fast
	movk	2,a0
	callr	q_his_react_flag_set		; fast
	jrc	roc3

robo_open_chest
	movk	4,a0

roc3	push	a0
	movi	00bH,a0
	callr	local_ochar_sound
	clr	a9
	calla	get_char_ani2
	pull	a0
	jauc	mframew

robo_close_chest
	clr	a9
	calla	get_char_ani2
	movk	4,a0
	jauc	backwards_ani

;************************************************************************

do_ind_zap
	clr 	a10
	movi	act_ind_zap,a1
	callr	zap_init_special_act

	clr	a0
	callr	local_ochar_sound

	movi	000030024H,a9
	jsrp	animate_a9

	move	*a13(p_slave),a0,l
	mmtm	sp,a0,a10
	callr	setup_proj_obj
	movi	ind_zap_proc,a7
	callr	create_proj_proc
	mmfm	sp,a0,a10
	move	a0,*a13(p_slave),l		; restore slave object

	callr	i_am_a_sitting_duck

	movk	3,a0
	jsrp	mframew
	movk	1,a1
	jauc	do_proj_sitting_duck

ind_zap_proc
	movi	024H,a9
	movk	3,a14
	calla	find_ani_part_a14
	calla	do_next_a9_frame

	movk	1,a0
	callr	local_ochar_sound

	movi	0a0000H,a0
	movk	4,a1				; animation speed
	callr	set_proj_vel
	movi	012H,a11
	jsrp	projectile_flight

	movi	000030004H,a0			; hit/blocked choices
	calla	hob_ochar_sound

	calla	stop_a8
	movi	024H,a9
	movk	4,a14
	calla	find_ani_part_a14

	movk	4,a0
	jsrp	mframew
	jruc	delete_proj_and_die

;************************************************************************

do_sky_ice_behind
	movi	060H,a11
	jruc	doice3

do_sky_ice_front
	movi	060H,a11
	neg	a11

doice3	calla	is_he_right
	jrc	doice5			; all is ok....
	neg	a11			; flipped = reverse
	jruc	doice5			; common from here on out..

do_sky_ice_on
	clr	a11

doice5	clr 	a10
	movi	act_sky_ice,a1
	callr	zap_init_special_act

	clr 	a0
	callr	local_ochar_sound

	movi	000030000H,a9		; sleep : ani offset
	jsrp	animate2_a9

	movk	2,a0
	jsrp	mframew			; start: animate ice into the sky
	movi	sky_ice_proc,a7
	callr	create_proj_proc	; let another proc handle things
	movk	3,a0
	jsrp	mframew			; finish: animate ice into the sky
	calla	delete_slave

	clr	a9
	movk	3,a0
	jsrp	backwards_ani2		; un ani
	jruc	local_retp


sky_ice_proc
	calla	find_part2		; a9 ---> ice fall ani

	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a0,w
	add	a11,a0			; adjust for on, behind or front
	move	a0,*a8(oxpos),w		; lineup with him

	calla	do_next_a9_frame	; pose: 1st ice fall frame
	move	@ceiling_y,a0,w
	subi	01b0H,a0
	move	a0,*a8(oypos),w		; way above the ceiling

	sleep	8			; delay b4 the actual drop

	movk	1,a0
	callr	local_ochar_sound

	move	*a8(oypos),a0,w
	addi	0100H,a0
	move	a0,*a8(oypos),w		; just above the ceiling

;	movi	0a0000H,a0
	movi	0b0000H,a0

	move	a0,*a8(oyvel),l		; heading down
	move	@ground_y,a10,w
	subi	0c0H,a10

icef3	sleep	1
	movi	012H,a0
	callr	proj_strike_check	; collide ?
	jrc	ice_hit			; yes ---> break up ani
	move	*a8(oypos),a0,w
	cmp	a10,a0
	jrlt	icef3
*
* ice hit the ground
*
	calla	stop_a8
	move	a10,*a8(oypos),w	; exactly on ground
	jruc	ice_break_up
*
* ice hit opponent
*
ice_hit
	movi	000020003H,a0
	calla	hob_ochar_sound		; hit or blocked sound

	movi	040000H,a0
	move	a0,*a8(oyvel),l		; heading down slow while breaking up

ice_break_up
	movk	3,a0
	jsrp	mframew			; ani: ice crashing on ground
	jruc	delete_proj_and_die

;************************************************************************

do_jax_zap2
	clr 	a10
	movi	act_jax_zap2,a1
	callr	zap_init_special_act

	movi	l_jaxzap2,a0
	calla	update_tsl  			; mark dis event !!

	jsrp	jax_zap_jsrp

	calla	do_next_a9_frame
	sleep	6

	clr	a0
	callr	local_ochar_sound		; jax fire sound
	movi	jax_zap_proc,a7
	callr	create_proj_proc

	movk	1,a1
	move	a1,*a0(p_store4),w		; flag: projectile #2
	movi	040000H,a0
	calla	away_x_vel			; recoil !!
	calla	do_next_a9_frame

	sleep	01dH				; EVEN LONGER DELAY !!!

	calla	stop_me
	movk	6,a0
	jauc	mframew				; and retp


do_jax_zap1
	clr 	a10
	movi	act_jax_zap,a1
	callr	zap_init_special_act

	jsrp	jax_zap_jsrp
	movi	010H,a1
	jauc	do_proj_sitting_duck


jax_zap_jsrp
	movi	024H,a9
	calla	do_first_a9_frame		; ani: zap
	sleep	6

	clr	a0
	callr	local_ochar_sound		; jax fire sound
	calla	do_next_a9_frame
	sleep	4

	movi	jax_zap_proc,a7
	callr	create_proj_proc
	clr	a1
	move	a1,*a0(p_store4),w		; flag: projectile #1

	movi	040000H,a0
	calla	away_x_vel			; recoil !!
	movk	4,a0
	jsrp	mframew				; finish part 1 ani
	calla	stop_me
	retp

jax_zap_proc
	movi	037H,a9
	calla	get_char_ani

	calla	do_next_a9_frame
	movi	013H,a0
	callr	tell_world_stk
	calla	strike_check_a0
	jrc	jax_zap_hit
	sleep	3

	movk	3,a0
	move	a0,*a13(p_store5),w

	movi	080000H,a0
	movk	4,a1				; animation speed
	callr	set_proj_vel
	movi	012H,a11
	movi	jax_proj_calla,a6
	jsrp	projectile_flight_call

jax_zap_hit
	move	b2,b2
	jrne	jax_zap_blocked

	movi	000050005H,a11
	calla	shake_a11

jax_zap_blocked
	movi	000010002H,a0
	calla	hob_ochar_sound			; hit or blocked sound

	calla	stop_a8
	calla	match_me_with_him
	clr	a1
	movi	-0b3H,a0
	calla	multi_adjust_xy

	move	*a13(p_store4),a0,w
	jreq	jzhit4

	movi	-01aH,a0
	movi	-025H,a1
	calla	multi_adjust_xy		; 2nd missle ---> raise up

jzhit4	movi	037H,a9
	movk	2,a14
	calla	find_ani_part_a14
	movk	4,a0
	jsrp	mframew
	jruc	delete_proj_and_die

jax_proj_calla
	move	*a13(p_store5),a0,w
	dec	a0
	jrne	jpc9
	movi	00fH,a0
	calla	create_fx		; puff o smoke
	movk	3,a0
jpc9	move	a0,*a13(p_store5),w
	rets	

;************************************************************************

do_sonya_zap
	clr	a10
	movi	act_sonya_zap,a1
	callr	zap_init_special_act

	clr	a0
	callr	local_ochar_sound

	movi	024H,a9
	calla	get_char_ani
	movk	3,a0
	jsrp	mframew

	movi	sonya_zap_proc,a7
	callr	create_proj_proc

	movi	023H,a1
	jauc	do_proj_sitting_duck


sonya_zap_proc
	movi	013H,a0
	callr	proj_strike_check		; prezap !!!
	jrnc	jzap2

	movi	-010H,a0
	clr	a1
	jruc	jzap7

jzap2	movi	037H,a9
	calla	get_char_ani

	movi	080000H,a0
	movk	3,a2
	movk	3,a1				; animation speed
	callr	set_proj_vel
	movi	012H,a11
	jsrp	projectile_flight

	calla	stop_a8
	movi	13,a0
	clr	a1
jzap7	calla	multi_adjust_xy
	clr	a0
	calla	create_fx

	movi	000010002H,a0			; hit / blocked sound
	calla	hob_ochar_sound

	callr	dead_projectile		; ejbpatch - make sure everyone calls this
	movi	020000H,a0
	clr	a1
	callr	set_proj_vel

	movi	037H,a9
	calla	find_ani_part2
	movk	4,a0
	jsrp	mframew
	jruc	delete_proj_and_die

**************************************************************************

do_kano_zap
	clr	a10
	movi	act_kano_zap,a1
	callr	zap_init_special_act

	movk	1,a0
	callr	local_ochar_sound

	movi	000000024H,a9
	calla	pose_a9
	sleep	3

	callr	setup_proj_obj
	movk	3,a0
	jsrp	double_mframew
	movi	kano_zap_proc,a7
	callr	create_proj_proc

	movk	4,a0
	jsrp	mframew				; finish throw ani

	movi	018H,a1
	jauc	do_proj_sitting_duck


kano_zap_proc
	movi	000030060H,a1
	movi	000220044H,a2
	movi	015H,a0
	callr	local_strike_check_box
	jrnc	kzap2

	movi	038H,a0
	movi	020H,a1
	jruc	kzap7

kzap2	movi	037H,a9
	calla	find_ani_part2

	movi	080000H,a0
	movk	1,a1
	callr	set_proj_vel
	movi	015H,a11				; a11 = stk offset
	jsrp	projectile_flight		; return if hit !!!

	calla	stop_a8
	movi	13,a0
	clr	a1
kzap7	calla	multi_adjust_xy

	movi	000020003H,a0
	calla	hob_ochar_sound			; hit / blocked sound

	callr	dead_projectile

	movi	037H,a9
	movk	3,a14
	calla	find_ani_part_a14
	movk	4,a0
	jsrp	mframew
	jruc	delete_proj_and_die

**************************************************************************
*											     *
*  get_proj_obj - Get a projectile object for a player.			     *
* 											     *
*  Input: a8 = player who wants one   Returns: a10 = proj obj		     *
*         a9 = frame #1										*
*											     *
**************************************************************************
get_proj_obj_m
	push	a8
	calla	gmo_proc			; a0 = process which holds data
	move	a8,a10				; a10 = object
	move	a0,*a8(oslink),l		; oslink = process
	pull	a8

	move	*a8(ochar),*a10(ochar),w	; same ochar as thrower
	move	a10,*a13(p_slave),l		; projectiles are slave objects

	movi	front_z+1,a0
	move	a0,*a10(ozval),l

	movi	ochar_proj_oids,a0
	calla	get_char_long

	move	*a8(oid),a1,w
	cmpi	oid_p1,a1
	jreq	gpo8				; player 1 projectile oid
	srl	16,a0				; player 2 projectile oid
gpo8	move	a0,*a10(oid),w			; give oid to projectile object

	move	a10,a0
	calla	match_ani_points		; lineup proj with thrower !
	rets


ochar_proj_oids
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2

	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2

	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2
	.word	pid_proj1,pid_proj2

**************************************************************************
*											     *
*  projectile_flight - flight loop for projectile				     *
* 											     *
*  Input: a11 = stk offset								     *
*          a6 = routine to call every tick                               *
*											     *
**************************************************************************
projectile_flight
	clr	a6

projectile_flight_call
	move	a6,*a13(p_store1),l		; store routine here !!!
	move	a11,a0
	callr	tell_world_stk

pflt3	sleep	1
	calla	next_anirate
	callr	proj_onscreen_test
	jrnc	delete_proj_and_die		; offscreen = delete

	move	*a13(p_store1),a6,l		; routine to call ??
	jreq	pflt5				; no.
	call	a6				; yes, call it

pflt5 	move	*a13(p_otherguy),a1,l
	move	*a1(ochar),a1,w
	cmpi	ft_motaro,a1
	jreq	pflt6				; motaro = reflect

	calla	get_his_action
	cmpi	act_reflect,a1			; indian reflect ??
	jrne	pflt4				; sans

pflt6	move	a11,a0
	calla	strike_check_a0_test
	jrc	projectile_reflect		; yes ---> turn around

pflt4	move	a11,a0
	callr	tell_world_stk
	callr	proj_strike_check
	jrnc	pflt3
	retp


projectile_reflect
	callr	benedict_arnold_projectile
	move	*a13(p_anirate),a1,w
	move	*a8(oxvel),a0,l
	abs	a0
	calla	set_proj_vel			; turn around velocity
	jruc	pflt3


benedict_arnold_projectile
	move	*a13(p_otherproc),a6,l
	move	*a6(p_otherguy),*a13(p_otherguy),l
	move	*a6(p_otherproc),*a13(p_otherproc),l	; new goal in life

	callr	get_frontmost_point		; a3 = frontmost point
	push	a3
	calla	flip_multi			; turn around
	callr	get_frontmost_point		; a3 = FLIPPED frontmost point
	pull	a4
	sub	a4,a3
	abs	a3
	neg	a3				; we ALWAYS want negative here 

	push	a3
	calla	rightmost_mpart			; a3
	calla	leftmost_mpart			; a2
	sub	a3,a2
	abs	a2
	pull	a3

	add	a2,a3				; add in the x size of projectile
	move	a3,a0
	clr	a1
	calla	multi_adjust_xy
	rets

;************************************************************************

*
*          a8 = projectile object
* *a8(oslink) = process holding projectile data
*
delete_proj_and_die
	move	*a8(oslink),a0,l
	calla	kill			; kill "data storage" process

	move	a8,a0
	calla	delobjp
	jruc	local_die

;************************************************************************

get_frontmost_point
	movi	rightmost_mpart,a14		; a3 = rightmost
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	pref4
	movi	a3_leftmost_mpart,a14	; a3 = leftmost
pref4	jump	a14


a3_leftmost_mpart
	calla	leftmost_mpart
	move	a2,a3			; return in a3
	rets

*
* a0 = vel
* a1 = anirate
*
set_proj_vel
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	spv6
      	neg	a0
spv6	move	a0,*a8(oxvel),l		; send it flyin'

	move	a1,a0
	jauc	init_anirate


proj_in_front
	movi	front_z+1,a0
	move	a0,*a8(ozval),l		; in front of players
	rets
*
* a1 = sleep time
*
do_proj_sitting_duck
	movi	act_proj_sd,a0
	move	a0,*a13(p_action),w	; I am a sitting duck
	move	a1,a0
	calla	prcslp
        	retp
*
* a7 = address
*
create_proj_proc
	movi	(pid_proj1*010000H)+pid_proj2,a0
	calla	p1p2_pick					; player pick..
	move	a0,a1
	calla	getprc
	move	*a13(p_otherguy),*a0(p_otherguy),l
	move	*a13(p_otherproc),*a0(p_otherproc),l
	move	a10,*a0(pa8),l
	clr	a1
	move	a1,*a0(p_joyport),l				; initialize for drones
	move	a1,*a13(p_slave),l
	rets

dead_projectile
	movi	act_proj_dead,a0
	move	a0,*a13(p_action),w
	rets

*
* a0 = x adjust
* a1 = y adjust
*
hit_proj_lineup_x
	move	*a8(oypos),a10,w
	callr	hit_proj_lineup_xy
	move	a10,*a8(oypos),w
	rets

hit_proj_lineup_xy
	mmtm	sp,a0,a1
	calla	match_me_with_him
	calla	flip_multi
	mmfm	sp,a0,a1
	calla	multi_adjust_xy		; lineup with guy getting hit
	rets

**************************************************************************
*											     *
*  proj_onscreen_test - Answers "Is a projectile (a8) onscreen ?	     *
* 											     *
*  Returns:   Carry set = yes								     *
*           Carry clear = no								     *
*											     *
**************************************************************************
proj_onscreen_test
	move	*a8(oflags2),a4,w
	btst	b_multipart,a4
	jrne	pot4
*
* single part object
*
	move	*a8(oxvel),a0,l
	jrnn	pot41
	move	*a8(oxpos),a3,w
	move	*a8(osizex),a2,w
	add	a2,a3
	jruc	pot3

pot41	move	*a8(oxpos),a2,w
	jruc	pot6
*
* multipart object
*
pot4	move	*a8(oxvel),a0,l
	jrnn	pot5
	calla	rightmost_mpart		; a3 = right point
pot3	move	@worldtlx+16,a5,w	; a5 = left world x
	cmp	a3,a5
	jrle	pot_yes
pot_no	clrc
	rets

pot5	calla	leftmost_mpart		; a2 = left point
pot6	move	@worldtlx+16,a5,w
	addi	scrrgt,a5		; a5 = right world x
	cmp	a2,a5
	jrlt	pot_no
pot_yes	setc
	rets


proj_strike_check
	callr	is_he_motaro
	jrc	proj_no_col

	jauc	strike_check_a0

proj_no_col
	clrc
	rets


p1p2_pid_stuff
	calla	p1p2_pick
	move	a0,*a13(procid),w
	rets

tell_world_stk
	push	a0
	calla	get_char_stk
	move	a0,*a13(p_joyport),l	; save stk table here !!
	pull	a0
	rets


is_he_motaro
	push	a14
	move	*a13(p_otherguy),a14,l
	move	*a14(ochar),a14,w
	cmpi	ft_motaro,a14
	pull	a14
	jreq	q_yes
	jruc	q_no


setup_proj_obj
	push	a9
	movi	037H,a9
	calla	get_char_ani
	move	a9,a11
	callr	get_proj_obj_m
	move	a10,a0
	calla	insobj
	pull	a9
	rets


q_his_react_flag_set
	move	*a13(p_otherproc),a14,l
	move	*a14(p_flags),a14,w
	btst	pb_reacting,a14
	jrne	q_yes
	jruc	q_no

q_yes	setc
	rets
q_no	clrc
	rets


i_am_a_sitting_duck
	movi	act_proj_sd,a0
	move	a0,*a13(p_action),w		; I am a sitting duck
	rets

local_strike_check_box
	callr	is_he_motaro
	jrc	proj_no_col
	jauc	strike_check_box


local_ochar_sound
	jauc	ochar_sound

local_retp
	retp

local_die
	die

;*************************************************************************

	.end
