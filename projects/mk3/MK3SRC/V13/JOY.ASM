**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: animation tables / routines							*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	'joy.asm'
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

turbo_raise_delay	.set	40

;*****************************************************

joy_begin
	callr	ochar_begin_calls
	jruc	joy_proc


endurance_wake
	calla	back_to_normal
	calla	disable_all_buttons
endw0	calla	stance_setup		; get stance ani / ani speed
endw	sleep	1
	calla	am_i_facing_him
	jrc	endx
	jsrp	turn_around 		; face the chump
	jruc	endw0
endx	calla	next_anirate
	move	@f_start,a0,w 		; start fighting ??
	jreq	endw	      		; no ---> loop
	jruc	joy_proc


switcheroo_wake
	movi	p1_char,a5
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	swoo3
	movi	p2_char,a5
swoo3	movk	14,a0			; dont 4-get smoke (ejbpatch)
	calla	randu
	dec	a0
	move	*a8(ochar),a1,w
	cmp	a0,a1
	jreq	swoo3			; dont turn into same guy 
	move	a0,*a8(ochar),w		; set my ochar
	move	a0,*a5,w		; set the other ochar as well

	calla	refresh_score
	move	*a8(ochar),a0,w
	addi	>28,a0
	calla	triple_sound
	calla	clear_inviso

	move	*a13(p_flags),a0,w
	ori	pm_alt_pal,a0		; flag: I am using alternate pal
	move	a0,*a13(p_flags),w
	calla	player_normpal
	clr	a9
	calla	pose_a9	
	calla	ground_ochar
	move	*a8(oypos),*a13(p_ganiy),w	; set the grounded y pos

joy_proc
	movi	bt_stance,b0
	callr	stuff_buttons
	move	*a13(p_flags),a4,w
	ori	pm_joy,a4
	move	a4,*a13(p_flags),w		; flag: i am a joystick dude
	sleep	1

joyb4	jsrp	wait_for_start			; stance till fight begins

joy_entry
	callr	enable_all_buttons
;	calla	back_to_normal
	calla	reset_proc_stack		; make things kosher

	callr	joystick_in_a0
	btst	bit_jdown,a0			; stick down ?
	jreq	joye4				; no.

	calla	get_my_height
	cmpi	>60,a1
	jrhi	joy_down     			; I am standing ---> do duck ani
	jruc	joy_duck_entry			; I am low ---> last duck frame

joye4	clr	a0
	move	a0,*a13(p_downcount),w	; not down anymore
	calla	stance_setup

joy_stance_loop
	calla	am_i_facing_him
	jrc	joye5
	jsrp	turn_around 		; face the chump
	jruc	local_reaction_exit

joye5	callr	check_winner_status
	move	@f_start,a0,w		; still fighting ?
	jreq	joyb4		   	; no --> stance animation
	sleep	1

	callr	check_block_bit
	jrc	joy_block
	callr	joystick_in_a0
	btst	bit_jright,a0		; right ?
	jrne	joy_right
	btst	bit_jleft,a0 		; left ?
	jrne	joy_left

	btst	bit_jup,a0		; up ?
	jrne	joy_up
	btst	bit_jdown,a0 		; down ?
	jrne	joy_down

	calla	back_to_shang_check

	calla	next_anirate
	jruc	joy_stance_loop

**************************************************************************
*											     *
*  joy = up										     *
*											     *
**************************************************************************
joy_up
	calla	face_opponent
	callr	disable_all_buttons
	jsrp	look_for_angle
	movi	bt_jump,b0
	callr	stuff_buttons

	calla	distance_from_ground
	move	a0,a10	   		; a10 = animation point ground dist
	clr	a11
	jsrp	do_jump_up
	jruc	local_reaction_exit


joy_duck_entry
	movk	4,a9
	calla	get_char_ani
	addi	32*2,a9			; a9 = my duck frame
	calla	do_next_a9_frame
	jruc	joyd3


joy_down
	callr	disable_all_buttons
	jsrp	do_duck

joy_getup_entry
joyd3	movi	bt_duck,b0
	callr	stuff_buttons

joyd4	movi	act_duck,a0
	move	a0,*a13(p_action),w		; reset action !!

	sleep	1

	calla	am_i_facing_him			; facing him ?
	jrc    	joyd5				; yes
	jsrp	duck_turnaround			; no, turnaround
	jruc	joyd3

joyd5	callr	inc_downcount			; count duck time !
	callr	check_block_bit
	jrc	joy_duck_block
	callr	check_winner_status		; scan for "end of round" while ducking


	callr	joystick_in_a0
	btst	bit_jdown,a0
	jrne	joyd4	    			; stay down while stick = down

joy_back_up
	callr	disable_all_buttons
	calla	face_opponent
	jsrp	do_backup
	jruc	local_reaction_exit	; return to normal

inc_downcount
	move	*a13(p_downcount),a0,w
	inc	a0
	move	a0,*a13(p_downcount),w
	rets

do_backup
	movi	act_backup,a1
	move	a1,*a13(p_action),w	; define my action
	movk	4,a9			; ani = duck
	movk	2,a0			; a0 = sleep time
	jauc	backwards_ani


do_duck
	callr	stop_me
	calla	face_opponent
	movk	4,a9
	calla	get_char_ani
	movk	2,a0
	movi	act_duck,a1
	jauc	act_mframew


