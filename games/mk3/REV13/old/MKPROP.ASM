**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: body propell moves									*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	'mkprop.asm'
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


do_body_propell
	cmpi	(propell_end-propell_table)/32,a0
	jahi	reaction_exit			; out of range = abort
	sll	5,a0
	addi	propell_table,a0
	move	*a0,a0,l
	jump	a0


propell_table
	.long	kano_cannon_ball	; 0 - kano cannonball roll
	.long	sonya_bike_kick		; 1 
	.long	ind_charge		; 2
	.long	jax_dash_punch		; 3
	.long	do_sz_decoy		; 4
	.long	do_lia_fly		; 5
	.long	do_lao_tele		; 6
	.long	do_lao_angle		; 7
	.long	do_robo_tele		; 8
	.long	do_robo_air_grab	; 9
	.long	do_tele_explode		; a
	.long	do_lia_stay_afloat	; b
	.long	do_square_wave		; c
	.long	do_lk_bike		; d
	.long	do_super_kang		; e
	.long	do_sg_pounce		; f
	.long	do_slide		; 10
	.long	do_swat_zoom		; 11
	.long	do_stick_sweep		; 12
	.long	do_tusk_blur		; 13
	.long	do_sg_quake		; 14
propell_end

;************************************************************************

do_tusk_blur
	movi	act_tusk_blur,a1
	calla	init_special_act

	movk	1,a9
	callr	local_get_char_ani2

	movi	>d0000,a0
	calla	towards_x_vel
	movk	1,a0
	calla	init_anirate

	movk	2,a0
	calla	ochar_sound		; zoom sound !!!

	clr	a0
	move	a0,*a13(p_store1),w

	movi	>1a,a10
blur3	sleep	1

	move	*a13(p_store1),a0,w
	jrne	blur5
	movi	>12,a0
	calla	strike_check_a0
	jrnc	blur5
	move	b2,b2
	jrne	tusk_blur_blocked
	movk	1,a0
	move	a0,*a13(p_store1),w

blur5	calla	sans_repell_3
	calla	next_anirate
	dsj	a10,blur3

	movk	1,a9
	calla	find_ani2_part2

	calla	stop_me
	movk	2,a0
	jsrp	mframew
	jruc	local_reaction_exit


tusk_blur_blocked
	movi	act_tusk_blur_sd,a1
	move	a1,*a13(p_action),w

	calla	set_no_block		; me = chump !!
	calla	stop_me
	move	*a9,a0,l
	jreq	blb7
	movk	1,a0
	jsrp	mframew
blb7	movk	1,a9
	calla	find_ani2_part2
	movk	1,a0
	jsrp	mframew

	movk	4,a0
	movk	3,a1
	movk	4,a2
	jsrp	shake_a8_up
	jruc	local_reaction_exit

;************************************************************************

do_stick_sweep
	movi	act_stick_sweep,a1
	calla	init_special_act

	movk	3,a0
	calla	ochar_sound			; stick sweep sound

	movi	>60000,a0
	calla	towards_x_vel

	movk	2,a9
	callr	local_get_char_ani2
	movk	4,a0
	jsrp	mframew
	calla	stop_me

	movi	>17,a0
	calla	strike_check_a0
	jrnc	stsw_miss
	move	b2,b2
	jrne	stsw_miss

	sleep	6

	calla	do_next_a9_frame
	sleep	>10
	movk	4,a0
	jauc	mframew

stsw_miss
	movi	act_stsw_sd,a0
	move	a0,*a13(p_action),w
	calla	do_next_a9_frame
	sleep	>20				; sitting duck time !!
	movk	4,a0
	jauc	mframew

;************************************************************************

do_swat_zoom
	movi	act_zoom,a1
	calla	init_special_act

	movk	1,a9
	callr	local_get_char_ani2
	calla	do_next_a9_frame

	movk	2,a0
	callr	local_ochar_sound
	movi	>c0000,a0
	calla	towards_x_vel
	movi	->20000,a0
	move	a0,*a8(oyvel),l
	movi	>2400,a0
	move	a0,*a8(ograv),l
	calla	sans_repell_3
*
* zoom scan loop
*
	clr	a0
	move	a0,*a13(p_store1),w	; flag: no hit yet
zoom3	sleep	1
	calla	sans_repell_3
	callr	zoom_damping

	calla	q_is_he_a_boss
	jrc	zoom4			; I aint strong enough to throw a boss
	movi	>15,a0
	calla	strike_check_a0
	jrc	zoom_hit		; hit = exit this loop
zoom4	move	*a8(oypos),a1,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	cmp	a0,a1			; starting below ground level ?
	jrlt	zoom3			; no, we are ok
	calla	stop_me
	calla	ground_player
	jruc	local_retp


zoom_hit
	move	b2,b2
	jrne	zoom_blocked

	calla	d_front_me_a5		; a5 = pixels in front of me
	cmpi	>e0,a5
	jrhi	zoomh1
	calla	set_his_noedge		; avoid corner bs

zoomh1	movk	4,a0
	callr	local_ochar_sound

	calla	stop_him
zoomh2	sleep	1
	calla	sans_repell_3
	callr	zoom_ground_scan
	calla	closest_edge_a5
	cmpi	>60,a5
	jrlo	zoomh5			; 2 close 2 edge ---> exit
	calla	get_x_dist
	cmpi	>30,a3
	jrlo	zoomh2
*
* line him up with me
*
zoomh5	calla	match_him_with_me_f
	movi	>0001001e,a9
	calla	pose_him_a9
	movi	ochar_zoom_lineups,a0
	calla	get_his_char_long
	move	a0,a1
	sext	a0,w
	sra	16,a1
	calla	adjust_him_xy		; line him up

	calla	stop_me
	calla	ground_player
*
* flip this zero !!
*
	calla	stop_him
	movi	>3a,a9
	calla	get_his_char_ani
	move	a9,a11	      		; a11 = his ani (flipped by me)
	move	*a13(p_otherguy),a10,l
	movk	1,a9
	callr	local_get_char_ani2
	calla	find_part2

	movk	4,a0
	calla	group_sound		; throw voice
	calla	rsnd_big_whoosh

	movi	zoom_damage,a14
	calla	add_combo_damage		; count damage in combos

	movk	3,a0
	jsrp	double_mframew
	movi	r_zoom_flipped,a7
	calla	xfer_otherguy
	move	a11,*a0(pa9),l		; pass ani
	calla	do_next_a9_frame
	sleep	>0a
	movk	6,a0
	jsrp	mframew			; out of ani
	jruc	local_retp

zoom_blocked
	movi	act_zoom_sd,a0
	move	a0,*a13(p_action),w

	calla	match_me_with_him
	calla	flip_multi     		; flip him !
	movi	->08,a0
	clr 	a1
	calla	multi_adjust_xy

	movi	>1a,a9
	calla	get_char_ani
	addi	32,a9
	movi	>10000,a0
	movi	->80000,a1
	movi	>6000,a2
	movk	2,a3
	jsrp	flight
	jauc	jump_up_land_jump

ochar_zoom_lineups
	.word	>40,>00
	.word	>40,>00
	.word	>40,>00
	.word	>40,>00
	.word	>40,>00

	.word	>40,>00		; 5 - swat
	.word	>40,>00
	.word	>40,>00
	.word	>40,>00
	.word	>40,>00

	.word	>40,>00
	.word	>40,>00
	.word	>40,>00
	.word	>40,>00
	.word	>40,>00

