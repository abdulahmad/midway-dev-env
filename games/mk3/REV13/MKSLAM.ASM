**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: special moves										*
* 											     *
*  copyright (c) 1994-95 midway manufacturing	 					*
*											     *
**************************************************************************
	.file	"moves.asm"
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

;************************************************************************

do_air_slam
	movi	air_slam_jumps,a0
	jauc	ochar_jump

do_body_slam
	movi	body_slam_jumps,a0
	jauc	ochar_jump


air_slam_jumps
	.long	kano_air_body_slam	; 0
	.long	wait_forever		; 1
	.long	wait_forever		; 2
	.long	wait_forever		; 3
	.long	wait_forever		; 4

	.long	wait_forever		;
	.long	wait_forever		;
	.long	wait_forever		;
	.long	robo2_air_slam		; 8
	.long	wait_forever		;

	.long	wait_forever		;
	.long	wait_forever		;
	.long	wait_forever		;
	.long	wait_forever		;
	.long	smoke_air_slam		;


body_slam_jumps
	.long	kano_slam		; 0
	.long	sonya_slam		; 1
	.long	jax_slam		; 2
	.long	indian_slam		; 3
	.long	sz_slam			; 4
	.long	sw_slam			; 5
	.long	lia_slam		; 6
	.long	robo1_slam		; 7
	.long	robo2_slam		; 8
	.long	lao_slam		; 9
	.long	tusk_slam		; 10
	.long	sg_slam			; 11
	.long	st_slam			; 12
	.long	lk_slam			; 13
	.long	smoke_slam		; 14
	.long	0
	.long	0
	.long	kano_slam		; 15
	.long	sz_slam			; 16


ochar_slam_damage
	.word	018H	; 0 - kano
	.word	018H
	.word	018H
	.word	018H
	.word	018H

	.word	018H
	.word	018H
	.word	018H
	.word	018H
	.word	018H

	.word	018H
	.word	018H
	.word	018H
	.word	018H
	.word	018H

	.word	018H
	.word	018H
	.word	025H
	.word	025H


tusk_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	callr	throw_voice
	movk	3,a0
	jsrp	double_mframew
	movi	thrown_by_tusk,a7
	callr	xfer_to_thrown

	sleep	10
	movk	8,a0
	jsrp	mframew			; finish ani
	retp

;************************************************************************

lao_slam
	callr	body_slam_init
	movk	2,a0			; sleep time of grab ani
	jsrp	grab_animation

	movk	5,a0
	calla	ochar_sound
;	callr	throw_voice

	movk	3,a0
	jsrp	double_mframew

	movi	thrown_by_lao,a7
	callr	xfer_to_thrown

	movi	dont_touch,a0		; initial x vel
	movi	dont_touch,a1		; initial y vel
	movi	08000H,a2		; grav
	movk	2,a3			; ani speed
	jsrp	flight
	jauc	jump_up_land_jsrp

;************************************************************************

smoke_air_slam
	movk	6,a9			; my ani2 = air slam
	movi	039H,a11			; his ani = air slammed by kano
	callr	air_slam_init

	movi	face_opponent,a0	
	calla	calla_for_him

	movk	4,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	callr	throw_voice
	movk	3,a0
	jsrp	double_mframew

	movi	thrown_by_smoke,a7
	callr	xfer_to_thrown
	sleep	10
	jruc	drop_down_land_jump



smoke_slam
	movk	6,a9			; my ani2 = air slam
	callr	body_slam_init

	movk	4,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	callr	throw_voice
	movk	3,a0
	jsrp	double_mframew

	movi	thrown_by_smoke,a7
	callr	xfer_to_thrown
	sleep	10

	calla	face_opponent
	clr	a9
	calla	pose_a9
	calla	ground_ochar
	sleep	2
	retp

;************************************************************************

kano_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	callr	throw_voice
	movk	4,a0
	jsrp	double_mframew

	movi	thrown_by_kano,a7
	callr	xfer_to_thrown

	calla	do_next_a9_frame
	sleep	16

	movk	8,a0
	jsrp	mframew			; finish ani
	retp

thrown_by_kano
	movi	0a0000H,a0
	movi	-010000H,a1
	movi	06000H,a2
	movk	6,a3
	jsrp	flight

	movi	ochar_slam_damage,a0
	calla	get_his_char_word
	move	a0,a10
	calla	damage_to_me
	jauc	land_on_my_back

