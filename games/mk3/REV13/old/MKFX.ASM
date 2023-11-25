**************************************************************************
*											     *
*  video game project:	mortal kombat 3							*
* 											     *
*  game software:    	ed boon								     *
* 											     *
*  module: mkfx.asm ---  special fx								*
* 											     *
*  copyright (c) 1994-95 midway manufacturing					 	*
*											     *
**************************************************************************
	.file	'mkfx.asm'
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
	.include	mkfx.tbl
	.include	mkfx2.tbl
	.include	mkfx3.tbl
	.include	mkfight.tbl
	.include	imgtbl.glo
	.text

;*************************************************************************

create_fx
	sll	5,a0			; long word
	addi	fx_table,a0
	movi	pid_fx,a1
	move	*a0,a7,l		; grab address
	jauc	getprc

fx_table
	.long	sonya_proj_globs	; 0
	.long	trail_proc		; 1
	.long	floor_explode		; 2
	.long	freeze_blast		; 3
	.long	rocket_puff		; 4
	.long	dave_explode		; 5
	.long	scream_shaker		; 6
	.long	robo_dizzy_bolts	; 7
	.long	robo_tele_explode	; 8
	.long	robo_tele_implode	; 9
	.long	robo_bomb_explode	; a
	.long	fx_fight_intro		; b
	.long	robo_crunch_limbs	; c
	.long	fx_combo		; d
	.long	fx_comment		; e
	.long	jax_zap_puff		; f
	.long	lineup_explode		; 10
	.long	fx_finish_him		; 11
	.long	fx_finish_her		; 12
	.long	fx_charge_bars		; 13
	.long	smoke_a_guy		; 14
	.long	laser_explode		; 15
	.long	fatality_drip		; 16
	.long	fx_forden_a11		; 17
	.long	swat_bomb_explode	; 18
	.long	skinny_blood		; 19
	.long	pit_mulch		; 1a
	.long	sonya_animal_fx		; 1b
	.long	fx_animality		; 1c
	.long	fx_mercy		; 1d
	.long	fx_inviso_poof		; 1e
	.long	smoke_smoke		; 1f
	.long	stand_blood_explode	; 20
	.long	jax_stomp_explode	; 21
	.long	cyrax_fatal_explode	; 22
	.long	cyrax_cutup_blood	; 23
	.long	lao_nado_pieces		; 24
	.long	lia_spin_fx		; 25
	.long	inflate_boom		; 26
	.long	danger_danger		; 27
	.long	spike_blood_explode	; 28
	.long	subway_rox		; 29
	.long	fx_friendship		; 2a
	.long	fx_babality		; 2b
	.long	sonya_crush_explode	; 2c
	.long	sz_rip_guts		; 2d
	.long	cyrax_copter_guts	; 2e

**************************************************************************

cyrax_copter_guts
	move	a8,a9
	movi	ge_copter,a11  	; gravity explode table
	jsrp	gravity_explode
	jruc	l_die


ge_copter
	.word	2		; how many pieces
	.word	0,->10		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	ARM_B01		; starting image
	.long	a_arm2		; animation table
	.word	>801		; x vel range   (sll 8)
	.word	>100		; x vel minimum (sll 8)
	.word	>0		; y vel range   (sll 8)
	.word	>0		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	0,->10		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LEG01		; starting image
	.long	a_leg		; animation table
	.word	>801		; x vel range   (sll 8)
	.word	>100		; x vel minimum (sll 8)
	.word	>0		; y vel range   (sll 8)
	.word	>0		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	0,->10		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	BONE01		; starting image
	.long	a_bone		; animation table
	.word	>801		; x vel range   (sll 8)
	.word	>100		; x vel minimum (sll 8)
	.word	>0		; y vel range   (sll 8)
	.word	>0		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	0

**************************************************************************

sz_rip_guts
	move	a8,a9
	movi	ge_sz_rip,a11  	; gravity explode table
	jsrp	gravity_explode

	movi	>00000000,a10
	create	pid_blood,blood_explode
	addi	>0020,a10
	create	pid_blood,blood_explode
	subi	>0040,a10
	create	pid_blood,blood_explode
	jruc	l_die


ge_sz_rip
	.word	2		; how many pieces
	.word	0,>00		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	ARM_B01		; starting image
	.long	a_arm2		; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>200		; y vel range   (sll 8)
	.word	>200		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	0,>00		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LEG01		; starting image
	.long	a_leg		; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>200		; y vel range   (sll 8)
	.word	>200		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	10		; how many pieces
	.word	0,>00		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	BONE01		; starting image
	.long	a_bone		; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>200		; y vel range   (sll 8)
	.word	>200		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	1		; how many pieces
	.word	0,>00		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	CAGE01		; starting image
	.long	a_rib_cage	; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>200		; y vel range   (sll 8)
	.word	>200		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	1		; how many pieces
	.word	0,>00		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	SKULL01		; starting image
	.long	a_skull		; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>200		; y vel range   (sll 8)
	.word	>200		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	0

**************************************************************************

sonya_crush_explode
	create	pid_blood,stand_blood_explode
	move	a8,a9
	movi	ge_krush,a11  	; gravity explode table
	jsrp	gravity_explode
	jruc	l_die

ge_krush
	.word	2		; how many pieces
	.word	0,>90		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	ARM_B01		; starting image
	.long	a_arm2		; animation table
	.word	>101		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>800		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	0,>90		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LEG01		; starting image
	.long	a_leg		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>800		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	10		; how many pieces
	.word	0,>90		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	BONE01		; starting image
	.long	a_bone		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>800		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	1		; how many pieces
	.word	0,>90		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	CAGE01		; starting image
	.long	a_rib_cage	; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>800		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	1		; how many pieces
	.word	0,>90		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	SKULL01		; starting image
	.long	a_skull		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>800		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	0

**************************************************************************

fx_babality
	movi	>43,a3
	calla	send_code_a3		; baby music

	movi	sp_bonusv,a0
	srl	8,a0
	move	a0,@chan5pri,w		; fake out bonus count waiter

	movk	7,a11
bab4	create	pid_fx,baby_letter
	dsj	a11,bab4
	create	pid_fx,baby_letter
	sleep	>60
	clr	a0
	move	a0,@chan5pri,w		; fake out bonus count waiter
	tsound	>65			; speech: babality
	die

baby_letter
	movi	>10,a0
	movi	>10,a1
	calla	randu_minimum
	calla	prcslp

	move	a11,a5
	sll	5,a5
	addi	baby_text,a5
	move	*a5,a5,l
	calla	gso_dmawnz_ns

	move	a11,a5
	movi	>26,a3
	mpys	a3,a5
	addi	>38,a5
	move	a5,*a8(oxpos),w
	movi	->30,a0
	move	a0,*a8(oypos),w

	move	a11,a0
	cmpi	7,a0
	jrne	bab5
	clr	a0
bab5	move	a0,*a8(ozpos),w

	calla	insobja8
*
* fall down
*
	movi	>20000,a0
	jsrp	baby_fall

	movi	>20000,a0
	movi	>20000,a1
	calla	randu_minimum
	neg	a0
	jsrp	baby_fall

	movi	>10000,a0
	movi	>10000,a1
	calla	randu_minimum
	neg	a0
	jsrp	baby_fall

	die
	
baby_fall
	move	a0,*a8(oyvel),l
	sleep	2
babf4	sleep	1
	move	*a8(oyvel),a0,l
	addi	>3000,a0
	move	a0,*a8(oyvel),l
	move	a0,a0
	jrn	babf4				; heading up

	move	*a8(oypos),a0,w
	cmpi	>4d,a0
	jrlt	babf4
	movi	>4d,a0
	move	a0,*a8(oypos),w
	calla	stop_a8
	retp

baby_text
	.long	BABALITY1
	.long	BABALITY2
	.long	BABALITY3
	.long	BABALITY4
	.long	BABALITY5
	.long	BABALITY6
	.long	BABALITY7
	.long	BABALITY8

**************************************************************************

ship_proc
	movi	a_ship,a9
	jruc	fani3

fx_friendship
	create	pid_fx,friendship_speech
	create	pid_fx,ship_proc

	movi	a_friend,a9
fani3	calla	gmo_proc
	calla	set_noscroll
	movi	>100,a0
	move	a0,*a8(ozpos),w
	movi	>005000c7,a4
	calla	set_xy_coordinates
	calla	insobja8
	movk	4,a0
	jsrp	mframew
	die

friendship_speech
	tsound	>68			; friendship

	movi	sp_bonusv,a0
	srl	8,a0
	move	a0,@chan5pri,w		; fake out bonus count waiter
	sleep	>40

	tsound	>69

	movi	sp_bonusv,a0
	srl	8,a0
	move	a0,@chan5pri,w		; fake out bonus count waiter
	sleep	>40

	tsound	>6a

	clr	a0
	move	a0,@chan5pri,w		; fake out bonus count waiter
	die

a_friend
	.long	FRIEN1
	.long	FRIEN2
	.long	FRIEN3
	.long	FRIEN4
	.long	FRIEN5
	.long	FRIEN4
	.long	FRIEN3
	.long	FRIEN2
	.long	FRIEN1
	.long	FRIEN2
	.long	FRIEN3
	.long	FRIEN4
	.long	FRIEN5
	.long	FRIEN4
	.long	FRIEN3
	.long	FRIEN2
	.long	FRIEN1
	.long	FRIEN2
	.long	FRIEN3
	.long	FRIEN4
	.long	FRIEN5

	.long	0

a_ship
	.long	DSHIP1
	.long	DSHIP2
	.long	DSHIP3
	.long	DSHIP4
	.long	DSHIP5
	.long	DSHIP4
	.long	DSHIP3
	.long	DSHIP2
	.long	DSHIP1
	.long	DSHIP2
	.long	DSHIP3
	.long	DSHIP4
	.long	DSHIP5
	.long	DSHIP4
	.long	DSHIP3
	.long	DSHIP2
	.long	DSHIP1
	.long	DSHIP2
	.long	DSHIP3
	.long	DSHIP4
	.long	DSHIP5
	.long	0

FRIEN1	.long	FRIEN01,0
FRIEN2	.long	FRIEN02,0
FRIEN3	.long	FRIEN03,0
FRIEN4	.long	FRIEN04,0
FRIEN5	.long	FRIEN05,0