zoom_damping
	move	*a8(oxvel),a0,l
	move	a0,a1
	sra	6,a1
	sub	a1,a0
	calla	set_x_vel		; damping looks kool !!
	rets


zoom_ground_scan
	move	*a8(oypos),a1,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	cmp	a0,a1			; starting below ground level ?
	jrlt	zoomh4			; no, we are ok
	move	*a13(p_otherguy),a1,l
	move	a0,*a8(oypos),w		; ground me
	clr	a0
	move	a0,*a8(ograv),l		; no grav
	move	a0,*a1(oyvel),l
zoomh4 	rets

;************************************************************************

do_slide
	movi	act_slide,a1
	calla	init_special_act

	movi	>80000,a0
	calla	towards_x_vel		; head towards opponent

	movk	2,a9
	callr	local_get_char_ani2
	movk	4,a0
	calla	init_anirate

	movk	6,a0
	callr	local_ochar_sound	; slide sound
*
* first part of slide = no collision check
*
	movi	>1c,a10
slide4	sleep	1
	calla	next_anirate

	cmpi	>14,a10
	jrhi	slide5
	movi	>10,a0
	calla	strike_check_a0
	jrc	slide_hit
slide5	dsj	a10,slide4
	jruc	slide_blocked


slide_hit
	move	b2,b2
	jrne	slide_blocked

	movi	>00020002,a9		; pose: frame 3
	calla	pose2_a9
	move	*a8(oxvel),a0,l
	sra	1,a0	       
	calla	set_x_vel
	sleep	3
	calla	stop_me
	jsrp	wait_for_landing	; stall till he lands !!
	jruc	slide_is_over

slide_blocked
	calla	stop_me
	calla	clear_noflip
	calla	set_no_block
	movi	act_slide_sd,a0
	move	a0,*a13(p_action),w	; i am a sitting duck !

	sleep	>16			; sitting duck time !

slide_is_over
	movi	>00010002,a9		; pose: frame 2
	calla	pose2_a9
	sleep	4
	movk	2,a9			; pose: frame 1
	calla	pose2_a9
	sleep	4
 
	movi	l_slide,a0
	calla	update_tsl
	jruc	local_reaction_exit

;************************************************************************

do_sg_quake
	movi	act_sg_quake,a1
	calla	init_special_act

	clr	a9
	callr	local_get_char_ani2
	clr	a0
	movi	->a0000,a1		; initial y vel
	movi	>c000,a2		; grav
	movk	2,a3			; ani speed
	jsrp	flight

	movk	1,a0
	callr	local_ochar_sound	; ground shake sound
	movi	>00080008,a11
	calla	shake_a11

	clr	a11			
	calla	is_he_airborn		; he in the air ?
	jrc	quake3			; yes, no damage

	calla	q_is_he_a_boss
	jrc	quake3			; yes, no damage

	movi	>19,a0
	calla	damage_to_him
	movi	r_quake,a7
	calla	takeover_him
	movk	1,a11			; flag: quake hit

quake3	movi	act_sg_quake_sd,a0
	move	a0,*a13(p_action),w

	clr	a9
	callr	local_get_char_ani2
	calla	find_part2
	movk	3,a0
	jsrp	mframew			; blur catch up

	movi	>1c,a0
	move	a11,a11
	jreq	quake4
	movi	>10,a0			; hit = faster wake
quake4	calla	prcslp
	calla	do_next_a9_frame	; backup (frame 5)
	sleep	4

	jruc	local_reaction_exit

;************************************************************************

do_sg_pounce
	movi	act_sg_pounce,a1
	calla	init_special_act

	clr	a0
	callr	local_ochar_sound		; teleport sound

	clr	a9
	callr	local_get_char_ani2
	calla	do_next_a9_frame		; tele frame #1

	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a11,w		; save his x

	movi	->80000,a0
	move	a0,*a8(oyvel),l
	movi	->10000,a0
	move	a0,*a8(ograv),l	   	; negative gravity

sgt4	sleep	1
	calla	distance_off_ground
	cmpi	>e8,a0
	jrlt	sgt4   			; zip off the top of the screen

	move	a11,*a8(oxpos),w 	; where he was when I took off !
	clr	a9
	callr	local_get_char_ani2
	addi	32*2,a9
	clr	a0
	movi	>60000,a1		; initial y vel
	movi	>8000,a2		; grav
	movk	2,a3			; ani speed
	movi	pounce_scan,a6

pounce_fall
	jsrp	flight_call
	jsrp	blur_catchup

	calla	get_his_action
	cmpi	act_pounced,a1
	jrne	pounce_miss		; miss = dont jump more

	calla	do_next_a9_frame	; backup (frame 5)
	sleep	4

	calla	set_ignore_y		; dont scroll up and down during pounce
	callr	pounce_ground_him

	clr	a0
	movi	r_pounce2,a11
	jsrp	pounce_jsrp
	calla	do_next_a9_frame	; backup (frame 5)
	sleep	4

	movi	>60000,a0
	calla	edge_pick_a0
	clr	a11
	jsrp	pounce_jsrp
	calla	do_next_a9_frame	; backup (frame 5)
	sleep	4

	jruc	local_reaction_exit


pounce_miss
	calla	set_no_block
	sleep	>0c
	calla	do_next_a9_frame	; backup (frame 5)
	sleep	4
	jruc	local_reaction_exit


pounce_jsrp
	mmtm	sp,a0,a11		; input: a0 = vel / a11 = his xfer
	movi	>00080008,a11
	calla	shake_a11
	calla	do_next_a9_frame
	mmfm	sp,a0,a11
	calla	set_x_vel

	movi	dont_touch,a0		; ignore flip status of me/him
	movi	->a0000,a1		; initial y vel
	movi	>c000,a2		; grav
	movk	2,a3			; ani speed
	jsrp	flight

	move	a11,a7
	jreq	blur_catchup
	calla	xfer_otherguy		; him = shake on back

blur_catchup
	movk	1,a0
	callr	local_ochar_sound	; ground shake sound
	movi	>00070004,a11
	calla	shake_a11

	movi	>12,a7
	move	a7,@f_norepell,w
	clr	a9
	callr	local_get_char_ani2
	calla	find_part2
	movk	3,a0
	jsrp	mframew			; blur catch up
;	calla	do_next_a9_frame	; backup (frame 5)
;	sleep	4
	retp


pounce_scan
	calla	sans_repell_3

	jruc	fff
	pull	a0
	pull	a0
fff

	movi	>12,a0			; nonboss = not blockable
	calla	q_is_he_a_boss
	jrnc	pounc4
	movi	>13,a0			; boss = blockable
pounc4	calla	strike_check_a0
	jrc	pounce_hit
	rets


pounce_hit
	pull	a0
	pull	a0
	calla	reset_proc_stack
	clr	a0
	movi	dont_touch,a1
	move	a1,a2
	move	a1,a3
	movi	pounce_adjust_him,a6
	jruc	pounce_fall

pounce_adjust_him
	calla	is_he_airborn
	jrnc	pounce_ground_him

	calla	stop_him
	calla	match_him_with_me
	movi	>00,a0
	movi	>20,a1
	jauc	adjust_him_xy

pounce_ground_him
	calla	stop_him
	move	*a13(p_otherguy),a0,l
	move	*a8(oxpos),*a0(oxpos),w
	jauc	ground_him

;************************************************************************