;************************************************************************

robo2_air_slam
	movk	6,a9			; my ani2 = air slam
	movi	039H,a11			; his ani = air slammed by robo2
	callr	air_slam_init

	calla	match_him_with_me_f	; line him up
	calla	double_next_a9		; him and me = first frame
	sleep	6			; still in the air
	movk	3,a0
	jsrp	double_mframew		; 2-gether
	movi	air_slamed_by_robo2,a7
	callr	xfer_to_thrown
	sleep	10
*
* fall to the ground
*
drop_down_land
	clr 	a0
	movi	018000H,a1
	movi	08000H,a2
	movi	never_ani,a3
	jsrp	flight
	jauc	jump_up_land_jsrp


drop_down_land_jump
	clr 	a0
	movi	018000H,a1
	movi	08000H,a2
	movi	never_ani,a3
	jsrp	flight
	jsrp	jump_up_land_jsrp
	jruc	local_reaction_exit



kano_air_body_slam
	clr	a9			; my ani2 = air slam
	movi	035H,a11			; his ani = air slammed by kano
	callr	air_slam_init

;	tsound	005H			; gotcha
	calla	match_him_with_me_f	; line him up
	calla	double_next_a9		; him and me = first frame

	sleep	8			; still in the air

	movk	2,a0
	jsrp	double_mframew		; step #2 = throw !!

;	calla	throw_voice

	movi	air_slamed_by_kano,a7
	callr	xfer_to_thrown

	sleep	10

*
* kano fall to the ground
*
	clr 	a0
	movi	018000H,a1
	movi	08000H,a2
	movi	never_ani,a3
	jsrp	flight
	jauc	jump_up_land_jsrp

air_slamed_by_kano
	movi	060000H,a0	; initial x vel
	movi	030000H,a1	; initial y vel
	movi	08000H,a2	; grav
	movk	4,a3		; ani speed
	jsrp	flight
*
* bounce on ground
*
	movk	2,a0
	calla	group_sound

	calla	shake_n_sound
	movi	010H,a10
	calla	damage_to_me

	movi	030000H,a0	; initial x vel
	movi	-060000H,a1	; initial y vel
	movi	08000H,a2	; grav
	movk	4,a3		; ani speed
	jsrp	flight

	jauc	land_on_my_back

;************************************************************************

lk_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	callr	throw_voice
	movk	3,a0
	jsrp	double_mframew
	movi	thrown_by_lk,a7
	callr	xfer_to_thrown

	sleep	10
	movk	3,a0
	jsrp	mframew			; finish ani
	retp


sonya_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	callr	throw_voice
	movk	4,a0
	jsrp	double_mframew
	movi	thrown_by_sonya,a7
	callr	xfer_to_thrown

	sleep	16

	movk	8,a0
	jsrp	mframew			; finish ani
	retp


jax_slam
	callr	body_slam_init

	movi	set_ignore_y,a0
	calla	calla_for_him		; scroller: dont follow him

	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	callr	read_lp_tick_state
	move	a0,*a13(p_store1),w	; remember when he 1st pressed low punch
	clr	a0
	move	a0,*a13(p_store2),w	; flag: multislam ok (for now)
	movk	4,a0
	move	a0,*a13(p_store3),w	; total slams allowed

	callr	throw_voice

jslam5 	calla	double_next_a9
	movk	3,a0
	jsrp	jax_slam_sleep
	move	*a9,a0,l
	jrne	jslam5			; animate together
*
* effects
*
	movk	5,a0
	calla	ochar_sound		; jax slam on ground sound
	movk	2,a0
	calla	his_group_sound		; him: wasted voice
	movi	000090009H,a11
	calla	shake_a11
*
* damage
*
	movi	00aH,a0
	move	a0,a14
	calla	add_combo_damage
	calla	damage_to_him 		; inflict pain
	calla	inc_his_p_hit

	calla	am_i_joy
	jrnc	jslam6			; drone = again !!
	move	*a13(p_store2),a0,w
	jrne	jax_slam_over		; too bad ---> no moe slammin'

