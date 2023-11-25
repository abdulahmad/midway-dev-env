**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: fatalities										*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	'mkfatal.asm'
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
	.include	mkfatal.tbl
	.include	mkfatal2.tbl
	.text

do_fatality_1
	calla	init_special
	movi	ochar_fatalities1,a0
	jauc	ochar_jump

do_fatality_2
	calla	init_special
	movi	ochar_fatalities2,a0
	jauc	ochar_jump


ochar_fatalities1
	.long	kano_lazer
	.long	sonya_kiss
	.long	jax_slice
	.long	ind_light
	.long	sz_blow
	.long	swat_taser
	.long	lia_scream_rip
	.long	fat_robo_crush
	.long	cyrax_self_destruct
	.long	lao_tornado
	.long	kabal_inflator
	.long	sg_pound
	.long	st_spike
	.long	kang_fire
	.long	smoke_blowup_earth


ochar_fatalities2
	.long	kano_skeleton
	.long	sonya_kiss_crusher
	.long	jax_grow
	.long	ind_zap_kill
	.long	sz_lift_n_freeze
	.long	sw_plant_bomb
	.long	lia_hair_spin
	.long	robo_flame_throw
	.long	cyrax_helecopter
	.long	lao_slicer
	.long	kabal_scare
	.long	sg_flesh_rip
	.long	st_suck
	.long	kang_mk_game
	.long	smoke_arm

;**************************************************************************

smoke_arm
	jsrp	fatality_start_pause

	clr	a0
	callr	local_ochar_sound
	movi	>0f,a9
	calla	get_char_ani2
	movk	6,a0
	jsrp	mframew
	movi	open_wide,a7
	calla	takeover_him
	movk	1,a0
	callr	local_ochar_sound

	sleep	8

	move	a8,a10
	movi	SMBOMB1A,a5
	calla	gso_dmawnz
	move	a8,a0
	move	a10,a1
	calla	lineup_1pwm
	clr	a0
	movi	->10,a1
	calla	multi_adjust_xy			; lineup wid arm
	calla	insobja8
	create	pid_robo_bomb,smoke_dropping
	move	*a13(p_otherguy),*a0(p_otherguy),l
	move	*a13(p_otherproc),*a0(p_otherproc),l
	move	a10,a8

	movk	2,a0
	callr	local_ochar_sound

	movk	6,a0
	jsrp	mframew
	calla	delete_slave

	sleep	>30

	callr	death_blow_complete
	jruc	local_victory_animation



open_wide
	calla	player_normpal
	calla	face_opponent
	movi	ochar_reached,a0
	calla	get_char_long
	move	a0,a9
	addi	32*3,a9
	calla	do_next_a9_frame
	calla	death_scream

	calla	match_me_with_him
	calla	flip_multi

	movi	ochar_wide_adjusts,a0
	calla	get_char_word
	neg	a0
	clr	a1
	calla	multi_adjust_xy
	jauc	wait_forever


ochar_wide_adjusts
	.word	>70
	.word	>70
	.word	>80
	.word	>80
	.word	>70

	.word	>70
	.word	>70
	.word	>80
	.word	>80
	.word	>60

	.word	>60
	.word	>5d
	.word	>70
	.word	>60
	.word	>90


smoke_dropping
	movi	>20000,a0	
	move	a0,*a8(oyvel),l
drop4	sleep	1
	move	*a8(oyvel),a0,l
	addi	>2000,a0
	move	a0,*a8(oyvel),l
	move	@ground_y,a0,w
	move	*a8(oypos),a1,w
	sub	a0,a1
	abs	a1
	cmpi	>80,a1
	jrhi	drop4

	movi	eat_this_shit,a7
	calla	takeover_him
	move	a8,a0
	calla	delobjp
	die


eat_this_shit
	calla	rsnd_big_block
	movi	>00020000,a0
	movk	2,a1
	movk	4,a2
	jsrp	shake_a8_up

	sleep	>20

	calla	set_inviso
	movi	>18,a0
	calla	create_fx		; explode
	jsrp	white_flash
	jauc	wait_forever

;**************************************************************************

smoke_blowup_earth
	jsrp	fatality_start_pause
	jsrp	robo_open_chest

	movk	20,a0
blow4	move	a0,*a13(p_anirate),w

	mmtm	sp,a8,a9,a11
	movk	4,a9
	calla	get_char_ani2
	move	a9,a11
	calla	get_proj_obj_m
	move	a10,a0
	calla	insobj

	move	a10,a5
	calla	a5_front_plus_1
	move	a10,a5
	movi	>00,a0
	movi	>28,a1
	calla	adjust_xy_a5
	mmfm	sp,a8,a9,a11

	create	pid_bani,earth_bomb

	sleep	10
	move	*a13(p_anirate),a0,w
	dsj	a0,blow4

	sleep	>30
	jsrp	robo_close_chest
	calla	wfe_him

;*************
	movi	gs_pitfall,a0
	move	a0,@gstate,w
;*************

	movk	30,a10
	jsrp	fadeout_jsrp

	clr	a1
	not	a1
	movi	pid_master,a0
	calla	existp
	move	*a0(procid),a1,w
	ori	>8000,a1
	move	a1,*a0(procid),w
	calla	murder_myoinit_score

	clr	a1
	not	a1
	movi	pid_master|>8001,a0
	calla	existp
	move	*a0(procid),a1,w
	andni	>8000,a1
	move	a1,*a0(procid),w
	calla	bogus_dlist

	movi	70,a10
starz	movi	bpal_white,a0
	movi	>00020002,a3
	calla	make_solid_object
	movi	400,a0
	calla	randu
	move	a0,*a8(oxpos),w
	movi	256,a0
	calla	randu
	move	a0,*a8(oypos),w		; random placement of star
	calla	insobja8
	dsj	a10,starz

	movi	a_earth,a9
	calla	gmo_proc
	calla	set_noscroll
	movi	>008000c5,a4
	calla	set_xy_coordinates
	movi	100,a0
	move	a0,*a8(ozpos),w		; front o starz
	calla	insobja8

	pushp	a9
	movk	10,a10
	jsrp	fadein_jsrp
	pullp	a9

	tsound	>87			; earth shake sound
	movk	4,a0
	movk	3,a1
	movk	8,a2
	jsrp	shake_a8_up		; shake da world

	movk	5,a0
	jsrp	mframew			; ka - freakin - BOOM !!!!

	tsound	>00
	tsound	>01			; boom sound
	jsrp	white_flash
	jsrp	white_flash
	move	a8,a0
	calla	delobjp

	movi	>00080010,a11
	calla	shake_a11

	sleep	>30
	callr	death_blow_complete
	jauc	wait_forever



earth_bomb
	move	a10,a8

	movi	>90000,a0
	calla	randu
	addi	>8000,a0
	calla	set_proj_vel

	move	@ground_y,a0,w
	subi	>15,a0
	move	a0,*a13(p_ganiy),w	; set ground position

	movk	3,a0
	calla	init_anirate
	movk	4,a9
	calla	get_char_ani2		; setup for gravity loop
	clr	a1
	move	a1,*a8(oyvel),l
	calla	bomb_gravity

	movi	->50000,a0
	callr	bomb_gravity2
	movi	->30000,a0
	callr	bomb_gravity2

	calla	stop_a8			; stop it already !!
	die


bomb_gravity2
	pull	a10
	move	a0,*a8(oyvel),l
	sleep	1
	jruc	bgrav3

bomb_gravity
	pull	a10
bgrav3	sleep	1
	calla	next_anirate
	dec	a11			; keep track o time
	move	*a8(oyvel),a0,l
	addi	>8000,a0
	move	a0,*a8(oyvel),l		; gravity
	jrn	bgrav3			; heading up ---> dont look at ground
	move	*a8(oypos),a5,w
	move	*a13(p_ganiy),a6,w
	cmp	a6,a5
	jrlt	bgrav3

	movk	8,a0			; klang 1 sound
	move	*a13(p_store1),a2,w
	xori	1,a2
	jreq	bgrav5
	movk	9,a0			; klang 2 sound
bgrav5 	move	a2,*a13(p_store1),w
	callr	local_ochar_sound

	move	*a8(oxvel),a0,l
	sra	1,a0
	move	a0,*a8(oxvel),l
	jump	a10

;**************************************************************************

kang_mk_game
	jsrp	fatality_start_pause

	movk	6,a0
	calla	ochar_sound			; morph
	movk	6,a9
	movk	4,a0
	jsrp	backwards_ani2			; disappear
	calla	set_inviso
	create	pid_blood,mk_game_cabinet
	move	*a13(p_otherguy),*a0(p_otherguy),l
	move	*a13(p_otherproc),*a0(p_otherproc),l
	sleep	>60

	jruc	kang_reform


mk_game_cabinet
	movi	MK1GAME,a5
	calla	gso_dmawnz
	calla	a8_front_plus_1

	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a0,w
	calla	center_about_x

	move	@ground_y,a0,w
	subi	>1b0,a0
	move	a0,*a8(oypos),w
	calla	insobja8

	movi	r_mk_game_crush,a7
	calla	takeover_him

	movi	>20000,a1
	movi	>6000,a10
	jsrp	gravity_ani_ysize

	movk	ft_lk,a0
	move	a0,*a8(ochar),w
	movk	8,a0
	calla	ochar_sound			; boom !
	movi	>000a000a,a11
	calla	shake_a11
	die

r_mk_game_crush
	calla	center_around_me
	sleep	20
	callr	death_scream
	jruc	r_jax_stomp

;**************************************************************************

kang_fire
	jsrp	fatality_start_pause

	move	*a8(oxpos),*a13(p_store4),w
	callr	sans_repell_for_good
	callr	wfe_him

	movk	7,a0
	calla	ochar_sound			; wasupwidat !!
	movk	6,a0
	calla	ochar_sound			; morph
	movk	6,a9
	movk	4,a0
	jsrp	backwards_ani2			; disappear

	movi	lk_skeleton_burn,a7
	calla	takeover_him

	calla	match_me_with_him
	movk	5,a9
	callr	local_get_char_ani2
	movk	4,a0
	jsrp	mframew				; into fire
	calla	set_inviso

	sleep	>60
	
	movk	6,a0
	calla	ochar_sound			; morph
	move	*a13(p_store4),*a8(oxpos),w

kang_reform
	calla	clear_inviso
	calla	player_normpal
	movk	6,a9
	callr	local_get_char_ani2
	movk	4,a0
	jsrp	mframew				; reform

	callr	death_blow_complete

null_fatality
	jruc	local_victory_animation


lk_skeleton_burn
	calla	center_around_me
	sleep	10
	jruc	sb_skeleton_burn

;**************************************************************************

st_suck
	jsrp	fatality_start_pause

	calla	flip_multi
	movi	>14,a9
	callr	local_get_char_ani2
	movk	4,a0
	jsrp	mframew
	
	movi	soul_float,a7
	calla	takeover_him
	sleep	>90

	movi	>14,a9
	movk	4,a0
	jsrp	backwards_ani2

	callr	death_blow_complete
	jruc	local_victory_animation


soul_float
	move	*a8(ochar),a9,w
	sll	5,a9
	addi	ochar_floaters,a9
	calla	do_next_a9_frame

	movi	->1000,a0
	move	a0,*a8(ograv),l
	sleep	45

	clr	a0
	move	a0,*a8(ograv),l

soul3	sleep	1
	move	*a8(oyvel),a0,l
	move	a0,a1
	sra	3,a1
	sub	a1,a0
	move	a0,*a8(oyvel),l
	abs	a0
	cmpi	>800,a0
	jrhi	soul3
	calla	stop_me

	movi	>11,a9
	calla	get_his_char_ani2
	create	pid_fx,green_shit
	sleep	5
	movk	8,a0
	calla	his_ochar_sound			; green orb sound
	sleep	10

	callr	death_scream
	movi	>11,a9
	calla	get_his_char_ani2
	calla	find_part2
	calla	find_part2			; skeleton part
	calla	do_next_a9_frame
	sleep	>30

	move	@ground_y,a0,w
	subi	>b0,a0
	move	a0,*a13(p_ganiy),w

	clr	a0
	movi	>20000,a1
	movi	>8000,a2			; grav
	movi	never_ani,a3			; ani speed
	jsrp	flight

	movk	9,a0
	calla	his_ochar_sound			; skeleton hitting ground
	movk	4,a0
	jsrp	mframew
	jruc	local_wait_forever


green_shit
	push	a8
	calla	gmo_proc
	calla	a8_front_plus_1
	calla	insobja8
	move	a8,a10
	pull	a8
		     	
	move	a10,a0
	move	a8,a1
	calla	lineup_a0_onto_a1
	move	a10,a8
	movk	5,a0
	jsrp	mframew

	movi	->3000,a0
	move	a0,*a8(oyvel),l
	sleep	>40

	move	a8,a0
	calla	delobjp				; rid of unwanted pieces !!!
	die

;**************************************************************************

st_spike
	jsrp	fatality_start_pause
	callr	sans_repell_for_good
	callr	wfe_him

	movi	>14,a9
	callr	local_get_char_ani2
	movk	4,a0
	jsrp	mframew

	create	pid_fx,appearing_spikes		; ta da !!!
	sleep	>10

	movk	5,a0
	jsrp	mframew
	sleep	>10

	push	a9
	movi	>32,a9
	calla	get_his_char_ani
	addi	(32*3)*9,a9
	move	a9,a11
	move	*a13(p_otherguy),a10,l
	pull	a9

	callr	make_him_face_me

	movk	4,a0
	jsrp	double_mframew
	movi	st_spiked,a7
	calla	takeover_him
	sleep	>20

	calla	flip_multi
	movk	4,a9
	movk	5,a0
	jsrp	backwards_ani

	callr	death_blow_complete
	jruc	local_victory_animation

st_spiked
	movi	>28,a0
	calla	create_fx		; blood explode
	movi	>00060006,a11
	calla	shake_a11
	callr	death_scream
	calla	rsnd_stab
	calla	ground_player
	movi	>1e,a9
	calla	find_ani_part2
	calla	find_last_frame
	calla	do_next_a9_frame

	clr	a0
	movi	-10,a1
	calla	multi_adjust_xy
	jruc	local_wait_forever

appearing_spikes
	movi	>00030003,a11
	calla	shake_a11

	movk	7,a0
	calla	ochar_sound		; sword spikes rising !!
	move	a8,a11
	movi	SPIKE9,a5
	calla	gso_dmawnz
	move	a11,a1
	move	a8,a0
	calla	lineup_1pwm
	movi	->a0,a0
	movi	>50,a1
	calla	multi_adjust_xy
	calla	insobja8
	die

;**************************************************************************

