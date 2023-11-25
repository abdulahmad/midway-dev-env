**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: animalities										*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	'mkanimal.asm'
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
	.include	mkanimal.tbl
	.text


do_animality
	jsrp	animality_start_pause
	calla	init_special
	movi	ochar_animalities,a0
	jauc	ochar_jump

animality_start_pause
	movi	fat_animality,a1
	calla	init_death_blow
	sleep	30
	retp

ochar_animalities
	.long	kano_spider		; 0
	.long	sonya_eagle		; 1
	.long	jax_lion		; 2
	.long	indian_wolf		; 3
	.long	sz_polar		; 4
	.long	swat_dino		; 5
	.long	sindel_wasp		; 6
	.long	sektor_bat		; 7
	.long	cyrax_shark		; 8
	.long	lao_cheetah		; 9
	.long	kabal_skeleton		; 10
	.long	sheeva_scorpion		; 11
	.long	shang_tsung_snake	; 12
	.long	liu_kang_dragon		; 13
	.long	smoke_bull_shit		; 14

;*************************************************************

cyrax_shark
	callr	animality_tune
	movi	a_shark,a9
	movk	18,a10
	callr	animal_morph

	callr	l_sans_repell_for_good
	callr	kill_and_stop_scrolling

	movi	>a0000,a0
	calla	towards_x_vel
	sleep	8
	callr	kill_repell
	sleep	>50-8

	tsound	>3a			; ROAR !!!
	calla	stop_me
	calla	match_me_with_him
	calla	ground_player
	calla	a8_back_minus_1
	movk	4,a0
	jsrp	mframew

	movi	eaten_by_shark,a7
	calla	takeover_him
	movi	>000a000a,a11
	calla	shake_a11

	sleep	4
	movk	3,a0
	jsrp	mframew
	calla	set_inviso
	sleep	>30
	calla	clear_inviso

	movi	a_shark,a9
	jruc	unmorph_and_exit

eaten_by_shark
	calla	death_scream
	movi	>20,a0
	calla	create_fx    		; blood explode
	sleep	2
	movi	>20,a0
	calla	create_fx    		; blood explode
	sleep	2
	movi	>20,a0
	calla	create_fx    		; blood explode

eaten_by_snake
	tsound	>24
	tsound	>25			; crunchy
	movi	>000a000a,a11
	calla	shake_a11

	calla	set_inviso
	jauc	wait_forever

;*************************************************************

lao_cheetah
	callr	animality_tune
	movi	a_cheetah,a9
	movk	18,a10
	callr	animal_morph

	callr	l_sans_repell_for_good
	sleep	>18

	tsound	>3c    			; wolf growl sound
	movi	>30000,a0
	calla	towards_x_vel
	movk	7,a0
	jsrp	mframew			; attack

	movi	lion_mauled,a7
	calla	takeover_him
	movi	>20000,a0
	calla	away_x_vel_him		; start him movin
	movk	6,a0
	jsrp	mframew

	callr	l_stop_me
	sleep	8
	calla	stop_him

	movi	>00050010,a0
	jsrp	animate_a0_frames	; finish attack

	movi	a_cheetah,a9
	movk	5,a14
	calla	find_part_a14
	calla	do_next_a9_frame
	calla	wfe_him
	sleep	>28

	movi	a_cheetah,a9
	jruc	unmorph_and_exit

;*************************************************************

liu_kang_dragon
	callr	animality_tune
	movi	a_dragon,a9
	movk	18,a10
	callr	animal_morph
	sleep	>30

	movk	4,a0
	jsrp	mframew
	movi	bit_in_half,a7
	calla	takeover_him
	movi	>000a000a,a11
	calla	shake_a11
	sleep	>40

	movk	4,a0
	jsrp	mframew			; stand back up

	sleep	>30
	movi	a_dragon,a9
	jruc	unmorph_and_exit


;*************************************************************

shang_tsung_snake
	callr	animality_tune
	movi	a_snake,a9
	movk	18,a10
	callr	animal_morph
	calla	a8_front_plus_1

	movk	5,a0
	jsrp	mframew
	movi	eaten_by_snake,a7
	calla	takeover_him
	movi	>000a000a,a11
	calla	shake_a11

	sleep	>20

	movk	5,a0
	jsrp	mframew

	sleep	>40
	movi	a_snake,a9
	jruc	unmorph_and_exit

;*************************************************************

sheeva_scorpion
	callr	animality_tune
	movi	a_scorpion,a9
	movk	18,a10
	callr	animal_morph

	movk	5,a0
	jsrp	mframew
	movi	stung_by_scorpion,a7
	calla	takeover_him

	sleep	>40*2
	movi	a_scorpion,a9
	jruc	animality_complete


stung_by_scorpion
	calla	face_opponent
	movi	>40000,a0
	calla	away_x_vel
	calla	rsnd_stab
	movk	2,a0
	calla	group_sound		; ow !!
	movi	>00050020,a9
	jsrp	animate_a9		; stumble
*
* now the poison sets in !!
*
	calla	stop_me
	calla	death_scream
	movi	>40,a9
	calla	pose_a9			; scared pose

	move	*a8(opal),a0,w
	movk	3,a10
	movk	6,a5
	movi	scorp_fade_tab,a11
	calla	fade_this_pal

	movk	3,a0
	movk	3,a1
	movk	20,a2
	jsrp	shake_a8_up

	calla	set_inviso
	movi	>15,a0
	calla	create_fx		; explode
	jauc	wait_forever
	