jslam6	move	*a13(p_store3),a0,w
	dec	a0
	jreq	jax_slam_over		; maximum slams allowed !!!
	move	a0,*a13(p_store3),w	; count em all

	movk	4,a0
	jsrp	jax_slam_sleep

	movi	030H,a0
	move	a0,@f_norepell,w  	; disable repell !!
	movk	4,a5
	jsrp	jax_multi_slam_pose
	movk	3,a5
	jsrp	jax_multi_slam_pose
	movk	2,a5
	jsrp	jax_multi_slam_pose

	calla	flip_multi		; flip me
	clr	a1
	movi	-00fH,a0
	calla	multi_adjust_xy		; lineup with previous flipped frame
	push	a8
	move	a10,a8
	calla	flip_multi		; flip him
	pull	a8

	movk	2,a5
	jsrp	jax_multi_slam_pose
	jruc	jslam5


jax_slam_over
	movi	thrown_by_jax,a7
	callr	xfer_to_thrown
	sleep	10

	movk	3,a14
	movi	023H,a9
	calla	find_ani_part_a14	; out of slam ani
	movk	5,a0
	jsrp	mframew			; finish ani
	retp

*
* a5 = offset input
*
jax_multi_slam_pose
	push	a5
	movi	028H,a9
	calla	get_his_char_ani
	move	a9,a11	    			; a11 = his ani (flipped by me)
	move	*a13(p_otherguy),a10,l	; a10 = his obj
	movi	023H,a9
	calla	find_ani_part2			; jax ---> "slam" ani
	pull	a5
	move	a5,a4
	sll	5,a4
	add	a4,a9				; a9 ---> jax correct "slam" frame
	sll	6,a5
	add	a4,a11
	add	a5,a11				; a11 ---> his matching "slammed"
	calla	double_next_a9			;
	movk	3,a0
	jruc	jax_slam_sleep

*
* returns carry set = still pressing hi punch (only)
*
jax_slam_sleep
	calla	prcslp

	movi	l_hp,a0
	calla	get_tsl

;	cmpi	8,a1
	cmpi	12,a1
	jrhi	multi_slam_no		; not tapping hi punch = no multi slam

	callr	read_lp_tick_state
	move	*a13(p_store1),a1,w	; remember when he 1st pressed low punch
	cmp	a0,a1			; has he touched it since ?
	jreq	multi_slam_yes		; no ---> still kool

multi_slam_no
	movk	1,a0
	move	a0,*a13(p_store2),w	; flag: no multislam

multi_slam_yes
	retp

read_lp_tick_state
	movi	l_lp,a0
	move	*a8(oid),a1,w
	cmpi	pid_p1,a1	; player 1 ??
	jreq	lts4
    	addk	16,a0		; no, point to player 2's tick ram
lts4	move	*a0,a0,w	; when was the last time we did this ?
	rets

;**************************************************************************

sg_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	callr	throw_voice
	calla	me_in_back

	calla	double_next_a9
	sleep	4
	calla	double_next_a9
	sleep	4
	calla	double_next_a9
	sleep	10

	movk	3,a0
	jsrp	double_mframew
	movi	thrown_by_sg,a7
	callr	xfer_to_thrown
	calla	do_next_a9_frame
	sleep	10

	movk	6,a0
	jauc	mframew			; finish ani / retp


st_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3
	callr	throw_voice
	movk	3,a0
	jruc	slam_ani2

indian_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3
	callr	throw_voice
	movk	3,a0

slam_ani2
	jsrp	double_mframew
	movi	thrown_by_indian,a7
	callr	xfer_to_thrown

	sleep	10

	movk	8,a0
	jsrp	mframew			; finish ani
	retp

sz_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3
	calla	double_next_a9		
	sleep	8			; hold 'em up for a sec...

	calla	me_in_back
	callr	throw_voice
	movk	4,a0
	jsrp	double_mframew
	movi	thrown_by_sz,a7
	callr	xfer_to_thrown
	sleep	12			; hold last frame

	calla	do_next_a9_frame	; retract
	sleep	5
	retp


sw_slam
	callr	body_slam_init
	movk	4,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	2

	callr	throw_voice
	movk	4,a0
	jsrp	double_mframew
	movi	thrown_by_swat,a7
	callr	xfer_to_thrown

	sleep	010H
	movk	8,a0
	jsrp	mframew			; finish ani
	retp


lia_slam
	clr	a0
	calla	ochar_sound		; lia hair whip sound

	callr	body_slam_init
	movk	1,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	3

	movk	4,a0
	jsrp	double_mframew
	movi	thrown_by_lia,a7
	callr	xfer_to_thrown
	sleep	8
	movk	4,a0
	jauc	mframew			; finish ani / return


