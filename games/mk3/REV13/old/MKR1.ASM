**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mkr1 = round intro jsrp's								*
* 											     *
*  copyright (c) 1995 Midway Manufacturing	   						*
*											     *
**************************************************************************
	.file	'main.asm'
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
	.include	stringh.asm

**************************************************************************

do_round_jsrps
	move	@round_1_jsrp,a1,w
	movi	round_1_jumps,a2

	move	@round_num,a0,w
	cmpi	1,a0
	jreq	round1

	move	@round_23_jsrp,a1,w
	movi	round_23_jumps,a2

round1

	.if ejbbug
	pushp	a1
	jsrp	r_print_diff
	pullp	a1
	.endif

	move	a1,a1
	jreq	l_retp

	dec	a1
	sll	5,a1
	add	a2,a1
	move	*a1,a1,l
	jump	a1

;kodes
round_1_jumps
	.long	r_throwing_disabled		; 1 = throwing disabled
	.long	r_blocking_disabled		; 2
	.long	r_p1_handicap			; 3 =
	.long	r_p2_handicap			; 4 =
	.long	r_dark_fighting			; 5 =
	.long	r_switcheroo	  		; 6 =
	.long	r_jackbot_easy			; 7 = 
	.long	r_p1_supercap			; 8 =
	.long	r_p2_supercap			; 9 =
	.long	r_space_game			; 10 =
	.long	r_wf_motaro			; 11 = winner fights motaro
	.long	r_wf_shao			; 12 = winner fights shao kahn
	.long	r_wf_noob			; 13 = winner fights noob
	.long	r_nofear_clue			; 14 = no fear clue
	.long	r_no_powerbars			; 15 =
	.long	r_uppercut_recovery		; 16 = 
	.long	r_unlim_run			; 17 =
	.long	r_psycho_kombat			; 18 =
	.long	r_intro_message			; 19 =
	.long	r_sf_smoke			; 1a = 

round_23_jumps
	.long	r_throwing_disabled		;  1 = throwing disabled
	.long	r_blocking_disabled		;  2
	.long	r_p1_handicap			;  3 =
	.long	r_p2_handicap			;  4 =
	.long	r_dark_fighting			;  5 =
	.long	r_switcheroo	  		;  6 =
	.long	r_jackbot_easy			;  7 = 
	.long	r_p1_supercap			;  8 =
	.long	r_p2_supercap			;  9 =
	.long	r_space_game			; 10 =
	.long	r_wf_motaro			; 11 = winner fights motaro
	.long	r_wf_shao			; 12 = winner fights shao kahn
	.long	r_wf_noob			; 13 = winner fights noob
	.long	r_nofear_clue			; 14 = no fear clue
	.long	r_no_powerbars			; 15 =
	.long	r_uppercut_recovery		; 16 = 
	.long	r_unlim_run			; 17 =
	.long	r_psycho_kombat			; 18 =
	.long	r_intro_message			; 19 =
	.long	r_sf_smoke			; 1a = 

;**************************************************


r_intro_message
	movi	txt_intro_message,a8
	jruc	msg1

r_psycho_kombat
	movk	1,a0
	move	a0,@f_upcut_rec,w		; flag: recover from upcuts fast
	move	a0,@f_unlim_run,w		; flag: unlimited run !
	move	a0,@f_sans_block,w

	create	pid_psycho,psycho_score_onoff
	create	pid_switcheroo,switcheroo_proc
	create	pid_dark,dark_fight_proc
	movi	txt_psycho_kombat,a8
	jruc	msg1

psycho_score_onoff
	calla	dont_show_scores
	callr	pso3
	calla	prcslp
	calla	show_scores
	callr	pso3
	calla	prcslp
	jruc	psycho_score_onoff

pso3	move	@winner_status,a0,w
	jrne	psox
	movi	>20,a0
	movi	>20,a1
	jauc	randu_minimum

psox	pull	a0
	calla	show_scores
	die

;**********************

r_uppercut_recovery
	movk	1,a0
	move	a0,@f_upcut_rec,w		; flag: recover from upcuts fast
	movi	txt_uppercut_recovery,a8
	jruc	msg1

r_unlim_run
	movk	1,a0
	move	a0,@f_unlim_run,w		; flag: unlimited run !
	movi	txt_unlim_run,a8
	jruc	msg1


r_sf_smoke
	movi	txt_wf_smoke,a8
	movi	post_wf_smoke,a14
	jruc	wf3

r_wf_noob
	movi	txt_wf_noob,a8
	movi	post_wf_noob,a14
	jruc	wf3