scorp_fade_tab
	.word	1,2,4,6,8,10,12,14,16,18,20,-1

;*************************************************************

kabal_skeleton
	callr	animality_tune
	movi	a_skeleton,a9
	movk	18,a10
	callr	animal_morph

	movi	>80000,a0
	calla	towards_x_vel
	movk	4,a0
	jsrp	mframew

	movi	dino_bucked,a7
	calla	takeover_him
	calla	stop_me
	sleep	>10

	movk	5,a0
	jsrp	mframew
	sleep	>10
	movi	a_skeleton,a9
	jruc	unmorph_and_exit


dino_bucked
	movk	1,a0
	calla	create_blood_proc
	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	calla	death_scream
	calla	rsnd_stab

	movi	>30000,a0		; initial x vel
	movi	->150000,a1		; initial y vel
	movi	>5000,a2		; grav
	movk	4,a3			; ani speed
	movi	>1e,a9			; ani offset
	jsrp	flight
	jauc	land_on_my_back

;*************************************************************

sektor_bat
	callr	animality_tune

	callr	center_around_him

	movi	a_bat,a9
	movk	18,a10
	callr	animal_morph
	callr	l_sans_repell_for_good
	calla	set_noedge

	movk	3,a0
	calla	init_anirate

	movi	>20,a0
	calla	ochar_sound

	movi	->2000,a0
	move	a0,*a8(ograv),l
	movi	>80000,a0
	calla	towards_x_vel
	movi	q_bat_1,a11
	jsrp	animate_till_a11_stop

	calla	stop_me
	calla	match_me_with_him
	calla	flip_multi
	movi	-scrrgt,a0
	movi	->40,a1
	calla	multi_adjust_xy

	movi	>20,a0
	calla	ochar_sound

	movi	>a0000,a0
	calla	towards_x_vel
	movi	q_bat_2,a11
	jsrp	animate_till_a11

	movi	r_bat_bite,a7
	calla	takeover_him
	move	*a8(oxvel),*a0(p_store1),l
	movi	q_bat_3,a11
	jsrp	animate_till_a11
	sleep	>40
*
* land / unmorph
*
	calla	stop_me
	calla	match_me_with_him
	calla	flip_multi
	movi	->60,a0
	movi	-scrbot,a1
	calla	multi_adjust_xy
	movi	>50000,a0
	move	a0,*a8(oyvel),l
	movi	q_bat_4,a11
	jsrp	animate_till_a11_stop

	calla	ground_player
	movi	a_bat,a9
	jruc	unmorph_and_exit


q_bat_4	calla	distance_off_ground
	cmpi	>03,a0
	jrgt	q_no
	jruc	q_yes

q_bat_3	callr	l_get_x_dist
	cmpi	>100,a3
	jrlo	q_no
	jruc	q_yes

q_bat_2	callr	l_get_x_dist
	cmpi	>20,a3
	jrgt	q_no
	jruc	q_yes

q_bat_1	callr	l_get_x_dist
	cmpi	>100,a3
	jrlo	q_no
	jruc	q_yes

r_bat_bite
	movi	>00060008,a11	
	calla	shake_a11
	calla	rsnd_stab
	calla	death_scream
	movk	1,a0
	calla	create_blood_proc

	move	a8,a10
	calla	set_inviso
	movi	ochar_cutups,a0
	calla	get_char_long

	move	@ofree,a14,l
	move	a14,*a13(p_store2),l
	movk	20,a11

bb3	move	*a0+,a5,l
	jreq	posts5
	push	a0
	calla	gso_dmawnz
	calla	cutup_correct_pal

	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm		; lineup with me
	calla	insobja8
	pull	a0
	move	a11,*a8(ozpos),w
	dec	a11
	jruc	bb3

posts5	move	*a13(p_store2),a8,l
	move	*a13(p_store1),a0,l
	sra	1,a0
	move	a0,*a8(oxvel),l
	movi	->20000,a1
	movi	>6000,a10
	jsrp	gravity_ani_ysize
	calla	rsnd_stab

	movi	->20000,a1
	movi	>6000,a10
	jsrp	gravity_ani_ysize
	calla	rsnd_stab

	jauc	wait_forever

;*************************************************************

animate_till_a11_stop
	jsrp	animate_till_a11
	callr	l_stop_me
	retp

animate_till_a11
	sleep	1
	calla	next_anirate
	call	a11
	jrnc	animate_till_a11
	retp

;**********************************

smoke_bull_shit
	callr	animality_tune

	movi	a_bull,a9
	movk	18,a10
	callr	animal_morph

	callr	l_sans_repell_for_good
	callr	kill_and_stop_scrolling
	movi	>a0000,a0
	calla	towards_x_vel
	sleep	1
	calla	kill_repell

	movk	4,a0
	calla	init_anirate