robo2_slam
	callr	body_slam_init
	movk	3,a0			; sleep time of grab ani
	jsrp	grab_animation
	sleep	4

	movk	7,a0
	calla	ochar_sound

	movk	4,a0
	calla	init_anirate
	movi	020000H,a0
	calla	away_x_vel

	movi	-0180000H,a0
	move	a0,*a8(oyvel),l		; initial UP vel
	movi	01a000H,a0
	move	a0,*a8(ograv),l
	callr	stick_him_with_me
*
* airborn stuff
*
r2slam1	sleep	1
	calla	sans_repell_3
	callr	stick_him_with_me
	move	*a13(p_anicount),a0,w
	dec	a0
	move	a0,*a13(p_anicount),w
	jrne	r2slam3						; not time yet

	move	*a13(p_anirate),*a13(p_anicount),w	; reload p_anirate
	move	*a9,a0,l
	jreq	r2slam3						; ani done !!
	calla	double_next_a9

r2slam3	move	*a8(oypos),a1,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	addi	010H,a0
	cmp	a0,a1			; hit ground yet ?
	jrlt	r2slam1 		; no, keep falling

	calla	sans_repell		; give us a sec..
	movi	000080008H,a11
	calla	shake_a11
	calla	rsnd_ground
	movk	2,a0
	calla	his_group_sound		; him: wasted voice
	calla	stop_me
	calla	stop_him

	movi	thrown_by_robo2,a7
	callr	xfer_to_thrown

	sleep	14
	calla	face_opponent
	calla	ground_player
	jsrp	do_backup
	jruc	local_reaction_exit

*
* bounce away from him
*
;	calla	face_opponent
;	movi	01bH,a9
;	calla	get_char_ani
;	addi	32,a9
;	movi	040000H,a0		; initial x vel
;	movi	-080000H,a1		; initial y vel
;	movi	06000H,a2		; grav
;	movk	4,a3			; ani speed
;	jsrp	flight
;	jauc	jump_up_land


stick_him_with_me
	move	*a8(oxvel),a0,l
	move	a0,*a10(oxvel),l		; illegitimate way
	move	*a8(oyvel),*a10(oyvel),l
	push	a8
	move	a10,a8
	calla	set_x_vel			; set him the legitimate way
	pull	a8
	rets
	

robo1_slam
	callr	body_slam_init

	clr 	a0
	calla	ochar_sound
	movk	1,a0			; sleep time of grab ani
	jsrp	grab_animation

	movk	2,a0
	jsrp	mframew			; grab him quickly....

	movk	1,a0
	calla	ochar_sound		; mechanical arm throw sound
	movk	3,a0
	jsrp	double_mframew
	movi	thrown_by_robo,a7
	callr	xfer_to_thrown

	movk	2,a0
	calla	ochar_sound		; mechanical arm IN sound
	movk	3,a0
	jauc	mframew			; retract arm / retp

;*************************************************************************

thrown_by_lk
thrown_by_sonya
	movi	070000H,a0
	clr	a1
	movi	06000H,a2
	movk	6,a3
	jsrp	flight

	movi	ochar_slam_damage,a0
	calla	get_his_char_word
	move	a0,a10
	calla	damage_to_me
	jauc	land_on_my_back


thrown_by_jax
	clr	a10
	jruc	common_slam

thrown_by_robo2
	calla	ground_player
	movi	01eH,a9
	calla	find_ani_part2		; knock down on back frame
	calla	do_next_a9_frame
	movk	2,a0
	calla	group_sound		; wasted
	calla	rsnd_ground
	movi	000080008H,a11
	calla	shake_a11

	movi	32,a10
	calla	damage_to_me

	movi	-030000H,a0		; initial x vel
	movi	-0a0000H,a1		; initial y vel
	movi	08000H,a2		; grav
	movk	4,a3			; ani speed
	jsrp	flight
	jauc	land_on_my_back


thrown_by_sg
	callr	ground_slammed_init

	calla	inc_p_hit
	movi	35,a10
	move	*a13(p_damage),a0,w
	add	a10,a0
	move	a0,*a13(p_damage),w	; used in combos
	calla	damage_to_me

	sleep	3
	movi	040000H,a0		; initial x vel
	movi	-0a0000H,a1		; initial y vel
	movi	08000H,a2		; grav
	movk	4,a3			; ani speed
	jsrp	flight			; HIGH BOUNCE !!!

	clr	a10			; we already gave out damage
	jruc	common_slam

