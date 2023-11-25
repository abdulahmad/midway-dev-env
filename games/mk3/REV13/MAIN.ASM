**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: main.asm ---  main game flow							*
* 											     *
*  copyright (c) 1994-95 Midway Manufacturing	   					*
*											     *
**************************************************************************
	.file	"main.asm"
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
	.include	bgndtbl.glo
	.include	stringh.asm
	.include	diagaudn.asm
;	.include	brief\mkbrief.asm

	.global	setup
	.text

SETUP	jauc	POWERRET	 ; toddview needs this line 'o' code

	.ref	get_aud,clr_aud,coinflag
	.ref	seccall2,form_coin_cksum_and_store


force_char
	.if ejbbug
	move	@f_fastrun,a6,w
	jrne	force_it
	rets

	.else
	rets
	.endif


force_it
	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jreq	frets

;	clr	a0

	move	@p1_char,a0,w
	cmpi	14,a0
	jrne	ddd
	clr	a0
	not	a0
ddd	inc	a0
	move	a0,@p1_char,w
	move	a0,@p2_char,w

;*******************
;	.if fataldemo
;	movk	15,a0
;	calla	randu
;	dec	a0
;	move	a0,@p1_char,w
;	movk	15,a0
;	calla	randu
;	dec	a0
;	move	a0,@p2_char,w
;	.endif
;*******************

frets	rets


corpse_a9_proc
	move	*a9(p_flags),a4,w
	ori	pm_corpse,a4
	move	a4,*a9(p_flags),w	; losing drone = dead corpse
	rets

p1_start_button
	movi	p1_state,a2		; a2 ---> player state ram
	clr	a4			; a4 = player offset
	jruc	start_entry

p2_start_button
	movi	p2_state,a2		; a2 ---> player state ram
	movk	1,a4	   		; a4 = player offset

start_entry
	movk	1,a0
	move	a0,@f_start_pressed,w	; flag: start button pressed !!
	move	@gstate,a0,w
	sll	5,a0
	addi	start_gstate_jumps,a0
	move	*a0,a0,l
	jump	a0


barge_game_start
	mmtm	a12,a2,a4		; save player info
	move	*a2,a0,w
	cmpi	ps_active,a0		; player already active ?
	jaeq	sucide			; yes, ignore

	calla	cr_strtp		; enough to start ?
	jalo	sucide			; no

	calla	p_start			; yes, take away proper # of credits

;*****************************
;	.if ejbbug
;	move	@f_fastrun,a6,w
;	jrne	skip_barge
;	jsrp	barge_in_message
;skip_barge
;	.else
;	jsrp	barge_in_message
;	.endif
;*****************************

	calla	clr_scrn
	calla	murder_myoinit
	callr	advance_curback

	move	@p1_state,b0,w
 	move	@p2_state,b1,w
	callr	game_init		; amode ---> reset everything
	move	b0,@p1_state,w
	move	b1,@p2_state,w		; leave pstates alone
	mmfm	a12,a2,a4		; save player info
	jruc	start_a_game



amode_game_start
gover_game_start
	calla	cr_strtp			; enough to start ?
	jalo	sucide				; no

	mmtm	sp,a2,a4
	calla	murder_myoinit_score
	calla	display_on
	mmfm	sp,a2,a4

	clr	a0
	move	a0,@c_1p_tries,w

	callr	game_init			; amode ---> reset everything
	movk	1,a0
	move	a0,@battle_num,w		; battle one !!

do_pstate_jump
	move	*a2,a0,w	 		; players current state ?
	move	a0,a1
	sll	5,a0
	addi	start_pstate_jumps,a0
	move	*a0,a0,l
	jump	a0


start_gstate_jumps
	.long	sucide			; 0
	.long	amode_game_start	; 1 - amode
	.long	barge_game_start	; 2 - fighting
	.long	do_pstate_jump		; 3 - buyin
	.long	do_pstate_jump		; 4 - fighter select
	.long	barge_game_start	; 5 - bonus count
	.long	barge_game_start	; 6 - pre-fight setup
	.long	barge_game_start	; 7 - round intro
	.long	sucide			; 8 - diag
	.long	sucide			; 9 - chop sequence
	.long	sucide			; a - enter initials
	.long	gover_game_start	; b - game over start !!
	.long	sucide			; c - octupus
	.long	sucide			; d - post player select fade shit
	.long	sucide			; e -
	.long	sucide			; f - intro effect
	.long	sucide			; 10 -
	.long	sucide			; 11 -
	.long	sucide			; 12 -
	.long	sucide			; 13 -
	.long	sucide			; 14 -
	.long	sucide			; 15 -

start_pstate_jumps
	.long	start_check		; 0 = not in game
	.long	sucide			; 1 = active
	.long	buyin_check		; 2 = buyin
	.long	auto_select_check	; 3 = player select
	.long	sucide			; 4 =
	.long	sucide			; 5 =
	.long	sucide			; 6 =
	.long	sucide			; 7 =

auto_select_check
	movk	1,a5			; p1 up mask
	movk	ft_st,a6
	movi	pid_p1sel,a0
	cmpi	p1_state,a2		; which player am I ??
	jreq	asc3
	movi	0100H,a5			; p2 up mask
	movk	ft_lk,a6
	movi	pid_p2sel,a0
asc3	clr	a1
	not	a1
	calla	existp			; do I have a cursor proc out there
	jreq	asc9

	move	*a0(pwake),a1,l
	cmpi	psel_cursor_loop,a1	; yes, is it where it should be
	jrne	asc9			; no, sorry no auto shit

	move	*a0(p_store6),a1,l	; p_mychar !!!!
	move	*a1,a1,w		; a1 = my current ochar
	cmp	a1,a6			; on original spot ?
	jrne	asc9			; nope.

	move	@switch,a2,l
	not	a2			; switch bits
	and	a5,a2			; am I pushing joystick up ?
	jreq	asc9			; nope...

	movi	auto_player_select,a7
	calla	fastxfer		; yes ---> auto player select

asc9	die


start_check
	calla	cr_strtp		; enough to start ?
	jalo	sucide			; no
	calla	p_start			; yes, take away proper # of credits
	jruc	start_a_game

buyin_check
	calla	cr_contp		; enough to continue ?
	jalo	sucide			; no
	calla	p_cont			; yes ---> dec credit count
	jruc	start_a_game

**************************************************************************
*											     *
*  start_a_game - game start proc							     *
*											     *
**************************************************************************
start_a_game
	movi	pid_master,a0
	move	a0,*a13(procid),w	; i am the master game flow proc

	movi	p1_wiar,a0
	movi	p1_rwon,a1
	movi	p1_state,a2
	move	a4,a4
	jreq	sag3
	movi	p2_wiar,a0
	movi	p2_rwon,a1
	movi	p2_state,a2

sag3	clr	a3
	move	a3,*a0,w		; buyin = clear wins in a row
	move	a3,*a1,w		; buyin = clear total rounds won

	calla	update_pmsg

	move	@gstate,a0,w
	cmpi	gs_psel,a0
	jaeq	join_in_during_psel	; during psel ---> join in

game4	movi	gs_psel,a0
	move	a0,@gstate,w		; game state = player select mode
	movk	ps_psel,a0
	move	a0,*a2,w