sg_pound
	jsrp	fatality_start_pause
	callr	sans_repell_for_good

	movk	2,a9
	calla	local_get_char_ani2

	movk	3,a0
	jsrp	mframew
	callr	wfe_him

	mmtm	sp,a8,a9
	movk	1,a9
	calla	get_char_ani2
	move	a9,a0
	calla	get_his_char_long
	push	a0
	move	*a13(p_otherguy),a8,l
	move	*a8(oflags2),a4,w
	andni	m_multipart,a4
	move	a4,*a8(oflags2),w	; klear the multipart bit
	pull	a1
	calla	ani_flag		; him = pounded pose !!
	mmfm	sp,a8,a9

	pushp	a9
	move	*a13(p_otherguy),a0,l
	move	a8,a1
	calla	lineup_1pwm
	movi	-8,a0
	clr	a1
	calla	adjust_him_xy		; right in front of me
	movi	>24,a6
	callr	chop_off_his_height
	pullp	a9

	movk	3,a0
	jsrp	mframew
	movi	>20,a6
	callr	chop_off_his_height

	movk	3,a0
	jsrp	mframew
	movi	>20,a6
	callr	chop_off_his_height

	callr	death_blow_complete
	movk	3,a0	  		
	jsrp	mframew					; un ani
	jruc	local_victory_animation


chop_off_his_height
	pull	a10
	move	*a13(p_otherguy),a0,l
	move	*a0(oypos),a1,w
	add	a6,a1
	move	a1,*a0(oypos),w
	move	*a0(osizey),a2,w
	sub	a6,a2
	move	a2,*a0(osizey),w
	movi	>00060008,a11
	calla	shake_a11

	movk	5,a0
	calla	ochar_sound		; klang
	movk	2,a0
	calla	his_group_sound
	movi	pounded_blood,a0
	calla	calla_for_him

	sleep	>10
	jump	a10


pounded_blood
	movk	1,a0
	jauc	create_blood_proc
	

sg_flesh_rip
	jsrp	fatality_start_pause

	movi	about_2b_ripped,a7
	calla	takeover_him
	callr	sans_repell_for_good

	movk	3,a9
	callr	local_get_char_ani2
	movk	4,a0
	jsrp	mframew			; grab

	movi	flesh_lineups,a0
	calla	get_his_char_word
	clr	a1
	calla	adjust_him_xy
	callr	make_him_face_me

	sleep	>20

	movi	flesh_ripped_off,a7
	calla	takeover_him
	tsound	>70
	movi	>00050007,a11
	calla	shake_a11

	movk	4,a0
	jsrp	mframew			; yank
	sleep	>40

	callr	death_blow_complete
	jruc	local_victory_animation


about_2b_ripped
	calla	face_opponent
	calla	back_to_normal
	movi	>25,a9
	calla	pose_a9
	calla	do_next_a9_frame
	jruc	local_wait_forever


flesh_lineups
	.word	>00
	.word	>10
	.word	>10
	.word	>10
	.word	>10

	.word	>00
	.word	>10
	.word	>10
	.word	>10
	.word	>10

	.word	>10
	.word	>10
	.word	>10
	.word	>10
	.word	>10


flesh_ripped_off
	calla	death_scream
	calla	face_opponent
	create	pid_blood,ripped_skelton

	movi	ochar_reached,a0
	calla	get_char_long
	move	a0,a9
	addi	32*2,a9
	movk	3,a0
	jsrp	mframew
	jauc	wait_forever


ripped_skelton
	movi	ochar_ripped_anis,a11

	movi	ochar_skeleton_adj,a0
	calla	get_char_long
	push	a0

	move	a8,a10
	move	a11,a9
	calla	find_part2
	move	*a8(ochar),a0,w
	cmpi	ft_sg,a0
	jrne	rsk1
	addi	32,a9			; sheeva = use other skeleton
rsk1	move	*a9,a9,l
	calla	gmo_proc
	calla	insobja8
	move	a10,a1
	move	a8,a0
	calla	lineup_a0_onto_a1	; lineup with my body

	pull	a0
	move	a0,a1
	zext	a0,w
	sra	16,a1
	calla	multi_adjust_xy		; lineup with body adjustments
	calla	find_last_frame
	calla	do_next_a9_frame

	move	*a8(ochar),a0,w
	cmpi	ft_sg,a0
	jreq	local_wait_forever	; cuz we dont gotz no green blud

	callr	skel_blood
	callr	skel_blood
	callr	skel_blood
	callr	skel_blood

	jauc	wait_forever

;**************************************************************************

kabal_scare
	jsrp	fatality_start_pause

	movk	6,a9
	calla	get_char_ani2
	movk	5,a0
	jsrp	mframew
	sleep	10
	pushp	a9

	push	a8
	move	a8,a10
	movk	7,a9
	calla	get_char_ani2
	move	*a9,a5,l
	move	a9,a11
	calla	gso_dmawnz
	calla	a8_front_plus_1
	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm
	calla	insobja8
	move	a8,a10			; a10 = head
	pull	a8			; a8 = tusk
	pullp	a9

	jsrp	face_and_head_ani
	jsrp	face_and_head_ani
	jsrp	face_and_head_ani
	movk	9,a0
	callr	local_ochar_sound
	movk	5,a0
	jsrp	face_ani			; head growing
;	sleep	>20

	push	a9
	subi	32*2,a9
	calla	do_next_a9_frame		; stand back up
	pull	a9
	movk	5,a0
	jsrp	face_ani			; head shrinking
	sleep	6

	jsrp	face_and_head_ani
	jsrp	face_and_head_ani
	jsrp	face_and_head_ani

	mmtm	sp,a8,a9,a10,a11
	movi	sacred_2_death,a7
	calla	takeover_him
	mmfm	sp,a8,a9,a10,a11
	movk	9,a0
	callr	local_ochar_sound
	movk	3,a0
	jsrp	face_ani

	jsrp	face_and_head_ani
	jsrp	face_and_head_ani
	jsrp	face_and_head_ani

	move	a10,a0
	calla	delobjp

	callr	death_blow_complete
	jruc	local_victory_animation


sacred_2_death
	calla	center_around_me
	movi	>40,a9
	calla	pose_a9

	create	pid_bani,my_ghost
	
	calla	face_opponent
	callr	death_scream
	movi	>10000,a0
	calla	away_x_vel

	movi	>00040000,a0
	movk	3,a1
	movi	12,a2
	jsrp	shake_a8_up
	calla	stop_me
	sleep	10
	jauc	collapse_on_ground


face_and_head_ani
	callr	next_head_ani
	calla	do_next_a9_frame
	sleep	4
	retp

face_ani
	mmtm	a12,a8,a9
	move	a10,a8
	move	a11,a9
	jsrp	framew
	move	a8,a10
	move	a9,a11
	mmfm	a12,a8,a9
	retp

next_head_ani
	mmtm	sp,a8,a9
	move	a10,a8
	move	a11,a9
	calla	frame_a9
	move	a8,a10
	move	a9,a11
	mmfm	sp,a8,a9
	rets


my_ghost
	move	a8,a10

	calla	get_ochar_stance1
	move	a0,a9
	calla	gmo_proc

	push	a8
	move	a8,a0
	move	a10,a8
	calla	match_ani_points
	pull	a8

	move	*a10(ochar),*a8(ochar),w

	movi	ochar_scared_pals,a0
	calla	get_char_long
	calla	swpal

	calla	insobja8

	movi	>40,a9
	calla	pose_a9
	movi	->20000,a0
	movk	3,a1
	calla	set_proj_vel

	movi	>00040000,a0
	movk	3,a1
	movi	12,a2
	jsrp	shake_a8_up
	calla	stop_a8
	sleep	10

	movi	>a0000,a0
	calla	set_proj_vel	
	movi	>3e,a9
	calla	get_char_ani
	movk	3,a0
	jsrp	mframew			; runnin on empty !!!

	die

;**************************************************************************

kabal_inflator
	jsrp	fatality_start_pause

	movi	center_around_me,a0
	calla	calla_for_him

	movk	5,a9
	calla	get_char_ani2
	movk	4,a0
	jsrp	mframew

	move	a9,a11

	movk	4,a9
	callr	local_get_char_ani2
	movi	pumped,a7
	calla	takeover_him
	move	a9,*a0(pa11),l

	movk	3,a10
kab3	move	a11,a9
	movk	7,a0
	callr	local_ochar_sound		; pump sound
	movk	5,a0
	jsrp	mframew
	dsj	a10,kab3

	movk	5,a0
	jsrp	mframew
	sleep	>40

	callr	death_blow_complete
	jruc	local_victory_animation


pumped
	move	*a8(ochar),a9,w
	sll	5,a9
	add	a11,a9
	move	*a9,a10,l
	addi	32*3,a10
	calla	do_next_a9_frame

	calla	match_me_with_him
	calla	flip_multi
	movi	->d0,a0
	clr	a1
	calla	multi_adjust_xy
	calla	ground_player

	pushp	a8
	move	a8,a11
	move	*a10+,a5,l
	calla	gso_dmawnz		; head object
	move	a11,a1
	move	a8,a0
	calla	lineup_1pwm		; lineup wid body !!
	calla	a8_front_plus_1
	calla	insobja8

	move	a10,a9
	movk	8,a0
	calla	his_ochar_sound		; pump sound

	movk	8,a0
	jsrp	framew

	subi	32*2,a9
pmp4	calla	frame_a9
	sleep	4
	subi	32*2,a9			; backwards pumped !
	cmp	a9,a10
	jrne	pmp4
	
	move	a10,a9
	movk	4,a0
	jsrp	framew			; forwards !!


	movk	2,a0
	movk	3,a1
	movi	>10,a2
	jsrp	shake_a8_up

	move	a8,a10
	pullp	a8

	movi	>3e,a11
pump4	sleep	1
	movi	->2000,a1
	move	a1,*a8(ograv),l
	move	*a8(oyvel),*a10(oyvel),l
	dsj	a11,pump4
	
	clr	a0
	move	a0,*a10(oyvel),l
	calla	stop_me
	calla	set_inviso

	movi	>26,a0
	calla	create_fx
	jauc	wait_forever

;**************************************************************************

lao_slicer
	movi	center_around_me,a0
	calla	calla_for_him

	jsrp	fatality_start_pause

	movk	4,a9
	calla	pose2_a9
	sleep	>10

	movk	1,a0
	calla	local_ochar_sound	; hat throw sound
	movk	4,a0
	jsrp	mframew

	callr	wfe_him
	clr	a2
	move	a2,*a0(pa11),l		; flag: 1st time around

	calla	get_proj_obj_m		; get an object spear projectile
	move	a10,a5
	movi	>40,a0
	movi	>60,a1
	calla	adjust_xy_a5		; adjust to lao
	move	a10,a0
	calla	insobj			; put on object list
	movi	slice_hat_proc,a7
	calla	create_proj_proc

	sleep	>40*3

	movk	4,a9
	movk	4,a0
	jsrp	backwards_ani2

	callr	death_blow_complete
	jruc	local_victory_animation

slice_hat_proc
	callr	slice_speed_set
	jsrp	sob3

	movi	>10,a0
	jsrp	slice_on_by
	movi	>30,a0
	jsrp	slice_on_by
	movi	>60,a0
	jsrp	slice_on_by
	die

slice_speed_set
	movi	>d0000,a0
	movi	never_ani,a1
	calla	set_proj_vel
	rets

slice_on_by
	push	a0
	calla	flip_multi
	callr	slice_speed_set
	movi	highest_mpart,a0
	calla	calla_for_him
	pull	a1
	add	a1,a0
	move	a0,*a8(oypos),w		; at the guys neck

sob3	sleep	1
	move	*a13(p_otherguy),a1,l
	move	*a1(oxpos),a1,w
	move	*a8(oxpos),a0,w
	sub	a0,a1
	abs	a1
	cmpi	10,a1
	jrhi	sob3

	movi	hat_sliced_xfer,a7
	calla	takeover_him
	move	*a8(oxvel),*a0(p_store4),l	; pass vel

	movk	8,a0
	calla	local_ochar_sound	; hat slice sound
	movi	death_scream,a0
	calla	calla_for_him

fly_offscreen
	sleep	1
	calla	proj_onscreen_test
	jrc	fly_offscreen
	calla	stop_a8
	sleep	>10
	retp

hat_sliced_xfer
	move	a11,a11
	jrne	lop_a_piece_off

first_slice
	movk	10,a11
	move	a8,a10
	calla	set_inviso

	move	@ofree,a9,l		; a9 = last one
	move	a9,*a13(p_store6),l	; save 1st one
	movi	ochar_cutups,a0
	calla	get_char_long
hatsl3	move	*a0+,a5,l
	jreq	hatsl5
	push	a0
	calla	gso_dmawnz
	callr	cutup_correct_pal

	move	a8,*a9(oslink),l	; link pieces
	move	a8,a9

	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm		; lineup with vic vic

	move	a11,*a8(ozpos),w
	dec	a11

	calla	insobja8
	pull	a0
	jruc	hatsl3
hatsl5	jauc	wait_forever


lop_a_piece_off
	move	*a13(p_store6),a8,l			; 1st one
	create	pid_blood,lopped_piece
	move	*a13(p_store4),*a0(pa11),l	; pass vel
	move	*a8(oslink),*a13(p_store6),l	; next piece to go
	jruc	local_wait_forever

lopped_piece
	sra	1,a11
	move	a11,*a8(oxvel),l
	clr	a1
	movi	>6000,a10
	jsrp	gravity_ani_ysize
	calla	rsnd_stab

	sra	1,a11
	move	a11,*a8(oxvel),l
	movi	->20000,a1
	movi	>6000,a10
	jsrp	gravity_ani_ysize
	calla	rsnd_stab
	die

gravity_ani_ysize
	move	a1,*a8(oyvel),l		; send 'em skywards

gas2	sleep	1
	move	*a8(oyvel),a0,l
	add	a10,a0
	move	a0,*a8(oyvel),l		; single object = gravity by hand
	jrn	gas2			; heading upwards = loop
	
	move	*a8(osizey),a0,w
	move	*a8(oypos),a1,w
	add	a1,a0
	move	@ground_y,a2,w
	cmp	a2,a0
	jrlt	gas2
	calla	stop_a8
	retp

;**************************************************************************

lao_tornado
	jsrp	fatality_start_pause
	callr	sans_repell_for_good

	movk	6,a0
	callr	local_ochar_sound		; tornado sound
	jsrp	normal_spin_intro

	movi	>00040020,a11
	calla	shake_a11			; long shake...

	movi	tornado_sucked,a7
	calla	takeover_him
	create	pid_fx,nado_sounds

	movk	3,a9
	calla	local_get_char_ani2
	movi	>00030030,a0
	jsrp	animate_a0_frames
	calla	player_normpal
	jsrp	normal_spin_intro

	callr	death_blow_complete
	jruc	local_victory_animation

tornado_sucked
	calla	player_normpal
	calla	me_in_back
	movi	>4000,a10

sucked3	sleep	1
	addi	>2000,a10
	move	a10,a0
	calla	towards_x_vel
	calla	get_x_dist
	cmpi	8,a3
	jrhi	sucked3
	calla	set_inviso
	calla	stop_me
	calla	face_opponent
	movi	>24,a0
	calla	create_fx

	jauc	wait_forever


normal_spin_intro
	movk	2,a9
	calla	local_get_char_ani2
	movi	>00010020,a0
	jauc	animate_a0_frames

