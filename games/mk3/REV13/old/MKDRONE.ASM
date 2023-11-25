**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: DRONE CODE										*
* 											     *
*  copyright (c) 1995 Midway Manufacturing							*
*											     *
**************************************************************************
	.file	'mkdrone.asm'
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
	.include	diagaudn.asm
	.text


drone_begin
	calla	ochar_begin_calls
	jruc	drone_proc

drone_proc
	callr	d_init
	jsrp	wait_for_start		; stay in stance till fight starts

d_cornered
	move	a0,a0			; ejbpatch

drone_entry
	calla	reset_proc_stack	; make things kosher
	callr	d_to_normal
	calla	check_winner_status
	callr	d_beware
	calla	stance_setup		; set things up for "stance" ani
	calla	am_i_facing_him
	jrnc	d_turnaround

	callr	boss_branch
	.word	>10

	calla	am_i_short
	jrnc	d_choose
	jsrp	d_backup_jsrp

d_choose
	callr	hangout_check

	callr	q_is_he_reacting
	jrc	d_wait_finish_react

d_attack
	callr	q_am_i_cornered
	jrc	cornered_attack
*
* attack according to distance
*
	callr	d_get_x_dist
	cmpi	>45,a3
	jrlo	d_attack_very_close
	cmpi	>78,a3
	jrlo	d_attack_close

;	cmpi	>d0,a3
	cmpi	>f0,a3
	jrlo	d_attack_far

;************************************

d_attack_very_far
	callr	q_airborn_counter
	jrc	very_far_airborn

	callr	random_do
	.word	4
	.long	d_fflip_jump
	.long	run_in_close
	.long	run_in_close
	.long	d_zap

very_far_airborn
	jruc	d_zap

;************************************

d_attack_far
	callr	q_airborn_counter
	jrc	far_airborn

	callr	random_do
	.word	5
	.long	stalk_in_close
	.long	run_in_close
	.long	perhaps_flipk
	.long	d_zap
	.long	d_propell_attack

far_airborn
	jruc	d_fflip_jump

;************************************

d_attack_close
	callr	q_airborn_counter
	jrc	close_airborn

	callr	q_is_kano_charging
	jrnc	acl4			; dont worry
	movi	rpt_anti_kano,a0
	callr	ask_mr_diff		; written in the starz ?
	jrc	close_kano		; yes

acl4	callr	random_do
	.word	6
	.long	d_sweep_kick
	.long	d_lo_kick
	.long	d_stalk_crossk
	.long	d_rapid_lo
	.long	d_walk_in_4_combos
	.long	d_propell_attack

close_kano
	jruc	run_in_close_now

close_airborn
	calla	is_towards_me
	jrc	d_jump_up_kick		; heading at me ---> jump up kick
	jruc	d_fflip_kick_jump

;************************************

d_attack_very_close
	callr	q_airborn_counter
	jrc	very_close_airborn

	callr	nr_kano_abuser_check
	callr	random_do
	.word	4
	.long	d_elbow
	.long	d_knee
	.long	d_slam
	.long	d_stalk_crossk

very_close_airborn
	jruc	d_jump_up_kick		; close 2 me ---> jump up kick

;************************************

cornered_attack
	movi	rpt_cornered,a0
	callr	ask_mr_diff
	jrc	run_in_close		; agressive = charge in !!!
	jruc	stalk_in_close		; wuss = walk in

rpt_cornered
	.word	100,100,100,250,333,400,450,600,700,750

;************************************

q_airborn_counter
	calla	is_he_airborn
	jrnc	q_no			; he is on ground ---> sans
	movi	rpt_counter_airborns,a0
	jruc	ask_mr_diff

rpt_counter_airborns
	.word	100,100,100,250,333,550,600,700,750,750

;************************************

d_walk_in_4_combos
	movi	>30,a10
	movi	>4a,a11
	jsrp	d_stalk_a11		; try 2 get close in !!
	jreq	d_reaction_exit		; oh well...
	callr	random_do
	.word	2
	.long	d_elbow
	.long	d_knee

d_stalk_a11_ntl
	movi	>40*500,a10   		; ntl = no time limit

d_stalk_a11
	calla	face_opponent
	callr	d_walkf_setup

dstk3	calla	am_i_facing_him
	jrnc	d_turnaround
	sleep	1
	callr	d_check_winner_status
	callr	d_next_anirate
	callr	d_beware
	callr	d_get_x_dist  		; a3 = distance tween us
	cmp	a11,a3	    		; within range ?
	jrlo	dist_retp   		; yes, exit
	dsj	a10,dstk3   		; max time to wait
	jruc	dist_retp


d_run_a11
	calla	run_setup
drun3	calla	am_i_facing_him
	jrnc	d_turnaround
	sleep	1
	calla	reduce_turbo_bar
	callr	d_check_winner_status
	callr	d_next_anirate
	callr	d_beware
	callr	d_get_x_dist  		; a3 = distance tween us
	cmp	a11,a3	    		; within range ?
	jrlo	dist_retp   		; yes, exit
	dsj	a10,drun3   		; max time to wait
	jruc	dist_retp


d_retreat_a11
	calla	face_opponent
	callr	d_walkb_setup

dret3	calla	am_i_facing_him
	jrnc	d_turnaround
	sleep	1
	callr	d_next_anirate
	callr	d_beware

	callr	d_either_edge_a5
	cmpi	>50,a5
	jrlo	d_cornered		; too close to edge of world !!

	callr	d_get_x_dist  		; a3 = distance tween us
	cmp	a11,a3	    		; within range ?
	jrhi	dist_retp   		; no, keep walking
	dsj	a10,dret3   		; max time to wait
	jruc	dist_retp

dist_retp
	callr	d_stop_me
	retp

d_wait_finish_react
	callr	d_get_x_dist
	cmpi	>60,a3
	jrlo	d_backoff_a_bit
	movi	q_is_he_reacting,a11
	movi	>60,a10				; max wait time
	jsrp	stance_wait_no
	jruc	d_reaction_exit

d_backoff_a_bit
	movi	>40*1,a10
	movi	>80,a11
	jsrp	d_retreat_a11		 ; sweep kick relief = back up
	jruc	d_reaction_exit


stalk_in_close
	movi	>40*100,a10
	movi	>40,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance
	jruc	d_attack_close


perhaps_flipk
	callr	d_get_x_dist
	cmpi	>b5,a3
	jrlo	stalk_in_close
	cmpi	>f0,a3
	jrhi	stalk_in_close 		; out o range !!

	callr	frontflip_setup
	movi	flipk_scan,a6
	jsrp	d_fflip_scan_jsrp
	jruc	d_reaction_exit


d_flip_punch_jump
	callr	frontflip_setup
	movi	flipp_scan,a6
	jsrp	d_fflip_scan_jsrp
	jruc	d_reaction_exit



run_in_close
	move	@diff,a0,w
;	cmpi	3,a0
	cmpi	4,a0
	jrlo	perhaps_flipk

run_in_close_now
	movi	>40,a10
	movi	>40,a11
	jsrp	d_run_a11		; run till at a11 distance
	callr	nr_kano_abuser_check

	move	@diff,a0,w
	cmpi	6,a0
	jrhs	run_in_close_hard

	calla	is_he_short
	jrc	d_knee
	calla	is_he_blocking
	jreq	d_sweep_kick

	callr	random_do
	.word	3
	.long	d_elbow
	.long	d_knee
	.long	d_sweep_kick

run_in_close_hard
	callr	random_do
	.word	3
	.long	d_elbow
	.long	d_knee
	.long	d_slam

;**********************************************************************

d_propell_attack
	move	@diff,a0,w
	cmpi	3,a0
	jrlo	diff_no_propell

	movi	ochar_props,a0
	callr	d_get_char_word
	jrn	stalk_in_close
	jruc	d_body_propell


diff_no_zap
diff_no_propell
	callr	d_get_x_dist
	cmpi	>48,a3
	jrlo	d_lo_kick		; in close = lo kick
	jruc	stalk_in_close		; further out = stalk


ochar_props
	.word	0	; 0 kano = ball roll
	.word	-1	; 1
	.word	3	; 2 jax = dash punch
	.word	2	; 3 ind = charge
	.word	>10	; 4 subzero slide
	.word	>11	; 5 swat zoom
	.word	-1	; 6
	.word	8	; 7 - katsup
	.word	-1	; 8
	.word	>06	; 9 - kung lao tele
	.word	>13	;10 - tusk blurr
	.word	>0f	;11 - sheeva pounce
	.word	-1	;12
	.word	>0d	;13 - lk bike
	.word	-1	;14
	.word	-1	;15
	.word	-1	;16
	.word	-1	;17
	.word	-1	;18

d_zap
	callr	is_throwing_allowed
	jrnc	diff_no_zap

d_zap_now
	movi	ochar_zaps,a0
	callr	d_get_char_word
	jrn	stalk_in_close
	movi	reaction_exit,a1
	pushp	a1			; so we know where to return !!
	jauc	do_zap


is_throwing_allowed
	move	@diff,a0,w
	cmpi	2,a0
	jrlo	q_no
	jruc	q_yes

ochar_zaps
	.word	0  	; 0
	.word	1	; 1
	.word	2	; 2
	.word	4	; 3
	.word	>0c	; 4
	.word	>1a	; 5
	.word	>1b	; 6
	.word	9  	; 7
	.word	>0b	; 8
	.word	>0e	; 9
	.word	>11	; 10
	.word	>18	; 11
	.word	>15	; 12
	.word	>17	; 13
	.word	-1	; 14
	.word	-1	; 15
	.word	-1	; 16
	.word	-1	; 17


d_bflip_jump
	jsrp	d_bflip_jsrp
	jruc	d_reaction_exit

d_bflip_jsrp
	callr	d_behind_me_a5
	cmpi	>70,a5
	jrlo	bflip_abort    		; too close to edge = abort
	callr	backflip_setup
	jruc	d_bflip_noscan_jsrp	; angle / retp

bflip_abort
	callr	d_reset_proc_stack
	jruc	d_attack		; ejbpatch - finish this


d_jumpup_nocall
	clr	a11

d_jumpup
	jsrp	do_jump_up
	jruc	d_land

d_fflip_scan_jump
	jsrp	d_fflip_scan_jsrp
	jruc	d_reaction_exit

d_bflip_noscan_jsrp
	clr	a6

d_bflip_scan_jsrp
	push	a6
	callr	backflip_setup
	jruc	dflip3

d_fflip_noscan_jsrp
	clr	a6

d_fflip_scan_jsrp
	push	a6
	callr	frontflip_setup
dflip3	pull	a6
	move	a6,*a13(p_store1),l	; drone routine to call
	jauc	do_flip



d_fflip_jump
	jsrp	d_fflip_jsrp
	jruc	d_reaction_exit

d_fflip_jsrp
	callr	frontflip_setup

	move	@diff,a0,w
	cmpi	4,a0
	jrlo	d_fflip_noscan_jsrp	; easy = dont scan him
	movi	fflip_watchout,a6
	jruc	d_fflip_scan_jsrp

fflip_watchout
	callr	d_get_x_dist

;	cmpi	>70,a3
	cmpi	>a0,a3

	jrhi	watch9

	pull	a0
	pull	a0
	pull	a0
	callr	d_reset_proc_stack
	callr	q_is_he_airborn
	jrc	watch_flip_punch
	jruc	watch_flip_kick

watch9	rets


watch_flip_punch
	jsrp	do_flip_punch
	jruc	d_reaction_exit

watch_flip_kick
	jsrp	do_flip_kick
	jruc	d_reaction_exit

;****************************************