r_wf_shao
	movi	txt_wf_shao,a8
	movi	post_wf_shao,a14
	jruc	wf3

r_wf_motaro
	movi	txt_wf_motaro,a8
	movi	post_wf_motaro,a14

wf3	move	a12,a1
	mmfm	a1,a3			; pullp
	mmfm	a1,a3			; pullp
	cmpi	play3,a3		; normal return address ??
	jrne	l_retp

	clr	a0
	move	a0,@round_1_jsrp,w
	move	a0,@round_23_jsrp,w	; only once !!
	calla	clear_combo_ram

	pullp	a0
	pullp	a1
	pushp	a14
	pushp	a0

;	movi	txt_wf_motaro,a8
	jruc	msg1


r_space_game
	create	pid_master,space_game
	movi	txt_rellim,a8
	jruc	msg1

r_no_powerbars
	calla	dont_show_scores
	movi	txt_no_powerbars,a8
	jruc	msg1

r_nofear_clue
	movi	txt_nofear_clue,a8
	jruc	msg1

r_jackbot_easy
	movi	txt_jackbot,a8
	jruc	msg1

r_switcheroo
	create	pid_switcheroo,switcheroo_proc
	movi	txt_switcheroo,a8
	jruc	msg1

r_dark_fighting
	create	pid_dark,dark_fight_proc
	movi	txt_dark_fighting,a8
	jruc	msg1

r_p1_supercap
	create	pid_fx,p1_supercap_proc
	movi	txt_p1_supercap,a8
	jruc	msg1

r_p2_supercap
	create	pid_fx,p2_supercap_proc
	movi	txt_p2_supercap,a8
	jruc	msg1


r_p1_handicap
	create	pid_fx,p1_hadicap_proc
	movi	txt_p1_handicap,a8
	jruc	msg1

r_p2_handicap
	create	pid_fx,p2_hadicap_proc
	movi	txt_p2_handicap,a8
	jruc	msg1


p1_supercap_proc
	movi	pa10,a11
	movi	full_strength/4,a10
	jruc	hand2

p2_supercap_proc
	movi	pa11,a11
	movi	full_strength/4,a10
	jruc	hand2

p1_hadicap_proc
	movi	pa10,a11
	movi	full_strength/2,a10
	jruc	hand2

p2_hadicap_proc
	movi	pa11,a11
	movi	full_strength/2,a10

hand2	jsrp	wait_for_charge
	move	a10,a1
	add	a11,a0
	move	a1,*a0,l		; pass new max to growing proc
	jruc	l_die


wait_for_charge
	sleep	5
	clr	a1
	not	a1
	movi	pid_fx_charge,a0
	calla	existp
	jreq	wait_for_charge
l_retp	retp


r_blocking_disabled
	movk	1,a0
	move	a0,@f_sans_block,w
	movi	txt_no_blocks,a8
	jruc	msg1

r_throwing_disabled
	movk	1,a0
	move	a0,@f_sans_throws,w
	movi	txt_no_throws,a8

msg1	movi	>00f000c8,a9
	jsrp	p7_centered
	movi	oid_r1,a1
	movi	objlst2,a0
msg3	move	a1,*a0(oid),w
	move	*a0,a0,l
	jrne	msg3  		; change all text id ---> oid_r1

	create	pid_r1,msg_round1
	retp

msg_round1
	movi	fl_r1,a11
	create	pid_r1,boonpal_stuff	; flash letters
	move	a0,a11

	sleep	>50

	movi	oid_r1,a0
	calla	dallobj		; delete our text
	movi	pid_r1,a0
	calla	dallprc
l_die	die

;**************************************************

txt_intro_message
	.string	"THERE IS NO KNOWLEDGE THAT IS NOT POWER",0
	.even

txt_psycho_kombat
	.string	"PSYCHO KOMBAT",0
	.even

txt_unlim_run
	.string	"UNLIMITED RUN",0
	.even

txt_uppercut_recovery
	.string	"FAST UPPERCUT RECOVERY ENABLED",0
	.even

txt_no_powerbars
	.string	"NO POWERBARS",0
	.even

txt_wf_smoke
	.string	"WINNER OF THIS ROUND BATTLES SMOKE",0
	.even

txt_wf_noob
	.string	"WINNER OF THIS ROUND BATTLES NOOB SAIBOT",0
	.even

txt_wf_shao
	.string	"WINNER OF THIS ROUND BATTLES SHAO KAHN",0
	.even

txt_wf_motaro
	.string	"WINNER OF THIS ROUND BATTLES MOTARO",0
	.even