do_super_kang
	movi	act_superkang,a1
	calla	init_special_act

	movk	2,a0
	callr	local_ochar_sound
	movk	5,a0
	calla	local_ochar_sound  	; scream !!

	movi	>a0000,a0
	calla	towards_x_vel		; head towards opponent

	calla	get_x_dist		; a3 = x distance tween dudes
	subk	10,a3			; nudge factor
	jrp	supfly3
       	movk	1,a3			; no negative !!
supfly3	sll	16,a3
	movk	10,a1
	divs	a1,a3			; a3 = distance/speed = time
	srl	16,a3
	jrp	supfly1
	movk	1,a3			; no negative !!
supfly1	move	a3,a11

	movi	>200000,a1		; a1 = distance we want to travel up !
	divs	a3,a1			; a1 = height/time = y speed

	cmpi	>40000,a1
	jrls	supfly9
	movi	>40000,a1		; dont spaz out !!
supfly9	neg	a1
	move	a1,*a8(oyvel),l

	movk	3,a9			; animation table offset
	callr	local_get_char_ani2
	movk	1,a0
	calla	init_anirate
*
* fly
*
	movk	8,a10
supfly5	sleep	1
	dec	a10
	jrne	supfly6
	movk	1,a10			; from now on ---> do collision check

	movi	>13,a0
	calla	strike_check_a0		; collision ?
	jrc	supfly7
supfly6	calla	next_anirate		; haya !!
	dsjs	a11,supfly5
*
* collision = no
*
	movi	dont_touch,a0
	move	a0,a1
	movi	>a000,a2
	movi	never_ani,a3
	clr	a6
	jsrp	flight_call		; coast to a landing

	movk	3,a9
	calla	find_ani2_part2
    	movk	3,a0
	jsrp	mframew	    		; landing animation / return
	jruc	local_reaction_exit
*
* collision = yes
*
supfly7	movi	act_postattack,a0
	move	a0,*a13(p_action),w	; flag: i am done with my attack
	move	b2,b2			; blocked ?
	jrne	supfly8			; yeah

	jsrp	super_kick_land
	jruc	super_exit
*
* superkick blocked
*
supfly8
	movi	act_superk_sd,a1
	move	a1,*a13(p_action),w

	jsrp	super_kick_land
	clr	a9
	calla	get_char_ani
	calla	do_next_a9_frame
	calla	set_no_block	; be victim to attacks !!
	sleep	10		; for this long

super_exit
	jruc	local_reaction_exit


super_kick_land
	movi	act_superk_sd,a1
	move	a1,*a13(p_action),w	; tell da drones
	calla	stop_me
	sleep	20			; I'm into the DANGER ZONE !!!

	clr	a0
	clr	a1
	movi	>a000,a2
	movi	never_ani,a3
	clr	a6
	jsrp	flight

	movk	3,a9
	calla	find_ani2_part2
    	movk	3,a0
	jauc	mframew	    		; landing animation / return

;*************************************************************************

do_lk_bike
	movi	act_bike,a1
	calla	init_special_act	; initialize for special move

	movk	4,a0
	callr	local_ochar_sound

	movi	->90000,a0
	calla	away_x_vel
	move	a0,a11			; save x vel

	movi	>00010002,a9		; ani 2
	movi	->90000,a0
	movi	->38000,a1
	movi	>3000,a2
	movk	4,a3
	movi	bike_call,a6
	movk	6,a11			; ticks sans collision checks
	jsrp	flight_call
	retp

bike_call
	move	a11,a11
	jreq	bcall3
	dec	a11
	jruc	bcall9

bcall3	movi	>12,a0
	calla	strike_check_a0
	jrnc	bcall9

	pull	a0			; pull return
	pull	a0			; pull a10
	pullp	a0
	calla	stop_me

	calla	lights_on_hit

	move	b2,b2			; blocked bike kick ?
	jrne	bike_sitting_duck
*
* liu kang bike: HIT
*
	movi	act_bike,a0
	calla	update_his_hit_queue

	move	*a13(p_otherguy),a0,l
	calla	clear_inviso

	movi	biked_suspend,a7
	calla	takeover_him

	calla	is_he_facing_me		; he facing me ?
	jrc	lkbike0
	push	a8
	move	*a13(p_otherguy),a8,l
	calla	flip_multi	    	; no,flip him !
	pull	a8

lkbike0	calla	is_he_airborn
	jrnc	lkbike1			; hit on ground
*
* hit in air
*
	calla	get_x_dist
	cmpi	>30,a3			; too close ?
	jrhi	lkbike3			; no

	move	*a10(oypos),a7,w
	calla	match_him_with_me_f
	move	a7,*a10(oypos),w
	jruc	lkbike2

lkbike1	calla	match_him_with_me_f
	calla	ground_him
lkbike2	movi	->20,a0
	calla	adjust_him_x		; line him up at my feet !!

lkbike3
;	move	*a13(p_otherguy),a8,l

	movi	>20,a9
	calla	get_his_char_ani	; him = hit by bike kick
	calla	find_part2
	move	a9,a11

	movi	->50000,a0
	calla	away_x_vel
	movi	>50000,a0
 	calla	away_x_vel_him		; move at same speed
	sleep	1			; let velocities take place
*
* punching bag animation loop
*
	move	*a13(p_otherguy),a10,l
	movk	2,a9
	callr	local_get_char_ani2		; me = bike kick ani
	movk	3,a0
	calla	init_anirate

	movk	8,a0
	move	a0,*a13(p_store2),w

	movi	48,a0
lkbike4	move	a0,*a13(p_store1),w
	calla	next_anirate

	move	*a13(p_store2),a0,w
	dec	a0
	jrne	lkbike7
	calla	rsnd_med_smack
	movk	8,a0
lkbike7	move	a0,*a13(p_store2),w

	move	*a13(p_anicount),a0,w
	cmpi	3,a0	     		; did we just animate ?
	jrne	lkbike6	     		; no

   	push	a11
	movi	>00030003,a11
	calla	shake_a11    		; skake a bit
	pull	a11
	push	a9
	move	a11,a9
	calla	do_his_next_a9_frame	; animate him
	move	a9,a11
	pull	a9

lkbike6 	move	*a13(p_otherguy),a0,l
	move	*a0(oxvel),a0,l		; he still moving ?
	jrne	lkbike5			; yes
	calla	get_x_dist		; a3 = x distance
	cmpi	>30,a3
	jrhi	lkbike5
	calla	stop_me

lkbike5	sleep	1

	calla	sans_repell_3
	move	*a13(p_store1),a0,w
	dsj	a0,lkbike4
*
* done = fall to ground
*
	movi	r_bike_kicked_done,a7
	calla	takeover_him
	clr	a0
	clr	a1
	movi	>4000,a2
	movk	4,a3
	jsrp	flight
	jruc	local_reaction_exit
bcall9	rets


bike_sitting_duck
	movi	act_bike,a1

	movi	>00010002,a9		; ani 2
	movi	>10000,a0
	movi	->50000,a1
	movi	>4000,a2
	movk	4,a3
	jsrp	flight
	jauc	jump_up_land_jump

biked_suspend
	calla	inc_p_hit

	movi	act_bike,a0
	move	a0,*a13(p_hitby),w
	jauc	suspend_wait_action

;*************************************************************************

do_square_wave
	movi	act_square,a1
	calla	init_special_act

	movk	4,a0
	callr	local_ochar_sound 	; sonya fly sound

	movi	>16,a9
	calla	find_ani_last_frame
	calla	do_next_a9_frame
	movi	->c0000,a0
	move	a0,*a8(oyvel),l		; head straight up !!

