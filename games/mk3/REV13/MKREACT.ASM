**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: Reactions 										*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	"mkreact.asm"
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


r_a10_offset
	sll	5,a10
	addi	a10_r_table,a10
	move	*a10,a10,l
	jump	a10

a10_r_table
	.long	r_post_shake
	.long	r_post_bike


reaction_table
	.long	r_hi_kick	; 0
	.long	r_lo_kick	; 1
	.long	r_hi_punch	; 2
	.long	r_lo_punch	; 3
	.long	r_sweep		; 4
	.long	r_duck_punch	; 5
	.long	r_duck_kickh	; 6 
	.long	r_duck_kickl	; 7
	.long	r_uppercut	; 8
	.long	r_elbow_knee   	; 9
	.long	r_flip_kick	; a
	.long	r_flip_punch	; b
	.long	r_roundhouse	; c
	.long	wait_forever	; d - keep this as wait_forever !!!!!!!
	.long	r_combo2_stab	; e
	.long	r_combo1_stab	; f
	.long	r_combo0	; 10
	.long	r_combo1	; 11
	.long	r_combo2	; 12
	.long	r_combo3	; 13
	.long	r_combo4	; 14
	.long	r_combo5	; 15
	.long	r_combo_klang	; 16
	.long	r_combo6	; 17
	.long	r_dummy		;
	.long	r_dummy		;
*
* Kano
*
	.long	r_kano_roll	; 1a
	.long	r_kano_zap	; 1b
	.long	r_kano_swipe	; 1c
*
* sonya
*
	.long	r_square	; 1d
	.long	r_sonya_zap	; 1e
	.long	r_dummy		; 1f
	.long	r_dummy		; 20
	.long	r_dummy		; 21
	.long	r_dummy		; 22
*
* Jax
*
	.long	r_jax_zap	; 23
	.long	r_jax_dash	; 24
	.long	r_dummy		; 25
	.long	r_dummy		; 26
	.long	r_dummy		; 27
*
* Night Wolf
*
	.long	r_ind_zap	; 28
	.long	r_ind_charge	; 29
	.long	r_axe_horz	; 2a
	.long	r_axe_up	; 2b
*
* Subzero
*
	.long	r_freeze	; 2c
	.long	r_slide		; 2d
	.long	r_dummy		; 2e
	.long	r_dummy		; 2f
*
* Swat guy (Kurtis Striker)
*
	.long	r_sw_zap	; 30
	.long	r_swat_bomb	; 31
	.long	r_zoom		; 32
	.long	r_stick_sweep	; 33
	.long	r_dummy		; 34
	.long	r_dummy		; 35
*
* Shao Kahn's Queen (Lia)
*
	.long	r_scream	; 36
	.long	r_lia_zap	; 37
	.long	r_dummy		; 38
	.long	r_dummy		; 39
	.long	r_dummy		; 3a
*
* Robo Ninjas
*
	.long	r_rocket	; 3b
	.long	r_net		; 3c
	.long	r_robo_tele	; 3d
	.long	r_robo_bomb	; 3e
	.long	r_spear		; 3f
	.long	r_dummy		; 40
	.long	r_dummy		; 41
	.long	r_dummy		; 42
	.long	r_dummy		; 43
	.long	r_dummy		; 44
*
* Kung Lao
*
	.long	r_hat		; 45
	.long	r_angle_kick	; 46
	.long	r_dummy		; 47
	.long	r_dummy		; 48
	.long	r_dummy		; 49
*
* Tusk
*
	.long	r_tusk_zap	; 4a
	.long	r_tusk_blur  	; 4b
	.long	r_tusk_elbow	; 4c
	.long	r_tusk_saw	; 4d
	.long	r_dummy
	.long	r_dummy
*
* Shang
*
	.long	r_summon	; 50
	.long	r_skull		; 51
	.long	r_dummy		; 52
	.long	r_dummy		; 53
	.long	r_dummy		; 54
*
* Liu Kang
*
	.long	r_lk_zap	; 55
	.long	r_bike_kicked	; 56
	.long	r_superkang	; 57
	.long	r_dummy		; 58
	.long	r_dummy		; 59
	.long	r_dummy		; 5a
*
* Sheeva
*
	.long	r_pounce	; 5b
	.long	r_sg_zap	; 5c
	.long	r_dummy		; 5d
	.long	r_dummy		; 5e
	.long	r_dummy		; 5f
*
* Motaro
*
	.long	r_boss_hit1	; 60
	.long	r_motaro_kick	; 61
*
* Shao Kahn
*
	.long	r_sk_punch	; 62
	.long	r_sk_hammer	; 63
	.long	r_sk_charge	; 64
	.long	r_sk_air_charge	; 65

**************************************************************************

r_dummy
	jauc	wait_forever

**************************************************************************

r_null_speared
	clr	a5
	clr	a6
	clr	a7
	callr	reaction_start
	movi	040000H,a0
	jauc	stumble_back_vel


r_spear	
	movi	act_spear,a0
	move	a0,*a13(p_hitby),w	; kludge this in so hit q is updated

	clr	a5
	clr	a6
	clr	a7
	callr	reaction_start
	movk	2,a0
	calla	group_sound		; wasted voice (rev2.1 change)

	movi	01fH,a0
	calla	his_ochar_sound

;	movi	act_dizzy,a0
;	move	a0,*a13(p_action),w

rspear4	sleep	2
	move	*a13(p_otherproc),a11,l
	move	*a11(p_action),a0,w
	cmpi	act_rope_pull,a0	; still doing spear move ?
	jreq	rspear4			; yes, let him do his thang !!
	jruc	local_reaction_exit	; no, I'm free !!

**************************************************************************

r_tusk_saw
	clr	a6
	clr	a5
	clr	a7
	callr	reaction_start

	movk	9,a0
	calla	create_blood_proc

	movk	2,a0
	calla	group_sound 	 	; group speech: wasted

	movi	020H,a9
	calla	find_ani_part2		; stumble like krazy

	movi	00003000cH,a11
	calla	shake_a11
	movi	00004000dH,a0
	jsrp	animate_a0_frames
	jruc	local_reaction_exit

**************************************************************************

r_zoom
	movk	1,a6
	clr	a5
	clr	a7
	callr	reaction_start
	jruc	suspend_wait_action

r_zoom_flipped
	movi	-080000H,a0		; a0 = initial x vel
	movi	-060000H,a1   		; initial y vel
	movi	08000H,a2		; grav
	movk	4,a3			; a3 = ani speed
	jsrp	flight

	movi	zoom_damage,a10
	calla	damage_to_me
	jruc	land_on_my_back

**************************************************************************

r_slide
	movk	7,a6
	clr	a5
	clr	a7
	callr	reaction_start

	movk	5,a0
	calla	group_sound		; tripped voice
	movi	030000H,a0
	calla	away_x_vel       	; zoom !!
	movi	038000H,a0		; a0 = initial x vel
	movi	-060000H,a1   		; initial y vel
	movi	06000H,a2		; grav
	movk	4,a3			; a3 = ani speed
	clr	a6	     		; routine
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

**************************************************************************

r_pounce2
	movk	2,a0
	calla	group_sound 	 	; group speech: wasted

	movk	3,a11
pounce1	movi	01eH,a9
	calla	find_ani_part2
	move	a9,a10
	addi	32,a10			; toggle frame 2
	subi	32*2,a9			; toggle frame 1
	calla	do_next_a9_frame
	calla	ground_multi
	sleep	3
	calla	ground_ochar
	move	a10,a9
	calla	do_next_a9_frame
	sleep	3
	dsj	a11,pounce1
	jruc	pounce4


r_pounce
	movk	1,a6
	callr	if_shao_then_pass
	clr	a5
	clr	a7
	callr	reaction_start

	movi	act_pounced,a0
	move	a0,*a13(p_action),w

	movk	2,a0
	calla	group_sound 	 	; group speech: wasted
	
	movi	01eH,a9
	calla	get_char_ani
	movk	2,a0
	jsrp	mframew
	movk	2,a0
	jsrp	mframew
pounce4 

;************ ejbnew
	calla	get_his_action
	cmpi	act_sg_pounce,a1
	jrne	getup_reaction_exit		; no longer in pounce = exit
;************ ejbnew

	jsrp	suspend_wait_action_jsrp
	jruc	getup_reaction_exit

**************************************************************************

r_superkang
	movk	1,a6
	clr	a5
	clr	a7
	callr	reaction_start

	calla	rsnd_med_smack
	movk	2,a0
	calla	group_sound 	 	; group speech: wasted
	movi	000050005H,a11
	calla	shake_a11

	movi	060000H,a0	; a0 = initial x vel
	movi	-030000H,a1	; a1 = initial y vel
	movi	04000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

**************************************************************************

r_bike_kicked
	sleep	080H

r_bike_kicked_done
	calla	am_i_airborn
	jrnc	stumble_back
	clr	a0
	clr	a1
	movi	06000H,a2	; a2 = gravity
	movk	5,a3		; a3 = ani speed
	jruc	fall_on_my_back

**************************************************************************

r_net
	movk	1,a6		; motaro is too big for a dumb net !
	callr	if_shao_then_pass
	clr	a5
	clr	a7
	callr	reaction_start
	calla	dec_my_p_hit

	movk	8,a0
	calla	group_sound			; his shook sound

	calla	clear_noflip
	calla	set_no_block

	movi	act_caught_net,a0
	move	a0,*a13(p_action),w

	movi	020H,a9
	calla	find_ani_part2
	movk	4,a0
	calla	init_anirate		; ani speed

	movi	030000H,a11		; a11 = current vel
	movi	02000H,a10		; amount to subtract from vel

	movi	050H,a0
nett4	move	a0,*a13(p_store1),w
	sub	a10,a11
	move	a11,a0
	calla	away_x_vel		; start off moving away
	jsrp	net_sleep

	move	*a13(p_store1),a0,w
	cmpi	028H,a0
	jrhi	nett3			; dont check distance so soon

	calla	get_x_dist
	cmpi	046H,a3
	jrlo	nett7			; close ---> stop

nett3	move	*a13(p_store1),a0,w
	dsj	a0,nett4
*
* still
*
nett7	calla	stop_me
	movi	020H,a10
nett5	jsrp	net_sleep
	dsjs	a10,nett5

	calla	am_i_airborn
	jrnc	local_reaction_exit

	clr	a0	 		; a0 = initial x vel
	clr	a1			; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land


net_sleep
	sleep	1
net_struggle
	calla	next_anirate
	retp

if_shao_then_pass
	move	*a8(ochar),a0,w
	cmpi	ft_sk,a0,w
	jrne	rnet4
	clr	a6     		; shao kahn netted = just like normal guys
rnet4	rets

**************************************************************************

r_scream
	clr	a6			; boss = react like a normal guy
	clr	a5
	clr	a7
	callr	reaction_start
	calla	set_no_block

	movi	act_screamed,a0
	move	a0,*a13(p_action),w

	calla	dec_my_p_hit		; scream does not = hit
	clr	a0
	move	a0,*a13(p_store1),w	; flag: not stopped yet
	calla	stop_me
	movi	020H,a9
	calla	pose_a9			; pose: stumble
*
* avoid getting caught behind SINDEL
*
	move	*a8(oxpos),a6,w		; a6 = my x
	move	*a13(p_otherguy),a5,l
	move	*a5(oxpos),a7,w		; a7 = his x
	move	*a5(oflags),a4,w
	btst	b_fliph,a4		; is she facing right ?
	jreq	scream0			; yes
	swap	a6,a7			; no swapo