DSHIP1	.long	DSHIP01,0
DSHIP2	.long	DSHIP02,0
DSHIP3	.long	DSHIP03,0
DSHIP4	.long	DSHIP04,0
DSHIP5	.long	DSHIP05,0

**************************************************************************

subway_rox
	move	a8,a10
	tsound	>00			; explode through floor sound
	tsound	>01			; explode through floor sound

	movi	>000a0010,a11
	calla	shake_a11

	movk	10,a0
	movk	5,a6
	movi	a_small_rock,a11
	callr	do_rox

	movk	8,a0
	movk	5,a6
	movi	a_med_rock,a11
	callr	do_rox

	movk	4,a0
	movk	5,a6
	movi	a_large_rock,a11
	callr	do_rox

	die


do_rox
	move	a0,*a13(p_store2),w
	move	*a11,a5,l
	calla	gso_dmawnz
	move	*a10(oxpos),*a8(oxpos),w
	move	*a10(oypos),*a8(oypos),w
	calla	insobja8
	create	pid_blood,subway_rock_fall
	move	a6,*a0(p_store1),w
	move	a11,*a0(pa9),l
	move	*a13(p_store2),a0,w
	dsj	a0,do_rox
	rets


subway_rock_fall
	movi	8,a0
	calla	randu
	calla	prcslp

	move	@ground_y,a5,w
	movk	5,a0
	move	a0,a1
	calla	randu_minimum
	sub	a0,a5
	subi	>10,a5
	move	a5,*a13(p_ganiy),w		; set ground y

	movi	>20000,a0
	calla	srand
	move	a0,*a8(oxvel),l			; random x vel

	movi	>4000,a11
	movk	4,a10
	jsrp	gravity_a11
	jruc	do_land_routine

**************************************************************************

spike_blood_explode
	movi	>0070ffe0,a10
	create	pid_blood,blood_explode
	movi	>0070fff0,a10
	create	pid_blood,blood_explode
	movi	>00700000,a10
	create	pid_blood,blood_explode
	movi	>00700010,a10
	create	pid_blood,blood_explode
	movi	>00700020,a10
	create	pid_blood,blood_explode
	movi	>00700030,a10
	create	pid_blood,blood_explode
	die

**************************************************************************

inflate_boom
	move	a8,a9
	movi	ge_laser,a11		; gravity explode table
	jsrp	gravity_explode

	movi	>00060010,a11
	calla	shake_a11
	tsound	>00
	tsound	>01
	jsrp	white_flash
	jruc	l_die

**************************************************************************

lia_spin_fx
	sleep	>20
	create	pid_blood,hair_blood
	movk	4,a10
hspin3	create	pid_blood,hair_explode
	sleep	10
	dsj	a10,hspin3
	die

hair_blood
	callr	hair3
	sleep	20
	callr	hair3
	sleep	20
	tsound	>24
	tsound	>25
	die

hair3	tsound	>24
	tsound	>25
	create	pid_blood,nado_blood_explode
	rets



hair_explode
	move	a8,a9
	movi	ge_hair,a11   	; gravity explode table
	jsrp	gravity_explode
	die

ge_hair
	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	ARM_B01		; starting image
	.long	a_arm2		; animation table
	.word	>601		; x vel range   (sll 8)
	.word	>400		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LEG01		; starting image
	.long	a_leg		; animation table
	.word	>601		; x vel range   (sll 8)
	.word	>400		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	3		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	BONE01		; starting image
	.long	a_bone		; animation table
	.word	>601		; x vel range   (sll 8)
	.word	>400		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	PORK01		; starting image
	.long	a_pork		; animation table
	.word	>601		; x vel range   (sll 8)
	.word	>400		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	0

**************************************************************************

lao_nado_pieces
	push	a8
	callr	nado_spawn
	pull	a8
	sleep	>18
	callr	nado_spawn
	jruc	l_die

nado_spawn
	create	pid_blood,nado_blood_explode
	callr	nado_pieces
	tsound	>24
	tsound	>25
	rets

nado_blood_explode
	movi	>00100000,a10
	create	pid_blood,blood_explode
	addi	>00200000,a10
	create	pid_blood,blood_explode
	addi	>00200000,a10
	create	pid_blood,blood_explode
	die

nado_pieces
	move	a8,a9
	movi	ge_nado,a11   	; gravity explode table
	jsrp	gravity_explode
	rets

ge_nado
	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	ARM_B01		; starting image
	.long	a_arm2		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LEG01		; starting image
	.long	a_leg		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	3		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	BONE01		; starting image
	.long	a_bone		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	PORK01		; starting image
	.long	a_pork		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	0

**************************************************************************

cyrax_cutup_blood
	movi	>0000fff0,a10
	create	pid_blood,blood_explode
	addi	>00000020,a10
	create	pid_blood,blood_explode
	die

**************************************************************************

cyrax_fatal_explode
	tsound	>00
	tsound	>01

	movi	>000c0012,a11
	calla	shake_a11

	move	a8,a9
	movi	ge_laser,a11		; gravity explode table
	jsrp	gravity_explode

	move	*a13(p_otherguy),a9,l
	movi	ge_laser,a11		; gravity explode table
	jsrp	gravity_explode

	move	a9,a8
	create	pid_blood,cyrax_blood_explode
;	movk	1,a0
;	calla	create_blood_proc

	move	*a13(p_otherguy),a8,l
	create	pid_blood,cyrax_blood_explode
;	movk	1,a0
;	calla	create_blood_proc

;	sleep	2
	jsrp	white_flash
	jruc	l_die

**************************************************************************

cyrax_blood_explode
	addi	>00200000,a10
	jruc	cbx3

stand_blood_explode
	movi	>00000000,a10
cbx3	create	pid_blood,blood_explode
	addi	>00200000,a10
	create	pid_blood,blood_explode
	addi	>00200000,a10
	create	pid_blood,blood_explode
	die

jax_stomp_explode
	movi	>00900000,a10
	create	pid_blood,blood_explode
	movi	>00900010,a10
	create	pid_blood,blood_explode
	movi	>00900020,a10
	create	pid_blood,blood_explode
	movi	>00900030,a10
	create	pid_blood,blood_explode
	die

**************************************************************************

fx_mercy
	movi	pid_mercy,a0
	move	a0,*a13(procid),w

	create	pid_mercy,make_db_tone
	create	pid_fade,mercy_fader
	sleep	>30

	tsound	>5d			; Mercy music hit !!

	movi	MERCY_01,a5
	movi	>ffd00000,a4
	calla	gso_dmawnz_ns_coor
	calla	center_obj_x
	calla	insobja8

	movi	a_mercy,a9
	movk	4,a0
	jsrp	framew
	callr	new_mercy_pal
	movk	4,a0
	jsrp	framew
	callr	new_mercy_pal
	movk	4,a0
	jsrp	framew

	move	a10,a0
	addi	>4e,a0
	calla	triple_sound		; speech: ???? shows mercy

	sleep	>08
	
	move	a8,a0
	calla	delobjp
	sleep	8
	calla	play_background_tune
	die


new_mercy_pal
	move	*a9,a1,l
	move	*a1(icmap),a0,l
	jauc	swpal


a_mercy	.long	MERCY_01
	.long	MERCY_02
	.long	MERCY_03
	.long	MERCY_04
	.long	MERCY_05
	.long	MERCY_06
	.long	MERCY_07
	.long	MERCY_08
	.long	MERCY_09
	.long	0
	.long	MERCY_10
	.long	MERCY_11
	.long	MERCY_12
	.long	MERCY_11
	.long	MERCY_10
	.long	MERCY_11
	.long	MERCY_12
	.long	MERCY_11
	.long	MERCY_10
	.long	0
	.long	MERCY_13
	.long	0


mercy_fader
	movi	pid_cycle,a0
	calla	dallprc			; kill any color cycle procs

	push	a9
	movi	>800,a9
	create	pid_fade,skydown
	pull	a9
	movi	death_fade_excludes,a0
	calla	fadeout_mercy

;	sleep	7
;	movi	pid_fade,a0
;	calla	dallprc
;	clr	a0
;	move	a0,@f_shadows,w

	jruc	l_die

**************************************************************************

sonya_animal_fx
	movk	10,a10
sony3	movk	1,a0
	calla	create_blood_proc
	dsj	a10,sony3

	move	a8,a9
	movi	ge_laser,a11		; gravity explode table
	jsrp	gravity_explode
	jruc	l_die

**************************************************************************

pit_mulch
	movi	>0006000a,a11
	calla	shake_a11

	create	pid_fx,pit_mulch_burst
	movi	>00400000,a10
	callr	pit_blood_explode
	movi	>00300030,a10
	callr	pit_blood_explode
	movi	>0020ffc0,a10
	callr	pit_blood_explode

	sleep	8

	create	pid_fx,pit_mulch_burst
	movi	>00400030,a10
	callr	pit_blood_explode
	movi	>00200000,a10
	callr	pit_blood_explode
	movi	>00300030,a10
	callr	pit_blood_explode

	die

pit_blood_explode
	pull	a11
	create	pid_fx,blood_explode
	sleep	4
	jump	a11



pit_mulch_burst
	move	a8,a9
	movi	ge_pit_mulch,a11		; gravity explode table
	jsrp	gravity_explode
	jruc	l_die


ge_pit_mulch
	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	ARM_B01		; starting image
	.long	a_arm2		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>700		; y vel range   (sll 8)
	.word	>300		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	4		; land routine

	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LEG01		; starting image
	.long	a_leg		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>700		; y vel range   (sll 8)
	.word	>300		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	4		; land routine

	.word	5		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	BONE01		; starting image
	.long	a_bone		; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>600		; y vel range   (sll 8)
	.word	>200		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	4		; land routine

	.word	5		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	PORK01		; starting image
	.long	a_pork		; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>600		; y vel range   (sll 8)
	.word	>200		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	4		; land routine

	.word	0		; end of table

**************************************************************************

