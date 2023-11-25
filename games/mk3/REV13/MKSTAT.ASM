**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: stationary moves									*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	"mkstat.asm"
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
	.include	mkbaby.tbl
	.text


do_stationary
	sll	5,a0
	addi	stat_jumps,a0
	move	*a0,a0,l
	jump	a0

stat_jumps
	.long	do_lao_spin		;  0
	.long	stat_do_lia_scream 	;  1
	.long	stat_do_axe_up		;  2
	.long	stat_do_fast_axe_up 	;  3
	.long	do_reflect		;  4
	.long	do_shake		;  5
	.long	do_noogy		;  6
	.long	stat_do_quake		;  7
	.long	do_inviso		;  8
	.long	do_leg_throw		;  9
	.long	do_kano_swipe		;  a
	.long	0			;  b
	.long	0			;  c
	.long	0			;  d
	.long	0			;  e
	.long	0			;  f

	.long	stat_do_hi_kick		; 10
	.long	stat_do_lo_kick		; 11
	.long	stat_do_sweep_kick 	; 12
	.long	stat_do_duck_punch 	; 13
	.long	stat_do_duck_kickh 	; 14
	.long	stat_do_duck_kickl 	; 15
	.long	stat_do_uppercut   	; 16
	.long	stat_do_roundhouse 	; 17
	.long	do_babality		; 18
	.long	0			; 19
	.long	0			; 1a
	.long	0			; 1b
	.long	0			; 1c
	.long	0			; 1d
	.long	0			; 1e
	.long	0			; 1f
	.long	0			; 20

;***********************************************************************

do_babality
	callr	local_init_special
	jsrp	baby_start_pause

	movi	turn_into_a_baby,a7
	calla	takeover_him

	sleep	050H
	jruc	babality_complete

baby_start_pause
	movi	fat_baby,a1
	calla	init_death_blow
	clr	a9
	calla	pose_a9			; stance frame 1
	sleep	020H
	retp

babality_complete
	calla	death_blow_complete
	calla	player_normpal
	jauc	victory_animation

turn_into_a_baby
	tsound	08cH			; poof
	move	a8,a10
	movi	01eH,a0
	calla	create_fx		; poof goes the wheasel
	sleep	8
	calla	set_inviso
	move	*a8(ochar),a5,w
	sll	5,a5
	addi	ochar_babies,a5
	move	*a5,a5,l
	calla	gso_dmawnz
	move	*a10(oxpos),*a8(oxpos),w

	move	@ground_y,a0,w
	move	*a8(osizey),a1,w
	sub	a1,a0
	subk	9,a0
	move	a0,*a8(oypos),w		; lil baby on ground

	calla	insobja8
	sleep	030H
	tsound	08dH			; cry
	jauc	wait_forever

ochar_babies
	.long	BABKANO
	.long	BABSONYA
	.long	BABJAX
	.long	BABINDIAN
	.long	BABZERO
	.long	BABSWAT
	.long	BABWITCH
	.long	BABKETCH
	.long	BABMUST
	.long	BABLAO
	.long	BABTUSKEN
	.long	BABGORO
	.long	BABTSUNG
	.long	BABKANG
	.long	BABSMOKE

;***********************************************************************

stat_do_roundhouse
	callr	local_init_special

	tsound	002H			; roundhouse whoosh !!!
	clr	a0
	calla	group_sound

	movi	round_speeds,a0
	calla	get_char_word
	movi	act_rhouse,a1
	movi	015H,a9
	movk	3,a10
	movi	00dH,a11
	move	a11,*a13(p_stk),w
	jsrp	striker
	jrnc	rh_no
	sleep	10			; hit ---> hold this frame longer
rh_no	movk	4,a0
	jauc	retract_strike


round_speeds
	.word	3	;
	.word	3	;
	.word	3	;
	.word	3	;
	.word	3	;

	.word	3	;
	.word	3	;
	.word	3	;
	.word	3	;
	.word	3	;

	.word	3	;
	.word	3	;
	.word	3	;
	.word	3	;
	.word	3	;

;***********************************************************************