lfly5	sleep	1
	calla	distance_off_ground
	cmpi	>60,a0
	jrlo	lfly5
*	
* now horizontal punch
*
	clr	a0
	calla	group_sound

	clr	a0
	move	a0,*a8(oyvel),l
	movk	3,a9
	calla	get_char_ani2
	movk	3,a0
	calla	init_anirate

	movi	>a0000,a0
	calla	towards_x_vel		; head towards opponent
	calla	face_opponent

	movi	>1a,a11
lfly4	sleep	1
	calla	next_anirate
	movk	>11,a0
	calla	strike_check_a0		; look for collision
	jrc	liz_fly_hit		; pow
	dsjs	a11,lfly4

square3	movi	>00010016,a9
	calla	pose_a9
	calla	face_opponent
	clr 	a0			; initial x vel
	movi	>20000,a1		; initial y vel
	movi	>8000,a2		; grav
	movi	never_ani,a3
	jsrp	flight
	jauc	jump_up_land_jsrp

liz_fly_hit
	calla	stop_me
	movi	>00020018,a9
	calla	pose_a9
	sleep	>0a

	movi	>20000,a0
	calla	away_x_vel     		; bounce away
	jruc	square3

;*************************************************************************

do_tele_explode
	move	*a8(oxvel),a5,l
	move	*a8(oyvel),a6,l
	mmtm	sp,a5,a6
	movi	act_tele_explode,a1
	move	a1,*a13(p_action),w
	calla	air_init_special
	mmfm	sp,a5,a6
	move	a5,*a8(oxvel),l
	move	a6,*a8(oyvel),l			; if moving --> keep moving

	movi	>00030007,a9
	jsrp	animate2_a9

	move	a8,a10				; a10 = my obj (for now)
	movk	2,a11				; start with ani2 part 2

dtex3	movk	7,a9
	callr	local_get_char_ani2
	move	a11,a14
	calla	find_part_a14

	move	*a9,a5,l
	calla	gso_dmawnz_np			; get obj sans palette
	move	*a10(ochar),*a8(ochar),w	; same ochar as player
	movi	character_palettes_1,a0
	calla	get_player_palette
	movi	oid_robo_limb,a0
	move	a0,*a8(oid),w
	calla	a8_front_plus_1

	move	a8,a0
	move	a10,a1
	calla	lineup_1pwm			; match up with robo
	calla	insobja8
	create	pid_robo_limb,robo_limb_out
	move	a10,a8
	inc	a11
	cmpi	9,a11
	jrne	dtex3

	movk	8,a0
	calla	create_fx			; explosion !!
	sleep	1

	calla	stop_me
	calla	set_nocol			; no collisions on me
	calla	set_inviso			; invisible
	calla	clear_shadow_bit		; no shadow while invisible
	callr	teleport_next_to		; next 2 him
	calla	face_opponent			; facing him
	calla	ground_player			; on the ground
	sleep	>0a

*
* implode !!
*
cyrax_implode
	move	a8,a10				; a10 = my obj (for now)
	movk	2,a11				; start with ani2 part 2

dtex5	movk	7,a9
	callr	local_get_char_ani2
	move	a11,a14
	calla	find_part_a14

	move	*a9,a5,l
	calla	gso_dmawnz_np			; get obj sans palette
	move	*a10(ochar),*a8(ochar),w	; same ochar as player
	movi	character_palettes_1,a0
	calla	get_player_palette
	movi	oid_robo_limb,a0
	move	a0,*a8(oid),w
	calla	a8_front_plus_1

	move	a8,a0
	move	a10,a1
	calla	lineup_1pwm			; match up with robo
	calla	insobja8
	create	pid_robo_limb,robo_limb_in
	move	a10,a8
	inc	a11
	cmpi	9,a11
	jrne	dtex5

	move	a0,a11
	movk	9,a0
	calla	create_fx			; implosion !!

dtex6	sleep	1
	move	*a11(pwake),a0,l
	cmpi	limb8,a0			; are we put 2-gether yet ??
	jrne	dtex6

	calla	clear_nocol			; collisions on me allowed now!
	calla	clear_inviso			; and viewable !!
	calla	set_shadow_bit			; no shadow while invisible

	movk	7,a9
	movk	3,a0
	jauc	backwards_ani2			; backwards ani / retp


robo_limb_in
	move	a9,*a13(p_store1),l		; save frame 1 here

	subk	2,a11
	sll	6,a11
	addi	limb_speeds,a11

	move	a11,a5
	move	*a5+,a0,l
	sll	3,a0				; quick multiply
	move	a0,a2				; 1/2 distance
	sll	1,a0				; quick multiply
	add	a2,a0

	move	*a5,a1,l
	sll	3,a1				; quick multiply
	move	a1,a2				; 1/2 distance
	sll	1,a1				; quick multiply
	add	a2,a1

	sra	16,a0
	sra	16,a1
	calla	multi_adjust_xy			; position at start of implode spot

	move	*a11+,a0,l
	move	*a11,a1,l

	move	a0,a2
	move	a1,a3
	sra	1,a2
	sra	1,a3
	add	a2,a0
	add	a3,a1				; implode 50% faster !!

	neg	a0
	neg	a1				; this time IMPLODE !!
	move	a1,*a8(oyvel),l
	movk	2,a1				; a1 = ani speed
	calla	set_proj_vel			

	movi	>10,a11				; # of ticks it will take to implode
limb5	sleep	1
	calla	next_anirate
	dsj	a11,limb5

	calla	stop_a8
	move	*a13(p_store1),a9,l		; get frame 1 here
	calla	frame_a9
	sleep	3				; show this for a sec before leaving

limb8	move	a8,a0
	calla	delobjp
	die


robo_limb_out
	subk	2,a11
	sll	6,a11
	addi	limb_speeds,a11
	move	*a11+,a0,l
	move	*a11,a1,l
	move	a1,*a8(oyvel),l
	movk	2,a1			; a1 = ani speed
	calla	set_proj_vel
limb3	sleep	1
	calla	next_anirate
	calla	scrtst
	jreq	limb3
	move	a8,a0
	calla	delobj
	die


lspeed	.set	>70000


limb_speeds
	.long	-lspeed,-lspeed		; left arm
	.long	0,-lspeed		; head
	.long	lspeed,-lspeed		; right arm
	.long	0,-(lspeed->20000)	; chest
	.long	0,lspeed		; waist
	.long	lspeed,lspeed		; right leg
	.long	-lspeed,lspeed		; left leg

;*************************************************************************

do_robo_air_grab
	movi	act_robo_airgrab,a1
	move	a1,*a13(p_action),w
	calla	air_init_special

	movk	6,a9
	calla	find_ani2_part2		; part 2 = lunge
	calla	do_next_a9_frame	; diving forward pose
	sleep	3

	movk	4,a0
	calla	init_anirate
	move	*a13(p_otherguy),a10,l
	movk	6,a11			; # of "close" ticks allowed

airs3	sleep	1

air_grab_sleep
	calla	next_anirate

	move	*a8(oxpos),a2,w
	move	*a8(oypos),a4,w
	move	*a10(oxpos),a1,w
	move	*a10(oypos),a3,w
	sub	a2,a1
	sub	a4,a3			; here is our direction vector !!!
	sll	16,a1
	sll	16,a3

	move	a1,a7
	move	a3,a14
	calla	get_rough_hypotenuse	; a14 = distance (roughly)
	sra	16,a14

	divs	a14,a1
	divs	a14,a3			; normalized vector

	movk	12,a5
	mpys	a5,a1
	mpys	a5,a3			; need 4 speed

	move	a1,*a8(oxvel),l
	move	a3,*a8(oyvel),l
	move	a1,a0
	calla	set_x_vel		; redirect me-self