skinny_blood
	movi	pid_blood,a0
	move	a0,*a13(procid),w

	movi	>08,a0
	movi	>10,a1
	calla	randu_minimum
	calla	prcslp			; random sleep

	move	a8,a10			; obj to follow
	movi	a_skinny_blood,a9

	move	*a9,a5,l
	calla	gso_dmawnz
	move	a10,a1
	move	a8,a0
	calla	lineup_1pwm

	move	a11,a0
	move	a11,a1
	zext	a0,w
	sra	16,a1
	calla	multi_adjust_xy		; place it !

	movi	100,a0	
	move	a0,*a8(ozpos),w		; front of all
	calla	insobja8

	movk	5,a0
	jsrp	framew			; drip stretch
	movk	6,a0
	calla	init_anirate
	movi	>10000,a0
	move	a0,*a8(oyvel),l

skbl3	sleep	1
	calla	next_anirate

	move	*a8(oyvel),a0,l
	addi	>6000,a0
	move	a0,*a8(oyvel),l		; gravity

	move	*a8(oypos),a0,w
	move	@ground_y,a1,w
	subi	>10,a1
	cmp	a0,a1
	jrgt	skbl3			; fall to ground

	calla	find_part2
	calla	stop_a8
	movk	5,a0
	jsrp	framew			; puddle
	die

**************************************************************************

fx_animality
	tsound	>60			; ROAR !!!
	movi	ANIMALITY01,a5
	movi	>00500050,a4
	calla	gso_dmawnz_ns_coor
	movi	>100,a0
	move	a0,*a8(ozpos),w
	calla	insobja8
	movi	a_animality,a9
	movk	4,a0
	jsrp	framew

	movi	sp_bonusv,a0
	srl	8,a0
	move	a0,@chan5pri,w		; fake out bonus count waiter

	sleep	>2a
	tsound	>64			; speech: animality

	clr	a0
	move	a0,@chan5pri,w		; fake out bonus count waiter
	die

a_animality
	.long	ANIMALITY01
	.long	ANIMALITY02
	.long	ANIMALITY03
	.long	ANIMALITY04
	.long	ANIMALITY05
	.long	ANIMALITY06
	.long	ANIMALITY07
	.long	ANIMALITY08
	.long	ANIMALITY09
	.long	ANIMALITY10
	.long	ANIMALITY11
	.long	ANIMALITY12
	.long	0

**************************************************************************

fatality_drip
	tsound	>62

	movi	FATALITY01,a5
	movi	>00500000,a4
	calla	gso_dmawnz_ns_coor
	calla	center_obj_x
	movi	1000,a0
	move	a0,*a8(ozpos),w
	calla	insobja8

	movi	a_fatality_drip,a9
	movk	4,a0
	jsrp	framew
	die

a_fatality_drip
	.long	FATALITY01
	.long	FATALITY02
	.long	FATALITY03
	.long	FATALITY04
	.long	FATALITY05
	.long	FATALITY06
	.long	FATALITY07
	.long	FATALITY08
j_fatal	.long	FATALITY09
	.long	FATALITY10
	.long	FATALITY11
	.long	FATALITY12
	.long	FATALITY13
	.long	FATALITY14
	.long	FATALITY15
	.long	ani_jump,j_fatal

**************************************************************************

swat_bomb_explode
	tsound	>00
	tsound	>01
	movi	>000c0012,a11
	calla	shake_a11
	move	a8,a9
	movi	ge_laser,a11		; gravity explode table
	jsrp	gravity_explode
	jruc	stand_blood_explode


laser_explode
	tsound	>00
	tsound	>01

	movi	>000c0012,a11
	calla	shake_a11
	move	a8,a9
	movi	ge_laser,a11		; gravity explode table
	jsrp	gravity_explode

	sleep	2
	jsrp	white_flash
	jruc	l_die

ge_laser
	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	ARM_B01		; starting image
	.long	a_arm2		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>b00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	2		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LEG01		; starting image
	.long	a_leg		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>b00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	10		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	BONE01		; starting image
	.long	a_bone		; animation table
	.word	>401		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>a00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	1		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	CAGE01		; starting image
	.long	a_rib_cage	; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>b00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	1		; how many pieces
	.word	>0,>40		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	SKULL01		; starting image
	.long	a_skull		; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>b00		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	3		; land routine

	.word	0

**************************************************************************

smoke_smoke
	movi	pid_smoker,a0
	move	a0,*a13(procid),w
ssm1	movk	2,a5
ssm3	create	pid_1_puff,smoke_smoke_1
	dsj	a5,ssm3
ssm4	sleep	5
	move	*a8(ochar),a4,w
	cmpi	ft_smoke,a4
	jrne	ssm4			; no longer smoke = no smoke
	move	*a8(oflags2),a4,w
	btst	b_inviso,a4
	jrne	ssm4			; invisible = dont smoke em
	jruc	ssm1


smoke_smoke_1
	movi	front_z+1,a6
	callr	puff_init

	movi	>18,a0
	calla	srand
	move	a0,a14

	movi	>40,a0
	movi	>20,a1
	calla	randu_minimum
	move	a0,a1
	move	a14,a0
	calla	multi_adjust_xy		; random ness

	movi	>30000,a0
	movi	>10000,a1
	calla	randu_minimum
	neg	a0
	move	a0,*a8(oyvel),l

;	movi	>20000,a0
	movi	>18000,a0
	calla	srand
	move	a0,*a8(oxvel),l
	calla	insobja8
	jruc	puff_ani2

;****************************************************

smoke_a_guy
	movi	pid_smoker,a0
	move	a0,*a13(procid),w

	move	a10,a5
sag4	create	pid_1_puff,smoke_a_1
	dsj	a5,sag4
	sleep	4
	jruc	smoke_a_guy

smoke_a_1
	movi	front_z+1,a6
	callr	puff_init

	movi	>20,a0
	calla	srand
	move	a0,a14

	movi	>70,a0
	clr	a1
	calla	randu_minimum
	move	a0,a1
	move	a14,a0
	calla	multi_adjust_xy		; random ness

	movi	>30000,a0
	movi	>10000,a1
	calla	randu_minimum
	neg	a0
	move	a0,*a8(oyvel),l
	movi	>20000,a0
	calla	srand
	move	a0,*a8(oxvel),l

	calla	insobja8

puff_ani2
	movi	a_puff,a9
	movk	4,a0
	jsrp	framew
	move	a8,a0
	calla	delobjp
	jruc	l_die

**************************************************************************

fx_combo
	move	*a8(oid),*a13(p_store1),w		; players oid here !!

	movi	pid_combo_msg,a0
	calla	dallprc
	movi	oid_combo_msg,a0
	calla	dallobj
	move	a0,*a13(procid),w			; there can be only 1 !!

	create	pid_combo_msg,hits_msg
	move	*a13(p_store1),*a0(p_store1),w	; players oid here !!
	sleep	10

	move	a10,a11
	movi	>00580000,a4
	movi	damage_s,a5
	movk	1,a6
	callr	setup_combo_message
	jruc	slide_combo_msg

hits_msg
	movi	>00480000,a4
	movi	hits_s,a5
	movk	7,a6
	callr	setup_combo_message

	move	*a13(p_store1),a0,w	; players oid here !!
	cmpi	pid_p2,a0
	jreq	slide_combo_msg		; player 1: no need to right justify

	movi	>30,a0
	move	*a8(oxpos),a1,w
	move	*a9(oxpos),a2,w
	add	a0,a1
	add	a0,a2
	move	a1,*a8(oxpos),w
	move	a2,*a9(oxpos),w
	cmp	a9,a10
	jreq	slide_combo_msg
	move	*a10(oxpos),a2,w
	add	a0,a2
	move	a2,*a10(oxpos),w  	; right justify for player 2
	jruc	slide_combo_msg


setup_combo_message
	push	a6
	move	@ofree,a10,l		; in case our # is only 1 digit
	move	a11,a1
	cmpi	100,a1
	jrlo	setc2
	movi	99,a1
setc2	move	a1,a3
	movk	10,a7
	divs	a7,a3	    		; compute 10's digit
	jreq	setc3	    		; none

	move	a3,a7
	callr	a3_combo_number_obj
	move	a8,a10		    	; a10 = 1st digit !!!

setc3	movk	10,a2
	mpys	a2,a3		    	; tens digit x 10 !!
	sub	a3,a1
	move	a1,a3
	callr	a3_combo_number_obj
	move	a8,a9		    	; a9 = 2nd digit !!!
*
* now do the "message" part
*
	calla	gso_dmawnz_ns_coor
	movi	oid_combo_msg,a0
	move	a0,*a8(oid),w
	move	a0,*a9(oid),w
	move	a0,*a10(oid),w

	movi	>f0000,a3			; velocity of text
	move	*a8(osizex),a0,w
	neg	a0
	move	*a13(p_store1),a2,w
	cmpi	pid_p2,a2
	jreq	fxcom3
	movi	scrrgt,a0
	neg	a3
fxcom3	move	a0,*a8(oxpos),w			; just outside of sight !!

	move	*a9(osizex),a1,w
	sub	a1,a0
	pull	a6
	sub	a6,a0				; spacing
	move	a0,*a9(oxpos),w			; ones digit

	cmp	a9,a10
	jreq	fxcom5
	move	*a10(osizex),a1,w
	sub	a1,a0
	move	a0,*a10(oxpos),w		; tens digit

fxcom5	move	a3,*a8(oxvel),l
	move	a3,*a9(oxvel),l
	move	a3,*a10(oxvel),l
	move	a3,*a8(oslink),l
	move	a3,*a9(oslink),l
	move	a3,*a10(oslink),l

	move	a8,a0
	calla	insobj
	move	a9,a0
	calla	insobj
	cmp	a9,a10
	jreq	fxcom6
	move	a10,a0
	calla	insobj
fxcom6	rets


a3_combo_number_obj
	mmtm	sp,a1,a3,a4,a5,a7
	calla	gso_dmawnz_ns_coor
	cmpi	9,a3
	jrhi	cnum9
	sll	5,a3
	addi	dave_small_numbers,a3
	move	*a3,a1,l
	calla	ani_flag
cnum9	mmfm	sp,a1,a3,a4,a5,a7
	rets


slide_combo_msg
	movi	>15,a11