stat_do_sweep_kick
	callr	local_init_special

	movk	4,a0
	move	a0,*a13(p_stk),w

	move	*a13(p_otherguy),a0,l
	move	*a0(ochar),a0,w
	movk	3,a0			; speed
	movi	act_sweep,a1
	movi	014H,a9
	movk	1,a10
	movk	4,a11
	jsrp	behind_striker
	movk	5,a0			; miss retract speed timer
	jrnc	sweep3
      	sleep	6
	movk	6,a0  			; contact = finish animation slower
sweep3	movi	act_sweep_sd,a1		; flag: i am hittable
	jruc	retract_strike_act



stat_do_duck_punch
	clr	a0
	calla	group_sound
	calla	rsnd_whoosh

	callr	local_init_special
	movk	3,a0
	movi	act_duckpunch,a1
	movk	8,a9
	movk	1,a10
	movi	005H,a11
	move	a11,*a13(p_stk),w
	jsrp	striker
	movk	3,a0   			; retract speed
	jruc	retract_strike


stat_do_duck_kickh
	clr	a0
	calla	group_sound
	calla	rsnd_whoosh

	callr	local_init_special
	movk	3,a0
	movi	act_duck_kickh,a1
	movk	9,a9
	movk	5,a10
	movi	006H,a11			; changed so drones can stay altert after
	move	a11,*a13(p_stk),w
	jauc	striker
	movk	3,a0   			; retract speed
	jruc	retract_strike


stat_do_duck_kickl
	clr	a0
	calla	group_sound
	calla	rsnd_whoosh

	callr	local_init_special
	movk	2,a0
	movi	act_duck_kickl,a1
	movk	00aH,a9
	movk	2,a10
	movi	007H,a11		; changed so drones can stay altert after
	move	a11,*a13(p_stk),w
	jauc	striker


stat_do_uppercut
	callr	local_init_special
	calla	rsnd_big_whoosh

	movk	00bH,a9	
	calla	do_first_a9_frame
	sleep	1
	calla	do_next_a9_frame
	sleep	1			; even FASTER uppercut !!!

	movk	2,a0
	movi	act_uppercut,a1
	movk	1,a10
	movi	008H,a11
	move	a11,*a13(p_stk),w
	jsrp	upcut_striker

	movi	act_upcut_sd,a0
	move	a0,*a13(p_action),w	; signal: i am a sitting duck
	
	movk	10,a0			; miss sleep
	jrnc	ucut4

	movk	18,a0			; blocked uppercut sleep time
	move	b2,b2			; blocked ?
	jrne	ucut4			; yes, use blocked sleep time
*
* full contact hit !!
*
	movi	020H,a0
	move	@f_upcut_rec,a1,w	; fast recovery ?
	jreq	ucut4			; no
	movk	4,a0
ucut4	calla	prcslp

	move	@winner_status,a0,w	; round over ?
	jrne	ucut8			; yes, exit

upcut_wait
	sleep	1
	calla	get_his_action
	cmpi	act_frozen,a1
	jreq	ucut8			; frozen = dont wait
	cmpi	act_hover,a1
	jreq	ucut8	    		; hover = dont wait

	calla	get_his_dog
	cmpi	050H,a0
	jrhi	upcut_wait


ucut8	movk	4,a0
	movi	act_upcut_sd,a1
	jsrp	act_mframew		; post uppercut ani

	calla	back_to_normal
	retp

;************************************

stat_do_lo_kick
	callr	local_init_special			; i can't block !!
	calla	rsnd_big_whoosh
	clr	a0
	calla	group_sound

	movi	012H,a9
	movk	1,a0
	move	a0,*a13(p_stk),w

	movk	1,a0
	movk	1,a11
	movi	act_lokick,a1

kick2	movk	6,a10
	jsrp	striker
	jrnc	kik3

	sleep	00cH

kik3	movi	act_ret_kick,a1

	movk	3,a0
	jruc	retract_strike_act

;**************************************

stat_do_hi_kick
	callr	local_init_special			; i can't block !!

	clr	a0
	move	a0,*a13(p_stk),w
	calla	rsnd_big_whoosh
	clr	a0
	calla	group_sound

	movk	1,a0
 	clr	a11
	movi	act_hikick,a1
	movi	011H,a9			; ani = hi kick
	jruc	kick2

