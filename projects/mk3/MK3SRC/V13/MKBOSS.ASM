**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: BOSS CODE										*
* 											     *
*  copyright (c) 1995 Midway Manufacturing							*
*											     *
**************************************************************************
	.file	'mkboss.asm'
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
	.text

sk_branches
	.long	motaro_hit0	; 0 - not ever called
	.long	sk_hit1		; 1
	.long	motaro_hit2	; 2
	.long	sk_hit3		; 3
	.long	sk_uppcutted	; 4
	.long	sk_comboed	; 5
	.long	sk_stumble	; 6
	.long	sk_slided	; 7
	.long	boss_stalk	; 8
	.long	sk_hard_comboed	; 9
	.long	boss_stalk	; a
	.long	boss_stalk	; b
	.long	boss_stalk	; c
	.long	boss_stalk	; d
	.long	boss_stalk	; e
	.long	boss_stalk	; f
	.long	sk_stalk	; 10 - used !!
	.long	boss_finish_him	; 11
	.long	sk_collapse	; 12

motaro_branches
	.long	motaro_hit0		; 0 - not ever called
	.long	motaro_hit1		; 1
	.long	motaro_hit2		; 2
	.long	motaro_hit3		; 3
	.long	motaro_upcutted		; 4
	.long	motaro_comboed		; 5
	.long	motaro_stumble		; 6
	.long	motaro_slided		; 7
	.long	motaro_flip_kicked	; 8
	.long	motaro_hard_comboed	; 9
	.long	boss_stalk		; a
	.long	boss_stalk		; b
	.long	boss_stalk		; c
	.long	boss_stalk		; d
	.long	boss_stalk		; e
	.long	boss_stalk		; f
	.long	boss_stalk		; 10
	.long	boss_finish_him		; 11
	.long	motaro_collapse		; 12


boss_stalk
	callr	q_is_he_car		; car = cornered and reacting !
	jrnc	boss1

	movi	300,a0
	calla	randper
	jrc	sk_laugh		; chance of laughing like a smart ass
	movi	800,a0
	calla	randper
	jrc	boss_ease_back		; yes = good chance of backing up

boss1	callr	q_ok_motaro_sweep
	jrnc	boss2
	movi	300,a0
	calla	randper
	jrc	motaro_sweep		; within sweep range = try it

boss2	callr	b_get_x_dist
	cmpi	>a0,a3
	jrlo	boss_close

boss_far
	movi	200,a0
	calla	randper
	jrc	motaro_nothing			; chance of nothin !!

	movi	mhe_motaro_far_attax,a0
	callr	get_mhe_long
	jump	a0

motaro_nothing
	calla	random_do
	.word	2
	.long	motaro_hop
	.long	motaro_hip_jump

mhe_motaro_far_attax
	.long	motaro_far_med
	.long	motaro_far_hard
	.long	motaro_far_easy

motaro_far_med
	movi	333,a0
	calla	randper
	jrc	motaro_zap		; slight chance of zap

	calla	random_do
	.word	2
	.long	motaro_tele
	.long	motaro_hop

motaro_far_hard
	movi	500,a0
	calla	randper
	jrc	motaro_zap		; slight chance of zap
	calla	random_do
	.word	2
	.long	motaro_tele
	.long	motaro_hop

motaro_far_easy
	movi	100,a0
	calla	randper
	jrc	motaro_zap		; slight chance of zap
	calla	random_do
	.word	2
	.long	motaro_tele
	.long	motaro_hop

;*******************************

boss_close
	movi	>40*3,a10
	callr	q_is_this_a_joke
	jrnc	bossc2
	movi	500,a0
	calla	randper
	jrc	motaro_stupid_stance

bossc2	movi	200,a0
	calla	randper
	jrnc	bossc4

	movi	>40,a0
	movi	>10,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause

bossc4	movi	>40*4,a10
	movi	>d0,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance
	callr	q_ok_motaro_sweep
	jrnc	bossc7
	movi	200,a0
	calla	randper
	jrc	motaro_sweep

bossc7	movi	>40*4,a10
	movi	>48,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance

	calla	is_he_airborn
	jrnc	boss_close_attack

	calla	get_his_action
	cmpi	act_angle_jump,a1
	jreq	boss_counter_angle

boss_wait_land
	jsrp	swait_land_jsrp		; let em land
	jruc	boss1

boss_finish_him
boss_close_attack
	calla	random_do
	.word	3
	.long	motaro_punch
	.long	motaro_grab_punch
	.long	motaro_kick

;******************************************************************

motaro_zap
	movi	>1f,a0
	jsrp	do_zap

	callr	q_am_i_losing
	jrc	b_reaction_exit

	movi	100,a0
	calla	randper
	jrc	b_reaction_exit

	movi	>20,a0
	movi	>20,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit

;******************************************************************

motaro_tele
	calla	init_special

	tsound	>27			; morph sound
	calla	set_nocol
	movk	5,a9
	calla	get_char_ani
	movk	3,a0
	jsrp	mframew
	calla	set_inviso
*
* figure out where to teleport to !!
*
	calla	q_is_he_cornered
	jrc	tele_cornered

	calla	match_me_with_him
	clr	a1
	movi	->70,a0
	calla	multi_adjust_xy		; behind him
	jruc	untele

tele_cornered
	calla	match_me_with_him
	calla	flip_multi
	clr	a1
	movi	->70,a0
	calla	multi_adjust_xy

untele	sleep	3
	calla	ground_player
	calla	clear_inviso
	movk	3,a0
	jsrp	mframew
	calla	clear_nocol
	jruc	b_reaction_exit

;******************************************************************

d_vfar	.set	>100
d_far	.set	>e0
d_med	.set	>90
d_close	.set	>60



