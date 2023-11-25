**************************************************************************
*											     *
*  video game project:	mk3									*
* 											     *
*  game software:    	ed boon								     *
* 											     *
*  module: canned animations									*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	'mkcanned.asm'
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

**************************************************************************
*											     *
*  winner status = 3									     *
*											     *
**************************************************************************
finish_him
	move	*a13(p_flags),a4,w
	btst	pb_finish,a4			; am i finishing him ?
	jreq	fhim3				; no
	rets


fhim3	pull	a1				; no retreat / no return
	move	@p1_matchw,a0,w
	move	@p2_matchw,a1,w
	move	*a13(procid),a2,w
	cmpi	pid_p1,a2			; am i player 1 ??
	jreq	fhim4				; yes
	swap	a0,a1				; no ---> swap
fhim4	cmp	a1,a0				; more wins for me ?
	jrlo	dizzy_dude			; no ---> dizzy

	move	*a13(p_flags),a4,w
	ori	pm_finish,a4
	move	a4,*a13(p_flags),w		; flag: i am finishing him

fhim5	calla	am_i_joy
	jrnc	d_finish_him			; drone ---> finish
	jauc	joy_entry			; joy ---> let him handle it

d_finish_him
	clr	a0
	jauc	drone_long_jump

**************************************************************************

new_endurance_guy
	calla	set_nocol

	calla	match_me_with_him
	calla	ground_ochar

	movi	97,a7
	calla	get_my_dfe
	cmp	a5,a6
	jrhi	neg4			; he is closer to the left
	neg	a7
neg4	move	*a8(oxpos),a0,w
	add	a7,a0
	move	a0,*a8(oxpos),w		; position myself here !!

;*********************
	movi	center_around_me,a0
	calla	calla_for_him
;	calla	center_around_me
;*********************

	calla	refresh_score

	sleep	>20

	move	*a8(ochar),a0,w
	addi	>28,a0
	calla	triple_sound
	calla	face_opponent
	jauc	back_to_the_fight

**************************************************************************
*											     *
*  dizzy_dude - guy who's got his shit kicked					     *
*											     *
**************************************************************************
dizzy_dude
	calla	disable_all_buttons
	calla	face_opponent
	calla	zero_my_p_hit

	move	@winner_status,a0,w
	cmpi	3,a0
	jrne	dd4

	move	*a8(oflags2),a4,w
	andni	m_noflip,a4
	move	a4,*a8(oflags2),w	; I can be flipped

	move	*a13(p_flags),a4,w
	ori	pm_sitduck,a4
	move	a4,*a13(p_flags),w 	; match over ---> i'm a sitting duk
	calla	set_no_block	    	; i can't block !!

dd4	calla	am_i_short    		; am i short ?
	jrnc	dd5			; no, skip

	movi	>00040021,a9
	jsrp	animate_a9		; yes, getup 1st

dd5	movi	act_stunned,a1
	move	a1,*a13(p_action),w	; define me action

	movk	6,a0
	calla	init_anirate
	movi	>25,a9
	calla	get_char_ani

	movi	dizzy_calls,a0
	calla	ochar_call


dd7	sleep	1

dizzy_wake
	calla	next_anirate
	move	@winner_status,a0,w
	cmpi	3,a0			; stay dizzy only during "finish him"
	jreq	dd7

	move	@f_death,a0,w		; death blow started ?
	jrne	dd7			; yes, dont fall over
	jruc	collapse_on_ground


dizzy_calls
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	robo_dizzy_call
	.long	robo_dizzy_call
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

robo_dizzy_call
	movk	7,a0
	calla	create_fx
	move	a13,*a0(p_store1),l		; pass my proc
	rets

**************************************************************************
*											     *
*  winner status = 4									     *
*											     *
**************************************************************************
endurance_trans
	pull	a0
	move	@p1_bar,a0,w
	move	@p1_obj,a4,l
	cmp	a4,a8
	jreq	entr3
	move	@p2_bar,a0,w		; a0 = power
entr3	move	a0,a0
	jreq	endurance_loser		; zero power = I am a loser !!
	jauc	endurance_wake		; power = wait for more battle !!

endurance_loser
	jruc	collapse_on_ground

**************************************************************************
*											     *
*  winner status = 1									     *
*											     *
**************************************************************************
player_1_wins
	movk	pid_p1,a2
	jruc	plwins

**************************************************************************
*											     *
*  winner status = 2									     *
*											     *
**************************************************************************
player_2_wins
	movk	pid_p2,a2
plwins  	pull	a3
	move	*a13(procid),a0,w		; a0 = my id
	cmp	a0,a2				; am i the winner
	jreq	victory_animation		; yes ---> celebrate
*
* I lost
*
	calla	disable_all_buttons
	jruc	collapse_on_ground


psel_victory_animation
	move	*a13(p_flags),a0,w
	andni	pm_alt_pal,a0	  
	move	a0,*a13(p_flags),w	; trickery !!

	move	*a8(ochar),a0,w
	cmpi	ft_lia,a0
	jreq	lia_psel_victory

victory_animation
	calla	clear_inviso
	calla	set_shadow_bit		; for smokes sake !!

	calla	init_special
	movi	victory_jumps,a0
	jauc	ochar_jump