nado_sounds
	movk	6,a0
	callr	local_ochar_sound		; tornado sound
	movk	7,a0
	callr	local_ochar_sound		; tornado sound
	sleep	>40
	jruc	nado_sounds

;**************************************************************************

cyrax_helecopter
	jsrp	fatality_start_pause

	callr	sans_repell_for_good

	movi	>0e,a9
	calla	pose2_a9
	sleep	>20

	callr	hele_sound
	movi	>00020010,a0
	jsrp	animate_a0_frames
	movi	>00010010,a0
	jsrp	animate_a0_frames

	callr	hele_sound
	movi	>0e,a9
	calla	find_ani2_part2
	movi	>00010010,a0
	jsrp	animate_a0_frames

	callr	hele_sound
	movi	>0e,a9
	calla	find_ani2_part2
	calla	find_part2

	movk	1,a10
	movk	2,a0
	calla	init_anirate
	movi	->2000,a0
	move	a0,*a8(ograv),l
hele4	callr	hele_sleep
	calla	distance_off_ground		; raise up my child !
;	cmpi	>f0,a0
	cmpi	>60,a0
	jrlo	hele4

	calla	stop_me
	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a1,w
	move	a1,*a8(oxpos),w			; directly above him !!
	calla	flip_multi_v

	movi	>40000,a0
	move	a0,*a8(oyvel),l			; down do be do down down !!
hele7	callr	hele_sleep
	calla	distance_off_ground		; raise up my child !
	cmpi	>00,a0
	jrgt	hele7

	movk	20,a10
	movi	hele_cutup,a7
	calla	takeover_him
	movi	>20000,a0
	move	a0,*a8(oyvel),l			; slower

	movk	1,a0
	move	a0,*a13(p_store5),w

hele8	callr	hele_sleep

	move	*a13(p_store5),a0,w
	dec	a0
	jrne	hele9
	movi	>23,a0
	calla	create_fx			; blood explode
	movk	14,a0
hele9	move	a0,*a13(p_store5),w
	calla	distance_off_ground		; raise up my child !
	cmpi	->80,a0
	jrgt	hele8

helea	callr	hele_sleep
	calla	distance_off_ground		; raise up my child !
	cmpi	->12a,a0
	jrgt	helea

	calla	stop_a8

	calla	back_to_normal
	calla	init_special			; rev2.1 addition !!

	calla	set_inviso
	calla	match_me_with_him
	calla	ground_player
	jsrp	cyrax_implode

	callr	death_blow_complete
	jruc	local_victory_animation


hele_cutup
	movi	>00060020,a11
	calla	shake_a11

	calla	back_to_normal
	move	a8,a10			; a10 = me
	calla	set_inviso
	movi	ochar_cutups,a0
	calla	get_char_long
	
	movk	10,a6
	movi	>10,a11
helec2	move	*a0+,a5,l
	jreq	hcut3
	push	a0
	calla	gso_dmawnz
	callr	cutup_correct_pal

	move	a6,*a8(ozpos),w
	dec	a6
	create	pid_blood,hele_slice
	move	a11,*a0(pa11),l		; pass sleep time
	addk	10,a11			; spacing of chunks
	pull	a0
	jruc	helec2

hcut3 	move	a10,a8
	callr	death_scream
	movk	10,a10
hcut4	sleep	8

	btst	0,a10
	jreq	hcut5
	movi	>2e,a0
	calla	create_fx		; shoot bonz out !!
	move	*a8(oypos),a0,w
	addi	10,a0
	move	a0,*a8(oypos),w

hcut5	calla	rsnd_stab
	dsj	a10,hcut4

	jauc	wait_forever


hele_slice
	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm		; lineup with me
	calla	insobja8
	move	a11,a0
	calla	prcslp
	move	a8,a0
	calla	delobjp
	jruc	l_die


hele_sleep
	pull	a11
	sleep	1
	dsj	a10,hele6
	movi	>20,a10
	callr	hele_sound
hele6	calla	next_anirate
	jump	a11

hele_sound
	movi	>1d,a0
	calla	ochar_sound
	movi	>1e,a0
	jauc	ochar_sound

;**************************************************************************

cyrax_self_destruct
	jsrp	fatality_start_pause

	movi	>1b,a0
	calla	ochar_sound		; self destruct sound

	movi	>0d,a9
	callr	local_get_char_ani2
	movk	6,a0
	jsrp	mframew
	move	a9,a11

	movk	4,a0
	callr	animate_a11
	movk	4,a0
	callr	animate_a11
	movk	4,a0
	callr	animate_a11

	movi	>0d,a9
	callr	local_get_char_ani2
	calla	find_part2
	calla	find_part2

	calla	delete_slave
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	selfd3
	calla	flip_multi		; avoid reverse text
selfd3
	movk	6,a0
	jsrp	mframew

	move	a9,a11
	movk	6,a0
	callr	animate_a11
	movk	6,a0
	callr	animate_a11
	movk	6,a0
	callr	animate_a11
	movk	6,a0
	callr	animate_a11
	movk	6,a0
	callr	animate_a11

	movi	>22,a0
	calla	create_fx
	move	*a13(p_otherguy),*a0(p_otherguy),l

	callr	wfe_him
	calla	delete_slave
	calla	set_inviso
	movi	set_inviso,a0
	calla	calla_for_him

	sleep	>80

	callr	death_blow_complete
	jruc	local_wait_forever

animate_a11
	pull	a1
	pushp	a1
	move	a11,a9
	jsrp	mframew
	pullp	a1
	jump	a1

;**************************************************************************

jax_grow
	jsrp	fatality_start_pause

	callr	sans_repell_for_good

	movi	grow_victum,a7
	calla	takeover_him

	move	*a8(oxpos),*a13(p_store4),w 	; centered x

	movk	4,a9
	calla	get_char_ani2
	move	*a9,a1,l
	move	*a8(oflags2),a4,w
	andni	m_multipart,a4
	move	a4,*a8(oflags2),w		; no more multipart for me
	move	*a8(oflags),a4,w
	andni	m_fliph,a4			; no flip
	calla	ani

	push	a8
	calla	getobj
	calla	copy_obj
	move	a0,a8
	movi	JAXGROWFINB,a1
	calla	ani_flag	
	move	a8,*a13(p_store1),l
	calla	insobja8
	pull	a8

	movi	>0a,a0
	calla	ochar_sound    		; grow sound

	movi	>01500150,a9
jgrow3	move	a9,*a8(oscale),l
	move	*a13(p_store1),a0,l
	move	a9,*a0(oscale),l	; scale 2 both players !!

	movi	JAXGROWFINA,a5
	callr	get_scaled_x_size
	move	*a13(p_store4),a2,w
	sub	a1,a2			; right justify
	move	a2,*a8(oxpos),w
	callr	ground_scaled_jax

	push	a8
	move	a8,a7
	move	*a13(p_store1),a8,l
	move	*a13(p_store4),a2,w
	move	a2,*a8(oxpos),w
	movi	JAXGROWFINB,a5
	move	*a7(oypos),a0,w
	addk	2,a0
	move	a0,*a8(oypos),w
	pull	a8

	sleep	1
	subi	>00040004,a9
	cmpi	>00500050,a9
	jrne	jgrow3

	sleep	>30

	calla	set_inviso
	move	*a13(p_store1),a8,l
;	calla	delobjp			; dont need this

	movi	>01000100,a0
	move	a0,*a8(oscale),l	; normal scale

	movi	>100,a0
	move	a0,*a8(ozpos),w		; in front of blood

	movi	JAXBIGBOOT,a1
	calla	ani_flag
	move	*a13(p_otherguy),a1,l
	move	a8,a0
	calla	lineup_1pwm

	clr	a1
	movi	->20,a0
	calla	multi_adjust_xy		; right over his friggin head

	move	*a8(osizey),a0,w
	move	@ground_y,a1,w
	sub	a0,a1
	move	a1,a9
	subi	scrbot->20,a1
	move	a1,*a8(oypos),w

	movi	r_jax_stomp,a7
	calla	takeover_him

	movi	>140000,a0
	move	a0,*a8(oyvel),l		; down comes the BOOT
stomp2	sleep	1
	move	*a8(oypos),a0,w
	cmp	a9,a0
	jrlt	stomp2
	calla	stop_a8
	move	a9,*a8(oypos),w

	movk	8,a0
	callr	local_ochar_sound
	movk	9,a0
	callr	local_ochar_sound

	calla	rsnd_ground
	movi	>000a000a,a11
	calla	shake_a11

	sleep	>10
	callr	death_blow_complete
	jruc	local_wait_forever


r_jax_stomp
	movk	4,a9
	calla	get_char_ani
	movk	3,a0
	jsrp	mframew		; duck ani
	calla	set_inviso
	movi	>21,a0
	calla	create_fx
	jauc	wait_forever


grow_victum
	sleep	6

	calla	face_opponent
	move	*a8(oxpos),a11,w
	clr	a1
	movi	>b0,a0
	calla	multi_adjust_xy
	move	*a8(oxpos),a9,w

	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jrne	grv3
	subi	scrrgt,a9
grv3	calla	lineup_on_a9
	move	a11,*a8(oxpos),w

	sleep	>40
	calla	death_scream
	movi	>40,a9
	calla	pose_a9
	movi	4,a0
	movi	3,a1
	movi	9,a2
	jsrp	shake_a8_up
	jauc	wait_forever


ground_scaled_jax
	move	*a5(isizey),a10,w
	sll	8,a10			; shift for the formula

	move	a10,a1
	move	a9,a3
	srl	16,a3			; only look at y
	divs	a3,a1			; a1 = new scaled y size
	move	@ground_y,a0,w
	sub	a1,a0
	move	a0,*a8(oypos),w	 	; ground new jax image
	rets

get_scaled_x_size
	move	*a5(isizex),a11,w
	sll	8,a11			; shift for the formula
	move	a11,a1
	move	a9,a3
	zext	a3,w			; only look at x
	divs	a3,a1			; a1 = new scaled x size
	rets

;**************************************************************************

jax_slice
	jsrp	fatality_start_pause

	movk	7,a0
	calla	ochar_sound
	movi	>00050003,a9
	jsrp	animate2_a9			; on yer knee
	sleep	>30

	movi	get_sliced_up,a7
	calla	takeover_him

	movi	>00030020,a0
	jsrp	animate_a0_frames		; whiz !!
	movk	3,a9
	calla	get_char_ani2
	calla	find_last_frame
	calla	do_next_a9_frame
	sleep	>10

	movi	post_sliced_up,a7
	calla	takeover_him

	movk	3,a9
	calla	find_ani2_part2
	calla	find_part2
	movk	5,a0
	jsrp	mframew				; arms back 2 normal

	callr	death_blow_complete
	jruc	local_victory_animation


get_sliced_up
	callr	death_scream
	calla	set_ignore_y

	movi	>0004000e,a11
	calla	shake_a11

	movk	1,a11
	move	a11,a10
	movi	>20,a9
	calla	find_ani_part2
	movi	3,a0
	calla	init_anirate
slice1	movi	->20000,a0
slice2	move	a0,*a8(oyvel),l
	sleep	1
	dsjs	a11,slice3
	movi	30,a11
	movi	>20,a0
	calla	create_fx			; blood explode

slice3	dsjs	a10,slice4
	calla	rsnd_stab
	movk	9,a10				; stab sound speed

slice4	calla	next_anirate
	calla	distance_off_ground
	cmpi	>40,a0
	jrlo	slice1
	clr	a0
	jruc	slice2


post_sliced_up
	move	a8,a10
	calla	set_inviso

	movi	ochar_cutups,a0
	calla	get_char_long
	movk	10,a11

posts3	move	*a0+,a5,l
	jreq	local_wait_forever
	push	a0
	calla	gso_dmawnz

	callr	cutup_correct_pal
	move	a11,*a8(ozpos),w
	dec	a11
	create	pid_blood,slice_fall
	pull	a0
	jruc	posts3


slice_fall
	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm		; lineup with me
	calla	insobja8

	movi	>20,a0
	movi	>20,a1
	calla	randu_minimum
	calla	prcslp

	move	@ground_y,a0,w
	move	a0,*a13(p_ganiy),w

	movi	never_ani,a0
	clr	a1
	clr	a6
	clr	a9
	movi	>6000,a10
	jsrp	gravity_ani		; chunk fall 2 the ground
	calla	rsnd_stab

	movi	>30000,a0
	movi	>10000,a1
	calla	randu_minimum
	move	@rand,a2,l
	jrn	sfall3
	neg	a0
sfall3	move	a0,*a8(oxvel),l	 	; not many comments here are there !

	movi	never_ani,a0
	movi	->40000,a1
	clr	a6
	clr	a9
	movi	>6000,a10
	jsrp	gravity_ani
	calla	rsnd_stab
	calla	stop_a8
	jauc	wait_forever


*
* a10 = original guy
*
cutup_correct_pal
	move	*a10(ochar),a0,w
	cmpi	ft_jax,a0
	jrne	ccp2
*
* Jax
*
	move	*a13(p_otherguy),a1,l
	move	*a1(ochar),a1,w
	cmpi	ft_jax,a1
	jrne	ccpx			; either one not jax = exit
	move	*a10(oid),a0,w
	cmpi	pid_p1,a0
	jreq	ccpx			; player 1 is ok
	movi	JX2CUT_P,a0
	calla	swpal			; player 2 = use alternate
	jruc	ccpx
*
* smoke check
*
ccp2	cmpi	ft_smoke,a0
	jrne	ccp3
	movi	SMCUT_P,a0
	calla	swpal			; use alternate
	jruc	ccpx

ccp3	cmpi	ft_robo2,a0
	jrne	ccp5
	movi	CYCUT_P,a0
	calla	swpal			; use alternate
	jruc	ccpx

ccp5	cmpi	ft_lao,a0
	jrne	ccpx

	move	*a13(p_otherguy),a1,l
	move	*a1(ochar),a1,w
	cmpi	ft_lao,a1
	jrne	ccpx			; not both lao = skip
	move	*a10(oid),a0,w
	cmpi	pid_p1,a0
	jreq	ccpx			; player 1 is ok

	movi	KL2CUT_P,a0
	calla	swpal			; player 2 = use alternate

ccpx	rets


JX2CUT_P:
   .word   63 
   .word   00000h,07bdeh,06f7bh,06739h,05ef7h,056b5h,04e73h,04631h
   .word   03defh,035adh,0318ch,02d6bh,0294ah,02529h,018c6h,014a5h
   .word   01084h,00c63h,00842h,00421h,009c2h,00581h,00561h,00140h
   .word   00120h,00100h,000e0h,000c0h,000a0h,00080h,07fdbh,07b16h
   .word   06eb1h,06692h,05e4fh,059ebh,05161h,04daah,04567h,04168h
   .word   04125h,03d69h,03d26h,03905h,038e3h,03506h,034c4h,03082h
   .word   02cc5h,02c82h,028e6h,028a3h,02483h,02440h,02062h,01842h
   .word   01800h,01021h,01000h,07c00h,06000h,04400h,00000h