frontflip_setup
	movi	>40000,a11   	; walk angle jump x vel
	movi	>70000,a6    	; run angle jump x vel
	movk	>1a,a0	     	; forward flip
	movk	>1b,a1	     	; backwards flip
	calla	is_he_right
	jrc	ffset3
	neg	a11
	neg	a6	     	; opposite direction
	movk	>1a,a1	     	; forward flip
	movk	>1b,a0	     	; backwards flip
ffset3  	rets


backflip_setup
	movi	>40000,a11   	; walk angle jump x vel
	movi	>70000,a6    	; run angle jump x vel
	movk	>1a,a0	     	; forward flip
	movk	>1b,a1	     	; backwards flip
	calla	is_he_right
	jrnc	bfset3
	neg	a11
	neg	a6	     	; opposite direction
	movk	>1a,a1	     	; forward flip
	movk	>1b,a0	     	; backwards flip
bfset3  	rets

;**********************************

stalk_wait_yes
	calla	face_opponent
	callr	d_walkf_setup

stwy3	calla	am_i_facing_him
	jrnc	d_turnaround
	sleep	1
	callr	d_check_winner_status
	callr	d_next_anirate
	callr	d_beware
	push	a10
	call	a11
	pull	a10
	jrc	d_retp
	dsj	a10,stwy3   		; max time to wait
	jruc	d_retp


retreat_wait_yes
	calla	face_opponent
	callr	d_walkb_setup

rwy3	calla	am_i_facing_him
	jrnc	d_turnaround
	sleep	1
	callr	d_next_anirate
	callr	d_beware

	callr	d_either_edge_a5
	cmpi	>50,a5
	jrlo	d_cornered		; too close to edge of world !!

	push	a10
	call	a11
	pull	a10
	jrc	d_retp   		; no, keep walking
	dsj	a10,rwy3   		; max time to wait
	jruc	d_retp

;**********************************

d_hang_out
	move	@dv_hangout,a0,w
	dec	a0
	move	a0,@dv_hangout,w		; count this

	movi	>40*2,a0
	movi	>30,a1
	calla	randu_minimum
	move	a0,a10
	jsrp	d_stance_pause
	jruc	d_reaction_exit

d_stance_pause
	callr	d_stance_setup
dsp3	callr	d_next_anirate
	callr	d_beware
	callr	d_check_winner_status
	calla	am_i_facing_him
	jrnc	d_turnaround			; keep facing him
	sleep	1
	dsj	a10,dsp3
	jruc	d_retp


d_stance_dumb
	callr	d_stance_setup
dsd3	callr	d_next_anirate
	calla	face_opponent
	sleep	1
	dsj	a10,dsd3
	jruc	d_retp

*
* a10 = max wait time
* a11 = routine we are waiting for a YES from
*
stance_wait_yes
	callr	d_stance_setup
dsp8	calla	next_anirate
	callr	d_beware		; keep one eye open !!
	push	a10
	call	a11
	pull	a10
	jrc	d_retp			; carry set = exit
	sleep	1
	dsj	a10,dsp8
	jruc	swn9			; retp

stance_wait_no
	callr	d_stance_setup
swn8	calla	next_anirate
	callr	d_beware		; keep one eye open !!
	push	a10
	call	a11
	pull	a10
	jrnc	d_retp			; carry clear = exit
	sleep	1
	dsj	a10,swn8
swn9	clrc				; carry clear = event did not happen
	jruc	d_retp

stw_proj_proc
	movi	q_is_proj_gone,a11
	movi	>50,a10
	jruc	stance_wait_no		; wait a bit

stw_proj_proc_gone
	movi	q_is_proj_gone,a11
	movi	>50,a10
	jruc	stance_wait_yes		; wait a bit




still_wait_yes
	sleep	1
	push	a10
	call	a11
	pull	a10
	jrc	d_retp			; carry set = exit
	dsj	a10,still_wait_yes
	jruc	d_retp


flipp_scan
	calla	get_x_dist
	cmpi	>80,a3
	jrhi	d_rets			; too far

	pull	a0
	pull	a0
	pull	a0
	callr	d_reset_proc_stack
	jsrp	do_flip_punch
	jruc	d_reaction_exit


flipk_scan
	calla	get_x_dist
	cmpi	>80,a3
	jrhi	d_rets			; too far

	pull	a0
	pull	a0
	pull	a0
	callr	d_reset_proc_stack
	jsrp	do_flip_kick
	jruc	d_reaction_exit


hangout_check
	move	@diff,a0,w
	cmpi	4,a0
	jrhi	d_rets			; hard = no hangouts !!

	move	@dv_hangout,a0,w
	jreq	d_rets			; no more "hangouts" left
	pull	a14
	callr	chance_do
	.word	200
	.long	d_hang_out
	jump	a14

**************************************************************************
*											     *
*  Drone versions of normal routines							     *
*											     *
**************************************************************************
d_backup_jump
	jsrp	d_backup_jsrp
	jruc	d_reaction_exit

d_backup_jsrp
	movi	act_backup,a1
	move	a1,*a13(p_action),w	; define my action
	movk	4,a9			; ani = duck
	callr	d_get_char_ani
	move	a9,a10
	addi	32*2,a9
	callr	d_do_next_a9_frame
	sleep	2
	callr	d_beware

	move	a10,a9
	addi	32,a9
	callr	d_do_next_a9_frame
	sleep	2
	callr	d_beware

	move	a10,a9
	callr	d_do_next_a9_frame
	sleep	2
	jruc	d_retp


d_slam
	callr	q_is_he_a_boss
	jrc	d_rapid_hi

	callr	q_is_he_airborn
	jrc	d_rapid_hi

	jsrp	do_body_slam
	jruc	d_reaction_exit

d_elbow	callr	q_is_he_airborn
	jrc	d_rapid_lo
	calla	is_he_short
	jrc	d_knee			; ducking = knee instead
	jsrp	do_elbow
	jruc	d_reaction_exit

d_knee	callr	q_is_he_airborn
	jrc	d_rapid_lo
	jsrp	do_knee
	jruc	d_reaction_exit

d_lo_kick
	jsrp	do_lo_kick
	jruc	d_reaction_exit

d_stalk_crossk
	movi	>40*1,a10
	movi	>40,a11
	jsrp	d_stalk_a11		; try 2 get close in !!
	move	a10,a10
	jreq	d_reaction_exit		; oh well, I tried

d_crossover_kick
	callr	nr_kano_abuser_check

	movi	crossover_scan,a6
	jruc	d_fflip_scan_jump

crossover_scan
	move	*a8(oxpos),a1,w
	move	*a13(p_otherguy),a2,l
	move	*a2(oxpos),a2,w
	move	*a8(oxvel),a3,l
	jrp	cscan4
	swap	a1,a2
cscan4	cmp	a2,a1			; have I crossed over yet ?
	jrlt	d_rets			; no

scan_flip_kick
	pull	a0
	pull	a0
	pull	a0
	callr	d_reset_proc_stack
	jsrp	do_flip_kick
	jruc	d_reaction_exit

;*************************************
d_fflip_kick_jump
	jsrp	d_fflip_kick_jsrp
	jruc	d_reaction_exit

d_fflip_kick_jsrp
	movi	fflip_scan,a6
	jruc	d_fflip_scan_jump

fflip_scan
	callr	d_get_x_dist
	cmpi	>70,a3
	jrlo	scan_flip_kick
	rets


d_jump_up_kick
	movi	jump_up_kick_scan,a11
	jsrp	do_jump_up
	jruc	d_reaction_exit

jump_up_kick_scan
	calla	get_x_dist

;	cmpi	>80,a3
	cmpi	>90,a3

	jrhi	juks9

	pull	a0
	pull	a0
	callr	d_reset_proc_stack		; woa! that was a load off !!
	jauc	do_jumpup_kick

juks9	rets

;*************************************

d_sweep_kick
	jsrp	do_sweep_kick
	
	callr	q_is_he_reacting
	jrnc	d_reaction_exit
	callr	random_do
	.word	2
	.long	d_get_open
	.long	d_backoff_a_bit

d_uppercut
	jsrp	do_uppercut
	jruc	d_reaction_exit

d_hi_kick
	jsrp	do_hi_kick
	jruc	d_reaction_exit

d_rapid_lo
	movk	7,a0
	movk	2,a1
	movk	3,a2		; stk #2 = hi punch
;	clr	a4
	movi	>0f,a9
	jruc	d_punch

d_rapid_hi
	movk	7,a0
	movk	2,a1
	movk	2,a2		; stk #2 = hi punch
;	clr	a4
	movi	>0e,a9
d_punch	jsrp	drone_rfp
	jruc	d_reaction_exit

*
* a0 = max times i am allowed to hit
* a1 = sleep time after a strike
* a2 = stk offset #1
* a4 = routine to call after every swing !
* a9 = animation offset to use !
*
drone_rfp
	mmtm	a12,a2,a3,a4,a9		; dump all our shit info on proc stack

	move	a0,*a13(p_dcount),w	; max punches in a row
	move	a1,*a13(p_anirate),w
	calla	init_special

	move	*a12,a9,l		; grab ani offset
	callr	d_get_char_ani

drfp1	movk	3,a0
	jsrp	mframew

;	move	*a12(32),a0,l
;	jreq	drf5
;	call	a0			; call routine if u must

drf5	move	*a12(32*3),a0,l		; a0 = stk #1
	calla	strike_check_a0		; strike: punch #1
	jrnc	drfp3			; miss

	move	*a13(p_dcount),a0,w
	dec	a0
	jreq	drfp3			; enough of this !
	move	a0,*a13(p_dcount),w	; count this hit

	move	*a13(p_anirate),a0,w
	calla	prcslp

	movk	3,a0
	jsrp	mframew

;	move	*a12(32),a0,l
;	jreq	drf6
;	call	a0			; call routine if u must
;drf6

	move	*a12(32*3),a0,l		; a0 = stk #1
	calla	strike_check_a0	 	; med punch strike #2
	jrnc	drfp2			; miss

	move	*a13(p_dcount),a0,w
	dec	a0
	jreq	drfp2			; enough of this !
	move	a0,*a13(p_dcount),w	; count this hit

	move	*a13(p_anirate),a0,w
	calla	prcslp
	jruc	drfp1
*
* unpunch #2
*
drfp2	move	*a12,a9,l
	calla	find_ani_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	jruc	drfp4
*
* unpunch #1
*
drfp3 	move	*a12,a9,l		; grab ani offset
	calla	find_ani_part2
	calla	find_part2
	calla	find_part2

drfp4	movk	3,a0
	jsrp	mframew
	mmfm	a12,a2,a3,a4,a9		; pull everything off stack
	jruc	d_retp

**************************************************************************
*											     *
*  ask_mr_diff - magical routine which asks mr diff if i can perform     *
*                a certain act.								     *
* 											     *
*  input: a0 --> table of 10 randper values which are used based on the  *
*                magical variable called diff					     *
* 											     *
*  returns: carry set   = yes								     *
*           carry clear = no								     *
*											     *
**************************************************************************
ask_mr_diff
	move	@diff,a1,w
	cmpi	9,a1
	jrle	amd3
    	movk	7,a1			; fucked up value ----> make it 7
amd3	sll	4,a1
	add	a0,a1
	move	*a1,a0,w		; grab yer "randper" entry
	jauc	randper


d_ochar_jump
	pull	a0
	move	*a8(ochar),a1,w
	sll	5,a1
	add	a0,a1
	move	*a1,a1,l
	jump	a1

**************************************************************************
*											     *
*  random_do - Do one of the actions (randomly) from this table of routi *
* 											     *
*  Input: return address = table of "do's"	  					     *
*											     *
**************************************************************************
random_do
	pull	a0
	move	a0,a1
	move	*a1+,a0,w		; a0 = # of entries
	calla	randu
	dec	a0
	sll	5,a0
	add	a0,a1
	move	*a1,a0,l