scream0	cmp	a7,a6			; am I on the right ?????
	jrgt	scream1			; yes, things are ok

	move	*a8(oypos),a10,w
	move	a5,a1
	move	a8,a0
	calla	lineup_a0_onto_a1
	calla	flip_multi
	clr	a1
	movi	-020H,a0
	calla	multi_adjust_xy		; position in front of her
	move	a10,*a8(oypos),w

*
* shake to the ground !!
*
scream1	calla	am_i_airborn
	jrnc	scream2
	movi	010000H,a0
	move	a0,*a8(oyvel),l		; if airborn = head down
scream2	movk	4,a11
	movi	(040H*2)/3,a10
scream3	sleep	3

	calla	is_he_airborn
	jrc	scream_abort		; she jumped = I am outta here
	calla	get_his_action
	cmpi	act_screamed,a1
	jreq	scream_abort		; she screwed up !!

	move	*a8(oxpos),a0,w
	add	a11,a0
	move	a0,*a8(oxpos),w		; shakey's pizza
	neg	a11

	move	*a8(oypos),a0,w
	move	*a13(p_ganiy),a1,w
	cmp	a1,a0
	jrlt	scream5

	clr	a0
	move	a0,*a8(oyvel),l
	calla	ground_player		; ground him !!

	calla	get_x_dist
	cmpi	050H,a3
	jrhi	scream4			; close = stop moving closer to him

	movk	1,a0
	move	a0,*a13(p_store1),w	; flag: stopped !!!
	calla	stop_me
	jruc	scream5

scream4	move	*a13(p_store1),a0,w
	jrne	scream5			; already stopped ---> dont restart

	movi	020000H,a0
	calla	towards_x_vel

scream5	dsj	a10,scream3
	jruc	local_reaction_exit


scream_abort
	calla	stop_me
	calla	ground_player		; ground him !!
	jruc	local_reaction_exit


r_jax_dash
	clr	a5
	clr	a7
	movk	2,a6			; boss = stumble
	callr	reaction_start

	movk	2,a0
	calla	group_sound 	 	; group speech: wasted
	calla	rsnd_big_smack
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact

	move	a8,*a0(p_otherguy),l	; pass me along

	movi	080000H,a0		; a0 = initial x vel
	movi	-060000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land

**************************************************************************

r_axe_up
	movk	1,a0
	calla	create_blood_proc
	movk	9,a0
	calla	his_ochar_sound		; axe hit sound
	calla	set_half_damage

	movk	1,a6
	clr	a5
	movi	cc_ken_masters,a7
	callr	reaction_start

	movk	2,a0
	calla	group_sound  		; group speech: wasted

	movi	010000H,a0		; a0 = initial x vel
	movi	-080000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight

	jruc	reaction_land

**************************************************************************

r_summon
	clr	a5
	movk	1,a6
	clr	a7
	callr	reaction_start
	movk	2,a0
	calla	group_sound  		; group speech: wasted

	calla	face_opponent
	calla	flip_multi

	movi	-030000H,a0		; a0 = initial x vel
	movi	-090000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land

**************************************************************************

r_hi_kick
	movk	2,a0
	calla	create_blood_proc

	movk	2,a0
	calla	group_sound  	; group speech: wasted
	calla	rsnd_big_smack

	movk	1,a6
	movi	generic_airborn_hit,a5
	clr	a7
	callr	reaction_start

	movi	048000H,a0
	calla	away_x_vel		; head away from otherguy

	movi	01cH,a9
	calla	get_char_ani		; ani = hit hi
	calla	do_next_a9_frame
	sleep	2
	calla	do_next_a9_frame
	sleep	6
*
* damping loop
*
	movk	10,a10
kdamp3	sleep	1
	move	*a8(oxvel),a0,l
	abs	a0
	move	a0,a1
	sra	6,a1			; slow down
	sub	a1,a0
	calla	away_x_vel
	dsj	a10,kdamp3

	calla	stop_me			; stop !
	movi	01cH,a9
	calla	get_char_ani
	addi	32,a9			; head snapped way back frame !
	movk	4,a0
	jsrp	mframew
	jruc	local_reaction_exit

**************************************************************************

r_lo_kick
	calla	rsnd_body_hit
	calla	rsnd_react_voice

	movk	1,a6
	movi	generic_airborn_hit,a5
	clr	a7
	callr	reaction_start

	movi	040000H,a0
	calla	away_x_vel		; head away from otherguy

	movi	00004001dH,a9		; hit in chest
	calla	am_i_short
	jrnc	rlk3
	movi	000040007H,a9		; duck hit
rlk3	jsrp	animate_a9
	jruc	local_reaction_exit

;**************************************************************************

r_duck_punch
	movk	1,a6
	movi	r_duck_airpunch,a5
;	movi	generic_airborn_hit,a5
	movi	cc_ken_masters,a7
	callr	reaction_start

	calla	rsnd_smack
	calla	rsnd_react_voice

	movi	040000H,a0
	calla	away_x_vel		; head away from otherguy

	movi	00003001dH,a9		; ani = hit in chest
	calla	get_my_height
	cmpi	080H,a1			; was i ducking ?
	jrhi 	rdp5			; no
	movi	000030007H,a9

rdp5	jsrp	animate_a9		; yes ---> ani = duck hit
	calla	stop_me
	calla	am_i_joy
	janc	drone_post_duck_hit
	jruc	local_reaction_exit


r_duck_airpunch
	calla	rsnd_med_smack
	calla	rsnd_react_voice

	movk	3,a1			; a1 = # of hits to trigger it !!
	callr	avoid_corner_trap

	movi	038000H,a0		; a0 = initial x vel
	movi	-060000H,a1		; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

;**************************************************************************

r_duck_kickh
	movk	1,a6
	movi	generic_airborn_hit,a5
	movi	cc_ken_masters,a7
	callr	reaction_start

	calla	rsnd_smack
	calla	rsnd_react_voice

	movi	048000H,a0
	calla	away_x_vel		; head away from otherguy

	movi	00003001dH,a9		; ani = hit in chest
	calla	get_my_height
	cmpi	080H,a1			; was i ducking ?
	jrhi 	rdk5			; no
	movi	000030007H,a9

rdk5	jsrp	animate_a9		; yes ---> ani = duck hit
	calla	stop_me
	calla	am_i_joy
	janc	drone_post_duck_hit
	jruc	local_reaction_exit

;**************************************************************************

r_duck_kickl
	movk	1,a6
	movi	r_airborn_duck_kick,a5
	movi	cc_ken_masters,a7
	callr	reaction_start

	calla	rsnd_smack
	calla	rsnd_react_voice

	movi	030000H,a0
	calla	away_x_vel		; head away from otherguy

	movi	00003001dH,a9		; ani = hit in chest
	calla	get_my_height
	cmpi	080H,a1			; was i ducking ?
	jrhi 	rdk6			; no
	movi	000030007H,a9

rdk6	jsrp	animate_a9		; yes ---> ani = duck hit
	calla	stop_me
	calla	am_i_joy
	janc	drone_post_duck_hit
	jruc	local_reaction_exit

;**************************************************************************

r_robo_tele
	movk	2,a0
	calla	group_sound 	 	; group speech: wasted
	calla	rsnd_big_smack
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact

	movi	zero_turbo_bar,a0
	calla	calla_for_him		; no run jab / run jab / run jab

	movk	4,a6
	clr	a5
	clr	a7
	callr	reaction_start

	movi	act_robo_teled,a0
	move	a0,*a13(p_action),w

	movi	010000H,a0		; a0 = initial x vel
	movi	-0b0000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land


r_robo_bomb
	movk	1,a6
	clr	a5
	clr	a7
	callr	reaction_start

	movk	2,a0
	calla	group_sound  		; group speech: wasted
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact

	calla	face_opponent
	calla	flip_multi

	movi	-030000H,a0		; a0 = initial x vel
	movi	-0c0000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land


r_combo6
	calla	set_half_damage		; keep this within reason
	movk	4,a6			; 4 = boss stumble
	clr	a5
	movi	cc_ken_masters,a7
	callr	reaction_start

	movk	1,a0
	calla	create_blood_proc
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact
	calla	rsnd_big_smack
	movk	2,a0
	calla	group_sound	  	; group speech: wasted

	movi	00eH,a0
	calla	create_fx		; upcut comment
	movi	010000H,a0		; a0 = initial x vel
	movi	-0c0000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land




r_combo5
	calla	set_half_damage		; keep this within reason

r_uppercut
	movk	4,a6			; 4 = boss stumble
	clr	a5
	movi	cc_ken_masters,a7
	cmpi	0edb00H,a10		; almost "Ed Boon" ??
	jrne	rupc4
	clr	a7			; pit = no ken masters
rupc4	callr	reaction_start

	movk	1,a0
	calla	create_blood_proc
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact
	calla	rsnd_big_smack
	cmpi	0edb00H,a10		; almost "Ed Boon" ??
	jreq	background_death	; yes, then down the pit with u !!

pit_abort
	movk	2,a0
	calla	group_sound	  	; group speech: wasted

	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jreq	rup3			; amode = no blast
	calla	get_my_strength
	jreq	rup3			; zero power = no blast

	movi	pid_dark,a0
	clr	a1
	not	a1
	calla	existp
	jrne	rup3			; no blast in the dark

	movi	pid_switcheroo,a0
	clr	a1
	not	a1
	calla	existp
	jrne	rup3		; no blast during randper (Thanks Dave S.)

	move	@curback,a0,w
	jreq	blast_through_subway
	cmpi	2,a0
	jreq	blast_through_bank
	cmpi	6,a0
	jreq	blast_through_soul

rup3	movi	00eH,a0
	calla	create_fx		; upcut comment

	movi	020000H,a0		; a0 = initial x vel
	movi	-0c0000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land

;***************************************************

background_death
	movi	gs_pitfall,a0
	move	a0,@gstate,w		; new game state !!

	move	@curback,a0,w
	cmpi	00aH,a0
	jreq	fall_down_pit
	cmpi	007H,a0
	jreq	fall_down_bell_tower
	cmpi	000H,a0
	jreq	fall_on_trax
	jruc	pit_abort		; no other options = why are we here ?
	
;********************************************************************

one_floor	.set	01adH

fall_down_bell_tower
	move	a8,*a13(p_store7),l	; remember my name
	movk	9,a0
	calla	group_sound		; death scream !!!
	calla	clear_shadow_bit
	calla	center_around_me
	
	movi	00006000aH,a11
	calla	shake_a11

	movi	pid_repell,a0
	calla	dallprc

	movi	600,a3			; a3 = middle of world
	move	*a8(oxpos),a1,w
	sub	a1,a3			; a3 = distance we have to travel
	sll	16,a3
	movi	050H,a11			; a11 = ticks !!
	divs	a11,a3			; a3 = distance/time = speed

	move	a3,a0			; a0 = x vel
	movi	-0120000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	movi	bell_fall_scan,a6
	jsrp	flight_call
	calla	stop_a8			; this code never gets executed
	jauc	wait_forever		; Then why is it here stupid ??!!

bell_fall_scan
	calla	distance_off_ground
	cmpi	0e0H,a0
	jrlo	l_rets			; wait to get off screen

	pull	a0
	pull	a0
	calla	reset_proc_stack

	calla	stop_me
	movi	600,a0
	move	a0,*a8(oxpos),w
	move	*a8(oypos),a0,w
	sleep	050H			; let scroller katch up !

	movi	0c0000H,a0
	move	a0,*a8(oyvel),l		; speed up
	clr	a0
	move	a0,*a8(ograv),l		; no grav
	calla	set_x_vel
	