slide1	sleep	1
	move	*a8(oxvel),a0,l
	move	a0,a1
	sra	3,a1
	sub	a1,a0
	move	a0,*a8(oxvel),l			; damping to look kool !!
	move	a0,*a9(oxvel),l			; damping to look kool !!
	move	a0,*a10(oxvel),l		; damping to look kool !!
	dsj	a11,slide1
	sleep	2
	clr	a0
	move	a0,*a8(oxvel),l
	move	a0,*a9(oxvel),l
	move	a0,*a10(oxvel),l
	sleep	>48
	move	*a8(oslink),a3,l
	neg	a3
	move	a3,*a8(oxvel),l
	move	a3,*a9(oxvel),l
	move	a3,*a10(oxvel),l

	sleep	10

	move	a8,a0
	calla	delobjp
	move	a9,a0
	calla	delobjp
	cmp	a9,a10
	jreq	l_die

	move	a10,a0
	calla	delobjp
	jruc	l_die

**************************************************************************
*											     *
*  fx_charge_bars - Grow the powerbars from 0 to maxpower			     *
*											     *
**************************************************************************
fx_charge_bars
	movi	pid_fx_charge,a0
	move	a0,*a13(procid),w	; set me id

	movi	-1,a0
	move	a0,@p1_bar,w
	move	a0,@p2_bar,w		; neg bar = flag: dont mess with bars !

	clr	a0
	move	a0,@p1_bar_view,w
	move	a0,@p2_bar_view,w

	movi	full_strength,a10	; p1 max out
	movi	full_strength,a11	; p2 max out

	movk	4,a8
gxcb5	callr	charge_stuff
	sleep	1
	addk	2,a8
	cmpi	full_strength,a8
	jrlo	gxcb5
	callr	charge_stuff
	die

charge_stuff
	move	a8,a6
	cmp	a10,a6
	jrlo	chst3
	move	a10,a6
chst3	move	a6,@p1_bar_view,w
	move	a6,@p1_bar,w

	move	a8,a7
	cmp	a11,a7
	jrlo	chst5
	move	a11,a7
chst5	move	a7,@p2_bar_view,w
	move	a7,@p2_bar,w		; neg bar = flag: dont mess with bars !
	rets

;**************************************************************************

fx_comment
	move	@p1_char,a0,w
	move	@p2_char,a1,w
	movi	ft_sk,a2
	calla	double_compare
	jreq	l_die			; no comment from Kahn if Kahn playing
	movi	ft_motaro,a2
	calla	double_compare
	jreq	l_die			; no comment if Motaro

	movi	pid_comment,a0
	calla	dallprc			; Raiden says: there can be only 1 !!!
	move	a0,*a13(procid),w

	sleep	>13

	movi	>1b,a11			; sound: toasty
	movi	40,a0
	calla	randper
	jrc	forden_peek

	movi	20,a0
	calla	randper
	jrc	shao_toasty		; every blue moon

	movk	6,a0
	calla	randu
	dec	a0
	sll	4,a0
	addi	comment_table,a0	; table of comment sound calls
	move	*a0,a0,w
	calla	triple_sound
	jruc	l_die

shao_toasty
	tsound	>6b
	jruc	l_die

comment_table
	.word	>0b		; Crowd "Oooo"
	.word	>74		; superb
	.word	>75		; well done
	.word	>79		; laugh 1
	.word	>7a		; laugh 2
	.word	>7b		; laugh 3

fx_forden_a11
	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jaeq	sucide

	sleep	>13

forden_peek
;	move	@tick,a0,w
;	move	a0,@toasty,w		; look at our stop watch now !!

	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jaeq	sucide

	move	@p1_bar,a0,w
	jreq	l_die
	move	@p2_bar,a0,w
	jreq	l_die			; round over = no toasty guy !!

	move	a11,a9
	movi	pid_forden,a0
	move	a0,*a13(procid),w
	movi	TOASTY,a5
	calla	gso_dmawnz_ns
	movi	>00a00158,a4
	calla	set_xy_coordinates
	movi	100,a0
	move	a0,*a8(ozpos),w
	calla	insobj2a8

	movi	->80000,a11
	move	a11,*a8(oxvel),l
	movk	6,a10
ford3	sleep	1
	dsj	a10,ford3

	calla	stop_a8
	move	a9,a0
	calla	triple_sound

	sleep	>20
	neg	a11
	move	a11,*a8(oxvel),l

	movi	>10,a10
ford5	sleep	1
	dsj	a10,ford5

	move	a8,a0
	calla	delobjp2
	die

;**************************************************************************

robo_crunch_limbs
	movi	>00090009,a11
	calla	shake_a11

	move	a8,a10
	movi	robo_limb_spots,a11

rcl3 	move	*a11+,a0,w
	jrn	rcl9

	callr	get_a_limb
	push	a8
	move	a8,a0
	move	a10,a8
	calla	match_ani_points		; match flip flags and such
	pull	a8
	move	*a11+,a0,w
	move	*a11+,a1,w
	calla	multi_adjust_xy

	movi	squeeze_out_left,a7
	move	*a11+,a0,w
	jreq	rcl5
	movi	squeeze_out_right,a7
rcl5	movi	pid_blood,a1
	calla	getprc
	jruc	rcl3

rcl9	jruc	l_die


robo_limb_spots
	.word	0,>50,>28,0
	.word	1,>70,>28,0
	.word	2,>90,>28,1
	.word	3,>b0,>28,1

	.word	4,>c0,>28,1
	.word	4,>c0,>28,1
	.word	4,>c0,>28,0
	.word	4,>c0,>28,0

	.word	5,>d0,>28,1
	.word	5,>d0,>28,1
	.word	5,>d0,>28,1

	.word	5,>50,>28,1
	.word	5,>60,>28,0
	.word	5,>70,>28,1

	.word	6,>80,>28,1
	.word	7,>70,>28,1
	.word	-1



limb_table
	.long	a_arm		; 0
	.long	a_arm2		; 1
	.long	a_leg		; 2
	.long	a_leg2		; 3
	.long	a_limb		; 4
	.long	a_bone		; 5
	.long	a_rib_cage	; 6
	.long	a_skull		; 7
	.long	a_goro_arm	; 8


squeeze_out_right
	movi	>10000,a0
	movi	>10000,a1
	calla	randu_minimum
	jruc	sol4

squeeze_out_left
	movi	>10000,a0
	movi	>10000,a1
	calla	randu_minimum
	neg	a0

sol4	calla	set_proj_vel
	movk	3,a0
	move	a0,*a13(p_store1),w

	movi	>4000,a0
	movi	>2000,a1
	calla	randu_minimum
	move	a0,a11			; random gravity

	move	@ground_y,a0,w
	move	*a8(osizey),a1,w
	sub	a1,a0
	addi	>10,a0
	move	a0,*a13(p_ganiy),w	; set our ground

	movk	3,a0
	calla	init_anirate
	jsrp	gravity_a11
	calla	half_x_vel

	movi	->30000,a0
	jsrp	gravity_a11_yvel

	move	@rand,a0,l
	jrn	sol7
	movi	->20000,a0
	jsrp	gravity_a11_yvel
sol7	calla	stop_a8
	jruc	l_die

get_a_limb
	sll	5,a0
	addi	limb_table,a0
	move	*a0,a9,l
	move	*a9,a5,l
	calla	gso_dmawnz
	movi	front_z+2,a0
	move	a0,*a8(ozval),l
	jauc	insobja8


a_arm
	.long	ARM01,ARM02,ARM03,ARM04,ARM05,ARM06,ARM07,ARM08,ARM09,ARM10
	.long	ARM11,ARM12,ani_jump,a_arm,0

a_arm_land
	.long	ARM13,ARM14,ARM15,ARM16,ARM17,ARM18,ARM19
	.long	0

a_arm2
	.long	ARM_B01,ARM_B02,ARM_B03,ARM_B04,ARM_B05,ARM_B06,ARM_B07,ARM_B08,ARM_B09,ARM_B10
	.long	ARM_B11,ARM_B12,ani_jump,a_arm2
	.long	0

a_leg
	.long	LEG01,LEG02,LEG03,LEG04,LEG05,LEG06,LEG07,LEG08,LEG09,LEG10,LEG11,LEG12
	.long	ani_jump,a_leg
	.long	LEG13,LEG14,LEG15,LEG16,LEG17,LEG18
	.long	0

a_leg2
	.long	LEG_B01,LEG_B02,LEG_B03,LEG_B04,LEG_B05,LEG_B06,LEG_B07
	.long	LEG_B08,LEG_B09,LEG_B10,LEG_B11,LEG_B12,ani_jump,a_leg2
	.long	0

a_limb
	.long	XLIMB01,XLIMB02,XLIMB03,XLIMB04,XLIMB05,XLIMB06,XLIMB07
	.long	XLIMB08,XLIMB09,XLIMB10,XLIMB11,XLIMB12,ani_jump,a_limb
	.long	0

a_bone
	.long	BONE01,BONE02,BONE03,BONE04,BONE05,BONE06,BONE07,BONE08
	.long	BONE09,BONE10,BONE11,BONE12
;	.long	0,ani_jump,a_bone
	.long	ani_jump,a_bone

a_rib_cage
	.long	CAGE01,CAGE02,CAGE03,CAGE04,CAGE05,CAGE06,CAGE07,CAGE08,CAGE09,CAGE10,CAGE11
	.long	CAGE12,ani_jump,a_rib_cage
	.long	CAGE13,CAGE14,CAGE15,CAGE16,CAGE17,CAGE18,CAGE19,CAGE20,CAGE21,CAGE22,CAGE23,CAGE24
	.long	0

a_skull
	.long	SKULL01,SKULL02,SKULL03,SKULL04,SKULL05,SKULL06,SKULL07
	.long	SKULL08,SKULL09,SKULL10,SKULL11,SKULL12,ani_jump,a_skull

a_goro_arm
	.long	GOROARM02,GOROARM03,GOROARM04,GOROARM05,GOROARM06,GOROARM07
	.long	GOROARM08,GOROARM09,GOROARM10,GOROARM11,GOROARM12,ani_jump,a_goro_arm

;**************************************************************************

fx_fight_intro
	clr	a0			; no speech
	movi	FINFITE1,a5
	movi	a_fight_out,a9
	jruc	grow_in_spin_out

fx_finish_him
	movi	>15,a0			; speech: finish him !!
	movi	FINHIM1,a5
	movi	a_finhim_out,a9
	jruc	grow_in_spin_out