thrown_by_smoke
thrown_by_tusk
air_slamed_by_robo2
thrown_by_lia
thrown_by_robo
thrown_by_swat
thrown_by_indian
thrown_by_lao
	movi	32,a10

common_slam
	callr	ground_slammed_init
	move	a10,a10
	jreq	no_slam_damage		; zero slam damage
	calla	damage_to_me

no_slam_damage
	movi	030000H,a0		; initial x vel
	movi	-060000H,a1		; initial y vel
	movi	08000H,a2		; grav
	movk	4,a3			; ani speed
	jsrp	flight
	jauc	land_on_my_back


ground_slammed_init
	push	a10
	calla	ground_player
	movi	01eH,a9
	calla	find_ani_part2		; knock down on back frame
	calla	do_next_a9_frame
	movk	2,a0
	calla	group_sound		; wasted
	calla	shake_n_sound
	pull	a10
	rets

thrown_by_sz
	movi	060000H,a0		; initial x vel
	movi	-060000H,a1		; initial y vel
	movi	0a000H,a2		; grav
	movi	never_ani,a3   		; ani speed
	jsrp	flight

	movi	25,a10
	calla	damage_to_me
	jauc	land_on_my_back

;************************************************************************

do_back_breaker
	calla	air_init_special	; this is considered a special move

	calla	stop_me
	calla	stop_him
	movi	clear_inviso,a0
	calla	calla_for_him
	movi	clear_shadow_bit,a0
	calla	calla_for_him
	calla	clear_shadow_bit

	movi	038H,a0
	move	a0,@f_norepell,w 	; disable repell !!
	movi	flipped_pause,a7
	calla	takeover_him_sr
	movi	act_backbreak,a0
	move	a0,*a13(p_action),w		; define my action
	move	*a13(p_otherproc),a1,l
	move	a0,*a1(pa11),l		; pass my action for him to look 4

	movk	6,a0
	calla	ochar_sound		; gotcha !
	calla	me_in_front

	movk	5,a9
	calla	get_char_ani2
	calla	do_next_a9_frame	; pose: frame 1 of breaking a back
	movi	000H,a0
	movi	000H,a1
	calla	multi_adjust_xy
*
* pose him ---> back getting snapped
*
	movi	player_normpal,a0
	calla	calla_for_him

	movi	last_knockdown_frame,a0
	calla	calla_for_him

	calla	match_him_with_me
	movi	back_break_adjusts,a0
	calla	get_his_char_long
	move	a0,a1
	sra	16,a1
	sll	16,a0
	sra	16,a0
	calla	adjust_him_xy		; line him up wid me !!!

	sleep	006H			; pause in the air to let em know !!

	clr	a0
	movi	020000H,a1
	movi	0a000H,a2
	movi	never_ani,a3
	movi	bb_fall_call,a6
	jsrp	flight_call
	calla	stop_him

	movk	5,a9
	calla	get_char_ani2
	addi	32,a9
	calla	do_next_a9_frame	; breaker frame 2

	movi	back_break_adjusts2,a0
	calla	get_his_char_long
	move	a0,a1
	sra	16,a1
	sll	16,a0
	sra	16,a0
	calla	adjust_him_xy		; line him up wid me !!!

	movk	6,a9
	calla	get_char_ani2
	move	*a13(p_otherguy),a0,l
	move	*a0(ochar),a0,w
	sll	5,a0
	add	a0,a9
	move	a9,*a13(p_store5),l
	movi	do_next_a9_frame,a0
	calla	calla_for_him
	
	sleep	3

	movk	00bH,a0
	calla	ochar_sound		; bax break
	movk	2,a0
	calla	his_group_sound		; him = wasted !!
	movi	000050005H,a11
	calla	shake_a11

	sleep	3
	movi	01aH,a0
	calla	damage_to_him 		; inflict pain
	movi	post_broken_back,a7
	calla	takeover_him

	sleep	018H
	jauc	do_backup


back_break_adjusts
	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH

	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH

	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH
	.word	00aH,-06bH

back_break_adjusts2
	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H

	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H

	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H

	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H
	.word	0,070H