SMCUT_P:
   .word   63 
   .word   00000h,0737fh,06b3eh,062fdh,05edch,05a9bh,0527ah,04e39h
   .word   04619h,041d8h,03db7h,03596h,03175h,02d34h,02913h,024f3h
   .word   020d2h,01cb1h,018b0h,0148fh,0106eh,00c4eh,0084dh,0082ch
   .word   0042bh,0000ah,00009h,00008h,00008h,07fffh,077bdh,0739ch
   .word   06f7bh,06b5ah,06739h,06318h,05ef7h,05ad6h,056b5h,05294h
   .word   04e73h,04a52h,04631h,04210h,03defh,039ceh,035adh,0318ch
   .word   02d6bh,0294ah,02108h,01ce7h,018c6h,014a5h,01084h,00c63h
   .word   00842h,00421h,00000h,0001fh,00016h,00010h,00000h

CYCUT_P:
   .word   63 
   .word   00000h,07ffeh,07ffah,07ff5h,07ff1h,07badh,07789h,07365h
   .word   06f22h,06f00h,06ae0h,062c0h,05ea0h,05a60h,05640h,05220h
   .word   04e00h,049e0h,045c0h,041a0h,03d80h,03960h,03540h,03120h
   .word   02d00h,028e0h,024c0h,020a0h,01ca0h,07fffh,077bdh,0739ch
   .word   06f7bh,06b5ah,06739h,06318h,05ef7h,05ad6h,056b5h,05294h
   .word   04e73h,04a52h,04631h,04210h,03defh,039ceh,035adh,0318ch
   .word   02d6bh,0294ah,02108h,01ce7h,018c6h,014a5h,01084h,00c63h
   .word   00842h,00421h,00000h,0001fh,00016h,00010h,00000h

KL2CUT_P:
   .word   63 
   .word   00000h,07fffh,0739ch,06b5ah,05ad6h,04a52h,039ceh,0294ah
   .word   01ce7h,014a5h,01084h,00842h,00001h,00319h,002d7h,00295h
   .word   00233h,001f1h,00190h,0014eh,0010dh,000ech,000abh,00089h
   .word   00068h,00047h,00006h,07fdeh,07fb9h,07f97h,07f56h,07b14h
   .word   076f2h,076cfh,06e8dh,06ad5h,06a90h,00279h,065e7h,06692h
   .word   0664dh,0624dh,05e50h,05da1h,051edh,049cch,049aah,04987h
   .word   04565h,04189h,03d68h,03926h,034e3h,030a2h,028c4h,02861h
   .word   024a1h,02062h,07c00h,06000h,04800h,03800h,00000h

;**************************************************************************

robo_flame_throw
	jsrp	fatality_start_pause

	movi	>0005000a,a9
	jsrp	animate2_a9			; on yer knee

	movi	robo_skeleton_burn,a7
	calla	takeover_him
	sleep	1
	calla	delete_slave
	sleep	>20

	movk	10,a9
	calla	find_ani2_part2
	movk	5,a0
	jsrp	mframew
	sleep	>80

	callr	death_blow_complete
	jruc	local_victory_animation

;**************************************************************************

lia_hair_spin
	jsrp	fatality_start_pause

	movi	>0a,a9
	calla	local_get_char_ani2

	movi	slide_behind_hair,a7
	calla	takeover_him

	movk	4,a0
	jsrp	mframew
	sleep	>30

	movi	hair_spun,a7
	calla	takeover_him		; send him into a frenzy

	movk	3,a0
	jsrp	mframew
	sleep	>40

	callr	death_blow_complete
	jruc	local_victory_animation


slide_behind_hair
	movi	>40000,a0
	calla	away_x_vel
sbh3	sleep	1
	calla	get_x_dist
	cmpi	>98,a3
	jrlo	sbh3
	calla	stop_me
	jauc	wait_forever

hair_spun
	callr	death_scream
	calla	center_around_me
	movk	7,a0
	calla	his_ochar_sound		; tornado sound
	movk	8,a0
	calla	his_ochar_sound		; quake rumble
	movi	>00050020,a11
	calla	shake_a11
	movi	>25,a0
	calla	create_fx		; bones n such

	move	*a8(ochar),a0,w
	push	a0
	movk	ft_lia,a0
	move	a0,*a8(ochar),w
	movk	8,a9
	calla	get_char_ani2
	pull	a0
	move	a0,*a8(ochar),w		; borrow animation from lia
	calla	do_next_a9_frame
	move	a9,a11

	movi	>60/2,a10
rtbl5	sleep	2
	calla	do_next_a9_frame
	dsj	a10,rtbl5

	move	a11,a9
	calla	find_part2
	movk	4,a0
	jsrp	mframew
	calla	set_inviso
	jruc	local_wait_forever

;**************************************************************************

lia_scream_rip
	jsrp	fatality_start_pause

	movk	9,a9
	calla	get_char_ani2
	move	a9,a11			; save ochar table
	movi	>00040000,a9
	jsrp	animate2_a9		; lean ovah !!

	movk	8,a0
	calla	local_ochar_sound
	movk	1,a0
	callr	local_ochar_sound	; scream sound

	movi	r_scream_ripped,a7
	calla	takeover_him
	move	a11,*a0(pa11),l
	movi	>0005000c,a0
	jsrp	animate_a0_frames	; scream loop

	sleep	>40

	clr	a9
	movk	5,a0
	jsrp	backwards_ani2
	callr	death_blow_complete
	jruc	local_victory_animation


flesh_rip_sound
	tsound	>70
	sleep	>40
	tsound	>70
	die

r_scream_ripped
	create	pid_blood,flesh_rip_sound
	push	a11
	movi	>00060030,a11
	calla	shake_a11
	pull	a11

	calla	face_opponent
	create	pid_blood,remaining_skel

	move	a11,a0
	calla	get_char_long

	move	*a8(ochar),a1,w
	cmpi	ft_lia,a1
	jrne	nolia
	move	*a8(oid),a1,w
	cmpi	oid_p2,a1
	jrne	nolia

	movk	15,a1
	move	a1,*a8(ochar),w
	move	a11,a0
	calla	get_char_long
	movk	ft_lia,a1
	move	a1,*a8(ochar),w		; player 2 lia = green pal

nolia	move	a0,a9			; a9 = my ripped animation !
	callr	rip_ani			; 1st ripped frame

	jsrp	initial_skeleton_shake

	movi	>a000,a0
	calla	away_x_vel		; speed up
rsr2
	calla	do_next_a9_frame
	sleep	5
	calla	do_next_a9_frame
	sleep	5
	callr	rip_ani
	sleep	5
	calla	do_next_a9_frame
	sleep	5
	calla	do_next_a9_frame
	sleep	5
	calla	do_next_a9_frame
	sleep	5

;	move	*a9,a0,l
;	jrne	rsr2

	calla	stop_me
	calla	set_inviso
	jauc	wait_forever

rip_ani	move	*a9,a1,l
	move	*a1,a1,l
	move	*a1(icmap),a0,l		; new palette ?
	jrnn	ran3			; no
	calla	player_swpal		; yes, use it
ran3	calla	do_next_a9_frame
	rets

;************************************

initial_skeleton_shake
	movi	>8000,a0
	calla	away_x_vel
	movk	3,a0
	movk	3,a1
	movk	6,a2
	jauc	shake_a8_up		; shake a bit 1st

;************************************

remaining_skel
	movi	ochar_skeleton_adj,a0
	calla	get_char_long
	push	a0

	move	a8,a10
	move	a11,a9
	calla	find_part2
	move	*a8(ochar),a0,w
	cmpi	ft_sg,a0
	jrne	rsr1
	addi	32,a9			; sheeva = use other skeleton
rsr1	move	*a9,a9,l
	calla	gmo_proc
	calla	insobja8
	move	a10,a1
	move	a8,a0
	calla	lineup_a0_onto_a1	; lineup with my body

	pull	a0
	move	a0,a1
	zext	a0,w
	sra	16,a1
	calla	multi_adjust_xy		; lineup with body adjustments

	jsrp	initial_skeleton_shake
	movk	8,a0
	jsrp	mframew

	callr	skel_blood
	callr	skel_blood
	callr	skel_blood
	callr	skel_blood

	jauc	wait_forever


skel_blood
	pull	a10

	movi	>0010fff0,a11
	callr	skinny_spawn
	movi	>0020fffc,a11
	callr	skinny_spawn
	movi	>0030fff8,a11
	callr	skinny_spawn
	sleep	>10
	movi	>00300002,a11
	callr	skinny_spawn
	movi	>0040fff0,a11
	callr	skinny_spawn
	sleep	>10
	movi	>0038fff8,a11
	callr	skinny_spawn
	movi	>0020fff8,a11
	callr	skinny_spawn
	sleep	>10
	jump	a10

skinny_spawn
	movi	>19,a0
	jauc	create_fx

ochar_skeleton_adj
	.long	0
	.long	>00080000
	.long	>00100000
	.long	0
	.long	0

	.long	0
	.long	>00060000
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	>fff80008
	.long	0
	.long	0

;**************************************************************************

sw_plant_bomb
	jsrp	fatality_start_pause

	callr	sans_repell_for_good

	movi	player_normpal,a0
	calla	calla_for_him

	callr	wfe_him			; disable him
	movi	100,a0
	move	a0,*a8(ozpos),w		; me the most in front
	movi	>00060004,a9
	jsrp	animate2_a9		; back to players !!

	movk	4,a9
	calla	get_char_ani2
	movk	3,a14
	calla	find_part_a14
	callr	attach_obj_to_him
	move	*a10(oypos),a0,w
	addi	>40,a0
	move	a0,*a10(oypos),w	; on chest !

	move	*a13(p_otherguy),a0,l
	move	*a0(oxval),*a8(oxval),l

	movi	>60000,a0
	calla	get_my_dfe
	cmp	a5,a6
	jrhi	plant5
	neg	a0
plant5	calla	set_x_vel

	movi	dont_touch,a0
	movi	>1a,a9
  	movi	->a0000,a1		; initial y vel (upwards)
	movi	angle_grav,a2
	movk	3,a3			; animation speed
	movk	4,a11			; flip whoosh sound speed
 	jsrp	flight

	calla	face_opponent
	tsound	>18			; feet gently landing on the ground
	movi	>1a,a9
	calla	get_char_ani
	calla	do_next_a9_frame
	sleep	3

	movk	4,a9
	calla	find_ani2_part2
	movk	6,a0
	jsrp	mframew			; plug ears !!
	sleep	>20

	movk	4,a9
	calla	get_char_ani2
	movk	4,a14
	calla	find_part_a14

	move	a8,a11
	move	a10,a8
	calla	do_next_a9_frame   	; BANG !!!
	sleep	2
	move	a8,a0
	calla	delobjp			; rid of BANG/BOMB image

	move	*a13(p_otherguy),a8,l
	calla	set_inviso
	movi	>18,a0
	calla	create_fx		; explode

	move	a11,a8			; a8 = me again
	jsrp	white_flash

	sleep	>40

	callr	death_blow_complete
	jruc	local_victory_animation


attach_obj_to_him
	push	a8
	calla	gmo_proc
	move	a8,a0
	move	*a13(p_otherguy),a1,l
	calla	lineup_a0_onto_a1		; put bomb on their chest
	calla	a8_front_plus_1
	calla	insobja8
	move	a8,a10
	pull	a8
	rets

;**************************************************************************

swat_taser
	jsrp	fatality_start_pause

	movk	3,a9
	calla	get_char_ani2
	movk	5,a0
	jsrp	mframew				; pull out da gun
	sleep	>10

	movk	7,a0
	calla	local_ochar_sound
	movk	5,a0
	jsrp	mframew				; fire !!

	movi	r_tasered,a7
	calla	takeover_him

	movk	18,a10
taz3	movk	6,a0
	callr	local_ochar_sound		; shocker the guard sound
	movk	3,a9
	calla	find_ani2_part2
	calla	find_part2
	movk	4,a0
	jsrp	mframew
	dsj	a10,taz3

	callr	death_blow_complete
	jruc	local_victory_animation


r_tasered
	movi	taser_lineups,a0
	calla	get_char_word
	clr	a1
	calla	fatal_offset

	movi	>000a0010,a11
	calla	shake_a11

	tsound	>1e			; zap sound
	callr	death_scream
	movk	9,a11
	jsrp	shocker_shaker
	jauc	collapse_on_ground

taser_lineups
	.word	->110
	.word	->110
	.word	->f8
	.word	->108
	.word	->120

	.word	->120
	.word	->120
	.word	->108
	.word	->108
	.word	->100

	.word	->100
	.word	->f0	; sg
	.word	->120	; st
	.word	->100	; lk
	.word	->108

	.word	->120
	.word	->120
	.word	->120

;**************************************************************************

sz_lift_n_freeze
	jsrp	fatality_start_pause

	movk	5,a9
	calla	get_char_ani2
	movi	>00080002,a0
	jsrp	animate_a0_frames	; reach out
	callr	wfe_him
	callr	make_him_face_me

	movi	>31,a11
	calla	get_his_a11_ani		; borrow lifted by sg ani
	calla	double_next_a9
	sleep	6

	calla	do_next_a9_frame

	push	a9
	movi	>1e,a9
	movi	find_ani_part2,a0
	calla	calla_for_him
	addi	32,a9
	movi	do_next_a9_frame,a0
	calla	calla_for_him
	pull	a9

	calla	match_him_with_me
	move	@ground_y,a0,w
	subi	>120,a0
	move	a0,*a10(oypos),w

	movi	>000a0010,a11
	calla	shake_a11
	tsound	>87				; add more zest-fully-clean

	movi	freeze_into_boomer,a7
	calla	takeover_him

	subi	32,a9
	move	a9,a11
*
* shake him over my head !!
*
	move	a11,a9
	callr	liftshake
	callr	liftshake
	move	a11,a9
	callr	liftshake
	callr	liftshake
	move	a11,a9
	callr	liftshake
	callr	liftshake

	sleep	>20

	tsound	>24
	tsound	>25
	movi	>000a000a,a11
	calla	shake_a11			; rip sound !!

	calla	a8_back_minus_1
	push	a8
	move	*a13(p_otherguy),a8,l
	movi	>2d,a0
	calla	create_fx			; gutz n' such !!
	pull	a8

	movi	death_scream,a0
	calla	calla_for_him

	callr	make_him_invisible
	calla	find_part2
	movk	4,a0
	jsrp	mframew
*
* create an object for the other half of the other dude
*
	mmtm	sp,a8,a9
	movk	5,a9
	calla	find_ani2_part2
	addi	32,a9
	calla	gmo_proc
	calla	insobja8
	move	a8,a11
	create	pid_bani,frozen_half_ani
	mmfm	sp,a8,a9

	move	a11,a0
	move	a8,a1
	calla	lineup_a0_onto_a1		; lineup ice piece with sz

	tsound	>00
	tsound	>01
	movi	>000a0010,a11
	calla	shake_a11

	movk	2,a0
	jsrp	mframew				; finish my animation

	sleep	>18

	callr	death_blow_complete
	jruc	local_victory_animation


frozen_half_ani
	calla	flip_multi
	calla	find_part2
	calla	find_part2
	movk	2,a0
	jsrp	mframew
	die