fx_finish_her
	movi	>16,a0			; speech: finish him !!
	movi	FINHER1,a5
	movi	a_finher_out,a9

grow_in_spin_out
	move	a9,*a13(p_store1),l
	move	a0,*a13(p_store2),w

	movi	pid_grow,a0
	move	a0,*a13(procid),w	; new id

	move	*a5(isizex),a11,w
	sll	8,a11			; shift for the formula
	move	*a5(isizey),a10,w
	sll	8,a10			; shift for the formula

	calla	gso_dmawnz_ns
	movi	>48,a0
	move	a0,*a8(oypos),w
	calla	center_obj_x
	movi	>03000300,a9
	move	a9,*a8(oscale),l	; start off real small
	calla	insobja8
	move	*a13(p_store2),a0,w
	jreq	grow3
	calla	triple_sound
*
* grow loop
*
grow3	move	a9,*a8(oscale),l	; start off real small
	callr	center_scaled
	sleep	1
	subi	>00200020,a9
	cmpi	>01000100,a9
	jrne	grow3
	move	a9,*a8(oscale),l	; full size !
	calla	center_obj_x

	movk	6,a9
grow5	movi	FITEYEL_P,a0
	calla	swpal
	sleep	4
	movi	MKFIGHT_P,a0
	calla	swpal
	sleep	4
	dsjs	a9,grow5		; flash yellow and red

;	movk	4,a0
	movk	3,a0
	move	*a13(p_store1),a9,l
	jsrp	framew
	move	a8,a0
	calla	delobjp
	jruc	l_die

center_scaled
	move	a11,a1
	move	a9,a3
	zext	a3,w			; only look at x
	divs	a3,a1			; a1 = new scaled x size
	movi	scrrgt/2,a2
	srl	1,a1			; 1/2 of x size
	sub	a1,a2			; center the image on the screen
	move	a2,*a8(oxpos),w

	move	a10,a1
	move	a9,a3
	srl	16,a3			; only look at y
	divs	a3,a1			; a1 = new scaled x size
	movi	(scrbot/2)->30,a2
	srl	1,a1			; 1/2 of x size
	sub	a1,a2			; center the image on the screen
	move	a2,*a8(oypos),w
	rets

a_fight_out
	.long	FINFITE1
	.long	FINFITE2
	.long	FINFITE3
	.long	FINFITE4
	.long	FINFITE5
	.long	FINFITE6
	.long	FINFITE7
	.long	FINFITE8
	.long	FINFITE9
	.long	FINFITE10
	.long	FINFITE11
	.long	FINFITE12
	.long	FINFITE13
	.long	FINFITE14
	.long	FINFITE15
	.long	FINFITE16
	.long	FINFITE17
	.long	0

a_finhim_out
	.long	FINHIM1
	.long	FINHIM2
	.long	FINHIM3
	.long	FINHIM4
	.long	FINHIM5
	.long	FINHIM6
	.long	FINHIM7
	.long	FINHIM8
	.long	FINHIM9
	.long	FINHIM10
	.long	FINHIM11
	.long	FINHIM12
	.long	FINHIM13
	.long	FINHIM14
	.long	FINHIM15
	.long	FINHIM16
	.long	FINHIM17
	.long	0

a_finher_out
	.long	FINHER1
	.long	FINHER2
	.long	FINHER3
	.long	FINHER4
	.long	FINHER5
	.long	FINHER6
	.long	FINHER7
	.long	FINHER8
	.long	FINHER9
	.long	FINHER10
	.long	FINHER11
	.long	FINHER12
	.long	FINHER13
	.long	FINHER14
	.long	FINHER15
	.long	FINHER16
	.long	FINHER17
	.long	0

**************************************************************************

fx_inviso_poof
	movi	pid_poof,a0
	move	a0,*a13(procid),w		; id = gravity piece

	move	a8,a10
	movi	a_ground_explode,a9
	calla	gmo_proc
	move	a0,*a8(oplink),l
	calla	a8_front_plus_1			; in front of players

	move	a8,a11
	move	a8,a0
	move	a10,a8
	calla	match_ani_points
	move	a11,a8
	movi	>00,a0
	movi	>90,a1
	calla	multi_adjust_xy			; lineup properly
	calla	insobja8

	movk	3,a0
	jsrp	mframew
	jauc	delete_proj_and_die


robo_bomb_explode
	movi	pid_gravp,a0
	move	a0,*a13(procid),w		; id = gravity piece

	movi	>00080008,a11
	calla	shake_a11
	move	a8,a10

	movi	a_ground_explode,a9
	calla	gmo_proc
	move	a0,*a8(oplink),l
	calla	a8_front_plus_1			; in front of players

	move	a8,a11
	move	a8,a0
	move	a10,a8
	calla	match_ani_points
	move	a11,a8
	movi	>00,a0
	movi	>0a,a1
	calla	multi_adjust_xy			; lineup properly
	calla	insobja8

	movk	3,a0
	jsrp	mframew
	jauc	delete_proj_and_die


a_ground_explode
	.long	FLOORXPD1
	.long	FLOORXPD2
	.long	FLOORXPD3
	.long	FLOORXPD4
	.long	FLOORXPD5
	.long	FLOORXPD6
	.long	FLOORXPD7
	.long	FLOORXPD8
	.long	FLOORXPD9
	.long	FLOORXPD10
	.long	FLOORXPD11
	.long	FLOORXPD12
	.long	FLOORXPD13
	.long	FLOORXPD14
	.long	FLOORXPD15
	.long	FLOORXPD16
	.long	FLOORXPD17
	.long	FLOORXPD18
	.long	FLOORXPD19
	.long	FLOORXPD20
	.long	FLOORXPD21
	.long	0

FLOORXPD1
	.long	FLOORXPD1A,0
FLOORXPD2
	.long	FLOORXPD2A,0
FLOORXPD3
	.long	FLOORXPD3A,0
FLOORXPD4
	.long	FLOORXPD4A,0
FLOORXPD5
	.long	FLOORXPD5A,0
FLOORXPD6
	.long	FLOORXPD6A,0
FLOORXPD7
	.long	FLOORXPD7A,0
FLOORXPD8
	.long	FLOORXPD8A,0
FLOORXPD9
	.long	FLOORXPD9A,0
FLOORXPD10
	.long	FLOORXPD10A,0
FLOORXPD11
	.long	FLOORXPD11A,FLOORXPD11B,FLOORXPD11C,0
FLOORXPD12
	.long	FLOORXPD12A,FLOORXPD12B,0
FLOORXPD13
	.long	FLOORXPD13A,FLOORXPD13B,0
FLOORXPD14
	.long	FLOORXPD14A,FLOORXPD14B,0
FLOORXPD15
	.long	FLOORXPD15A,FLOORXPD15B,FLOORXPD15C,0
FLOORXPD16
	.long	FLOORXPD16A,FLOORXPD16B,FLOORXPD16C,0
FLOORXPD17
	.long	FLOORXPD17A,FLOORXPD17B,FLOORXPD17C,FLOORXPD17D,0
FLOORXPD18
	.long	FLOORXPD18A,FLOORXPD18B,0
FLOORXPD19
	.long	FLOORXPD19A,FLOORXPD19B,0
FLOORXPD20
	.long	FLOORXPD20A,FLOORXPD20B,0
FLOORXPD21
	.long	FLOORXPD21A,FLOORXPD21B,0

;**************************************************************************

robo_tele_implode
	movi	>0e,a0
	calla	ochar_sound

	move	a8,a10				; a10 = robo obj
	callr	get_explode_obj
	calla	find_part2			; part 2 = implode
	movk	2,a0
	jruc	rplode3

robo_tele_explode
	move	a8,a10				; a10 = robo obj
	movi	>00080008,a11
	calla	shake_a11
	movi	>0d,a0
	calla	ochar_sound
	callr	get_explode_obj
	movk	4,a0
rplode3	jsrp	mframew				; blam !!
	jauc	delete_proj_and_die


get_explode_obj
	movi	pid_explode,a0
	move	a0,*a13(procid),w
	movi	a_dave_explode,a9
	calla	gmo_proc
	move	a0,*a8(oplink),l

	calla	a8_back_minus_1			; behind.....

	move	a8,a11
	move	a8,a0
	move	a10,a8
	calla	match_ani_points
	move	a11,a8
	movi	>00,a0
	movi	>30,a1
	calla	multi_adjust_xy			; lineup properly
	jauc	insobja8

;**************************************************************************

robo_dizzy_bolts
	movi	pid_bolt,a0
	move	a0,*a13(procid),w

	move	a8,a10			; a10 = robo
	movk	6,a11
rdb4	create	pid_bolt,one_dizzy_bolt
	move	*a13(p_store1),*a0(p_store1),l
	dsjs	a11,rdb4

	move	a10,a8

rdb5	movi	3,a0
	movi	>0f,a1
	calla	randu_minimum
	calla	ochar_sound		; spark sound

	movi	10,a0
	movk	18,a1
	calla	randu_minimum		; random spacing
	calla	prcslp

	callr	is_robo_still_dizzy
	jrnc	robo_dizzy_abort
	jruc	rdb5


one_dizzy_bolt
	movk	30,a0
	calla	randu
	calla	prcslp			; random wait

	callr	is_robo_still_dizzy
	jrnc	robo_dizzy_abort

	move	*a8(ochar),a7,w
	movk	2,a9
	calla	get_char_ani2
	move	*a9,a5,l
	calla	gso_dmawnz		; create obj for bolt

	movi	oid_bolt,a0
	move	a0,*a8(oid),w

	move	a7,*a8(ochar),w		; robo ochar for animations
	calla	a8_front_plus_1
	calla	insobja8

bolt_loop
	move	a11,a7
	dec	a7
	sll	5,a7
	addi	bolt_offsets,a7

	move	a8,a0
	move	a10,a1
	calla	lineup_1pwm		; lineup with robo

	move	*a7+,a0,w
	move	*a7,a1,w
	calla	multi_adjust_xy		; offset

	movk	2,a9
	calla	get_char_ani2		; bolt ani

	movk	4,a0
	calla	randu
	addk	2,a0
	jsrp	framew			; single obj ani

	movi	>f00,a0
	move	a0,*a8(oypos),w		; offscreen

	movk	30,a0
	calla	randu
	addi	>10,a0
	calla	prcslp

	move	*a13(p_store1),a0,l
	move	*a0(pwake),a0,l
	cmpi	dizzy_wake,a0
	jreq	bolt_loop    		; still dizzy = continue

	move	a8,a0	
	calla	delobjp			; delete the bolt object !!
	jruc	l_die