do_duck_block
	callr	stop_me
	calla	face_opponent
	movk	6,a9
	calla	get_char_ani
	movk	3,a0
	movi	act_blocklo,a1
	jauc	act_mframew   		; get into "duck block" pose



joy_duck_punch
	callr	disable_all_buttons
	jsrp	do_duck_punch

	callr	joystick_in_a0
	btst	bit_jdown,a0
	jrne	joyd3	    		; stay down while stick = down
	jruc	joy_back_up

**************************************************************************
*											     *
*  joy = uppercut									     *
*											     *
**************************************************************************
joy_uppercut
	callr	disable_all_buttons
	jsrp	do_uppercut

	jruc	local_reaction_exit	; return to normal


joy_duck_block
	callr	disable_all_buttons
jdblk2	jsrp	do_duck_block


joy_duck_block_loop
	sleep	1

	calla	am_i_facing_him			; facing him ?
	jrc    	jdblk5				; yes
	jsrp	duck_turnaround			; no, turnaround
	jruc	jdblk2

jdblk5	callr	joystick_in_a0
	btst	bit_jdown,a0		; still holding down joystick ?
	jreq	joy_back_up		; no ---> back up

	callr	inc_downcount
	callr	check_winner_status	; scan for "end of round" while ducking

	movi	act_blocklo,a0
	move	a0,*a13(p_action),w	; reset action !!
	callr	check_block_bit		; still holding block ?
	jrc	joy_duck_block_loop	; yes, loop
*
* joy un - duck block
*
	movi	act_duck,a1
	move	a1,*a13(p_action),w

	movk	6,a9
	movk	3,a0			; a0 = sleep time
	jsrp	backwards_ani

	movk	4,a9
	calla	find_ani_last_frame
	calla	do_next_a9_frame	; last frame = duck3

;	calla	find_ani_last_frame
;	movi	act_duck,a1
;	movk	3,a0
;	jsrp	act_mframew		; "duck un-block"

	jruc	joyd3


joy_duck_kickh
	jsrp	do_duck_kickh
	movi	act_ret_kick,a0
	move	a0,*a13(p_action),w

	movk	8,a0			; no connect sleep
	jrnc	dkick5
	movk	16,a0			; connect sleep
dkick5	calla	prcslp
	movk	4,a0
	jsrp	retract_strike

	move	*a13(p_downcount),a0,w
	addi	>26,a0
	move	a0,*a13(p_downcount),w	; count kick time as "down time"
	jruc	post_joy_duck_kick


joy_duck_kickl
	jsrp	do_duck_kickl
	movi	act_ret_kick,a0
	move	a0,*a13(p_action),w

	movk	6,a14
	calla	is_he_joy
	jrc	dkick2
	movk	10,a14			; pause against drone
dkick2	move	a14,a0
	calla	prcslp

	movk	2,a0
	jsrp	retract_strike

	move	*a13(p_downcount),a0,w
	addi	8,a0
	move	a0,*a13(p_downcount),w	; count kick time as "down time"

post_joy_duck_kick
	callr	joystick_in_a0
	btst	bit_jdown,a0
	jrne	joyd3	    		; stay down while stick = down
	jruc	joy_back_up

**************************************************************************
*											     *
*  joy = left										     *
*											     *
**************************************************************************
joy_left
	move	*a8(oflags),a4,w
	andi	m_fliph,a4
	xori	m_fliph,a4		; flipped
	movi	m_jleft,a0
	jruc	joyr2

**************************************************************************
*											     *
*  joy = right										     *
*											     *
**************************************************************************
joy_right
	move	*a8(oflags),a4,w
	andi	m_fliph,a4
	movi	m_jright,a0

joyr2	move	a0,*a13(p_store4),w	; store joystick mask here
	clr	a2
	move	a2,*a13(p_action),w	; no more stance

	movi	get_walk_info_f,a5
	movk	1,a9			; forward walk
	move	a4,a4
	jreq	joyr3
	movi	get_walk_info_b,a5

joyr3	cmpi	get_walk_info_f,a5	; forward ??
	jrne	joyr4			; sans

	callr	is_run_pressed
	jrc	joy_run

joyr4	call	a5			; get walk info
	move	a2,a9
	calla	init_anirate
	move	a1,a0
	calla	set_x_vel
	move	a9,*a13(p_store1),w	; store walk ani offset here
	calla	get_char_ani
	move	a9,*a13(p_anitab),l	; store walk animation
*
* walk loop
*
joyr6	sleep	1
walkwake	callr	check_winner_status

	move	*a13(p_store1),a0,w
	cmpi	1,a0			; walk forward animation ?
	jrne	joyr8			; no ---> dont check for a run
	callr	is_run_pressed
	jrc	joy_run

joyr8   	callr	angle_scan		; look for joystick angle combos
	callr	walk_flip_check
	calla	next_anirate
	callr	mask_joystick
	jrne	joyr6			; still pressed ---> walk again
*
* joystick was released
*
	move	*a13(p_anitab),a0,l
	sub	a9,a0
	abs	a0
	srl	5,a0			; a0 = walk frame # i am on !
	cmpi	3,a0			; skip ?
	jrhs	joyr7			; no, stop abruptly

*
* skip animation
*
;	move	a0,a1
;	sll	5,a1			; 32 bits
;	move	*a13(p_store1),a9,w
;	inc	a9			; a9 = skip animation offset
;	calla	get_char_ani
;	add	a1,a9			; a9 = spot to finish off skip ani
;	movi	>00060002,a0		; slower skip now !!
;	jsrp	animate_a0_frames	; finish skip ani