**************************************************************************

do_kano_swipe
	movi	act_kano_swipe,a1
	callr	local_init_special_act
	clr	a0
	callr	local_ochar_sound

	movk	pow_flipkp,a0
	movb	a0,*a13(p_power)	; I am above flip kicks/punches

	movi	012H,a0
	move	a0,*a13(p_stk),w	; define my stk table offset

	movk	1,a9
	calla	get_char_ani2
	movk	2,a0
	jsrp	mframew
	movi	012H,a0
	calla	strike_check_a0

	movi	act_kswipe_sd,a0
	move	a0,*a13(p_action),w

	movk	4,a0
	jsrp	mframew			; finish ani

	callr	local_zero_power
	sleep	008H
	movk	4,a0
	jsrp	mframew			; finish ani
	retp

****************************************************************************

do_leg_throw
	movi	act_leg_grab,a1
	callr	local_init_special_act
	calla	rsnd_big_whoosh

	movk	010H,a0
	move	a0,*a13(p_stk),w		; tell da world
	clr	a9
	calla	get_char_ani2
	movi	000020003H,a0
	jsrp	animate_a0_frames
	movk	1,a0
	jsrp	mframew

	calla	q_is_he_a_boss
	jrc	leg_miss

	movk	010H,a0
	calla	strike_check_a0
	jrnc	leg_miss

	movi	act_leg_sd,a0
	move	a0,*a13(p_action),w		; i am a sitting duck

;***********
	movi	clear_inviso,a0
	calla	calla_for_him
;***********

	move	b2,b2
	jrne	leg_blocked
*
* success
*
	movi	act_leg_grab,a0
	calla	update_his_hit_queue

	movi	face_opponent,a0
	calla	calla_for_him			; him ---> face me !!
	calla	rsnd_big_block
	movk	2,a0
	calla	his_group_sound			; him: wasted voice

	movi	060H,a0
	move	a0,@f_norepell,w		; disable repells for a bit
	movi	act_leg_grab,a0
	calla	xfer_him_to_flipped_pause
	calla	inc_his_p_hit

	movi	036H,a9
	calla	get_his_char_ani
	move	a9,a11	    			; a11 = his ani (legged by me)
	move	*a13(p_otherguy),a10,l	; a10 = his obj
	clr	a9
	calla	get_char_ani2
	calla	find_part2   	 		; me = PART 2 of leg grab ani

;**************
	.if debug
	move	@f_colbox,a14,w			; collision box object ?
	jane	double_mframew_debug
	.endif
;**************

	calla	double_next_a9		; 1st frame for both of us

	movi	000030000H,a0  		; y:x
	movk	3,a1	      		; sleep time
	movk	5,a2	      		; # of shakes
	jsrp	shake_him_up

	movk	4,a0
	jsrp	double_mframew		; animate together
	movi	r_leg_slammed,a7
	calla	takeover_him

	movk	5,a0
	jsrp	mframew	    		; finish slam animation
	jruc	local_reaction_exit


leg_blocked
	calla	rsnd_big_block
	movi	018H,a0			; blocked sleep
	jruc	post_leg_sleep

leg_miss
	movi	010H,a0			; miss sleep

post_leg_sleep
	movi	act_leg_sd,a1
	move	a1,*a13(p_action),w	; set my state

	calla	prcslp

	clr	a9
	calla	get_char_ani2
	calla	find_part2

	movk	5,a0
	jsrp	mframew			; undo ani
	movk	5,a0
	jsrp	mframew			; undo ani
	jruc	local_reaction_exit

r_leg_slammed
	movi	act_legged,a0
	move	a0,*a13(p_action),w

	calla	ground_player
	movi	01eH,a9
	calla	find_ani_part2		; knock down on back frame
	calla	do_next_a9_frame

	movk	2,a0
	calla	group_sound  	; group speech: wasted

	calla	shake_n_sound
	movi	35,a10
	calla	damage_to_me

	movi	030000H,a0		; initial x vel
	movi	-060000H,a1		; initial y vel
	movi	08000H,a2		; grav
	movk	4,a3			; ani speed
	jsrp	flight

	jauc	land_on_my_back