;***********************************************

liftshake
	pull	a10
	calla	do_next_a9_frame
	movk	3,a2
	move	a8,a0
	callr	lifts3
	sleep	3
	movi	-3,a2
	move	a8,a0
	callr	lifts3
	sleep	3
	jump	a10

lifts3	move	*a0(oxpos),a1,w
	add	a2,a1
	move	a1,*a0(oxpos),w
	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a1,w
	add	a2,a1
	move	a1,*a0(oxpos),w
	rets


freeze_into_boomer
	movk	6,a9
	calla	get_his_char_ani2

	move	*a9+,a0,l
	move	*a0,a0,l
	move	*a0(icmap),a0,l
	calla	swpal
	calla	do_next_a9_frame

	move	@ground_y,a0,w
	subi	>90,a0
	move	a0,*a8(oypos),w

	movk	6,a0
	jsrp	mframew
	jruc	local_wait_forever

;**************************************************************************

sz_blow
	jsrp	fatality_start_pause

	movk	3,a9
	calla	get_char_ani2

	movk	7,a0
	callr	local_ochar_sound		; blow sounds

	movk	5,a0
	jsrp	mframew
	movi	r_ice_blow,a7
	calla	takeover_him
	callr	center_around_him

	movk	5,a0
	jsrp	mframew
	calla	delete_slave
	sleep	>40

	callr	death_blow_complete
	jruc	local_victory_animation


r_ice_blow
	movk	8,a0
	calla	his_ochar_sound		; frozen sound
	calla	face_opponent

	calla	death_scream
	calla	player_froze_pal
	movi	>3f,a9
	calla	pose_a9

	movi	4,a0
	movk	3,a1
	movk	10,a2
	jsrp	shake_a8_up

;	sleep	>30
	movk	4,a0
	jsrp	mframew

	movi	>000a0010,a11
	calla	shake_a11
	tsound	>00
	tsound	>01			; krash !!

	movk	4,a9
	calla	get_his_char_ani2
	calla	do_next_a9_frame
	calla	ground_multi

	movi	>18000,a0
	calla	away_x_vel
;	sleep	5

	movk	5,a0
	jsrp	mframew
	calla	stop_me
	jauc	wait_forever

;**************************************************************************

ind_zap_kill
	jsrp	fatality_start_pause

	calla	get_x_dist

	movk	7,a9
	calla	get_char_ani2
	movk	5,a0
	jsrp	mframew
	sleep	6

	movk	3,a0
	jsrp	mframew
	calla	delete_slave
	movi	r_ind_lightning,a7
	calla	takeover_him

	sleep	>40
	callr	death_blow_complete
	jruc	local_victory_animation


r_ind_lightning
	movi	->b8,a0
	clr	a1
	calla	fatal_offset

;	tsound	>1e			; zap sound
	tsound	>00			; zap sound
	tsound	>01			; zap sound
	movi	>000a000d,a11
	calla	shake_a11

	callr	death_scream
	movk	4,a11
	jsrp	shocker_shaker
	jauc	collapse_on_ground

;**************************************************************************

ind_light
	jsrp	fatality_start_pause

	movi	>00060005,a9
	jsrp	animate2_a9
	sleep	>10

	mmtm	sp,a8,a9
	movk	6,a9
	calla	get_char_ani2
	calla	gmo_proc
	calla	a8_front_plus_1
	calla	insobja8
	move	a8,a0
	move	*a13(p_otherguy),a1,l
	calla	lineup_a0_onto_a1
	clr	a0
	movi	>90,a1
	calla	multi_adjust_xy			; on to the ground
	create	pid_bani,light_animator
	create	pid_bani,light_sound_proc
	mmfm	sp,a8,a9

	movk	10,a0
	calla	local_ochar_sound		; light start
	movk	5,a0
	jsrp	mframew

	sleep	>10
	movk	11,a0
	calla	local_ochar_sound		; light start
	sleep	>20

	movi	death_scream,a0
	calla	calla_for_him
	callr	make_him_invisible
	movk	12,a0
	calla	local_ochar_sound		; light end
	sleep	>10
	movk	11,a0
	calla	local_ochar_sound		; light start
	sleep	>20

	callr	death_blow_complete
	jruc	local_victory_animation


light_sound_proc
	die



light_animator
	movk	6,a0
	jsrp	mframew
	move	a8,a0
	calla	delobjp
	die

death_scream
	movk	9,a0
	jauc	group_sound


make_him_invisible
	movi	set_inviso,a0
	jauc	calla_for_him

center_around_him
	movi	center_around_me,a0
	jauc	calla_for_him

;**************************************************************************

sonya_kiss_crusher
	jsrp	fatality_start_pause

	movk	2,a9
	calla	get_char_ani2
	movk	3,a0
	jsrp	mframew

	push	a8
	movk	4,a9
	calla	get_char_ani2
	move	a9,a11
;	move	*a9,a5,l
;	calla	gso_dmawnz
	calla	gmo_proc
	calla	insobja8
	move	a8,a10
	move	a8,a0
	pull	a8
	calla	match_ani_points

	movi	->20,a0
	movi	->10,a1
	move	a10,a5
	calla	adjust_xy_a5		; lineup with sonya

	movk	6,a0
	callr	local_ochar_sound

	create	pid_bani,crusher_orb
	move	*a13(p_otherguy),*a0(p_otherguy),l
	move	*a13(p_otherproc),*a0(p_otherproc),l

	movk	7,a0
	calla	ochar_sound		; rumble sound

	movi	center_around_me,a0
	calla	calla_for_him

	sleep	>90
	callr	death_blow_complete
	jruc	local_victory_animation

crusher_orb
	move	a10,a8
	calla	a8_front_plus_1

	move	a11,a9			; animation of blob
	movk	3,a0
	jsrp	mframew

	movi	>20000,a0
	calla	set_proj_vel
	movk	3,a0
	calla	init_anirate

crush4	sleep	1
	calla	next_anirate
	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a1,w
	move	*a8(oxpos),a2,w
	sub	a1,a2
	abs	a2
	cmpi	>b1,a2			; glide over 2 him
	jrhi	crush4

	calla	stop_a8

	push	a8
	move	a8,a0
	move	*a13(p_otherguy),a8,l
	calla	match_ani_points
	pull	a8			; lineup with him for real

	movi	->b1,a0
	movi	>00,a1
	calla	multi_adjust_xy
	movi	crush_stuggle,a7
	calla	takeover_him

	movi	>0003000d,a0
	jsrp	animate_a0_frames

	movi	crush_duck,a7
	calla	takeover_him
	move	a11,a9			; animation of blob
	calla	find_part2
	calla	find_part2

	movk	4,a0
	jsrp	mframew

	move	a8,a0
	calla	delobjp
	jauc	wait_forever


crush_stuggle
	calla	face_opponent
	calla	death_scream
	movi	>20,a9
	calla	find_ani_part2
	movk	4,a0
	jsrp	mframew
	jauc	wait_forever		; should never get here


crush_blood
	movk	1,a0
	calla	create_blood_proc
	sleep	4
	movk	1,a0
	calla	create_blood_proc
	die

crush_duck
	create	pid_blood,crush_blood
	movi	>2c,a0
	calla	create_fx

	movi	>000c000c,a11
	calla	shake_a11
	tsound	>23			; crush sound

	movi	>00040004,a9
	jsrp	animate_a9

	movk	5,a9
	calla	get_his_char_ani2
	calla	do_next_a9_frame

	move	@ground_y,a0
	move	a0,*a8(oypos),w		; gutz on the ground

	movi	->a8,a0
	movi	->90,a1
	calla	multi_adjust_xy
	movi	pid_scroll,a0
	calla	dallprc
	movi	pid_repell,a0
	calla	dallprc

	jauc	wait_forever

;**************************************************************************

sonya_kiss
	jsrp	fatality_start_pause

	push	a8
	movk	2,a9
	calla	find_ani2_part2
	move	a9,a11
	move	*a9,a5,l
	calla	gso_dmawnz
	move	a8,a10
	calla	insobja8
	pull	a8
	move	a10,a0
	move	a8,a1
	calla	lineup_1pwm			; lineup wid sonya

	movk	2,a9
	calla	get_char_ani2
	callr	kissani
	callr	kissani

	push	a8
	move	a10,a8
	move	*a11,a0,l
	move	*a0(icmap),a0,l
	calla	swpal				; new pal for orb
	pull	a8

kiss4 	callr	kissani
	move	*a9,a0,l
	jrne	kiss4

	movk	6,a0
	callr	local_ochar_sound

	create	pid_fx,kiss_orb
	move	*a13(p_otherguy),*a0(p_otherguy),l
	move	*a13(p_otherproc),*a0(p_otherproc),l

	sleep	>90
	callr	death_blow_complete
	jruc	local_victory_animation


kiss_orb
	move	a10,a8
	move	a11,a9

	movi	>60000,a5		; x vel
	movi	->8000,a11
	calla	is_he_right
	jrc	kflame4
       	neg	a5
	neg	a11
kflame4	move	a5,*a8(oxvel),l		; start moving towards other player
	sleep	>04

	movi	->70000,a0
	move	a0,*a8(oyvel),l		; initial upwards

kflame5	callr	orb_sleep_1
	move	*a8(oxvel),a0,l
	add	a11,a0	
	move	a0,*a8(oxvel),l
	move	*a8(oyvel),a0,l
	addi	>4000,a0
	move	a0,*a8(oyvel),l		; accelerate down
	jrn	kflame5

	movk	10,a11
kflame6	callr	orb_sleep_1
	move	*a8(oxvel),a0,l
	add	a11,a0	
	move	a0,*a8(oxvel),l
	move	*a8(oyvel),a0,l
	addi	>8000,a0
	move	a0,*a8(oyvel),l		; accelerate down
	dsj	a11,kflame6

	calla	stop_a8

	move	*a13(p_otherguy),a10,l	; a10 = opponent obj
	move	*a10(oxpos),a3,w
	move	@ground_y,a5,w			; a5 = destination y
	subi	>58,a5				; adjust
	
	move	*a8(oxpos),a1,w
	move	*a8(oypos),a0,w
	sub	a1,a3				; a3 = x distance to travel
	sub	a0,a5				; a5 = y distance to travel
	sll	16,a3
	sll	16,a5

	movi	>10,a0				; a0 = time
	divs	a0,a3
	divs	a0,a5
	move	a3,*a8(oxvel),l
	move	a5,*a8(oyvel),l

	movk	3,a0
	calla	init_anirate
	movi	>10,a11
kisso3	callr	orb_sleep_1
	dsj	a11,kisso3

	movi	sb_skeleton_burn,a7
	calla	takeover_him
	move	a8,a0
	calla	delobjp
	die


kissani	pull	a0
	pushp	a0
	calla	do_next_a9_frame		; sonya
	mmtm	sp,a8,a9
	move	a10,a8
	move	a11,a9
	calla	frame_a9
	move	a9,a11
	mmfm	sp,a8,a9
	sleep	4
	pullp	a0
	jump	a0

orb_sleep_1
	pull	a10
	calla	next_anirate
	sleep	1
	jump	a10

;**********************************************

robo_skeleton_burn
	calla	face_opponent
	calla	center_around_me
	movi	a_robo_skeleton_burn,a9
	jruc	skburn3

sb_skeleton_burn
	movi	a_sb_skeleton_burn,a9

skburn3	callr	death_scream
	create	pid_bani,skel_fire_proc

	sleep	>12
	calla	set_inviso
	jruc	local_wait_forever

skel_fire_proc
	move	a8,a10			; a10 = victum
	calla	gmo_proc
	move	a10,a1
	move	a8,a0
	calla	lineup_a0_onto_a1
	calla	flip_multi
	calla	a8_front_plus_1
	calla	insobja8
	tsound	>20			; burning flames

	movk	5,a0
	jsrp	mframew
	move	a9,a10

	movk	3,a11
sfire4	move	a10,a9
	movk	5,a0
	jsrp	mframew
	dsj	a11,sfire4

	movk	5,a0
	jsrp	mframew
	sleep	6

	tsound	>21			; burning flames
	movk	6,a0
	jsrp	mframew
	jruc	local_wait_forever


a_sb_skeleton_burn
	.long	SBFRE1
	.long	SBFRE2

a_robo_skeleton_burn
	.long	SKELFIRE1
	.long	SKELFIRE2
	.long	SKELFIRE3
	.long	SKELFIRE4
	.long	SKELFIRE5
	.long	SKELFIRE6
	.long	0

	.long	SKELFIRE7
	.long	SKELFIRE8
	.long	SKELFIRE9
	.long	SKELFIRE10
	.long	SKELFIRE11
	.long	SKELFIRE12
	.long	SKELFIRE13	; loop
	.long	0

	.long	SKELFIRE14
	.long	SKELFIRE15
	.long	SKELFIRE16	; standing skeleton
	.long	0

	.long	ani_sound
	.long	>21
	.long	SKELFIRE17
	.long	SKELFIRE18
	.long	SKELFIRE19
	.long	SKELFIRE20
	.long	SKELFIRE21
	.long	SKELFIRE22
	.long	SKELFIRE23
	.long	SKELFIRE24	; collapse
	.long	0

SBFRE1		.long	SBFIRE1,0
SBFRE2		.long	SBFIRE2,0


SKELFIRE1
	.long	SKELFIRE1A,0
SKELFIRE2
	.long	SKELFIRE2A,0
SKELFIRE3
	.long	SKELFIRE3A,0
SKELFIRE4
	.long	SKELFIRE4A,0
SKELFIRE5
	.long	SKELFIRE5A,0
SKELFIRE6
	.long	SKELFIRE6A,0
SKELFIRE7
	.long	SKELFIRE7A,SKELFIRE7B,0
SKELFIRE8
	.long	SKELFIRE8A,SKELFIRE8B,0
SKELFIRE9
	.long	SKELFIRE9A,SKELFIRE9B,0
SKELFIRE10
	.long	SKELFIRE10A,SKELFIRE10B,0
SKELFIRE11
	.long	SKELFIRE11A,SKELFIRE11B,0
SKELFIRE12
	.long	SKELFIRE12A,SKELFIRE12B,0
SKELFIRE13
	.long	SKELFIRE13A,SKELFIRE13B,0
SKELFIRE14
	.long	SKELFIRE14A,SKELFIRE14B,0
SKELFIRE15
	.long	SKELFIRE15A,SKELFIRE15B,0
SKELFIRE16
	.long	SKELFIRE16A,SKELFIRE16B,0
SKELFIRE17
	.long	SKELFIRE17A,SKELFIRE17B,0
SKELFIRE18
	.long	SKELFIRE18A,SKELFIRE18B,0
SKELFIRE19
	.long	SKELFIRE19A,0
SKELFIRE20
	.long	SKELFIRE20A,0
SKELFIRE21
	.long	SKELFIRE21A,0
SKELFIRE22
	.long	SKELFIRE22A,0
SKELFIRE23
	.long	SKELFIRE23A,0
SKELFIRE24
	.long	SKELFIRE24A,0