;	calla	get_y_dist
;	cmpi	>30,a3
;	jrhi	airs3

	calla	is_he_airborn
	jrnc	air_grab_cancel		; he is on ground ---> cancel

	calla	get_x_dist
	cmpi	>45,a3	  		; super close ?
	jrhi	airs3			; no, loop
	dsj	a11,airs3		; yes, chalk up 1 "close" tick


air_grab_cancel
	movi	>19,a9
	calla	pose_a9			; pose: first frame of flip kick
	movi	dont_touch,a0		; initial x vel
	move	a0,a1			; initial y vel
	movi	>8000,a2		; grav
	movi	never_ani,a3		; ani speed
	jsrp	flight
	jauc	jump_up_land_jsrp

;*************************************************************************

do_robo_tele
	movi	act_robo_tele,a1
	move	a1,*a13(p_action),w
	calla	air_init_special

	movk	7,a0
	callr	local_ochar_sound

	movi	>0d,a9
	calla	get_char_ani
	calla	find_last_frame
	calla	do_next_a9_frame	; pose: teleport down

	movi	>68000,a0
	move	a0,*a8(oyvel),l		; start headin' downwards

	movi	>a000,a0
	move	a0,*a8(ograv),l

rtele3	sleep	1
	calla	distance_from_ground
	cmpi	0,a0
	jrgt	rtele3			; yes

	calla	match_me_with_him
	movi	->40,a0
	clr	a1
	calla	multi_adjust_xy		; line me up to hit him !!

	move	@ground_y,a1,w
	move	a1,*a8(oypos),w		; under otherguy

	movi	->90000,a0
	move	a0,*a8(oyvel),l
	movi	->6000,a0
	move	a0,*a8(ograv),l

	movk	3,a9
	callr	local_get_char_ani2		; teleport punch ani
	movk	5,a0
	calla	init_anirate

	clr	a0
	move	a0,*a13(p_store1),w	; flag: no collision made (yet)

rtele8	sleep	1
	calla	next_anirate
	move	*a8(oypos),a0,w
	move	*a13(p_ganiy),a1,w
	move	a0,a2
	sub	a1,a2
	cmpi	>30,a2
	jrhi	rtele9
	callr	tele_scan		; high enough to scan for collision
rtele9	cmp	a1,a0
	jrgt	rtele8			; wait for me to reach ground level

	movi	>f000,a0
	move	*a13(p_store2),a1,w	; type of collision
	jreq	rtelea
	movi	>b000,a0		; blocked = hang more (vulnerable)
rtelea	move	a0,*a8(ograv),l

	clr	a0
	movi	dont_touch,a1
	move	a1,a2
	move	*a13(p_anirate),a3,w
	movi	tele_scan2,a6
	jsrp	flight_call
	jauc	jump_up_land_jsrp

tele_scan2
	move	*a8(oyvel),a0,l
	jrnn	tele_no			; dont check while heading down

tele_scan
	move	*a13(p_store1),a0,w
	jrne	tele_no		   	; collision already made ---> exit

;******
	.if ejbbug
	jruc	sss
	pull	a0
	calla	reset_proc_stack	; for debugging collision box size
sss
	.endif
;******

	movi	act_robo_tele_sd,a0
	move	a0,*a13(p_action),w

	movi	>13,a0
	calla	strike_check_a0
	jrnc	tele_no

	move	b2,a0
	move	a0,*a13(p_store2),w	; flag: collision made

	movk	1,a0
	move	a0,*a13(p_store1),w	; flag: collision made
tele_no	rets

;*************************************************************************

do_lao_angle
	movi	act_lao_angle,a1
	move	a1,*a13(p_action),w
	calla	air_init_special

	clr	a0
	calla	group_sound	 	; attack voice
	clr	a0
	callr	local_ochar_sound 	; angle kick sound

	movi	>19,a9
	movi	->80000,a0
	movi	>30000,a1
	movi	>4000,a2

	movk	2,a3
	movi	lao_angle_scan,a6
	jsrp	flight_call
	jauc	jump_up_land_jsrp


lao_angle_scan
	move	*a9,a0,l		; leg extended ?
	jrne	srs4			; no
	movi	>12,a0			; stk table offset
	calla	strike_check_a0
	jrc	lao_angle_hit
srs4	rets


lao_angle_hit
	pull	a0
	pull	a0
	calla	reset_proc_stack
	calla	stop_me			; freeze in the air

	move	b2,b2
	jrne	lao_angle_blocked
	sleep	6
	clr	a0
	clr	a1
	movi	>8000,a2
	movi	never_ani,a3
	jauc	land_on_yer_feet


lao_angle_blocked
	movi	act_lao_sd,a0
	move	a0,*a13(p_action),w
	movk	>1a,a9
	calla	get_char_ani
	addi	32,a9			; rolled in a ball ani
	movi	>4000,a0
	movi	->70000,a1
	movi	>6000,a2
	movk	3,a3
	jsrp	flight
	jauc	jump_up_land_jump

;*************************************************************************

do_lao_tele
	movi	act_lao_tele,a1
	calla	init_special_act		; i can't block !!

	movk	4,a0
	callr	local_ochar_sound		; teleport sound

	clr	a9
	callr	local_get_char_ani2
	calla	do_next_a9_frame		; tele frame #1
	movk	2,a0
	calla	init_anirate

	movi	->80000,a0
	move	a0,*a8(oyvel),l
	movi	->10000,a0
	move	a0,*a8(ograv),l			; negative gravity

hht4	sleep	1
	calla	next_anirate
	calla	distance_off_ground
	cmpi	>e8,a0
	jrlt	hht4				; zip off the top of the screen

	callr	teleport_next_to
	calla	face_opponent

	move	@ground_y,a1,w
	subi	>60,a1
	move	a1,*a8(oypos),w

	movi	>8000,a0
	move	a0,*a8(ograv),l
	movi	->a0000,a0
	move	a0,*a8(oyvel),l

hht6	sleep	1
	move	*a8(oypos),a0,w
	subi	>10,a0			; make a little more powerful
	move	*a13(p_ganiy),a1,w
	cmp	a1,a0
	jrhi	hht6

	calla	am_i_joy
	jrnc	hht8
	movi	bt_jump,b0
	calla	stuff_buttons		; joy = let him punch / kick

	clr	a9
	calla	find_ani2_part2
	clr	a0
	move	*a8(oyvel),a1,l
	move	*a8(ograv),a2,l
	movi	5,a3
	jsrp	flight
	retp
*
* drone = do jump up kick / punch
*
hht8	movi	do_jumpup_punch,a7
	move	@rand,a0,l
	jrn	hht9
	movi	do_jumpup_kick,a7
hht9	jump	a7


teleport_next_to
	movi	>54,a9				; positive = in front
	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a3,w			; a3 = his x
	move	@right_edge,a1,w
	addi	scrrgt,a1			; a1 = right side of universe
	sub	a3,a1
	abs	a1
	cmpi	>80,a1
	jrls	tnt4				; he's too close to right edge
	move	@left_edge,a1,w
	sub	a3,a1
	abs	a1
	cmpi	>80,a1
	jrls	tnt4				; he's too close to left edge
	neg	a9				; melt up behind the other player !!