****************************************************************************

do_inviso
	callr	local_init_special

	movi	00bH,a9
	calla	get_char_ani2
	movk	2,a0
	jsrp	mframew			; smoke inviso pose

	movi	01eH,a0
	calla	create_fx
	sleep	6

	move	*a8(oflags2),a4,w
	btst	b_inviso,a4
	jrne	do_un_inviso

	calla	set_inviso
	calla	clear_shadow_bit
	jruc	local_reaction_exit

do_un_inviso
	calla	clear_inviso
	calla	set_shadow_bit
	jruc	local_reaction_exit

;***********************************************************

stat_do_quake
	movi	act_quake,a1
	callr	local_init_special_act	; i can't block !!
	clr	a9
	calla	get_char_ani2

	movk	4,a0
	jsrp	mframew
	sleep	6			; hold that fist up jax !!

	tsound	002H			; roundhouse whoosh !!!
	clr	a0
	calla	group_sound		; whoosh

	movk	3,a0
	jsrp	mframew			; wham !!

	mmtm	sp,a10,a11
	calla	is_he_airborn		; he in the air ?
	jrc	quake3			; yes, no damage

	calla	q_is_he_a_boss
	jrc	quake3			; yes, no damage

	movi	015H,a0
	calla	damage_to_him
	movi	r_quake,a7
	calla	takeover_him

quake3 	movi	00009000eH,a11
 	calla	shake_a11		; earthquake !!
	movk	4,a0
	callr	local_ochar_sound	; ground smash sound

	mmfm	sp,a10,a11
	movi	act_proj_sd,a1
	move	a1,*a13(p_action),w
	movk	3,a0
	jsrp	mframew
	calla	delete_slave
	jauc	do_backup

;*****************************


do_noogy
	callr	local_init_special

	movk	014H,a0
	move	a0,*a13(p_stk),w	; define my stk table offset

	movk	1,a0
	calla	group_sound		; voice: jump !

	movk	1,a9
	calla	get_char_ani2
	movk	3,a0
	movi	act_noogy,a1
	jsrp    act_mframew		; reach out and grab someone

	movk	6,a11			; scan for this many frames
noog3	movi	014H,a0
	calla	strike_check_a0
	jrc	noogy_hit
	sleep	1
	dsjs	a11,noog3

*
* missed = retract
*
noogy_blocked
	movi	act_noogy_sd,a0
	move	a0,*a13(p_action),w

	sleep	00dH			; stunned

	movk	1,a9
	calla	get_char_ani2
	move	a9,a10
	addi	32,a9
	calla	do_next_a9_frame	; frame 2
	sleep	6
	move	a10,a9
	calla	do_next_a9_frame	; frame 1
	sleep	6
	retp


noogy_hit
	calla	lights_on_hit

	move	b2,b2
	jrne	noogy_blocked

;	movk	2,a0
;	calla	his_group_sound		; him: wasted voice
	movk	6,a0
	callr	local_ochar_sound	; speech: gotcha !

	calla	me_in_front
	movi	noogy_suspended,a7
	calla	takeover_him

	push	a9
	movi	01cH,a9
	calla	get_his_char_ani
	move	a9,a11
	addi	32,a9	      		; hit hi frame 3
	calla	do_his_next_a9_frame
	pull	a9

	movi	noog_lineup_1,a10
	jsrp	edge_of_world_lineup

	move	*a13(p_otherguy),a10,l

	movi	000030003H,a0
	movk	3,a1
	movk	3,a2
	jsrp	shake_him_up

	movi	000000010H,a0
	calla	adjust_him_a0
	calla	do_next_a9_frame
	sleep	4

	movi	000050010H,a0
	calla	adjust_him_a0
	calla	do_next_a9_frame
	sleep	4

	movi	01cH,a0
	calla	pose_him_a0
	calla	do_next_a9_frame
	sleep	4

*
* pow pow pow !!
*
	clr	a0
	move	a0,*a13(p_store1),w	; flag: no exit

	movk	5,a0