sk_stalk
	callr	q_boss_stupid		; should I be stupid and "talk trash"
	jrc	sk_stupid		; yea, I am winning

	callr	b_get_x_dist
	cmpi	d_close,a3
	jrlo	sk_close
	cmpi	d_med,a3
	jrlo	sk_medium
	cmpi	d_far,a3
	jrlo	sk_far			; branch according to distance

	movi	200,a0
	calla	randper
	jrc	sk_zap			; REAL far = SHAO KAHN zap

sk_stalk_far
	movi	>40*4,a10
	movi	d_far,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance

	movi	500,a0
	calla	randper
	jrc	sk_far			; normal far

sk_stalk_med
	movi	>40*4,a10
	movi	d_med,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance

	movi	500,a0
	calla	randper
	jrc	sk_medium		; normal far

	movi	>40*4,a10
	movi	d_close,a11
	jsrp	d_stalk_a11		; close stalk

sk_close
	callr	q_is_he_car		; car = cornered and reacting !
	jrnc	skcl3
	movi	700,a0
	calla	randper
	jrc	boss_ease_back		; yes = good chance of backing up

skcl3	calla	random_do
	.word	4
	.long	sk_hammer
	.long	sk_punch
	.long	sk_kick
	.long	sk_charge


sk_far	calla	random_do
	.word	3
	.long	sk_zap
	.long	sk_charge
	.long	sk_air_charge

sk_medium
	calla	random_do
	.word	3
	.long	sk_hammer
	.long	sk_charge
	.long	sk_air_charge
	.long	sk_zap

;*****************************

sk_laugh
	calla	init_special

	movi	>00040003,a0			; 4=1st sound/ 2 entries
	calla	rsnd_ochar_sound
	movk	>0b,a9
	calla	get_char_ani
	movi	>0005000c,a0	
	jsrp	animate_a0_frames		; laugh animation
	jruc	b_reaction_exit

;*****************************

sk_stupid_stance
	movi	>40*3,a10
	callr	q_is_this_a_joke
	jrc	ss1

motaro_stupid_stance
	movi	>30,a0
	movi	>30,a1
	calla	randu_minimum
	move	a0,a10				; random time of stupidity

ss1	calla	stance_setup
ss3	calla	next_anirate
	calla	check_winner_status
	calla	am_i_facing_him
	janc	d_turnaround			; keep facing him
	sleep	1
	dsj	a10,ss3
	jruc	b_reaction_exit

;*****************************

sk_zap
	clr	a0
	calla	group_sound			; voice: attack

	movi	>1d,a0
	jsrp	do_zap
	jruc	b_reaction_exit

;*****************************

sk_hammer
	calla	init_special

	clr	a0
	calla	group_sound   		; voice: attack

	movi	>1a,a9
	movk	2,a11			; stk offset
	movk	1,a0			; ani speed
	movk	2,a10			; frames to look for collision
	clr	a1			; act !
	jsrp	striker
	jrnc	boss_close_miss
	sleep	>0e
	jruc	boss_post_hit

;*****************************

sk_kick
	calla	init_special

	clr	a0
	calla	group_sound   		; voice: attack

	movi	>11,a9
	movk	1,a11			; stk offset
	movk	2,a0			; ani speed
	movk	2,a10			; frames to look for collision
	clr	a1			; act !
	jsrp	striker
	jrnc	boss_close_miss
	sleep	>0e
	jruc	boss_post_hit

;*****************************

sk_punch
	calla	init_special

	clr	a0
	calla	group_sound   		; voice: attack

	movi	>0e,a9
	clr	a11			; stk offset
	movk	3,a0			; ani speed
	movk	1,a10			; frames to look for collision
	clr	a1			; act !
	jsrp	striker
	jrnc	boss_close_miss
	sleep	>0e
	jruc	boss_post_hit

;*****************************

sk_charge
	calla	init_special

	clr	a0
	calla	group_sound   		; voice: attack

	clr	a0
	calla	ochar_sound		; shadow shoulder

	movk	>19,a9
	calla	get_char_ani		; charge animation
	movk	3,a0
	calla	init_anirate

	movk	1,a0
	calla	create_fx		; shadow

	movi	>80000,a0
	calla	towards_x_vel
	movi	>14,a11
	movk	6,a10			; # of frames without collision check

kchg6	sleep	1
	calla	next_anirate
	dsj	a10,kchg3		; not time to check for collision yet
	movk	1,a10
	movk	3,a0
	calla	strike_check_a0
	jrnc	kchg3

	calla	stop_me
	movk	>19,a9
	calla	get_char_ani		; charge animation
	calla	find_last_frame
	calla	do_next_a9_frame	; pose on last frame of charge
	sleep	>20
	jruc	kchg8

kchg3	dsj	a11,kchg6
*
* decellerate
*
	calla	am_i_facing_him
	jrnc	kchg7			; not facing him ---> stop now
	movk	8,a11
kchg5	move	*a8(oxvel),a0,l
	abs	a0
	move	a0,a1
	sra	2,a1
	sub	a1,a0

	move	a0,a2
	sra	3,a2
	sub	a2,a0

	calla	towards_x_vel
	sleep	1
	dsj	a11,kchg5

kchg7	calla	stop_me
	sleep	8

kchg8	movk	>19,a9
	calla	find_ani_part2
	movk	3,a0
	jsrp	mframew
	jruc	b_reaction_exit

;********************************************