ochar_do
	movi	reaction_exit,a1
	move	a1,-*a12,l		; push ret addr
	jump	a0

ochar_do_or_rets
	calla	get_char_long
	jreq	odor9
	pull	a1			; no return
	jruc	ochar_do
odor9	rets


chance_do
	pull	a0
	move	a0,a1
	move	*a1,a0,w
	calla	randper			; shoops !!!
	jrnc	chano			; nope.
	move	*a1(16),a0,l
	jump	a0
chano	addi	16+32,a1		; sorry
	jump	a1			; rets

;*************************************************************************

drone_post_duck_hit
	movi	>40*2,a10
	jsrp	d_wait_nonattack
	jsrp	do_backup
	jruc	d_reaction_exit

;*************************************************************************

d_wait_nonattack
	sleep	1
	dec	a10
	jreq	wna9
	callr	is_he_attacking
	jrc	d_wait_nonattack
wna9	jruc	d_retp

;*************************************************************************

d_post_block
	clr	a1
	move	a1,*a13(p_action),w

	movi	>0c,a9
	calla	am_i_short
	jrnc	pblk3
	movk	6,a9
pblk3	callr	d_get_char_ani
	move	a9,a10
	addi	32,a9
	callr	d_do_next_a9_frame
	sleep	3

	callr	d_beware
	move	a10,a9
	callr	d_do_next_a9_frame
	sleep	3

	calla	am_i_short
	jrc	d_backup_jump		; short = get back up
	jruc	d_reaction_exit

;******************

d_turnaround
	callr	d_reset_proc_stack
	jsrp	d_turnaround_jsrp
	jruc	d_reaction_exit

d_turnaround_jsrp
	calla	am_i_facing_him
	jrc	d_retp			; no need

	callr	d_stop_me
	movk	3,a9
	callr	d_get_char_ani
	movi	ta_speeds,a0
	calla	get_char_long		; get my speed to animate
	calla	init_anirate		; turn around speed

dturn7	sleep	1
	callr	d_beware
	calla	next_anirate
	move	*a9,a0,l		; animation done ????
	jrne	dturn7			; no
	jruc	d_retp

;*******************

d_getup
	movi	act_getup,a0
	move	a0,*a13(p_action),w		; define my action !
	clr	a0
	move	a0,*a13(p_otheract),w	; dont let anything get by me !

	movi	>21,a9
	callr	d_get_char_ani
	move	a11,a0
	calla	get_char_word
dgu4	calla	init_anirate			; define animation speed

dgu5	sleep	1
	callr	d_beware
	callr	d_next_anirate
	move	*a9,a0,l
	jrne	dgu5
	jruc	d_reaction_exit

;*******************

d_get_open
	callr	d_get_my_dfe
	movi	d_bflip_jump,a2
	movi	d_open_jumpover,a7
	cmp	a5,a6
	jrhi	open_right
	movi	d_bflip_jump,a7
	movi	d_open_jumpover,a2

open_right
	calla	is_he_right
	jrc	open_jump
	swap	a2,a7

open_jump
	jump	a7

d_open_jumpover
	jsrp	d_fflip_jsrp
	calla	check_winner_status
	jruc	d_bflip_jump


d_duck	jsrp	do_duck
	movi	>40*2,a10
	jsrp	d_wait_nonattack
	jruc	d_backup_jump

d_duck_then_uppercut
	jsrp	do_duck
	movi	>40*2,a10
	jsrp	d_wait_nonattack
	jruc	d_uppercut

d_duck_fast
	movi	act_duck,a1
	move	a1,*a13(p_action),w	; define my DIFFERENT action !!!
	callr	d_stop_me
	calla	face_opponent
	movk	4,a9
	callr	d_get_char_ani
	movk	1,a0
	jauc	mframew

**************************************************************************
*											     *
*  If you cans !!									     *
*											     *
**************************************************************************
nr_hikick_if_u_can
	clr	a0			; stk offset to check
	movi	d_hi_kick,a10   	; where to jump if this will hit !
	jruc	if_u_can

nr_sweep_if_u_can
	movk	4,a0			; stk offset to check
	movi	d_sweep_kick,a10   	; where to jump if this will hit !
	jruc	if_u_can

nr_uppercut_if_u_can
	movk	8,a0			; stk offset to check
	movi	d_uppercut,a10		; where to jump if this will hit !
;	jruc	if_u_can

if_u_can
	callr	d_strike_check_a0_test
	jrnc	d_rets
	pull	a0			; no return
	jump	a10

**************************************************************************
*											     *
*   Drone versions of external routines						     *
*											     *
**************************************************************************
d_block
	calla	face_opponent
	jsrp	do_block_hi
	movi	>40*2,a10
	jsrp	d_wait_nonattack
	jruc	d_reaction_exit

d_duck_block
	calla	stop_me
	calla	face_opponent
	movk	6,a9
	callr	d_get_char_ani		; duck block ani
	movk	3,a0
	movi	act_blocklo,a1
	jsrp	act_mframew   		; get into "duck block" pose
	movi	>40*2,a10
	jsrp	d_wait_nonattack
	jruc	d_reaction_exit

d_block_projectile
	movi	q_is_proj_gone,a11
	movi	>30,a10
	jsrp	stance_wait_no
	jsrp	do_block_hi
	movi	q_is_proj_gone,a11
	movi	>50,a10
	jsrp	still_wait_yes
	jruc	d_reaction_exit


d_to_normal
	calla	back_to_normal
	clr	a0
	move	a0,*a13(p_otheract),w
	rets


d_stance_setup
	callr	d_stop_me

	move	a9,a5	       	; a5 = "before" animation
	calla	stance_setup
	calla	do_next_a9_frame
	subi	32,a9		; back 2 1st frame

sss1	move	*a9,a4,l
	cmpi	ani_ochar_jump,a4	; jump command ?
	jrne	sss2
	addi	32*5,a9,l      	; yes, skip the bs
	jruc	sss1

sss2	move	a9,a4
sss3	move	*a4+,a1,l
	cmpi	ani_jump,a1	; find the "ani_jump"
	jrne	sss3
	subi	32*2,a4		; a4 --> last stance frame
*
* a9 ---> top
* a4 ---> bottom     a5 ---> where we were before
* 
	cmp	a9,a5
	jrlo	sss6		; b4 = above the top ---> use new ani
	cmp	a4,a5
	jrhi	sss6		; b4 = below the bottom ---> new ani
	move	a5,a9		; already in stance ani ---> dont interupt
sss6	rets



d_walkb_setup
	calla	get_walk_info_b
	jruc	dwset3

d_walkf_setup
	calla	get_walk_info_f
dwset3	move	a2,a9
	calla	init_anirate
	move	a1,a0
	calla	set_x_vel
	jruc	d_get_char_ani


d_either_edge_a5
	calla	get_my_dfe
	cmp	a5,a6
	jrhi	eith3
	move	a6,a5		; a5 = distance from closest edge
eith3	rets


d_front_me_a5
	callr	d_get_my_dfe
	swap	a5,a6
	jruc	beh1

d_behind_me_a5
	callr	d_get_my_dfe
beh1	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	beh3
    	move	a6,a5
beh3	rets

**************************************************************************
*											     *
*     FAQ										     *
*											     *
**************************************************************************
get_his_y_vel
	move	*a13(p_otherguy),a0,l
	move	*a0(oyvel),a0,l
	rets


q_my_back_to_him
	movi	am_i_facing_him,a0
	jruc	yes_means_no

q_is_he_dropping
	move	*a13(p_otherguy),a0,l	
	move	*a0(oyvel),a0,l
	jrn	q_no
	jreq	q_no
	jruc	q_yes


q_am_i_a_boss
	move	a8,a14
	jruc	bossck

q_is_he_a_boss
	move	*a13(p_otherguy),a14,l
bossck	move	*a14(ochar),a14,w
	cmpi	ft_motaro,a14
	jreq	q_yes
	cmpi	ft_sk,a14
	jreq	q_yes
	jruc	q_no


q_square_lower
	movi	>50,a7				; here is the line !!

q_is_he_lower
	move	*a13(p_otherguy),a0,l
	move	*a0(oyvel),a1,l
	jrn	q_no				; heading up = no
	move	*a13(p_otherproc),a2,l
	move	*a0(oypos),a1,w
	move	*a2(p_ganiy),a2,w
	sub	a1,a2
	cmp	a7,a2				; input: a7 = distance
	jrhi	q_no
	jruc	q_yes

q_is_he_below_ground
	move	*a13(p_otherguy),a0,l
	move	*a13(p_otherproc),a1,l
	move	*a0(oypos),a0,w
	jrn	q_no
	move	*a1(p_ganiy),a1,w
	cmp	a1,a0
	jrhi	q_yes
	jruc	q_no


q_is_he_airborn
	jauc	is_he_airborn

q_is_he_reacting
	callr	d_get_his_action
	cmpi	act_reacting,a1
	jreq	q_yes	
	jruc	q_no

q_is_he_dizzy
	move	*a13(p_otherproc),a0,l
	move	*a0(pwake),a7,l
	cmpi	dizzy_wake,a7			; he in dizzy routine ?
	jreq	q_yes
	jruc	q_no

is_he_attacking
	callr	d_get_his_action
	srl	8,a1
	sll	8,a1
	cmpi	act_attacks,a1
	jreq	ihay
	cmpi	act_body_propell,a1
	jreq	ihay

	clrc
	rets
ihay	setc
	rets


is_he_him
	move	*a13(p_otherguy),a1,l
	move	*a1(ochar),a1,w
	cmp	a0,a1
	jreq	ihhy
	clrc	
	rets
ihhy	setc
	rets


is_towards_me
	move	*a13(p_otherguy),a0,l
	move	*a0(oxvel),a0,l
	jreq	itmno
	jrp	itm5			; moving right
	calla	is_he_right
	jrc	itmyes
itmno	clrc
	rets
itm5	calla	is_he_right
	jrc	itmno			; moving right / he is right ---> no
itmyes	setc
	rets

q_will_he_reach_me
	mmtm	sp,a8,a13			; save my personal info
	move	*a13(p_otherguy),a8,l	; him
	move	*a13(p_otherproc),a13,l	; his proc
	move	*a13(p_stk),a0,w    		; his strike table
	callr	d_strike_check_a0_test
q_merets	mmfm	sp,a8,a13
	rets

is_propell_close
	callr	is_he_body_propell
	jrnc	q_yes
	calla	get_x_dist
	cmpi	>70,a3
	jrlo	q_yes				; close
	jruc	q_no

is_flyk_close
	callr	is_he_body_propell
	jrnc	q_yes
	calla	get_x_dist
	cmpi	>80,a3
	jrlo	q_yes			; close
	jruc	q_no

q_is_he_cornered
	mmtm	sp,a8,a13			; save my personal info
	move	*a13(p_otherguy),a8,l	; him
	move	*a13(p_otherproc),a13,l	; his proc
	callr	q_am_i_cornered
	jruc	q_merets

q_his_action_0
	callr	d_get_his_action
	jreq	q_yes
	jruc	q_no


yes_means_no
	call	a0
	jrc	q_no				; carry means NO
	jruc	q_yes				; no carry means YES !


q_am_i_cornered
	callr	d_behind_me_a5
	cmpi	>90,a5
	jrhi	q_no
	jruc	q_yes

q_no	clrc				; generic NO jump
	rets
q_yes	setc				; generic YES jump
d_rets	rets

**************************************************************************

drone_long_jump
	sll	5,a0
	addi	drone_longs,a0
	move	*a0,a0,l
	jump	a0

drone_longs
	.long	d_finish_him	; 0
	.long	wait_forever	; 1
	.long	wait_forever	; 2
	.long	wait_forever	; 3
	.long	wait_forever	; 4
	.long	wait_forever	; 5
	.long	wait_forever	; 6
	.long	wait_forever	; 7