bolt_offsets
	.word	0,>20
	.word	0,>40
	.word	->0d,>70
	.word	->10,>90
	.word	->08,>60
	.word	>10,>60


robo_dizzy_abort
	movi	pid_bolt,a0
	calla	dallprc
	movi	oid_bolt,a0
	calla	dallobj
	jruc	l_die


is_robo_still_dizzy
	move	*a13(p_store1),a0,l
	move	*a0(pwake),a7,l
	cmpi	dizzy_wake,a7
	jreq	q_yes
	clrc
	rets
q_yes	setc
	rets

;**************************************************************************

scream_shaker
	movk	6,a11			; amount we shake
sshake3	move	@worldtly+16,a6,w
	sub	a11,a6
	move	a6,@worldtly+16,w
	neg	a11			; next time the other way...
	sleep	3
	move	*a10(pwake),a7,l
	cmpi	scream_wake,a7
	jreq	sshake3
	jruc	l_die

;**************************************************************************

lineup_explode
	mmtm	sp,a10,a11			; save coordinate adjust
;	movk	6,a0
;	calla	ochar_sound
	movi	pid_explode,a0
	move	a0,*a13(procid),w
	movi	a_dave_explode,a9
	calla	gmo_proc
	move	a0,*a8(oplink),l
	calla	a8_front_plus_1
	mmfm	sp,a10,a11
*
* a10 = starting y:x
* a11 = adjust y:x
*
	move	a10,a4
	calla	set_xy_coordinates
	move	a11,a0
	sext	a0,w
	move	a11,a1
	sra	16,a1
	calla	multi_adjust_xy			; and adjust to correct spot
	calla	insobja8

	movk	4,a0
	jsrp	mframew				; blam !!
	jauc	delete_proj_and_die


dave_explode
;	movk	6,a0
;	calla	ochar_sound

	movi	pid_explode,a0
	move	a0,*a13(procid),w

	movi	a_dave_explode,a9
	calla	gmo_proc
	move	a0,*a8(oplink),l

	movi	front_z+1,a0
	move	a0,*a8(ozval),l			; in front of players
	move	a10,*a8(oxpos),w
	move	a11,*a8(oypos),w
	calla	insobja8

	movk	4,a0
	jsrp	mframew				; blam !!
	jauc	delete_proj_and_die


a_dave_explode
	.long	BIGXPLOD1
	.long	BIGXPLOD2
	.long	BIGXPLOD3
	.long	BIGXPLOD4
	.long	BIGXPLOD5
	.long	BIGXPLOD6
	.long	BIGXPLOD7
	.long	BIGXPLOD8
	.long	BIGXPLOD9
	.long	BIGXPLOD10
	.long	BIGXPLOD11
	.long	BIGXPLOD12
	.long	BIGXPLOD13
	.long	BIGXPLOD14
	.long	BIGXPLOD15
	.long	BIGXPLOD16
	.long	0

	.long	BIGXPLOD16
	.long	BIGXPLOD15
	.long	BIGXPLOD14
	.long	BIGXPLOD13
	.long	BIGXPLOD12
	.long	BIGXPLOD11
	.long	BIGXPLOD10
	.long	BIGXPLOD9
	.long	BIGXPLOD8
	.long	BIGXPLOD7
	.long	BIGXPLOD6
	.long	BIGXPLOD5
	.long	BIGXPLOD4
	.long	BIGXPLOD3
	.long	BIGXPLOD2
	.long	BIGXPLOD1
	.long	0

BIGXPLOD1
	.long	BIGXPLOD1A,0
BIGXPLOD2
	.long	BIGXPLOD2A,0
BIGXPLOD3
	.long	BIGXPLOD3A,0
BIGXPLOD4
	.long	BIGXPLOD4A,0
BIGXPLOD5
	.long	BIGXPLOD5A,0
BIGXPLOD6
	.long	BIGXPLOD6A,0
BIGXPLOD7
	.long	BIGXPLOD7A,0
BIGXPLOD8
	.long	BIGXPLOD8A,0
BIGXPLOD9
	.long	BIGXPLOD9A,0
BIGXPLOD10
	.long	BIGXPLOD10A,BIGXPLOD10B,0
BIGXPLOD11
	.long	BIGXPLOD11A,BIGXPLOD11B,0
BIGXPLOD12
	.long	BIGXPLOD12A,BIGXPLOD12B,0
BIGXPLOD13
	.long	BIGXPLOD13A,BIGXPLOD13B,0
BIGXPLOD14
	.long	BIGXPLOD14A,BIGXPLOD14B,0
BIGXPLOD15
	.long	BIGXPLOD15A,BIGXPLOD15B,0
BIGXPLOD16
	.long	BIGXPLOD16A,BIGXPLOD16B,0

a_small_explode
	.long	SMALLXPD1
	.long	SMALLXPD2
	.long	SMALLXPD3
	.long	SMALLXPD4
	.long	SMALLXPD5
	.long	SMALLXPD6
	.long	SMALLXPD7
	.long	SMALLXPD8
	.long	SMALLXPD9
	.long	SMALLXPD10
	.long	SMALLXPD11
	.long	SMALLXPD12
	.long	SMALLXPD13
	.long	SMALLXPD14
	.long	SMALLXPD15
	.long	0

;**************************************************************************
jax_zap_puff
	movi	front_z+1,a6
	callr	puff_init
	movi	>30,a0
	movi	>40,a1
	calla	multi_adjust_xy		; lineup with flame of jax zap
	jruc	puff_ani

rocket_puff
	clr	a6			; z val for smoke puff
	callr	puff_init
	sll	5,a11
	addi	puff_placements,a11
	move	*a11+,a0,w		; x
	move	*a11+,a1,w		; y
	calla	multi_adjust_xy		; lineup with flame of rocket

puff_ani	calla	insobja8
	movi	a_puff,a9
	movk	4,a0
	jsrp	framew
	move	a8,a0
	calla	delobjp
	jruc	l_die

puff_init
	movi	pid_1_puff,a0
	move	a0,*a13(procid),w
	move	a8,a10			; a10 = rocket to follow
	movi	PUFF1,a5
	calla	gso_dmawnz
	move	a6,*a8(ozval),l		; behind players
	move	a8,a0
	move	a10,a1
	jauc	lineup_1pwm


puff_placements
	.word	>00,>18		; 12
	.word	->08,>10 	; 1
	.word	->10,>08 	; 2
	.word	->18,>00	; 3
	.word	>00,->18	; 6
	.word	->08,->10	; 5
	.word	->10,->08	; 4
	.word	->18,>00	; 3
	.word	>00,00


a_puff	.long	PUFF1
	.long	PUFF2
	.long	PUFF3
	.long	PUFF4
	.long	PUFF5
	.long	0

;**************************************************************************

floor_explode
	tsound	>00			; explode through floor sound
	tsound	>01			; explode through floor sound

	movi	pid_shaker,a0
	movi	blast_shaker,a7
	calla	create_and_kill

	movi	ge_floor,a11		; gravity explode table
	jsrp	gravity_explode
	die

ge_floor
	.word	10		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	SMALL01		; starting image
	.long	a_small_rock	; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>d00		; y vel range   (sll 8)
	.word	>600		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	0		; land routine

	.word	12		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	MEDIUM01	; starting image
	.long	a_med_rock	; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>100		; x vel minimum (sll 8)
	.word	>600		; y vel range   (sll 8)
	.word	>400		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	1		; land routine

	.word	3		; how many pieces
	.word	0,>20		; x:y coordinate offset of dude
	.word	>4000		; gravity
	.long	LARGE01		; starting image
	.long	a_large_rock	; animation table
	.word	>201		; x vel range   (sll 8)
	.word	>00		; x vel minimum (sll 8)
	.word	>c00		; y vel range   (sll 8)
	.word	>600		; y vel minimum (sll 8)
	.word	3		; animation speed
	.word	2		; land routine

	.word	0		; end of the road

;************************************************************************

gravity_explode
	move	*a11+,a10,w		; a10 = loop count
	jreq	gex9

	move	*a11+,a0,w
	move	*a9(oxpos),a2,w
	add	a0,a2		   	; x coordinate offset
	move	*a11+,a0,w
	move	*a9(oypos),a3,w
	add	a0,a3		   	; y coordinate offset

	move	*a11+,a7,w		; a7 = gravity
	zext	a7,w
gex3	move	*a11,a5,l		; a5 = starting image
	move	*a11(32),a6,l		; animation to use
	clr	b0
	callr	spawn_1_piece

	move	*a11(32+32),a0,w	; x vel range
	btst	0,a0			; do a flipped also ?
	jreq	gex5			; no.
	movk	1,b0
	callr	spawn_1_piece		; yes

gex5	dsj	a10,gex3
	addi	16*10,a11		; a11 ---> next entry
	jruc	gravity_explode

gex9	retp


*
* b0 = flip x flag
*
spawn_1_piece
	calla	gso_dmawnz		; get object for image

	move	*a11(32+32),a0,w	; x vel range
	move	*a11(32+32+16),a1,w	; x vel minimum
	andni	1,a0			; rid of "do a flipped also" flag
	sll	8,a0
	sll	8,a1			; shift o rama
	calla	randu
	add	a1,a0
	move	b0,b0			; flip x vel ?
	jreq	spawn2			; no
	neg	a0			; yes
spawn2	move	a0,*a8(oxvel),l

	move	*a11(64+32),a0,w	; y vel range
	move	*a11(64+48),a1,w	; y vel minimum
	sll	8,a0
	sll	8,a1	  		; shift o rama
	calla	randu
	add	a1,a0
	neg	a0	  		; y = upwards
	move	a0,*a8(oyvel),l

	move	a2,*a8(oxpos),w
	move	a3,*a8(oypos),w		; set starting coordinates

	push	a7
	create	pid_gravp,gravity_piece
	pull	a7

	move	*a11(16*9),a1,w
	move	a1,*a0(p_store1),w	; land routine

	move	a6,*a0(pa9),l		; pass animation
	move	*a11(16*8),a1,w
	move	a1,*a0(pa10),w		; pass animation speed
	move	a7,*a0(pa11),l		; gravity

	calla	insobja8
	rets