sk_air_charge
	calla	init_special

	clr	a0
	calla	group_sound   		; voice: attack
	clr	a0
	calla	ochar_sound		; shadow shoulder
	calla	set_nocol		; now this is POWER !!!

	movk	>14,a9
	calla	get_char_ani		; charge animation
	calla	do_next_a9_frame
	sleep	3
	calla	do_next_a9_frame
	sleep	3			; 1st 2 frames on ground

	movk	4,a0
	calla	init_anirate

	movk	1,a0
	calla	create_fx		; shadow

	movi	->40000,a1
	move	a1,*a8(oyvel),l
	movi	>a0000,a0
	calla	towards_x_vel
	movi	>10,a11

;	movk	6,a10			; # of frames without collision check
	movk	4,a10			; # of frames without collision check

achg6	sleep	1
	calla	next_anirate
	dsj	a10,achg3		; not time to check for collision yet
	movk	1,a10
	movk	5,a0
	calla	strike_check_a0
	jrnc	achg3

;	calla	clear_nocol		; now this was POWER !!!

	calla	stop_me
	movk	>14,a9
	calla	get_char_ani		; charge animation
	calla	find_last_frame
	calla	do_next_a9_frame	; pose on last frame of charge
	sleep	>18
	jruc	achg8

achg3	dsj	a11,achg6
*
* decellerate
*
	calla	clear_nocol		; now this was POWER !!!

	calla	am_i_facing_him
	jrnc	achg7			; not facing him ---> stop now
	movk	8,a11
achg5	move	*a8(oxvel),a0,l
	abs	a0
	move	a0,a1
	sra	2,a1
	sub	a1,a0

	move	a0,a2
	sra	3,a2
	sub	a2,a0

	calla	towards_x_vel
	sleep	1
	dsj	a11,achg5

achg7	calla	stop_me
	sleep	8

achg8	movk	>14,a9
	calla	find_ani_part2
	calla	do_next_a9_frame
	jauc	drop_down_land_jump

;********************************************

sk_stupid
	calla	random_do
	.word	5
	.long	boss_ease_back
	.long	sk_taunt
	.long	sk_laugh
	.long	sk_stupid_stance
	.long	sk_stupid_stance


sk_taunt
	movi	>00080003,a0		; 8 = 1st entry / 3 entries
	calla	rsnd_ochar_sound

	movi	>18,a9
	calla	get_char_ani

	movk	2,a10
riwk5	movk	3,a0
	jsrp	mframew			; point

	movk	6,a0
	calla	randu
	addk	10,a0
	calla	prcslp
	dsj	a10,riwk5

	movi	>18,a9
	calla	find_ani_part2
	calla	find_part2
	movk	3,a0
	jsrp	mframew			; unpoint

	movi	>10,a0
	movi	>10,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit

**************************************************************************
*											     *
*    MOTARO ATTAX									     *
*											     *
**************************************************************************
motaro_sweep
	movk	2,a0
	callr	b_ochar_sound

	movi	>14,a9
	movk	3,a0
	clr	a1
	movk	2,a10
	movk	2,a11
	jsrp	striker
	jrc	mot_sweep_hit

	movk	4,a0
	jsrp	mframew
	movk	4,a0
	jsrp	mframew
	jruc	b_reaction_exit

mot_sweep_hit
	sleep	8
	movk	4,a0
	jsrp	mframew
	sleep	10
	movk	4,a0
	jsrp	mframew

	calla	d_front_me_a5
	cmpi	>120,a5
	jrlo	motaro_hip_jump

	movi	500,a0
	calla	randper
	jrc	motaro_hip_jump

	movi	->a0000,a0
	movi	->b0000,a1
	movi	>1a,a9
	jruc	mhop7

;******************************************************************

boss_counter_angle
	calla	is_towards_me
	jrnc	boss_wait_land		; away from me !!
	callr	motaro_easy_randper
	jrnc	boss_wait_land		; away from me !!
	callr	b_get_x_dist
	cmpi	>80,a3
	jrhi	boss_wait_land		; far from me
	jruc	motaro_punch		; close to me = punch it !!

;******************************************************************

boss_ease_back
	calla	get_walk_info_b
	push	a0
	move	a2,a9
	move	a1,a0
	calla	set_x_vel
	calla	get_char_ani
	pull	a0
	calla	init_anirate

	movi	>60,a10
ease3	calla	am_i_facing_him
	janc	d_turnaround
	sleep	1
	callr	b_get_x_dist
	cmpi	>100,a3
	jrhi	ease5			; far enough !!

	callr	b_check_winner_status
	callr	b_next_anirate
	callr	b_beware
	callr	b_get_x_dist  		; a3 = distance tween us
	dsj	a10,ease3   		; max time to wait

ease5	movi	>10,a0
	movi	>10,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit

;******************************************************************

motaro_hop
	movk	2,a0
	callr	b_ochar_sound

	callr	b_get_x_dist
	cmpi	>e0,a0
	movi	>1a,a9
	jrlo	mhop3

	movi	->a0000,a0
	movi	->70000,a1
	jruc	mhop7			; super long hop

mhop3	calla	get_char_ani
	movi	>00020003,a0
	jsrp	animate_a0_frames	; 1st 2 frames on ground
*
* take off !!
*
	movi	>30000,a0
	movi	>70000,a1
	move	a0,a1
	neg	a1
	movi	->a0000,a0
	
mhop7	movi	>8000,a2		; grav
	movk	4,a3			; ani speed
	jsrp	flight
	calla	shake_n_sound

	movi	>1a,a9
	calla	find_ani_part2
	movk	3,a0
	jsrp	mframew			; hop hand animation
	jruc	b_reaction_exit

;******************************************************************

;motaro_hip2_jump
;	jsrp	motaro_hip_jsrp
;	jsrp	motaro_hip_jsrp
;	jruc	b_reaction_exit