ending_victory_animation
	calla	stop_a8
	calla	ground_player

;	calla	face_opponent

	move	*a13(p_flags),a4,w
	ori	pm_special,a4
	move	a4,*a13(p_flags),w	; flag: i am doing a special move

	movi	victory_jumps,a0
	jauc	ochar_jump


victory_jumps
	.long	kano_victory	; 0
	.long	sonya_victory	; 1
	.long	jax_victory	; 2
	.long	indian_victory	; 3
	.long	generic_victory	; 4
	.long	swat_victory	; 5
	.long	lia_victory	; 6
	.long	generic_victory	; 7
	.long	generic_victory	; 8
	.long	generic_victory	; 9
	.long	generic_victory	;
	.long	generic_victory	;
	.long	generic_victory	;
	.long	generic_victory	;
	.long	generic_victory	;
	.long	motaro_victory	;
	.long	sk_victory	;
	.long	generic_victory	;

indian_victory
	movi	>0005000d,a9
	jsrp	animate_a9
	sleep	8

	movk	2,a0
	calla	ochar_sound

	calla	do_next_a9_frame
	sleep	9

	movk	6,a0
	jsrp	mframew
	jruc	local_wait_forever


jax_victory
	movi	>0d,a9
	calla	get_char_ani
	movk	6,a0			; animation speed
	movk	12,a1			; pause between ani1 and ani2 
	jsrp	mframew_2x
	jruc	local_wait_forever

sonya_victory
	movi	>0d,a9
	calla	get_char_ani
	movk	5,a0
	jsrp	mframew				; animate !!
	sleep	12
	movk	4,a0
	jsrp	mframew				; animate !!
	jruc	local_wait_forever


lia_psel_victory
	movi	>0d,a9
	calla	find_ani_part2
	jruc	liav4

lia_victory
	calla	set_ignore_y

	movi	>0d,a9
	calla	get_char_ani

liav4	movk	4,a0
	jsrp	mframew				; animate !!

	movi	->4000,a0
	move	a0,*a8(ograv),l			; accelerate upwards
	sleep	>0c
*
* power down
*
liav6	movi	>2000,a10
	move	a10,*a8(ograv),l		; head down
liav3	sleep	1
	move	*a8(oyvel),a0,l
	jrn	liav3				; neg = loop
	sleep	>0d
*
* power up
*
	neg	a10
	move	a10,*a8(ograv),l		; head down
liav7	sleep	1
	move	*a8(oyvel),a0,l
	jrnn	liav7				; neg = loop
	sleep	>0d
	jruc	liav6


swat_victory
	movi	>0d,a9
	calla	get_char_ani
	movk	6,a0
	jsrp	mframew				; animate !!

	movk	3,a11
swatv3	sleep	6
	movi	>0d,a9
	calla	find_ani_part2
	movk	2,a0
	jsrp	mframew				; BANG !!
	dsj	a11,swatv3

	calla	delete_slave
	movk	6,a0
	jsrp	mframew				; animate !!
	jruc	local_wait_forever


kano_victory
	movk	4,a10
	jruc	vic7

sk_victory
	movk	7,a10
	jruc	vic7

motaro_victory
	movk	1,a0
	calla	ochar_sound
	calla	center_around_me

generic_victory
	movk	5,a10
vic7	movi	>0d,a9
	calla	get_char_ani
	move	a10,a0
	jsrp	mframew				; animate !!
	jruc	local_wait_forever

**************************************************************************
*											     *
*  a0 = animation speed									     *
*  a1 = pause between animations								     *
*											     *
**************************************************************************
mframew_2x
	mmtm	a12,a0,a1
	jsrp	mframew				; part 1
	mmfm	a12,a0,a1
	move	a0,a10
	move	a1,a0
	calla	prcslp
	move	a10,a0
	jauc	mframew				; part 1

;************************************************************************

collapse_on_ground
	calla	player_normpal
	calla	set_noedge
	calla	stop_me

	calla	boss_branch
	.word	>12			; 12 = collapse dead

	movi	>0004003f,a9
	jsrp	animate_a9		; fall to ground

	movi	>1e,a9
	calla	find_ani_part2
	calla	find_last_frame		; dead frame
	calla	do_next_a9_frame

;	movi	>500,a0
;	move	a0,@right_edge,w
;	neg	a0
;	move	a0,@left_edge,w		; no more edge restrictions

	movi	ochar_dead_adjusts,a0
	calla	get_char_word
	clr	a1
	calla	multi_adjust_xy

	calla	shake_n_sound
	calla	clear_shadow_bit
	jruc	local_wait_forever


local_wait_forever
	jauc	wait_forever

ochar_dead_adjusts
	.word	->48 ; 0
	.word	->30 ; 1
	.word	->40 ; 2
	.word	->48 ; 3
	.word	->4c ; 4

	.word	->50 ; 5
	.word	->38 ; 6
	.word	->38 ; 7
	.word	->45 ; 8
	.word	->50 ; 9

	.word	->40 ; a
	.word	->40 ; b
	.word	->30 ; c
	.word	->48 ; d
	.word	->38 ; e

	.word	->38 ; 15
	.word	->38 ; 16
	.word	->38 ; 17
	.word	->38 ; 18
	.word	->38 ; 0

*******************************************************************

	.end