bfall3	sleep	1
	calla	distance_off_ground
	cmpi	010H,a0
	jrhi	bfall3

	movi	pid_backg,a0
	calla	dallprc
	movi	pid_scroll,a0
	calla	dallprc
	calla	stop_scrolling

;***********
;	movi	080H,a7
;	move	@worldtlx8+16,a6,w
;	clr	a3			; dont flip
;	callr	floor_piece
;	callr	broken_floor_a
;	callr	broken_floor_b
;	xori	1,a3			; reverse
;	callr	floor_piece
;*
;* make 1st broken floor piece !!
;*
;	move	@baklst7,a0,l
;	move	@baklst8,a1,l
;	move	a1,a2
;bfall31	move	a2,a3
;	move	*a2,a2,l		; find last obj on baklst8
;	jrne	bfall31
;	move	a0,*a3(olink),l		; link a7 onto a8
;	move	a1,@baklst7,l		; and stuff into a7 list
;	clr	a4
;	move	a4,@baklst8,l
;***********

*
* create intermediate floor on baklst8 !!
*
	move	@worldtlx,a0,l
	move	@worldtlx1,a1,l
	move	@worldtlx2,a2,l
	move	@worldtlx3,a3,l
	move	@worldtlx4,a4,l
	move	@worldtlx5,a5,l
	move	@worldtlx6,a6,l
	move	@worldtlx7,a7,l
	mmtm	sp,a0,a1,a2,a3,a4,a5,a6,a7,a8

	movi	bell2_mod,a0
	calla	init_bakmods 		; initialize
	move	@worldtly+16,a0,w
	subi	050H,a0
	move	a0,@worldtly+16,w
	calla	multi_plane
	move	@worldtly+16,a0,w
	addi	050H,a0
	move	a0,@worldtly+16,w

	mmfm	sp,a0,a1,a2,a3,a4,a5,a6,a7,a8
	move	a0,@worldtlx,l
	move	a1,@worldtlx1,l
	move	a2,@worldtlx2,l
	move	a3,@worldtlx3,l
	move	a4,@worldtlx4,l
	move	a5,@worldtlx5,l
	move	a6,@worldtlx6,l
	move	a7,@worldtlx7,l

	move	@baklst8,a0,l
	clr	a7   		  	; current lowest point
adj8	move	*a0(oypos),a1,w
	addi	one_floor,a1
	move	a1,*a0(oypos),w	  	; adjust back list 8 down town !!

	move	*a0(osizey),a2,w
	add	a2,a1
	cmp	a7,a1			; furthest down ?
	jrlt	adj81			; no
	move	a1,a7			; yes, new lowest point !
adj81	move	*a0,a0,l
	jrne	adj8
*
* tack on xtra pieces to bottom of floor
*
	move	@worldtlx8+16,a6,w
	clr	a3			; dont flip
	callr	floor_piece
	callr	broken_floor_a
	callr	broken_floor_b
	xori	1,a3			; reverse
	callr	floor_piece

	create	pid_fx,crash_fx
	move	*a13(p_store7),*a0(pa8),l	; remember my name

	movi	0c0000H,a0		; dont fall 2 fast !
	move	a0,@scrolly,l 		; pan down

wait_old_offscreen
	sleep	1
	move	@worldtly+16,a0,w
	cmpi	scrbot,a0
	jrlt	wait_old_offscreen 	; not offscreen yet

	move	*a13(p_store7),a8,l
	movi	clear_shadow_bit,a0
	calla	calla_for_him
*
* get rid of bell tower #1 images
*
	clr	a0
	move	a0,@f_skew,w		; no need for this floor BS
	movi	baklst1,a2
	calla	delolist
	movi	baklst2,a2
	calla	delolist
	movi	baklst3,a2
	calla	delolist
	movi	baklst4,a2
	calla	delolist
	movi	baklst5,a2
	calla	delolist
	movi	baklst6,a2
	calla	delolist
	movi	baklst7,a2
	calla	delolist   	    		; off you go !!
*
* make another copy of bell2 on list 7 !!
*
	move	@worldtly+16,a10,w		; save this spot !!
	move	@worldtlx8,@worldtlx7,l	; use the normal world x
	move	@baklst8,a8,l
	calla	getobj
	calla	copy_obj   		; from a8 to a0
	move	a0,@baklst7,l  		; 1st obj on list 7
	jruc	copy81
copy8	calla	getobj
	calla	copy_obj   		; from a8 to a0
	move	a0,*a9(olink),l
copy81	move	*a0(oypos),a2,w
	addi	one_floor,a2
	move	a2,*a0(oypos),w		; one screen below
	clr	a1
	move	a1,*a0(olink),l
	move	a0,a9			; a9 = previous #7
	move	*a8,a8,l		; next #8
	jrne	copy8

	jsrp	scroll_down_1_floor
	movi	baklst8,a2
	callr	baklst_down_2_floors
	jsrp	scroll_down_1_floor
	movi	baklst7,a2
	callr	baklst_down_2_floors
*
* speed up past the guy !!
*
	movi	0100000H,a0		; dont fall 2 fast !
	move	a0,@scrolly,l 		; pan down
	jsrp	scroll_down_1_floor
*
* fix broken pieces !!!
*
	move	@baklst7,a8,l
	callr	fix_broken_pieces
	move	@baklst8,a8,l
	callr	fix_broken_pieces

	movi	baklst8,a2
	callr	baklst_down_2_floors
	jsrp	scroll_down_1_floor
	movi	baklst7,a2
	callr	baklst_down_2_floors
	jsrp	scroll_down_1_floor

	movk	14,a10
	move	@worldtlx+16,a3,w

spike3	callr	make_a_spike
	clr	a0
	move	a0,*a8(ozpos),w
	callr	make_a_spike
	movi	100,a0
	move	a0,*a8(ozpos),w
	dsj	a10,spike3

	sleep	6
	clr	a0
	move	a0,@scrolly,l
	move	*a13(p_store7),a8,l	; remember my name

*
* fall till I meet my maker !!
*
falld3	sleep	1
	move	*a8(oypos),a0,w
	cmpi	0a40H,a0
	jrlt	falld3

	calla	rsnd_stab
	calla	death_scream		; cuz you know...that would hurt ALOT !
	movi	01eH,a9
	calla	find_ani_part2
	calla	do_next_a9_frame

	movi	0a0000H,a0
	move	a0,*a8(oyvel),l
falld4	sleep	1
	move	*a8(oyvel),a0,l
	sra	4,a0
	move	a0,*a8(oyvel),l		; fast dampin..
	cmpi	010000H,a0
	jrhi	falld4

	move	*a8(oypos),a0,w
	addi	0100H,a0
	move	a0,@ground_y,w		; place for blood 2 land
	movi	00aH,a0	
	calla	create_blood_proc

	sleep	10

	calla	death_blow_complete	; ok now its over !!
	calla	stop_a8
	jauc	wait_forever


make_a_spike
	movi	EJBSPIKE,a5
	calla	gso_dmawnz
	move	a3,*a8(oxpos),w
	movi	0a80H,a0
	move	a0,*a8(oypos),w
	addk	15,a3			  	; spike spacing
	calla	insobja8
	rets


fix_broken_pieces
	move	*a8(ozpos),a0,w
	cmpi	1000,a0
	jreq	fbp4
	move	*a8,a8,l
	jrne	fix_broken_pieces

fbp4	move	*a8,a7,l
	move	*a7,a7,l
	move	*a7(oypos),a7,w		; jump ahead 2 - grab this y !!
	move	@worldtlx8+16,a6,w
	clr	a3

fbp3	movi	BELLHOLE2,a1
	calla	ani_flag
	move	a3,a3
	jreq	fbp6
	calla	flip_single
fbp6	move	a6,*a8(oxpos),w
	move	a7,*a8(oypos),w		; magic y !!

	move	*a8(osizex),a0,w
	add	a0,a6			; update magic x
	xori	1,a3			; alternate flips
	move	*a8(olink),a8,l	
	jrne	fbp3
	rets


broken_floor_b
	movi	BELLHOLE1B,a5
	jruc	brok2

broken_floor_a
	movi	BELLHOLE1A,a5
brok2	subk	25,a7
	callr	flr2
	addk	25,a7
	rets

floor_piece
	movi	BELLHOLE2,a5
flr2	calla	gso_dmawnz
	move	a3,a3
	jreq	flr3
	calla	flip_single
flr3	move	a7,*a8(oypos),w
	move	a6,*a8(oxpos),w
	movi	1000,a0
	move	a0,*a8(ozpos),w		; we want this in front !!
	move	*a8(osizex),a0,w
	add	a0,a6			; move over right 1 space
	move	a8,a0
	movi	baklst8,b4
	calla	insobj_v		; on to list 8
	rets


baklst_down_2_floors
	move	*a2,a0,l
daf3	move	*a0(oypos),a1,w
	addi	one_floor*2,a1
	move	a1,*a0(oypos),w
	move	*a0(olink),a0,l
	jrne	daf3
	rets

scroll_down_1_floor
	move	@worldtly+16,a10,w		; save this spot !!
osgb3	sleep	1
	move	@worldtly+16,a7,w
	sub	a10,a7
	abs	a7
	cmpi	one_floor,a7
	jrlo	osgb3
	retp


crash_fx
	sleep	3
	movk	6,a10
crash3	movi	000050005H,a11
	calla	shake_a11
	tsound	1
	movk	2,a0
	calla	group_sound			; wasted voice
	sleep	023H
	dsj	a10,crash3

	sleep	001H
	tsound	00bH			; crowd: Oooo
	die

;*************************


	movi	clear_shadow_bit,a0
	calla	calla_for_him
;	callr	make_broken_wood

	clr	a0
	move	a0,*a8(ograv),l		; stop accelerating
	movi	0150000H,a0
	move	a0,@scrolly,l
	move	a0,*a8(oyvel),l		; same speed

;ddd	sleep	1
;	move	@worldtly+16,a0,w
;	cmpi	scrbot,a0
;	jrlt	ddd

;	move	*a13(p_store7),a0,l
;	move	a0,@dlists,l

	movi	bell2_mod,a0
	calla	multi_plane
	move	@worldtly+16,a5,w
	move	*a13(p_store5),a0,w
	add	a0,a5
	move	a5,@worldtly+16,w		; start underneath upper background



make_broken_wood
	move	a8,a10
	movi	BELLHOLE1A,a5
	calla	gso_dmawnz
	movi	-030H,a0
	movi	040H,a1
	callr	wood_coor_offset

	movi	BELLHOLE1B,a5
	calla	gso_dmawnz
	movi	030H,a0
	movi	040H,a1
	callr	wood_coor_offset
	rets

;BELLHOLE1A,BELLHOLE1B,BELLHOLE2

wood_coor_offset
	move	*a10(oxpos),a2,w
	add	a0,a2
	move	a2,*a8(oxpos),w
	move	*a10(oypos),a2,w
	add	a1,a2
	move	a2,*a8(oypos),w
	calla	insobja8
	rets


;********************************************************************

fall_down_pit