motaro_hip_jump
	calla	check_winner_status	; dont hop if things are done !

	jsrp	motaro_hip_jsrp
	jruc	b_reaction_exit

motaro_hip_jsrp
	clr	a0
	callr	b_ochar_sound

	movi	>1a,a9			; hip = hop in place
	calla	get_char_ani
	movi	>00020003,a0
	jsrp	animate_a0_frames	; 1st 2 frames on ground
	movi	>10000,a0
	movi	->60000,a1
	movi	>8000,a2		; grav
	movk	4,a3			; ani speed
	jsrp	flight
	calla	shake_n_sound

	movi	>1a,a9
	calla	find_ani_part2
	movk	3,a0
	jauc	mframew			; hop hand animation

;******************************************************************

motaro_kick
	movi	>11,a9
	calla	get_char_ani

	movk	1,a0
	callr	b_ochar_sound

	calla	am_i_facing_him
	jrnc	motk3			; no, no need 2 turn around
	movk	1,a0
	jsrp	mframew			; yes, turnaround for this !
	subi	32*4,a9			; adjust for "find_part2"

motk3	calla	find_part2

	movk	2,a0
	jsrp	mframew
	movk	4,a10
motk5	movk	1,a0
	calla	strike_check_a0		; collision check !!
	jrc	motaro_kick_hit
	sleep	1
	dsj	a10,motk5

motk7	movk	3,a0
	jsrp	mframew
*
* post kick = turn back around
*
	calla	am_i_facing_him
	jrc	motk8			; no need 2 turn around
	movi	>00030011,a9
	jsrp	animate_a9

motk8	clr	a9
	calla	pose_a9
	jruc	b_reaction_exit

motaro_kick_hit
	sleep	10
	jruc	motk7

;******************************************************************

motaro_grab_punch
	calla	is_he_airborn
	jrc	motaro_punch		; not out of the air

motaro_grab_punch_now
	movk	2,a0
	callr	b_ochar_sound

	calla	me_in_back
	calla	wfe_him			; him = wait forever
	calla	stop_him
	movi	>00030004,a9
	jsrp	animate_a9		; reach out !!

	calla	sans_repell_3
	movi	>00000020,a9
	calla	pose_him_a9

	clr	a7
	calla	q_is_he_cornered
	jrnc	grab2
	movi	>30000,a7
grab2	move	a7,a0
	calla	away_x_vel
	movk	6,a10
grab4	sleep	1
	calla	match_him_with_me_f
	movi	->50,a0
	movi	>10,a1
	calla	adjust_him_xy		; put him at my hands !!
	calla	sans_repell_3
	dsj	a10,grab4

	calla	stop_me

	movk	4,a9
	calla	find_ani_part2

	movi	>60,a7
	move	a7,@f_norepell,w	; start the count down

;**********
	move	*a13(p_otherproc),a0,l
	move	*a0(pwake),a0,l
	cmpi	wait_forever_wake,a0
	jrne	motaro_grab_abort
;**********

	movi	>20,a0
	movi	->10,a1
	callr	grab_ani
	movi	>23,a0
	movi	->30,a1
	callr	grab_ani
	clr	a0
	clr	a1
	callr	grab_ani		; lift him up

	movk	4,a0
	movk	3,a1
	movk	2,a2
	jsrp	shake_him_up		; pause

	movi	drop_down_land_jump,a7
	calla	takeover_him
	sleep	1
	movi	>20000,a0
	calla	away_x_vel_him
	movk	4,a9
	movk	3,a14
	calla	find_ani_part_a14
	calla	me_in_front

	movk	2,a0
	jsrp	mframew
	clr	a0
	calla	strike_check_a0		; POW !!

	movk	5,a0
	jsrp	mframew

motaro_grab_abort
	jruc	b_reaction_exit


grab_ani
	pull	a11
	calla	adjust_him_xy		; put him at my hands !!
	calla	do_next_a9_frame
	sleep	6
	jump	a11

;***********************************************

motaro_punch
	movk	2,a0
	callr	b_ochar_sound

	clr	a0
	move	a0,a1
	sll	5,a0
	sll	4,a1
	add	a1,a0
	addi	boss_attack_info,a0
	move	a0,a7

	move	*a7+,a9,w		; animation
	move	*a7+,a11,w		; stk offset
	move	*a7,a0,w		; speed
	movk	3,a10			; frames to look for collision
	clr	a1
	jsrp	striker
	jrnc	boss_close_miss

	sleep	>10-8

boss_post_hit
boss_close_miss
	sleep	8	
	movk	3,a0
	jsrp	mframew			; out of ani
	jruc	b_reaction_exit


boss_attack_info
	.word	>0e	; animation
	.word	>00	; stk
	.word	>02	; speed

**************************************************************************
*											     *
*  SHAO KAHN COUNTERS									     *
*											     *
**************************************************************************
sk_catagory_table
	.long	skc_counter_zap
	.long	skc_counter_stationary
	.long	skc_counter_propell
	.long	0			;sk_counter_non_attacks
	.long	0
	.long	0
	.long	skc_counter_sitting_duck
	.long	0

skc_counter_zap
	.long	skc_zap			; >00
	.long	skc_zap			; >01
	.long	skc_zap			; >02
	.long	skc_zap			; >03
	.long	skc_zap			; >04
	.long	skc_zap			; >05
	.long	skc_zap			; >06
	.long	skc_zap			; >07
	.long	skc_zap			; >08
	.long	skc_zap			; >09
	.long	skc_zap			; >0a
	.long	skc_zap			; >0b
	.long	skc_zap			; >0c
	.long	skc_zap			; >0d
	.long	skc_zap			; >0e
	.long	skc_zap			; >0f
	.long	skc_zap			; >10
	.long	skc_zap			; >11
	.long	skc_zap			; >12
	.long	skc_zap			; >13
	.long	skc_lk_zap_lo		; >14
	.long	skc_zap			; >15
	.long	skc_zap			; >16
	.long	skc_zap			; >17
	.long	skc_zap			; >18
	.long	skc_zap			; >19
	.long	skc_zap			; >1a
	.long	skc_zap			; >1b
	.long	skc_zap			; >1c
	.long	skc_zap			; 1d
	.long	skc_zap			; 1e
	.long	skc_zap			; 1f
	.long	skc_zap			; 20