noog5 	move	a0,*a13(p_anicount),w

	movk	3,a0
	jsrp	mframew					; wham !!
	movk	7,a0
	move	a0,a14
	calla	add_combo_damage
	calla	damage_to_him
	calla	inc_his_p_hit
*
* fx and sound !!
*
	movk	2,a0
	calla	his_group_sound			; him: wasted voice

	tsound	083H
;	calla	rsnd_big_smack

	create	pid_fx,noogy_shaker
	move	*a13(p_otherguy),*a0(pa10),l

	move	*a13(p_anicount),a0,w
	cmpi	1,a0
	jreq	noogy_last_hit 			; max hits ---> exit
	move	*a13(p_store1),a0,w
	jrne	noogy_last_hit 			; not tapping button --> exit

;****************
	mmtm	a12,a9,a11
	move	a11,a9				; input a11 = animation table
noog6	calla	do_his_next_a9_frame
	sleep	2
	move	*a9,a0,l
	jrne	noog6
	mmfm	a12,a9,a11
;****************

	callr	noogy_early_check
	sleep	2
	callr	noogy_early_check
	sleep	2				; Hey Dave !!
	callr	noogy_early_check		; things are faster now !!

	move	*a13(p_anicount),a0,w
	dec	a0
	jruc	noog5


noog_lineup_1
	calla	match_him_with_me_f
	move	*a13(p_otherguy),a0,l
	move	*a0(ochar),a0,w
	sll	5,a0
	addi	ochar_noogy_lineups,a0
	move	*a0,a0,l
	jauc	adjust_him_a0

;xxx
ochar_noogy_lineups
	.word	-054H,-008H
	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H

	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,000H

	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H

	.word	-048H,-010H
	.word	-04bH,-01aH	; shao kahn
	.word	-048H,-010H
	.word	-048H,-010H
	.word	-048H,-010H


gotcha_react_voice
	movk	2,a0
	jauc	group_sound  	; group speech: wasted


noogy_early_check
	movi	l_lp,a0
	calla	get_tsl		; mark this event
	cmpi	008H,a1		; still tapping ?
	jrlo	nec5		; no, exit
	movk	1,a0
	move	a0,*a13(p_store1),w	; flag: exit
nec5	rets

noogy_last_hit
	movi	r_last_noogy,a7
	calla	xfer_otherguy
	calla	dec_his_p_hit	; cuz "reaction_start" is gonna inc it !!
	sleep	010H
	movi	000040004H,a0
	jsrp	animate_a0_frames
	retp

noogy_shaker
	movi	000090006H,a11
	calla	shake_a11
	movi	000000005H,a0
	movk	3,a1
	movk	4,a2
	jsrp	shake_him_up
	die


noogy_suspended
	movk	4,a7
	move	a7,@f_norepell,w	; no repell while in this mode
	sleep	2
	calla	get_his_action
	cmpi	act_noogy,a1
	jreq	noogy_suspended
	jruc	local_reaction_exit


edge_of_world_lineup
	call	a10
	calla	get_his_dfe		; a5 / a6
	cmpi	040H,a5
	jrlo	noog8
	cmpi	040H,a6
	jrhi	noog9

noog8	movi	060000H,a0
	calla	away_x_vel		; back up

	pushp	a11
	movk	8,a11
noog1	sleep	1
	call	a10
	dsj	a11,noog1
	calla	stop_me
	call	a10
	pullp	a11

noog9	retp


;***************************************************************

do_shake
	movi	act_shake,a1
	callr	local_init_special_act

	movk	010H,a0
	move	a0,*a13(p_stk),w	; define my stk table offset
	movi	000030002H,a9
	jsrp	animate2_a9

	movk	6,a11			; scan for this many frames
shake3
	calla	q_is_he_a_boss
	jrc	shakeno
	movi	010H,a0
	calla	strike_check_a0
	jrc	shake_hit
shakeno
	sleep	1
	dsjs	a11,shake3

shake_blocked
	sleep	10			; sucka !!
	movk	2,a9
	calla	get_char_ani2
	movk	5,a0
	jauc	backwards_ani