**************************************************************************
*											     *
*  gravity_piece										     *
* 											     *
*  Generic proc to control an exploding gravity piece given:		     *
* 											     *
*   a8 = object										     *
*   a9 = animation									     *
*  a10 = animation speed									     *
*  a11 = gravity											*
*											     *
**************************************************************************
gravity_piece
	move	@ground_y,a0,w
	move	a0,*a13(p_ganiy),w	; set our ground
	move	a10,a0	
	calla	init_anirate
	jsrp	gravity_a11

;	calla	stop_a8

do_land_routine
	move	*a13(p_store1),a0,w
	sll	5,a0
	addi	land_routines,a0
	move	*a0,a0,l
	jump	a0


gravity_a11_yvel
	move	a0,*a8(oyvel),l

gravity_a11
	sleep	1
	calla	next_anirate
	move	*a8(oyvel),a0,l
	add	a11,a0
	move	a0,*a8(oyvel),l		; simulate gravity
	jrn	gravity_a11		; heading up ---> dont check ground
	calla	hit_ground_yet
	jrnc	gravity_a11
	retp


blast_shaker
	movk	10,a10
	movk	6,a11
bshk3	move	@worldtly+16,a6,w
	sub	a11,a6
	move	a6,@worldtly+16,w
	move	@worldtly_t+16,a6,w
	sub	a11,a6
	move	a6,@worldtly_t+16,w		; shake BOTH y variables
	sleep	3
	neg	a11
	dsj	a10,bshk3
	die

**************************************************************************

land_routines
	.long	land_small_rock		; 0
	.long	land_med_rock		; 1
	.long	land_large_rock		; 2
	.long	land_body_part		; 3
	.long	land_pit_bottom		; 4
	.long	land_subway_rock	; 5


land_pit_bottom
	calla	stop_a8

	movi	>18000,a0
	move	a0,*a8(oyvel),l		; moving downwards

	movk	4,a0
	movk	3,a1
	movk	4,a2
	jsrp	shake_a8_up

	move	a8,a0
	calla	delobjp			; off the list
	die


land_large_rock
	movi	>40000,a0
	movi	>40000,a1
	jsrp	rock_bounce
*
* split in 3
*
	move	a8,a10	      	; a10 = large rock
	callr	spit_in_half
	callr	spit_in_half
	move	a10,a8

split_bounce
	movi	>40000,a0
	movi	>40000,a1
	jsrp	rock_bounce
	jruc	rock_crumble	; split in 2 !!


spit_in_half
	movi	MEDIUM01,a5
	calla	gso_dmawnz
	move	*a10(oxpos),*a8(oxpos),w
	move	*a10(oypos),*a8(oypos),w
	calla	insobja8
	movi	a_med_rock,a9
	create	pid_rock,split_bounce
	move	*a13(p_ganiy),*a0(p_ganiy),w
	rets


land_subway_rock
	movi	>20000,a0
	movi	>20000,a1
	jsrp	rock_bounce_nosound

	calla	stop_a8
	movi	a_crumple,a9
	movk	3,a0
	jsrp	framew			; crumple to nothing
	move	a8,a0
	calla	delobjp			; off the list
	die


land_med_rock
land_small_rock
	movi	>40000,a0
	movi	>40000,a1
	jsrp	rock_bounce

med_rock_bounce
	movi	>30000,a0
	movi	>30000,a1
	jsrp	rock_bounce

rock_crumble
	calla	stop_a8
	calla	rsnd_rocks
	movi	a_crumple,a9
	movk	3,a0
	jsrp	framew			; crumple to nothing
	move	a8,a0
	calla	delobjp			; off the list
	die


rock_bounce
	mmtm	sp,a0,a1
	calla	rsnd_rocks
	mmfm	sp,a0,a1

rock_bounce_nosound
	calla	randu_minimum		; a0 = random #
	neg	a0
	move	a0,a1			; a1 = y vel

	movi	dont_touch,a0		; x vel
	movi	>4000,a2		; grav
	movk	2,a3			; ani speed
	jsrp	single_flight

	clr	a0
	move	a0,*a8(oyvel),l		; stop y only
;	calla	stop_a8
	retp


land_body_part
	calla	rsnd_splish

	movi	>40000,a0
	movi	>40000,a1
	calla	randu_minimum		; a0 = random #
	neg	a0
	move	a0,a1			; a1 = y vel

	movi	dont_touch,a0		; x vel
	movi	>4000,a2		; grav
	movk	2,a3			; ani speed
	jsrp	single_flight
	calla	stop_a8
	die


*
* a0 = x vel
* a1 = y vel
* a2 = gravity
* a3 = animation speed
* a9 = animation table
*
single_flight
	cmpi	dont_touch,a0
	jreq	sf3
	move	a0,*a8(oxvel),l
sf3	cmpi	dont_touch,a1
	jreq	sf4
	move	a1,*a8(oyvel),l
sf4	move	a3,a0
	calla	init_anirate
	move	a2,a11			; grav

	move	a9,a9
	jrn	sf5			; neg = all set
	calla	get_char_ani

sf5	move	*a8(oypos),a0,w
	move	*a8(osizey),a2,w
	move	*a13(p_ganiy),a1,w
	add	a2,a1
	cmp	a1,a0
	jrlt	sf6
	move	a1,*a8(oypos),w		; if underground = ground
sf6	jsrp	gravity_a11
	retp



a_small_rock
	.long	SMALL01
	.long	SMALL02
	.long	SMALL03
	.long	SMALL04
	.long	SMALL05
	.long	SMALL06
a_small_rock2
	.long	SMALL07
	.long	SMALL08
	.long	SMALL09
	.long	SMALL10
	.long	SMALL11
	.long	SMALL12
	.long	ani_jump,a_small_rock

a_med_rock
	.long	MEDIUM01
	.long	MEDIUM02
	.long	MEDIUM03
	.long	MEDIUM04
	.long	MEDIUM05
	.long	MEDIUM06
	.long	MEDIUM07
	.long	MEDIUM08
	.long	MEDIUM09
	.long	MEDIUM10
	.long	MEDIUM11
	.long	MEDIUM12
	.long	ani_jump,a_med_rock

a_large_rock
	.long	LARGE01
	.long	LARGE02
	.long	LARGE03
	.long	LARGE04
	.long	LARGE05
	.long	LARGE06
	.long	LARGE07
	.long	LARGE08
	.long	LARGE09
	.long	LARGE10
	.long	LARGE11
	.long	LARGE12
	.long	ani_jump,a_large_rock

a_crumple
	.long	XPLODE01
	.long	XPLODE02
	.long	XPLODE03
	.long	XPLODE04
	.long	XPLODE05
	.long	XPLODE06
	.long	XPLODE07
	.long	XPLODE08
	.long	XPLODE09
	.long	XPLODE10
	.long	XPLODE11
	.long	XPLODE12
	.long	0

**************************************************************************
*											     *
*  trail_proc - process to make a trail of images of a dude		     *
* 	       for superkick								     *
* 											     *
*  input: a8 = dude/multipart object to follow					     *
*											     *
**************************************************************************
trail_proc
	move	a8,a11

	callr	get_trail_pid
	move	a1,a0
	clr	a1
	not	a1				; rev2.1 change
	calla	dallprc				; only 1 trail proc
	callr	get_trail_pid
	move	a1,*a13(procid),w		; and thats me..

	callr	get_shadow_oid
	move	a1,a0
	clr	a1
	not	a1
	calla	dallobj				; kill previous shadows !!

	clr	a0
	move	a0,*a13(p_store1),l
	move	@ofree,a8,l
	move	a8,*a13(p_store2),l		; save 1st object
	clr	a7				; no previous object yet
				    	
;	movk	7,a0
	movk	8,a0

trail5	move	a0,*a13(p_anirate),w		; max number of shadow dudes

	move	*a11(ochar),a0,w
	move	a11,a8
	clr	a9
	calla	get_char_ani
	move	*a9,a5,l			; a5 = frame #1

	push	a7
	calla	get_jc_pid
	movi	shadow_dummy_proc,a7
	calla	getprc				; grab a process for ram
	move	a0,a6
	addi	pdata,a6  			; a6 = multipart ram starts here !!
	movk	1,a7				; a7 = palette flag
	calla	get_multi_obj

	callr	get_shadow_oid
	move	a1,*a8(oid),w			; rev2.1 change

	move	*a11(oshape),a0,l
	calla	ani2				; same shape as cage

	push	a8
	move	a8,a0
	move	a11,a8
	calla	match_ani_points		; lineup with cage
	pull	a8
	pull	a7

	move	a7,a7				; do we have a previous ?
	jreq	trail6				; no
	move	a8,*a7(oplink),l		; yes, link to previous object

trail6	movi	ind_shadow_p,a0
	move	*a11(ochar),a1,w
	cmpi	ft_sk,a1
	jrne	trail4
	movi	sk_shadow_p,a0
trail4	calla	swpal

	move	*a13(p_store1),a0,l
	inc	a0
	move	a0,*a13(p_store1),l
	move	a0,*a8(ozval),l

	calla	insobja8

	sleep	3
	move	a8,a7			; a7 = previous shadow object
	move	*a11(oxvel),a0,l
	jreq	trail7			; stopped moving ---> no moe trail

	move	*a13(p_anirate),a0,w
	dec	a0
	jrne	trail5			; limit the # of shadows
	clr	a0
	move	a0,*a8(oplink),l	; zero the last one
*
* erase trail
*
trail7	move	*a13(p_store2),a8,l	; save 1st object
trail8	move	*a8(oplink),a10,l	; grab next one !!
	move	a8,a0
	calla	delobjp
	sleep	2
	move	a10,a8
	jrne	trail8

	callr	get_jc_pid
	move	a1,a0
	calla	dallprc			; rid of procs too
	die

get_jc_pid
	movi	pid_shadow1,a1
	move	*a11(oid),a0,w
	cmpi	oid_p1,a0
	jreq	getjc4
	movi	pid_shadow2,a1
getjc4	rets