;********* ????
;	calla	nosounds		; stop the music !!
;	sleep	1
;********* ????

	movk	9,a0
	calla	group_sound		; death scream !!!

	clr	a1
	not	a1
	movi	pid_scroll,a0
	calla	existp
	movi	pit_scroll_proc,a7
	calla	fastxfer		; scroller ---> follow my ass down
	move	a8,*a0(pa11),l		; pass my object

	move	*a13(p_ganiy),a0,w
	addi	0500H,a0
	move	a0,*a13(p_ganiy),w	; floor = way down there

	movi	08000H,a0		; a0 = initial x vel

	move	*a8(oxpos),a14,w
	cmpi	01c3H,a14
	jrlo	normfall
	cmpi	02f0H,a14
	jrhi	normfall

	movi	020000H,a0		; a0 = initial x vel


normfall
	movi	-0c0000H,a1		; a1 = initial y vel
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	movi	pit_fall_scan,a6
	jsrp	flight_call
*
* build the machinery down yonder !!
*
	move	*a13(p_ganiy),a0,w
	addi	0460H,a0
	move	a0,*a13(p_ganiy),w	; floor = way down there
	calla	build_pit_saw
*
* continue fallin !
*
	movi	0130000H,a1
	move	a1,*a8(oyvel),l
	move	a11,*a8(oxvel),l

fdp4	sleep	1
	clr	a1
	not	a1
	movi	pid_scroll,a0
	calla	existp
	move	*a0(pwake),a7,l
	cmpi	pit_scroll_stopped,a7	; wait till scroller reaches bottom
	jrne	fdp4

	calla	set_inviso
	clr	a0
	move	a0,*a8(oyvel),l
	move	a0,*a8(oxvel),l
	sleep	020H			; pause for dramatic effect
	calla	clear_inviso

	move	a11,a0
	movi	0130000H,a1
	movi	06000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight

	movi	01aH,a0
	calla	create_fx		; body parts is parts !!

	move	*a8(oypos),a0,w
	addi	050H,a0
	move	a0,@ground_y,w		; new ground

	create	pid_fx,machine_sound
	create	pid_fx,bone_grind_sound

	movk	5,a0
	movk	3,a1
	movk	3,a2
	jsrp	shake_a8_up		; oooo, dats hurtz !!
	calla	set_inviso

	sleep	060H
	calla	death_blow_complete	; ok now its over !!
	jauc	wait_forever


machine_sound
	movk	6,a10
mach3	tsound	022H	 	; machine
	sleep	010H
	dsj	a10,mach3
	die

bone_grind_sound
	movk	3,a10
bg3	tsound	023H	 	; machine
	sleep	010H
	dsj	a10,bg3
	die

pit_fall_scan
	move	*a8(oxvel),a11,l	; save x vel
	move	*a8(oyvel),a0,l
	cmpi	0130000H,a0
	jrlt	pfmv3
	clr	a0
	move	a0,*a8(ograv),l
	movi	0130000H,a0
	move	a0,*a8(oyvel),l		; no faster than this !!
pfmv3	rets

;***************************************************

fall_on_trax
	move	*a8(oxpos),*a13(p_store6),w
	movk	9,a0
	calla	group_sound		; death scream !!!

	movi	pid_scroll,a0
	calla	dallprc
	movi	pid_repell,a0
	calla	dallprc

	movi	-0100000H,a0
	move	a0,*a8(oyvel),l		; zoom off the screen !!
	movi	01eH,a9			; a9 = ani offset
	calla	get_char_ani
	movk	6,a0
	calla	init_anirate

trax3	sleep	1
	calla	next_anirate
	calla	distance_off_ground
	cmpi	0100H,a0
	jrlo	trax3

	calla	stop_me
	calla	clear_shadow_bit

	movi	029H,a0
	calla	create_fx		; rox o plenty !!!

	sleep	050H

	move	a8,a10
	move	*a10(ochar),a5,w
	sll	5,a5
	addi	ochar_mini_falls,a5
	move	*a5,a5,l
	move	a5,*a13(p_store7),l
	calla	gso_dmawnz
	calla	clear_shadow_bit

	move	*a10(ochar),*a8(ochar),w
	move	*a10(oid),*a8(oid),w

	movi	p1_obj,a4
	move	*a13(procid),a0,w
	cmpi	pid_p1,a0
	jreq	trax7
	movi	p2_obj,a4
trax7	move	a8,*a4,l	  	; stuff new obj
	calla	player_froze_pal
	calla	player_normpal		; use the correct pal

	move	a8,a0
	movi	baklst6,b4
	calla	insobj_v
	move	*a13(p_store6),*a8(oxpos),w
	movi	000H,a0
	move	a0,*a8(oypos),w

	move	@worldtlx6+16,a0,w
	addi	scrrgt/2,a0
	move	a0,*a8(oxpos),w		; center o screen

	movk	2,a0
	calla	group_sound		; scream

	movi	030000H,a0
	move	a0,*a8(oyvel),l
	movi	06000H,a0
	move	a0,*a8(ograv),l		; fall down

	create	pid_bani,train_sound_proc

trax8	sleep	1
	move	*a8(oypos),a0,w
	cmpi	090H,a0
	jrlt	trax8			; fall till u hit ground

	calla	shake_n_sound
	calla	stop_me
	sleep	018H

	move	*a10(ochar),a5,w
	sll	5,a5
	addi	ochar_mini_stunned,a5
	move	*a5,a1,l
	calla	ani_flag

	move	*a8(osizey),a0,w
	movi	0d0H,a1
	sub	a0,a1
	move	a1,*a8(oypos),w

	movi	-030000H,a0
	move	a0,*a8(oyvel),l
	sleep	015H
	calla	stop_a8

	create	pid_bani,train_proc

	sleep	020H

	movk	9,a0
	calla	group_sound		; deth scream
	tsound	083H			; hit by train sound
	move	*a13(p_store7),a1,l
	calla	ani_flag
	calla	flip_single

	move	*a8(oypos),a0,w
	addi	020H,a0
	move	a0,*a8(oypos),w

	movi	080000H,a0
	move	a0,*a8(oxvel),l
	movi	-020000H,a0
	move	a0,*a8(oyvel),l
	movi	03000H,a0
	move	a0,*a8(ograv),l		; ill fly away
	movi	000050005H,a11
	calla	shake_a11

	sleep	030H
	calla	death_blow_complete	; ok now its over !!
	sleep	020H
	jauc	wait_forever


train_sound_proc
	tsound	084H
	sleep	010H

	tsound	085H
	sleep	038H
	tsound	085H
	sleep	038H
	tsound	085H
	sleep	038H

	tsound	086H
	die

;***************************************************

blast_through_soul
	movi	0125H,a4					; store5 - broken floor adj
	movi	tower_mod,a5				; store8
	movi	dlists_soul_to_tower,a6		; store7
	movk	4,a7					; store6
	jruc	blast_entry

blast_through_bank
	movi	0125H,a4					; store5 - broken floor adj
	movi	roof_mod,a5				; store8
	movi	dlists_bank_to_roof,a6		; store7
	movk	3,a7					; store6
	jruc	blast_entry

blast_through_subway
	movi	scrbot,a4
	movi	street_mod,a5				; store8
	movi	dlists_subway_to_street,a6	; store7
	movk	1,a7					; store6

blast_entry
	callr	blast_init

	movi	wait_forever,a7
	calla	xfer_otherguy
	calla	no_edge_limits
*
* flying up = special case
*
	movi	010000H,a0		; a0 = initial x vel
	calla	away_x_vel

;	movi	-0160000H,a1		; a1 = initial y vel
	movi	-0120000H,a1		; a1 = initial y vel
	move	a1,*a8(oyvel),l
	movi	05800H,a2		; a2 = gravity	
	move	a2,*a8(ograv),l
	movi	01eH,a9			; a9 = ani offset
	calla	get_char_ani
	movk	15,a0
	calla	init_anirate

blst4	sleep	1
	calla	next_anirate
	move	*a8(oyvel),a0,l
	jrn	blst4			; wait till we start heading downwards
*
* fall to the ground
*
	movi	dont_touch,a0		; a0 = initial x vel
	movi	dont_touch,a1		; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movk	5,a3
	jsrp	flight

	calla	ground_ochar
	move	*a8(oypos),*a13(p_ganiy),w		; new ground

	movi	back_to_the_fight,a7
	calla	xfer_otherguy

	callr	shake_n_sound
	movi	01eH,a9
	calla	find_ani_part2
	movk	4,a0
	jsrp	mframew			; thudd ani

	sleep	020H

	calla	smoke_if_smoke
	jruc	getup_reaction_exit



smoke_if_smoke
	move	*a8(ochar),a0,w
	cmpi	ft_smoke,a0
	jrne	blst5
	movi	01fH,a0
	calla	create_fx		; smoke = smoke screen needed !!
blst5	rets



back_to_the_fight
	move	*a13(p_otherguy),a5,l
	calla	get_screen_coordinates

	movi	040H,a4
	cmpi	scrrgt/2,a0
	jrhi	btf5
	movi	scrrgt-040H,a4
btf5	move	a4,*a8(oxpos),w		; pick other half of screen
	movi	scrbot,a4
	move	a4,*a8(oypos),w		; come from the bottom

	move	a8,a5
	calla	world_a5		; now put me in the world
*
* pop up
*
	movi	016H,a9
	calla	get_char_ani
	addi	32,a9		
	calla	do_next_a9_frame	; pose: jump up
	calla	face_opponent

	clr	a0
	move	a0,*a8(ograv),l
	movi	-0c0000H,a0
	move	a0,*a8(oyvel),l

btf6	sleep	1
	move	*a8(oypos),a0,w
	move	*a13(p_ganiy),a1,w
	cmp	a1,a0
	jrhi	btf6

	clr	a0
	move	*a8(oyvel),a1,l
	movi	010000H,a2
	movi	never_ani,a3
	jsrp	flight

	calla	ground_ochar
	move	*a8(oypos),*a13(p_ganiy),w

	calla	clear_nocol
	calla	smoke_if_smoke

	movi	reaction_exit,a0
	pushp	a0			; return address
	jauc	jump_up_land_jsrp



blast_init
	mmtm	sp,a4,a5,a6,a7

	move	*a13(p_otherproc),a0,l
	calla	immune_a0    		; dont kill otherguys proc
	movi	pid_master,a0
	calla	exprc_er
	calla	immune_a0    		; dont kill master
*
* make multi-part procs immune !!
*
	calla	immune_mpp
	calla	murder
	create	pid_blast,background_blast	; fx to handle the scrolling

	mmfm	sp,a4,a5,a6,a7

	move	a4,*a0(p_store5),w
	move	a5,*a0(p_store8),l		; pass new module
	move	a6,*a0(p_store7),l		; transition dlists
	move	a7,*a0(p_store6),w		; new curback

	move	*a13(p_otherproc),a0,l
	calla	unimmune_a0
	movi	pid_master|08000H,a0
	calla	exprc_er
	calla	unimmune_a0			; master / otherguy ---> killable
	calla	unimmune_mpp

l_rets	rets

;**************************************************************************

*
* combo reaction 0 - hit in face
*
r_combo0
	movk	4,a0
	calla	create_blood_proc

	callr	combo_setup

	movi	combo_airborn_hit,a5
	clr	a7
	movk	5,a6		     	; 5 = comboed
	callr	reaction_start
	calla	set_no_block 	; disable blocking

	calla	rsnd_big_smack
	movi	01cH,a9
	calla	get_char_ani
	move	a9,a10
	addi	32*3,a9
	calla	do_next_a9_frame
	sleep	3
	move	a10,a9
	movk	4,a0
	jsrp	mframew

	jruc	local_reaction_exit