**************************************************************************
**************************************************************************
**************************************************************************

d_finish_him
	callr	boss_branch
	.word	>11

	move	@f_no_violence,a0,w
	jrne	non_violent_finish

	movi	aud_drone_fatal,a0		; a0 = audit to use
	movk	10,a2				; a2 = max number
	calla	audit_event_check

;************
;	.if ejbbug
;	jruc	drone_babality
;	jruc	drone_friendship
;	jruc	drone_animality
;	jruc	drone_execute_fatality
;	.endif
;************

	jrc	drone_execute_fatality

non_fatal_finish
	movi	500,a0
	calla	randper				; drone = 50% change of bg fatal
	jrnc	non_violent_finish

	move	@curback,a1,w
	jreq	d_background_fatal		; subway = knock em on trax	
	cmpi	10,a1
	jreq	d_background_fatal		; pit 3 = into the machines
	cmpi	7,a1
	jreq	d_background_fatal		; bell tower = on the spikes

non_violent_finish
	jsrp	d_get_close_2_u
	movi	q_is_he_dizzy,a11		; question to ask
	movi	>40,a10				; max wait time
	jsrp	stance_wait_yes
	jrnc	d_fatality_abort		; times up....
	callr	random_do
	.word	3
	.long	d_upcut_finish
	.long	d_upcut_finish
	.long	d_elbow

d_upcut_finish
	movi	>10,a10
	jsrp	d_stance_pause		; dont look 2 much in a hurry
	jsrp	do_duck
	sleep	8
	callr	q_is_he_dizzy
	jrnc	d_reaction_exit		; 1 last check
	jruc	d_uppercut

d_background_fatal
	jsrp	d_get_close_2_u
	movi	q_is_he_dizzy,a11		; question to ask
	movi	>40,a10				; max wait time
	jsrp	stance_wait_yes
	jrnc	d_fatality_abort		; times up....
	jauc	do_pit_fatality

drone_babality
	calla	face_opponent
	callr	d_stance_setup

	movi	>40,a10
bab3	callr	d_next_anirate
	sleep	1
	dsj	a10,bab3
	jauc	do_babality

drone_friendship
	movi	ochar_friendship_distances,a0
	calla	get_char_word
	jsrp	fatality_align
	jauc	do_friendship

drone_animality
	movi	ochar_animality_distances,a0
	calla	get_char_word
	jsrp	fatality_align
	movi	>40,a10
	movi	q_is_he_dizzy,a11
	jsrp	stance_wait_yes
	move	a10,a10
	jreq	d_fatality_abort
	jauc	do_animality

drone_execute_fatality
	movi	aud_funality,a0
	movi	200,a2	   		; a2 = max number
	calla	audit_event_check
	jrnc	def2

	move	@rand,a0,l
	jrn	drone_babality
	jruc	drone_friendship

def2	movi	50,a0
	calla	randper

	.if fataldemo
	jruc	skipani
	.endif

	jrc	drone_animality


skipani
	movi	ochar_fatality_distances,a0
	calla	get_char_long

	move	@rand,a5,l
	jrn	def3

;************
	.if fataldemo
	jruc	def3
	.endif
;************

	srl	16,a0
	jsrp	fatality_align

	movi	>40,a10
	movi	q_is_he_dizzy,a11
	jsrp	stance_wait_yes
	move	a10,a10
	jreq	d_fatality_abort
	jauc	do_fatality_2

def3	zext	a0,w
	jsrp	fatality_align
	movi	q_is_he_dizzy,a11		; question to ask
	movi	>40,a10				; max wait time
	jsrp	stance_wait_yes
	jrnc	d_fatality_abort		; times up....
	jauc	do_fatality_1


d_get_close_2_u
	calla	get_x_dist
	cmpi	>100,a3	    		; flip to save time ?
	jrlo	c2u3	    		; no
	jsrp	d_fflip_jsrp		; far away ---> flip
c2u3	movi	>40,a11
	jauc	d_stalk_a11_ntl

fatality_align
	move	a0,a11
	calla	get_x_dist		; a3 = x dist
	cmp	a3,a0
	jrlo	def5
	jauc	fatality_retreat_a11

def5	calla	get_x_dist
	cmpi	>100,a3	    		; flip to save time ?
	jrlo	def6	    		; no
	jsrp	d_fflip_jsrp

def6	movi	>40*3,a10
	jsrp	fatality_stalk_a11		; try 2 get close in !!
	move	a10,a10
	jreq	d_fatality_abort
	retp


fatality_stalk_a11
	calla	face_opponent
	callr	d_walkf_setup

fstk3	calla	am_i_facing_him
	jrnc	d_turnaround
	sleep	1
	callr	d_check_winner_status
	callr	d_next_anirate
	callr	d_get_x_dist  		; a3 = distance tween us
	cmp	a11,a3	    		; within range ?
	jrlo	dist_retp   		; yes, exit
	dsj	a10,fstk3   		; max time to wait
	jruc	dist_retp

fatality_retreat_a11
	movi	>40*2,a10
	callr	q_am_i_cornered
	jrc	d_fatality_cornered

	callr	d_get_x_dist
	sub	a11,a3
	abs	a3
	cmpi	>100,a3			; backflip 2 save time ??
	jrlo	fret4			; no.
	jsrp	d_bflip_jsrp
	jruc	fatality_retreat_a11

fret4	calla	face_opponent
	callr	d_walkb_setup
fret3	sleep	1
	callr	d_next_anirate
	callr	d_get_x_dist  		; a3 = distance tween us
	cmp	a11,a3	    		; within range ?
	jrhi	dist_retp   		; no, keep walking
	dsj	a10,fret3   		; max time to wait

	pullp	a0
	jruc	d_fatality_abort


ochar_friendship_distances
	.word	>80
	.word	>80
	.word	>80
	.word	>80
	.word	>80

	.word	>80
	.word	>80
	.word	>c0
	.word	>80
	.word	>80

	.word	>80
	.word	>80
	.word	>80
	.word	>80
	.word	>80


ochar_animality_distances
	.word	>50		; kano
	.word	>50		; sonya
	.word	>50		; jax
	.word	>50		; nightwolf
	.word	>50		; subzero
	.word	>68		; stryker
	.word	>50		; sindel
	.word	>50		; sektor
	.word	>50		; cyrax
	.word	>50		; lao
	.word	>50		; kabal
	.word	>50		; sheeva
	.word	>60		; shang tsung
	.word	>68 		; liu kang
	.word	>d0		; smoke

ochar_fatality_distances
	.word	>a0,>48		; kano
	.word	>80,>e0		; sonya
	.word	>50,>d0		; jax
	.word	>50,>c0		; nightwolf
	.word	>c0,>4a		; subzero
	.word	>f8,>48		; stryker
	.word	>50,>70		; sindel
	.word	>90,>b0		; sektor
	.word	>50,>80		; cyrax
	.word	>80,>60		; lao
	.word	>c0,>50		; kabal
	.word	>50,>50		; sheeva
	.word	>50,>70		; shang tsung
	.word	>80,>80		; liu kang
	.word	>f0,>80		; smoke

d_fatality_cornered
d_fatality_abort
	calla	reset_proc_stack

;	calla	stop_me
;	calla	nosounds
;	sleep	1
;	tsound	>1c
;	movi	>25,a9
;	calla	get_char_ani
;	movk	1,a0
;	jsrp	mframew

	jauc	victory_animation

**************************************************************************
*											     *
*      BEWARE										     *
*											     *
**************************************************************************
d_init
	move	*a13(p_flags),a4,w
	andni	pm_joy,a4
	move	a4,*a13(p_flags),w	; flag: i am a drone
	movk	2,a0
	move	a0,@dv_hangout,w
	rets


d_beware
	move	@winner_status,a0,w
	jrne	bew8				; we have a winner
;	jruc	bew8				; DEBUG: ignore everything

	callr	d_get_his_action
	jreq	bew8   				; no act ---> no react

	move	*a13(p_otheract),a0,w
	cmp	a0,a1				; same as before ??
	jreq	bew8				; yes, we had our chance before
	move	a1,*a13(p_otheract),w 	; no ---> new latest act !!

	move	a1,a2
	srl	8,a2
	sll	5,a2		 		; a2 = catagory offset

	move	*a8(ochar),a0,w
	sll	5,a0
	addi	ochar_cat_tables,a0
	move	*a0,a3,l

	add	a3,a2				; add in catagory table
	move	*a2,a2,l
	jreq	bew8				; no catagory ---> skip

	andi	>00ff,a1			; look only at catagory
	sll	5,a1
	add	a2,a1
	move	*a1,a1,l
	jreq	bew8	 			; no reaction ---> skip

	push	a1
	calla	player_normpal			; make sure i look like i should !
	move	*a8(ochar),a3,w			; a3 = my ochar
	pull	a1
	pull	a0				; a0 = return address

	move	a0,*a13(p_beware_return),l
	move	a10,*a13(p_beware_a10),l
	move	a11,*a13(p_beware_a11),l
	jump	a1	 			; react to his action !

bew8	rets


ochar_cat_tables
	.long	drone_catagory_table		; 0
	.long	drone_catagory_table		; 1
	.long	drone_catagory_table		; 2
	.long	drone_catagory_table		; 3
	.long	drone_catagory_table		; 4
	.long	drone_catagory_table		; 5
	.long	drone_catagory_table		; 6
	.long	drone_catagory_table		; 7
	.long	drone_catagory_table		; 8
	.long	drone_catagory_table		; 9
	.long	drone_catagory_table		; 10
	.long	drone_catagory_table		; 11
	.long	drone_catagory_table		; 12
	.long	drone_catagory_table		; 13
	.long	drone_catagory_table		; 14 - smoke
	.long	motaro_catagory_table	; 15 - motaro
	.long	sk_catagory_table		; 16 - shao kahn
	.long	drone_catagory_table		; 17
	.long	drone_catagory_table		; 18


drone_catagory_table
	.long	counter_zap			; 0
	.long	counter_attack_table		; 1
	.long	counter_propell			; 2
	.long	counter_nonattack		; 3
	.long	0				; 4
	.long	0				; 5
	.long	counter_sitting_duck		; 6
	.long	0				; 7

counter_nonattack
	.long	0			; 300
	.long	0			; 301
	.long	0			; 302
	.long	0			; 303
	.long	0			; 304
	.long	0			; 305
	.long	0			; 306
	.long	0			; 307
	.long	c_angle_jump		; 308
	.long	0			; 309
	.long	0			; 30a
	.long	0			; 30b
	.long	0			; 30c
	.long	0			; 30d

counter_zap
	.long	0		; ccc
	.long	c_kano_zap    	; 01
	.long	c_sonya_zap	; 02
	.long	c_jax_zap1  	; 03
	.long	c_jax_zap2  	; 04
	.long	c_ind_zap	; 05
	.long	c_sky_ice  	; 06
	.long	0		; 07	swat gun
	.long	c_robo_zap2	; 08
	.long	c_robo_zap	; 09
	.long	c_robo_net	; 0a
	.long	c_lia_anglez  	; 0b
	.long	c_lao_zap	; 0c
	.long	c_robo_bomb	; 0d
	.long	c_tusk_zap	; 0e
	.long	c_floor_zap	; 0f
	.long	c_st_zap1	; 10
	.long	c_st_zap2	; 11
	.long	c_st_zap3	; 12
	.long	c_lk_zaphi	; 13
	.long	c_lk_zap_lo   	; 14
	.long	0		; 15
	.long	0		; 16
	.long	c_sg_zap    	; 17
	.long	c_swat_bomb_hi	; 18
	.long	c_swat_bomb_lo	; 19
	.long	c_forward_ice	; 1a
	.long	c_lia_forward	; 1b
	.long	c_floor_blade	; 1c
	.long	c_spear		; 1d
	.long	0		; 1e
	.long	0		; 1f
	.long	0		; 20
	.long	0		; 21