bull4	sleep	1
	calla	next_anirate
	calla	get_x_dist
	cmpi	>60,a3
	jrhi	bull4

	movi	a_bull,a9
	calla	find_part2
	calla	do_next_a9_frame		; still frame !!
	calla	stop_me
	movi	>000a000a,a11
	calla	shake_a11

	movi	hit_by_bull,a7
	calla	takeover_him

	sleep	>60

	movi	a_bull,a9
	jruc	unmorph_and_exit


hit_by_bull
	movk	1,a0
	calla	create_blood_proc
	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	calla	death_scream
	calla	rsnd_stab

	calla	set_noedge

	movi	>130000,a0		; initial x vel
	calla	away_x_vel
	move	a0,*a8(oxvel),l

	movi	dont_touch,a0		; initial x vel
	movi	->80000,a1		; initial y vel
	movi	>6000,a2		; grav
	movk	4,a3			; ani speed
	movi	>1e,a9			; ani offset
	jsrp	flight
	jauc	land_on_my_back

;*************************************************************

sindel_wasp
	callr	animality_tune
	callr	l_sans_repell_for_good

	movi	a_wasp,a9
	movk	10,a10
	callr	animal_morph

	movi	>00030010,a0
	jsrp	animate_a0_frames		; flap wings
	movi	stung_a_bunch,a7
	calla	takeover_him
	callr	face_him_at_me

	calla	match_me_with_him
	calla	flip_multi
	movi	->28,a0
	movi	->48,a1
	calla	multi_adjust_xy			; above em

	callr	kill_and_stop_scrolling

	calla	no_edge_both_players
	movi	>30000,a0
	calla	away_x_vel_him
	movi	>30000,a0
	calla	towards_x_vel

	movi	a_wasp,a9
	calla	find_part2
	calla	find_part2
	movi	>0004001a,a0
	jsrp	animate_a0_frames		; sting / sting / sting !!

	callr	set_his_inviso
	callr	l_stop_me
	sleep	>40
	calla	death_blow_complete
	movi	pid_repell,a0
	calla	dallprc

	calla	player_normpal
	clr	a9
	calla	pose_a9
	calla	ground_ochar
	move	*a8(oypos),a0,w
	addi	>90,a0
	move	a0,*a8(oypos),w

	move	@worldtlx+16,a0,w
	addi	>60,a0
	move	a0,*a8(oxpos),w

	movi	->20000,a0
	move	a0,*a8(oyvel),l
	jauc	lia_victory


stung_a_bunch
	sleep	8
	calla	death_scream
stung3	movi	>0003001c,a9
	jsrp	animate_a9
	jruc	stung3


a_wasp	.long	WASP1
	.long	WASP3
	.long	WASP4
	.long	WASP5
	.long	WASP6
	.long	0

j_wasp	.long	WASP7
	.long	WASP9
	.long	ani_jump,j_wasp
	.long	0

j_wasp2	.long	WASP9
	.long	WASP10
	.long	WASP11
	.long	ani_calla,rsnd_stab
	.long	WASP10
	.long	ani_jump,j_wasp2

;*************************************************************

swat_dino
	callr	animality_tune

	movk	2,a0
	movi	a_swat_dino,a9
	movk	18,a10
	callr	animal_morph
	callr	l_sans_repell_for_good

	tsound	>3a			; huge roar
	sleep	>30

	movk	5,a0
	jsrp	mframew			; attack
	movi	>00080008,a11
	calla	shake_a11
	movi	bit_in_half,a7
	calla	takeover_him
	tsound	>24
	tsound	>25			; crunchy

	sleep	>30

	movk	5,a0
	jsrp	mframew			; attack

	tsound	>27    			; animality morph sound
	calla	ground_player
	movi	a_swat_dino,a9
	movk	5,a0
	jsrp	backwards_ani		; back 2 sz
	jruc	animality_complete


bit_in_half
	movi	>00060006,a11
	calla	shake_a11		; shake upon contact
	calla	death_scream
	calla	rsnd_stab
	movk	8,a0
	calla	create_blood_proc

	move	*a8(ochar),a0,w
	sll	5,a0
	addi	ochar_half_bodies,a0
	move	a0,a9
	move	*a9,a1,l
	move	*a1,a1,l
	move	*a1(icmap),a0,l
	calla	swpal

;***********
	move	a8,a10
	calla	cutup_correct_pal
;***********

	calla	do_next_a9_frame
	jauc	wait_forever


a_swat_dino
	.long	DINO1
	.long	DINO3
	.long	DINO4
	.long	DINO5
	.long	DINO6
	.long	0

	.long	DINO9
	.long	DINO10
	.long	0

	.long	DINO11
	.long	0

;*************************************************************

sz_polar
	callr	animality_tune

	movk	2,a0
	movi	a_sz_polar,a9
	movk	18,a10
	callr	animal_morph
	callr	l_sans_repell_for_good
	sleep	>30

	tsound	>3c    			; wolf growl sound
	movi	>20000,a0
	calla	towards_x_vel
	movk	5,a0
	jsrp	mframew			; attack

	movi	lion_mauled,a7
	calla	takeover_him
	callr	l_stop_me
	calla	stop_him

	movi	>00050020,a0
	jsrp	animate_a0_frames
	calla	wfe_him
	sleep	8

	tsound	>27    			; animality morph sound
	calla	ground_player
	movi	a_sz_polar,a9
	movk	5,a0
	jsrp	backwards_ani		; back 2 sz

	jruc	animality_complete