;SBBIGBALL1
;	.long	SBBIGBALL1A,SBBIGBALL1B,0
;SBBIGBALL3
;	.long	SBBIGBALL3A,SBBIGBALL3B,0
;SBBIGBALL4
;	.long	SBBIGBALL4A,SBBIGBALL4B,0
;SBBIGBALL5
;	.long	SBBIGBALL5A,SBBIGBALL5B,0
;SBBIGBALL6
;	.long	SBBIGBALL6A,SBBIGBALL6B,0

;**************************************************************************

kano_skeleton
	jsrp	fatality_start_pause

	callr	sans_repell_for_good

	movk	6,a0
	movi	a_kano_rip_skel,a9
	jsrp	mframew
	callr	wfe_him
	callr	make_him_face_me

	movi	player_normpal,a0
	calla	calla_for_him

	movi	ochar_reached,a0
	calla	get_his_char_long
	move	a0,a11
	move	*a13(p_otherguy),a10,l
	calla	double_next_a9

	movi	2,a0
	calla	his_group_sound		; his wasted voice

	movk	7,a0
	calla	ochar_sound
	movk	3,a0
	movk	3,a1
	movk	4,a2
	jsrp	shake_him_up
	sleep	>0b

	movk	7,a0
	calla	ochar_sound		; crunch
	movi	death_shake,a7
	calla	xfer_otherguy
	movk	3,a0
	movk	3,a1
	movk	4,a2
	jsrp	shake_a8_up

	movk	7,a0
	calla	ochar_sound
	movi	9,a0
	calla	his_group_sound		; his wasted voice

	push	a11
	movi	>00080008,a11
	calla	shake_a11
	pull	a11

	movi	skin_fall,a7
	calla	xfer_otherguy
	move	*a13(p_otherproc),a0,l
	move	a11,*a0(pa11),l

	movk	8,a0
	jsrp	mframew
	callr	death_blow_complete
	jruc	local_wait_forever


skin_fall
	move	a11,a9
	movi	>00080002,a0
	jsrp	animate_a0_frames	; open mouth

	movk	3,a0
	movk	3,a1
	movk	10,a2
	jsrp	shake_a8_up

	movi	8,a0
	calla	his_ochar_sound		; skin fall sound
	movk	8,a0
	jsrp	mframew
	jauc	wait_forever


death_shake
	movk	3,a0
	movk	3,a1
	movk	4,a2
	jsrp	shake_a8_up
	jruc	local_wait_forever


ochar_reached
	.long	a_reached_kano
	.long	a_reached_sonya
	.long	a_reached_jax
	.long	a_reached_ind
	.long	a_reached_sz

	.long	a_reached_swat
	.long	a_reached_lia
	.long	a_reached_robo1
	.long	a_reached_robo2
	.long	a_reached_lao

	.long	a_reached_tusk
	.long	a_reached_sg
	.long	a_reached_st
	.long	a_reached_lk
	.long	a_reached_robo1

a_kano_rip_skel
	.long	KNRIPSKEL1
	.long	KNRIPSKEL2
	.long	KNRIPSKEL3
	.long	KNRIPSKEL4
	.long	0

	.long	KNRIPSKEL5
	.long	ani_sladd,MAINBONE1
	.long	KNRIPSKEL6
	.long	ani_slani,MAINBONE2
	.long	KNRIPSKEL7
	.long	ani_slani,MAINBONE3
	.long	KNRIPSKEL7
	.long	ani_slani,MAINBONE4
	.long	KNRIPSKEL8
	.long	ani_slani,MAINBONE5
	.long	KNRIPSKEL9
	.long	ani_slani,MAINBONE6
	.long	KNRIPSKEL9
	.long	0


MAINBONE1
	.long	MAINBONE1A,0
MAINBONE2
	.long	MAINBONE2A,0
MAINBONE3
	.long	MAINBONE3A,MAINBONE3B,MAINBONE3C,0
MAINBONE4
	.long	MAINBONE4A,MAINBONE4B,0
MAINBONE5
	.long	MAINBONE5A,MAINBONE5B,0
MAINBONE6
	.long	MAINBONE6A,MAINBONE6B,0


KNRIPSKEL1
	.long	KNRIPSKEL1A,KNRIPSKEL1B,0
KNRIPSKEL2
	.long	KNRIPSKEL2A,KNRIPSKEL2B,0
KNRIPSKEL3
	.long	KNRIPSKEL3A,KNRIPSKEL3B,0
KNRIPSKEL4
	.long	KNRIPSKEL4A,KNRIPSKEL4B,0
KNRIPSKEL5
	.long	KNRIPSKEL5A,KNRIPSKEL5B,0
KNRIPSKEL6
	.long	KNRIPSKEL6A,KNRIPSKEL6B,0
KNRIPSKEL7
	.long	KNRIPSKEL7A,KNRIPSKEL7B,0
KNRIPSKEL8
	.long	KNRIPSKEL8A,KNRIPSKEL8B,KNRIPSKEL8C,0
KNRIPSKEL9
	.long	KNRIPSKEL9A,KNRIPSKEL9B,KNRIPSKEL9C,0

;***************************

a_reached_kano
	.long	ani_adjustxy
	.word	-9,10
	.long	KNMOUTH3
	.long	KNMOUTH4
	.long	KNMOUTH5

	.long	KNMOUTH6
	.long	KNMOUTH7
	.long	KNMOUTH8
	.long	0

KNMOUTH3
	.long	KNMOUTH3A,KNSKELEG1A,KNSKELEG1B,0
KNMOUTH4
	.long	KNMOUTH4A,KNSKELEG1A,KNSKELEG1B,0
KNMOUTH5
	.long	KNMOUTH5A,KNSKELEG1A,KNSKELEG1B,0
KNMOUTH6
	.long	KNMOUTH6A,0
KNMOUTH7
	.long	KNMOUTH7A,0
KNMOUTH8
	.long	KNMOUTH8A,0

;***************************

a_reached_sonya
	.long	ani_adjustxy
	.word	-5,>00
	.long	SBMOUTH3
	.long	SBMOUTH4
	.long	SBMOUTH5
	.long	SBMOUTH6
	.long	SBMOUTH7
	.long	SBMOUTH8
	.long	0

SBMOUTH3
	.long	SBMOUTH3A,SBMOUTH3B,SBSKELEG1A,SBSKELEG1B,0
SBMOUTH4
	.long	SBMOUTH4A,SBMOUTH4B,SBSKELEG1A,SBSKELEG1B,0
SBMOUTH5
	.long	SBMOUTH5A,SBMOUTH5B,SBSKELEG1A,SBSKELEG1B,0
SBMOUTH6
	.long	SBMOUTH6A,SBMOUTH6B,SBMOUTH6C,0
SBMOUTH7
	.long	SBMOUTH7A,0
SBMOUTH8
	.long	SBMOUTH8A,0


;***************************

a_reached_jax
	.long	ani_adjustxy
	.word	-9,10
	.long	JXMOUTH3
	.long	JXMOUTH4
	.long	JXMOUTH5
	.long	JXMOUTH6
	.long	JXMOUTH7
	.long	JXMOUTH8
	.long	0

JXMOUTH3
	.long	JXMOUTH3A,JXSKELEG1A,JXSKELEG1B,0
JXMOUTH4
	.long	JXMOUTH4A,JXSKELEG1A,JXSKELEG1B,0
JXMOUTH5
	.long	JXMOUTH5A,JXSKELEG1A,JXSKELEG1B,0
JXMOUTH6
	.long	JXMOUTH6A,JXMOUTH6B,0
JXMOUTH7
	.long	JXMOUTH7A,0
JXMOUTH8
	.long	JXMOUTH8A,0



;***************************

a_reached_ind
	.long	ani_adjustxy
	.word	-10,>00
	.long	INMOUTH3
	.long	INMOUTH4
	.long	INMOUTH5
	.long	INMOUTH6
	.long	INMOUTH7
	.long	INMOUTH8
	.long	0

INMOUTH3
	.long	INMOUTH3A,INSKELEG1A,INSKELEG1B,INSKELEG1C,0
INMOUTH4
	.long	INMOUTH4A,INSKELEG1A,INSKELEG1B,INSKELEG1C,0
INMOUTH5
	.long	INMOUTH5A,INSKELEG1A,INSKELEG1B,INSKELEG1C,0
INMOUTH6
	.long	INMOUTH6A,INMOUTH6B,INMOUTH6C,0
INMOUTH7
	.long	INMOUTH7A,0
INMOUTH8
	.long	INMOUTH8A,0


;***************************

a_reached_sz
	.long	ani_adjustxy
	.word	>00,>0a
	.long	SZMOUTH3
	.long	SZMOUTH4
	.long	SZMOUTH5
	.long	SZMOUTH6
	.long	SZMOUTH7
	.long	SZMOUTH8
	.long	0

SZMOUTH3
	.long	SZMOUTH3A,SZSKELEG1A,SZSKELEG1B,0
SZMOUTH4
	.long	SZMOUTH4A,SZSKELEG1A,SZSKELEG1B,0
SZMOUTH5
	.long	SZMOUTH5A,SZSKELEG1A,SZSKELEG1B,0
SZMOUTH6
	.long	SZMOUTH6A,SZMOUTH6B,0
SZMOUTH7
	.long	SZMOUTH7A,0
SZMOUTH8
	.long	SZMOUTH8A,0


;***************************

a_reached_swat
	.long	ani_adjustxy
	.word	-9,10
	.long	OBMOUTH3
	.long	OBMOUTH4
	.long	OBMOUTH5
	.long	OBMOUTH6
	.long	OBMOUTH7
	.long	OBMOUTH8
	.long	0

OBMOUTH3
	.long	OBMOUTH3A,OBSKELEG1A,OBSKELEG1B,0
OBMOUTH4
	.long	OBMOUTH4A,OBSKELEG1A,OBSKELEG1B,0
OBMOUTH5
	.long	OBMOUTH5A,OBSKELEG1A,OBSKELEG1B,0
OBMOUTH6
	.long	OBMOUTH6A,OBMOUTH6B,OBMOUTH6C,0
OBMOUTH7
	.long	OBMOUTH7A,0
OBMOUTH8
	.long	OBMOUTH8A,0

;***************************

a_reached_lia
	.long	ani_adjustxy
	.word	-9,0
	.long	LIMOUTH3
	.long	LIMOUTH4
	.long	LIMOUTH5
	.long	LIMOUTH6
	.long	LIMOUTH7
	.long	LIMOUTH8
	.long	0

LIMOUTH3
	.long	LIMOUTH3A,LISKELEG1A,LISKELEG1B,LISKELEG1C,0
LIMOUTH4
	.long	LIMOUTH4A,LISKELEG1A,LISKELEG1B,LISKELEG1C,0
LIMOUTH5
	.long	LIMOUTH5A,LISKELEG1A,LISKELEG1B,LISKELEG1C,0
LIMOUTH6
	.long	LIMOUTH6A,LIMOUTH6B,LIMOUTH6C,0
LIMOUTH7
	.long	LIMOUTH7A,0
LIMOUTH8
	.long	LIMOUTH8A,0


;***************************

a_reached_robo1
a_reached_robo2
	.long	ani_adjustxy
	.word	-9,4
	.long	RBMOUTH3
	.long	RBMOUTH4
	.long	RBMOUTH5
	.long	RBMOUTH6
	.long	RBMOUTH7
	.long	RBMOUTH8
	.long	0

RBMOUTH3
	.long	RBMOUTH3A,RBMOUTH3B,RBMOUTH3C,RBSKELEG1A,RBSKELEG1B,0
RBMOUTH4
	.long	RBMOUTH4A,RBMOUTH4B,RBMOUTH4C,RBSKELEG1A,RBSKELEG1B,0
RBMOUTH5
	.long	RBMOUTH5A,RBMOUTH5B,RBMOUTH5C,RBSKELEG1A,RBSKELEG1B,0
RBMOUTH6
	.long	RBMOUTH6A,RBMOUTH6B,RBMOUTH6C,0
RBMOUTH7
	.long	RBMOUTH7A,0
RBMOUTH8
	.long	RBMOUTH8A,0


ROBOBONE1
	.long	ROBOBONE1A,0
ROBOBONE2
	.long	ROBOBONE2A,0
ROBOBONE3
	.long	ROBOBONE3A,ROBOBONE3B,0
ROBOBONE4
	.long	ROBOBONE4A,ROBOBONE4B,ROBOBONE4C,0


;***************************

a_reached_lao
	.long	ani_adjustxy
	.word	9,0
	.long	KLMOUTH3
	.long	KLMOUTH4
	.long	KLMOUTH5
	.long	KLMOUTH6
	.long	KLMOUTH7
	.long	KLMOUTH8
	.long	0

KLMOUTH3
	.long	KLMOUTH3A,KLSKELEG1A,KLSKELEG1B,KLSKELEG1C,0
KLMOUTH4
	.long	KLMOUTH4A,KLSKELEG1A,KLSKELEG1B,KLSKELEG1C,0
KLMOUTH5
	.long	KLMOUTH5A,KLSKELEG1A,KLSKELEG1B,KLSKELEG1C,0
KLMOUTH6
	.long	KLMOUTH6A,KLMOUTH6B,KLMOUTH6C,0
KLMOUTH7
	.long	KLMOUTH7A,0
KLMOUTH8
	.long	KLMOUTH8A,0

;***************************

a_reached_tusk
	.long	ani_adjustxy
	.word	>01,>0a
	.long	TRMOUTH3
	.long	TRMOUTH4
	.long	TRMOUTH5
	.long	TRMOUTH6
	.long	TRMOUTH7
	.long	TRMOUTH8
	.long	0

TRMOUTH3
	.long	TRMOUTH3A,TRSKELEG1A,TRSKELEG1B,0
TRMOUTH4
	.long	TRMOUTH4A,TRSKELEG1A,TRSKELEG1B,0
TRMOUTH5
	.long	TRMOUTH5A,TRSKELEG1A,TRSKELEG1B,0
TRMOUTH6
	.long	TRMOUTH6A,TRMOUTH6B,0
TRMOUTH7
	.long	TRMOUTH7A,0
TRMOUTH8
	.long	TRMOUTH8A,0


;***************************

a_reached_sg
	.long	ani_adjustxy
	.word	>1b,>0a
	.long	SGMOUTH3
	.long	SGMOUTH4
	.long	SGMOUTH5
	.long	SGMOUTH6
	.long	SGMOUTH7
	.long	SGMOUTH8
	.long	0

SGMOUTH3
	.long	SGMOUTH3A,SGSKELEG1A,SGSKELEG1B,SGSKELEG1C,0
SGMOUTH4
	.long	SGMOUTH4A,SGSKELEG1A,SGSKELEG1B,SGSKELEG1C,0
SGMOUTH5
	.long	SGMOUTH5A,SGSKELEG1A,SGSKELEG1B,SGSKELEG1C,0
SGMOUTH6
	.long	SGMOUTH6A,SGMOUTH6B,SGMOUTH6C,0
SGMOUTH7
	.long	SGMOUTH7A,0
SGMOUTH8
	.long	SGMOUTH8A,0




SGOROBONE1
	.long	SGOROBONE1A,0