tnt4	calla	match_me_with_him
	clr	a1
	move	a9,a0
	jauc	multi_adjust_xy			; shift next to opponent

;************************************************************************

do_lia_stay_afloat
	calla	air_init_special
	movk	2,a9
	callr	local_get_char_ani2
	calla	find_part2
	addi	32*6,a9			; hover part of animation
	calla	back_to_normal
	movi	act_hover,a1
	move	a1,*a13(p_action),w
	jruc	main_hover_loop


do_lia_fly
	movi	act_hover,a1
	callr	local_init_special_act

	movk	2,a9
	callr	local_get_char_ani2
	calla	set_ignore_y   		; don't scroll up and follow me

	clr	a0
	callr	set_float_ani
*
* initial UP !!
*
	movk	5,a0
	callr	local_ochar_sound

	movi	->6000,a0
	move	a0,*a8(ograv),l		; initial upwards accelerate
	movi	>60000,a10     		; maximum speed
	movi	>d0,a11

hover0	callr	hover_sleep_1
	calla	distance_from_ground
	cmpi	>c0,a0
	jrlt	hover0

	calla	back_to_normal
	movi	act_hover,a1
	move	a1,*a13(p_action),w

	clr	a0
	callr	set_float_ani
	calla	find_part2

	movi	>5000,a0
	move	a0,*a8(ograv),l		; down
	jsrp	settle_down

main_hover_loop
	calla	distance_from_ground
	move	a0,a5		    	; a5 = distance from ground...
*
* left / right movement
*
	calla	is_stick_right
	jrnc	hover2

	movi	>8000,a11
	callr	accelerate_x		; stick right ---> accelerate right
	callr	flight_move_ani
	jruc	xdamp9

hover2	calla	is_stick_left
	jrnc	xdamp1

	movi	->8000,a11
	callr	accelerate_x		; stick left ---> accelerate left
	callr	flight_move_ani
	jruc	xdamp9
*
* x velocity damping
*
xdamp1	move	*a8(oxvel),a0,l
	jreq	xdamp7
	move	a0,a1
	sra	4,a1
	jreq	xdamp4			; damp = tiny ---> stop already !!
	cmpi	-1,a1
	jrne	xdamp8			; damp = tiny ---> stop already !!
xdamp4	move	a0,a1			; small enough ---> its ZERO ALREADY !
xdamp8	sub	a1,a0
	calla	set_x_vel

xdamp7	move	*a13(p_store3),a2,w
	jreq	xdamp9			; float ani ---> we cool
	cmpi	3,a2
	jreq	xdamp9

	movk	3,a0
	cmpi	1,a2
	jreq	xdamp6			; charge forward ---> uncharge
	movk	4,a0
	cmpi	2,a2			; backoff ---> unbackoff
	jrne	xdamp9	

xdamp6	callr	set_float_ani		; slowed down ---> back to float ani

xdamp9	movi	>4000,a6		; stick not up gravity change
	calla	is_stick_up		; stick up ?
	jrnc	hover3			; no
*
* stick = up
*
	movi	->c000,a6		; gravity change
;	cmpi	>100,a5			; too high in the air ??
	cmpi	>e0,a5			; too high in the air ??
	jrlo	hoverd			; no
	movi	>2000,a6		; too high = head down
	jruc	hoverd
*
* heading down ---> pull up
*
hover3	cmpi	>d5,a5
	jrhi	hover5
	movi	->3000,a6
	jruc	hoverd
*
* heading up ---> pull down
*
hover5	cmpi	>d8,a5
	jrlo	hovers
	movi	>3000,a6

hoverd	move	a6,*a8(ograv),l
	move	*a8(oyvel),a0,l
	movi	>30000,a1
	cmp	a1,a0
	jrgt	hovd3
	neg	a1
	cmp	a1,a0
	jrlt	hovd3
	jruc	hovers
hovd3	move	a1,*a8(oyvel),l
hovers	callr	hover_sleep_1
	jruc	main_hover_loop


settle_down
	callr	hover_sleep_1
	move	*a8(oyvel),a5,l
	jrn	settle_down  		; heading up ---> loop

	calla	distance_from_ground
	cmpi	>e0,a0
	jrhi	settle_down

	movi	->6000,a6
	move	a6,*a8(ograv),l		; pull up
settle3	callr	hover_sleep_1
	move	*a8(oyvel),a5,l
	abs	a5
	cmpi	>10000,a5
	jrhi	settle3
	retp


flight_move_ani
	move	*a8(oxvel),a0,l
	abs	a0
	cmpi	>60000,a0
	jrlo	fmi7			; slow ---> dont change ani

	move	*a13(p_store3),a1,w
	cmpi	1,a1
	jreq	fmi7
	cmpi	2,a1
	jreq	fmi7			; already using ani ---> skip

	movk	1,a0			; 1 = charge forward
	movi	is_he_left,a6
	move	a11,a11
	jrn	fmi3
	movi	is_he_right,a6
fmi3	call	a6
	jrc	fmi5
	movk	2,a0			; 2 = backoff
fmi5	push	a0
	calla	face_opponent
	pull	a0
	callr	set_float_ani
fmi7	rets


accelerate_x
	move	a11,a0
	move	*a8(oxvel),a1,l
	add	a0,a1
	movi	->80000,a2
	cmp	a2,a1			; too fast negative ??
	jrgt	acc4
	move	a2,a1
	jruc	acc8
acc4	cmpi	>80000,a1		; too fast positive ??
	jrlt	acc8
	movi	>80000,a1
acc8	move	a1,a0
	calla	set_x_vel
	rets

hover_sleep_1
	pull	a0			; return address
	pushp	a0
	movk	2,a0
	move	a0,@f_norepell,w	; dont repell us during this
	sleep	1
	calla	next_anirate
	pullp	a7

	calla	check_block_bit
	jrc	hover_land
	jump	a7


set_float_ani
	push	a0
	move	a0,*a13(p_store3),w
	addk	2,a0
	move	a0,a9
	callr	local_get_char_ani2
	pull	a0

	sll	4,a0
	addi	float_ani_speeds,a0
	move	*a0,a0,w
	jauc	init_anirate

float_ani_speeds
	.word	6	; 0 - up
	.word	3	; 1 - forward
	.word	3	; 2 - back
	.word	3	; 3 - unforward
	.word	3	; 4 - unbackoff

hover_land
	clr	a0
	callr	set_float_ani
	calla	face_opponent

	movi	dont_touch,a0		; initial x vel
	movi	dont_touch,a1		; initial y vel
	movi	>a000,a2		; grav
	movk	4,a3
	jsrp	flight

	calla	reset_proc_stack
	jauc	jump_up_land_jump

;************************************************************************

ind_charge
	movi	act_ind_charge,a1
	callr	local_init_special_act
	movk	4,a9
	callr	local_get_char_ani2

	movk	8,a0
	callr	local_ochar_sound	; shadow shoulder sound

	movk	1,a0
	calla	create_fx
	calla	clear_shadow_bit 	; no shadow while in "shadow kick mode"

	movk	1,a0
	calla	towards_x_vel		; just so we are not exactly "0"

	calla	do_next_a9_frame
	sleep	2
	calla	do_next_a9_frame
	sleep	2

	movi	>90000,a0
	calla	towards_x_vel
	calla	do_next_a9_frame

	movi	20,a11
indc3	sleep	1
	movi	>11,a0
	calla	strike_check_a0
	jrc	icharge_hit
	dsj	a11,indc3