a_sz_polar
	.long	POLAR1
	.long	POLAR3
	.long	POLAR4
	.long	POLAR5
	.long	POLAR6
	.long	0
	.long	POLAR8
	.long	POLAR10
	.long	POLAR11
	.long	0

	.long	POLAR12
	.long	ani_adjustxy
	.word	0,8
	.long	POLAR13
	.long	ani_adjustxy
	.word	0,8
j_polar	.long	POLAR15
	.long	POLAR16
	.long	POLAR17
	.long	ani_jump,j_polar

;*************************************************************

kano_spider
	calla	wfe_him
	movi	>40,a9
	calla	pose_him_a9		; him = scared
	callr	face_him_at_me

	callr	animality_tune

	movk	2,a0
	movi	a_kano_spider,a9

	movi	>40,a10
	callr	animal_morph
	callr	l_sans_repell_for_good
	tsound	>26			; animality sizzle

	movk	5,a0
	jsrp	mframew			; pounce

	move	*a13(p_otherguy),a0,l
	move	*a0(ochar),a0,w
	cmpi	ft_sg,a0
	jrne	spid3

	movi	>20,a0
	clr	a1
	calla	multi_adjust_xy		; nudge for sheeva

spid3	push	a8
	move	*a13(p_otherguy),a8,l
	movk	6,a0
	calla	create_blood_proc
	pull	a8

	movi	spider_shake,a7
	calla	takeover_him
	jsrp	spider_shake_jsrp	; both of us shake

	movi	a_kano_spider,a9
	movk	3,a14
	calla	find_part_a14
	movk	5,a0
	jsrp	mframew			; back on ground

	movi	collapse_on_ground,a7
	calla	takeover_him
	sleep	>30

	tsound	>27    			; animality morph sound
	movk	5,a0
	jsrp	mframew			; back to kano
	jruc	animality_complete


spider_shake
	jsrp	spider_shake_jsrp

local_wait_forever
	jauc	wait_forever

spider_shake_jsrp
	movk	6,a0
	movk	3,a1
	movk	16,a2
	jauc	shake_a8_up 		; both shake !!


a_kano_spider
	.long	SPIDER1
	.long	SPIDER3
	.long	SPIDER4
	.long	SPIDER5		; morph
	.long	SPIDER6
	.long	0

	.long	ani_adjustxy
	.word	>14,->0a
	.long	SPIDER7
	.long	ani_adjustxy
	.word	>14,->0a
	.long	SPIDER8
	.long	ani_adjustxy
	.word	>14,->0a
	.long	SPIDER10
	.long	0

	.long	ani_adjustxy
	.word	->14,>0a
	.long	SPIDER10
	.long	ani_adjustxy
	.word	->14,>0a
	.long	SPIDER8
	.long	ani_adjustxy
	.word	->14,>0a
	.long	SPIDER7
	.long	SPIDER6
	.long	0

	.long	SPIDER5
	.long	SPIDER4
	.long	SPIDER3
	.long	SPIDER1		; back to kano
	.long	0

SPIDER1	.long	SPIDER1A,SPIDER1B,0
SPIDER3	.long	SPIDER3A,SPIDER3B,0
SPIDER4	.long	SPIDER4A,SPIDER4B,0
SPIDER5	.long	SPIDER5A,SPIDER5B,SPIDER5C,0
SPIDER6	.long	SPIDER6A,SPIDER6B,SPIDER6C,0
SPIDER7	.long	SPIDER7A,SPIDER7B,0
SPIDER8	.long	SPIDER8A,SPIDER8B,0
SPIDER10	.long	SPIDER10A,0

;*************************************************************

sonya_eagle
	callr	animality_tune

	movk	2,a0
	movi	a_sonya_hawk,a9
	movk	1,a10
	callr	animal_morph
	callr	l_sans_repell_for_good

	movk	5,a0
	calla	init_anirate
	movi	->2000,a0
	move	a0,*a8(ograv),l		; heading up !!
eagle3	sleep	1
	calla	next_anirate
	calla	distance_off_ground
	cmpi	>38,a0
	jrlo	eagle3

	callr	l_stop_me

eagle5	sleep	1
	movi	>a000,a0
	calla	towards_x_vel
	calla	next_anirate
	callr	l_get_x_dist
	cmpi	>08,a3
	jrhi	eagle5

	callr	l_stop_me
	movi	>30,a10
	callr	next_anirate_a10

	movi	->10000,a0
	move	a0,*a8(ograv),l
	move	*a13(p_otherguy),a10,l
	move	a0,*a10(ograv),l

	movi	>18,a10
	callr	next_anirate_a10
	callr	l_stop_me
	calla	stop_him
	movi	death_scream,a0
	calla	calla_for_him

	sleep	>30

	movi	>1b,a0
	callr	create_fx_for_him
	
	movi	>0008000c,a11
	calla	shake_a11
	tsound	>24
	tsound	>25
	sleep	>20

	tsound	>24
	tsound	>25
	sleep	>10
	calla	death_blow_complete
	jauc	wait_forever

;************************************************************************