txt_rellim
	.string	"YOU ARE ENTERING THE LAND OF RELLIM",0
	.even

txt_nofear_clue
	.string	"NO FEAR = EB BUTTON, SKYDIVE, MAX COUNTDOWN",0
	.even

txt_jackbot
	.string	"HOLD FLIPPERS DURING CASINO RUN",0
	.even

txt_switcheroo
	.string	"RANDPER KOMBAT",0
	.even

txt_no_throws
	.string	"THROWING DISABLED",0
	.even

txt_no_blocks
	.string	"BLOCKING DISABLED",0
	.even

txt_p1_handicap
	.string	"PLAYER 1 HALF POWER",0
	.even

txt_p2_handicap
	.string	"PLAYER 2 HALF POWER",0
	.even

txt_p1_supercap
	.string	"PLAYER 1 QUARTER POWER",0
	.even

txt_p2_supercap
	.string	"PLAYER 2 QUARTER POWER",0
	.even

txt_dark_fighting
	.string	"DARK KOMBAT",0
	.even

;**************************************************

fl_r1	.word	bpal_white,4
	.word	>ffff
	.word	rgb_blue
	.word	end_stuff

;**************************************************

switcheroo_proc
	sleep	8
	move	@f_start,a0,w 		; start fighting ??
	jreq	switcheroo_proc		; no

;	movi	>40*2,a1
;	movi	>40*2,a0
;	calla	randu_minimum

	movk	8,a0			; switch right away
	move	a0,*a13(p_store1),w
	move	a0,*a13(p_store2),w	; switch count down...

switcher3
	move	@p1_bar,a0,w
	jreq	l_die
	move	@p2_bar,a0,w
	jreq	l_die
	move	@f_thatsall,a0,w
	jrne	l_die			; stop upon these events

	sleep	2
	move	@p1_obj,a8,l		; object in question
	move	@p1_proc,a5,l
	move	a13,a11
	addi	p_store1,a11	   	; time since last change
	callr	switcheroo_check

	move	@p2_obj,a8,l		; object in question
	move	@p2_proc,a5,l
	move	a13,a11
	addi	p_store2,a11	   	; time since last change
	callr	switcheroo_check
	jruc	switcher3


switcheroo_check
	push	a13

	move	*a11,a0,w
	jreq	sw_3			; zero = time 2 switch if u can
	subk	2,a0
	jrnn	sw_2
	clr	a0			; count down !!
sw_2	move	a0,*a11,w
	jrne	sw_no			; it isn't soup yet.

sw_3	move	a5,a13			; pretend I am him !!
	calla	am_i_airborn
	jrc	sw_no			; not while in the air !!
	move	*a13(p_flags),a4,w
	btst	pb_special,a4
	jrne	sw_no	     		; special move = no !
	btst	pb_reacting,a4
	jrne	sw_no	      	  	; reacting = no !!

	move	a13,a0
	movi	switcheroo_wake,a7
	calla	fastxfer

	movi	>40*4,a1
	movi	>40*1,a0
	calla	randu_minimum
	move	a0,*a11,w		; setup for next switcheroo

sw_no	pull	a13			; back 2 me ole self agin
	rets

;**************************************************

dark_fight_proc
	sleep	1
	calla	next_anirate
	move	@f_start,a0,w
	jreq	dark_fight_proc		; wait for fighting 2 start

	clr	a0
	move	a0,@f_dark,w		; flag: lights out !
	move	@dlists,a10,l		; grab current dlists
	move	a10,@dark_dlist,l
	sleep	8

dark2	callr	lights_out
dark3	movk	1,a0
	callr	dark_sleep
	move	@f_dark,a1,w		; someone hit ?
	jreq	dark3			; no, stay dark
*
* hit = lights on !!
*
	callr	lights_on
dark4	move	@f_dark,a0,w
	jreq	dark2			; already slept ---> go dark
	clr	a1
	move	a1,@f_dark,w		; flag: no hits
	callr	dark_sleep
	callr	lights_out		; no, off go the lights again
	jruc	dark4


dark_sleep
	pull	a9
	move	a0,a8
darks3	sleep	1
	move	@p1_bar,a0,w
	jreq	dark_abort
	move	@p2_bar,a0,w
	jreq	dark_abort		; zerp power = lights on !
	move	@f_thatsall,a0,w	; flag: enough fighting already
	jrne	dark_abort
	dsj	a8,darks3
	jump	a9

dark_abort
	callr	lights_on
	die