counter_attack_table
	.long	0		; ccc
	.long	c_hipunch   	; 101 - hi punch
	.long	c_lopunch   	; 102 - lo punch
	.long	c_hikick	; 103 - hi kick
	.long	c_lokick	; 104 - lo kick
	.long	c_rhouse	; 105 - roundhouse kick
	.long	c_duck_kickh	; 106 - duck kick hi
	.long	c_duck_kickl	; 107 - duck kick lo
	.long	c_duckpunch	; 108
	.long	c_knee		; 109
	.long	c_elbow		; 10a
	.long	c_jupkick 	; 10b
	.long	c_juppunch 	; 10c
	.long	c_sweep		; 10d
	.long	c_uppercut  	; 10e
	.long	c_lia_scream	; 10f
	.long	c_leg_grab	; 110
	.long	c_shake		; 111
	.long	c_noogy		; 112
	.long	c_quake		; 113
	.long	0		; 114
	.long	c_axe_up	; 115
	.long	0		; 116
	.long	c_kano_swipe 	; 117
	.long	c_quake		; 118
	.long	c_laospin   	; 119

counter_propell
	.long	c_flykick	; 200 - flying (flip) kick
	.long	c_flypunch	; 201 - flying (flip) punch
	.long	c_sz_decoy	; 202 -
	.long	0		; 203
	.long	c_sbike		; 204
	.long	c_jax_dash	; 205
	.long	c_lao_tele	; 206
	.long	c_square	; 207
	.long	c_robo_tele  	; 208
	.long	0		; 209
	.long	c_tele_explode	; 20a
	.long	c_kano_roll  	; 20b
	.long	c_lao_angle 	; 20c
	.long	c_bike		; 20d
	.long	c_superkang	; 20e
	.long	c_sg_pounce 	; 20f
	.long	c_bike		; 210
	.long	c_zoom		; 211
	.long	c_swat_stick	; 212
	.long	c_tusk_blur	; 213
	.long	c_ind_charge	; 214

counter_sitting_duck
	.long	0		; 600
	.long	0		; 601
	.long	c_kroll_sd  	; 602
	.long	0		; 603
	.long	c_proj_sd	; 604
	.long	0		; 605
	.long	0		; 606
	.long	c_caught_net	; 607
	.long	c_leg_sd 	; 608
	.long	0		; 609
	.long	0		; 60a
	.long	0		; 60b
	.long	0		; 60c
	.long	0		; 60d
	.long	0		; 60e
	.long	0		; 60f
	.long	c_frozen	; 610
	.long	c_sbike_sd	; 611
	.long	c_superk_sd	; 612
	.long	0		; 613
	.long	c_stsw_sd	; 614
	.long	c_screamed	; 615
	.long	0		; 616
	.long	0		; 617
	.long	c_kswipe_sd	; 618
	.long	0		; 619
	.long	0		; 61a
	.long	0	;act_noogy_sd	; 61b
	.long	c_ssd		; 61c
	.long	c_lk_bike_sd	; 61d
	.long	c_zoom_sd	; 61e
	.long	c_tusk_blur_sd	; 61f
	.long	0		; 620
	.long	0		; 621
	.long	c_robo_tele_sd	; 622

**************************************************************************

rpt_angle
	.word	100,100,100,150,200,400,450,600,700,750

c_angle_jump
	move	@diff,a0,w
	jreq	let_em_abuse

	move	@f_aabuse,a0,w
	cmpi	10,a0
	jrhi	angle_abuser_here	; you abuse me / I abuse you !!!

let_em_abuse
 	movi	rpt_angle,a0
	callr	ask_mr_diff
	jrnc	return_to_beware

angle_abuser_here
	calla	is_towards_me
	jrc	caj_towards_me		; he is heading towards me !!
	callr	q_is_he_cornered
	jrc	caj_corner
*
* angle jump - away from me
*
	callr	d_get_x_dist
	cmpi	>60,a3
	jrlo	d_flip_punch_jump	; close = flip punch
	cmpi	>b0,a3
	jrlo	zap_close_away_flipper
	jruc	return_to_beware


zap_close_away_flipper
	movk	6,a0			; sz sky behind
	move	*a8(ochar),a1,w
	cmpi	ft_subzero,a1
	jaeq	d_zap_jump		; subzero = sky ice behind

	movk	>19,a0
	move	*a8(ochar),a1,w
	cmpi	ft_swat,a1
	jaeq	d_zap_jump		; swat = zap hi

	movk	>16,a0
	move	*a8(ochar),a1,w
	cmpi	ft_lk,a1
	jreq	d_lk_hi_zap_jump	; lk = zap hi
	jruc	d_zap			; everyone else = normal


d_lk_hi_zap_jump
	movi	>16,a0
	jsrp	do_zap
	jruc	d_reaction_exit

d_zap_jump
	jsrp	do_zap
	jruc	d_reaction_exit


caj_towards_me
	calla	get_his_y_vel
	jrp	return_to_beware	; heading down, 2 late 2 react

	calla	get_x_dist

	move	*a8(ochar),a0,w
	cmpi	ft_lk,a0
	jreq	cajt3			; cuz lk has a bad hi kick !

	cmpi	>80,a3
	jrlo	d_hi_kick		; real close = hi kick

cajt3	cmpi	>90,a3
	jrlo	d_jump_up_kick		; kinda close = jump up kick
	cmpi	>b0,a3
	jrlo	d_flip_punch_jump	; not too close = flip punch

	movi	ochar_towards_counters,a0
	calla	get_char_long
	jreq	return_to_beware
	jump	a0


caj_corner
	calla	get_x_dist
	cmpi	>48,a3
	jrlo	d_uppercut		; we are real close ---> pow !!
	cmpi	>88,a3
	jrlo	d_flip_punch_jump	; not too close = flip punch
	cmpi	>c0,a3
	jrhi	caj_corner_far		; he is cornered far away !!

	movi	>40,a10
	movi	q_corner_backf_land,a11
	jsrp	stance_wait_yes
	jruc	d_zap

caj_corner_far
	movi	500,a0
	calla	randper
	jrc	d_zap			; sometimes zap just to be a jerk !!
	movi	>40*2,a10
	movi	>a0,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance
	jruc	d_reaction_exit


q_corner_backf_land
	callr	get_his_y_vel
	abs	a0
	cmpi	>20000,a0
	jrhi	q_no
	jruc	q_yes

;**************************

ochar_towards_counters
	.long	0
	.long	sonya_delayed_bike
	.long	jax_delayed_quake
	.long	ind_delayed_axe
	.long	sz_sky_zap

	.long	swat_zap_hi
	.long	lia_delayed_scream
	.long	d_backup_zap
	.long	robo2_delayed_net
	.long	d_backup_zap

	.long	tusk_jump_up_zap
	.long	sg_delayed_quake
	.long	st_delayed_whatever
	.long	lk_jump_up_zap
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0



st_delayed_whatever

;	calla	get_x_dist
;	cmpi	>e0,a0
;	jrhi	st2tusk

	callr	random_do
	.word	4
	.long	st2ind
	.long	st2sonya
	.long	st2tusk
	.long	st2lia


st2ind	jsrp	do_st_2_ind
	jruc	ind_delayed_axe

st2sonya	jsrp	do_st_2_sonya
	jruc	sonya_delayed_bike

st2tusk	jsrp	do_st_2_tusk
	jruc	tusk_jump_up_zap

st2lia	jsrp	do_st_2_lia
	jruc	lia_delayed_scream


sg_delayed_quake
	movi	>40,a10
	movi	q_jax_smash,a11
	jsrp	retreat_wait_yes
	callr	d_get_x_dist
	cmpi	>c0,a3
	jrlo	sq_quake_abort
	movi	>14,a0
	jauc	do_body_propell		; sg quake move !!

sq_quake_abort
	callr	q_am_i_cornered
	jrc	d_flip_punch_jump
	jruc	d_bflip_jump

;*******************************

lk_jump_up_zap
tusk_jump_up_zap
	movi	tusk_jup_scan,a11
	jsrp	do_jump_up
	jruc	d_reaction_exit

tusk_jup_scan
	calla	distance_off_ground
	cmpi	>40,a0
	jrlo	q_no
	pull	a0
	pull	a0
	callr	d_reset_proc_stack		; woa! that was a load off !!
	jruc	d_zap_now

;*******************************

robo2_delayed_net
	movi	>40,a10
	movi	q_is_he_net_close,a11
	jsrp	retreat_wait_yes
	jruc	d_zap

q_is_he_net_close
	callr	get_his_y_vel
	abs	a0
	cmpi	>10000,a0
	jrhi	q_no
	jruc	q_yes

;*******************************

d_backup_zap
	movi	>40,a10
	movi	q_backup_zap,a11
	jsrp	retreat_wait_yes
	jruc	d_zap

q_backup_zap
	callr	get_his_y_vel
	jrn	q_no
	calla	get_his_dog
	cmpi	>70,a0
	jrhi	q_no
	jruc	q_yes

;*******************************

lia_delayed_scream
	movi	>40,a10
	movi	q_is_he_scream_close,a11
	jsrp	stalk_wait_yes
	jsrp	do_lia_scream
	jruc	d_reaction_exit

q_is_he_scream_close
	callr	d_get_x_dist
	cmpi	>b0,a3
	jrhi	q_no
	jruc	q_yes

;*******************************

swat_zap_hi
	movi	>19,a0
	jsrp	do_zap
	jruc	d_reaction_exit

sz_sky_zap
	movk	7,a0
	jsrp	do_zap
	jruc	d_reaction_exit

ind_delayed_axe
	movi	>40,a10
	movi	q_is_he_axe_close,a11
	jsrp	stalk_wait_yes
	jsrp	do_axe_up
	jruc	d_reaction_exit

q_is_he_axe_close
	callr	d_get_x_dist
	cmpi	>70,a3
	jrhi	q_no
	jruc	q_yes

;**************************

jax_delayed_quake
;	callr	q_am_i_cornered
;	jrc	return_to_beware

	movi	>40,a10
	movi	q_jax_smash,a11
	jsrp	retreat_wait_yes
	callr	d_get_x_dist
	cmpi	>b0,a3
	jrlo  	d_reaction_exit
	jsrp	do_quake		; far enough
	jruc	d_reaction_exit

q_jax_smash
	calla	get_his_y_vel
	jrn	q_no			; heading up.
	jruc	q_yes

;**************************

sonya_delayed_bike
	movi	>40,a10
	movi	q_is_he_bike_close,a11
	jsrp	stalk_wait_yes
	movk	1,a0
	jsrp	do_body_propell		; sonya bike kick
	jruc	d_reaction_exit

q_is_he_bike_close
	callr	d_get_x_dist
	cmpi	>80,a3
	jrhi	q_no
	jruc	q_yes

**************************************************************************
*											     *
*   ZAPS											     *
*											     *
**************************************************************************
c_tusk_blur
	callr	react_jump_table_act
	.long	d_block
	.long	d_block
	jruc	d_block

c_robo_bomb
	callr	react_jump_table_act
	.long	c_bomb
	.long	c_bomb

c_bomb	jruc	run_in_close		; close = charge


c_st_zap2
c_st_zap3
	callr	react_jump_table_act
	.long	c_stzap23
	.long	c_stzap23

c_stzap23
	callr	nr_sweep_if_u_can
	jruc	duck_under_mproj		; close = duk


c_lk_zap_lo
	callr	react_jump_table_act
	.long	c_lkzaplo
	.long	c_lkzaplo