skc_counter_stationary
	.long	skc_stationary  	; >100
	.long	skc_stationary  	; >101
	.long	skc_stationary  	; >102
	.long	skc_stationary  	; >103
	.long	skc_stationary  	; >104
	.long	skc_stationary  	; >105
	.long	skc_stationary  	; >106
	.long	skc_stationary  	; >107
	.long	skc_stationary  	; >108
	.long	skc_stationary  	; >109
	.long	skc_stationary  	; >10a
	.long	skc_stationary  	; >10b
	.long	skc_stationary  	; >10c
	.long	skc_stationary  	; >10d
	.long	skc_stationary  	; >10e
	.long	skc_stationary  	; >10f
	.long	skc_stationary  	; >110
	.long	skc_stationary  	; >111
	.long	skc_stationary  	; >112
	.long	skc_stationary  	; >113
	.long	skc_stationary  	; >114
	.long	skc_stationary  	; >115
	.long	skc_stationary  	; >116
	.long	skc_stationary  	; >117
	.long	skc_stationary  	; >118
	.long	skc_stationary  	; >119
	.long	skc_stationary  	; >11a
	.long	skc_stationary  	; >11b

skc_counter_sitting_duck
	.long	0		; 600
	.long	0		; 601
	.long	0		; 602
	.long	0		; 603
	.long	0		; 604
	.long	0		; 605
	.long	0		; 606
	.long	0		; 607
	.long	0		; 608
	.long	0		; 609
	.long	0		; 60a
	.long	0		; 60b
	.long	0	;mc_fk_sd   	; 60c
	.long	0		; 60d
	.long	0		; 60e
	.long	0		; 60f
	.long	0		; 610
	.long	0		; 611
	.long	0		; 612
	.long	0		; 613
	.long	0		; 614
	.long	0		; 615
	.long	0		; 616
	.long	0		; 617
	.long	0		; 618
	.long	0		; 619
	.long	0		; 61a
	.long	0		; 61b
	.long	0		; 61c
	.long	0		; 61d
	.long	0		; 61e
	.long	0		; 61f
	.long	skc_dizzy   	; 620
	.long	0		; 621
	.long	0		; 622
	.long	0		; 623
	.long	0		; 624
	.long	0		; 625


skc_counter_propell
	.long	skc_propell	; >200
	.long	skc_propell	; >200
	.long	skc_propell	; >201
	.long	skc_propell	; >202
	.long	skc_propell	; >203
	.long	skc_propell	; >204
	.long	skc_propell	; >205
	.long	skc_propell     ; >206
	.long	skc_propell	; >207
	.long	skc_propell	; >208
	.long	skc_propell	; >209
	.long	skc_propell	; >20a
	.long	skc_propell	; >20b
	.long	skc_propell	; >20c
	.long	skc_propell	; >20d
	.long	skc_propell	; >20e
	.long	skc_propell	; >20f
	.long	skc_propell	; >210
	.long	skc_propell	; >211
	.long	skc_propell	; >212
	.long	skc_propell	; >213
	.long	skc_propell	; >214
	.long	skc_propell	;
	.long	skc_propell	;
	.long	skc_propell	;

skc_propell
;	callr	sk_randper
;	jrnc	b_return_to_beware

	callr	b_get_x_dist
	cmpi	>90,a3
	jrhi	b_return_to_beware_4get
	jruc	d_block




skc_lk_zap_lo
	calla	get_x_dist
	cmpi	>70,a3
	jrlo	sk_charge
	jruc	sk_air_charge

skc_zap
;	callr	sk_randper
	movi	800,a0
	calla	randper
	jrnc	b_return_to_beware

	callr	sk_counter_randper
	jrnc	sk_block_zap		; counter = zap em right back

	calla	get_x_dist
	cmpi	>70,a3
	jrlo	sk_charge		; close = nail em
	jruc	sk_zap

sk_block_zap
	calla	face_opponent
	jsrp	do_block_hi
	jsrp	wait_proj_spawn
	jsrp	wait_proj_pass		; wait for projectile to pass
	jruc	b_reaction_exit


skc_stationary
	callr	sk_randper
	jrnc	b_return_to_beware
	callr	b_get_x_dist
	cmpi	>70,a3
	jrhi	b_return_to_beware_4get
	jruc	d_block


skc_dizzy
	movi	500,a0
	calla	randper
	jrc	b_return_to_beware

	movi	400,a0
	calla	randper
	jrc	sk_laugh

	movi	>40*3,a10
	movi	q_is_he_dizzy,a11
	jsrp	stance_wait_no		; let him get out of it !!
	movi	>40,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit

q_is_he_dizzy
	calla	get_his_action
	cmpi	act_dizzy,a1
	jreq	q_yes
	jruc	q_no

q_boss_stupid
	callr	q_is_this_a_joke
	jrc	bs_joke
	callr	q_am_i_way_ahead
	jrc	bs_ahead		; way ahead = good chance of stupidity
	callr	q_am_i_losing
	jrc	bs_losing		; losing = dont be too dumb !!

	movi	150,a0
	jauc	randper