*
* combo reaction 1 - stumble away
*
r_combo1_stab
	callr	combo_setup
	movi	combo_airborn_hit,a5
	clr	a7
	movk	5,a6		     	; 5 = comboed
	callr	reaction_start
	calla	set_no_block 			; disable blocking
	calla	rsnd_stab
	jruc	combo1


r_combo_klang
	callr	combo_setup
	movi	combo_airborn_hit,a5
	clr	a7
	movk	5,a6	 	    	; 5 = comboed
	callr	reaction_start
	calla	set_no_block 		; disable blocking
	calla	rsnd_klang
	jruc	combo1


r_combo1
	callr	combo_setup
	movi	combo_airborn_hit,a5
	clr	a7
	movk	5,a6	     	; 5 = comboed
	callr	reaction_start
	calla	set_no_block 	; disable blocking

	calla	rsnd_big_smack


combo1	movk	4,a0
	calla	create_blood_proc

	movi	020000H,a0
	calla	away_x_vel		; head away from otherguy

	movi	01cH,a9
	calla	get_char_ani
	move	a9,a10
	addi	32*3,a9
	calla	do_next_a9_frame
	sleep	3
	move	a10,a9
	movk	4,a0
	jsrp	mframew
	jruc	local_reaction_exit

*
* combo reaction 2 - knocked on yer back
*
r_combo2_stab
	callr	combo_setup
	movi	combo_airborn_hit,a5
	clr	a7
	movk	9,a6		     	; 5 = comboed HARD
	callr	reaction_start
	calla	set_no_block 			; disable blocking

	calla	rsnd_stab
	jruc	combo2

r_combo2
	callr	combo_setup
	movi	combo_airborn_hit,a5
	clr	a7
	movk	9,a6		     	; 5 = comboed HARD
	callr	reaction_start
	calla	set_no_block		 	; disable blocking

	calla	rsnd_big_smack

combo2	movk	4,a0
	calla	create_blood_proc

	calla	set_half_damage		; keep this within reason

	movi	00eH,a0
	calla	create_fx	; comment

	movi	040000H,a0	; a0 = initial x vel
	movi	-080000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

*
* combo reaction 3 - knocked HIGH on yer back
*
r_combo3
	callr	combo_setup
	movi	combo_airborn_hit,a5
	clr	a7
	movk	9,a6		     	; 5 = comboed HARD
	callr	reaction_start

	calla	set_no_block 	; disable blocking
	calla	rsnd_big_smack

	calla	set_half_damage		; keep this within reason

	movk	4,a0
	calla	create_blood_proc

	movi	00eH,a0
	calla	create_fx	; comment

	movi	020000H,a0	; a0 = initial x vel
	movi	-080000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

*
* combo reaction 4 - nailed !!
*
r_sk_punch
r_boss_hit1
	movk	4,a0
	calla	create_blood_proc
	movk	1,a0
	calla	create_blood_proc
	jruc	combo43

r_combo4
	calla	set_half_damage		; keep this within reason

combo43	clr	a5
	movk	9,a6  	     	; 5 = comboed HARD
	clr	a7
	callr	reaction_start
	calla	set_no_block 	; disable blocking

	movk	4,a0
	calla	create_blood_proc

	movk	2,a0
	calla	group_sound   	; group speech: wasted
	calla	rsnd_big_smack
	movi	00eH,a0
	calla	create_fx	; comment
	movi	0000a000aH,a11
	calla	shake_a11    	; shake upon contact

	movi	0a0000H,a0	; a0 = initial x vel
	movi	-080000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back


combo_setup
	movk	2,a0
	calla	group_sound   	; group speech: wasted
	movi	000060006H,a11
	calla	shake_a11    	; shake upon contact
	rets


combo_sitting_duck

;	movi	000040020H,a9
;	jsrp	animate_a9		; stumble

	movi	01cH,a9
	calla	get_char_ani
	addi	32,a9
	movk	4,a0
	jsrp	mframew

	sleep	8
	jruc	local_reaction_exit

;**************************************************************************

r_sk_hammer
	movk	1,a6
	movi	r_motaro_kick,a5	; a5 = airborn one !!
	clr	a7
	callr	reaction_start

	movk	2,a0
	calla	his_ochar_sound
	movk	9,a0
	calla	group_sound   		; group speech: death scream

	movi	0000a000aH,a11
	calla	shake_a11

	movk	4,a0
	calla	create_blood_proc
	movk	1,a0
	calla	create_blood_proc

	movi	030000H,a0
	calla	away_x_vel		; move away from him
	movi	000040020H,a9
	jsrp	animate_a9		; stumble ani
	calla	stop_me

	movi	act_dizzy,a0
	move	a0,*a13(p_action),w
	jruc	dizzy_by_boss


r_sk_air_charge
	movk	1,a6
	clr	a5	     	; air = same as ground
	clr	a7
	callr	reaction_start

	movk	4,a0
	calla	create_blood_proc
	movk	1,a0
	calla	create_blood_proc

	movk	2,a0
	calla	group_sound   	; group speech: wasted
	calla	rsnd_big_smack
	movi	0000a000aH,a11
	calla	shake_a11    	; shake upon contact

	movi	060000H,a0	; a0 = initial x vel
	movi	-060000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight

	callr	shake_n_sound
	movi	01eH,a9			; a9 = ani offset
	calla	find_ani_part2
	movk	6,a0
	jsrp	mframew			; thudd ani
	sleep	4
	jruc	getup_reaction_exit

;**************************************************************************

r_motaro_kick
	movk	4,a0
	calla	create_blood_proc
	movk	1,a0
	calla	create_blood_proc

	movk	1,a6
	clr	a5	     	; air = same as ground
	clr	a7
	callr	reaction_start

	movk	2,a0
	calla	group_sound   	; group speech: wasted
	calla	rsnd_big_smack
	movi	0000a000aH,a11
	calla	shake_a11    	; shake upon contact

	movi	080000H,a0	; a0 = initial x vel
	movi	-080000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight

	callr	shake_n_sound
	movk	3,a0			; ani speed
	movk	1,a10			; # of times to shake
	jsrp	shake_on_my_back

	sleep	4	      		; stay laying on my back

	callr	check_stay_down		; should I even get up at all ?
	calla	check_winner_status
	movi	000040021H,a9	  	; getup animation
	jsrp	animate_a9
	jruc	local_reaction_exit

dizzy_by_boss
	movi	act_dizzy,a0
	move	a0,*a13(p_action),w

	movi	025H,a9
	calla	get_char_ani
	movi	000050010H,a0
	jsrp	animate_a0_frames
	jruc	local_reaction_exit

;**************************************************************************

r_tusk_elbow
	movk	4,a0
	calla	create_blood_proc
	movk	4,a0
	calla	create_blood_proc	; hooks = MAN DAS A LATTA BLUD !!

	calla	rsnd_stab
	jruc	rek3

r_elbow_knee
	calla	rsnd_med_smack

rek3	movk	4,a0
	calla	create_blood_proc
	calla	rsnd_react_voice
	movi	000040004H,a11
	calla	shake_a11

	movk	1,a6
	movi	generic_airborn_hit,a5
	clr	a7
	callr	reaction_start
	calla	set_no_block

	movi	010000H,a0
	calla	away_x_vel		; head away from otherguy
	movi	00004001cH,a9
	jsrp	animate_a9		; ani: hit in face
	jruc	local_reaction_exit


r_flip_punch
	calla	rsnd_react_voice
	movi	000040004H,a11
	calla	shake_a11

	movk	1,a6
	movi	generic_airborn_hit,a5
	clr	a7
	callr	reaction_start

	calla	rsnd_med_smack

;	movi	030000H,a0
	movi	010000H,a0
	calla	away_x_vel		; head away from otherguy
	movi	00004001cH,a9
	jsrp	animate_a9		; ani: hit in face
	jruc	local_reaction_exit

;**************************************************************************

r_stick_sweep
	clr	a5
	movk	1,a6
	clr	a7
	callr	reaction_start
	calla	rsnd_body_hit
	movk	6,a0
	calla	group_sound
	calla	ground_player
	jruc	sweep3


r_sweep
	movk	1,a6
	movi	generic_airborn_hit,a5
	clr	a7
	callr	reaction_start
	calla	rsnd_body_hit

	movk	5,a0
	calla	group_sound

sweep3	movi	00005001fH,a9
	jsrp	animate_a9
	callr	shake_n_sound

	calla	am_i_joy
	jrc	joy_swept3

	movk	4,a0
	jsrp	d_beware_mframew		; ani: standing unblock

	clr	a0
	move	a0,*a13(p_otheract),w
	calla	d_beware
	sleep	1
	calla	d_beware
	sleep	1
	calla	d_beware
	sleep	1
	jruc	swept5	

joy_swept3
	movk	4,a0
	jsrp	mframew			; finish fall ani
;	sleep	4
 
swept5	callr	check_stay_down
	jruc	sweepup_local_reaction_exit

;*************************************************************************

r_flip_kick
	calla	rsnd_med_smack
	movi	generic_airborn_hit,a5

	movk	8,a6
	callr	if_shao_then_pass
	clr	a7
	callr	reaction_start

	calla	set_half_damage

	movi	act_react_flipk,a0	
	move	a0,*a13(p_action),w
	jruc	onback3

r_angle_kick
r_last_noogy
	calla	rsnd_med_smack
	movi	generic_airborn_hit,a5
	movk	1,a6
	clr	a7
	callr	reaction_start

onback3	calla	rsnd_react_voice
	movk	2,a0
	calla	create_blood_proc

	movi	030000H,a0		; a0 = initial x vel
	movi	-080000H,a1		; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight

	callr	shake_n_sound
	movi	01eH,a9			; a9 = ani offset
	calla	find_ani_part2
	
	calla	am_i_joy
	jrnc	drone_flipk_getup

	movk	5,a0
	jsrp	mframew			; thudd ani
	sleep	4
	jruc	getup_reaction_exit

drone_flipk_getup
	movk	3,a0
	jsrp	d_beware_mframew

	calla	d_beware
	sleep	1
	calla	d_beware
	sleep	1
	calla	d_beware
	sleep	1

;	sleep	4

	jruc	getup_reaction_exit

;*************************************************************************

r_hi_punch
	callr	inc_p_block

	movk	1,a6
	movi	r_airpunch,a5
	movi	cc_hi_punch,a7
	callr	reaction_start

	calla	rsnd_react_voice
	calla	rsnd_smack
	calla	dec_my_p_hit

	movk	3,a0
	calla	create_blood_proc		; face punch blood

	movi	00003001cH,a9
	jsrp	animate_a9
	jruc	local_reaction_exit

;*************************************************************************

r_lo_punch
	callr	inc_p_block

	movk	1,a6
	movi	r_airpunch,a5
	movi	cc_lo_punch,a7
	callr	reaction_start

	calla	rsnd_react_voice
	calla	rsnd_body_hit
	calla	dec_my_p_hit

	movi	00003001dH,a9		; ani: hit in chest
	calla	am_i_short
	jrnc	rlp3
	movi	000030007H,a9		; ani: duck hit
rlp3	jsrp	animate_a9
	jruc	local_reaction_exit

;*************************************************************************