c_lkzaplo
	callr	d_get_x_dist
	cmpi	>80,a3
	jrlo	d_crossover_kick		; crossover if u can
	jruc	d_fflip_kick_jump		; dont wait for proj proc

;***********************************************

c_lao_zap
	callr	react_jump_table_act
	.long	c_hat
	.long	c_hat

c_hat	callr	nr_sweep_if_u_can
	callr	d_get_x_dist
	cmpi	>c0,a3
	jrlo	d_block_projectile
	jruc	d_flipk_over_proj

;***********************************************

c_robo_net
	callr	react_jump_table_act
	.long	d_block_projectile
	.long	d_block_projectile

;	.long	c_net
;c_net	callr	d_get_x_dist 			; DONT SWEEP HERE !!!
;	cmpi	>80,a3
;	jrlo	d_block_projectile		; too close
;	jruc	d_flipk_over_proj

;*********************************

c_robo_zap2
	callr	react_jump_table_act
	.long	c_tracker_rocket
	.long	c_tracker_rocket

c_tracker_rocket
	callr	nr_sweep_if_u_can
	callr	d_get_x_dist
	cmpi	>e0,a3
	jrlo	run_in_close		; close = charge

	jsrp	stw_proj_proc		; wait for projectile proc

	movi	q_is_tracker_close,a11
	movi	>70,a10
	jsrp	stance_wait_yes
;	jsrp	d_fflip_kick_jsrp
	jruc	run_in_close		; close = charge

q_is_tracker_close
	calla	get_his_proj_proc
	jreq	q_yes
	move	*a0(pa8),a1,l
	move	*a1(oxpos),a1,w
	move	*a8(oxpos),a2,w
	sub	a2,a1
	abs	a1
	cmpi	>70,a1
	jrlo	q_yes
	jruc	q_no

;*********************************

c_lia_anglez
	callr	react_jump_table_act
	.long	c_lia_zap
	.long	c_lia_zap

c_lia_zap
	callr	d_get_x_dist
	cmpi	>c0,a3
	jrlo	cliaz3
	cmpi	>f0,a3
	jrhi	d_fflip_kick_jump	; kick her !!!

	callr	q_am_i_cornered
	jrnc	d_bflip_jump

	jsrp	stw_proj_proc
	clr	a11
	jsrp	do_jump_up
	movi	>40,a10
	movi	>40,a11
	jsrp	d_run_a11		; run till at a11 distance
	jruc	d_reaction_exit


cliaz3	movi	>40,a10
	movi	>40,a11
	jsrp	d_run_a11		; run till at a11 distance
	jruc	d_uppercut		; too close to edge of world !!


c_swat_bomb_lo
	callr	react_jump_table_act
	.long	c_bomblo_pro
	.long	c_bomblo_pro

c_bomblo_pro
	callr	nr_sweep_if_u_can
	callr	d_get_x_dist 		; a3 = x distance
	cmpi	>b0,a3
	jrlo	duck_under_proj		; close = duk
	jruc	d_fflip_kick_jump


c_swat_bomb_hi
	callr	react_jump_table_act
	.long	d_block_projectile
	.long	c_bombhi_pro

c_bombhi_pro
	callr	nr_sweep_if_u_can
	callr	d_get_x_dist
	cmpi	>110,a3
	jrlo	duck_under_proj
	jruc	run_in_close	

c_sky_ice
	callr	react_jump_table_act
	.long	d_block_projectile
	.long	c_sky_pro

c_sky_pro
	callr	nr_sweep_if_u_can
	movi	q_is_proj_gone,a11
	movi	>30,a10
	jsrp	stance_wait_no
	jruc	run_in_close	

c_floor_blade
	callr	nr_sweep_if_u_can
	callr	d_get_x_dist
	cmpi	>c0,a3
	jrlo	run_in_close_now

	movi	>30,a10
	movi	q_does_blade_exist,a11
	jsrp	stalk_wait_yes
	movi	>60,a10
	movi	q_is_blade_close,a11
	jsrp	stance_wait_yes
	move	a11,a11
	jrne	d_reaction_exit		; no proc = no jump
	jruc	d_jumpup_nocall		; jump up !!


q_does_blade_exist
	movi	pid_blade,a0
	clr	a1
	not	a1
	calla	existp
	jreq	q_no			; no proc
	jruc	q_yes

q_is_blade_close
	callr	q_does_blade_exist
	jrnc	q_yes

	move	*a0(p_otherguy),a1,l
	cmp	a1,a8
	jrne	q_yes			; this is mine !!

	move	*a0(pa8),a5,l
	move	*a5(oxpos),a3,w
	move	*a8(oxpos),a4,w
	sub	a3,a4
	abs	a4
	cmpi	>50,a4
	jrhi	q_no			; too far !!!
	clr	a11			; a11 = zero = jump !
	jruc	q_yes


c_jax_zap2
	callr	react_jump_table_act
	.long	duck_under_mproj
	.long	duck_under_mproj

c_spear
c_lia_forward
c_forward_ice
c_sg_zap
c_st_zap1
c_lk_zaphi
c_tusk_zap
c_robo_zap
c_ind_zap
c_jax_zap1
c_sonya_zap
c_kano_zap
	callr	react_jump_table_act
	.long	duck_under_proj
	.long	ckzap1

ckzap1	callr	nr_sweep_if_u_can
	callr	nr_jump_over_proj	; no return: jump over projectile

duck_under_proj
	calla	reset_proc_stack
	jsrp	do_duck
	jsrp	wait_proj_spawn
	jsrp	wait_proj_pass		; wait for projectile to pass
	jruc	d_backup_jump		; and retp

;*******************

duck_under_mproj
	calla	reset_proc_stack
	jsrp	do_duck
	jsrp	wait_proj_spawn		; 1st let one spawn
	movi	q_is_proj_gone,a11
	movi	>50,a10
	jsrp	still_wait_yes
	jruc	d_backup_jump		; and retp

q_is_proj_gone
	callr	get_his_proj_proc
	jreq	q_yes
	jruc	q_no

;*******************

wait_proj_spawn
	movi	>20,a10			; max wait time
wps3	sleep	1
	dec	a10
	jreq	wps9
	movi	(pid_proj2*>10000)|pid_proj1,a0
	calla	p1p2_pick
	movi	>f00,a1
	calla	existp			; proj proc out there ?
	jrne	wait_proj_found		; yes
*
* no projectile found...
*
	calla	get_his_action
	cmpi	act_proj_sd,a1
	jreq	wps9		; and he is sittin duck ---> exit

	move	a1,a1
	jreq	wps9
	cmpi	>ff,a1
	jrhi	wps9		; and he is not zapping ---> exit
	jruc	wps3		; he is zapping ---> wait

wait_proj_found
wps9	retp


wait_proj_pass
	sleep	1

	callr	get_his_proj_proc
	jreq	wpp9

	move	a0,a7
	move	*a7(p_joyport),a0,l	; a0 = stk table
	move	*a7(pa8),a5,l		; a5 = proj obj
	move	*a5(oxpos),a3,w
	move	*a0,a2,w		; a2 = x offset (stk table)
	move	*a0(16*2),a4,w		; a4 = x size
	move	*a5(oflags),a6,w
	btst	b_fliph,a6
	jreq	wpp5
	neg	a2
	neg	a4			; flipped = reverse offsets
wpp5	add	a2,a3
	sub	a4,a3			; a3 = tail end of proj scan
	move	*a8(oxpos),a2,w

	move	*a5(oflags),a6,w
	btst	b_fliph,a6
	jreq	wpp7
	swap	a3,a2
wpp7	cmp	a3,a2
	jrgt	wait_proj_pass

	movi	act_proj_passed,a1
	move	a1,*a7(p_action),w	; flag: this proj is pass my ahh
wpp9	retp


get_his_proj_proc
	movi	(pid_proj2*>10000)|pid_proj1,a0
	calla	p1p2_pick
	move	a0,a1			; a1 = id we are looking for

	movi	active,a0		; a0 ---> active proc list
ghpp4	move	*a0(plink),a0,l
	jreq	ghpp9			; no more ---> exit
	move	*a0(procid),a2,w	; a2 = pid
	andi	>ff00,a2		; mask off individual stuff
	cmp	a1,a2			; projectile ?
	jrne	ghpp4			; no, keep looking through list
	move	a0,a0			; clear zero bit
ghpp9	rets


nr_jump_over_proj
	callr	d_get_x_dist 		; a3 = x distance
	cmpi	>b6,a3
	jrlo	d_rets			; too close
	pull	a0			; no return

	callr	d_get_x_dist
	cmpi	>f0,a3
	jrlo	d_fflip_kick_jump	; he is close ---> dont wait for proj
			
d_flipk_over_proj
	jsrp	stw_proj_proc
	movi	q_proj_jclose,a11	; question to ask
	movi	>20,a10			; max wait time
	jsrp	stance_wait_yes
	jruc	d_fflip_kick_jump


q_his_proj_proc
	callr	get_his_proj_proc
	jreq	q_no
	jruc	q_yes

q_proj_jclose
	callr	his_proj_front_x
	move	*a8(oxpos),a2,w
	sub	a2,a3
	abs	a3
	cmpi	>90,a3
	jrhi	q_no
	jruc	q_yes


his_proj_front_x
	callr	get_his_proj_proc
	move	a0,a7
	move	*a7(p_joyport),a0,l	; a0 = stk table
	
;*************
;	.if ejbbug	
;	jrne	ftx1
;	movi	>1095,a3
;	calla	send_code_a3		; say toasty so I know the error !
;	movi	>25,a3
;	calla	send_code_a3		; and play different tune
;debug
;	jauc	$
;lftx1	.endif
;*************

	move	*a7(pa8),a5,l		; a5 = proj obj
	move	*a5(oxpos),a3,w
	move	*a0,a2,w		; a2 = x offset (stk table)
	move	*a0(16*2),a4,w		; a4 = x size
	move	*a5(oflags),a6,w
	btst	b_fliph,a6
	jreq	ftx5
	neg	a2
	neg	a4			; flipped = reverse offsets
ftx5	add	a2,a3
	add	a4,a3			; a3 = front x of proj scan
	rets


c_floor_zap
	callr	react_jump_table_act
	.long	run_in_close_now
	.long	run_in_close_now

**************************************************************************
*											     *
*  Sitting ducks										     *
*											     *
**************************************************************************
c_stsw_sd
	callr	nr_attack_sd
	callr	nr_uppercut_if_u_can
	callr	nr_sweep_if_u_can
	callr	d_get_x_dist
	cmpi	>90,a3
	jrhi	d_zap
	jruc	d_reaction_exit


c_robo_tele_sd
	callr	nr_attack_sd
	callr	nr_uppercut_if_u_can
	jruc	d_hi_kick


c_tusk_blur_sd
	callr	nr_attack_sd
	callr	nr_uppercut_if_u_can
	callr	nr_sweep_if_u_can
	callr	random_do
	.word	2
	.long	run_in_close
	.long	d_zap

c_ssd
	callr	nr_attack_sd
	callr	nr_uppercut_if_u_can
	callr	nr_sweep_if_u_can
	callr	random_do
	.word	2
	.long	d_zap
	.long	d_propell_attack

c_lk_bike_sd
c_superk_sd
	movi	>30,a10
	movi	>48,a11
	jsrp	d_stalk_a11		; try 2 get close in !!
	callr	nr_uppercut_if_u_can
	jruc	d_rapid_lo


c_sbike_sd
	callr	nr_attack_sd

	calla	get_x_dist
	cmpi	>d0,a3
	jrhi	d_zap			; too far = zap
	jruc	d_fflip_kick_jump


c_screamed
	movi	>30,a10
	movi	>45,a11
	jsrp	d_stalk_a11		; try 2 get close in !!

	movi	>30,a10
	movi	q_is_he_airborn,a11
	jsrp	stance_wait_no		; wait for him to land
	jruc	d_elbow