joyr7	callr	stop_me
	jruc	local_reaction_exit	; return to normal

*
* joystick ---> check if i should turn around while i am walking
*
walk_flip_check
	calla	am_i_facing_him
	jrc	wfc5
	pull	a0
	jsrp	turn_around
	jruc	local_reaction_exit	; return to normal

wfc5	rets


joy_run
	calla	run_setup

jrun3	sleep	1
   	callr	angle_scan		; look for joystick angle combos
	calla	next_anirate
	callr	check_winner_status
	calla	reduce_turbo_bar
	jreq	joyr7			; out of turbo ----> stop running

;***************
	movi	->80000,a5
	callr	joystick_in_a0
	btst	bit_jright,a0		; right ??
	jrne	jrun5
	btst	bit_jleft,a0		; left ??
	jreq	joyr7			; neither = abort
	neg	a5			; yes, left = negative direction !
jrun5	move	*a8(oxvel),a0,l
	cmp	a0,a5			; we heading in WRONG direction ?
	jreq	joyr7			; wrong = exit
;***************

	callr	mask_joystick
	jrne	jrun3			; still pressed ---> keep a runnin'
	jruc	joyr7

**************************************************************************

is_run_pressed
	move	@switch,a3,l
	not	a3
	movi	p1b5,a10		; assume player 1 bit
	move	*a13(procid),a7,w
	cmpi	pid_p1,a7
	jreq	irp4
	movi	p2b5,a10		; player 2 bit
irp4	and	a10,a3			; look only at run button bit
	jrne	run_yes
run_no	clrc
	rets

run_yes
	movi	p1_turbo,a1
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	runy3
	movi	p2_turbo,a1
runy3	move	*a1,a0,w		; grab current turbo value
	jreq	no_turbo_left		; button pressed ---> no turbo
	setc
	rets

no_turbo_left
	movi	p1_dont_raise,a6
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	ntl3
	movi	p2_dont_raise,a6
ntl3	movi	turbo_raise_delay,a0
	move	a0,*a6,w		; dont raise this bar for a few ticks
	jruc	run_no


run_setup
	movi	>3e,a9
	calla	get_char_ani		; ani = run
	movk	3,a0
	calla	init_anirate		; run animation speed
	movi	>80000,a0
	calla	towards_x_vel		; set run speed
	movk	7,a0
	jauc	group_sound		; voice: run

;**********************

zero_turbo_bar
	move	@f_unlim_run,a1,w
	jrne	rtb9			; unlimited run !!

	callr	turbo_bar_setup
	movi	turbo_raise_delay,a0
	move	a0,*a6,w		; dont raise this bar for a few ticks
	clr	a0
	move	a0,*a5,w   		; stuff updated value
	rets

reduce_turbo_bar
	move	@f_unlim_run,a1,w
	jrne	rtb9			; unlimited run !!

	callr	turbo_bar_setup
	movi	turbo_raise_delay,a0

	move	a0,*a6,w		; dont raise this bar for a few ticks
	move	*a5,a0,w   		; grab current turbo value
	jreq	rtb9	   		; no turbo ---> exit
	dec	a0
	move	a0,*a5,w   		; stuff updated value
rtb9	rets


turbo_bar_setup
	movi	p1_turbo,a5
	movi	p1_dont_raise,a6
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	rtb5
	movi	p2_turbo,a5
	movi	p2_dont_raise,a6
rtb5	rets

**************************************************************************
*											     *
*  joy = up / right									     *
*											     *
**************************************************************************
joy_upright
	callr	angle_abuse_check

	movi	>40000,a11		; walk angle jump x vel
	movi	>70000,a6		; run angle jump x vel
	movk	>1a,a0			; forward flip
	movk	>1b,a1			; backwards flip
	jsrp	do_flip
	jruc	local_reaction_exit	; return to normal

*
* input: a0 = ani #1
*	a1 = ani #2
*        a6 = run x vel
*       a11 = walk x vel
*
do_flip
	push	a0
	move	a9,a5
	movi	>39,a9
	calla	get_char_ani		; a9 = beginning of run ani
	move	a9,a7	
	calla	find_last_frame
	cmp	a7,a5
	jrlo	jur3			; not in run animation
	cmp	a9,a5
	jrhi	jur3
	move	a6,a11			; in run animation ---> jump further !

jur3	movk	1,a0
	calla	group_sound  	; group speech: jump "huh"
	pull	a0

	move	a0,a9
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	jur4
	move	a1,a9

jur4	callr	stop_me
	callr	disable_all_buttons

	movi	bt_angle_jump,b0
	callr	stuff_buttons		; now you can allow attacks

	movi	act_angle_jump,a0
	move	a0,*a13(p_action),w			; define my action
	move	*a8(oxpos),*a13(p_store8),w	; save starting x position

	calla	is_he_right
	jrnc	jur6
	neg	a11    	
jur6	move	a11,a0			; x vel

	movi	angle_jump_call,a6
  	movi	->a0000,a1		; initial y vel (upwards)
	movi	angle_grav,a2
	movk	3,a3			; animation speed
	movk	4,a11			; flip whoosh sound speed
 	jsrp	flight_call
	jauc	angle_jump_land_jsrp


angle_jump_call
	calla	am_i_joy
	jrc	ajc3			; joy = branch

	move	*a13(p_store1),a6,l
	jreq	ajc9
	call	a6			; drone = call routine !!
	jruc	ajc9