get_trail_pid
	movi	pid_trail1,a1
	move	*a11(oid),a0,w
	cmpi	oid_p1,a0
	jreq	gettr4
	movi	pid_trail2,a1
gettr4	rets


get_shadow_oid
	movi	oid_shadow1,a1
	move	*a11(oid),a0,w
	cmpi	oid_p1,a0
	jreq	getsh4
	movi	oid_shadow2,a1
getsh4	rets

;***************************************************************************

shadow_dummy_proc
	sleep	>80
	die

ind_shadow_p
   .word   64 
   .word   00000h,00080h,000c0h,00100h,00120h,00120h,00140h,00160h
   .word   00180h,001a0h,001c2h,001e2h,00204h,00224h,00226h,00248h
   .word   0028ah,002ach,002cch,000c0h,000a0h,000e0h,000c0h,00100h
   .word   000e0h,000e0h,00100h,00120h,000e0h,00100h,00120h,00160h
   .word   00560h,00980h,00d80h,00940h,011a0h,015a0h,015c0h,015e0h
   .word   01e00h,02220h,02a40h,02e40h,03280h,036a0h,03ac0h,02ee0h
   .word   04300h,04720h,04764h,047e9h,00460h,02060h,04480h,00060h
   .word   000e0h,00120h,00180h,001e0h,00a60h,01f02h,033a7h,047ech

sk_shadow_p
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07fffh,07fffh,077bfh,06f7fh,0673fh,05effh,05adfh,04e7fh
   .word   0463fh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh
   .word   07f3fh,07fffh,07fffh,07fffh,07fffh,07fffh,07fffh,07fdfh
   .word   07fbfh,07fbfh,07fffh,07f9fh,07fbfh,07ebfh,07f3fh,07f5fh
   .word   07f9fh,07e1fh,07f3fh,07f7fh,07e9fh,07a1fh,07abfh,0771fh
   .word   0773fh,076ffh,0765fh,0775fh,0721fh,072dfh,06effh,06ebfh
   .word   06adfh,06a3fh,066bfh,0621fh,05e9fh,0563fh,04e1fh,041ffh

;*************************************************************************


sonya_proj_globs
	movk	8,a5
sglob1	create	pid_blood,glob_away
	dsjs	a5,sglob1

	movk	8,a5
sglob3	create	pid_blood,glob_toward
	dsjs	a5,sglob3
	die

glob_toward
	callr	get_glob_and_vel
	move	*a8(oxvel),a0,l
	neg	a0
	move	a0,*a8(oxvel),l		; the other way dummy

	movi	>3000,a0
	calla	randu
	addi	>6000,a0
	move	a0,a10			; gravity
	movk	8,a0
	jruc	glob_fly

get_glob_and_vel
	movi	>60000,a0		; x velocity range
	movi	>20000,a1		; x velocity add
	movi	>80000,a2		; y velocity range
	movi	>50000,a3		; y velocity add
	jruc	get_glob_obj


glob_away
	callr	get_glob_and_vel

	movi	>3000,a0
	calla	randu
	addi	>6000,a0
	move	a0,a10			; gravity
	movk	8,a0

glob_fly
	movi	m_fliph,a4,w		; assume we want it flipped !!
	move	*a8(oxvel),a7,l
	jrp	gfly1
	clr	a4

gfly1	move	*a8(oflags),a5,w
	andi	m_fliph,a5
	cmp	a0,a5
	jrne	gfly2

	mmtm	sp,a0,a1,a6,a9,a10
	calla	flip_single		; point the correct direction
	mmfm	sp,a0,a1,a6,a9,a10

gfly2	clr	a6
	jsrp	gravity_ani
	movi	>24,a9
	movk	4,a14
	calla	find_ani_part_a14
	movk	4,a0
	jsrp	framew 			; splash on ground
	move	a8,a0
	calla	delobjp
	die


get_glob_obj	
	mmtm	sp,a0,a1,a2,a3
	move	a8,a10
	movi	>24,a9
	movk	3,a14
	calla	find_ani_part_a14
	move	*a9,a5,l
	calla	gso_dmawnz
	move	*a10(ochar),*a8(ochar),w  	; pass sonya ochar
	addi	32,a9
	
	move	a8,a0
	move	a10,a1
	calla	lineup_1pwm
	movi	>80,a0
	movi	>40,a1
	calla	multi_adjust_xy
	calla	insobja8

	mmfm	sp,a0,a1,a2,a3
	calla	randu
	add	a1,a0
	calla	set_proj_vel		; x velocity

	move	@ground_y,a0,w
	move	a0,*a13(p_ganiy),w	; set the ground level

	move	a2,a0
	calla	randu
	add	a3,a0
	neg	a0
	move	a0,a1			; initial y vel
	rets

**************************************************************************
*											     *
*  freeze_blast - about object in A8							     *
*											     *
**************************************************************************
freeze_blast
	movi	pid_fblast,a0
	move	a0,*a13(procid),w

	calla	highest_mpart
	calla	lowest_mpart
	calla	leftmost_mpart
	calla	rightmost_mpart		; grab dimensions of decoy obj

	sub	a0,a1
	abs	a1
	srl	1,a1
	add	a1,a0
	sub	a2,a3
	abs	a3
	srl	1,a3
	add	a3,a2			; a0:a2 = center of dude
	mmtm	sp,a0,a2

	move	a8,a11			; a11 = decoy obj

	move	*a8(ochar),a6,w		; save ochar
	movi	ft_subzero,a0
	move	a0,*a8(ochar),w		; animations found in subzero tables
	movk	1,a9
	calla	get_char_ani2
	move	a6,*a8(ochar),w		; restore ochar

	calla	gmo_proc
	move	a0,*a8(oplink),l
	movi	ft_subzero,a0
	move	a0,*a8(ochar),w		; animations found in subzero tables

	mmfm	sp,a0,a2
	move	a0,*a8(oypos),w
	move	a2,*a8(oxpos),w		; center the blast on the decoy obj
	movi	front_z+2,a0
	move	a0,*a8(ozpos),w		; in front of players
	calla	insobja8		; on the list !

	movk	1,a9
	calla	get_char_ani2
	movk	3,a0
	jsrp	mframew			; blam !!
	jauc	delete_proj_and_die

white_flash_proc
	jsrp	white_flash
	die

white_flash
	move	@irqskye,a9,w		; save original background color
	movi	>ffff,a0
	move	a0,@irqskye,w		; white
	calla	display_off
	sleep	6
	move	a9,@irqskye,w		; original background color
	calla	display_on
	retp

**************************************************************************
*											     *
*  shake_a11 - shake the earth according to					     *
* 											     *
*  a11 = [ # of pixels , # of shakes ]						     *
*											     *
**************************************************************************
shake_a11
	push	a10
	move	a11,a10
	srl	16,a11		; a11 = # of pixels
	sll	16,a10
	srl	16,a10

	movi	pid_shaker,a0
	movi	es_sub,a7
	calla	create_and_kill
	pull	a10
	rets

es_sub	move	@worldtly+16,a6,w
	sub	a11,a6
	move	a6,@worldtly+16,w
	sleep	3	       	; hey, check out the fault !!!
	neg	a11
	dsjs	a10,es_sub
l_die	die

;*************************************************************************

blood_explode
	move	a8,a11				; save dude to follow
	movi	a_blood_explode,a9
	calla	gmo_proc

	move	*a11(oxpos),a2,w
	move	*a11(oypos),a3,w
	move	a10,a0
	move	a10,a1
	zext	a0,w
	srl	16,a1
	add	a0,a2
	add	a1,a3
	move	a2,*a8(oxpos),w
	move	a3,*a8(oypos),w			; position the burst o blud !
	movi	100,a0
	move	a0,*a8(ozpos),w			; in front o players

	calla	insobja8

	movk	5,a0
	jsrp	mframew
	move	a8,a0
	calla	delobjp
	jruc	l_die

a_blood_explode
	.long	BLDXPD1
	.long	BLDXPD2
	.long	BLDXPD3
	.long	BLDXPD4
	.long	BLDXPD5
	.long	BLDXPD6
	.long	BLDXPD7
	.long	BLDXPD8
	.long	BLDXPD9
	.long	BLDXPD10
	.long	BLDXPD11
	.long	BLDXPD12
	.long	BLDXPD13
	.long	0

BLDXPD1
	.long	BLDXPD1A,BLDXPD1B,0
BLDXPD2
	.long	BLDXPD2A,BLDXPD2B,0
BLDXPD3
	.long	BLDXPD3A,BLDXPD3B,0
BLDXPD4
	.long	BLDXPD4A,BLDXPD4B,0
BLDXPD5
	.long	BLDXPD5A,BLDXPD5B,0
BLDXPD6
	.long	BLDXPD6A,BLDXPD6B,0
BLDXPD7
	.long	BLDXPD7A,BLDXPD7B,0
BLDXPD8
	.long	BLDXPD8A,BLDXPD8B,0
BLDXPD9
	.long	BLDXPD9A,BLDXPD9B,0
BLDXPD10
	.long	BLDXPD10A,BLDXPD10B,0
BLDXPD11
	.long	BLDXPD11A,BLDXPD11B,0
BLDXPD12
	.long	BLDXPD12A,BLDXPD12B,0
BLDXPD13
	.long	BLDXPD13A,BLDXPD13B,0

**************************************************************************
*											     *
*  danger_danger - print a little danger by the players power bar who is *
*                  trouble								     *
*											     *
**************************************************************************
danger_danger
	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jreq	l_die

	movi	DANGER,a5
	calla	gso_dmawnz_ns
	movi	pid_danger1,a7
	movi	>00270092,a4
	dec	a11
	jreq	ddd4
	movi	pid_danger2,a7
	movi	>002700d7,a4
ddd4 	move	a7,*a13(procid),w
	move	a7,*a8(oid),w

	calla	set_xy_coordinates
	calla	insobja8
	tsound	>71				; yes ---> warning sound !!

	movk	12,a10
ddd6	movi	->80,a1
	jsrp	danger_y_adjust
	movi	>80,a1
	jsrp	danger_y_adjust
	dsj	a10,ddd6
	move	a8,a0
	calla	delobjp
	die

danger_y_adjust
	move	*a8(oypos),a0,w
	add	a1,a0
	move	a0,*a8(oypos),w	
	sleep	6
	retp

;***************************************************************

 	.end