icharge_hit
	calla	stop_me
	movi	act_icharge_sd,a0
	move	a0,*a13(p_action),w
	sleep	>10

	movk	4,a9
	calla	find_ani2_part2
	movk	3,a0
	jauc	mframew			; and then retp

;************************************************************************

sonya_bike_kick
	movi	act_sbike,a1
	callr	local_init_special_act

	movk	3,a0
	calla	local_ochar_sound	; bike sound fx
	movk	5,a0
	calla	local_ochar_sound	; bike speech

	movi	>00020001,a9
	jsrp	animate2_a9		; intro part

	movk	4,a0
	calla	init_anirate

	movi	>40000,a0
	calla	towards_x_vel
	movi	->20000,a0
	move	a0,*a8(oyvel),l
	movi	->c000,a0
	move	a0,*a8(ograv),l		; negative gravity

	calla	set_nocol		; now this is POWER !!!

bike3	sleep	1
	calla	sans_repell_3

	calla	get_his_action
	cmpi	act_duck,a1
	jreq	bike4
	cmpi	act_blocklo,a1
	jreq	bike4			; he is ducked = no collision check !!

	movi	>14,a0
	calla	strike_check_a0
	jrc	bike_hit

bike4	calla	next_anirate
	calla	distance_from_ground
	cmpi	>c0,a0
	jrlo	bike3
*
* miss
*
	movi	act_sbike_sd,a0
	move	a0,*a13(p_action),w
	calla	clear_nocol		; no more

	movi	dont_touch,a0		; initial x vel
	movi	dont_touch,a1		; initial y vel
	movi	>a000,a2		; grav
	movk	4,a3
	movi	bike_scan_call,a6
	jsrp	flight_call
	jruc	local_retp


bike_hit
	movi	act_sbike_sd,a1
	move	a1,*a13(p_action),w	; I am a duck !!

;***********
	movi	clear_inviso,a0
	calla	calla_for_him
;***********

	move	b2,b2
	jrne	bike_blocked

	movi	>00030030,a11
	calla	shake_a11		; start a long shake !!

	push	a9
	movi	>20,a11
	calla	get_his_a11_ani
	move	a11,a9
	calla	find_part2		; his ani = repeating stumble
	move	a9,a11
	pull	a9

	calla	double_next_a9
;	movi	act_bike,a0
	calla	xfer_him_to_flipped_pause

	calla	inc_his_p_hit
	calla	stop_me
	calla	stop_him

	movk	4,a0
	calla	init_anirate

	movk	1,a0
	move	a0,*a13(p_store2),w

	movi	>30000,a0
	calla	towards_x_vel
	movi	->30000,a0
	move	a0,*a8(oyvel),l
	move	a0,*a10(oyvel),l

	movi	>20,a0
bike6  	move	a0,*a13(p_store1),w
	sleep	1
	callr	bike_hit_call
	calla	distance_from_ground
	cmpi	>e0,a0
	jrhi	bike8
	move	*a13(p_store1),a0,w
	dsj	a0,bike6

bike8	movi	>10000,a0
	calla	towards_x_vel
	movi	>8000,a0
	move	a0,*a8(oyvel),l
	move	a0,*a10(oyvel),l

	movi	>10,a0
bike7  	move	a0,*a13(p_store1),w
	sleep	1
	callr	bike_hit_call
	move	*a13(p_store1),a0,w
	dsj	a0,bike7
*
* release the other guy
*
	movi	pid_shaker,a0
	calla	dallprc

 	movk	1,a10
	calla	xfer_him_to_a10_r

	movi	act_sbike_kicked,a1
	calla	set_his_p_action

	movk	1,a9
	callr	local_get_char_ani2
	movk	3,a14
	calla	find_part_a14
	movk	4,a0
	jsrp	mframew	 	    	; get out of bike kick animation
*
* and land
*
	movi	>00010016,a9
	calla	pose_a9
	calla	face_opponent
	clr 	a0			; initial x vel
	movi	>20000,a1		; initial y vel
	movi	>8000,a2		; grav
	movi	never_ani,a3
	jsrp	flight
	jauc	jump_up_land_jsrp


bike_blocked
	clr 	a0			; blocked x stop x vel
	movi	->60000,a1
	movi	>8000,a2		; grav
	movk	4,a3
	jsrp	flight
	jauc	jump_up_land_jsrp


bike_scan_call
	movk	3,a0
	move	a0,@f_norepell,w
	rets


bike_hit_call
	movk	3,a0
	move	a0,@f_norepell,w

	move	*a13(p_store2),a0,w
	dec	a0
	jrne	bike9
	calla	rsnd_smack
	movk	7,a0
bike9	move	a0,*a13(p_store2),w

	calla	match_him_with_me_f
	movi	>ffe0ffd0,a0
	calla	adjust_him_a0

	move	*a8(ograv),*a10(ograv),l
	move	*a8(oxvel),*a10(oxvel),l
	move	*a8(oyvel),*a10(oyvel),l

	move	a9,a5
	calla	next_anirate
	cmp	a9,a5
	jreq	bhc4

	calla	advance_him

bhc4	rets


set_his_p_action
	move	*a13(p_otherproc),a0,l
	movi	act_sbike_kicked,a1
	move	a1,*a0(p_action),w	; define his action !!!
	rets

;************************************************************************

kano_cannon_ball
	callr	local_init_special

	movk	4,a0
	callr	local_ochar_sound

	calla	set_noflip
	movi	act_kano_roll,a0
	move	a0,*a13(p_action),w
	movi	>a0000,a0
	calla	towards_x_vel

	clr	a0
	movi	>10,a1
	calla	multi_adjust_xy		; lower me a bit

	movi	>1a,a9
	calla	get_char_ani
	addi	32,a9			; a9 ---> ball roll ani
	movk	3,a0
	calla	init_anirate		; spin animation speed

	movi	>1a,a11			; how long to spin

kroll5	sleep	1

	cmpi	>1a-6,a11
	jrhi	kroll4			; dont scan on 1st 6 tix !
	movi	>13,a0
	calla	strike_check_a0
	jrc	kroll_hit
kroll4	calla	next_anirate		; animate
	dsjs	a11,kroll5

kroll6	calla	stop_me
	calla	ground_player
	jruc	local_reaction_exit		; get out of this smoother (ejbpatch)


kroll_hit
	movi	act_kroll_sd,a0
	move	a0,*a13(p_action),w	; sitting duck mode !!

	movi	>00070008,a0		; hit / blocked sound
	calla	hit_or_blocked_sound

	movi	>50000,a0
	movi	->80000,a1
	mmtm	sp,a0,a1
	movi	>1a,a9
	calla	get_char_ani
	addi	32,a9
	mmfm	sp,a0,a1

	move	b2,b2			; blocked
	jreq	kroll8			; no
	movi	>10000,a0
	movi	->80000,a1		; yes ---> "sitting duck"

kroll8	movi	>6000,a2
	movk	2,a3
	jsrp	flight
	jauc	jump_up_land_jsrp

;************************************************************************

jax_dash_punch
	movi	act_jax_dash,a1
	callr	local_init_special_act

	movk	3,a0
	callr	local_ochar_sound

	movk	2,a9
	callr	local_get_char_ani2
	move	a9,a10
	movi	>00030002,a0
	jsrp	animate_a0_frames

	movi	>a0000,a11
	move	a11,a0
	calla	towards_x_vel
	calla	do_next_a9_frame

	movk	8,a10