SGOROBONE2
	.long	SGOROBONE2A,SGOROBONE2B,0
SGOROBONE3
	.long	SGOROBONE3A,SGOROBONE3B,SGOROBONE3C,0
SGOROBONE4
	.long	SGOROBONE4A,SGOROBONE4B,0

;***************************

a_reached_st
	.long	ani_adjustxy
	.word	->0c,7
	.long	TSMOUTH3
	.long	TSMOUTH4
	.long	TSMOUTH5
	.long	TSMOUTH6
	.long	TSMOUTH7
	.long	TSMOUTH8
	.long	0

TSMOUTH3
	.long	TSMOUTH3A,TSSKELEG1A,TSSKELEG1B,0
TSMOUTH4
	.long	TSMOUTH4A,TSSKELEG1A,TSSKELEG1B,0
TSMOUTH5
	.long	TSMOUTH5A,TSSKELEG1A,TSSKELEG1B,0
TSMOUTH6
	.long	TSMOUTH6A,TSMOUTH6B,0
TSMOUTH7
	.long	TSMOUTH7A,0
TSMOUTH8
	.long	TSMOUTH8A,0

;***************************

a_reached_lk
	.long	ani_adjustxy
	.word	0,0
	.long	LUMOUTH3
	.long	LUMOUTH4
	.long	LUMOUTH5
	.long	LUMOUTH6
	.long	LUMOUTH7
	.long	LUMOUTH8
	.long	0

LUMOUTH3
	.long	LUMOUTH3A,LUSKELEG1A,LUSKELEG1B,LUSKELEG1C,0
LUMOUTH4
	.long	LUMOUTH4A,LUSKELEG1A,LUSKELEG1B,LUSKELEG1C,0
LUMOUTH5
	.long	LUMOUTH5A,LUSKELEG1A,LUSKELEG1B,LUSKELEG1C,0
LUMOUTH6
	.long	LUMOUTH6A,LUMOUTH6B,LUMOUTH6C,0
LUMOUTH7
	.long	LUMOUTH7A,0
LUMOUTH8
	.long	LUMOUTH8A,0


;**************************************************************************

kano_lazer
	jsrp	fatality_start_pause

	movk	5,a0
	calla	ochar_sound		; lazer eye start

	movk	3,a9
	calla	get_char_ani2
	movk	4,a0
	jsrp	mframew

	movk	6,a0
	calla	ochar_sound		; lazer burnin !!

	movi	local_r_laser,a7
	calla	takeover_him
	move	a9,a11			; save this spot
*
* burn it in !!!
*
	movk	4,a10
laz3	pushp	a10
	move	a11,a9
	movk	6,a0
	jsrp	mframew
	pullp	a10
	dsj	a10,laz3

	push	a8
	move	*a13(p_otherguy),a8,l
	calla	set_inviso
	movi	>15,a0
	calla	create_fx		; explode
	pull	a8

	callr	wfe_him
	movk	4,a0
	jsrp	mframew
	calla	delete_slave
	movi	pid_fx,a0
	calla	dallprc
	callr	death_blow_complete
	jruc	local_victory_animation


test_fade_tab
	.word	1,2,4,6,8,10,12,14,16,18,20,-1

local_r_laser
	movk	9,a0
	calla	group_sound		; death scream
	calla	set_noedge

	move	*a8(opal),a0,w
	movk	1,a10
	movk	6,a5
	movi	test_fade_tab,a11
	calla	fade_this_pal

	movi	>40,a9
	calla	get_char_ani

	calla	match_me_with_him
	calla	flip_multi

	movi	ochar_laser_lineups,a0
	calla	get_char_long
	move	a0,a1
	sra	16,a1
	sext	a0,w
	calla	multi_adjust_xy

	movk	4,a0
	jsrp	mframew

	calla	center_around_me

	movi	>00030000,a0
	movk	3,a1
	movi	5,a2
	jsrp	shake_a8_up

	movi	>14,a0
	calla	create_fx
	movk	2,a1
	move	a1,*a0(pa10),l		; stuff # of puffs

	movi	>00050000,a0
	movk	3,a1
	movi	10,a2
	jsrp	shake_a8_up

	movi	>14,a0
	calla	create_fx
	movk	3,a1
	move	a1,*a0(pa10),l		; stuff # of puffs

lazagain
	movi	>00050000,a0
	movk	3,a1
	movi	40,a2
	jsrp	shake_a8_up
	jruc	lazagain


ochar_laser_lineups
	.word	->b8,>00	;
	.word	->b8,>00	;
	.word	->a8,->10	;
	.word	->ac,>00	;
	.word	->b8,>00	; 4

	.word	->b8,>00	;
	.word	->d0,->13	;
	.word	->b8,>00	;
	.word	->b8,>00	;
	.word	->ad,>00	; 9

	.word	->b8,>00	;
	.word	->9a,->09	;
	.word	->c8,>05	;
	.word	->ac,>00	;
	.word	->b8,>00	; 14
	
local_die
	die

;**************************************************************************

fat_robo_crush
	jsrp	fatality_start_pause

	jsrp	robo_open_chest
	movi	>16,a0
	callr	local_ochar_sound

	movi	center_around_me,a0
	calla	calla_for_him

	move	a8,*a13(p_store4),l	; save me
	movk	8,a9
	calla	get_char_ani2
	calla	do_next_a9_frame	; create slave object (arms)
	sleep	6

	move	a8,a10			; save me here
	move	*a13(p_slave),a8,l
	calla	a8_back_minus_1
	movk	6,a0
	movk	10,a0
	movk	5,a0
	jsrp	mframew			; ani: arms coming out
*
* create "clipable" arm object
*
	callr	create_arm_obj
	move	a10,*a13(p_store1),l	; and store here 4 l8r !!

	movk	5,a0
	jsrp	mframew			; ani: arms coming out

	callr	create_arm_obj
	move	a10,*a13(p_store2),l
	callr	a10_frame_a9
	callr	create_arm_obj
	move	a10,*a13(p_store3),l
	callr	a10_frame_a9
	movi	wait_forever,a7
	calla	xfer_otherguy		; disable him
	move	a9,*a13(p_store5),l	; save
	sleep	>10

	movi	>17,a0
	callr	local_ochar_sound
*
* crush down !!
*
	clr 	a9
	movi	-9,a1
	jsrp	crush_him_more
	movi	-9,a1
	movi	>00000004,a9		; frame 0 : ani offset = 4
	jsrp	crush_him_more
	movi	-9,a1
	movi	>00010004,a9		; frame 1 : ani offset = 4
	jsrp	crush_him_more
	movi	-15,a1
	movi	>00020004,a9		; frame 1 : ani offset = 4
	jsrp	crush_him_more

	movi	clear_shadow_bit,a0
	calla	calla_for_him
	movi	set_inviso,a0
	calla	calla_for_him		; hide him !!

	movi	>18,a0
	callr	local_ochar_sound

	movk	9,a9
	calla	get_char_ani2
	move	a9,*a13(p_store7),l	; save blood ani
	calla	gmo_proc
	calla	a8_front_plus_1
	move	a8,a0
	move	*a13(p_store4),a8,l	; me
	calla	match_ani_points	; lineup blood with me
	calla	insobj
	move	a0,*a13(p_store6),l

	move	a0,a8			; pass blood object
	movk	>0c,a0
	calla	create_fx		; bones and limbs and stuff
*
* reshape top and bottom pieces
*
	move	*a13(p_store5),a9,l	; save
	move	*a13(p_store3),a8,l
	calla	frame_a9
	move	*a13(p_store2),a8,l
	calla	frame_a9
*
* animate blood
*
	movi	>28,a0
	movi	->24,a1
	callr	adjust_top_and_bottom
	callr	crush_sleep_5
	move	*a13(p_store6),a8,l	; a8 = blood
	move	*a13(p_store7),a9,l	; get blood ani
	addi	32,a9

	sleep	6

	movk	4,a0
	movi	-8,a1
	callr	adjust_top_and_bottom
	calla	do_next_a9_frame
	callr	crush_sleep_5

	movk	3,a0
	movi	-3,a1
	callr	adjust_top_and_bottom
	movk	5,a0
	jsrp	mframew
*
* retract arm
*
	move	*a13(p_store1),a0,l
	calla	delobjp
	move	*a13(p_store2),a0,l
	calla	delobjp
	move	*a13(p_store3),a0,l
	calla	delobjp				; rid of unwanted pieces !!!

	move	*a13(p_store4),a8,l		; me
	move	*a13(p_slave),a10,l		; arm obj (slave)
	movk	8,a9
	calla	find_ani2_part2
	calla	find_part2
	calla	find_part2

	movk	6,a0
	jsrp	mframew
	calla	delete_slave

	jsrp	robo_close_chest
	callr	death_blow_complete
	jruc	local_victory_animation


adjust_top_and_bottom
	move	*a13(p_store2),a6,l
	callr	adjust_piece
	move	*a13(p_store3),a6,l	; bottom piece
	move	a0,a1
	jruc	adjust_piece

*
* a1 = amount to adjust top/bottom pieces
* a9 = frame #:ani offset for him
*
crush_him_more
	move	*a13(p_store3),a6,l	; bottom piece
	callr	adjust_piece
	clr	a0			; dont adjust his x
	calla	adjust_him_xy
	neg	a1
	move	*a13(p_store2),a6,l	; top piece
	callr	adjust_piece
	move	a9,a9
	jreq	chm9

	movi	player_normpal,a0
	calla	calla_for_him		; him: normal palette
	movi	pose_a9,a0
	calla	calla_for_him		; him: pose

chm9	callr	crush_sleep_5
	retp


crush_sleep_5
	move	*a13(p_store1),a0,l	; clippable guy...
	move	*a13(p_store2),a5,l	; top piece
	move	*a5(oypos),a5,w
	move	a5,*a0(oypos),w

	move	*a13(p_store3),a6,l	; bottom piece
	move	*a6(oypos),a3,w
	move	*a6(osizey),a6,w
	add	a3,a6
	sub	a5,a6			; a6 = distance

	cmpi	3,a6
	jrgt	crslp4
	movk	3,a6			; minimum size
crslp4	move	a6,*a0(osizey),w	; clip proper amount
	pull	a11
	sleep	4
	jump	a11


adjust_piece
	move	*a6(oypos),a7,w
	add	a1,a7
	move	a7,*a6(oypos),w
	rets

create_arm_obj
	push	a8
	move	a8,a10
	movi	RBCRUSH4BAR,a5
	calla	gso_dmawnz
	move	a8,a0
	move	a10,a1
	calla	lineup_1pwm
	calla	a8_front_plus_1
	calla	insobja8
	move	a8,a10
	pull	a8
	rets

a10_frame_a9
	push	a8
	move	a10,a8
	calla	a8_back_minus_1
	calla	frame_a9
	pull	a8
	rets

;*************************************************************

*
* a11 = # of times to loop
*
shocker_shaker
	movi	a_kano_shocked,a9
	move	*a8(ochar),a0,w
	sll	5,a0
	add	a0,a9
	add	a0,a9
	add	a0,a9
	add	a0,a9
	add	a0,a9
	movi	BUZZER,a0
	calla	player_swpal
	move	a9,a10

shsh3	move	a10,a9

	push	a10
	movk	3,a10
	movi	>14,a0
	calla	create_fx		; smoke em
	pull	a10

	movi	pid_smoker,a0
	calla	dallprc

	movk	4,a0
	jsrp	mframew
	dsj	a11,shsh3
	retp


a_kano_shocked
a_KNBZZ	.long	KNBZZ1
	.long	KNBZZ2
	.long	KNBZZ3
	.long	KNBZZ4
	.long	0

a_SBBZZ	.long	SBBZZ1
	.long	SBBZZ2
	.long	SBBZZ3
	.long	SBBZZ4
	.long	0

a_JXBZZ	.long	JXBZZ1
	.long	JXBZZ2
	.long	JXBZZ3
	.long	JXBZZ4
	.long	0

a_INBZZ	.long	INBZZ1
	.long	INBZZ2
	.long	INBZZ3
	.long	INBZZ4
	.long	0

a_SZBZZ	.long	SZBZZ1
	.long	SZBZZ2
	.long	SZBZZ3
	.long	SZBZZ4
	.long	0

a_OBBZZ	.long	OBBZZ1
	.long	OBBZZ2
	.long	OBBZZ3
	.long	OBBZZ4
	.long	0

a_LIBZZ	.long	LIBZZ1
	.long	LIBZZ2
	.long	LIBZZ3
	.long	LIBZZ4
	.long	0

a_RBBZZ2	.long	RBBZZ1
	.long	RBBZZ2
	.long	RBBZZ3
	.long	RBBZZ4
	.long	0

a_RBBZZ	.long	RBBZZ1
	.long	RBBZZ2
	.long	RBBZZ3
	.long	RBBZZ4
	.long	0

a_KLBZZ	.long	KLBZZ1
	.long	KLBZZ2
	.long	KLBZZ3
	.long	KLBZZ4
	.long	0

a_TRBZZ	.long	TRBZZ1
	.long	TRBZZ2
	.long	TRBZZ3
	.long	TRBZZ4
	.long	0

a_SGBZZ	.long	SGBZZ1
	.long	SGBZZ2
	.long	SGBZZ3
	.long	SGBZZ4
	.long	0

a_TSBZZ	.long	TSBZZ1
	.long	TSBZZ2
	.long	TSBZZ3
	.long	TSBZZ4
	.long	0

a_LUBZZ	.long	LUBZZ1
	.long	LUBZZ2
	.long	LUBZZ3
	.long	LUBZZ4
	.long	0

	.long	RBBZZ1
	.long	RBBZZ2
	.long	RBBZZ3
	.long	RBBZZ4
	.long	0