ajc3	callr	next_flip_whoosh

	move	*a8(oyvel),a0,l		; vertical direction ?
	jrn	ajc9			; upwards --> skip
	
	move	*a8(oypos),a2,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	sub	a2,a0
	abs	a0			; a0 = distance from ground
	cmpi	20,a0
	jrhi	ajc9			; hi off ground ---> skip

	callr	disable_all_buttons	; close to ground ---> no attacking
	clr	a6
	move	a6,*a13(p_store4),l	; no more need for this

ajc9	rets


next_flip_whoosh
	dsj	a11,nfw9
	movk	12,a11			; reset counter
	movi	>00c000c1,a0
	calla	p1p2_pick
	calla	triple_sound
nfw9	rets

**************************************************************************

angle_abuse_check
	movi	l_angle,a0
	calla	get_tsl	  	; last one ??
	cmpi	>40,a1	  	; recently ?
	jrhi	aac9	  	; no, let this one slide !!

	move	@f_aabuse,a0,w
	inc	a0
	move	a0,@f_aabuse,w

	.if ejbbug
	cmpi	10,a0
	jrne	aac9
	tsound	>1d    		; CRISPY flag: so I know whats going on
	.endif

aac9	movi	l_angle,a0
	calla	update_tsl
	rets

**************************************************************************
*											     *
*  joy = up / left									     *
*											     *
**************************************************************************
joy_upleft
	callr	angle_abuse_check

	movk	>1a,a1			; forward flip
	movk	>1b,a0			; backwards flip
	movi	->40000,a11		; walk angle jump x vel
	movi	->70000,a6		; run angle jump x vel
	jsrp	do_flip
	jruc	local_reaction_exit	; return to normal

stop_me	calla	stop_a8
	clr	a0
	move	a0,*a8(ograv),l

; <<<<<<<< fall through >>>>>>>>

set_x_vel
	movi	p1_xvel,a1,l
	move	@p1_obj,a2,l
	cmp	a2,a8
	jreq	sxv4			; one of the players ---> zero p?_xvel

	movi	p2_xvel,a1,l
	move	@p2_obj,a2,l
	cmp	a2,a8
	jreq	sxv4			; one of the players ---> zero p?_xvel
	rets

sxv4	move	a0,*a1,l		; make the request !!
	rets

**************************************************************************
*											     *
*  look_for_angle - watches for joystick angle combos			     *
* 											     *
*  returns: carry set = combo was found						     *
*											     *
**************************************************************************
look_for_angle
	movk	3,a11
url4	callr	joystick_in_a0
	move	a0,a1

	andi	m_jup|m_jright,a0
	cmpi	m_jup|m_jright,a0
	jreq	url5
	andi	m_jup|m_jleft,a1
	cmpi	m_jup|m_jleft,a1
	jreq	url6

	sleep	1
	dsjs	a11,url4   		; give a change to go up/right
	retp

url5	pullp	a0			; no return
	jruc	joy_upright
url6	pullp	a0			; no return
	jruc	joy_upleft


angle_scan
	callr	joystick_in_a0
	move	a0,a1
	andi	m_jright|m_jup,a0
	cmpi	m_jright|m_jup,a0
	jreq	ascan4
	andi	m_jleft|m_jup,a1
	cmpi	m_jleft|m_jup,a1
	jreq	ascan5
	rets

ascan4	pull	a0
	jruc	joy_upright
ascan5	pull	a0
	jruc	joy_upleft

**************************************************************************
*											     *
*  mask_joystick - looks at the joystick bits, masks according to	     *
*                  p_store4.								     *
* 											     *
*  returns: zero set   = bit is clear							     *
*           zero clear = bit is set							     *
*											     *
**************************************************************************
mask_joystick
	callr	joystick_in_a0
	move	*a13(p_store4),a1,w	; a1 = joystick mask
	and	a1,a0
	rets

**************************************************************************
*											     *
*  joystick_in_a0 - returns current switch state in a0				*
*											     *
**************************************************************************
joystick_in_a0
	move	*a13(p_joyport),a0,l
	move	*a0,a0,l
	not	a0
	andi	>0f,a0			; look only at 4 joy bits
	rets

**************************************************************************
*											     *
*  check_block_bit - routine to check if a player's block bit iz set !!  *
* 											     *
*  input: a13 = process of dude in question					     *
* 											     *
*  returns: carry set ---> block bit is set !					     *
*											     *
**************************************************************************
check_block_bit
	move	@switch,a0,l
	not	a0			; a0 = switch states
	move	*a13(procid),a1,w
	cmpi	pid_p1,a1		; player 1 ?
	jreq	chbb4			; yes

	andi	m_p2blocks,a0
	jreq	blkno
	jruc	blkyes

chbb4	andi	m_p1blocks,a0
	jreq	blkno

blkyes	setc
	rets
blkno	clrc
	rets


bt_null	.long	0		; 0
	.long	0		; 1
	.long	0		; 2
	.long	0		; 3
	.long	0		; 4
	.long	0		; 5
	.long	0		; 6
	.long	0		; 7
	.long	0		; 8
	.long	0		; 9

bt_angle_jump
	.long	joy_flip_punch 	; 0
	.long	joy_flip_punch 	; 1
	.long	0		; 2
	.long	joy_flip_kick	; 3
	.long	joy_flip_kick	; 4
	.long	0		; 5
	.long	0		; 6
	.long	0		; 7
	.long	0		; 8
	.long	0		; 9