jax_lion
	callr	animality_tune

	movk	2,a0
	movi	a_jax_lion,a9
	movk	18,a10
	callr	animal_morph
	callr	l_sans_repell_for_good
	sleep	>30

	movi	>20000,a0
	calla	towards_x_vel
	movk	5,a0
	jsrp	mframew			; attack

	movi	lion_mauled,a7
	calla	takeover_him

	callr	l_stop_me
	calla	stop_him
;xxx

	movi	>00050020,a0
	jsrp	animate_a0_frames
	calla	wfe_him
	sleep	8

	tsound	>27    			; animality morph sound
	movi	a_jax_lion,a9
	movk	5,a0
	jsrp	backwards_ani		; back 2 jax

	jruc	animality_complete


lion_mauled
	calla	death_scream
	calla	face_opponent
	movi	>0003001e,a9
	jsrp	animate_a9
	movk	3,a0
	jsrp	mframew

maul3	movk	7,a0
	calla	create_blood_proc
	tsound	>24
	movk	3,a0
	movk	3,a1
	movk	5,a2
	jsrp	shake_a8_up

	movk	7,a0
	calla	create_blood_proc
	calla	death_scream
	tsound	>25
	movk	5,a0
	movk	3,a1
	movk	3,a2
	jsrp	shake_a8_up		; just keep a shakin'
	jruc	maul3

a_jax_lion
	.long	LIONMORF1
	.long	LIONMORF3
	.long	LIONMORF4
	.long	LIONMORF5
	.long	LIONMORF6
	.long	0

	.long	LIONMORF7
	.long	LIONMORF8
	.long	0
	.long	LIONMORF10
	.long	LIONMORF13
	.long	LIONMORF14
a_lion	.long	LIONMORF15
	.long	LIONMORF16
	.long	LIONMORF17
	.long	ani_jump,a_lion

;************************************************************************

indian_wolf
	callr	animality_tune

	movk	2,a0
	movi	a_indiam_wolf,a9
	movk	18,a10
	callr	animal_morph
	callr	l_sans_repell_for_good
	sleep	>18

	tsound	>3c    			; wolf growl sound
	movi	>20000,a0
	calla	towards_x_vel
	movk	5,a0
	jsrp	mframew			; attack

	movi	lion_mauled,a7
	calla	takeover_him
	movi	>20000,a0
	calla	away_x_vel_him		; start him movin

	movi	>00060002,a0
	jsrp	animate_a0_frames	; finish attack
	callr	l_stop_me
	sleep	8
	calla	stop_him

	movi	>00050010,a0
	jsrp	animate_a0_frames	; finish attack

	movi	a_indiam_wolf,a9
	movk	4,a14
	calla	find_part_a14
	calla	do_next_a9_frame
	calla	wfe_him
	sleep	>28

	tsound	>27    			; animality morph sound
	movi	a_indiam_wolf,a9
	movk	5,a0
	jsrp	backwards_ani		; back 2 jax
	jruc	animality_complete


a_indiam_wolf
	.long	WOLF1
	.long	WOLF3
	.long	WOLF4
	.long	WOLF5
	.long	WOLF6
	.long	0

	.long	WOLF11
	.long	WOLF12
	.long	WOLF13
	.long	0

	.long	WOLF14
j_wolf	.long	WOLF15
	.long	WOLF16
	.long	WOLF18
	.long	ani_jump,j_wolf
	.long	0

	.long	WOLF20
	.long	0

;************************************************************************

next_anirate_a10
	pull	a11
na10	sleep	1
	calla	next_anirate
	dsj	a10,na10
	jump	a11


create_fx_for_him
	push	a8
	move	*a13(p_otherguy),a8,l
	calla	create_fx			; body parts
	pull	a8
	rets


a_sonya_hawk
	.long	HAWKMORF1
	.long	HAWKMORF3
	.long	HAWKMORF4
	.long	HAWKMORF5
	.long	HAWKFLY5
	.long	0

j_hawk	.long	HAWKFLY6
	.long	HAWKFLY7
	.long	HAWKFLY2
	.long	HAWKFLY3
	.long	HAWKFLY4
	.long	HAWKFLY5
	.long	ani_jump,j_hawk

HAWKMORF1
	.long	HAWKMORF1A,HAWKMORF1B,0
HAWKMORF3
	.long	HAWKMORF3A,HAWKMORF3B,0
HAWKMORF4
	.long	HAWKMORF4A,HAWKMORF4B,0
HAWKMORF5
	.long	HAWKMORF5A,HAWKMORF5B,HAWKMORF5C,0
HAWKFLY2
	.long	HAWKFLY2A,HAWKFLY2B,HAWKFLY2C,0
HAWKFLY3
	.long	HAWKFLY3A,HAWKFLY3B,0
HAWKFLY4
	.long	HAWKFLY4A,HAWKFLY4B,0
HAWKFLY5
	.long	HAWKFLY5A,HAWKFLY5B,HAWKFLY5C,0
HAWKFLY6
	.long	HAWKFLY6A,HAWKFLY6B,0
HAWKFLY7
	.long	HAWKFLY7A,HAWKFLY7B,0

;*************************************************************

LIONMORF1
	.long	LIONMORF1A,LIONMORF1B,0
LIONMORF3
	.long	LIONMORF3A,LIONMORF3B,0
LIONMORF4
	.long	LIONMORF4A,LIONMORF4B,0