shake_hit
	calla	lights_on_hit

	move	b2,b2
	jrne	shake_blocked

	movi	shake_suspended,a7
	calla	takeover_him		; watch vs drones (ejbpatch)

	calla	match_him_with_me_f

	calla	me_in_front

	movi	038H,a11
	calla	get_his_a11_ani

        .if debug
	move	@f_colbox,a14,w			; collision box object ?
	jane	double_mframew_debug
        .endif

	movk	8,a0
	calla	his_group_sound			; his shook sound

	movk	5,a0
	jsrp	double_mframew			; lift up 2-gether

	movk	4,a0
shake4	move	a0,*a13(p_anicount),w
	mmtm	a12,a9,a11
	movk	3,a0
	jsrp	double_mframew
	mmfm	a12,a9,a11

	movk	8,a0
	calla	damage_to_him
	move	*a13(p_anicount),a0,w
	dsj	a0,shake4

	calla	double_next_a9
	sleep	3
	calla	double_next_a9
	sleep	3
	calla	double_next_a9

	clr	a10
	callr	xfer_him_to_a10_r

	sleep	008H			; hold with arms extended
	movk	2,a9
	calla	get_char_ani2
	movk	2,a0
	jsrp	backwards_ani
	jruc	local_reaction_exit

shake_suspended
	movk	4,a7
	move	a7,@f_norepell,w	; no repell while in this mode
	sleep	2
	calla	get_his_action
	cmpi	act_shake,a1
	jreq	shake_suspended
	jruc	local_reaction_exit

;***************************************************************

do_lao_spin
	movi	act_laospin,a1
	callr	local_init_special_act

	movk	2,a9
	calla	get_char_ani2
	movk	2,a0
	calla	init_anirate
	movk	1,a11
*
* spin without need to tap button
*
	movk	20,a0
hhspin3	move	a0,*a13(p_store1),l
	sleep	1
	calla	next_anirate
	move	*a13(p_store1),a0,w
	dsjs	a0,hhspin3
*
* now you gotta keep tapping !!
*
hhspin4	sleep	1
	calla	next_anirate
	movi	l_run,a0
	calla	get_tsl
	cmpi	00eH,a1			; still tapping button ?
	jrhi	hhspin_hit		; no, exit
	movi	013H,a0
	calla	strike_check_a0
	jrnc	hhspin4

hhspin_hit
	movk	3,a0
	calla	init_anirate
	movi	020H,a11
hhspin7	sleep	1
	calla	next_anirate
	dsjs	a11,hhspin7
	jruc	local_reaction_exit

;***********************************************************************

stat_do_lia_scream
	movi	act_lia_scream,a1
	callr	local_init_special_act
	clr	a9
	calla	get_char_ani2
	movk	3,a0
	jsrp	mframew				; lean forward

	calla	get_his_action
	cmpi	act_screamed,a1
	jaeq	r_scream			; double scream = I am screamed

	clr	a0
	move	a0,*a13(p_store2),w		; flag: no hit yet
	movk	3,a0
	calla	init_anirate
	movk	1,a0
	move	a0,*a13(p_store3),w		; sound call timer
	
	move	a13,a10				; pass lia proc over
	movk	6,a0
	calla	create_fx			; scream world shaker

	movk	1,a11
	movi	050H,a0
scream3	move	a0,*a13(p_store1),w
	sleep	1

scream_wake
	calla	next_anirate
*
* update scream sound call
*
	move	*a13(p_store3),a0,w
	dec	a0
	jrne	scream6
	movk	1,a0
	callr	local_ochar_sound			; scream sound
	movi	058H,a0
scream6	move	a0,*a13(p_store3),w			; sound call timer

	move	*a13(p_store2),a0,w
	jrne	scream2					; already hit ---> skip

	movi	011H,a0
	calla	strike_check_a0				; strike ?
	jrnc	scream2					; no ---> loop
;	move	b2,b2
;	jrne	scream2					; blocked ---> loop

	movk	1,a0
	move	a0,*a13(p_store2),w			; flag: hit !!!
	movi	020H,a0
	move	a0,*a13(p_store1),w			; wrap things up
	calla	dec_his_p_hit				; dont count scream as a hit

scream2	dsjs	a11,scream4

	movi	010H,a11	       				; reset counter
	create	pid_scream_wave,scream_wave