c_proj_sd
	move	@diff,a0,w
	cmpi	3,a0
	jrlo	return_to_beware	
	callr	nr_sweep_if_u_can
	movi	ft_robo2,a0
	callr	is_he_him
	jrne	return_to_beware
	callr	get_his_proj_proc		; net proc ?
	jreq	return_to_beware		; no, safe
	jruc	d_block_projectile



c_caught_net
	movi	>30,a10
	movi	>40,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance
	callr	q_is_he_airborn
	jrc	d_uppercut
	jruc	d_attack_very_close

c_frozen
	callr	d_get_x_dist
	cmpi	>e0,a3
	jrlo	c_froze_closer
	jsrp	d_fflip_jsrp		; far = flip foward !!

c_froze_closer
	movi	>30,a10
	movi	>40,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance
	callr	q_is_he_airborn
	jrnc	d_attack_very_close
	calla	get_his_dog
	cmpi	>10,a0
	jrlo	d_uppercut		; close to ground = pow !!
	jruc	d_jump_up_kick		; way off ground ---> jump at him


c_zoom_sd
c_kroll_sd
	callr	nr_attack_sd
	jruc	willy_go_round		; willy go round in circles

c_leg_sd
c_kswipe_sd
counter_grounded_sd
	callr	nr_attack_sd

	calla	get_x_dist
	cmpi	>b0,a3
	jrhi	d_zap			; far = zap
	jruc	d_propell_attack	; close = propell

willy_go_round
	movi	>30,a10
	movi	>40,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance

	movi	>30,a10
	movi	q_willy_uppercut,a11
	jsrp	stance_wait_yes
	jruc	d_uppercut

q_willy_uppercut
	calla	get_his_dog
	cmpi	>40,a0
	jrhi	q_no
	jruc	q_yes


nr_attack_sd
	pull	a14
	callr	should_i_promove
	jrnc	return_to_beware
	jump	a14			; return

**************************************************************************
*											     *
*   Body Propell Moves									     *
*											     *
**************************************************************************
;xxx
c_sz_decoy
	move	@diff,a0,w
	cmpi	3,a0
	jrhs	counter_decoy

;debug
	jruc	counter_decoy

 	movi	rpt_counter,a0
	callr	ask_mr_diff
	jrnc	return_to_beware

counter_decoy
	callr	d_ochar_jump
	.long	decoy_zap_wait
	.long	decoy_zap_wait
	.long	decoy_zap_wait
	.long	decoy_zap_wait
	.long	decoy_zap_wait		; 4 - sz

	.long	decoy_zap_wait
	.long	decoy_zap_wait
	.long	d_propell_attack	; 7 - robo 1
	.long	decoy_zap_wait		; 8
	.long	decoy_zap_wait		; 9

	.long	decoy_zap_wait		; a
	.long	decoy_zap_wait		; b
	.long	decoy_zap_wait		; c
	.long	decoy_zap_wait		; d
	.long	decoy_zap_wait		; e

	.long	decoy_zap_wait
	.long	decoy_zap_wait
	.long	decoy_zap_wait
	.long	decoy_zap_wait



decoy_zap_wait
	movi	ochar_zaps,a0
	callr	d_get_char_word
	jrn	decoy_wait
	jsrp	do_zap			; lia = dont zap !

decoy_wait
	movi	q_is_decoy_alive,a11
	movi	>80,a10
	jsrp	stance_wait_no		; wait for tele
	jruc	d_reaction_exit

q_is_decoy_alive
	movi	pid_decoy2*>10000+pid_decoy1,a0
	calla	p1p2_pick
	clr	a1
	not	a1
	calla	existp
	jreq	q_no
	jruc	q_yes

;********************************

c_lao_tele
 	movi	rpt_counter,a0
	callr	ask_mr_diff
	jrnc	return_to_beware

	movi	q_is_he_below_ground,a11
	movi	>50,a10
	jsrp	stance_wait_yes		; wait for tele
*
* thanks Dave Schwartz...
*
	callr	d_get_x_dist
	cmpi	>70,a3
	jrhi	d_lo_kick		; far = always kick !!

	move	@diff,a0,w
	cmpi	4,a0
	jrhi	d_uppercut
	jruc	d_lo_kick

;**********************

c_sg_pounce
	callr	react_jump_table_act
	.long	av_pounce
	.long	av_pounce

av_pounce
	calla	run_setup
	calla	face_opponent
	movi	>10,a10
avp3	sleep	1
	calla	reduce_turbo_bar
	callr	d_next_anirate
	dsj	a10,avp3		; get out of the way

	calla	stop_me
	jsrp	d_turnaround_jsrp
	jsrp	swait_land_jsrp
	jruc	run_in_close_now

;******************

c_sbike
	callr	react_jump_table_act
	.long	av_sonya_bike
	.long	av_sonya_bike

av_sonya_bike
	calla	get_x_dist
	cmpi	>70,a3
	jrlo	asb2

swait_nonattack_jump
	movi	is_he_attacking,a11	; question to ask
	movi	>40,a10			; max wait time
	jsrp	stance_wait_no
	jruc	d_reaction_exit

asb2	jsrp	do_duck
asb1	sleep	1
	calla	am_i_facing_him
	jrnc	asb3			; crossover = turn around
	callr	is_he_attacking
	jrnc	d_reaction_exit
	jruc	asb1

asb3	jsrp	duck_turnaround
	movi	>40*2,a10
	jsrp	d_wait_nonattack
	jruc	d_reaction_exit

swait_land_jsrp
	movi	is_he_airborn,a11	; question to ask
	movi	>40,a10			; max wait time
	jruc	stance_wait_no

;******************************

c_lao_angle
	callr	react_jump_table_act
	.long	av_lao_angle
	.long	av_lao_angle

av_lao_angle
	movi	lao_angle_wait,a11	; question to ask
	movi	>30,a10			; max wait time
	jsrp	stance_wait_yes

	callr	d_get_his_action
	cmpi	act_lao_angle,a1
	jrne	d_reaction_exit		; not a threat..
	jruc	d_block

lao_angle_wait
	callr	d_get_his_action
	cmpi	act_lao_angle,a1
	jrne	q_yes			; not angle anymore ---> exit
	callr	d_get_x_dist
	cmpi	>70,a3
	jrlo	q_yes
	jruc	q_no

;******************************

c_tele_explode
	callr	react_jump_table_act
	.long	av_tele_explode
	.long	av_tele_explode

av_tele_explode
	movi	>10,a10
	movi	q_my_back_to_him,a11
	jsrp	stance_wait_yes		; wait 4 her 2 cross !!
	calla	am_i_facing_him
	jrc	avtel3
	jsrp	d_turnaround_jsrp

avtel3	movi	>10,a10
	jsrp	d_stance_pause		; DEBUG: do nothing
	jruc	d_hi_kick

;******************************

c_robo_tele
	callr	react_jump_table_act
	.long	av_robo_tele
	.long	av_robo_tele

av_robo_tele
	movi	>06,a10
;	jsrp	d_stance_dumb
	jsrp	d_stance_pause		; pause a sec
	jruc	d_block

;******************************

c_square
	callr	react_jump_table_act
	.long	ct_square
	.long	ct_square

ct_square
	callr	d_get_x_dist
	cmpi	>fc,a3
	jrhi	sq_far			; she is 2 far to cross oh-vah !!
*
* close
*
	movi	>40,a10
	movi	q_my_back_to_him,a11
	jsrp	stance_wait_yes		; wait 4 her 2 cross !!

	jsrp	d_turnaround_jsrp

sq_far	movi	>40,a10
	movi	q_is_he_dropping,a11
	jsrp	stance_wait_yes		; wait 4 her 2 head down...

	callr	d_get_x_dist
	cmpi	>50,a3
	jrlo	hit_drop_sonya
	jruc	d_zap

hit_drop_sonya
	movi	q_square_lower,a11	; question to ask
	movi	>40,a10			; max wait time
	jsrp	stance_wait_yes		; wait 4 her 2 cross !!

	callr	d_either_edge_a5
	cmpi	>50,a5
	jrlo	d_uppercut		; too close to edge of world !!
	jruc	d_hi_kick


c_bike
c_superkang
c_kano_roll
	callr	react_jump_table_act
	.long	ct_propell
	.long	ct_propell

ct_propell
	callr	is_towards_me
	jrnc	return_to_beware

	movi	is_propell_close,a11	; question to ask
	movi	>30,a10			; max wait time
	jsrp	stance_wait_yes
	jruc	d_block


c_ind_charge
c_jax_dash
	callr	react_jump_table_act
	.long	d_block
	.long	ct_jax_dash

ct_jax_dash
	jsrp	do_duck
	jsrp	d_wait_nonattack
	callr	nr_uppercut_if_u_can
	callr	nr_sweep_if_u_can
	jruc	d_reaction_exit

;******************************

c_zoom
	callr	react_jump_table_act
	.long	ct_zoom
	.long	ct_zoom

ct_zoom
	jruc	d_block

;******************************

c_flykick
c_flypunch
	callr	react_jump_table_act
	.long	av_flyattack
	.long	av_flyattack

av_flyattack
	callr	is_towards_me
	jrc	flykick_towards_me
*
* away from me !!
*
	calla	get_x_dist
	cmpi	>40,a3
	jrlo	d_block			; real close ---> avoid turn around hit

	callr	q_will_he_reach_me
	jrnc	return_to_beware
	jruc	d_block

flykick_towards_me
	callr	q_will_he_reach_me	; towards me and close ?
	jrc	return_to_beware 	; rev2.1 change

	calla	get_x_dist
	cmpi	>a0,a3
	jrlo	d_block
*
* escape ?
*
	movi	500,a0
	calla	randper
	jrc	flyk2

	callr	d_behind_me_a5
	cmpi	>80,a5
	jrlo	flyk2
	jruc	d_bflip_jump

flyk2	movi	>30,a10
	movi	is_flyk_close,a11
	jsrp	stance_wait_yes
	callr	d_get_x_dist
	cmpi	>a0,a3
	jrhi	d_reaction_exit		; far away from me ---> exit
	callr	q_is_he_airborn
	jrnc	d_reaction_exit
	jruc	d_block			; rev2.1 change

;***************************************************************************

is_he_body_propell
	callr	d_get_his_action
	srl	8,a1
	sll	8,a1
	cmpi	act_body_propell,a1	; attacking still ?
	jreq	ihbpy			; yes, wait
	clrc
	rets
ihbpy   	setc
	rets

;******************************

c_swat_stick
	callr	react_jump_table_act
	.long	ct_stick_sweep
	.long	ct_stick_sweep

ct_stick_sweep
	callr	is_throwing_allowed
	jrc	stsw_zap

	callr	d_get_x_dist
	cmpi	>80,a3
 	jrlo	d_crossover_kick
	jruc	d_block

stsw_zap
	callr	d_get_x_dist
	cmpi	>80,a3
 	jrlo	d_crossover_kick
	cmpi	>d0,a3
	jrhi	d_zap 			; far from me = zap em
	jruc	d_block

;******************************

c_uppercut
	callr	q_will_he_reach_me
	jrnc	return_to_beware

	callr	react_jump_table_act
	.long	ct_uppercut
	.long	ct_uppercut

ct_uppercut
	jsrp	d_duck_fast
	movi	>40*2,a10
	jsrp	d_wait_nonattack
	callr	nr_uppercut_if_u_can
	callr	nr_sweep_if_u_can
	jruc	d_reaction_exit

;******************************

c_jupkick
c_juppunch
	calla	get_x_dist
	cmpi	>60,a3
	jrhi	return_to_beware		; too far away
	callr	react_jump_table_act
	.long	d_duck
	.long	d_duck

;******************************