LIONMORF5
	.long	LIONMORF5A,LIONMORF5B,LIONMORF5C,0
LIONMORF6
	.long	LIONMORF6A,LIONMORF6B,LIONMORF6C,0
LIONMORF7
	.long	LIONMORF7A,LIONMORF7B,LIONMORF7C,0
LIONMORF8
	.long	LIONMORF8A,LIONMORF8B,LIONMORF8C,0
LIONMORF10
	.long	LIONMORF10A,LIONMORF10B,LIONMORF10C,0
LIONMORF13
	.long	LIONMORF13A,LIONMORF13B,0
LIONMORF14
	.long	LIONMORF14A,LIONMORF14B,0
LIONMORF15
	.long	LIONMORF15A,LIONMORF15B,0
LIONMORF16
	.long	LIONMORF16A,LIONMORF16B,LIONMORF16C,0
LIONMORF17
	.long	LIONMORF17A,LIONMORF17B,0

;*************************************************************

POLAR1	.long	POLAR1A,POLAR1B,0
POLAR3	.long	POLAR3A,POLAR3B,0
POLAR4	.long	POLAR4A,POLAR4B,0
POLAR5	.long	POLAR5A,POLAR5B,0
POLAR6	.long	POLAR6A,POLAR6B,0
POLAR8	.long	POLAR8A,POLAR8B,0
POLAR10	.long	POLAR10A,0
POLAR11	.long	POLAR11A,0
POLAR12	.long	POLAR12A,POLAR12B,0
POLAR13	.long	POLAR13A,POLAR13B,0
POLAR15	.long	POLAR15A,POLAR15B,0
POLAR16	.long	POLAR16A,POLAR16B,0
POLAR17	.long	POLAR17A,POLAR17B,0

;*************************************************************

WOLF1	.long	WOLF1A,WOLF1B,0
WOLF3	.long	WOLF3A,WOLF3B,0
WOLF4	.long	WOLF4A,0
WOLF5	.long	WOLF5A,0
WOLF6	.long	WOLF6A,WOLF6B,0
WOLF11	.long	WOLF11A,0
WOLF12	.long	WOLF12A,0
WOLF13	.long	WOLF13A,0
WOLF14	.long	WOLF14A,WOLF14B,0
WOLF15	.long	WOLF15A,0
WOLF16	.long	WOLF16A,0
WOLF18	.long	WOLF18A,WOLF18B,0
WOLF20	.long	WOLF20A,WOLF20B,0

;*************************************************************

a_cheetah
	.long	CHEETA1
	.long	CHEETA3
	.long	CHEETA4
	.long	CHEETA5
	.long	CHEETA6
	.long	0

	.long	CHEETA7
	.long	CHEETA9
	.long	0
	.long	CHEETA10
	.long	CHEETA15
	.long	0

j_cheet	.long	CHEETA16
	.long	CHEETA17
	.long	CHEETA19
	.long	ani_jump,j_cheet
	.long	0

	.long	CHEETA15
	.long	0


CHEETA1
	.long	CHEETA1A,CHEETA1B,0
CHEETA3
	.long	CHEETA3A,CHEETA3B,0
CHEETA4
	.long	CHEETA4A,CHEETA4B,0
CHEETA5
	.long	CHEETA5A,CHEETA5B,0
CHEETA6
	.long	CHEETA6A,CHEETA6B,CHEETA6C,0
CHEETA7
	.long	CHEETA7A,CHEETA7B,CHEETA7C,0
CHEETA9
	.long	CHEETA9A,CHEETA9B,0
CHEETA10
	.long	CHEETA10A,CHEETA10B,0
CHEETA15
	.long	CHEETA15A,CHEETA15B,CHEETA15C,0
CHEETA16
	.long	CHEETA16A,CHEETA16B,CHEETA16C,0
CHEETA17
	.long	CHEETA17A,CHEETA17B,CHEETA17C,0
CHEETA19
	.long	CHEETA19A,CHEETA19B,CHEETA19C,0

;*************************************************************

a_bat
	.long	BAT1
	.long	BAT3
	.long	BAT4
	.long	BAT5
	.long	BAT6
	.long	0

	.long	BAT7
j_bat	.long	BAT8
	.long	BAT9
	.long	BAT10
	.long	BAT11
	.long	BAT12
	.long	BAT13
	.long	ani_jump,j_bat
	.long	0

BAT1	.long	BAT1A,BAT1B,0
BAT3	.long	BAT3A,BAT3B,0
BAT4	.long	BAT4A,BAT4B,0
BAT5	.long	BAT5A,BAT5B,0
BAT6	.long	BAT6A,BAT6B,0
BAT7	.long	BAT7A,BAT7B,0
BAT8	.long	BAT8A,BAT8B,0
BAT9	.long	BAT9A,BAT9B,0
BAT10	.long	BAT10A,BAT10B,0
BAT11	.long	BAT11A,BAT11B,0
BAT12	.long	BAT12A,BAT12B,0
BAT13	.long	BAT13A,BAT13B,0

;*************************************************************