bt_duck
	.long	joy_uppercut	; 0
	.long	joy_duck_punch	; 1
	.long	joy_duck_block	; 2
	.long	joy_duck_kickh	; 3
	.long	joy_duck_kickl	; 4
	.long	0		; 5
	.long	0		; 6
	.long	0		; 7
	.long	0		; 8
	.long	0		; 9

bt_stance
	.long	joy_hi_punch	; 0
	.long	joy_lo_punch	; 1
	.long	joy_block	; 2
	.long	joy_hi_kick	; 3
	.long	joy_lo_kick	; 4
	.long	0		; 5

;	.long	joy_down 	; 6
	.long	0	 	; 6

	.long	0		; 7
	.long	0		; 8
	.long	0		; 9


bt_jump	.long	jumpup_punch	; 0
	.long	jumpup_punch	; 1
	.long	0		; 2
	.long	jumpup_kick	; 3
	.long	jumpup_kick	; 4
	.long	0		; 5
	.long	0		; 6
	.long	0		; 7
	.long	0		; 8
	.long	0		; 9

**************************************************************************
*											     *
*  joy_block - joystick dude block sequence					     *
*											     *
**************************************************************************
joy_block
	callr	disable_all_buttons
	calla	face_opponent		; dont look stupid
	jsrp	do_block_hi

joy_block_loop
	sleep	1
	callr	joystick_in_a0
	btst	bit_jdown,a0
	jrne	joy_down

	calla	am_i_facing_him
	jrc	jblk5

	jsrp	turn_around		; face your rival
	jruc	local_reaction_exit	; return to normal

jblk5	callr	check_block_bit
	jrc	joy_block_loop

	jsrp	do_unblock_hi
	jruc	local_reaction_exit	; return to normal

**************************************************************************
*											     *
*  joy_hi_punch - joystick hi punch		  					     *
*											     *
**************************************************************************
psleep	.set	3

joy_hi_punch
	callr	disable_all_buttons

	callr	me_in_front
	callr	elbow_check
	callr	stop_me	
	movk	>0e,a9
	calla	get_char_ani

jhp4	callr	get_last_button
	move	a0,*a13(p_store3),l	; save here

	movk	2,a0
	move	a0,*a13(p_stk),w

	clr	a0
	calla	group_sound		; group speech: quick attack
	calla	rsnd_whoosh		; woosh

	movk	psleep,a0
	movi	act_hipunch,a1
	jsrp	act_mframew

	move	@f_thatsall,a0,w
	jrne	joy_un_hi_punch1	; round is over ---> exit

	clr	a10			; flag: hi punch
	movk	2,a11			; a11 = strike check offset to use
	move	a11,a0
	callr	punch_strike_check

	movk	5,a10
	jsrp	punch_sleep
	jrnc	joy_un_hi_punch1
	srl	16,a0
	cmpi	sw_lo_punch,a0
	jreq	joy_punch_htm1		; interupted by medium punch !!
 	cmpi	sw_hi_punch,a0
	jrne	joy_un_hi_punch1	; non-hi-punch ----> finish punch

jhp5	callr	get_last_button
	move	a0,*a13(p_store3),l	; save here

	clr	a0
	calla	group_sound		; group speech: quick attack
	calla	rsnd_whoosh		; woosh

	movk	2,a0
	move	a0,*a13(p_stk),w

	movk	psleep,a0
	movi	act_hipunch,a1
	jsrp	act_mframew

	move	@f_thatsall,a0,w
	jrne	joy_un_hi_punch2	; round is over ---> exit

	clr	a10
	movk	2,a11			; a11 = strike check offset to use
	move	a11,a0

	callr	punch_strike_check
	movk	5,a10
	jsrp	punch_sleep
	jrnc	joy_un_hi_punch2
	srl	16,a0
	cmpi	sw_lo_punch,a0
	jreq	joy_punch_htm2		; interupted by medium punch !!
 	cmpi	sw_hi_punch,a0
	jrne	joy_un_hi_punch2	; non-hi-punch ----> finish punch
	jruc	jhp4


joy_un_hi_punch2
	movi	>0e,a9
	calla	find_ani_part2		; a9 ---> part 2
	calla	find_part2		; a9 ---> part 3
	jruc	unhip1

joy_un_hi_punch1
	movi	>0e,a9
	calla	find_ani_part2		; a9 ---> part 2
unhip1	calla	find_part2		; a9 ---> part 3
	calla	find_part2		; a9 ---> un-hipunch
      	movk	psleep-1,a0
	jsrp	mframew
	jruc	local_reaction_exit	; return to normal


joy_punch_htm1
	movi	>0e,a9
	calla	find_ani_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2	; (ejbpatch) - fix this crap !!
	jruc	jmp5

joy_punch_htm2
	movi	>0e,a9
	calla	find_ani_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2	; (ejbpatch) - fix this crap !!
	jruc	jmp4


punch_strike_check

;***********
	.if ejbbug
	move	@f_colbox,a14,w		; collision box object ?
	jreq	psc3
	pull	a14
psc3	.endif
;***********

	calla	strike_check_a0		; strike: hipunch #1
	jrnc	psc5
	clr	a11
	not	a11			; collision = dont check for more
psc5	rets