c_duckpunch
c_duck_kickh
c_duck_kickl
	callr	q_will_he_reach_me
	jrnc	return_to_beware

	callr	q_is_he_cornered
	jrc	d_crossover_kick

	callr	react_jump_table_act
	.long	d_block
	.long	d_crossover_kick

;******************************

c_knee
c_elbow
	callr	avoid_agressive_bastards
	callr	react_jump_table_act
	.long	d_avoid_elbow_knee		; rev2.1 change
	.long	d_avoid_elbow_knee		; rev2.1 change

d_avoid_elbow_knee
 	movi	rpt_elbow_knee,a0
	callr	ask_mr_diff
	jrnc	d_block

	calla	get_x_dist
	cmpi	>4a,a3
	jrlo	d_slam	 		; he is close up ---> slam 'em !!
	jruc	d_block


rpt_elbow_knee
	.word	100,100,200,400,450,500,600,650,700,750


avoid_agressive_bastards
	move	@diff,a0,w
	cmpi	2,a0
	jrlo	d_rets

	move	*a13(p_action),a0,w
	cmpi	act_getup,a0
	jrne	d_rets			; I am not getting up = return
	
	pull	a0
	calla	get_x_dist
	cmpi	>48,a3
	jrlo	d_slam			; he is close up ---> slam 'em !!
	jruc	d_sweep_kick

;******************************

c_sweep
	move	@diff,a0,w
	cmpi	3,a0
	jrlo	csweep3

	move	*a13(p_action),a0,w
	cmpi	act_react_flipk,a0
	jreq	av_sweep
	cmpi	act_getup,a0
	jreq	av_sweep

csweep3	callr	q_will_he_reach_me
	jrnc	return_to_beware
	callr	react_jump_table_act
	.long	av_sweep			; av = avoid
	.long	ct_sweep			; ct = counter

av_sweep
	callr	q_am_i_cornered
	jrc	d_duck_block
	jruc	d_bflip_jump

ct_sweep
	jruc	d_crossover_kick

;*****************************

c_lia_scream
 	movi	rpt_counter,a0
	callr	ask_mr_diff
	jrnc	return_to_beware

	callr	d_get_x_dist
	cmpi	>d0,a3
	jrlo	d_block

	movi	is_he_attacking,a11	; question to ask
	movi	>60,a10			; max wait time
	jsrp	stance_wait_no
	jruc	d_reaction_exit

c_hipunch
	movi	act_hipunch,a1
	jruc	cpch3

c_lopunch
	movi	act_lopunch,a1

cpch3	push	a1
	callr	d_get_x_dist
	pull	a1
	cmpi	>60,a3
	jrhi	return_to_beware_4get

;	push	a1
;	callr	q_will_he_reach_me
;	pull	a1
;	jrnc	return_to_beware

	callr	react_jump_table
	.long	d_sweep_kick
	.long	d_sweep_kick

c_rhouse
	movi	act_rhouse,a1
	jruc	ckik3

c_noogy
	movi	act_noogy,a1
	jruc	ckik3

c_shake
	movi	act_shake,a1
	jruc	ckik3

c_hikick
	movi	act_hikick,a1
	jruc	ckik3

c_lokick
	movi	act_lokick,a1
ckik3	push	a1
	callr	q_will_he_reach_me
	pull	a1
	jrnc	kick_will_miss
	callr	react_jump_table
	.long	d_block
	.long	ct_kicks			; ct = counter with another move

ct_kicks
	callr	d_get_his_action
	cmpi	act_lokick,a1
	jreq	d_duck				; lokick = cant sweep em
	movk	8,a0
	calla	d_strike_check_a0_test  	; does my uppcut reach ?
	jrc	d_duck_then_uppercut		; yes, duck then do it
	jruc	d_sweep_kick			; no, sweep

kick_will_miss
	callr	d_get_x_dist
	cmpi	>80,a3
	jrlo	d_sweep_kick
	jruc	return_to_beware

;*****************************

c_quake
	callr	react_jump_table_act
	.long	ct_quake
	.long	ct_quake

ct_quake
	callr	nr_hikick_if_u_can
	jruc	d_jumpup_nocall

;*****************************

c_laospin
	callr	react_jump_table_act
	.long	ct_lao_spin
	.long	ct_lao_spin

ct_lao_spin
	move	@diff,a0,w
	cmpi	3,a0
	jrhi	laosp3

	movi	>40*3,a10
	movi	>70,a11
	jsrp	d_stalk_a11		; stalk till at a11 distance
	callr	nr_sweep_if_u_can

laosp3	callr	d_get_x_dist
	cmpi	70,a3
	jrlo	d_zap			; close = zap now

	movi	>20,a10
	jsrp	d_stance_pause		; pause a sec
	jruc	d_zap

;*****************************

c_kano_swipe
	callr	react_jump_table_act
	.long	ct_kswipe
	.long	ct_kswipe

ct_kswipe
	callr	d_get_x_dist
	cmpi	>90,a3
	jrlo	d_block			; reach me ?

	callr	should_i_promove
	jrc	d_zap
	jruc	swait_nonattack_jump

;*****************************

c_axe_up
	callr	q_will_he_reach_me
	jrnc	return_to_beware
	callr	react_jump_table_act
	.long	ct_axe_up
	.long	ct_axe_up

ct_axe_up
	callr	nr_sweep_if_u_can
	jruc	d_block

;*****************************

c_leg_grab
	callr	react_jump_table_act
	.long	ct_leg
	.long	ct_leg

ct_leg
	callr	q_will_he_reach_me
	jrnc	swait_nonattack_jump
	jruc	d_block

;*****************************

return_to_beware_4get
	clr	a0
	move	a0,*a13(p_otheract),w	; forget I was ever here.

return_to_beware
	move	*a13(p_beware_a10),a10,l
	move	*a13(p_beware_a11),a11,l
	move	*a13(p_beware_return),a0,l
	jump	a0


d_land	movk	2,a0
	jsrp	d_beware_mframew
	jruc	d_reaction_exit


d_beware_mframew
	clr	a11
	move	a11,*a13(p_otheract),w	; dont ignore anything
	pullp	a11				; a11 = return address
	calla	init_anirate			; set things arriba !!
dbmf3	sleep	1
	calla	next_anirate
	callr	d_beware
	move	*a9,a1,l
	jrne	dbmf3			; more frames to go ---> loopy
	jump	a11			; return


*
* if abusive kano roller = slam em
*
nr_kano_abuser_check
	callr	q_is_kano_charging
	jrnc	kab6			; dont worry

	movi	rpt_anti_kano,a0
	callr	ask_mr_diff		; written in the starz ?
	jrnc	kab6			; no

	pull	a0			; sans return
	jruc	d_slam			; screw em

kab6	rets


q_is_kano_charging
	move	*a13(p_otherguy),a0,l
	move	*a0(ochar),a0,w
	cmpi	ft_kano,a0
	jrne	q_no			; not kano....

	move	@switch,a0,l
	not	a0
	movi	p2b4,a1
	move	*a8(oid),a2,w
	cmpi	pid_p1,a2		; player 1 = me ?
	jreq	kab3			; yes
	movi	p1b4,a1
kab3	and	a1,a0			; look at low kick
	jreq	q_no			; not pressed
	movi	get_last_kano_charge,a0
	calla	calla_for_him
	cmpi	>48,a1
	jrlo	q_no			; he's not charged up enough
	jruc	q_yes

get_last_kano_charge
	movi	l_lk,a0
	calla	get_tsl   		; get dis event !!
	rets

rpt_anti_kano
	.word	100,100,350,500,600,650,750,750,750,750

**************************************************************************
*											     *
*  how_do_i_react - Answers the question given: a7 = table of randpers   *
* 											     *
*  Input: a1 = action to avoid repeats						     *
*         a7 = 0-3 (magnitude of hit)							     *
* 											     *
*  Returns: a0 = 0 ---> let him hit me						     *
*                1 ---> block / avoid his attack				     *
*                2 ---> counter his attack with one of my own		     *
*											     *
**************************************************************************
react_jump_table_act
	callr	d_get_his_action	; a1 = input: action to avoid

react_jump_table
	pull	a2		 	; a2 = return address

	cmpi	3,a7
	jrls	hdr3
	movk	3,a7
hdr3	callr	count_q_repeats	 	; a3 = # of hits so far

	movi	repeat_table,a0	
	callr	get_diff_word
	cmp	a0,a3			; how many ?
	jrhs	hdr6			; too many ---> counter this move

	movi	d_randpers,a0
	callr	get_diff_word
	calla	randper			; react ?
	jrc	hdr5			; yes

;	jruc	hdr5			; yes always


	jruc	return_to_beware	; no reaction ----> ignore
*
* react to him
*
hdr5 	movi	rpt_counter,a0
	callr	ask_mr_diff
	jrnc	hdr7
hdr6	addi	32,a2			; 2nd entry = counter
hdr7	move	*a2,a2,l		; grab 1st entry = avoid
	jump	a2

;******************************************************************

should_i_promove
 	movi	rpt_counter,a0
	jruc	ask_mr_diff

rpt_promoves
	.word	100,200,300,700,750,775,785,795,800,850

;******************************************************************

rpt_counter
	.word	100,350,550,600,700,750,800,800,800,900

d_randpers
	.word	150,175,300,400,550,600,650,700,750,750

repeat_table
	.word	3,3,3,2,2,2,2,1,1,1

*
* a1 = action  returns: a3 = # of matches found
*
count_q_repeats
	calla	get_my_hitq		; a0 = my hit queue ram
	push	a2
	clr	a3			; start with zero matches
	callr	scan_1_entry
	callr	scan_1_entry
	callr	scan_1_entry
	callr	scan_1_entry
	callr	scan_1_entry
	callr	scan_1_entry		; scan all 6 entries in hit queue
	pull	a2
	move	a3,a3			; set zero flag if no matches found
	rets

scan_1_entry
	move	*a0+,a2,w	
	cmp	a1,a2			; match ?
	jrne	scan1			; no
	inc	a3			; yes, count it
scan1	rets


get_diff_word
	move	@diff,a14,w		; input: a0 = table of 10 words
	sll	4,a14
	add	a0,a14
	move	*a14,a0,w
	rets

**************************************************************************
*											     *
*  Drone external references								     *
*											     *
**************************************************************************

d_flip_kick_jump
	jsrp	do_flip_kick
	jruc	d_reaction_exit

d_body_propell
	movi	reaction_exit,a7
	pushp	a7
	jauc	do_body_propell

d_check_winner_status
	jauc	check_winner_status

d_strike_check_a0_test
	jauc	strike_check_a0_test

d_get_my_dfe
	jauc	get_my_dfe

d_stop_me
	jauc	stop_me

d_reaction_exit
	jauc	reaction_exit

d_reset_proc_stack
	jauc	reset_proc_stack

d_get_his_action
	jauc	get_his_action

d_next_anirate
	jauc	next_anirate

d_get_char_word
	jauc	get_char_word

d_get_x_dist
	jauc	get_x_dist

d_get_char_ani
	jauc	get_char_ani

d_do_next_a9_frame
	jauc	do_next_a9_frame

d_retp	retp

boss_branch
	pull	a0
	move	*a8(ochar),a1,w
	cmpi	ft_motaro,a1
	jreq	bbr_mot		; yes I guess you could call me a boss
	cmpi	ft_sk,a1
	jreq	bbr_sk 		; yes I guess you could call me a boss

	addk	16,a0		; beyond the word !!
	jump	a0		; sans boss = return

bbr_mot	movi	motaro_branches,a1
	jruc	bbr3

bbr_sk	movi	sk_branches,a1
bbr3	move	*a0,a0,w
	sll	5,a0
	add	a1,a0
	move	*a0,a0,l
	jump	a0

;*************************

	.end