r_airpunch
	calla	rsnd_med_smack
	calla	rsnd_react_voice

	movi	act_airpunched,a0
	move	a0,*a13(p_action),w

	movi	zero_turbo_bar,a0
	calla	calla_for_him		; no run jab / run jab / run jab

	movk	2,a1			; a1 = # of hits to trigger it !!
	callr	avoid_corner_trap

;**** make hi punch combos easier !!!
;	movi	038000H,a0		; a0 = initial x vel
;	movi	-060000H,a1		; a1 = initial y vel
;	movi	08000H,a2		; a2 = gravity	

	movi	030000H,a0		; a0 = initial x vel
	movi	-060000H,a1		; a1 = initial y vel
	movi	07000H,a2		; a2 = gravity	
;*******************

	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

*
* a1 = # of hits which triggers "repell"
*
avoid_corner_trap
	calla	am_i_close_to_edge
	jrnc	act9 			; I am cornered ---> move him

	movb	*a13(p_hit),a0		; how many hits is that ??
	cmp	a1,a0			; have I been hit this many times
	jrlo	act9			; no

	movi	ken_masters_xfer,a7
	calla	xfer_otherguy

act9	rets

;*************************************************************************

r_ind_charge
	movk	3,a6
	clr	a5
	clr	a7
	callr	reaction_start

	movi	000060006H,a11
	calla	shake_a11  	; shake upon contact
	movk	2,a0
	calla	group_sound  	; group speech: wasted
	calla	rsnd_big_smack

	movi	040000H,a0	; a0 = initial x vel
	movi	-030000H,a1	; a1 = initial y vel
	movi	06000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back


r_kano_roll
	movk	3,a6
	clr	a5
	clr	a7
	callr	reaction_start

	movi	000060006H,a11
	calla	shake_a11  	; shake upon contact
	movk	2,a0
	calla	group_sound  	; group speech: wasted
	calla	rsnd_big_smack

	movi	040000H,a0	; a0 = initial x vel
	movi	-040000H,a1	; a1 = initial y vel
	movi	04000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

;*************************************************************************

r_roundhouse
	clr	a0
	calla	create_blood_proc

	movk	2,a0
	calla	group_sound  	; group speech: wasted
	calla	rsnd_big_smack
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact

	clr	a5
	clr	a7
	movk	1,a6
	callr	reaction_start

	movi	060000H,a0	; a0 = initial x vel
	movi	-080000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

;*************************************************************************

r_square
	movk	2,a0
	calla	group_sound  	; group speech: wasted
	calla	rsnd_big_smack
	movi	000080008H,a11
	calla	shake_a11  	; shake the earth

	movk	1,a6
	clr	a5
	clr	a7
	callr	reaction_start

	movi	050000H,a0	; a0 = initial x vel
	movi	-050000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

;*************************************************************************

r_axe_horz
r_kano_swipe
	movk	2,a0
	calla	group_sound  	; group speech: wasted

	tsound	00fH
	movk	1,a0
	calla	create_blood_proc

	movi	airborn_hit_no_sound,a5
	movk	1,a6
	clr	a7
	callr	reaction_start

	movi	020H,a9
	calla	pose_a9			; stumble frame 1
	movi	060000H,a0
	calla	away_x_vel
	sleep	8

	movi	040000H,a0
	jruc	stumble_back_vel
	
;*************************************************************************

cc_hi_punch
	movk	6,a5	 	; not pulling away hits
	movk	4,a6	 	; pulling away hits
	jruc	ccp3

cc_lo_punch
	movk	5,a5	     	; # of hits if stick is NOT pulled away
	movk	3,a6	     	; # of hits if stick is pulled away

ccp3	calla	am_i_joy
	jrnc	stck4	     	; drone: assume stick pulled away

	calla	is_stick_away	; am I pulling stick away ?
	jrc	stck4	    	; yes	
	move	a5,a6
stck4	movb	*a13(p_block),a0
	cmp	a0,a6	    	; enough hits to separate players ?
	jrhi	stck6	    	; no


;**************
	pull	a0
;**************

	pull	a0
 	pull	a0	    	; pull all return addresses off stack
	jruc	separate_us 	; yes

stck6	rets

separate_us
	calla	am_i_close_to_edge
	movi	030000H,a0
	jrnc	stumble_back_vel	; yea, stumble back

	movi	ken_masters_xfer,a7
	calla	takeover_him

bsep3	jruc	block_exit

;*************************************************************************

cc_block_sweep
	movi	030000H,a0
	movi	030000H,a1
	clr	a7
	jruc	repell_one_of_us

;**************************************************************************

cc_block_avoid_corner
	movk	1,a1
	jruc	avoid_corner_trap_b

cc_block_weak
cc_ken_masters
cc_duck_kickh
	movk	1,a1
	jruc	avoid_corner_trap

;**************************************************************************

ken_masters_xfer
	movi	070000H,a0

ags3	push	a0
	calla	am_i_airborn
	pull	a0
	jrnc	ags_on_ground
*
* getting separated in the air
*
	movi	038000H,a0	; a0 = initial x vel
	movi	-060000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; ani = knocked down
	jsrp	flight
	jruc	land_on_my_back

ags_on_ground
	calla	away_x_vel	; move away from him

	movk	10,a11
ags4	sleep	1
	callr	move_slave_too
	dsjs	a11,ags4
*
* slow down
*
ags6	sleep	1
	callr	move_slave_too
	move	*a8(oxvel),a0,l
	sra	1,a0			; 1/2 speed
	abs	a0
	cmpi	01000H,a0
	jrlo	ags7
	calla	away_x_vel		; move away from him
	jruc	ags6

ags7	callr	move_slave_too
	movi	050H,a10
	jsrp	wait_for_his_dog
	jruc	local_reaction_exit


move_slave_too
	move	*a13(p_slave),a0,l
	jreq	mst9

	move	*a8(oxvel),*a0(oxvel),l
	move	*a8(oyvel),*a0(oyvel),l
	jauc	match_ani_points

mst9	rets

**************************************************************************
*											     *
*  reaction_start - standard reaction start routine. everyone reacting   *
*                   to a hit should call this routine 1st.		     *
* 											     *
*  Input: a5 = address to jump to if airborn					     *
*         a6 = boss reaction offset							     *
*         a7 = routine to run	 								*
*											     *
**************************************************************************
reaction_start
	movi	act_reacting,a0
	move	a0,*a13(p_action),w

	mmtm	sp,a5,a6,a7
	callr	reaction_start_chores
	mmfm	sp,a5,a6,a7

	movi	ochar_react_start_calls,a0
	jruc	rst5

blocked_start
	mmtm	sp,a5,a6,a7
	callr	reaction_start_chores
	mmfm	sp,a5,a6,a7
	calla	zero_my_p_hit		; block is NOT considered a hit !!

	callr	inc_p_block
	clr	a5  			; flag: dont do an airborn check
	movi	ochar_block_start_calls,a0
rst5	calla	ochar_call

	calla	lights_on_hit

	move	a5,a5			; check for airborn hit ?
	jreq	rst2			; no

	calla	am_i_airborn	
	jrnc	rst2
	pull	a0			; no return
	jump	a5

rst2	move	a7,a7			; corner check routine ?
	jreq	rst9			; none, exit

	push	a6
	call	a7			; call it
	pull	a6

rst9	move	a6,a6
	jrne	rsta
	rets

rsta	movi	motaro_branches,a1
	move	*a8(ochar),a7,w
	cmpi	ft_motaro,a7
	jreq	rstc
	movi	sk_branches,a1
	cmpi	ft_sk,a7
	jreq	rstc
	rets

rstc	pull	a0			; no return
	sll	5,a6
	add	a1,a6
	move	*a6,a6,l
	jump	a6



inc_p_block
	movb	*a13(p_block),a0
	inc	a0
	movb	a0,*a13(p_block) 	; add to block counter
	rets

;*************************************************************************

combo_airborn_hit
	movk	2,a0
	calla	group_sound   	; group speech: wasted
	calla	rsnd_big_smack
	movi	000060006H,a11
	calla	shake_a11    	; shake upon contact

	movi	050000H,a0	; a0 = initial x vel
	movi	-030000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back


r_airborn_duck_kick
	movk	1,a1			; a1 = # of hits to trigger it !!
	callr	avoid_corner_trap

generic_airborn_hit
	calla	rsnd_med_smack
	calla	rsnd_react_voice

airborn_hit_no_sound
	movi	038000H,a0	; a0 = initial x vel
	movi	-060000H,a1	; a1 = initial y vel
	movi	08000H,a2	; a2 = gravity	
	movk	5,a3		; a3 = ani speed
	movi	01eH,a9		; a9 = ani offset
	jsrp	flight
	jruc	land_on_my_back

;*************************************************************************

r_tusk_blur
	movk	1,a6
	callr	if_shao_then_pass	; shao kahn = normal guy here

	clr	a5
	clr	a7
	callr	reaction_start

	calla	stop_me
	calla	set_no_block

	movi	act_blurred,a0
	move	a0,*a13(p_action),w

	move	*a8(ochar),a0,w
	push	a0
	movk	ft_lia,a0
	move	a0,*a8(ochar),w
	movk	8,a9
	calla	get_char_ani2
	pull	a0
	move	a0,*a8(ochar),w		; borrow animation from lia
	calla	do_next_a9_frame

	movk	4,a0
  	move	a0,*a13(p_store1),w
	movi	060H/2,a10
rtbl5	sleep	2
	calla	do_next_a9_frame
	move	*a13(p_store1),a0,w
	dec	a0
	jrne	rtbl7
	calla	rsnd_whoosh
	movk	4,a0
rtbl7	move	a0,*a13(p_store1),w
	dsj	a10,rtbl5

	movb	*a13(p_hit),a0
	move	*a13(p_damage),a1,w
	mmtm	sp,a0,a1
	clr	a0
	move	a0,*a13(p_hit),w		; fake out "back 2 normal"
	move	a0,*a13(p_damage),w
	calla	back_to_normal
	mmfm	sp,a0,a1
	movb	a0,*a13(p_hit)
	move	a1,*a13(p_damage),w

	calla	am_i_airborn
	jrc	fall_on_my_back

	calla	ground_player

	calla	q_am_i_a_boss
	jrc	local_reaction_exit

	movi	025H,a9
	calla	get_char_ani
	movi	00005000cH,a0
	jsrp	animate_a0_frames
	jruc	local_reaction_exit

;*************************************************************************

r_tusk_zap
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact
	movi	generic_airborn_hit,a5
	movk	1,a6
	clr	a7
	callr	reaction_start
	clr	a0
	calla	his_ochar_sound
	movi	040000H,a0
	jruc	stumble_back_vel

r_lk_zap
	movk	2,a0
	calla	group_sound 	 	; group speech: wasted
	jruc	zap_stumble

r_skull
	jruc	zap_stumble

r_kano_zap
	movk	2,a0
	calla	his_ochar_sound
	jruc	zap_stumble

r_sg_zap
	movk	2,a0
	calla	his_ochar_sound
	jruc	zap_stumble

r_sonya_zap
	movk	1,a0
	calla	his_ochar_sound

zap_stumble
	movk	6,a6
	movi	generic_airborn_hit,a5
	clr	a7
	callr	reaction_start

	movi	000060006H,a11
	calla	shake_a11		; shake upon contact
	movi	040000H,a0
	jruc	stumble_back_vel


r_swat_bomb
r_rocket
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact
	jruc	zap_stumble

r_ind_zap
r_lia_zap
r_sw_zap
	movk	2,a0
	calla	group_sound		; wasted voice

	movk	1,a6
	movi	generic_airborn_hit,a5
	clr	a7
	callr	reaction_start
	movi	040000H,a0
	jruc	stumble_back_vel