TSBZZ1	.long	TSBUZZ1,0
TSBZZ2	.long	TSBUZZ2,0
TSBZZ3	.long	TSBUZZ3,0
TSBZZ4	.long	TSBUZZ4,0
INBZZ1	.long	INBUZZ1,0
INBZZ2	.long	INBUZZ2,0
INBZZ3	.long	INBUZZ3,0
INBZZ4	.long	INBUZZ4,0
SZBZZ1	.long	SZBUZZ1,0
SZBZZ2	.long	SZBUZZ2,0
SZBZZ3	.long	SZBUZZ3,0
SZBZZ4	.long	SZBUZZ4,0
TRBZZ1	.long	TRBUZZ1,0
TRBZZ2	.long	TRBUZZ2,0
TRBZZ3	.long	TRBUZZ3,0
TRBZZ4	.long	TRBUZZ4,0
LIBZZ1	.long	LIBUZZ1,0
LIBZZ2	.long	LIBUZZ2,0
LIBZZ3	.long	LIBUZZ3,0
LIBZZ4	.long	LIBUZZ4,0
OBBZZ1	.long	OBBUZZ1,0
OBBZZ2	.long	OBBUZZ2,0
OBBZZ3	.long	OBBUZZ3,0
OBBZZ4	.long	OBBUZZ4,0
RBBZZ1	.long	RBBUZZ1,0
RBBZZ2	.long	RBBUZZ2,0
RBBZZ3	.long	RBBUZZ3,0
RBBZZ4	.long	RBBUZZ4,0
JXBZZ1	.long	JXBUZZ1,0
JXBZZ2	.long	JXBUZZ2,0
JXBZZ3	.long	JXBUZZ3,0
JXBZZ4	.long	JXBUZZ4,0
KLBZZ1	.long	KLBUZZ1,0
KLBZZ2	.long	KLBUZZ2,0
KLBZZ3	.long	KLBUZZ3,0
KLBZZ4	.long	KLBUZZ4,0
SBBZZ1	.long	SBBUZZ1,0
SBBZZ2	.long	SBBUZZ2,0
SBBZZ3	.long	SBBUZZ3,0
SBBZZ4	.long	SBBUZZ4,0
SGBZZ1	.long	SGBUZZ1,0
SGBZZ2	.long	SGBUZZ2,0
SGBZZ3	.long	SGBUZZ3,0
SGBZZ4	.long	SGBUZZ4,0
KNBZZ1	.long	KNBUZZ1,0
KNBZZ2	.long	KNBUZZ2,0
KNBZZ3	.long	KNBUZZ3,0
KNBZZ4	.long	KNBUZZ4,0
LUBZZ1	.long	LUBUZZ1,0
LUBZZ2	.long	LUBUZZ2,0
LUBZZ3	.long	LUBUZZ3,0
LUBZZ4	.long	LUBUZZ4,0

;*************************************************************

fatal_offset
	mmtm	sp,a0,a1
	calla	match_me_with_him
	calla	flip_multi
	mmfm	sp,a0,a1
	jauc	multi_adjust_xy


sans_repell_for_good
	movi	>500,a0
	move	a0,@f_norepell,w
	rets

;*************************************************************


fatality_start_pause
	movi	fat_fatality,a1
	callr	init_death_blow

	clr	a9
	calla	pose_a9			; hold stance pose
	sleep	20
	retp


init_death_blow

;	cmpi	bb_fatality,a1
;	jreq	initdb3
;	cmpi	fs_fatality,a1
;	jreq	initdb3

	move	@f_no_violence,a4,w
	jrne	init_abort

initdb3	move	a1,@f_death,w	  	; flag: death blow !!!
	move	a1,@f_final_act,w	; remember the final act
	calla	init_special		; i can't block !!
	create	pid_fx,make_db_tone

	move	@f_death,a0,w
	cmpi	fat_pit,a0
	jreq	initdb5			; pit fatality = no fade

	create	pid_fade,death_blow_fader

initdb5	rets

init_abort
	pull	a4			; no return
	jauc	wait_forever


death_blow_fader
	movi	pid_cycle,a0
	calla	dallprc			; kill any color cycle procs

	movk	1,a0
	move	a0,@f_fade,w		; flag: we r faded !!
	push	a9
	movi	>800,a9
	create	pid_fade,skydown
	pull	a9
	movi	death_fade_excludes,a0
	calla	fadeout
	sleep	7

	movi	pid_fade,a0
	calla	dallprc
	clr	a0
	move	a0,@f_shadows,w
	jruc	l_die

make_db_tone
	sleep	2
	movi	>36,a3
	calla	send_code_a3
l_die	die

;*************************************************************

death_blow_complete
	move	@f_death,a1,w
	movi	-1,a0
	move	a0,@f_death,w

	cmpi	fat_friend,a1
	jreq	dbc9			; friend = no ending chord

	movi	>3b,a3			; end of animality
	cmpi	fat_animality,a1
	jreq	dbc4

	movi	>37,a3			; end of fatality
dbc4	calla	send_code_a3		; death blow over tune !!

dbc9	rets

;*************************************************************

make_him_face_me
	movi	face_opponent,a0
	jauc	calla_for_him

wfe_him	movi	wait_forever,a7
	jauc	takeover_him

local_victory_animation
	jauc	victory_animation

local_wait_forever
	jauc	wait_forever

local_ochar_sound
	jauc	ochar_sound

local_get_char_ani2
	jauc	get_char_ani2

;**************************************************************************

do_pit_fatality
	calla	init_special
	create	pid_fx,make_db_tone
	movk	fat_pit,a1
	move	a1,@f_death,w	  	; flag: death blow !!!

	move	*a13(p_otherproc),a0,l
	movi	>edb00,a1
	move	a1,*a0(pa10),l		; flag: down u go !!
	jsrp	do_duck
	sleep	8
	jsrp	do_uppercut
	
	movi	>0b,a9
	calla	find_ani_part2
	movk	5,a0
	jsrp	mframew
	jruc	local_victory_animation

;**************************************************************************


ochar_mini_stunned
	.long	KNTINYSTUN1A
	.long	SBTINYSTUN1A
	.long	JXTINYSTUN1A
	.long	INTINYSTUN1A
	.long	SZTINYSTUN1A
	.long	OBTINYSTUN1A
	.long	LITINYSTUN1A
	.long	RBTINYSTUN1A
	.long	RBTINYSTUN1A
	.long	KLTINYSTUN1A
	.long	TRTINYSTUN1A
	.long	SHTINYSTUN1A
	.long	TSTINYSTUN1A
	.long	LKTINYSTUN1A
	.long	RBTINYSTUN1A
 
ochar_mini_falls
	.long	KNTINYFALL1A
	.long	SBTINYFALL1A
	.long	JXTINYFALL1A
	.long	INTINYFALL1A
	.long	SZTINYFALL1A
	.long	OBTINYFALL1A
	.long	LITINYFALL1A
	.long	RBTINYFALL1A
	.long	RBTINYFALL1A
	.long	KLTINYFALL1A
	.long	TRTINYFALL1A
	.long	SHTINYFALL1A
	.long	TSTINYFALL1A
	.long	LKTINYFALL1A
	.long	RBTINYFALL1A

;**********************************************************************

ochar_scared_pals
	.long	KNSCAR_P
	.long	SBSCAR_P
	.long	JXSCAR_P
	.long	INSCAR_P
	.long	SZSCAR_P
	.long	OBSCAR_P
	.long	LIASCAR_P
	.long	SMSCAR_P
	.long	CYSCAR_P
	.long	KLSCAR_P
	.long	TRSCAR1_P
	.long	SHSCAR_P
	.long	TSSCAR_P
	.long	TSSCAR_P
	.long	SMSCAR_P

KNSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,04e74h
   .word   07fffh,07fffh,077bdh,0739ch,06739h,06318h,05ef7h,056b5h
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07ffbh,07fffh,07ff5h,07fffh,07fffh,07ffch,07fffh,07fffh
   .word   07ffbh,07ffeh,07fd8h,07ffdh,07f94h,07f13h,07ffbh,07fdch
   .word   07f74h,07fb8h,07f79h,07f38h,07ef4h,07b17h,07a93h,072f6h
   .word   06e73h,06ad5h,066b5h,07f9fh,07fffh,07ebbh,07ebah,07f1dh
   .word   07eb9h,07eb8h,07eb7h,07e97h,07e96h,07295h,06679h,07e73h

SBSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07ff7h,07fffh,07fffh,07fffh
   .word   07fffh,07ff7h,07fffh,07f16h,07fffh,07ffeh,07ffeh,07fd4h
   .word   07f76h,07f12h,07fbah,07ffeh,07f9ah,07f77h,07ed2h,07f34h
   .word   07f7ah,07ef5h,07ad4h,07652h,06ab5h,06a93h,06272h,07fffh
   .word   07f75h,07f76h,07f75h,07f75h,07f7fh,07f75h,07f7eh,07f75h
   .word   07f75h,07f7dh,07f75h,07f58h,07b35h,076f5h,072d5h,06eb5h
   .word   06695h,05a35h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07bdeh,06f7bh,06739h,06318h,05ef7h,05ad6h,056b5h,04a72h

JXSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07bdeh,077bdh,0739ch,06f7bh,06b5ah,06739h
   .word   06318h,05ef7h,05ad6h,056b5h,05294h,04e73h,07e5fh,07e7fh
   .word   07e7fh,07e5fh,07e5fh,07a5eh,0725ch,06a5ah,06258h,05a56h
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07ffdh,07fb3h,07ffch
   .word   07fb9h,07fbah,07f77h,07fbbh,07f78h,07fbch,07f57h,07f35h
   .word   07f58h,07f16h,07b17h,07ad4h,07717h,076d4h,07338h,072f5h
   .word   06ed5h,06e92h,06ab4h,06294h,06252h,05a73h,05a52h,05252h

INSCAR_P:
   .word   64 
   .word   00000h,04e96h,04ed9h,04f1bh,04f3bh,04f3fh,04f5fh,04f7fh
   .word   04f9fh,04fbfh,04fdfh,04fffh,04fffh,04fffh,04fffh,04fffh
   .word   057ffh,05bffh,05fffh,062d5h,066b4h,066f5h,06ed4h,06f16h
   .word   072f4h,076f4h,07b15h,07b36h,07ef5h,07b17h,07f37h,07f79h
   .word   07f79h,07f9ah,07f98h,07f55h,07fbah,07fb8h,07fdbh,07ffdh
   .word   07ffdh,07ffeh,07ffeh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07e73h,07e73h,07e94h,04e74h
   .word   05ef7h,06739h,0739ch,07fffh,07fffh,07fffh,07fffh,07fffh

SZSCAR_P:
   .word   64 
   .word   00000h,06293h,06673h,066b3h,06e93h,06ed4h,072b3h,076b3h
   .word   07ad3h,07af4h,07b16h,07f38h,07f58h,07f9ah,07f9ah,07fbbh
   .word   07fb9h,07f76h,07ffch,07ffah,07ffdh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,056d7h,05af9h,05b1bh,05f3dh,05f3fh,05f3fh
   .word   05f3fh,0635fh,0677fh,0677fh,0679fh,067dfh,067ffh,067ffh
   .word   067ffh,067ffh,067ffh,04e74h,05ef7h,06739h,06f7bh,077bdh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07f36h

OBSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07ffeh,07ffah,07ffbh,07fffh,07fdah,07ffbh,07f97h,07fd8h
   .word   07fbah,07ffch,07fd9h,07f77h,07f77h,07f56h,07b35h,07315h
   .word   072f3h,062f5h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07bdeh,077bdh,0739ch,06f7bh
   .word   06b5ah,06739h,06318h,05ef7h,05ad6h,056b5h,05294h,04e73h
   .word   04a52h,07fffh,07bffh,073ffh,067dfh,05b9fh,0533fh,05b3fh
   .word   0571fh,0571fh,0571dh,052fbh,052d9h,04e97h,04a53h,04a52h

LIASCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07ffeh,07ffdh,07fffh,07ffeh,07ffah,07ffdh
   .word   07ffbh,07ffah,07ffdh,07ffbh,07fdah,07fb9h,07f99h,07f77h
   .word   07778h,07738h,072f6h,06b16h,062b4h,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07bdeh,077bdh
   .word   0739ch,06f7bh,06b5ah,06739h,06318h,05ef7h,05ad6h,056b5h
   .word   04e73h,07fffh,07fffh,07fffh,07fdfh,07fbfh,07f5fh,07f1fh
   .word   07effh,07edfh,07abfh,0729fh,06e7eh,06e7dh,0627ch,04e73h

CYSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07ffeh,07ffbh,07ffch
   .word   07ff9h,07fefh,07fefh,07fefh,07fefh,07fefh,07fefh,07fefh
   .word   07ff0h,07fd0h,07fd0h,07fb0h,07f90h,07f90h,07f70h,07b10h
   .word   076f0h,072d0h,06eb0h,05a6fh,0562fh,04e0fh,049efh,045cfh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fdfh,07bbfh,0779fh,0737eh,06f5dh,0671bh,062fah
   .word   05ed9h,05ab8h,05697h,05276h,04e55h,04a34h,04613h,04613h

KLSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,0739ch
   .word   06739h,05ef7h,05ad6h,05294h,04a53h,07fffh,07ffeh,07ffdh
   .word   07ffch,07ffbh,07ffah,07ff9h,07fd8h,07fb7h,07f96h,07b75h
   .word   07754h,06f14h,066f3h,05ed2h,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07ffbh
   .word   07ff9h,07fffh,07fffh,07fffh,07fffh,07ff3h,07fffh,07ffeh
   .word   07ffch,07fd9h,07fb7h,07fdbh,07fbah,07f78h,07f35h,07af4h
   .word   07316h,072b3h,06ef3h,06ab4h,07e52h,07e52h,07e52h,07e52h

TRSCAR1_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fdfh,0779dh,06f5bh,06b3ah,06719h,062f8h,05ed7h,05ab6h
   .word   05695h,07fffh,07fffh,07ffdh,07ffbh,07fd8h,07fb6h,07f73h
   .word   07f33h,07b13h,076f3h,072d3h,06eb3h,06a93h,06673h,06273h
   .word   07fffh,07fffh,07fffh,07fffh,07ffeh,07ffbh,07ffbh,07fd8h
   .word   07fb6h,07f97h,07f55h,07f37h,07315h,06ed4h,066b4h,07e53h
   .word   06e53h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07ffch
   .word   07ffch,07fdbh,07bb9h,07798h,07377h,06f56h,06715h,05ed5h

SHSCAR_P:
   .word   64 
   .word   00000h,07fdfh,07fdfh,07fdfh,07fdfh,07fdfh,07fdfh,07fdfh
   .word   07fdfh,07fdfh,07fdfh,07fdfh,07fdfh,07fdfh,07fdfh,07fdfh
   .word   07fbeh,07f9dh,07f7ch,07f5ah,07b3ah,0771ah,072f9h,06ed9h
   .word   066d9h,062b8h,05e98h,05a78h,062b9h,05e99h,05a98h,05678h
   .word   04e92h,04a93h,05272h,05a72h,05e72h,06672h,06e72h,07672h
   .word   07e72h,07e72h,07e96h,07ed7h,07f19h,07f5ah,07f9bh,07fdch
   .word   07ffeh,04eb4h,056f6h,05f38h,0677ah,06fbch,077feh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,04672h

TSSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fdfh,07fbfh,07f9fh,07f7fh,07f5fh
   .word   07f3fh,07effh,07effh,07b1fh,0771fh,07affh,076dfh,072dfh
   .word   072bfh,06e9fh,0669fh,0627fh,07fffh,07fffh,07fffh,07fffh
   .word   07fdfh,07b7fh,06f1fh,066dfh,05e9fh,05a7fh,0523fh,049ffh
   .word   06b97h,06b97h,06b17h,06ad7h,066b7h,06297h,05e77h,05a57h
   .word   05637h,05217h,04dd7h,049b7h,04577h,04177h,03d77h,03177h

SMSCAR_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fdfh,07bbfh,0779fh,0737fh,06f5fh,06b3fh,0671fh,05edfh
   .word   05abfh,0569eh,0527dh,04e5ch,04a3bh,0463ah,04639h,04638h
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,07fffh,07bdeh,077bdh,0739ch,06f7bh,06739h
   .word   06318h,05ef7h,05ad6h,056b5h,05294h,04e73h,04a52h,04631h

;************************************

	.end