bs_joke
	movi	750,a0
	jruc	skrp
bs_ahead
	movi	400,a0
	jruc	skrp
bs_losing
	movi	75,a0
	jruc	skrp

sk_counter_joke
	movi	75,a0
	jruc	skrp

sk_randper
	callr	q_is_this_a_joke
	jrc	sk_counter_joke

	movi	mhe_sk_randpers,a0
	callr	get_mhe_word
skrp	jauc	randper

mhe_sk_randpers
	.word	700	; med
	.word	775	; hard
	.word	600	; easy

;**********************************************************

sk_counter_randper
;	callr	q_is_this_a_joke
;	jrc	skcrj

	movi	mhe_sk_counter_randpers,a0
	callr	get_mhe_word
	jruc	skrp

;skcrj	movi	100,a0	   	; i am REALLY winning = dont counter much
;	jruc	skrp

mhe_sk_counter_randpers
	.word	700	; med
	.word	850	; hard
	.word	600	; easy

;	.word	600	; med
;	.word	750	; hard
;	.word	400	; easy

;**********************************************************

q_is_this_a_joke
	calla	get_my_matchw
	move	a0,a0
	jreq	q_no			; no wins = I am not way ahead
	calla	get_his_matchw
	move	a0,a0
	jrne	q_no			; he has a win = I am not way ahead
	calla	get_his_strength
	move	a0,a5
	calla	get_my_strength
	cmp	a5,a0
	jrlo	q_no			; I am losing = this is no joke
	cmpi	full_strength/2,a5
	jrhi	q_no
	jruc	q_yes			; wow, this player sux


q_am_i_losing
	movi	q_am_i_way_ahead,a0
	jauc	calla_for_him

q_am_i_way_ahead
	calla	get_my_matchw
	jreq	q_no			; no wins = I am not way ahead
	calla	get_his_matchw
	jrne	q_no			; he has a win = I am not way ahead
	callr	q_am_i_stronger
	jrnc	q_no
	jruc	q_yes

q_am_i_stronger
	calla	get_his_strength
	move	a0,a5
	calla	get_my_strength
	cmp	a5,a0
	jrlo	q_no			; I am losing = this is no joke
	jruc	q_yes

**************************************************************************
*											     *
*    MOTARO COUNTERS !									     *
*											     *
**************************************************************************
motaro_catagory_table
	.long	0
	.long	mot_counter_stationary
	.long	mot_counter_propell
	.long	mot_counter_non_attacks
	.long	0
	.long	0
	.long	mot_counter_sitting_duck
	.long	0

mot_counter_stationary
	.long	mc_stationary	; 0
	.long	mc_stationary	; 1
	.long	mc_stationary	; 2
	.long	mc_stationary	; 3
	.long	mc_stationary	; 4
	.long	mc_stationary	; 5
	.long	mc_stationary	; 6
	.long	mc_stationary	; 7
	.long	mc_stationary	; 8
	.long	mc_stationary	; 9
	.long	mc_stationary	; a
	.long	mc_stationary	; b
	.long	mc_stationary	; c
	.long	mc_stationary	; d
	.long	mc_stationary	; e
	.long	mc_stationary	; f
	.long	mc_stationary	; 10
	.long	mc_stationary	; 11
	.long	mc_stationary	; 12
	.long	mc_stationary	;
	.long	mc_stationary	;
	.long	mc_stationary	;
	.long	mc_stationary	;
	.long	mc_stationary	;
	.long	mc_stationary	;

mot_counter_propell
	.long	mc_flipkp	;c_flykick	; 200 - flying (flip) kick
	.long	mc_flipkp	;c_flypunch	; 201 - flying (flip) punch
	.long	mc_propell_ls	;c_sz_decoy	; 202 -
	.long	mc_hover		;0		; 203
	.long	mc_propell_ls	;c_sbike		; 204
	.long	mc_propell_ls	;c_jax_dash	; 205
	.long	mc_propell_ls	;c_lao_tele	; 206
	.long	mc_propell_ls	;c_square	; 207
	.long	mc_propell_ls	;c_robo_tele  	; 208
	.long	mc_propell_ls	;0		; 209
	.long	mc_propell_ls	;c_tele_explode	; 20a
	.long	mc_propell_ls	;c_kano_roll  	; 20b
	.long	mc_propell_ls	;c_lao_angle 	; 20c
	.long	mc_propell_ls	;c_bike		; 20d
	.long	mc_propell_ls	;c_superkang	; 20e
	.long	mc_sg_pounce	;c_sg_pounce 	; 20f
	.long	mc_propell_ls	;c_bike		; 210
	.long	mc_propell_ls	;c_zoom		; 211
	.long	mc_propell_ls	;0		; 212
	.long	mc_propell_ls	;c_tusk_blur	; 213
	.long	mc_propell_ls	;c_ind_charge	; 214

mot_counter_non_attacks
	.long	0		; 0
	.long	0		; 1
	.long	0		; 2
	.long	0		; 3
	.long	0		; 4
	.long	0		; 5
	.long	0		; 6
	.long	0		; 7
	.long	mc_angle_jump	; 8
	.long	0		; 9
	.long	0		; a
	.long	0		; b
	.long	0		; c
	.long	0		; d
	.long	0		; e