;************************************************************************

r_quake
	movi	act_quake,a0
	move	a0,*a13(p_hitby),w	; kludge this in so hit q is updated

	movi	generic_airborn_hit,a5
	movk	6,a6			; boss = stumble
	clr	a7
	callr	reaction_start

	movk	2,a0
	calla	group_sound		; wasted voice

	movi	028000H,a0
	calla	away_x_vel   		; move away from her
	movk	20,a10
	movi	000040020H,a9
	jsrp	animate_a9		; stumble ani
	jruc	local_reaction_exit

;*************************************************************************

r_post_shake
	movi	040000H,a0		; a0 = initial x vel
	movi	-040000H,a1		; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land

r_post_bike
	movi	040000H,a0		; a0 = initial x vel
	movi	-060000H,a1		; a1 = initial y vel
	movi	0a000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight
	jruc	reaction_land

;*************************************************************************

r_sk_charge
;r_ind_charge
	calla	rsnd_big_smack
	movk	2,a0
	calla	group_sound 	 	; group speech: wasted
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact

	movk	6,a6			; bossy = stumbly
	clr	a7
	movi	airborn_hit_no_sound,a5
	callr	reaction_start

	movi	050000H,a0
	calla	away_x_vel		; move away from him
	movi	000030020H,a9
	jsrp	animate_a9		; FASTER STUMBLE = faster recovery
	jruc	local_reaction_exit


r_jax_zap
	movk	2,a0
	calla	group_sound 	 	; group speech: wasted
	movi	000060006H,a11
	calla	shake_a11		; shake upon contact

	movi	airborn_hit_no_sound,a5
	movk	1,a6
	clr	a7
	callr	reaction_start
	movi	040000H,a0
	jruc	stumble_back_vel

;*************************************************************************

r_decoy_freeze
	movk	3,a0
	calla	create_fx		; freeze blast about a8
	movk	5,a0
	calla	his_ochar_sound

r_freeze
	calla	lights_on_slam

	movi	act_sky_ice,a1
	move	a1,*a13(p_hitby),w	; make sure this gets queued

	callr	reaction_start_chores
	calla	dec_my_p_hit

	move	*a13(p_action),a0,w
	cmpi	act_frozen,a0
;	cmpi	freeze_wakeup,a9	; re-freeze ??
	jreq	freeze_backfire		; yes, backfire !
	
	calla	stop_me			; sans movement
	calla	set_no_block		; sans blocking
	calla	me_in_back
*
* low on strength = frosty !!
*
	calla	get_my_strength
	cmpi	8,a0
	jrhi	freez3
	movi	017H,a0
	calla	create_fx
	movi	01cH,a2
	move	a2,*a0(pa11),l		; pass sound: Frosty !!

freez3	movi	act_frozen,a0
	move	a0,*a13(p_action),w	; define my state !

	move	*a8(oflags2),a4,w
	andni	m_noflip,a4
	move	a4,*a8(oflags2),w	; flag: i can be flipped !!
;	movi	freeze_wakeup,a9	; flag: i am frozen

	calla	player_froze_pal

;****************
	move	*a8(ochar),a0,w
	cmpi	ft_tusk,a0
	jrne	no_tusk_blur_freeze

	move	*a8(oshape),a0,l
	cmpi	TRZOOM6,a0
	jreq	tusk_blur_freeze
	cmpi	TRZOOM5,a0
	jreq	tusk_blur_freeze
	cmpi	TRZOOM4,a0
	jreq	tusk_blur_freeze
	cmpi	TRZOOM3,a0
	jrne	no_tusk_blur_freeze

tusk_blur_freeze
	movk	1,a9
	calla	pose2_a9		; dont get frozen in long blur frame

no_tusk_blur_freeze
;****************

	movi	000000004H,a0		; y:x pixels
	movk	3,a1			; sleep time
	movk	2,a2			; # of shakes
	jsrp	shake_a8_up

;	calla	player_froze_pal

	movi	000000004H,a0		; y:x pixels
	movk	3,a1			; sleep time
	movk	8,a2			; # of shakes
	jsrp	shake_a8_up

	sleep	080H

freeze_wakeup
	calla	player_normpal

	calla	am_i_airborn
	jrnc	local_reaction_exit	; grounded ---> cool

	clr	a0		 	; a0 = initial x vel
	movi	010000H,a1		; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight			; fall to ground
	jruc	land_on_my_back


freeze_backfire
	movi	r_freeze,a7
	calla	takeover_him		; freeze the otherguy !!
	jruc	freeze_wakeup		; and un-freeze me !

;*************************************************************************

r_hat
	movk	1,a6
	callr	if_shao_then_pass	; shao kahn = normal guy here
	clr	a5
	clr	a7
	callr	reaction_start

	movk	2,a0
	callr	local_group_sound

	movi	020H,a9
	calla	find_ani_part2		; repeating stumble
	movi	030000H,a0
	calla	away_x_vel		; moving away from kung lao

	movk	6,a0
	calla	init_anirate
	movi	024H,a10
rhat3	sleep	1
rhat_wake
	move	*a13(p_anicount),a0,w
	cmpi	1,a0
	jrne	rhat5
	movk	5,a0
	calla	create_blood_proc   	; hit by hat = blood
rhat5	calla	next_anirate
	dsj	a10,rhat3
	jruc	local_reaction_exit

;*************************************************************************

stumble_back
	movi	030000H,a0

stumble_back_vel
	calla	away_x_vel		; move away from him
	movi	000040020H,a9
	jsrp	animate_a9		; stumble ani
	jruc	local_reaction_exit

;*************************************************************************

update_hit_queue
	mmtm	sp,a5,a6
	jruc	uhq_entry

reaction_start_chores
	mmtm	sp,a5,a6
	callr	inc_p_hit
	clr	a7
	move	a7,*a8(ograv),l

	move	*a13(p_flags),a4,w
	btst	pb_sitduck,a4
	jreq	rst1

	movk	1,a0
	move	a0,@f_thatsall,w	; i was a sitting duck ---> thats all !

rst1	ori	pm_reacting,a4
	move	a4,*a13(p_flags),w	; flag: i am reacting to an attack
	calla	delete_slave		; no slaves !!

	move	*a8(oflags2),a4,w
	andni	m_noblock,a4	 	; i am hit ---> now allow blocking !!
	andni	m_inviso,a4	 	; clear inviso flag !
	andni	m_ignore_y,a4	 	; dont ignore my y position
	andni	m_nocol,a4	 	; dont ignore collisions
	ori	m_shadow,a4		; turn on shadow
	move	a4,*a8(oflags2),w

	move	a8,a2
	calla	noflip_a2		; u can't flip me if i'm out o control

	clr	a0
	movb	a0,*a13(p_power)	; not invincible to anything
	move	a0,*a13(p_stk),w	; I am no longer striking !!
	calla	player_normpal
	calla	face_opponent
	calla	stop_me

uhq_entry
	move	*a13(p_hitby),a7,w	; a7 = action i was hit by
	callr	get_my_hitq		; a0 = my hit queue ram
	move	*a0,a1,w
	move	*a0(16),a2,w
	move	*a0(32),a3,w
	move	*a0(48),a4,w
	move	*a0(64),a5,w		; grab 5 entries to shift down
	move	a7,*a0,w
	move	a1,*a0(16),w
	move	a2,*a0(32),w
	move	a3,*a0(48),w
	move	a4,*a0(64),w
	move	a5,*a0(80),w		; update queue
	mmfm	sp,a5,a6
	rets


update_his_hit_queue
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	move	a7,*a13(p_hitby),w
	callr	update_hit_queue
	mmfm	sp,a8,a13
	rets


inc_p_hit
	movb	*a13(p_hit),a0
	inc	a0
	movb	a0,*a13(p_hit)		; add to hit counter
	rets

ochar_block_start_calls
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0


ochar_react_start_calls
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

**************************************************************************
*											     *
*  get_my_hitq - get a pointer to my hit queue					     *
* 											     *
*  input: a8 = object who wants 2 know						     *
* 											     *
*  returns: a0 = pointer to my hit queue						     *
*											     *
**************************************************************************
get_my_hitq
	push	a1
	movi	p1_hitq,a0
	move	@p1_obj,a1,l		; a1 = player 1 object
	cmp	a1,a8			; me ?
	jreq	gmhq3			; yes
	movi	p2_hitq,a0		; no, use hit queue for player 2 (me)
gmhq3  	pull	a1
	rets

**************************************************************************
*											     *
*                         BLOCKED REACTIONS					     *
*                         BLOCKED REACTIONS					     *
*                         BLOCKED REACTIONS					     *
*											     *
**************************************************************************

block_xfers
	.long	b_weak			; 0
	.long	b_hard			; 1
	.long	b_uppercut		; 2
	.long	b_sweep			; 3
	.long	b_hard_silent		; 4
	.long	b_weak_silent		; 5
	.long	b_hard_ken_masters	; 6
	.long	b_knee_elbow		; 7
	.long	b_scream		; 8
	.long	r_robo_bomb 	  	; 9
	.long	b_duck_hit_soft		; a
	.long	b_duck_hit_hard		; a
	.long	r_robo_bomb		; c - you cant block this !!
	.long	wait_forever   		; d - keep this as "wait_forever"
	.long	r_pounce		; e - HAMMER SAYS: you cant block this !!
	.long	b_combo			; f - blocked a combo hit
	.long	b_weak_no_masters	; 10
	.long	b_punch			; 11
	.long	b_combo_hard		; 12 - blocked a HARD combo hit
	.long	wait_forever		; 13
	.long	wait_forever		; 14
	.long	b_boss_hit1		; 15

b_uppercut
	calla	rsnd_big_block
	movi	000040004H,a11
	calla	shake_a11

	clr	a5
	clr	a6
	movi	cc_ken_masters,a7
	callr	blocked_start

	movi	040000H,a0
	calla	away_x_vel         	; head away from otherguy
	movk	2,a11
	movk	4,a10
	jruc	block_shake_n_exit

;***********************************************************************

b_boss_hit1
	clr	a7
	clr	a5
	clr	a6
	callr	blocked_start

	calla	rsnd_big_block

	movi	060000H,a0
	calla	away_x_vel	     	; head away from otherguy
	movi	000060006H,a11
	calla	shake_a11

	movk	2,a11
	movk	3,a10
	movi	00cH,a9
	jsrp	block_shake

	movi	040000H,a0
	jruc	stumble_back_vel

;***********************************************************************

b_hard_ken_masters
	calla	rsnd_big_block
	movi	cc_block_avoid_corner,a7
	jruc	block2

b_hard
	calla	rsnd_big_block

b_hard_silent
	clr	a7
block2	clr	a5
	clr	a6
	callr	blocked_start

block3	movi	000040004H,a11
	calla	shake_a11
	movi	020000H,a0
	calla	away_x_vel	     	; head away from otherguy
	movk	2,a11
	movk	3,a10
	jruc	block_shake_n_exit

;***********************************************************************

b_knee_elbow
	movi	000040004H,a11
	calla	shake_a11

b_combo	movi	cc_block_avoid_corner,a7
	clr	a5
	clr	a6
	callr	blocked_start
	calla	rsnd_big_block

;	movi	030000H,a0
;	movi	050000H,a0
	movi	040000H,a0
	calla	away_x_vel         	; head away from otherguy
	movk	2,a11
	movk	3,a10
	jruc	block_shake_n_exit