;************** ejbpatch
; put this back in (why the heck does this not find eliminate_buyins !?!?
;	calla	elminate_buyins
;**************

	.if ejbbug
	move	@f_fastrun,a0,w
	jreq	skipf

	movk	ps_active,a0
	move	a0,@p1_state,w		; debug: force p1 in game
	move	a0,@p2_state,w		; debug: force p1 in game

	.if fataldemo
	clr	a0
	move	a0,@p1_state,w		; debug: force p1 in game
	move	a0,@p2_state,w		; debug: force p1 in game
	.endif


;sstate

skipf
	.endif

	callr	match_init
	jsrp	player_select

game_loop
	callr	count_active_players	; a0 = # of active players
	jreq	game_over		; both players gone ---> game over

	jsrp	vs_or_ladder		; vs screen or ladder !?

round_loop
	jsrp	check_battle_milestone

	callr	count_active_players	; a0 = # of active players
	jreq	game_over		; both players gone ---> game over
	cmpi	2,a0
	jreq	play2			; 2 player ---> skip drone char stuff

	callr	clear_combo_ram		; 1 player game ---> NO combo stuff
	movi	gs_round_intro,a0
	move	a0,@gstate,w		; game state: intro
	callr	set_drone_ochar 	; determine drone from current map position
	jrc	game_over

;	cmpi	ft_endur2a,a0  		; special case modes ?
;	jrge	endurance_round		; yes

play2	jsrp	play_1_round
play3	jsrp	results_of_round

	move	@p1_matchw,a0,w
	move	@p2_matchw,a1,w
	movk	2,a2
	calla	double_compare		; anyone won 2 yet ?
	jrne	play7			; no ---> bonus count

	callr	inc_winners_wiar	; winner = 1 more "win in a row"
	calla	update_win_counters

	move	@clk_ones,a0,w
	move	@clk_tens,a1,w
	add	a0,a1
	jreq	play7			; timeout round ---> skip FINISH HIM !!

	jsrp	finish_him_sequence	; yes, give him a chance to finish !!
	callr	set_winner_status

play7	movk	1,a0
	move	a0,@f_thatsall,w	; flag: enough fighting already
	jsrp	bonus_count		; print "winner is" msg / retp

	move	@p1_matchw,a0,w
	move	@p2_matchw,a1,w
	movk	2,a2
	calla	double_compare		; anyone won 2 yet ?
	jrne	round_loop		; no, play another round

	callr	end_of_match_chores

;**********
	callr	count_active_players
	move	a0,a14			; a14 = active players before buyin
	pushp	a14
;**********

	callr	loser_in_buyin		; loser = buyin state

	jsrp	check_enter_initials1
	jsrp	do_buyin

	pullp	a14				; a14 = active players before buyin
	cmpi	1,a14
	jreq	skip_inits

	jsrp	check_enter_initials2	; if loser didn't buyin, check hstd

skip_inits
	callr	current_drone_a0
	cmpi	sp_end,a0
	jreq	game_over		; ff = end of the line
	jruc	game_loop


endurance_round
	subi	ft_endur2a,a0
	sll	5,a0
	addi	endurance_matches,a0,w
	move	*a0,a0,l
	move	a0,*a13(p_store1),l	; save endurance table
	callr	drone_char_point_a6	; a6 ----> p?char
	move	*a0,a1,w		; grab ochar value
	jreq	endurance_over
	move	a1,*a6,w		; 1st endurance ochar !
	jsrp	play_1_round

endr3	callr	drone_char_point_a6	; a6 ----> p?char
	movi	p1_char,a5
	move	@p2_obj,a8,l
	move	@p2_bar,a0
	jreq	endr1			; player 1 wins
	movi	p2_char,a5
	move	@p1_obj,a8,l
endr1	cmp	a5,a6			; winner human ??
	jreq	endurance_over		; no

	move	*a13(p_store1),a0,l
	addk	16,a0
	move	a0,*a13(p_store1),l	; save endurance table spot
	callr	drone_char_point_a6	; a6 ----> p?char
	move	*a0,a1,w		; grab ochar value
	jreq	endurance_over

	move	a1,*a6,w		; 1st endurance ochar !
	jsrp	spawn_another_fighter
	jsrp	master_mercy_entry	; wait for results of this one !
	calla	reset_proc_stack
	jruc	endr3

endurance_over
	jruc	play3


endurance_matches
	.long	e2_a
	.long	e2_b
	.long	e2_c
	.long	e2_d
	.long	e2_e
	.long	e2_f
	.long	e3_a


e2_a	.word	ft_st,ft_lia,0
e2_b	.word	ft_kano,ft_sg,0
e2_c	.word	ft_sonya,ft_jax,0
e2_d	.word	ft_robo1,ft_tusk,0
e2_e	.word	ft_lao,ft_lk,0
e2_f	.word	ft_indian,ft_subzero,0

e3_a	.word	ft_tusk,ft_lk,ft_lao,0


**************************************************************************

set_winner_status
	movk	2,a1
	move	@p1_bar,a0,w
	jreq	sws4
	movk	1,a1
sws4	move	a1,@winner_status,w	; declare the winner !!
	rets

**************************************************************************
*											     *
*  play_1_round - Master process routine to play 1 round !!		     *
* 											     *
*  Returns: a11 --> 0 ---> player 1 won the round					*
*                   1 ---> player 2 won the round					*
*                   2 ---> tied									*
*                   3 ---> timeout (clock hit zero)				     *
*											     *
**************************************************************************
play_1_round
;	movi	qwerty,a0
;	move	a0,@call_every_tick,l

	movi	gs_pfsetup,a0
	calla	set_game_state		; game state: pre-fight setup

	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jreq	play00
	calla	murder_myoinit_score	; amode = dont kill everyone
play00	calla	oinit
	calla	setup_score_ram
	movi	SCORE_P,a0
	calla	getfpal 		; palette #2 = vogel's score palette

	movi	qwerty,a0
	move	a0,@call_every_tick,l

	callr	force_char
	calla	display_off

	move	@curback,a11,w

	move	@p1_char,a0,w
	move	@p2_char,a1,w
	movi	ft_motaro,a2
	calla	double_compare
	jrne	play0
	movk	4,a11			; motaro = always use tower background
	jruc	playn

play0	movi	ft_sk,a2
	calla	double_compare
	jrne	playm
	movk	10,a11			; shao kahn = always use pit 3
	jruc	playn

playm	movi	ft_noob,a2
	calla	double_compare
	jrne	playn
	movk	18,a11			; noob = always use nowall tower

playn	move	@f_smoke,a2,w
	jrne	playo			; adjustment is set - this is not special

	movi	ft_smoke,a2
	calla	double_compare
	jrne	playo
	movk	00bH,a11			; smoke = hidden portal background

playo	move	a11,@curback,w
	calla	do_a11_background

	callr	round_init
	calla	update_knotches
	calla	update_pmsg
	calla	update_win_counters
	calla	show_scores
	sleep	1

	create	pid_repell,repell
	create	pid_scroll,scroller
	calla	setup_players
	calla	start_shadows
	movi	gs_round_intro,a0
	calla	set_game_state
	callr	play_background_tune

	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jreq	play1a
	callr	try_briefcase		    	; try combination
	jsrp	do_round_jsrps
play1a	create	pid_fx,round_intro_fx	; grow bars / FIGHT / say: ROUND 1
	sleep	1

	.if ejbbug
	move	@f_fastrun,a6,w
	jrne	skip_intro
	.endif

	movi	020H,a10
	jsrp	fast_fadein_jsrp
	sleep	040H  			; time for fx to run

skip_intro
	.if ejbbug
	calla	display_on
	.endif

post_sec_trash

	.if ejbbug
	move	@f_nopower,a0,w
	jreq	leave_power

	movk	1,a0
;	move	a0,@p1_bar,w
	move	a0,@p2_bar,w
	move	a0,@p1_matchw,w
;	move	a0,@p2_matchw,w

;	move	@map_position,a0,w
;	cmpi	10,a0
;	jrge	leave_power
;	movk	10,a0
;	move	a0,@map_position,w

leave_power
	.endif


master_mercy_entry
	movk	1,a0
	move	a0,@f_start,w		; flag: start fighting !!

	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jaeq	sucide			; attact mode ----> die
*
* clock countdown
*
	movi	gs_fighting,a0
	calla	set_game_state

	movk	11,a9			; clock speed
	movk	9,a11			; 9 tens
   	movk	9,a10			; 9 ones = 99 seconds
clock3	move	a10,@clk_ones,w
	move	a11,@clk_tens,w

	move	a10,a1
	movi	entry_12,a0
	calla	update_clock_ones

	cmpi	2,a11
	jrhs	clock5
	tsound	017H			; time down tick
clock5	move	a10,a0
	add	a11,a0			; total digits
	jreq	round_timeout

	move	a9,a8			; reset counter
clock4	sleep	3

	move	@p1_bar,a0,w
	jreq	round_is_over
	move	@p2_bar,a0,w
	jreq	round_is_over		; either bar zero ---> round over !!

	dsjs	a8,clock4
	dec	a10			; dec ones
	jrnn	clock3

	movk	9,a10
	dec	a11			; time never runs out (debug)
	move	a11,a1
	movi	entry_11,a0
	calla	update_clock_tens	; update TENS digit
	jruc	clock3


round_is_over
	move	@p1_bar,a1,w
	move	@p2_bar,a2,w
	cmp	a1,a2			; tie ?
	jreq	round_tied

;	movi	p1_matchw,a5
	movk	1,a6
	cmp	a2,a1
	jrhi	p1_won

p2_won	movk	1,a11
	jruc	prend

p1_won	clr 	a11			; 0 = normal ending (somebody won)
	jruc	prend

round_timeout
	clr	a11
	move	a11,@clk_ones,w
	move	a11,@clk_tens,w		; zero clock digits
	movk	3,a11
	jruc	prend

round_tied
	movk	2,a11			; 2 = tie

prend	calla	killfx			; round is over
	callr	weed_out_cheaters	; keep things legit
l_retp	retp

;***********************************************************************

master_proc_mercy
	clr	a0
	move	a0,@f_start,w		; dont fight just yet
	move	a0,@f_thatsall,w

	move	@p1_char,a10,w
	movi	p1_wiar,a0
	move	@p1_bar,a2,w		; player 1 have power ?
	jrne	merc2			; yes ---> p1 is the merciful one !
	move	@p2_char,a10,w
	movi	p2_wiar,a0
merc2	move	*a0,a1,w
	jreq	merc3
	dec	a1
merc3	move	a1,*a0,w		; take "win in a row" from the winner

	movi	p1_bar,a5
	movi	p2_matchw,a6
	callr	restore_power
	movi	p2_bar,a5
	movi	p1_matchw,a6
	callr	restore_power  		; more power to the loser !

	move	@clk_tens,a0,w
	cmpi	4,a0
	jrhs	merc4
	movk	4,a0
merc4	move	a0,@clk_tens,w		; make sure enough time left 2 fight

	calla	update_knotches
	calla	update_pmsg
	calla	update_win_counters
	calla	show_scores

	movi	01dH,a0
	calla	create_fx		; MERCY effect
	move	a10,*a0(pa10),l		; pass merciful ochar

	movi	gs_round_intro,a0
	move	a0,@gstate,w		; game state: intro
	sleep	040H

	move	@p1_proc,a0,l
	movi	mercy_start,a7
	calla	fastxfer
	move	@p2_proc,a0,l
	movi	mercy_start,a7
	calla	fastxfer		; both players in stance animation

	sleep	040H

	clr	a0
	move	a0,@winner_status,w	; now there is no winner !!
	calla	reset_proc_stack

	movi	play3,a0
	pushp	a0			; here is where we "retp" to
	jruc	master_mercy_entry



restore_power
	move	*a5,a0,w
	jrne	rest3
	movk	5,a0
	move	a0,*a5,w		; retore a little power !!
	movk	1,a0
	move	a0,*a6,w		; match wins = 1
rest3	rets


mercy_start
	calla	back_to_normal
	calla	face_opponent
	calla	disable_all_buttons
	jsrp	wait_for_start	  	; stance till fight begins
	jauc	reaction_exit

;**********************************************

spawn_another_fighter
	callr	drone_char_point_a6	; a6 ----> drones p?char
	calla	getprc		   	; grab a process for ram
	movi	01000H,a6
	move	a6,*a0(ptime),w		; sans wakeup
	move	a0,a6
	addi	pdata,a6   		; a6 = multipart ram starts here !!
	move	a6,*a8(oimg),l		; new proc pointer for oimg data
	move	*a8(oshape),a0,l
	calla	ani2			; reshape him now

	clr	a0
	move	a0,@f_start,w		; flag: dont fight yet
	movk	4,a1
	move	a1,@winner_status,w	; endurance transition state !!!

	sleep	2

	move	@p1_proc,a0,l
	move	@p2_proc,a1,l
	callr	loser_pick_a0
	move	a0,a9
	callr	corpse_a9_proc

	move	@p1_obj,a0,l
	move	@p2_obj,a1,l
	callr	loser_pick_a0
	move	a0,a8			; a8 = loser's obj

	movi	050H,a10
spawn2	sleep	1
	push	a13
	move	a9,a13
	calla	am_i_airborn		; wait for him 2 land !!
	pull	a13
	jrnc	spawn3			; on ground = ok to spawn other guy
	dsj	a10,spawn2

	push	a13
	move	a9,a13
	calla	stop_me
	calla	ground_player		; force me on the ground
	movi	collapse_on_ground,a0
	move	a0,*a13(pwake),l	; and wake up here !!
	pull	a13

spawn3	movi	p1_proc,a5
	movi	setup_player_1,a6
	move	@p1_bar,a3,w
	jreq	endr5
	movi	p2_proc,a5
	movi	setup_player_2,a6
endr5	push	a5
	call	a6			; create another obj 4 new endurance guy
	pull	a5
	move	*a5,a5,l		; a5 = new player proc
	calla	init_p_others		; link everyone up
	movi	new_endurance_guy,a7
	move	a7,*a5(pwake),l		; repoint player ---> endurance !!

	movi	p1_bar,a0
	move	*a0,a1,w
	jreq	endr7			; no power = recharge
	movi	p2_bar,a0
endr7	movi	full_strength,a1
	move	a1,*a0,w

	sleep	020H
	movi	pid_scroll,a0
	calla	dallprc			; kill old scroller
	movi	pid_shaker,a0
	calla	dallprc
	create	pid_scroll,scroller	; back 2 normal scrolling

	clr	a1
	move	a1,@winner_status,w	; back to no winner again !!
	sleep	020H
	retp

loser_pick_a0
	move	@p1_bar,a2,w
	jreq	loser9
	move	a1,a0
loser9	rets

**************************************************************************
*											     *
*  results_of_round - Acts on the results of the round based on	     *
* 											     *
*  a11 --> 0 ---> player 1 won the round						     *
*          1 ---> player 2 won the round						     *
*          2 ---> tied									     *
*          3 ---> timeout (clock hit zero)						     *
*											     *
**************************************************************************
results_of_round
	move	a11,a0
	sll	5,a0
	addi	round_results_tab,a0
	move	*a0,a0,l
	jump	a0

round_results_tab
	.long	player_1_won		; 0 - player 1 won
	.long	player_2_won		; 1 - player 2 won
	.long	its_a_tie		; 2 - tie
	.long	clock_ran_out		; 3 - timeout

player_1_won
	movk	1,a1
	move	a1,@winner_status,w	; winner status = player 1

	movi	p1_matchw,a0
	callr	local_inc_a0_word	; add to his match wins
	movi	p1_rwon,a0
	callr	local_inc_a0_word	; add to his total rounds won
	jruc	results_retp

player_2_won
	movk	2,a1
	move	a1,@winner_status,w	; winner status = player 2

	movi	p2_matchw,a0
	callr	local_inc_a0_word	; add to his match wins
	movi	p2_rwon,a0
	callr	local_inc_a0_word	; add to his total rounds won
	jruc	results_retp

its_a_tie
	retp

clock_ran_out
	movk	1,a0
	move	a0,@f_thatsall,w	; flag: enough fighting already
	jsrp	print_timeout_msg
	movi	play3,a0
	pushp	a0			; fake a return address
	jruc	round_is_over		; walk through results again

results_retp
	calla	update_knotches

;********
;	.if ejbbug
;	jruc	game_finished		; yes, game over
;	.endif
;********

	move	@p2_char,a1,w
	move	@p1_matchw,a2,w
	movi	p1_state,a3
	move	@winner_status,a0,w
	cmpi	1,a0
	jreq	res4
	move	@p1_char,a1,w
	move	@p2_matchw,a2,w
	movi	p2_state,a3

res4	cmpi	2,a2			; 2 wins ?
	jrne	res5			; nope

	move	*a3,a3,w		; winner state ?
	cmpi	ps_active,a3,w		; winner human ??
	jrne	res5			; no....

	callr	count_active_players	; a0 = # of active players
	cmpi	2,a0
	jreq	res5			; 2 player game = exit

	move	@map_start,a0,l
	jreq	res5			; no map defined yet ---> exit
	move	@map_position,a1,w
	inc	a1
	sll	4,a1
	add	a1,a0
	move	*a0,a0,w
	cmpi	sp_end,a0		; did player just beat da game ???
	jreq	game_finished		; yes, game over

res5	retp

game_finished
	callr	reset_map_variables
	movi	gs_gameover,a0
	move	a0,@gstate,w		; game start = over !!
	movi	aud_finish,a0
	calla	aud1			; audit this event !!
	jauc	shao_kahn_death_fx

pf_entered
	mess_mac rd15font,0,scrrgt/2,040H,001010000H,strcnrmos_scr,0
	.byte	0
	.even

txt_p1_entered
	.string	"PLAYER 1 HAS ENTERED\nTHE TOURNAMENT !",0

txt_p2_entered
	.string	"PLAYER 2 HAS ENTERED\nTHE TOURNAMENT !",0

**************************************************************************
*											     *
*  check_enter_initials - check if its time to enter initials, if so     *
*                         setup variables and call the routine		     *
*											     *
**************************************************************************
check_enter_initials1
	move	@p1_state,a0,w
	jreq	sans_enter_initials
	move	@p2_state,a0,w
	jreq	sans_enter_initials	; any player NOT in ---> no inits

check_enter_initials2
	move	@p1_state,a0,w
	move	@p2_state,a1,w
	move	a1,a5
	add	a0,a5
	jreq	sans_enter_initials	; nobody playing anymore = no initials

	move	@p1_state,a0,w
	cmpi	ps_active,a0
	jrne	cei7			; p1 not active ---> check
	move	@p2_state,a0,w
	cmpi	ps_buyin,a0		; im in / he's buyin ---->  skip
	jreq	cei8

cei7	move	@p1_wiar,a0,w
	calla	does_a0_cut_it		; p1 = enough wins to cut the mustard ?
	jrc	cei1

cei8	move	@p2_state,a0,w
	cmpi	ps_active,a0
	jrne	cei9			; p2 not active ---> check
	move	@p1_state,a0,w
	cmpi	ps_buyin,a0
	jreq	sans_enter_initials	; im in / he's buyin ---->  skip

cei9	move	@p2_wiar,a0,w
	calla	does_a0_cut_it		; p2 = enough wins to cut the mustard ?
	jrnc	sans_enter_initials	; no, exit
*
* player 2 enter your initials
*
	movk	1,a7
	move	@p2_wiar,a6,w
	jruc	cei2
*
* player 1 enter your initials
*
cei1	clr	a7
	move	@p1_wiar,a6,w

cei2  	move	a7,*a13(p_flags),w	; save player offset here
	move	a6,*a13(p_anitab),l
	jauc	enter_initials

sans_enter_initials
	retp

**************************************************************************
*											     *
*  is_finish_him_allowed - looks at the game situation an answers with   *
* 											     *
*  carry set = yes, run the finish him sequence					     *
*      clear = no, skip finish him							     *
*											     *
**************************************************************************
is_finish_him_allowed
	move	@p2_char,a0,w
	move	@p1_char,a1,w
	movi	ft_motaro,a2
	calla	double_compare
	jreq	q_no

	movi	ft_sk,a2
	calla	double_compare
	jreq	q_no

	movi	ft_noob,a2
	calla	double_compare
	jreq	q_no

	move	@clk_ones,a0,w
	move	@clk_tens,a1,w
	add	a0,a1
	jreq	q_no			; no time left ---> no finish him

q_yes	setc				; everything else is just a light
	rets
q_no	clrc
	rets

**************************************************************************
*											     *
*                MASTER CONTROL PROCESS ROUTINES				     *
*                MASTER CONTROL PROCESS ROUTINES				     *
*                MASTER CONTROL PROCESS ROUTINES				     *
*                MASTER CONTROL PROCESS ROUTINES				     *
*											     *
**************************************************************************

try_briefcase
	clr	a5			; a5 will be players' attempt to open !
	move	@combo_6,a0,w
	or	a0,a5
	move	@combo_5,a0,w
	sll	4*1,a0
	or	a0,a5
	move	@combo_4,a0,w
	sll	4*2,a0
	or	a0,a5
	move	@combo_3,a0,w
	sll	4*3,a0
	or	a0,a5
	move	@combo_2,a0,w
	sll	4*4,a0
	or	a0,a5
	move	@combo_1,a0,w
	sll	4*5,a0
	or	a0,a5
*
* walk down the table of codes
*
	movi	brief_case_codes,a0 	; here is the table of codes
brief3	move	*a0+,a1,l
	jreq	briefcase_failure   	; end of table ---> exit
	cmp	a1,a5		    	; match ?
	jreq	briefcase_success   	; yes ---> do this code !!
	addi	32,a0	  	  	; no ----> next entry
	jruc	brief3

briefcase_success
	move	*a0,a0,l
	call	a0

briefcase_failure
	clr	a0
	move	a0,@combo_1,w
	move	a0,@combo_2,w
	move	a0,@combo_3,w
	move	a0,@combo_4,w
	move	a0,@combo_5,w
	move	a0,@combo_6,w
	rets


advance_curback
	move	@curback,a0,w
	cmpi	00bH,a0
	jrlo	acb3
	clr	a0
acb3	move	a0,@curback,w		; we were in mk1 ---> get out of it
	rets


barge_in_message
	movi	gs_barge,a0
	move	a0,@gstate,w		; game state = barge !

	movk	1,a0
	move	a0,@f_timeout,w		; flag: this round was timedout
	calla	murder

	jsrp	freeze_2_pages
	calla	display_on

	movi	033H,a3
	calla	send_code_a3		; Mortal Sans !!

	movi	txt_p1_entered,a14
	move	@p1_state,a0,w
	jreq	enter4
	movi	txt_p2_entered,a14
enter4	movi	pf_entered,a8
	calla	lm_setup
	move	a14,a8
	jsrp	printf

	movi	bpal_red,a0
	movi	000400122H,a3		; size
	calla	make_solid_object
	calla	set_noscroll
	movi	000360038H,a4	  	; coordinate
	calla	set_xy_coordinates
	movk	1,a0
	move	a0,*a8(ozpos),w
	calla	insobja8

	movi	bpal_yellow,a0
	movi	000440126H,a3		; size
	calla	make_solid_object
	calla	set_noscroll
	movi	000340036H,a4	  	; coordinate
	calla	set_xy_coordinates
	clr	a0
	move	a0,*a8(ozpos),w
	calla	insobja8

	movi	fl_entered,a11
	create	pid_fx,boonpal_stuff	; flash letters
	move	a0,a11
;	movi	sans_boonpal,a0
;	calla	join_in_fade1

	sleep	032H

	move	a11,a0
	calla	kill			; stop flasher shit

	sleep	040H
	calla	murder_myoinit_score
	calla	clr_scrn

;	calla	murder
;	movi	all_palettes,a0
;	calla	join_in_fade2
;	movi	01000H,a9
;	create	pid_fade,skydown
	retp


round_intro_fx

	.if ejbbug
	move	@f_fastrun,a6,w
	jrne	l_die
	.endif

	movi	013H,a0
	calla	create_fx
	jsrp	print_round_number
	movi	00bH,a0
	calla	create_fx		; big FIGHT letters

	sleep	010H
	tsound	010H			; speech: FIGHT !
	sleep	020H
l_die	die


print_round_number
	move	@round_num,a0,w
	cmpi	4,a0
	jrhi	prn3
	addi	010H,a0
	calla	triple_sound		; speech: ROUND #

prn3	movi	txt_round_num,a8
	movi	0005800c8H,a9
	jsrp	p15_centered
	sleep	030H
	movi	oid_text,a0
	calla	dallobj			; erase "round #" text
	retp


check_battle_milestone
	callr	count_active_players
	cmpi	2,a0
	jrne	mile9			; 2 player game only

	move	@battle_num,a0,w
	cmpi	100,a0			; time for that special game ?
	jrne	mile9			; sans

	move	@round_num,a0,w
	jrne	mile9			; secret only on round 1 !!!

	move	@p1_state,a0,w
	move	@p2_state,a1,w
	mmtm	a12,a0,a1
	jsrp	hidden_game		; take it away mark and kent !!
	calla	murder_myoinit_score
	mmfm	a12,a0,a1
	move	a0,@p1_state,w
	move	a1,@p2_state,w

mile9	retp

**************************************************************************
*											     *
*  weed_out_cheaters - Jump to GAME OVER if:					     *
* 											     *
*  a. Both players are at full strength						     *
*  b. 5th or later round									     *
*											     *
**************************************************************************
weed_out_cheaters
	move	@p1_bar,a0,w
	move	@p2_bar,a1,w
	add	a1,a0
	cmpi	full_strength*2,a0	; both players at full strength ??
	jreq	weed6			; yes, no cheating the game kids !
	move	@round_num,a0,w
	cmpi	5,a0
	jrhs	weed6			; no more than 2 ties allowed
	rets

weed6	pull	a0			; no return
	calla	reset_proc_stack
	jruc	game_over

**************************************************************************
*											     *
*  count_active_players - Returns a0 = # of active players		     *
*											     *
**************************************************************************
count_active_players
	clr	a0			; start with zero
	move	@p1_state,a1,w
	callr	cap5
	move	@p2_state,a1,w
cap5	cmpi	ps_active,a1		; in ?
	jrne	cap7			; no
	inc	a0			; yes, count him
cap7

;*****************
	.if fataldemo
	movk	2,a0
	.endif
;*****************

	move	a0,a0			; set or clear zero flag
	rets


loser_in_buyin
	movi	p2_state,a11
	move	@winner_status,a2,w	; winner is...
	cmpi	1,a2			; player 1 ??
	jreq	lib3			; yes, player 2 must buyin
	movi	p1_state,a11

lib3	move	*a11,a0,w
	cmpi	ps_active,a0		; loser a human ?
	jrne	lib7			; no

	movi	ps_buyin,a0
	move	a0,*a11,w		; loser = human --> he is in buyin mode

lib7	rets

**************************************************************************
*											     *
*  print_timeout_msg - When a round times out we call this to interupt   *
*                      things and print "TIMES UP" msg			     *
*											     *
**************************************************************************
print_timeout_msg
	clr	a3
	calla	send_code_a3		; stop music
	movi	021bH,a3
	calla	send_code_a3		; gong !!

	movk	1,a0
	move	a0,@f_novel,l
	move	a0,@f_timeout,w		; flag: this round was timedout
	clr	a0
	move	a0,@scrolly,l
	calla	stop_scrolling		; no scrolling !!
	calla	murder

	movi	txt_times_up,a8
	movi	0003800c8H,a9
	jsrp	p15_centered

rto6	sleep	050H
	movi	oid_fx,a0
	calla	dallobj			; erase text
	retp

**************************************************************************
*											     *
*  finish_him_sequence - Handle things for FINISH HIM			     *
*											     *
**************************************************************************
finish_him_sequence
	callr	is_finish_him_allowed
	jrnc	finish_him_exit

	movk	3,a0
	move	a0,@winner_status,w	; flag: finish him mode
	callr	finish_him_or_her

;
; fix this race condition (ejbpatch)
;
	movi	028H,a11
	jsrp	fatality_wait
	move	@f_thatsall,a0,w	; over ?
	jrne	finish_him_exit		; yes

	move	@curback,a3,w
	sll	4,a3
	addi	finish_tunes,a3
	move	*a3,a3,w
	calla	send_code_a3		; send proper "finish him" tune

	movi	080H,a11
	jsrp	fatality_wait

	move	@p1_proc,a0,l
	move	*a0(p_action),a0,w
	move	@p2_proc,a1,l
	move	*a1(p_action),a1,w

	move	a11,a11
	jreq	finish_him_exit
*
* fatality started !!!
*
	movi	040H*8,a11
fhs3	sleep	1

wait_fatality_finish
	move	@f_death,a0,w
	cmpi	-1,a0			; death blow complete ??
	jreq	finish_him_exit		; yes
	dsj	a11,fhs3		; no, keep waiting

finish_him_exit
	retp

**************************************************************************
*											     *
*  fatality_wait - wait around for the FATALITY to start			     *
* 											     *
*    Input: a11 = max time i will wait						     *
* 											     *
*  Returns: a11 = 0 ---> timed out							     *
*           a11 > 0 ---> fatality started						     *
*											     *
**************************************************************************
fatality_wait
	sleep	1

fatality_waiting
	move	@f_death,a0,w		; death blow ?
	jrne	fatal_yes
	move	@f_thatsall,a0,w
	jrne	fatal_no		; thats all !!
	dsj	a11,fatality_wait
fatal_no
	clr	a11
fatal_yes
	retp

**************************************************************************
*											     *
*  play_background_tune - look at curback and play the current backgroun *
*                         tune.								     *
*											     *
**************************************************************************
play_background_tune
	movi	round_1_tunes,a1
	move	@round_num,a0,w
	cmpi	1,a0			; round 1 ??
	jreq	pbt3
	movi	round_23_tunes,a1
pbt3	move	@curback,a11,w		; a11 = current background counter
	move	a11,a0
	sll	4,a0
	add	a1,a0
	move	*a0,a3,w
	jauc	send_code_a3		; play this background's tune

round_1_tunes
	.word	005H	; 0 -
	.word	015H	; 1 -
	.word	00dH	; 2 -
	.word	009H	; 3 -
	.word	01dH	; 4 -
	.word	019H	; 5 -
	.word	021H	; 6 -
	.word	009H	; 7
	.word	011H	; 8
	.word	02dH	; 9 -
	.word	01dH	; a -
	.word	025H	; b - hidden portal

	.word	025H	; c - hidden
	.word	025H	; d - hidden
	.word	025H	; e - hidden
	.word	025H	; f - hidden
	.word	025H	; 10 - hidden
	.word	025H	; 11 - hidden
	.word	025H	; 12 - hidden
	.word	025H	; 13 - hidden
	.word	025H	; 14 - hidden


round_23_tunes
	.word	006H	; 0 -
	.word	016H	; 1 -
	.word	00eH	; 2 -
	.word	00aH	; 3 -
	.word	01eH	; 4 -
	.word	01aH	; 5 -
	.word	022H	; 6 -
	.word	00aH	; 7 -
	.word	012H	; 8
	.word	02eH	; 9 -
	.word	01eH	; a -
	.word	025H	; b - hidden portal

	.word	025H	; c - hidden
	.word	025H	; d - hidden
	.word	025H	; e - hidden
	.word	025H	; f - hidden
	.word	025H	; 10 - hidden
	.word	025H	; 11 - hidden
	.word	025H	; 12 - hidden
	.word	025H	; 13 - hidden
	.word	025H	; 14 - hidden


finish_tunes
	.word	007H	; 0 -
	.word	017H	; 1 -
	.word	00fH	; 2 -
	.word	00bH	; 3 -
	.word	01fH	; 4 -
	.word	01bH	; 5 -
	.word	023H	; 6 -
	.word	00bH	; 7 -
	.word	013H	; 8
	.word	02fH	; 9 -
	.word	01fH	; a -
	.word	026H	; b - hidden portal

	.word	026H	; c - hidden
	.word	026H	; d - hidden
	.word	026H	; e - hidden
	.word	026H	; f - hidden
	.word	026H	; 10 - hidden
	.word	026H	; 11 - hidden
	.word	026H	; 12 - hidden
	.word	026H	; 13 - hidden
	.word	026H	; 14 - hidden


winner_tunes
	.word	008H	; 0 - traine1.vag
	.word	018H	; 1 - oldend.vag
	.word	010H	; 2 - slowend.vag
	.word	00cH	; 3 - coolend.vag
	.word	020H	; 4 - pitend.vag
	.word	01cH	; 5 - wackend.vag
	.word	024H	; 6 - tongueend.vag
	.word	00cH	; 7 - coolend.vag
	.word	014H	; 8 - chrchend.vag
	.word	030H	; 9 - gravend.vag
	.word	020H	; a - pitend.vag
	.word	027H	; b - frenzye.vag

	.word	027H	; c - hidden
	.word	027H	; d - hidden
	.word	027H	; e - hidden
	.word	027H	; f - hidden
	.word	027H	; 10 - hidden
	.word	027H	; 11 - hidden
	.word	027H	; 12 - hidden
	.word	027H	; 13 - hidden
	.word	027H	; 14 - hidden

**************************************************************************
*											     *
*  who_is_alone - answers the question with					     *
* 											     *
*  a0 = 1 ---> player 1 is the only human						     *
*       2 ---> player 2 is the only human						     *
* 											     *
**************************************************************************
who_is_alone
	move	@p1_state,a1,w
	move	@p2_state,a2,w

	cmpi	ps_active,a1
	jreq	p1_alone
	cmpi	ps_active,a2
	jreq	p2_alone

p1_alone
	cmpi	ps_active,a2		; is player 2 also in the game ?
	jreq	who_is_alone_error	; yes, something is wrong here
	movk	1,a0
	rets

p2_alone
	cmpi	ps_active,a1		; is player 1 also in the game ?
	jreq	who_is_alone_error	; yes, something is wrong here
	movk	2,a0
	rets

who_is_alone_error
	ermac	1


game_over
	movi	gs_gameover,a0
	move	a0,@gstate,w		; game state = game over

;	movi	2,a3
;	calla	send_code_a3		; start the grizzly tune

	calla	dont_show_scores
	callr	reset_map_variables
	clr	a0
	move	a0,@diff,w
	move	a0,@p1_state,w
	move	a0,@p2_state,w		; take players out of the game

	calla	immune_mpp
	calla	murder			; stop color cycler !!
	movi	020H,a10
	jsrp	fast_fadeout_jsrp
	calla	murder			; stop skyfade

;ending_gover_entry

	calla	clr_scrn
	calla	murder_myoinit_score
	calla	unimmune_mpp
	calla	murder			; kill lingering multipart procs

	movi	021H,a3
	calla	send_code_a3
	calla	clear_units
	calla	form_coin_cksum_and_store

	move	@f_smoke,a0,w
	jreq	game_over_smoke

	movk	10,a11
	calla	do_a11_background	; do the pit background !!
	movi	txt_gover,a8
	movi	0005000c8H,a9
	jsrp	p15_centered
	sleep	040H*5
	jruc	gover_exit

game_over_smoke
	jsrp	smoke_page

gover_exit
	calla	murder
	jauc	gover_amode_entry

txt_gover
	.string	"GAME OVER",0
	.even

;***************************************************************************

fl_entered
	.word	bpal_flash1,4
	.word	0ffffH
	.word	rgb_blue
	.word	end_stuff

fl_finish
	.word	bpal_flash1,4
	.word	0ffffH
	.word	rgb_red
	.word	end_stuff

**************************************************************************
*											     *
*  game_init - initializes variables for starting a game			     *
*											     *
**************************************************************************
game_init
	movk	9,a0
	calla	randu
	move	a0,@curback,w		; background 0

	clr	a0
;	move	a0,@curback,w		; background 0
	move	a0,@f_secret,w
	move	a0,@f_shadows,w
	move	a0,@f_nosound,w
	move	a0,@round_num,w		; round one !!!
	move	a0,@winner_status,w	; no winner
	move	a0,@coinflag,w		; flag: coin page not up

	move	a0,@p1_xvel,l
	move	a0,@p1_obj,l
	move	a0,@p1_proc,l
	move	a0,@p1_state,w
	move	a0,@p1_map,l
	move	a0,@p1_wiar,w
	move	a0,@p1_rwon,w

	move	a0,@p2_obj,l
     	move	a0,@p2_proc,l
	move	a0,@p2_xvel,l
	move	a0,@p2_state,w
	move	a0,@p2_wiar,w
	move	a0,@p2_rwon,w

init_player_variables
	clr	a0
	move	a0,@p1_matchw,w
	move	a0,@p2_matchw,w
	move	a0,@p1_perfect,w
	move	a0,@p2_perfect,w
	movi	bt_null,a0
	move	a0,@p1_button,l
	move	a0,@p2_button,l		; disable buttons
	rets


match_init
	clr	a0
	move	a0,@round_23_jsrp,w
	callr	clear_combo_ram
	rets

round_init
	move	@round_num,a0,w
	inc	a0
	move	a0,@round_num,w		; next round !

	move	@c_three,a0,w
	inc	a0
	cmpi	4,a0
	jrlo	rloop3
	movk	1,a0
rloop3	move	a0,@c_three,w		; keep track of 1-2-3

	callr	boss_minumum_diff	; boss = stay tough !

*
* initialize switch queue ram
*
	movi	p1_bcq,a0
	callr	init_1_q
	movi	p1_jcq,a0
	callr	init_1_q
	movi	p1_boq,a0
	callr	init_1_q
	movi	p1_joq,a0
	callr	init_1_q

	movi	p2_bcq,a0
	callr	init_1_q
	movi	p2_jcq,a0
	callr	init_1_q
	movi	p2_boq,a0
	callr	init_1_q
	movi	p2_joq,a0
	callr	init_1_q

	calla	recharge_bars

	movk	9,a0
	move	a0,@clk_ones,w
	move	a0,@clk_tens,w

	movi	round_init_words,a1
	calla	zero_table_o_words
	movi	round_init_longs,a1
	calla	zero_table_o_longs

	clr	a0
	movi	round_zero,a1
rinit5	move	a0,*a1+,w
	cmpi	round_zero_end,a1		; zero this ram every round
	jrne	rinit5

	create	pid_flasher,flash_pmsg
	rets


init_1_q
	move	a0,a1
	addi	32,a1
	move	a1,*a0+,l
	movi	sqs*2,a1
	jauc	clear_ram


round_init_words
	.long	round_1_jsrp
	.long	f_sans_throws
	.long	f_sans_block
	.long	f_shadows
	.long	f_fade
	.long	f_dark
	.long	f_norepell
	.long	tick
	.long	f_timeout
	.long	winner_status
	.long	f_start
	.long	f_novel
	.long	f_death
	.long	f_final_act
	.long	f_warnsound
	.long	f_thatsall
	.long	c_goro_dummy
	.long	c_kahn_dummy
	.long	0

round_init_longs
	.long	p1_hitq
	.long	p1_hitq+32
	.long	p1_hitq+64
	.long	p2_hitq
	.long	p2_hitq+32
	.long	p2_hitq+64
	.long	p1_xvel
	.long	p2_xvel
	.long	p1_hitq
	.long	p1_hitq+32
	.long	p2_hitq
	.long	p2_hitq+32

	.long	l_hp
	.long	l_lp
	.long	l_block
	.long	l_hk
	.long	l_lk
	.long	0

**************************************************************************
*											     *
*  flash_pmsg - process to flash the player messages				     *
*											     *
**************************************************************************
flash_pmsg
	movi	entry_6,a8
	movi	entry_5,a9

fpmsg2	move	*a8(32*3),a0,l
	move	*a9(32*3),a1,l
	add	a1,a0
	jrne	flash_pmsg2
	sleep	3	       		; wait for legitimate messages
	jruc	fpmsg2

flash_pmsg2
	movi	entry_6,a8
	movi	entry_5,a9

pmsg_blink_loop
	move	*a8(32*3),a10,l		; a10 = player 1 size
	move	*a9(32*3),a11,l		; a11 = player 2 size
	clr	a5

	move	@p1_state,a0,w
	cmpi	ps_active,a0
	jreq	fpmsg5
	move	a5,*a8(32*3),l
fpmsg5	move	@p2_state,a0,w
	cmpi	ps_active,a0
	jreq	fpmsg6
	move	a5,*a9(32*3),l		; zero size = display off
fpmsg6	sleep	10

fpmsg7	move	*a8(32*3),a0,l		; player 1 still zero ?
	jrne	fpmsg8	      		; no
	move	a10,*a8(32*3),l		; yes, restore to normal size
fpmsg8	move	*a9(32*3),a0,l		; player 2 still zero ?
	jrne	fpmsg9	      		; no

	move	a11,*a9(32*3),l		; yes, restore to normal size

fpmsg9	sleep	10
	jruc	pmsg_blink_loop

**************************************************************************
*											     *
*  add_to_diff - add a value to the variable @diff				     *
* 											     *
*  input: a1 = amount to add								     *
*											     *
**************************************************************************
add_to_diff
	move	@diff,a0,w
	add	a1,a0		; adjust
	jrnn	adiff2
	clr	a0		; minimum = zero
adiff2	cmpi	9,a0
	jrls	adiff3
	movk	9,a0
adiff3	move	a0,@diff,w
	rets

**************************************************************************


*
* Input: a0 = table of 5 words
*
get_adj_diff_word
	push	a0
	callr	get_adj_diff	; a0 = adjustment difficulty
	move	a0,a1
	sll	4,a1
	pull	a0
	add	a0,a1
	move	*a1,a0,w
	rets

get_adj_diff
	movi	adj_ddiff,a0
	calla	get_adj
	cmpi	5,a0
	jrls	gin7
	movk	3,a0
gin7	dec	a0		; return in (0-4) offset form
    	rets

**************************************************************************
*											     *
*  end_of_match_chores - do this when a match is over (2 out of 3)	     *
*											     *
**************************************************************************
end_of_match_chores
	move	@curback,a0,w
	inc	a0
	cmpi	00bH,a0
	jrlo	mio2
    	clr	a0
mio2	move	a0,@curback,w		; match is over ---> next background

	move	@battle_num,a2,w
	inc	a2
	move	a2,@battle_num,w	; next battle please !!

	clr	a0
	move	a0,@round_num,w
	move	a0,@c_three,w
	move	a0,@f_mercy,w

	movi	oid_text,a0
	calla	dallobj			; erase msg

	clr	a0
	move	a0,@p1_matchw,w
	move	a0,@p2_matchw,w		; reset match wins for both dudes
	move	a0,@p1_perfect,w
	move	a0,@p2_perfect,w

	callr	adv_winner_map		; winner: move on !!
	callr	diff_adjust		; end of round difficulty adjust
*
* check "winning streak" reset counter
*
	movi	adj_hsreset,a0
	calla	get_adj			; a0 = setting
	dec	a0
	sll	4,a0
	addi	reset_boundaries,a0
	move	*a0,a3,w		; a3 = count to reset at

	movi	aud_ws_reset,a0
	calla	aud1			; count another game
	movi	aud_ws_reset,a0
	calla	get_aud			; a1 = current count
	cmp	a1,a3			; time to reset ?
	jrhi	eomca			; no

	calla	fs_inits
	movi	aud_ws_reset,a0
	calla	clr_aud			; yes, reset audit counter

eomca	rets

reset_boundaries
	.word	5000
	.word	10000
	.word	15000
	.word	30000
	.word	50000


inc_winners_wiar
	movi	p1_wiar,a0
	movi	p1_state,a1
	move	@winner_status,a2,w
	dec	a2
	jreq	iww3

	movi	p2_wiar,a0   	; player 2 wins in a row
	movi	p2_state,a1

iww3	move	*a1,a1,w
	cmpi	ps_active,a1	; winner active (ie...human) ???
	jrne	iww9		; nope....
	jruc	local_inc_a0_word

iww9	clr	a1
	move	a1,*a0,w	; winner = drone = zero wins in a row !!
	rets

**************************************************************************
*											     *
*  diff_adjust - end of round adjustment of the variable 'diff'    		*
*											     *
**************************************************************************
diff_adjust
	movi	p1_state,a0
	move	@winner_status,a5,w
	cmpi	1,a5
	jreq	eord4
	movi	p2_state,a0
eord4	move	*a0,a0,w
	cmpi	ps_active,a0		; is winner a human player ?
	jrne	winner_is_drone		; no
*
* winner is a human ---> get harder
*
	calla	count_active_players
	cmpi	2,a0
	jreq	dadj9	  		; no ---> don't adjust for 2 player

	move	@perform,a0,w
	inc	a0
	move	a0,@perform,w  		; performance = better

	move	@diff,a0,w
	inc	a0
	cmpi	9,a0
	jrlo	dadj5
	movk	9,a0			; max = 9

dadj5	push	a0
	callr	get_adj_diff
	sll	5,a0
	addi	game_adjustment_minimums,a0
	move	*a0,a0,l
	move	a0,a2			; a0 = mhe table
	pull	a0

	callr	ladder_order_a1		; a1 = ladder order....
	sll	4,a1
	add	a2,a1
	move	*a1,a1,w   		; a1 = minimum !!
	cmp	a1,a0
	jrhs	dadj7
	move	a1,a0			; no lower than this !
dadj7	callr	stuff_a0_diff
dadj9	rets


winner_is_drone
	move	@diff,a0,w
	jreq	wid3			; rev2.1 change
	dec	a0
	jrne	wid3
	clr	a0
wid3	jruc	dadj5

;***********************************************

game_adjustment_minimums
	.long	mhe_minimums_1
	.long	mhe_minimums_2
	.long	mhe_minimums_3
	.long	mhe_minimums_4
	.long	mhe_minimums_5

mhe_minimums_1
 	.word	0	; medium tower
	.word	1	; hard
	.word	0	; easy

mhe_minimums_2
	.word	1
	.word	2
	.word	0

mhe_minimums_3
	.word	1
	.word	3
	.word	0

mhe_minimums_4
	.word	3
	.word	4
	.word	2

mhe_minimums_5
	.word	4
	.word	5
	.word	3



ladder_order_a1
	move	@ladder_order,a1,w
	cmpi	3,a1
	jrlo	ladd1
	movk	1,a1
ladd1	rets



stuff_a0_diff
	cmpi	9,a0
	jrls	sdiff4
	movk	5,a0			; too big = just use 5
sdiff4	move	a0,@diff,w
	rets

**************************************************************************
*											     *
*  adv_winner_map - advance winners map pointer to next position	     *
*											     *
**************************************************************************
adv_winner_map
	calla	count_active_players
	cmpi	2,a0
	jreq	adv9				; both players human ---> skip

	movk	1,a1				; assume player 1 alone
	move	@p1_state,a3,w
	cmpi	ps_active,a3
	jreq	adv2
	movk	2,a1				; player 2 alone
adv2	move	@winner_status,a0,w
	cmp	a1,a0				; winner = human ?
	jrne	adv7				; sans

	move	@map_position,a0,w
	inc	a0

;**************
;	move	a0,a1
;	sll	4,a1
;	move	@map_start,a3,l
;	add	a3,a1
;	move	*a1,a1,w
;	cmpi	ft_smoke,a1			; secret spot ?
;	jrne	adv3				; no, we cool
;	inc	a0				; yes, skip over it
;adv3
;**************

	move	a0,@map_position,w		; next offset

adv9	rets


adv7	move	@c_1p_tries,a0,w
	inc	a0
	move	a0,@c_1p_tries,w		; count # of 1p tries !!
	jruc	adv9


reset_map_variables
	clr	a0
	move	a0,@map_position,w
	move	a0,@map_start,l
	move	a0,@perform,w		; zero performance
	rets

**************************************************************************
*											     *
*  set_drone_ochar - determine who is the next drone opponent based		*
*                      on the player up's map position 				*
* 											     *
*  returns: carry set ---> end of game was reached				     *
*           carry clr ---> end of game sans reached				     *
*											     *
**************************************************************************
set_drone_ochar
	callr	drone_char_point_a6	; a6 ----> p?char
	callr	current_drone_a0
	cmpi	sp_end,a0
	jreq	ndo9			; ff = end of the line
	move	a0,*a6,w		; define drone's "ochar"
	clrc				; carry clear = game not over
	rets
ndo9	setc
	rets


drone_char_point_a6
	push	a0
	callr	who_is_alone	; a0 = player who is alone
	movi	p2_char,a6
	cmpi	1,a0
	jreq	ndo8	 	; player 1 alone
	movi	p1_char,a6
ndo8	pull	a0
	rets


current_drone_a0
	move	@map_start,a0,l
	jreq	cda0			; no map ---> just return zero
	move	@map_position,a1,w
	sll	4,a1
	add	a1,a0
	move	*a0,a0,w	; a0 = next "enemy offset" to battle with
cda0	rets

**************************************************************************
*											     *
*  amode_demo_game - attract mode demo game process				     *
*											     *
**************************************************************************
amode_demo_game
	move	@f_nosound,a1,w
	push	a1
	callr	game_init		; yes ---> reset everything
	pull	a1
	move	a1,@f_nosound,w		; dont mess with this variable in amode

	calla	oinit
	calla	clear_sound_ram
	calla	setup_score_ram
	movi	SCORE_P,a0
	calla	getfpal 		; palette #2 = vogel's score palette

	movk	11,a0
	calla	randu
	dec	a0
	move	a0,@curback,w		; random background !!

	movk	5,a0
	move	a0,@diff,w
	jsrp	play_1_round
	jauc	wait_forever

**************************************************************************
*											     *
*                  MASTER CONTROL PROCESS SUBROUTINES			     *
*                  MASTER CONTROL PROCESS SUBROUTINES			     *
*                  MASTER CONTROL PROCESS SUBROUTINES			     *
*                  MASTER CONTROL PROCESS SUBROUTINES			     *
*											     *
**************************************************************************

boss_minumum_diff
	move	@p1_char,a0,w
	move	@p2_char,a1,w
	rets


finish_him_or_her
	movk	012H,a0			; finish her !!
	move	@p1_char,a3,w
	move	@p1_bar,a4,w
	jreq	hoh2
	move	@p2_char,a3,w
hoh2	cmpi	ft_sonya,a3
	jreq	hoh5
	cmpi	ft_lia,a3
	jreq	hoh5			; female = finish her !!
	cmpi	ft_sg,a3
	jreq	hoh5			; female = finish her !!
	movk	011H,a0			; finish him !!!
hoh5	jauc	create_fx


local_inc_a0_word
	jauc	inc_a0_word

clear_combo_ram
	clr	a0
	move	a0,@combo_1,w
	move	a0,@combo_2,w
	move	a0,@combo_3,w
	move	a0,@combo_4,w
	move	a0,@combo_5,w
	move	a0,@combo_6,w		; clear all combination lock ram
	move	a0,@round_1_jsrp,w
	move	a0,@round_23_jsrp,w
	rets

;**********************************************************************

txt_times_up
	.string	"TIME IS UP",0
	.even

txt_round_num
	.string	"ROUND %d",0
	.long	round_num
	.even

;**********************************************************************

; kodes
brief_case_codes
	.long	0100100H
	.long	bc_throwing_disabled	; 0 - EASY
	.long	0020020H
	.long	bc_blocking_disabled	; 1 - EASY
	.long	0033000H
	.long	bc_p1_handicap	    	; 2 - EASY
	.long	0000033H
	.long	bc_p2_handicap	    	; 3 - EASY
	.long	0688422H
	.long	bc_dark_fighting    	; 4 - LINK CODE #4 - MK3 3RD CONSUMER ADD
	.long	0460460H
	.long	bc_switcheroo		; 5 - LINK KODE #9 - josh
	.long	0987666H
	.long	bc_jackbot	    	; 6 - LINK CODE #? - JACKBOT MESSAGE CODE
	.long	0707000H
	.long	bc_p1_supercap	    	; 7 - PLAYER 1 1/4 POWER
	.long	0000707H
	.long	bc_p2_supercap	    	; 8 - PLAYER 2 1/4 POWER
	.long	0642468H
	.long	bc_space_game	    	; 9 - PENACHO GAME
	.long	0969141H
	.long	bc_wf_motaro		;10 - LINK KODE #6 -
	.long	0033564H
	.long	bc_wf_sk		;11 - LINK KODE #3 - USED IN 2ND TRADE ADD
	.long	0769342H
	.long	bc_wf_noob		;12 - LINK KODE #8 -
	.long	0282282H
	.long	bc_nofear_clue	    	;13 - LINK KODE #  - NO FEAR MESSAGE CODE
	.long	0987123H
	.long	bc_no_powerbars	    	;14 - LINK KODE #2 - 15 SEC. NIGHTMARE
	.long	0688422H			; josh #2
	.long	bc_uppercut_recovery	;15 - LINK KODE  (no   fear #2)
	.long	0466466H
	.long	bc_unlim_run 		;16 - LINK KODE #5 -
	.long	0985125H
	.long	bc_psycho_kombat2	;17 - LINK KODE #10 -
	.long	0123926H
	.long	bc_intro_message	;18 - LINK KODE #1 - 30 SEC. NIGHTMARE
	.long	0205205H
	.long	bc_wf_smoke		;19 - LINK KODE #7 -
	.long	0

bc_wf_smoke
	movk	20,a0
	jruc	stuff_round_123

bc_intro_message
	movk	19,a0
	jruc	stuff_round_123

bc_psycho_kombat2
	movk	18,a0
	jruc	stuff_round_123

bc_unlim_run
	movk	17,a0
	jruc	stuff_round_123

bc_uppercut_recovery
	movk	16,a0
	jruc	stuff_round_123

bc_no_powerbars
	movk	15,a0
	jruc	stuff_round_123

bc_nofear_clue
	movk	14,a0
	jruc	stuff_round_123

bc_wf_noob
	movk	13,a0
	jruc	stuff_round_123

bc_wf_sk
	movk	12,a0
	jruc	stuff_round_123

bc_wf_motaro
	movk	11,a0
	jruc	stuff_round_123

bc_space_game
	movk	10,a0
	jruc	stuff_round_123

bc_p2_supercap
	movk	9,a0
	jruc	stuff_round_123

bc_p1_supercap
	movk	8,a0
	jruc	stuff_round_123

bc_jackbot
	movk	7,a0
	jruc	stuff_round_123

bc_switcheroo
	movk	6,a0
	jruc	stuff_round_123

bc_dark_fighting
	movk	5,a0
	jruc	stuff_round_123

bc_p1_handicap
	movk	3,a0
	jruc	stuff_round_123

bc_p2_handicap
	movk	4,a0
	jruc	stuff_round_123

bc_throwing_disabled
	movk	1,a0
	move	a0,@round_1_jsrp,w
	move	a0,@round_23_jsrp,w
	rets

bc_blocking_disabled
	movk	2,a0

stuff_round_123
	move	a0,@round_1_jsrp,w
	move	a0,@round_23_jsrp,w
	rets

;******************************

	.end