**************************************************************************
*											     *
*  joy_lo_punch - joystick medium punch						     *
*											     *
**************************************************************************
joy_lo_punch
	callr	stop_me
	callr	disable_all_buttons

	movi	>40,a7
	callr	toss_check
	jrc	joy_toss

	callr	me_in_front

	movk	>0f,a9
	calla	get_char_ani

jmp4	callr	get_last_button
	move	a0,*a13(p_store3),l	; save here

	movk	3,a0
	move	a0,*a13(p_stk),w

	clr	a0
	calla	group_sound		; group speech: quick attack
	calla	rsnd_whoosh		; woosh

	movk	psleep,a0
	movi	act_lopunch,a1
	jsrp	act_mframew

	move	@f_thatsall,a0,w
	jrne	joy_un_lo_punch1	; round is over ---> exit

	movk	1,a10		 	; flag: med punch
	movk	3,a11			; a11 = strike check offset to use
	move	a11,a0
	calla	strike_check_a0	 	; med punch strike #1
	jrnc	jmp2

	clr	a11
	not	a11			; dont check for more collisions

jmp2	movk	5,a10
	jsrp	punch_sleep
	jrnc	joy_un_lo_punch1
	srl	16,a0
	cmpi	sw_hi_punch,a0
	jreq	joy_punch_mth1		; interupted by hi punch !!
 	cmpi	sw_lo_punch,a0
	jrne	joy_un_lo_punch1	; non-med-punch ----> finish punch


jmp5	callr	get_last_button
	move	a0,*a13(p_store3),l		; save here

	movk	3,a0
	move	a0,*a13(p_stk),w

	clr	a0
	calla	group_sound		; group speech: quick attack
	calla	rsnd_whoosh		; woosh

	movk	psleep,a0
	movi	act_lopunch,a1
	jsrp	act_mframew

	move	@f_thatsall,a0,w
	jrne	joy_un_lo_punch2	; round is over ---> exit
	movk	1,a10	   		; flag: med punch
	movk	3,a11			; a11 = strike check offset to use
	move	a11,a0
	calla	strike_check_a0		; med punch strike #2
	jrnc	jmp6
	
	clr	a11
	not	a11			; dont check for more collisions

jmp6	movk	5,a10
	jsrp	punch_sleep
	jrnc	joy_un_lo_punch2
	srl	16,a0
	cmpi	sw_hi_punch,a0
	jreq	joy_punch_mth2		; interupted by hi punch !!
 	cmpi	sw_lo_punch,a0
	jrne	joy_un_lo_punch2	; non-med-punch ----> finish punch
	jruc	jmp4


joy_un_lo_punch2
	movi	>0f,a9
	calla	find_ani_part2		; a9 ---> part 2
	calla	find_part2		; a9 ---> part 3
	jruc	unhip1

joy_un_lo_punch1
	movi	>0f,a9
	calla	find_ani_part2		; a9 ---> part 2
	jruc	unhip1


joy_punch_mth1
	movi	>0f,a9
	calla	find_ani_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2		; fix this crap (ejbpatch)
	jruc	jhp5

joy_punch_mth2
	movi	>0f,a9
	calla	find_ani_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	calla	find_part2
	jruc	jhp4

**************************************************************************
*											     *
*  jumpup_punch - punch while jumping straight up				     *
*											     *
**************************************************************************
jumpup_punch
	callr	disable_all_buttons
	jsrp	do_jumpup_punch
	jruc	local_reaction_exit	; return to normal

**************************************************************************
*											     *
*  jumpup_kick - kick while jumping straight up					     *
*											     *
**************************************************************************
jumpup_kick
	callr	disable_all_buttons
	jsrp	do_jumpup_kick
	jruc	local_reaction_exit	; return to normal

**************************************************************************
*											     *
*  elbow_check - sees if dudes are real close together and if so then    *
*                it jumps to the elbow routine.					     *
*											     *
**************************************************************************
elbow_check
	calla	is_he_airborn
	jrc	local_rets

	callr	get_x_dist		; a3 = x distance between guys
;	cmpi	>40,a3
	cmpi	>4a,a3
	jrhi	local_rets

joy_elbow
	pull	a0
	jsrp	do_elbow
	jruc	local_reaction_exit	; return to normal

**************************************************************************
*											     *
*  toss_check - sees if dudes are close enough to for me to toss the     *
*               other guy. carry set = yes							*
* 											     *
*  input: a7 = x distance to qualify "close enough" to toss !!	     	*
*											     *
**************************************************************************
toss_check
	move	*a13(p_otherguy),a0,l

	calla	q_is_he_a_boss
	jrc	toss_no			; BOSS dudes can't be flipped

	move	@f_sans_throws,a1,w
	jrne	toss_no			; throws disabled !!

	move	*a0(oflags2),a0,w
	btst	b_noflip,a0		; is he allowed to be flipped ??
	jrne	toss_no
	calla	is_he_airborn
	jrc	toss_no			; cant toss if he's airborn
	callr	get_x_dist		; a3 = x distance between guys
	cmp	a7,a3
	jrhi	toss_no			; too far apart !!
	calla	am_i_facing_him
	jrnc	toss_no			; he's on the wrong side o me !!
*
* we are close enough !!
*
	calla	get_his_action
	cmpi	act_land,a1		; landing ?
	jreq	toss_no			; yes ---> cant toss him !!

	calla	is_he_joy
	jrc	toss_ok			; he is joy = ok to throw
	callr	toss_drone_check