lights_out
	movi	dark_velocities,a0
	move	a0,@call_every_tick,l
	clr	a0
	move	a0,@f_dark,w		; flag: no hit
	move	a0,@dlists,l		; turn out the lights
	rets

lights_on
	movi	qwerty,a0
	move	a0,@call_every_tick,l	; normal 
	move	a10,@dlists,l			; show things
	rets

dark_velocities
	move	@dark_dlist,a11,l
	subi	64,a11

darkv2	addi	64,a11
	move	*a11,a0,l
	jaeq	qwerty			; all velocities updated ---> qwerty
	jrnn	darkv3			; routine = skip this bs

	move	*a11(32),a0,l
	cmpi	use_next_y,a0
	jrne	darkv2
	addi	32,a11			; skip special case routine
	jruc	darkv2

darkv3	move	*a0,a0,l		; any list ?
	jreq	darkv2			; no
	move	*a0(oxval),a1,l
	move	*a0(oxvel),a2,l
	add	a2,a1
	move	a1,*a0(oxval),l
	move	*a0(oyval),a1,l
	move	*a0(oyvel),a2,l
	add	a2,a1
	move	a1,*a0(oyval),l		; manually process velocities
	jruc	darkv3


lights_on_hit
	push	a14
	movi	>18,a14
	move	a14,@f_dark,w		; flag to darkman !!
	pull	a14
	rets

lights_on_slam
	push	a14
	movi	>38,a14
	move	a14,@f_dark,w		; flag to darkman !!
	pull	a14
	rets

space_game
	sleep	>40*2
	jsrp	hidden_game
	calla	murder_myoinit_score
	create	pid_amode,game_over
	clr	a0
	move	a0,@f_nosound,w	 	; are we allowed ??
	die


post_wf_smoke
	movk	ft_smoke,a0
	jruc	postw2

post_wf_noob
	movk	ft_noob,a0
	jruc	postw2

post_wf_shao
	movk	ft_sk,a0
	jruc	postw2

post_wf_motaro
	movk	ft_motaro,a0
postw2	pushp	a0

	jsrp	results_of_round
	movk	1,a0
	move	a0,@f_thatsall,w	; flag: enough fighting already
	jsrp	bonus_count		; print "winner is" msg / retp

	clr	a0
	movi	p1_state,a1,w		; loser
	movi	p1_char,a3
	move	@p1_bar,a2,w
	jreq	postw3
	movi	p2_state,a1,w
	movi	p2_char,a3
postw3	move	a0,*a1,w		; loser = out of it !!

	pullp	a5			; new ochar
	move	a5,*a3,w		; new ochar !!!

;	sleep	8

	clr	a0
	move	a0,@p1_matchw,w
	move	a0,@p2_matchw,w

	calla	reset_proc_stack
	calla	murder_myoinit_score

	move	@diff,a0,w
	pushp	a0
	clr	a0
	move	a0,@p1_matchw,w
	move	a0,@p2_matchw,w
	callr	special_game_init
	jsrp	play_1_round
	jsrp	results_of_round
	pullp	a0
	move	a0,@diff,w		; restore original diff !!

	movk	1,a0
	move	a0,@f_thatsall,w	; flag: enough fighting already
	jsrp	bonus_count		; print "winner is" msg / retp

	callr	special_game_init
	calla	advance_curback

	movi	p1_state,a1
	move	@p1_state,a0,w
	cmpi	ps_active,a0
	jrne	postw5
	movi	p2_state,a1
postw5	movi	ps_buyin,a2
	move	a2,*a1,w		; non-active guy = in buyin
	jsrp	do_buyin

;	move	@p1_state,a1,w
;	move	@p2_state,a2,w
;	mmtm	sp,a1,a2
;	calla	game_init   		; reset everything
;	mmfm	sp,a1,a2
;	move	a1,@p1_state,w
;	move	a2,@p2_state,w

	calla	advance_curback
	jauc	game_loop


special_game_init
	move	@p1_state,a1,w
	move	@p2_state,a2,w
	mmtm	sp,a1,a2
	calla	game_init   		; reset everything
	mmfm	sp,a1,a2
	move	a1,@p1_state,w
	move	a2,@p2_state,w
	rets

;****************************************************

r_print_diff
	calla	count_active_players
	cmpi	2,a0
	jreq	l_retp
	move	@diff,a0,w
	move	a0,@pf_ram,l
	movi	txt_diff,a8
	jruc	msg1

txt_diff
	.string	"D=%d"
	.byte	0
	.long	pf_ram
	.even

;************************************************************

	.end