dash2	sleep	1
	movi	>10,a0
	calla	strike_check_a0
	jrc	dash_hit
	dsj	a10,dash2

	move	*a8(oxvel),*a13(p_store1),l	; save vel
*
* slow down
*
	movi	>10,a10
dash3	sleep	1

	move	*a8(oxvel),a0,l
	move	a0,a6
	move	*a13(p_store1),a5,l 	; save vel
	sra	31,a6
	sra	31,a5
	cmp	a5,a6	   		; heading in correct direction?
	jreq	dash5	   		; yes
	clr	a0	   		; no, zero !!

dash5	move	a0,a1
	sra	5,a1
	sub	a1,a0
	calla	set_x_vel

	cmpi	5,a10
	jrlo	dash4			; moving slow ---> no collision check
	movi	>10,a0
	calla	strike_check_a0
	jrc	dash_hit

dash4	dsj	a10,dash3
	jruc	dash_unblur


dash_hit
	callr	no_action

	move	b2,b2
	jrne	dash_blocked

	move	*a8(oxvel),a0,l
	abs	a0
	cmpi	>40000,a0
	jrlo	dash6
	movi	>40000,a0
	calla	towards_x_vel		; max speed after hit

dash6	movi	>20,a0
	move	a0,@f_norepell,w	; allow us to overlap !!
	sleep	4

dash_unblur
	movk	2,a9
	calla	find_ani2_part2
	movk	5,a0
	jsrp	mframew
	jruc	local_retp

dash_blocked
	calla	stop_me
	sleep	4
	jruc	dash_unblur

;************************************************************************

do_sz_decoy
	calla	air_init_special

	movi	act_sz_decoy,a1
	move	a1,*a13(p_action),w

	movi	l_sz_decoy,a0
	calla	update_tsl

	movi	pid_decoy1*>10000+pid_decoy2,a0
	calla	p1p2_pick
	move	a0,a1
	movi	decoy_proc,a7
	calla	getprc
	move	*a13(p_otherguy),*a0(p_otherguy),l
	move	*a13(p_otherproc),*a0(p_otherproc),l

	movk	4,a0
	callr	local_ochar_sound

	movi	>1b,a9
	calla	get_char_ani
	addi	32,a9			; backward flip ani
	movi	>60000,a0
	movi	->60000,a1
	movi	angle_grav,a2
	movk	3,a3
	jsrp	flight
*
* replace with generic land routine (ejbpatch)
*
	movi	act_land,a1
	move	a1,*a13(p_action),w	; action: landing on the ground
	calla	face_opponent
	movi	>1a,a9
	calla	get_char_ani
	calla	do_next_a9_frame
	sleep	3   	  		; allow moves during this sleep (ejbpatch)
	jruc	local_retp


decoy_proc
	move	*a8(oid),*a13(p_store1),w
	move	a9,a10			; save where I was
	clr	a9
	calla	get_char_ani		; get stance ani to make new obj
	move	a8,a11			; a11 = original subzero
	calla	gmo_proc		;  a8 = decoy object
	move	a0,*a13(p_store3),l	; save dummy proc here

	mmtm	sp,a8,a11
	move	a8,a0
	move	a11,a8
	calla	match_ani_points	; lineup with sz
	mmfm	sp,a8,a11

	move	*a11(oflags),*a8(oflags),w
	move	*a11(ochar),*a8(ochar),w
	move	*a11(oshape),a0,l
	calla	ani2			; decoy obj = same shape as subzero

	calla	player_froze_pal	; decoy = froze pal
	calla	insobja8
	movk	3,a0
	calla	create_fx		; freeze blast about a8

	movk	10,a10
decoy2	movi	->04,a0
	clr	a1
	calla	multi_adjust_xy
	sleep	1
	dsj	a10,decoy2
*
* decoy collision checks
*
	calla	q_is_he_a_boss
	jrc	decoy9

	movi	>40,a11			; vs joy = longer
	calla	is_he_joy
	jrc	decoy3
	movi	>2a,a11			; vs drone = shorter
decoy3	sleep	1
	callr	decoy_collision_check
	jrc	decoy9
	dsjs	a11,decoy3

	movk	6,a9
	jsrp	shake_and_collision

decoy9	calla	reset_proc_stack

	movk	4,a0
	callr	local_ochar_sound

	movk	3,a0
	calla	create_fx		; freeze blast about a8
	sleep	>0c			; let the effect take place
	move	*a13(p_store3),a0,l	; dummy proc
	calla	kill			; kill "data storage" process
	move	a8,a0
	calla	delobjp
	die


shake_and_collision
	move	*a8(oxpos),a0,w	
	addk	3,a0
	move	a0,*a8(oxpos),w
	movk	3,a11
sac4	sleep	1
	callr	decoy_collision_check
	jrc	decoy9
	dsjs	a11,sac4

	move	*a8(oxpos),a0,w	
	subk	3,a0
	move	a0,*a8(oxpos),w
	movk	3,a11
sac5	sleep	1
	callr	decoy_collision_check
	jrc	decoy9
	dsjs	a11,sac5
	dsj	a9,shake_and_collision
	retp


decoy_collision_check
	push	a8
	calla	highest_mpart		; a0 = highest
	calla	lowest_mpart		; a1 = lowest
	calla	leftmost_mpart		; a2 = leftmost
	calla	rightmost_mpart		; a3 = rightmost

	move	a2,a4
	sub	a3,a4
	abs	a4			; a4 = width of me
	move	a4,a7
	srl	3,a7			; a7 = 1/8 wideness
	srl	2,a4			; a4 = 1/2 wideness
	add	a7,a4			; a4 = 4/8 + 1/8 = 5/8 wideness
	add	a4,a2
	sub	a4,a3			; squeeze in the left and right edges

	move	a0,a4
	sub	a1,a4
	abs	a4			; a4 = my height
	move	a4,a7
	srl	3,a7			; a7 = 1/8 wideness
	srl	2,a4			; a4 = 1/2 wideness
	add	a7,a4			; a4 = 4/8 + 1/8 = 5/8 wideness
	add	a4,a0
	sub	a4,a1			; squeeze in the top and bottom

	mmtm	sp,a0,a1,a2,a3
	move	*a13(p_otherguy),a8,l
	calla	highest_mpart		; a0 = highest
	calla	lowest_mpart		; a1 = lowest
	calla	leftmost_mpart		; a2 = leftmost
	calla	rightmost_mpart		; a3 = rightmost

	mmfm	sp,a4,a5,a6,a7		; restore my edge coordinates
	pull	a8			; retore me

	cmp	a4,a1			; my highest vs. his lowest
	jrlt	dec_no			; miss
	cmp	a5,a0			; my lowest vs his highest
	jrgt	dec_no			; miss
	cmp	a6,a3			; my leftmost vs his rightmost
	jrlt	dec_no			; miss
	cmp	a7,a2			; my rightmost vs his leftmost
	jrgt	dec_no			; miss

	calla	disable_his_buttons 	; dont let him break out !
	movi	r_decoy_freeze,a7
	calla	xfer_otherguy		; hit = freeze him
	setc				; carry set = hit
	rets

dec_no	clrc
	rets

;************************************************************************

local_get_char_ani2
	jauc	get_char_ani2

local_reaction_exit
	jauc	reaction_exit

local_init_special
	jauc	init_special

local_init_special_act
	jauc	init_special_act

local_retp
	retp

local_ochar_sound
	jauc	ochar_sound

no_action
	clr	a1
	move	a1,*a13(p_action),w	; action: landing on the ground

local_rets
	rets

;************************************************************************

	.end