*
* no throwing when near a wall
*
toss_ok
	calla	am_i_joy		; am I a joystick dude
	jrnc	tchk4			; no

	calla	get_my_dfe
	calla	is_he_right
	jrc	tchk2
	move	a6,a5			; a5 = edge that is behind me
tchk2	cmpi	close_to_edge+8,a5
	jrlo	toss_no			; close to edge ---> no throwing

tchk4	mmtm	sp,a13,a8
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l	; trick "joystick_in_a0" routine
	callr	is_stick_away
	mmfm	sp,a13,a8
	jrnc	toss_yes      		; joy is not away ---> ok to flip

toss_no
	clrc
	rets

toss_yes	setc
	rets


drone_reverse_toss
joy_toss
	jsrp	do_body_slam
	jauc	reaction_exit


local_rets
	rets

local_reaction_exit
	jauc	reaction_exit



toss_drone_check
	move	@winner_status,a0,w
	cmpi	3,a0
	jreq	tdck9			; finish him = ok to throw

	move	@diff,a0,w
	sll	5,a0
	addi	rt_drone_reverse,a0
	move	*a0,a0,w
	calla	randper
	jrnc	tdck9

	calla	get_his_action
	cmpi	act_frozen,a1
	jreq	tdck9			; froze dude ---> no counter throw

	pull	a7
	pull	a7
	movi	drone_reverse_toss,a7
	calla	react_xfer_him
	sleep	4			; let him slam me
	jauc	reaction_exit		; too l8

tdck9	rets

rt_drone_reverse
	.word	0,100,200,300,400,500,700,700,800,900

**************************************************************************
*											     *
*  knee_check - checks to see if dudes are close enough for a knee!!     *
*											     *
**************************************************************************
knee_check
	callr	get_x_dist		; a3 = x distance between guys
;	cmpi	>40,a3
	cmpi	>4a,a3
	jrhi	local_rets 		; too far away
	calla	is_he_airborn		; is he airborn ?
	jrc	local_rets		; yes, dont knee

joy_knee
	pull	a0
	jsrp	do_knee
	jruc	local_reaction_exit	; return to normal

**************************************************************************
*											     *
*  get_x_dist - get ani x distance between 2 dudes				     *
* 											     *
*  returns: a3 = distance between 'em							     *
*											     *
**************************************************************************
get_x_dist
	move	*a8(oxpos),a4,w
	move	*a13(p_otherguy),a3,l
	move	*a3(oxpos),a3,w
	jruc	gdist4

get_y_dist
	move	*a8(oypos),a4,w
	move	*a13(p_otherguy),a10,l
	move	*a10(oypos),a3,w
gdist4	sub	a4,a3
	abs	a3		; a3 = distance
	rets

**************************************************************************
*											     *
*  punch_sleep - sleep used after a punch has been made (and hit)	     *
* 											     *
*  input: a10 = total sleep time (assuming no buttons pressed)		     *
*         a11 = strike_check offset							     *
*  *a13(p_store3) = button/time that started it all					*
* 											     *
*  returns: carry set = interupted by additional button press		     *
* 											     *
*            a0 = last button/time pressed							*
*											     *
**************************************************************************
punch_sleep
	sleep	1
	move	a11,a0
	jrn	psl2			; neg = dont check for collision
	callr	punch_strike_check
					; ejbpatch - abort if success hit !!
psl2	callr	get_last_button
	move	*a13(p_store3),a1,l	; a1 = old state
	cmp	a0,a1			; same ?
	jrne	psl7			; no, leave right now
	dsjs	a10,punch_sleep		; count yer sleeps
	clrc
	jruc	psl9

psl7	calla	am_i_facing_him		; allow repeats only if im facing him
psl9	retp

**************************************************************************
*											     *
*  get_last_button - returns last button/time in a0			     	*
*											     *
**************************************************************************
get_last_button
	calla	get_bcq_next_pointer
	jauc	previous_q_entry

**************************************************************************
*											     *
*  joy_hi_kick - joystick high kick							     *
*											     *
**************************************************************************
joy_hi_kick
	callr	disable_all_buttons
	callr	is_stick_away
	jrc	joy_roundhouse		; stick away ---> roundhouse

	callr	knee_check
	jsrp	do_hi_kick
	jruc	local_reaction_exit	; return to normal

joy_roundhouse
	jsrp	do_roundhouse
	jruc	local_reaction_exit	; return to normal

**************************************************************************
*											     *
*  joy_lo_kick - joystick low kick							     *
*											     *
**************************************************************************
joy_lo_kick
	callr	disable_all_buttons
	callr	knee_check

	callr	is_stick_away
	jrc	joy_sweep_kick

	jsrp	do_lo_kick
	jruc	local_reaction_exit

joy_sweep_kick
	jsrp	do_sweep_kick
	jruc	local_reaction_exit

**************************************************************************
*											     *
*  joy_flykick - joystick dude kicking while flying at an angle	     *
*											     *
**************************************************************************
joy_flip_kick
	callr	disable_all_buttons
	jsrp	do_flip_kick
	jruc	local_reaction_exit

joy_flip_punch
	callr	disable_all_buttons
	jsrp	do_flip_punch
	jruc	local_reaction_exit