mot_counter_sitting_duck
	.long	0		; 600
	.long	0		; 601
	.long	0		; 602
	.long	0		; 603
	.long	0		; 604
	.long	0		; 605
	.long	0		; 606
	.long	0		; 607
	.long	0		; 608
	.long	0		; 609
	.long	0		; 60a
	.long	0		; 60b
	.long	mc_fk_sd   	; 60c
	.long	0		; 60d
	.long	0		; 60e
	.long	0		; 60f
	.long	0		; 610
	.long	0		; 611
	.long	0		; 612
	.long	0		; 613
	.long	0		; 614
	.long	0		; 615
	.long	0		; 616
	.long	0		; 617
	.long	0		; 618
	.long	0		; 619
	.long	0		; 61a
	.long	0		; 61b
	.long	0		; 61c
	.long	0		; 61d
	.long	0		; 61e
	.long	0		; 61f
	.long	mc_dizzy   	; 620
	.long	0		; 621
	.long	0		; 622
	.long	0		; 623
	.long	0		; 624
	.long	0		; 625

mc_fk_sd
	movi	500,a0
	calla	randper
	jrnc	b_return_to_beware
	callr	b_get_x_dist
	cmpi	>90,a3
	jrhi	b_return_to_beware		; 2 far away

	movi	>40,a10
	movi	q_is_he_airborn,a11
	jsrp	stance_wait_no			; wait for him to land
	jruc	motaro_grab_punch_now


mc_dizzy
	movi	500,a0
	calla	randper
	jrc	b_return_to_beware
	movi	>40*2,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit

mc_angle_jump
	calla	is_towards_me
	jrnc	b_return_to_beware	; away from me !!
	callr	motaro_easy_randper
	jrnc	b_return_to_beware	; away from me !!
	callr	b_get_x_dist
	cmpi	>80,a3
	jrhi	b_return_to_beware	; far from me
	jruc	motaro_punch		; close to me = punch it !!

;********************************************

mc_flipkp
	callr	q_is_this_a_joke
	jrc	return_to_beware

	calla	is_towards_me
	jrnc	mc_flipk_away

	callr	b_get_x_dist
	cmpi	>70,a3
	jrhi	b_return_to_beware_4get
	calla	random_do
	.word	2
	.long	d_block
	.long	motaro_tele

mc_flipk_away
	callr	b_get_x_dist
	cmpi	>80,a3
	jrhi	b_return_to_beware
	jruc	d_block

;********************************************

mc_sg_pounce
	callr	motaro_randper
	jauc	d_block

mc_propell_ls
	callr	motaro_randper

	callr	b_get_x_dist
	cmpi	>70,a3
	jrhi	b_return_to_beware_4get
	jauc	d_block


mc_hover
	callr	motaro_randper
;	jrnc	b_return_to_beware

	callr	b_get_x_dist
	cmpi	>70,a3
	jrlo	motaro_punch		; close = punch
	jruc	motaro_hop

mc_stationary
	callr	motaro_randper
	jrnc	b_return_to_beware

	callr	b_get_x_dist
	cmpi	>8a,a3
	jrhi	b_return_to_beware_4get
	jruc	b_block


motaro_randper
	callr	q_is_this_a_joke
	jrc	motaro_joke_randper

	movi	500,a0
	jauc	randper

motaro_joke_randper
	movi	100,a0
	jauc	randper

motaro_easy_randper
	movi	350,a0
	jauc	randper


b_block
	calla	face_opponent
	jsrp	do_block_hi
	movi	>40*1,a10
	jsrp	d_wait_nonattack	; wait for non !!
	callr	b_get_x_dist
	cmpi	>80,a3
	jrlo	motaro_grab_punch
	jruc	b_reaction_exit

**************************************************************************
;how_far_from_stk
;	mmtm	sp,a8,a13
;
;	move	*a13(p_otherguy),a8,l	; him
;	move	*a13(p_otherproc),a13,l	; his proc
;	move	*a13(p_stk),a0,w    		; his strike table
;	calla	get_char_stk
;
;	move	*a0,a1,w			; x offset
;	move	*a8(oxpos),a2,w
;	move	*a8(oflags),a4,w
;	btst	b_fliph,a4
;	jaeq	hffs3
;     	neg	a1				; flipped = the other way.
;hffs3	add	a1,a2				; a2 = reach !!
;	mmfm	sp,a8,a13
;
;	move	*a8(oxpos),a0,w
;	sub	a0,a2
;	abs	a2
;	rets

**************************************************************************
*											     *
*    MOTARO REACTIONS !!									     *
*											     *
**************************************************************************

motaro_flip_kicked
	calla	rsnd_big_smack
	movi	>00030002,a0		; 3=min / 2 entries
	calla	rsnd_ochar_sound

	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	movi	>50000,a0
	calla	away_x_vel		; move away from him
	movi	>00040020,a9
	jsrp	animate_a9		; stumble ani

	movi	>10,a0
	movi	>10,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit


motaro_hit_flight
	movi	>40000,a0		; a0 = initial x vel
	movi	->40000,a1		; a1 = initial y vel
	movi	>6000,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	>1e,a9			; a9 = ani offset
	jsrp	flight

;	jauc	reaction_land
	jauc	land_on_my_back


motaro_upcutted
	calla	am_i_airborn
	jrc	motaro_hit_flight	; airborn !

	calla	rsnd_big_smack
	movi	>00030002,a0		; 3=min / 2 entries
	calla	rsnd_ochar_sound

	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	movi	>60000,a0
	calla	away_x_vel		; move away from him
	movi	>00040020,a9
	jsrp	animate_a9		; stumble ani

	movi	>10,a0
	movi	>10,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit


motaro_hit3
motaro_hit2
	calla	am_i_airborn
	jrc	motaro_hit_flight	; airborn !

	calla	rsnd_big_smack
	movi	>00030002,a0		; 3=min / 2 entries
	calla	rsnd_ochar_sound

	movi	>40000,a0
	calla	away_x_vel

	movi	>1c,a9
	calla	get_char_ani
	movi	>00030002,a0
	jsrp	animate_a0_frames
	sleep	6
	movk	3,a0
	jsrp	mframew
	jruc	b_reaction_exit