a_snake
	.long	SNAKE1
	.long	SNAKE3
	.long	SNAKE4
	.long	SNAKE5
	.long	SNAKE6
	.long	0
	.long	SNAKE8
	.long	SNAKE9
	.long	SNAKE10
	.long	SNAKE11
	.long	0

	.long	SNAKE12
	.long	SNAKE13
	.long	SNAKE8
	.long	SNAKE6
	.long	0

SNAKE1
	.long	SNAKE1A,SNAKE1B,0
SNAKE3
	.long	SNAKE3A,SNAKE3B,0
SNAKE4
	.long	SNAKE4A,SNAKE4B,0
SNAKE5
	.long	SNAKE5A,SNAKE5B,0
SNAKE6
	.long	SNAKE6A,SNAKE6B,0
SNAKE8
	.long	SNAKE8A,SNAKE8B,0
SNAKE9
	.long	SNAKE9A,SNAKE9B,SNAKE9C,0
SNAKE10
	.long	SNAKE10A,SNAKE10B,SNAKE10C,0
SNAKE11
	.long	SNAKE11A,SNAKE11B,SNAKE11C,0
SNAKE12
	.long	SNAKE12A,SNAKE12B,SNAKE12C,0
SNAKE13
	.long	SNAKE13A,SNAKE13B,0

;*************************************************************

WASP1	.long	WASP1A,WASP1B,0
WASP3	.long	WASP3A,WASP3B,0
WASP4	.long	WASP4A,WASP4B,0
WASP5	.long	WASP5A,WASP5B,WASP5C,0
WASP6	.long	WASP6A,WASP6B,WASP6C,0
WASP7	.long	WASP7A,WASP7B,WASP7C,0
WASP9	.long	WASP9A,WASP9B,WASP9C,0
WASP10	.long	WASP10A,WASP10B,0
WASP11	.long	WASP11A,WASP11B,0

;unused
;WASP8	.long	WASP8A,0
;WASP12	.long	WASP12A,0

;*************************************************************

a_shark
	.long	SHARK1
	.long	SHARK3
	.long	SHARK4
	.long	SHARK5
	.long	0

	.long	SHARK9
	.long	SHARK10
	.long	SHARK11
	.long	SHARK12
	.long	SHARK13
	.long	0

	.long	SHARK14
	.long	SHARK15
	.long	SHARK16
	.long	SHARK17
	.long	SHARK19
	.long	0

SHARK1
	.long	SHARK1A,SHARK1B,0
SHARK3
	.long	SHARK3A,SHARK3B,0
SHARK4
	.long	SHARK4A,SHARK4B,0
SHARK5
	.long	SHARK5A,SHARK5B,0
SHARK9
	.long	SHARK9A,SHARK9B,0

SHARK10
	.long	SHARK10A,SHARK10B,SHARK10C,0
SHARK11
	.long	SHARK11A,SHARK11B,SHARK11C,SHARK11D
	.long	0
SHARK12
	.long	SHARK12A,SHARK12B,SHARK12C,SHARK12D
	.long	SHARK12E,0
SHARK13
	.long	SHARK13A,SHARK13B,SHARK13C,SHARK13D
	.long	SHARK13E,SHARK13F,SHARK13G,0
SHARK14
	.long	SHARK14A,SHARK14B,SHARK14C,SHARK14D
	.long	0
SHARK15
	.long	SHARK15A,SHARK15B,0
SHARK16
	.long	SHARK16A,0
SHARK17
	.long	SHARK17A,SHARK17B,0
SHARK19
	.long	SHARK19A,0


SHARKFIN
	.long	SHARKFINA,SHARKFINB,SHARKFINC,SHARKFIND
	.long	0

;*************************************************************

a_dragon
	.long	DRAGON1
	.long	DRAGON3
	.long	DRAGON4
	.long	DRAGON5
	.long	DRAGON6
	.long	DRAGON7
	.long	0
	.long	DRAGON9
;	.long	DRAGON10
	.long	DRAGON13
	.long	DRAGON15
	.long	0
	.long	DRAGON13
	.long	DRAGON9
	.long	0

DRAGON1
	.long	DRAGON1A,DRAGON1B,0
DRAGON3
	.long	DRAGON3A,DRAGON3B,0
DRAGON4
	.long	DRAGON4A,DRAGON4B,0
DRAGON5
	.long	DRAGON5A,DRAGON5B,0
DRAGON6
	.long	DRAGON6A,DRAGON6B,DRAGON6C,0
DRAGON7
	.long	DRAGON7A,DRAGON7B,DRAGON7C,0
DRAGON9
	.long	DRAGON9A,DRAGON9B,DRAGON9C,0

; not used
;DRAGON10
;	.long	DRAGON10A,0
DRAGON13
	.long	DRAGON13A,DRAGON13B,DRAGON13C,0
DRAGON15
	.long	DRAGON15A,DRAGON15B,DRAGON15C,DRAGON15D,0

;*************************************************************

a_scorpion
	.long	SCORP1
	.long	SCORP3
	.long	SCORP4
	.long	SCORP5
	.long	SCORP6
	.long	0

	.long	SCORP7
	.long	SCORP8
	.long	SCORP9
	.long	0

SCORP1	.long	SCORP1A,SCORP1B,0
SCORP3	.long	SCORP3A,SCORP3B,0
SCORP4	.long	SCORP4A,SCORP4B,SCORP4C,0
SCORP5	.long	SCORP5A,SCORP5B,SCORP5C,SCORP5D
	.long	0