**************************************************************************
*											     *
*  check_winner_status - players call this routine between every move    *
*                        to check the status of the game			     *
* 											     *
*  where the variable means:								     *
* 											     *
*  0 - no outcome yet									     *
*  1 - player 1 wins									     *
*  2 - player 2 wins									     *
*  3 - finish him off mode								     *
*  4 - endurance transition 									*
*											     *
**************************************************************************
check_winner_status
	move	@winner_status,a0,w
	jreq	cws9				; nothing new ---> return
	cmpi	4,a0
	jrhi	winner_error
	dec	a0
	sll	5,a0
	addi	status_jumps,a0
	move	*a0,a0,l
	jump	a0				; jump to offset of table

cws9	rets


status_jumps
	.long	player_1_wins			; winner_status = 1
	.long	player_2_wins			; winner_status = 2
	.long	finish_him			; winner_status = 3
	.long	endurance_trans			; winner status = 4

winner_error
	ermac	2				; we are screwed bigtime !!

**************************************************************************
*											     *
*  disable_his_buttons - disable other players buttons			     *
*											     *
**************************************************************************
disable_his_buttons
	push	a8
	push	b0
	move	*a13(p_otherguy),a8,l	; trick "disable_all_buttons"
	callr	disable_all_buttons
	pull	b0
	pull	a8
	rets

**************************************************************************
*											     *
*  disable_all_buttons - disable my buttons					     *
*											     *
**************************************************************************
disable_all_buttons
	movi	bt_null,b0
	jruc	stuff_buttons	

enable_all_buttons
	movi	bt_stance,b0
;	<<<<<<<<<<<< fall through >>>>>>>>>>>>

**************************************************************************
*											     *
*  stuff_buttons - stuff a new button vector into p?_button		     *
* 											     *
*  input: b0 = new vector								     *
*         a8 = player object making the request					     *
*											     *
**************************************************************************
stuff_buttons
	push	a0
	move	@p1_obj,a0,l		; a0 = player 1 object
	movi	p1_button,b1
	cmp	a0,a8			; my object match player 1 ?
	jreq	stbut3			; yes, i am player 1
	movi	p2_button,b1		; no, i am player 2
stbut3	move	b0,*b1,l
	pull	a0
	rets

**************************************************************************
*											     *
*  stuff_bjump - stuff an address into a players button jump ram	     *
* 											     *
*  input: a10 = player 1 button jump ram						     *
*         a11 = player 2 button jump ram						     *
*         a9 = address	  								     *
*											     *
**************************************************************************
stuff_bjump
	move	@p1_obj,a3,l
	cmp	a3,a8
	jreq	sbj4
    	move	a11,a10
sbj4	move	a9,*a10,l		; stuff address in !!
	rets

**************************************************************************
*											     *
*  me_in_front - puts my object in front of the other guys		     *
* 											     *
*  input: a8 = my object									     *
*											     *
**************************************************************************
me_in_front
	move	*a13(p_otherguy),a1,l	; grab the other chump
	movi	back_z,a0
	move	a0,*a1(ozval),l
	movi	front_z,a0
	move	a0,*a8(ozval),l
	rets

**************************************************************************
*											     *
*  me_in_back - puts my object in front of the other guys		     	*
* 											     *
*  input: a8 = my object									     *
*											     *
**************************************************************************
me_in_back
	move	*a13(p_otherguy),a1,l	; grab the other chump
	movi	front_z,a0
	move	a0,*a1(ozval),l
	movi	back_z,a0
	move	a0,*a8(ozval),l
	rets

**************************************************************************
*											     *
*  noflip_a2 - set the noflip bit in the a2 object				     *
*											     *
**************************************************************************
noflip_a2
	move	*a2(oflags2),a4,w
	ori	m_noflip,a4
	move	a4,*a2(oflags2),w		; set his bit !
	rets

**************************************************************************
*											     *
*      questions questions questions questions questions questions	     *
*      questions questions questions questions questions questions	     *
*      questions questions questions questions questions questions	     *
*											     *
**************************************************************************

**************************************************************************
*											     *
*  is_stick_away - answers the question: "is my joystick moving away	*
*                  from the other dude?"	 					     *
* 											     *
*  returns: carry set = yes								     *
*											     *
**************************************************************************
is_stick_up
	movi	m_jup,a7
	jruc	isa5

is_stick_left
	movi	m_jleft,a7
	jruc	isa5


is_stick_toward
	movi	m_jright,a7
	calla	is_he_right
	jrc	isa5
	movi	m_jleft,a7
	jruc	isa5

is_stick_away
	movi	m_jleft,a7
	calla	is_he_right
	jrc	isa5

is_stick_right
	movi	m_jright,a7

isa5	callr	joystick_in_a0		; a0 = joy bits
	and	a7,a0
	jreq	isa7
	setc
	rets

isa7	clrc
	rets

is_stick_down
	callr	joystick_in_a0
	btst	bit_jdown,a0		; is joystick down ?
	jrne	isdyes	
	clrc
	rets
isdyes	setc
	rets

**************************************************************************

ochar_begin_calls
	movi	ochar_begin_tab,a0
	jauc	ochar_call

ochar_begin_tab
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
	.long	smoke_begin

	.long	0
	.long	0
	.long	noob_begin
	.long	0
	.long	0


smoke_begin
	movi	>1f,a0
	calla	create_fx		; smoke = smoke screen needed !!

	move	@f_smoke,a0,w		; smoke adj set ?
	jrne	local_rets		; yes, dont change diff

	movk	9,a0
	move	a0,@diff,w		; smoke is still hidden = tough
	rets

noob_begin
	movk	8,a0
	move	a0,@diff,w		; noob is a tough lil cookie
	rets

;************************************************************************

	.end