motaro_comboed
	calla	am_i_airborn
	jrc	motaro_hit_flight	; airborn !

	calla	rsnd_big_smack
	movi	>10000,a0
	calla	away_x_vel
	movi	>1c,a9
	calla	get_char_ani
	movi	>00030002,a0
	jsrp	animate_a0_frames
	sleep	6
	movk	3,a0
	jsrp	mframew

	move	*a13(p_hit),a0,w
	cmpi	3,a0
	jrlo	b_reaction_exit

	calla	random_do
	.word	2
	.long	motaro_hip_jump
	.long	boss_ease_back

motaro_hit1
motaro_hit0
	calla	am_i_airborn
	jrc	motaro_hit_flight	; airborn !

	calla	rsnd_med_smack
	movi	>00030002,a0		; 3=min / 2 entries
	calla	rsnd_ochar_sound

	movi	>20000,a0
	calla	away_x_vel
	movi	>0003001c,a9
	jsrp	animate_a9
	jruc	b_reaction_exit


motaro_hard_comboed
	movk	2,a1
	calla	avoid_corner_trap

	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	calla	rsnd_big_smack

	movi	>40000,a0
	calla	away_x_vel		; move away from him
	movi	>00030020,a9
	jsrp	animate_a9		; stumble ani

motaro_stumble
	movi	>40000,a0
	calla	away_x_vel		; move away from him
	movi	>00040020,a9
	jsrp	animate_a9		; stumble ani

	calla	back_to_normal

	movi	>10,a0
	movi	>10,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause
	jruc	b_reaction_exit


motaro_collapse
	movi	>0003001e,a9
	jsrp	animate_a9
	jruc	b_wait_forever

**************************************************************************
*											     *
*  Shao Kahn reactions !									     *
*											     *
**************************************************************************
sk_collapse
	movi	>0003001e,a9
	jsrp	animate_a9

	calla	shake_n_sound
	movk	3,a0
	jsrp	mframew
	jruc	b_wait_forever

sk_uppcutted
	movk	1,a0
	calla	create_blood_proc
	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	calla	rsnd_big_smack

	movk	2,a0
	calla	group_sound

	movi	>20000,a0		; a0 = initial x vel
	movi	->c0000,a1		; a1 = initial y vel
	movi	>6000,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	>1e,a9			; a9 = ani offset
	jsrp	flight
	jauc	reaction_land


sk_hard_comboed
	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	calla	rsnd_big_smack
	movk	6,a0
	calla	group_sound		; hit in face voice

	callr	sk_airborn_check
	movi	>50000,a0
	jauc	stumble_back_vel

sk_stumble
	callr	sk_airborn_check
	movi	>40000,a0
	jauc	stumble_back_vel


sk_hit1
	calla	rsnd_med_smack
	movi	>00040004,a11
	calla	shake_a11		; boss = make hit seem bigger wida shake

	movk	6,a0
	calla	group_sound		; hit in face voice

	callr	sk_airborn_check

	movi	>40000,a0
	calla	away_x_vel
	movi	>0004001c,a9
	jsrp	animate_a9
	jruc	b_reaction_exit


sk_hit3
	movi	>00060006,a11
	calla	shake_a11  	; shake upon contact
	calla	rsnd_big_smack
	movk	6,a0
	calla	group_sound		; hit in face voice

sk_slided
sk_knocked_down
	movk	6,a0
	calla	group_sound		; hit in face voice

motaro_slided
	movi	>40000,a0	; a0 = initial x vel
	movi	->30000,a1	; a1 = initial y vel
	movi	>5000,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	>1e,a9		; a9 = ani offset
	jsrp	flight
	jauc	land_on_my_back

sk_comboed
	calla	rsnd_big_smack
	callr	sk_airborn_check

	movk	6,a0
	calla	group_sound		; hit in face voice

	movi	>30000,a0
	calla	away_x_vel
	movi	>1c,a9
	calla	get_char_ani
	movi	>00030002,a0
	jsrp	animate_a0_frames
	sleep	6
	movk	3,a0
	jsrp	mframew
	jruc	b_reaction_exit


sk_airborn_check
	pull	a7
	calla	am_i_airborn
	jrc	sk_knocked_down
	jump	a7

**************************************************************************

q_ok_motaro_sweep
	callr	b_get_x_dist
	cmpi	>d0,a3
	jrhi	q_no
	cmpi	>80,a3
	jrlo	q_no

	calla	is_he_airborn
	jrc	q_no			; only if he is grounded !!

q_yes	setc
	rets
q_no	clrc
	rets

q_is_he_car
	calla	q_is_he_cornered
	jrnc	q_no
	calla	q_is_he_reacting
	jrnc	q_no
	jruc	q_yes

**************************************************************************

get_mhe_word
	move	@ladder_order,a1,w
	sll	4,a1
	add	a1,a0
	move	*a0,a0,w
	rets

get_mhe_long
	move	@ladder_order,a1,w
	sll	5,a1
	add	a1,a0
	move	*a0,a0,l
	rets

**************************************************************************

b_wait_forever
	jauc	wait_forever

b_reaction_exit
	jauc	reaction_exit

b_return_to_beware_4get
	clr	a0
	move	a0,*a13(p_otheract),w	; forget I was ever here.

b_return_to_beware
	jauc	return_to_beware

b_get_x_dist
	jauc	get_x_dist

b_check_winner_status
	jauc	check_winner_status

b_next_anirate
	jauc	next_anirate

b_beware
	jauc	d_beware

b_retp	retp

b_ochar_sound
	jauc	ochar_sound


**************************************************************************


	.end