SCORP6	.long	SCORP6A,SCORP6B,SCORP6C,SCORP6D
	.long	0
SCORP7	.long	SCORP7A,SCORP7B,SCORP7C,SCORP7D,0
SCORP8	.long	SCORP8A,SCORP8B,SCORP8C,0
SCORP9	.long	SCORP9A,SCORP9B,SCORP9C,0

;*************************************************************

DINO1	.long	DINO1A,DINO1B,0
DINO3	.long	DINO3A,DINO3B,0
DINO4	.long	DINO4A,DINO4B,DINO4C,0
DINO5	.long	DINO5A,DINO5B,DINO5C,0
DINO6	.long	DINO6A,DINO6B,DINO6C,DINO6D,0
DINO9	.long	DINO6A,DINO6B,DINO9A,DINO9B,0
DINO10	.long	DINO6A,DINO6B,DINO10A,DINO10B,0
DINO11	.long	DINO6A,DINO6B,DINO11A,DINO11B,0

;*************************************************************

a_bull
	.long	BULL1
	.long	BULL3
	.long	BULL4
	.long	BULL5
	.long	BULL6
	.long	0

j_bull	.long	BULL7
	.long	BULL8
	.long	BULL9
	.long	BULL10
	.long	BULL11
	.long	BULL12
	.long	BULL13
	.long	ani_jump,j_bull

BULL1	.long	BULL1A,BULL1B,0
BULL3	.long	BULL3A,BULL3B,BULL3C,0
BULL4	.long	BULL4A,BULL4B,BULL4C,0
BULL5	.long	BULL5A,BULL5B,BULL5C,0
BULL6	.long	BULL6A,BULL6B,BULL6C,0
BULL7	.long	BULL7A,BULL7B,0
BULL8	.long	BULL8A,BULL8B,BULL8C,0
BULL9	.long	BULL9A,BULL9B,BULL9C,BULL9D,0
BULL10	.long	BULL10A,BULL10B,BULL10C,0
BULL11	.long	BULL11A,BULL11B,BULL11C,BULL11D,0
BULL12	.long	BULL12A,BULL12B,BULL12C,BULL12D,0
BULL13	.long	BULL13A,BULL13B,BULL13C,0

;*************************************************************

a_skeleton
	.long	SKELETN1
	.long	SKELETN2
	.long	SKELETN3
	.long	SKELETN4
	.long	SKELETN5
	.long	0

	.long	SKELETN9
	.long	SKELETN10
	.long	SKELETN11
	.long	ani_nosleep
	.long	SKELETN12
	.long	0

	.long	SKELETN13
	.long	SKELETN14
	.long	0

SKELETN1
	.long	SKELETN1A,SKELETN1B,0
SKELETN2
	.long	SKELETN2A,SKELETN2B,0
SKELETN3
	.long	SKELETN3A,SKELETN3B,SKELETN3C,0
SKELETN4
	.long	SKELETN4A,SKELETN4B,SKELETN4C,0
SKELETN5
	.long	SKELETN5A,SKELETN5B,SKELETN5C,0
SKELETN9
	.long	SKELETN9A,SKELETN9B,SKELETN9C,0
SKELETN10
	.long	SKELETN10A,SKELETN10B,SKELETN10C,0
SKELETN11
	.long	SKELETN11A,SKELETN11B,SKELETN11C,0
SKELETN12
	.long	SKELETN12A,SKELETN12B,SKELETN12C,0
SKELETN13
	.long	SKELETN13A,SKELETN13B,SKELETN13C,0
SKELETN14
	.long	SKELETN14A,SKELETN14B,SKELETN14C,0

;*************************************

unmorph_and_exit
	movk	5,a0
	jsrp	backwards_ani		; back 2 sz
	jruc	animality_complete

animal_morph
	pull	a11
	sleep	>20

	move	*a9,a0,l  			; grab image which has pal
	move	*a0,a0,l
	move	*a0(icmap),a0,l
	calla	player_swpal
	calla	do_next_a9_frame
	sleep	>10				; pause on glow frame

	tsound	>27				; animality morph sound
	movk	5,a0
	jsrp	mframew

	move	a10,a0
	calla	prcslp
	jump	a11


animality_tune
	movi	>3a,a3
	jauc	send_code_a3

animality_complete
	calla	death_blow_complete
	calla	player_normpal
	jauc	victory_animation

face_him_at_me
	movi	face_opponent,a0
	jauc	calla_for_him

center_around_him
	movi	center_around_me,a0
	jruc	cfh

set_his_inviso
	movi	set_inviso,a0
cfh	jauc	calla_for_him

l_stop_me
	jauc	stop_me


l_get_x_dist
	jauc	get_x_dist

l_sans_repell_for_good
	jauc	sans_repell_for_good

q_yes	setc
	rets
q_no	clrc
	rets

local_ochar_sound
	jauc	ochar_sound

kill_repell
	movi	pid_repell,a0
	jauc	dallprc				; dont follow us offscreen

kill_and_stop_scrolling
	calla	stop_scrolling
	movi	pid_scroll,a0
	jauc	dallprc				; dont follow us offscreen

;*************************************

	.end