bb_fall_call
	move	*a13(p_otherguy),a0,l
	move	*a8(oyvel),*a0(oyvel),l
	rets

post_broken_back
	movi	038000H,a0
	movi	-080000H,a1
	movi	0a000H,a2
	movi	never_ani,a3
	jsrp	flight
	jruc	land_on_my_back

last_knockdown_frame
	movi	01eH,a9
	calla	get_char_ani
	calla	find_last_frame
	calla	do_next_a9_frame
	rets

;************************************************************************

xfer_to_thrown
	calla	takeover_him
	move	*a13(p_otherproc),a0,l
	move	a11,*a0(pa9),l			; pass animation
	rets

;************************************************************************

grab_animation
	push	a0
	movi	023H,a9
	calla	get_char_ani
	pull	a0
	jauc	mframew

;************************************************************************

body_slam_init
	callr	grab_voice
	calla	init_special

	calla	lights_on_slam

	move	*a13(p_otherguy),a0,l
	calla	delete_slave

	movi	030H,a0
	move	a0,@f_norepell,w 		; disable repell !!

	movi	ochar_slammed_anis,a0
	calla	get_char_word
;**********
;	move	*a8(ochar),a9,w
;	add	a0,a9				; add "flipped by me" offset
;**********
	move	a0,a9
	calla	get_his_char_ani
	move	a9,a11	    			; a11 = his ani (flipped by me)
	move	*a13(p_otherguy),a10,l	; a10 = his obj
	movi	023H,a9	    			;  a9 = my "throw" animation
	calla	get_char_ani

	movi	face_opponent,a0
	calla	calla_for_him
	movi	back_to_normal,a0
	calla	calla_for_him
	movi	clear_inviso,a0
	calla	calla_for_him

	movi	act_bodyslam,a0
	callr	xfer_him_to_flipped_pause

        .if debug
	move	@f_colbox,a14,w			; collision box object ?
	jane	body_slam_debug
        .endif

	rets


ochar_slammed_anis
	.word	026H
	.word	027H
	.word	028H
	.word	029H
	.word	02aH

	.word	02bH
	.word	02cH
	.word	02dH
	.word	02eH
	.word	02fH

	.word	030H
	.word	031H
	.word	032H
	.word	033H
	.word	034H

	.word	035H
	.word	036H
	.word	026H
	.word	02aH

**************************************************************************
*											     *
*  air_slam_init										     *
* 											     *
*  Input:  a9 = anitab2 offset								     *
*         a11 = anitab offset for otherguy				     		*
*											     *
**************************************************************************
air_slam_init
	calla	air_init_special

	calla	lights_on_slam

	move	*a13(p_otherguy),a0,l
	calla	delete_slave

	push	a9
	move	a11,a9
	calla	get_his_char_ani		; his ani = air flipped by me
	move	*a13(p_otherguy),a10,l	; a10 = his obj
	move	a9,a11				; a11 = his "air thrown" ani
	pull	a9
	calla	get_char_ani2			; a9 = my "air throw" animation

	movi	act_bodyslam,a0
	callr	xfer_him_to_flipped_pause

	movi	030H,a0
	move	a0,@f_norepell,w 		; disable repell !

        .if debug
	move	@f_colbox,a14,w			; collision box object ?
	jane	air_slam_debug
        .endif

	rets

**************************************************************************
*											     *
*  xfer_him_to_flipped_pause - given:							     *
* 											     *
*  a0 = my new action									     *
*											     *
**************************************************************************
xfer_him_to_flipped_pause
	move	a0,*a13(p_action),w		; define my action

	push	a0
	movi	flipped_pause,a7
	calla	takeover_him_sr
	move	*a13(p_otherproc),a1,l
	pull	a0

	move	a0,*a1(pa11),l			; pass my action for him to look 4
	rets

*
* input: a11 = action being done on me !
*
flipped_pause
	calla	lights_on_slam

fpause	sleep	1
	move	*a13(p_otherproc),a0,l
	move	*a0(p_action),a0,w
	cmp	a0,a11				; still doing the same thing ?
	jreq	fpause				; yes

	calla	ground_player
;	callr	clear_vflip

local_reaction_exit
	jauc	reaction_exit

grab_voice
	movk	3,a0
	jruc	local_group_sound

throw_voice
	movk	4,a0

local_group_sound
	jauc	group_sound

;*************************************************************************


	.end