b_combo_hard
	movi	000040004H,a11
	calla	shake_a11

	movi	cc_block_avoid_corner,a7
	clr	a5
	clr	a6
	callr	blocked_start
	calla	rsnd_big_block

	movi	050000H,a0
	calla	away_x_vel         	; head away from otherguy
	movk	3,a10			; # of shakes
	movk	3,a11			; sleep time
	jruc	block_shake_n_exit



b_duck_hit_soft
	movi	generic_airborn_hit,a5
	clr	a6
	movi	cc_block_avoid_corner,a7
	callr	blocked_start
	calla	rsnd_small_block
	movi	020000H,a0
	calla	away_x_vel		; head away from otherguy

	movk	2,a11
	movk	3,a10
	jruc	block_shake_n_exit

;**********************************************

b_duck_hit_hard
	movi	generic_airborn_hit,a5
	clr	a6
	movi	cc_block_avoid_corner,a7
	callr	blocked_start
	calla	rsnd_big_block
	movi	050000H,a0
	calla	away_x_vel		; head away from otherguy

	movk	2,a11
	movk	3,a10
	jruc	block_shake_n_exit

;**********************************************

b_punch
	calla	rsnd_small_block

	clr 	a5
	clr	a6
	movi	cc_punch,a7
	callr	blocked_start
	movi	020000H,a0
	calla	away_x_vel		; repell some
	movk	2,a11
	movk	3,a10
	jruc	block_shake_n_exit

cc_punch
	movk	3,a1
	callr	avoid_corner_trap_b
	rets
*
* input a1: # of hits to repell at
*
avoid_corner_trap_b
	movb	*a13(p_hit),a0
	push	a0
	movb	*a13(p_block),a0
	movb	a0,*a13(p_hit)		; fake out "avoid corner"
	callr	avoid_corner_trap	; count blocks not hits
	pull	a0
	movb	a0,*a13(p_hit)
	rets

;**********************************************

b_weak_no_masters
	calla	rsnd_small_block
	clr 	a5
	clr	a6
	clr	a7			; no ken masters = no corner checking
	callr	blocked_start
	jruc	weak3

b_weak	calla	rsnd_small_block

b_weak_silent
	clr 	a5
	clr	a6
	movi	cc_block_weak,a7
	callr	blocked_start

weak3	movk	2,a11
	movk	3,a10
	jruc	block_shake_n_exit


b_sweep
	calla	rsnd_small_block
	clr	a5
	clr	a6
	movi	cc_block_sweep,a7
	callr	blocked_start
	movk	2,a11
	movk	2,a10
	jruc	block_shake_n_exit

b_scream
	movi	040000H,a0
	jruc	stumble_back_vel

**************************************************************************
*											     *
*  block_shake_n_exit									     *
* 											     *
*  Input: a10 = # of times to shake							     *
*         a11 = sleep time								     *
*											     *
**************************************************************************
block_shake_n_exit
	callr	get_block_ani_offset		; tall/short/or boss
	jsrp	block_shake

block_exit
	clr	a0
	movb	a0,*a13(p_hit)	 	; ok, but you gotta start the count over
	movb	a0,*a13(p_block) 	; ok, but you gotta start the count over

;*********** new
	calla	back_to_normal
;*********** new

	calla	am_i_joy
	janc	d_post_block
	calla	am_i_short
	jac	joy_duck_block_loop
	jauc	joy_block_loop


get_block_ani_offset
	movi	00cH,a9
	movi	006H,a5

	move	*a8(ochar),a0,w
	cmpi	ft_sg,a0,w
	jreq	sg_block_ani_offset

gba3	callr	tall_or_short_ani	; pick one based on height
	rets

sg_block_ani_offset
	move	*a8(oshape),a0,l
	cmpi	SHDUCKBLOCK1,a0
	jreq	tos7			; special case bs !!
	cmpi	SHDUCKBLOCK2,a0
	jreq	tos7			; special case bs !!
	cmpi	SHDUCKBLOCK3,a0
	jreq	tos7			; special case bs !!
	jruc	gba3
*
* Input: a9 = standing animation
*        a5 = ducking animation
*
tall_or_short_ani
	calla	am_i_short
	jrnc	tos9
tos7	move	a5,a9			; short = use duck ani
tos9	rets

**************************************************************************
*											     *
*  block_shake - Handy routine to shake someone who is blocking	     *
* 											     *
*  Input: a9 = animation offset								     *
*        a10 = # of times to shake							     *
*        a11 = sleep time								     *
*											     *
**************************************************************************
block_shake
	calla	get_char_ani
	addi	32,a9

blk2	jsrp	block_shake_ani
	jsrp	block_shake_ani
	subi	32*2,a9
	dsj	a10,blk2
	calla	stop_me
	retp

block_shake_ani
	calla	do_next_a9_frame	; show frame 2
	move	a11,a0
	calla	prcslp
block_shake_wake
	retp

***************************************************************************

suspend_wait_action
	jsrp	suspend_wait_action_jsrp
	jruc	local_reaction_exit		; no, abort

suspend_wait_action_jsrp
	calla	get_his_action
	move	a1,a11
susp3	sleep	2

suspend_wait_wake
	calla	get_his_action
	cmp	a1,a11				; he still doing his thing ?
	jreq	susp3				; yes, wait
	retp

**************************************************************************
*											     *
*           LANDING AND RECOVERING HANDY PLACES TO JUMP TO		     *
*           LANDING AND RECOVERING HANDY PLACES TO JUMP TO		     *
*           LANDING AND RECOVERING HANDY PLACES TO JUMP TO		     *
*           LANDING AND RECOVERING HANDY PLACES TO JUMP TO		     *
*											     *
**************************************************************************
fall_on_my_back
	clr	a0	 		; a0 = initial x vel
	clr	a1			; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movk	5,a3			; a3 = ani speed
	movi	01eH,a9			; a9 = ani offset
	jsrp	flight

reaction_land
	callr	shake_n_sound

	movi	01eH,a9
	calla	find_ani_part2
	movk	4,a0
	jsrp	mframew			; thudd ani
	sleep	3
	jruc	getup_reaction_exit

land_on_my_back
	callr	shake_n_sound
	movk	3,a0			; ani speed
	movk	1,a10			; # of times to shake
	jsrp	shake_on_my_back

	sleep	4			; stay laying on my back
	jruc	getup_reaction_exit

**************************************************************************
*											     *
*  getup_reaction_exit - Getup then goto local_reaction_exit	     	*
* 											     *
**************************************************************************
sweepup_local_reaction_exit
	movi	022H,a9			; sweepup animation
	jruc	gup2

getup_reaction_exit
	movi	021H,a9			; getup animation
gup2	movi	getup_speeds,a11
   	move	a9,a10			; remember ani
	callr	check_stay_down		; should I even get up at all ?
	calla	check_winner_status
	calla	back_to_normal		; clear "phit not getting zeroed" bug

	calla	am_i_joy		; me joy dude ?
	janc	d_getup		; no
*
* joystick dude getup
*
	calla	is_stick_down
	jrc	getup_stay_ducked	; stick down = stay ducked down

	calla	get_char_ani
	move	a11,a0
	calla	get_char_word		; getup /sweepup speeds
	calla	init_anirate

gup4	calla	next_anirate
	move	*a9,a0,l
	jreq	gup6			; last frame = exit

	cmpi	017H,a10
	jreq	gup3			; sweepup ani = no aborting allowed

	calla	is_stick_down
	jrc	joy_getup_abort
	calla	joystick_in_a0
	btst	bit_jup,a0		; is joystick up ?
	jrne	joy_getup_jump

gup3	sloop	1,gup4

gup6	sleep	2
	jruc	local_reaction_exit


joy_getup_abort
	calla	player_normpal
	jauc	joy_down		; stick down = duck NOW !

joy_getup_jump
	calla	player_normpal
	jauc	joy_up			; yes, quickly jump up


getup_stay_ducked
	calla	back_to_normal
	movk	4,a9
	calla	find_ani_last_frame
	calla	do_next_a9_frame	; pose: ducked frame
	jauc	joy_getup_entry

getup_speeds
	.word	4
	.word	4
	.word	4
	.word	4
	.word	4

	.word	4
	.word	4
	.word	4
	.word	4
	.word	4

	.word	4
	.word	4
	.word	4
	.word	4
	.word	4

	.word	4
	.word	4
	.word	4
	.word	4
	.word	4

**************************************************************************
*											     *
*  repell_one_of_us - Repells one of us based on our position on the scr *
* 											     *
*  Input: a0 = velocity to repell me at						     *
*         a1 = velocity to repell him at							*
*         a7 = routine to xfer attacker						     *
*											     *
**************************************************************************
repell_one_of_us
	calla	am_i_close_to_edge
	jrnc	rus7 				; I am cornered ---> move him

	move	a7,a7 				; routine to xfer ?
	jreq	rus3				; without

	mmtm	sp,a0,a1
	calla	takeover_him			; yes ---> xfer him to it
	mmfm	sp,a0,a1

rus3	mmtm	sp,a13,a8
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l	; put on his mask
	move	a1,a0
	calla	away_x_vel
	mmfm	sp,a13,a8
	rets

rus7	jauc	away_x_vel 		  	; head away from otherguy

;***************************************************************************

check_stay_down
	move	@winner_status,a0,w
	jreq	gup9			; no winner ----> get up
	cmpi	3,a0
	jreq	gup9			; finish him ---> get up !!
	move	*a13(procid),a1,w
	cmp	a0,a1			; am i the winner ?
	jreq	gup9			; yes, getup
*
* I lose ---> stay down !
*
	pull	a0			; no return
	calla	clear_shadow_bit
	jauc	wait_forever

gup9  	rets

**************************************************************************

shake_n_sound
	movi	000060006H,a11
	calla	shake_a11
	jauc	rsnd_ground

**************************************************************************
*											     *
*   reverse_ani - Walk backwards through an animation starting at the    *
*                 2nd to last frame							     *
* 											     *
*   a0 = sleep time									     *
*   a9 = animation offset								     *
*											     *
**************************************************************************
reverse_ani
	move	a0,-*a12,l		; save sleep time (pushp a0)

	calla	get_char_ani
	move	a9,a10
	subi	32,a10			; a10 = 1st frame marker
	calla	find_last_frame
	subi	32,a9			; a9 = 2nd to last frame

reva3	calla	do_next_a9_frame
	move	*a12,a0,l		; pull sleep time but keep stack same
	calla	prcslp
	subi	32*2,a9
	cmp	a9,a10
	jrne	reva3

	pullp	a0
	retp

**************************************************************************
*											     *
*  shake_on_my_back - Do the "shake on my back" animation given:	     *
* 											     *
*  Input: a0 = speed of ani								     *
*        a10 = # of times to shake (2 frames each)				     *
*											     *
**************************************************************************
shake_on_my_back
	pushp	a0

somb2	movi	01eH,a9
	calla	find_ani_part2
	move	a9,a11			; a11 = 1st frame of shake
somb3	move	a11,a9
	move	*a12,a0,l		; pull sleep time but keep stack same
	jsrp	mframew
	dsj	a10,somb3

	pullp	a0
	retp

local_reaction_exit
	jauc	reaction_exit

rsnd_react_voice
	movk	6,a0
	jauc	group_sound

local_ochar_sound
	jauc	ochar_sound

local_group_sound
	jauc	group_sound

*************************************************************************

	.end