scream4	move	*a13(p_store1),a0,w
	dsj	a0,scream3

scream5	clr	a9
	calla	get_char_ani2
	calla	find_part2
	calla	find_part2
	calla	delete_slave
	movk	3,a0
	jauc	mframew					; and return


scream_wave
	move	a8,a10			; a10 = my lia
	movi	lia_anitab2,a0
	move	*a0(32),a9,l
	calla	gmo_proc
	move	a0,*a8(oslink),l	; link me

	movi	front_z+1,a0
	move	a0,*a8(ozpos),w

	push	a8			; save wave object
	move	a8,a0
	move	a10,a8
	calla	match_ani_points	; lineup wave with LIA !!!
	pull	a8			; get wave object
	calla	insobja8

	movk	5,a0
	jsrp	mframew
	jauc	delete_proj_and_die

;***********************************


;**********************************************************************

stat_do_fast_axe_up

;************
	movi	set_half_damage,a0
	calla	calla_for_him 		; sal is a little bit 2 powerfull
;************

	movi	000020002H,a9
	movk	4,a11
	jruc	axeup3

stat_do_axe_up
	movk	10,a11
	movi	000030002H,a9

axeup3	movi	act_axe_up,a1
	callr	local_init_special_act

	movk	5,a0
	callr	local_ochar_sound	; axe up sound

	movk	pow_flipkp,a0
	movb	a0,*a13(p_power)	; I am above flip kicks/punches
	jsrp	animate2_a9

	clr	a0
	move	a0,*a13(p_store1),w	; no hit yet
	movk	3,a0
	calla	init_anirate

;***************
asc2	sleep	1
	move	*a13(p_store1),a0,w
	jrne	asc3
	movi	015H,a0
	calla	strike_check_a0		; hit ?
	jrnc	asc3
	movk	1,a0
	move	a0,*a13(p_store1),w	; flag: hit
asc3	calla	next_anirate
	move	*a9,a0,l
	jrne	asc2
;***************

	movi	act_ssd,a1
	move	a1,*a13(p_action),w


	callr	local_zero_power
	move	a11,a0
	calla	prcslp			; fast or slow sleep

	calla	delete_slave		; no need 4 glow no moe !!

	addi	32,a9
	movk	2,a0
	jauc	mframew			; un ani / retp

;************************************
;do_axe_horz
;	movi	act_axe_horz,a1
;	callr	local_init_special_act
;
;	movi	000030000H,a9
;	jsrp	animate2_a9
;
;	movi	013H,a0
;	calla	strike_check_a0		; hit ?
;
;	movk	3,a0
;	jsrp	mframew
;
;	sleep	10
;	calla	delete_slave		; no need 4 glow no moe !!
;	movk	2,a0
;	jauc	mframew			; un ani / retp
;************************************


do_reflect
	movi	act_reflect,a1
	callr	local_init_special_act

	movk	7,a0
	callr	local_ochar_sound

	movk	3,a9
	calla	get_char_ani2
	movk	5,a0
	jsrp	mframew
	movk	5,a0
	jsrp	mframew

	movi	act_ref_sd,a1
	move	a1,*a13(p_action),w

	calla	delete_slave
	movk	3,a9
	calla	find_ani2_part2
	calla	find_part2
	movk	4,a0
	jsrp	mframew			; undo animation

	jruc	local_reaction_exit



xfer_him_to_a10_r
	move	*a13(p_otherproc),a0,l
	move	a10,*a0(pa10),l			; pass a10 offset along
	movi	r_a10_offset,a7
	jauc	takeover_him



;**********************************************************************
;**********************************************************************
;**********************************************************************

retract_strike
	clr	a1

retract_strike_act
	jsrp	act_mframew		; un hi kick

ret9	calla	back_to_normal
	retp

local_ochar_sound
	jauc	ochar_sound

local_zero_power
	clr	a0
	movb	a0,*a13(p_power)	; I am above flip kicks/punches
	rets

local_reaction_exit
	jauc	reaction_exit

local_init_special
	jauc	init_special

local_init_special_act
	jauc	init_special_act

**********************************************************************

	.end
