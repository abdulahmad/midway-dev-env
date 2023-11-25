**************************************************************************
*											     *
*  video game project:	MK3									*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: special moves										*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	"moves.asm"
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

p1_up	.set	001H
p1_down	.set	002H
p1_left	.set	003H
p1_right	.set	004H	
p2_up	.set	0100H
p2_down	.set	0200H
p2_left	.set	0300H
p2_right	.set	0400H	

reaction_exit
	calla	am_i_airborn		; am i in the air ?
	jrnc	rex3			; no

	clr	a0
	clr	a1
	movi	06000H,a2		; a2 = gravity
	movk	5,a3			; a3 = ani speed
	jauc	fall_on_my_back

rex3	calla	stop_me
	calla	back_to_normal	  	; back 2 reality
	calla	reset_proc_stack  	; make things kosher
	calla	back_to_shang_check

	move	*a13(p_flags),a4,w
	btst	pb_corpse,a4
	jane	collapse_on_ground	; I am a beaten endurance guy = die
	btst	pb_joy,a4		; joystick dude ?
	jane	joy_entry		; yes ---> return to joystick
	jauc	drone_entry		; no ---> drone

**************************************************************************
*											     *
*   the following info is supplied:							     *
* 											     *
*  a0 = switch offset (0-8)								     *
*  a2 = player offset (0-1)								     *
*  a8 = my object									     *
* 											     *
*  p_store4    = my proc									     *
*  p_otherguy  = other guy's object							     *
*  p_otherproc = other guy's proc							     *
*											     *
**************************************************************************
switch_close_jumps
	.long	ochar_hp_close
	.long	ochar_lp_close
	.long	ochar_block_close
	.long	ochar_hk_close
	.long	ochar_lk_close
	.long	ochar_run_close

	.long	ochar_up
	.long	ochar_down
	.long	ochar_left
	.long	ochar_right


ochar_run_close
	.long	0
	.long	sonya_run_close
	.long	0
	.long	0
	.long	sz_run_close

	.long	0
	.long	0
	.long	0
	.long	robo2_run_close
	.long	lao_run_close

	.long	tusk_run_close
	.long	0
	.long	st_run_close
	.long	0
	.long	smoke_run_close


ochar_hp_close
	.long	kano_hp_close	; 0
	.long	sonya_hp_close	; 1
	.long	jax_hp_close	; 2
	.long	ind_hp_close	; 3
	.long	sz_hp_close	; 4
	.long	sw_hp_close	; 5
	.long	lia_hp_close	; 6
	.long	robo_hp_close
	.long	robo2_hp_close
	.long	lao_hp_close
	.long	tusk_hp_close
	.long	sg_hp_close
	.long	st_hp_close
	.long	lk_hp_close
	.long	0


ochar_lp_close
	.long	kano_lp_close
	.long	sonya_lp_close
	.long	jax_lp_close
	.long	ind_lp_close
	.long	sz_lp_close
	.long	sw_lp_close
	.long	lia_lp_close
	.long	robo_lp_close
	.long	robo2_lp_close
	.long	lao_lp_close
	.long	tusk_lp_close
	.long	sg_lp_close
	.long	st_lp_close
	.long	lk_lp_close
	.long	smoke_lp_close


ochar_block_close
	.long	kano_block_close
	.long	sonya_block_close
	.long	jax_block_close
	.long	ind_block_close
	.long	sz_block_close
	.long	sw_block_close
	.long	lia_block_close
	.long	robo_block_close
	.long	robo2_block_close
	.long	lao_block_close
	.long	tusk_block_close
	.long	sg_block_close
	.long	st_block_close
	.long	lk_block_close
	.long	smoke_block_close


ochar_hk_close
	.long	kano_hk_close
	.long	sonya_hk_close
	.long	jax_hk_close
	.long	ind_hk_close
	.long	sz_hk_close	; 4

	.long	sw_hk_close
	.long	lia_hk_close
	.long	robo_hk_close
	.long	robo2_hk_close
	.long	lao_hk_close

	.long	tusk_hk_close
	.long	sg_hk_close
	.long	st_hk_close
	.long	lk_hk_close
	.long	smoke_hk_close


ochar_lk_close
	.long	kano_lk_close
	.long	sonya_lk_close
	.long	jax_lk_close
	.long	ind_lk_close
	.long	sz_lk_close

	.long	sw_lk_close
	.long	lia_lk_close
	.long	robo1_lk_close
	.long	robo2_lk_close
	.long	lao_lk_close

	.long	tusk_lk_close
	.long	0
	.long	st_lk_close
	.long	lk_lk_close
	.long	smoke_lk_close


ochar_up
	.long	0
	.long	0
	.long	0
	.long	0
	.long	sz_up

	.long	0
	.long	lia_up_close
	.long	robo1_up
	.long	robo2_up_close
	.long	lao_up

	.long	tusk_up
	.long	sg_up
	.long	st_up_close
	.long	lk_up_close
	.long	smoke_up_close


ochar_down
	.long	0
	.long	sonya_down_close
	.long	0
	.long	ind_down_close
	.long	0

	.long	0
	.long	0
	.long	robo1_down_close
	.long	robo2_down_close
	.long	lao_down_close

	.long	0
	.long	0
	.long	st_down_close
	.long	lk_down_close
	.long	smoke_down_close



ochar_left
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

ochar_right
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
*    Sheeva										     *
*											     *
**************************************************************************
sg_block_close
	movi	sm_sg_bc,a14
	jruc	secret_move_search

sg_hk_open
	movi	sm_sg_hko,a14
	jruc	secret_move_search

sg_lp_close
	movi	sm_sg_lpc,a14
	jruc	secret_move_search

sg_hk_close
	movi	sm_sg_hkc,a14
	jruc	secret_move_search

sg_up	movi	sm_sg_uc,a14
	jruc	secret_move_search

sg_hp_close
	movi	sm_sg_hpc,a14
	jruc	secret_move_search

**************************************************************************
*											     *
*   Liu Kang										     *
*											     *
**************************************************************************
lk_down_close
	movi	sm_lk_dc,a14
	jruc	secret_move_search

lk_up_close
	movi	sm_lk_uc,a14
	jruc	secret_move_search

lk_block_close
	movi	sm_lk_bc,a14
	jruc	secret_move_search

lk_lk_close
	movi	sm_lk_lkc,a14
	jruc	secret_move_search

lk_hp_close
	movi	sm_lk_hpc,a14
	jruc	secret_move_search

lk_lp_close
	movi	sm_lk_lpc,a14
	jruc	secret_move_search

lk_hk_close
	movi	sm_lk_hkc,a14
	jruc	secret_move_search

lk_lk_open
	movi	sm_lk_lko,a14
	jruc	secret_move_search

**************************************************************************
*											     *
*  Shang Tsung										     *
*											     *
**************************************************************************
st_hp_open
	movi	sm_st_hpo,a14
	jruc	secret_move_search

st_lp_open
	movi	sm_st_lpo,a14
	jruc	secret_move_search

st_lk_open
	movi	sm_st_lko,a14
	jruc	secret_move_search

st_run_close
	movi	sm_st_rc,a14
	jruc	secret_move_search

st_hk_close
	movi	sm_st_hkc,a14
	jruc	secret_move_search

st_lk_close
	movi	sm_st_lkc,a14
	jruc	secret_move_search


st_up_close
	movi	sm_st_uc,a14
	jruc	secret_move_search

st_down_close
	callr	check_st_2_sonya
	jrc	st_2_sonya
	movi	sm_st_dc,a14
	jruc	secret_move_search

st_block_close
	callr	check_st_2_sonya
	jrc	st_2_sonya
	movi	sm_st_bc,a14
	jruc	secret_move_search

st_lp_close
	callr	check_st_2_sonya
	jrc	st_2_sonya

	movi	sm_st_lpc,a14
	jruc	secret_move_search

st_hp_close
	movi	sm_st_hpc,a14
	jruc	secret_move_search

st_2_sonya
	movi	do_st_2_sonya,a7
	jruc	restricted_xfer

**************************************************************************
*											     *
*  Tusk											     *
*											     *
**************************************************************************
tusk_up
	movi	sm_tusk_uc,a14
	jruc	secret_move_search

tusk_hk_close
	movi	sm_tusk_hkc,a14
	jruc	secret_move_search

tusk_block_close
	movi	sm_tusk_bc,a14
	jruc	secret_move_search

tusk_run_close
	movi	sm_tusk_rc,a14
	jruc	secret_move_search

tusk_lk_close
	movi	sm_tusk_lkc,a14
	jruc	secret_move_search

tusk_lp_close
	jruc	death

tusk_hp_close
	movi	sm_tusk_zap,a14
	jruc	secret_move_search

tusk_hp_open
	movi	sm_tusk_hpo,a14
	jruc	secret_move_search


**************************************************************************
*											     *
*   Smoke										     *
*											     *
**************************************************************************
smoke_lk_close
	movi	sm_smoke_lkc,a14
	jruc	secret_move_search

smoke_up_close
	movi	sm_smoke_uc,a14
	jruc	secret_move_search

smoke_down_close
	movi	sm_smoke_dc,a14
	jruc	secret_move_search

smoke_hk_close
	movi	sm_smoke_hkc,a14
	jruc	secret_move_search

smoke_run_close
	movi	sm_smoke_rc,a14
	jruc	secret_move_search

smoke_lp_close
	movi	sm_smoke_lpc,a14
	jruc	secret_move_search

smoke_block_close
	calla	distance_from_ground
	cmpi	0a0H,a0			; high enough off ground ?
	jrlo	smoke_block_close2   ; no

	calla	get_x_dist
	cmpi	058H,a3	  		; close enough ?
	jrhi	smoke_block_close2	; no
	calla	get_y_dist
	cmpi	058H,a3	  		; close enough ?
	jrhi	smoke_block_close2	; no

	move	*a10(oypos),a2,w
	move	@ground_y,a0,w
	sub	a2,a0
	cmpi	0b8H,a0			; high enough off ground ?
	jrlo	smoke_block_close2  	; no

	calla	q_is_he_a_boss
	jrc	smoke_block_close2	; boss = sorry smoke !!!

	calla	get_his_action
	cmpi	act_react_flipk,a1
	jreq	smoke_block_close2

	movi	do_air_slam,a7
	jruc	airborn_xfer

smoke_block_close2
	movi	sm_smoke_bc,a14
	jruc	secret_move_search

**************************************************************************
*											     *
*    Kano										     *
*											     *
**************************************************************************
kano_lp_close
	movi	sm_kano_lpc,a14
	jruc	secret_move_search

kano_hk_close
	movi	sm_kano_hkc,a14
	jruc	secret_move_search

kano_lp_open
	movi	sm_kano_lpo,a14
	jruc	secret_move_search

**************************************************************************
*											     *
*     Sonya										     *
*											     *
**************************************************************************
sonya_down_close
	movi	sm_sonya_dc,a14
	jruc	secret_move_search

sonya_run_close
	movi	sm_sonya_rc,a14
	jruc	secret_move_search

sonya_lp_open
	movi	sm_sonya_lpo,a14
	jruc	secret_move_search

sonya_lk_close
	movi	sm_sonya_lkc,a14
	jruc	secret_move_search

sonya_hk_close
	movi	p1b3,a0			; player 1 legal buttons
	movi	p2b3,a1			; player 2 legal buttons
	movi	scom_bike,a11		; switch combo table
	callr	stick_look_lr
	jrnc	death			; no

	calla	get_his_action
	cmpi	act_sbike_kicked,a1
	jreq	death

	movi	do_bike,a7
	jruc	restricted_xfer

sonya_hp_close
	movi	sm_sonya_hpc,a14
	jruc	secret_move_search

sonya_lp_close
	movi	p1b1,a0			; player 1 legal buttons
	movi	p2b1,a1			; player 2 legal buttons
	movi	scom_sonya_zap,a11	; switch combo table
	callr	stick_look_lr
	jrnc	slpc3			; no

	movi	do_sonya_zap,a7
	jruc	restricted_xfer

slpc3	callr	check_sonya_legs
	jrnc	death
	movi	do_leg_throw,a7
	jruc	restricted_xfer

sonya_block_close
	callr	check_sonya_legs
	jrnc	death
	movi	do_leg_throw,a7
	jruc	restricted_xfer


check_st_2_sonya
	movi	p1b1|p1b2|p1b5,a0		; player 1 requirement
	movi	p2b1|p2b2|p2b5,a1		; player 2 requirement
	callr	button_bit_check
	jrnc	q_no
	jauc	is_stick_down


check_sonya_legs
	movi	p1b1|p1b2,a0		; player 1 requirement
	movi	p2b1|p2b2,a1		; player 2 requirement
	callr	button_bit_check
	jrnc	q_no

	calla	get_his_action
	cmpi	act_legged,a1
	jreq	q_no			; no repeats
	cmpi	act_sweep_sd,a1
	jreq	q_no			; not sfter a sweep

	jauc	is_stick_down

**************************************************************************

lia_up_close
	movi	sm_lia_uc,a14
	jruc	secret_move_search

lia_block_close
	movi	sm_lia_bc,a14
	jruc	secret_move_search

lia_lp_close
	movi	sm_lia_lpc,a14
	jruc	secret_move_search


lia_lk_close
	movi	p1b4,a0			; player 1 legal buttons
	movi	p2b4,a1			; player 2 legal buttons
	movi	scom_lia_anglez,a11 	; switch combo table
	callr	stick_look_lr
	jrnc	death			; no

	calla	distance_from_ground
	cmpi	0b0H,a0
	jrlo	death			; gotta be off da ground

	movk	1,a6			; 1 = airborn
	movi	do_lia_anglez,a7
	callr	check_tsl
	.long	l_liazap
	.word	030H			; enuf seconds ?
	jruc	death


lia_hk_close
	movi	p1b3,a0			; player 1 legal buttons
	movi	p2b3,a1			; player 2 legal buttons
	movi	scom_fly,a11		; switch combo table
	callr	stick_look_lr
	jrnc	death			; no

	calla	q_is_he_a_boss
	jrc	death

	movi	do_lia_fly,a7
	jruc	restricted_xfer


lia_hp_close
	movi	sm_lia_hpc,a14
	jruc	secret_move_search

**************************************************************************
lao_lk_close
	movi	sm_lao_lkc,a14
	jruc	secret_move_search

lao_block_close
	movi	sm_lao_bc,a14
	jruc	secret_move_search

lao_down_close
	movi	sm_lao_dc,a14
	jruc	secret_move_search

lao_hp_close
	movi	sm_lao_hpc,a14
	jruc	secret_move_search

lao_run_close
	movi	sm_lao_rc,a14
	jruc	secret_move_search



lao_up
	movi	p1b0|p1b1|p1b2|p1b3|p1b4,a0
	movi	p2b0|p2b1|p2b2|p2b3|p2b4,a1
	movi	scom_lao_teleport,a11
	callr	stick_look_lr		; melt joystick combo ?
	jrnc	death			; no

	movi	do_lao_tele,a7
	jruc	restricted_xfer


lao_lp_close
	movi	p1b1,a0
	movi	p2b1,a1
	movi	scom_lao_zap,a11
	callr	stick_look_lr		; hat head throw yer hat ?
	jrnc	death			; no

	callr	is_my_proj_alive
	jrc	death			; I have a projectile active ---> die

	movi	do_lao_zap,a7
	jruc	restricted_xfer


lao_hk_close
	movi	p1b3,a0
	movi	p2b3,a1
	movi	scom_lao_angle_kick,a11
	callr	stick_look_lr
	jrnc	death				; no

	calla	distance_from_ground
	cmpi	0a0H,a0
	jrlo	death				; must be at a certain height

	movi	do_lao_angle_kick,a7
	jruc	airborn_xfer

**************************************************************************

switch_open_jumps
	.long	ochar_hi_punch_open	; 0
	.long	ochar_lo_punch_open	; 1
	.long	ochar_block_open	; 2
	.long	ochar_hi_kick_open	; 3
	.long	ochar_lo_kick_open	; 4
	.long	ochar_run_open		; 5
	.long	ochar_null		; 6
	.long	ochar_null		; 7
	.long	ochar_null		; 8
	.long	ochar_null		; 9


ochar_run_open
	.long	all_run_open
	.long	all_run_open
	.long	all_run_open
	.long	all_run_open
	.long	all_run_open

	.long	all_run_open
	.long	all_run_open
	.long	all_run_open
	.long	all_run_open
	.long	all_run_open

	.long	all_run_open
	.long	all_run_open
	.long	all_run_open
	.long	all_run_open
	.long	all_run_open


all_run_open
	movi	sm_all_ro,a14
	jruc	secret_move_search


sm_all_ro
	.long	p1b5	     	; player 1 requirements
	.long	p2b5	     	; player 2 requirements
	.word	x_mercy
	.long	q_mercy_req	; yes/no routine
	.long	do_mercy 	; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0



ochar_hi_punch_open
	.long	kano_hp_open
	.long	0
	.long	0
	.long	ind_hp_open
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	tusk_hp_open
	.long	0
	.long	st_hp_open
	.long	0
	.long	0

ochar_lo_punch_open
	.long	kano_lp_open
	.long	sonya_lp_open
	.long	jax_lp_open
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	st_lp_open
	.long	0
	.long	0

ochar_block_open
	.long	0
	.long	0
	.long	jax_block_open
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


ochar_lo_kick_open
	.long	kano_lk_open
	.long	0
	.long	jax_lk_open
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	st_lk_open
	.long	lk_lk_open
	.long	0


ochar_hi_kick_open
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
	.long	sg_hk_open
	.long	0
	.long	0
	.long	0


ochar_null
	.long	0,0,0,0,0
	.long	0,0,0,0,0
	.long	0,0,0,0,0
	
**************************************************************************

jax_lk_close
	movi	sm_jax_lkc,a14
	jruc	secret_move_search

jax_block_close
	calla	distance_from_ground
	cmpi	0a0H,a0			; high enough off ground ?
	jrlo	jax_block_close2		; no

	calla	get_x_dist
	cmpi	058H,a3	  		; close enough ?
	jrhi	jax_block_close2		; no
	calla	get_y_dist
	cmpi	058H,a3	  		; close enough ?
	jrhi	jax_block_close2		; no

	move	*a10(oypos),a2,w
	move	@ground_y,a0,w
	sub	a2,a0
	cmpi	0b8H,a0			; high enough off ground ?
	jrlo	jax_block_close2		; no

	calla	q_is_he_a_boss
	jrc	jax_block_close2		; boss = sorry jax !!!

	calla	get_his_action
	cmpi	act_react_flipk,a1
	jreq	jax_block_close2

	movi	do_back_breaker,a7
	jruc	airborn_xfer

jax_block_close2
	jruc	death

;	movi	sm_jax_bc,a14
;	jruc	secret_move_search

jax_block_open
	movi	sm_jax_bo,a14
	jruc	secret_move_search

jax_lp_open
	movi	sm_jax_lpo,a14
	jruc	secret_move_search

jax_hp_close
	movi	p1b0|p1b1|p1b4,a0	; player 1 legal buttons
;	movi	p2b0|p2b1|p1b4,a1	; player 2 legal buttons
	movi	p2b0|p2b1|p2b4,a1	; rev2.1 fix !!

	movi	scom_jax_zap2,a11
	callr	stick_look_lr
	jrnc	jhpc3			; no

	movi	l_jaxzap2,a0
	calla	get_tsl   		; get dis event !!
	cmpi	040H*2,a1
	jrlo	jhpc3			; not too often

	movi	do_jax_zap2,a7
	jruc	restricted_xfer

jhpc3	movi	p1b0|p1b4,a0		; player 1 legal buttons
	movi	p2b0|p1b4,a1		; player 2 legal buttons
	movi	scom_jax_zap1,a11
	callr	stick_look_lr
	jrnc	death			; no

	movi	do_jax_zap1,a7
	jruc	restricted_xfer


jax_lp_close
	movi	sm_jax_lpc,a14
	jruc	secret_move_search

jax_hk_close
	movi	p1b3|p1b4,a0		; player 1 legal buttons
	movi	p2b3|p1b4,a1		; player 2 legal buttons
	movi	scom_dash,a11
	callr	stick_look_lr
	jrnc	death			; no
	movi	jax_dash_punch,a7
	jruc	restricted_xfer

jax_lk_open
	clr	a6
	movi	do_quake,a7		; a7 = special move address
	callr	check_tsl
	.long	l_lk			; last time low kick was pressed
	.word	050H			; 2 seconds ?
	jruc	death

**************************************************************************

kano_block_close
	calla	q_is_he_a_boss
	jrc	death

	calla	distance_from_ground
	cmpi	0a0H,a0			; high enough off ground ?
	jrlo	death			; no

	calla	get_x_dist
	cmpi	050H,a3	  		; close enough ?
	jrhi	death			; no
	calla	get_y_dist
	cmpi	050H,a3	  		; close enough ?
	jrhi	death			; no

	move	*a10(oypos),a2,w
	move	@ground_y,a0,w
	sub	a2,a0
	abs	a0
	cmpi	0b8H,a0			; high enough off ground ?
	jrlo	death			; no

	calla	get_his_action
	cmpi	act_react_flipk,a1
	jreq	death

	movi	do_air_slam,a7
	jruc	airborn_xfer


kano_hp_close
	movi	sm_kano_hpc,a14
	jruc	secret_move_search


kano_lk_close
	movi	sm_kano_lkc,a14
	jruc	secret_move_search

kano_lk_open
	clr	a6			; xfer offset
	movi	do_kano_roll,a7		; a7 = special move address
	callr	check_tsl
	.long	l_lk			; last time low kick was pressed
	.word	050H			; 2 seconds ?
	jruc	death

kano_hp_open
	movi	sm_kano_hpo,a14
	jruc	secret_move_search

**************************************************************************

ind_block_close
	movi	sm_ind_bc,a14
	jruc	secret_move_search

ind_down_close
	movi	sm_ind_dc,a14
	jruc	secret_move_search

ind_hp_close
	movi	sm_ind_hpc,a14
	jruc	secret_move_search

ind_hp_open
	movi	sm_ind_hpo,a14
	jruc	secret_move_search

ind_lp_close
	movi	sm_ind_lpc,a14
	jruc	secret_move_search

ind_lk_close
	movi	p1b4,a0   		; player 1 legal buttons
	movi	p2b4,a1   		; player 2 legal buttons
	movi	scom_ind_charge,a11
	callr	stick_look_lr
	jrnc	death			; no

	movi	do_ind_charge,a7
	jruc	restricted_xfer


ind_hk_close
	movi	sm_ind_hkc,a14
	jruc	secret_move_search

**************************************************************************
*											     *
*   Sub-zero										     *
*											     *
**************************************************************************

sz_run_close
	movi	sm_sz_rc,a14
	jruc	secret_move_search

sz_up
	movi	sm_sz_uc,a14
	jruc	secret_move_search


sz_hk_close
	movi	sm_sz_hkc,a14
	jruc	secret_move_search


sz_hp_close
	movi	p1b0,a0   		; player 1 legal buttons
	movi	p2b0,a1   		; player 2 legal buttons
	movi	scom_sky_zap_on,a11
	callr	stick_look_lr
	jrnc	szhpc3			; no

	movi	do_sky_ice_on,a7
	jruc	sky_ice_xfer

szhpc3	movi	p1b0,a0   		; player 1 legal buttons
	movi	p2b0,a1   		; player 2 legal buttons
	movi	scom_sky_zap_behind,a11
	callr	stick_look_lr
	jrnc	szhpc4			; no

	movi	do_sky_ice_behind,a7
	jruc	sky_ice_xfer

szhpc4	movi	p1b0,a0   		; player 1 legal buttons
	movi	p2b0,a1   		; player 2 legal buttons
	movi	scom_sky_zap_front,a11
	callr	stick_look_lr
	jrnc	death			; no

	movi	do_sky_ice_front,a7

sky_ice_xfer
	movi	pid_decoy1*010000H+pid_decoy2,a0
	calla	p1p2_pick
	clr	a1
	not	a1
	calla	existp
	jreq	restricted_xfer

	move	*a0(p_store1),a0,w
	move	*a8(oid),a1,w
	cmp	a0,a1
	jreq	death			; I have a decoy proc ---> no ice
	jruc	restricted_xfer

sz_lk_close
	callr	slide_check
	jruc	death

sz_block_close
	callr	slide_check
	jruc	death

;	movi	sm_sz_bc,a14
;	jruc	secret_move_search


sz_lp_close
	callr	slide_check
	movi	sm_sz_lpc,a14
	jruc	secret_move_search


slide_check
	calla	is_stick_away
	jrnc	local_rets

	movi	p1b1|p1b2|p1b4,a0	; player 1 requirement
	movi	p2b1|p2b2|p2b4,a1	; player 2 requirement
	callr	button_bit_check
	jrnc	local_rets
	pull	a0			; no deposit, no return
	movi	do_slide,a7
	jruc	restricted_xfer

**************************************************************************

sw_block_close
	movi	sm_sw_bc,a14
	jruc	secret_move_search

sw_lk_close
	movi	sm_sw_lkc,a14
	jruc	secret_move_search

sw_hk_close
	movi	sm_swat_hkc,a14
	jruc	secret_move_search

sw_lp_close
	movi	sm_swat_lpc,a14
	jruc	secret_move_search

sw_hp_close
	movi	sm_swat_hpc,a14
	jruc	secret_move_search

**************************************************************************
robo2_up_close
	movi	sm_robo2_uc,a14
	jruc	secret_move_search

robo2_down_close
	movi	sm_robo2_dc,a14
	jruc	secret_move_search

robo_hk_close
	movi	sm_robo_hkc,a14
	jruc	secret_move_search

robo_block_close
	movi	sm_robo_bc,a14
	jruc	secret_move_search

robo2_run_close
	movi	sm_robo2_rc,a14
	jruc	secret_move_search

robo2_hp_close
	movi	sm_robo2_hpc,a14
	jruc	secret_move_search


robo2_lp_close
	move	*a13(p_store4),a0,l
	move	*a0(pwake),a0,l
	cmpi	air_grab_sleep,a0	; air grabbin ?
	jrne	death

	calla	get_y_dist
	cmpi	030H,a3			; close enough ???
	jrhi	death			; no.
	calla	get_x_dist
	cmpi	050H,a3			; close enough ???
	jrhi	death			; no.

	movi	do_air_slam,a7
	jruc	free_xfer


robo2_block_close
	movi	p1b2,a0
	movi	p2b2,a1
	movi	scom_robo2_tele,a11
	callr	stick_look_lr
	jrnc	r2blk3			; no

	movi	do_tele_explode,a7
	jruc	airborn_xfer

r2blk3	movi	p1b2,a0
	movi	p2b2,a1
	movi	scom_robo_air_grab,a11
	callr	stick_look_lr
	jrnc	death			; no

	calla	q_is_he_a_boss
	jrc	death

	calla	is_he_airborn
	jrnc	death

	move	*a13(p_otherguy),a0,l
	move	*a0(oyvel),a1,l
	jrn	r2bc3			; headin upwards = cool

	move	*a0(oypos),a1,w
	move	*a13(p_otherproc),a2,l
	move	*a2(p_ganiy),a2,w
	sub	a1,a2
	abs	a2
	cmpi	030H,a3
	jrlo	death			; headin down and too close to grnd


r2bc3	movi	do_robo_air_grab,a7
	jruc	restricted_xfer


robo2_hk_close
	movi	p1b3|p1b4,a0
	movi	p2b3|p2b4,a1
	callr	button_bit_check	; requirement #1: hk and lk closed
	jrnc	death

	callr	get_his_p_hit
	cmpi	2,a0
	jrge	death			; dont over do it !

	calla	get_his_action
	cmpi	act_caught_net,a1
	jreq	death

	movi	do_bomb_full,a14
	movi	p1b3|p1b4,a0
	movi	p2b3|p2b4,a1
	movi	scom_bomb_full,a11
	callr	stick_look_lr
	jrc	r2bomb			; no

	movi	do_bomb_mid,a14
	movi	p1b3|p1b4,a0
	movi	p2b3|p2b4,a1
	movi	scom_bomb_mid,a11
	callr	stick_look_lr
	jrnc	death			; no

r2bomb	clr	a6			; xfer offset
	move	a14,a7
	callr	check_tsl
	.long	l_lk			; last time low kick was pressed
	.word	010H			; enough ticks gone by ?
	jruc	death


robo_lp_close
	movi	p1b1,a0   		; player 1 legal buttons
	movi	p2b1,a1   		; player 2 legal buttons
	movi	scom_robo_zap1,a11
	callr	stick_look_lr
	jrnc	r1lpc3			; no

	movi	(pid_p2rocket2*010000H)|pid_p1rocket2,a0
	callr	p1p2_pick
	clr	a1
	not	a1
	calla	existp
	jrne	death

	movi	do_robo_zap,a7
	jruc	restricted_xfer

r1lpc3	jruc	death

	movi	do_fatality_1,a7
	movi	0007000a0H,a0
	jruc	fatality_xfer_range


robo_hp_close
	movi	p1b0,a0   		; player 1 legal buttons
	movi	p2b0,a1   		; player 2 legal buttons
	movi	scom_robo_zap2,a11
	callr	stick_look_lr
	jrnc	death			; no

	movi	(pid_p2rocket1*010000H)|pid_p1rocket1,a0
	callr	p1p2_pick
	clr	a1
	not	a1
	calla	existp
	jrne	death

	movi	do_robo_zap2,a7
	jruc	restricted_xfer


robo1_down_close
	movi	sm_robo1_dc,a14
	jruc	secret_move_search

robo1_up
	movi	sm_robo1_uc,a14
	jruc	secret_move_search



robo1_lk_close
	movi	p1b4,a0   		; player 1 legal buttons
	movi	p2b4,a1   		; player 2 legal buttons
	movi	scom_robo_tele,a11
	callr	stick_look_lr
	jrnc	death			; no

	callr	get_his_p_hit
	cmpi	2,a0
	jrge	death			; dont over do it !

	calla	get_his_action
	cmpi	act_robo_teled,a1
	jreq	death			; not again and again !!!

	movi	do_robo_tele,a7
	jruc	airborn_xfer

robo2_lk_close
	movi	p1b4,a0   		; player 1 legal buttons
	movi	p2b4,a1   		; player 2 legal buttons
	movi	scom_robo_net,a11
	callr	stick_look_lr
	jrnc	death			; no

	callr	get_his_p_hit
	cmpi	3,a0
	jrge	death			; dont over do it !

	calla	get_his_action
	cmpi	act_caught_net,a1
	jreq	death			; no "double netting" allowed

	clr	a6
	movi	do_robo_net,a7
	callr	check_tsl
	.long	l_net			; last time low kick was pressed
	.word	040H			; time requirements
	jruc	death

**************************************************************************

check_tsl
	pull	a5			; a5 = return address
	move	*a5+,a0,l		; a0 = "lram"
	move	*a5+,a3,w		; a3 = time frame allowed
	calla	get_tsl			; a1 = time that has actually passed
	cmp	a3,a1
	jrhi	check_yes		; cool ----> do the move
	jump	a5			; not cool ---> return from subroutine

check_yes
	cmpi	x_lastone,a6
	jrls	cht6
	clr	a6			; default = ground xfer
cht6	sll	5,a6
	addi	xfer_types_table,a6
	move	*a6,a6,l
	jump	a6			; do the xfer

**************************************************************************
*											     *
*  button_bit_check - Checks if a specific pattern of buttons are being  *
*                     pressed.								     *
* 											     *
*  Input: a0 = player 1 requirements								*
*         a1 = player 2 requirements								*
*											     *
**************************************************************************
button_bit_check
	move	@p1_obj,a4,l
	cmp	a4,a8
	jreq	bbc3
	move	a1,a0  		; player 2 ---> use his requirements
bbc3	callr	buttons_in_a2
	cmp	a2,a0
	jrne	bbc_no
	setc
	rets
bbc_no	clrc
	rets

**************************************************************************
*											     *
*  illegal_button_check										*
*												*
*  tells us if any illegal buttons are being pushed					*
* 											     *
*  input: a8 = dude who wants 2 know							     *
*         a0 = player 1 "allowed" buttons							*
*         a1 = player 2 "allowed" buttons							*
* 											     *
*  returns: eq = no illegal buttons pressed / ok to do special move		*
*											     *
**************************************************************************
illegal_button_check
	callr	buttons_in_a2
	move	@p1_obj,a4,l
	cmp	a8,a4	    		; player 1 ??
	jreq	ibi4			; yes
	move	a1,a0			; no, use player 2 mask
ibi4	not	a0
	and	a0,a2			; mask off allowed switches
	move	a2,a2
	rets

**************************************************************************

buttons_in_a2
	move	@switch,a2,l
	not	a2
	movi	p1b0|p1b1|p1b2|p1b3|p1b4|p1b5,a3	; assume player 1 mask
	move	@p1_obj,a4,l
	cmp	a4,a8						; player 1 ??
	jreq	bit3						; yes
	movi	p2b0|p2b1|p2b2|p2b3|p2b4|p2b5,a3	; no, use player 2 mask
bit3	and	a3,a2						; look only at my buttons
	rets

**************************************************************************
*											     *
*  Stationary moves										*
*											     *
**************************************************************************
do_baby
	movk	018H,a0
	jruc	l_stat

do_roundhouse
	movk	017H,a0
	jruc	l_stat

do_uppercut
	movk	016H,a0
	jruc	l_stat

do_duck_kickl
	movk	015H,a0
	jruc	l_stat

do_duck_kickh
	movk	014H,a0
	jruc	l_stat

do_duck_punch
	movk	013H,a0
	jruc	l_stat

do_sweep_kick
	movk	012H,a0
	jruc	l_stat

do_lo_kick
	movi	011H,a0
	jruc	l_stat

do_hi_kick
	movi	010H,a0
	jruc	l_stat

do_kano_swipe
	movk	00aH,a0
	jruc	l_stat
do_leg_throw
	movk	009H,a0
	jruc	l_stat
do_inviso
	movk	008H,a0
	jruc	l_stat
do_quake
	movk	007H,a0
	jruc	l_stat
do_noogy
	movk	006H,a0
	jruc	l_stat
do_shake
	movk	005H,a0
	jruc	l_stat
do_reflect
	movk	004H,a0
	jruc	l_stat
do_fast_axe_up
	movk	003H,a0
	jruc	l_stat
do_axe_up
	movk	002H,a0
	jruc	l_stat
do_lia_scream
	movk	001H,a0
	jruc	l_stat
do_lao_spin
	clr	a0
l_stat	jauc	do_stationary

**************************************************************************
*											     *
*  Body Propell Moves									     *
*											     *
**************************************************************************
do_kano_roll
	clr 	a0
	jruc	local_do_body_propell
do_bike
	movk	1,a0
	jruc	local_do_body_propell
do_ind_charge
	movk	2,a0
	jruc	local_do_body_propell
jax_dash_punch
	movk	3,a0
	jruc	local_do_body_propell
do_sz_decoy
	movk	4,a0
	jruc	local_do_body_propell
do_lia_fly
	movk	5,a0
	jruc	local_do_body_propell
do_lao_tele
	movk	6,a0
	jruc	local_do_body_propell
do_hover_down
	movk	1,a10
	jruc	hov4
do_hover_left
	movk	2,a10
	jruc	hov4
do_hover_right
	movk	3,a10
hov4	movk	6,a0
	jruc	local_do_body_propell
do_lao_angle_kick
	movk	7,a0
	jruc	local_do_body_propell

do_smoke_tele
do_robo_tele
	movk	8,a0
	jruc	local_do_body_propell

do_robo_air_grab
	movk	9,a0
	jruc	local_do_body_propell

do_tele_explode
	movk	10,a0
	jruc	local_do_body_propell

do_square_wave
	movk	12,a0
	jruc	local_do_body_propell

lk_bike_kick
	movi	00dH,a0
	jruc	local_do_body_propell

do_super_kang
	movi	00eH,a0
	jruc	local_do_body_propell

do_sg_pounce
	movi	00fH,a0
	jruc	local_do_body_propell

do_slide
	movi	010H,a0
	jruc	local_do_body_propell

do_swat_zoom
	movi	011H,a0
	jruc	local_do_body_propell

do_stick_sweep
	movi	012H,a0
	jruc	local_do_body_propell

do_tusk_blur
	movi	013H,a0
	jruc	local_do_body_propell

do_sg_quake
	movi	014H,a0
	jruc	local_do_body_propell


local_do_body_propell
	jauc	do_body_propell

**************************************************************************
*											     *
*  Projectile Zaps									     *
*											     *
**************************************************************************

do_kano_zap
	clr	a0
	jruc	local_do_zap

do_sonya_zap
	movk	1,a0
	jruc	local_do_zap

do_jax_zap1
	movk	2,a0
	jruc	local_do_zap

do_jax_zap2
	movk	3,a0
	jruc	local_do_zap

do_ind_zap
	movk	4,a0
	jruc	local_do_zap

do_sky_ice_on
	movk	5,a0
	jruc	local_do_zap

do_sky_ice_behind
	movk	6,a0
	jruc	local_do_zap

do_sky_ice_front
	movk	7,a0
	jruc	local_do_zap

do_sw_zap
	movk	8,a0
	jruc	local_do_zap

do_robo_zap
	movk	9,a0
	jruc	local_do_zap

do_robo_zap2
	movk	10,a0
	jruc	local_do_zap

do_robo_net
	movk	11,a0
	jruc	local_do_zap

do_sz_forward_zap
	movi	12,a0
	jruc	local_do_zap

do_lia_anglez
	movk	13,a0
	jruc	local_do_zap

do_lao_zap
	movk	14,a0
	jruc	local_do_zap

do_bomb_full
	movk	15,a0
	jruc	local_do_zap

do_bomb_mid
	movk	16,a0
	jruc	local_do_zap

do_tusk_zap
	movi	011H,a0
	jruc	local_do_zap

do_summon
	movi	012H,a0
	jruc	local_do_zap

do_st_zap1
	movi	013H,a0
	jruc	local_do_zap
do_st_zap2
	movi	014H,a0
	jruc	local_do_zap
do_st_zap3
	movi	015H,a0
	jruc	local_do_zap

lk_zap_hi
	movi	016H,a0
	jruc	local_do_zap

lk_zap_lo
	movi	017H,a0
	jruc	local_do_zap

do_sg_zap
	movi	018H,a0
	jruc	local_do_zap

do_swat_bomb_hi
	movi	019H,a0
	jruc	local_do_zap

do_swat_bomb_lo
	movi	01aH,a0
	jruc	local_do_zap

do_lia_forward
	movi	01bH,a0
	jruc	local_do_zap

do_floor_blade
	movi	01cH,a0
	jruc	local_do_zap

do_smoke_spear
	movi	01eH,a0
	jruc	local_do_zap

local_do_zap
	jauc	do_zap

**************************************************************************
*											     *
*   standard moves									     *
*											     *
**************************************************************************
do_unblock_hi
	clr	a1
	move	a1,*a13(p_action),w
	movk	00cH,a9
	calla	find_ani_last_frame
	subi	32,a9			; a9 ---> block frame 2
	move	a9,a10
	subi	32,a10			; a10 ---> block frame 1

	calla	do_next_a9_frame
	sleep	4
	move	a10,a9
	calla	do_next_a9_frame
	sleep	4
	retp


do_block_hi
	calla	stop_me
	movk	00cH,a9
	calla	get_char_ani
	movk	3,a0
	movi	act_blockhi,a1
	jauc	act_mframew 		; block stance !


turn_around
	movk	3,a9
turn5	calla	stop_me
	calla	disable_all_buttons
	calla	get_char_ani

	movi	ta_speeds,a0
	calla	get_char_long		; get my speed to animate
	move	a0,a10
	jsrp	mframew	     		; "turn around"

	move	a10,a0
	srl	16,a0
	jreq	turn9
	calla	prcslp

turn9	retp


duck_turnaround
	movk	5,a9
	calla	get_char_ani
	movk	2,a0
	jauc	mframew

*
* "turn around" speeds
*
ta_speeds
	.word	2,0	; 0 - kano
	.word	2,0	; 1
	.word	2,0	; 2
	.word	2,0	; 3
	.word	2,0	; 4
	.word	2,0	; 5
	.word	2,0	; 6
	.word	2,0	; 7
	.word	2,0	; 8
	.word	2,0	; 9
	.word	2,0	; 10
	.word	2,0	; 11
	.word	2,0	; 12
	.word	2,0	; 13
	.word	2,0	;
	.word	2,0	; 15 - motaro
	.word	2,0	; 16 - shao kahn
	.word	2,0	; 17 - noob
	.word	2,0	; 18 - 

;************************************************************

up_grav	.set	08000H

do_jumpup_punch
	movi	act_juppunch,a0
	move	a0,*a13(p_action),w

	calla	face_opponent
	clr	a0
	calla	group_sound
	calla	rsnd_whoosh

	movk	9,a0			; strike table offset
	move	a0,*a13(p_stk),w
	movk	15,a1			; # of strike checks
	movk	3,a2			; animation speed
	movi	018H,a9
	jruc	jk6


do_jumpup_kick
	movi	act_jupkick,a0
	move	a0,*a13(p_action),w

	calla	face_opponent
	clr	a0
	calla	group_sound
	calla	rsnd_whoosh

	movi	00aH,a0			; strike table offset
	move	a0,*a13(p_stk),w
	movk	16,a1			; # of strike frames
	movk	3,a2			; animation speed
	movi	017H,a9

jk6	movi	up_grav,a3
	movk	pow_flipkp,a4
	jsrp	air_strike
	jrnc	jk9

	movi	act_hitfall_sd,a0
	move	a0,*a13(p_action),w	; action: falling to ground !
	move	*a8(oyvel),a11,l
	move	*a8(ograv),a10,l
	clr	a0
	move	a0,*a8(ograv),l
	move	a0,*a8(oyvel),l		; stop in mid air
	sleep	8
	move	a11,*a8(oyvel),l
	move	a10,*a8(ograv),l

	addi	32,a9			; a9 ---> jump kick finish animation
	clr	a1			; dont mess with vel !
	movk	3,a0

	clr	a3
	move	a3,*a13(p_store4),l	; no more routine callin'
	movi	0e000H,a3
	move	a3,*a8(ograv),l
	jsrp	flight_loop

jk9	jauc	jump_up_land_jsrp	; and retp



do_flip_kick
	calla	face_opponent
	calla	rsnd_whoosh
	clr	a0
	calla	group_sound

	movi	00bH,a0
	move	a0,*a13(p_stk),w
	movi	act_flykick,a0
	move	a0,*a13(p_action),w

	movi	00bH,a0			; stk table offset
	movk	16,a1			; # strike check frames
	movk	3,a2			; animation speed
	movi	019H,a9			; animation table offset
	movi	angle_grav,a3
	movk	pow_flipkp,a4
	jsrp	air_strike
	jrnc	jfk8
*
* wham !!!
*
	calla	me_in_front
	movi	act_fk_sd,a0
 	move	a0,*a13(p_action),w	; flag: i'm vulnerable

	movk	8,a0			; pause ticks
	jsrp	mid_air_pause

	movk	3,a0
	clr	a1			; dont mess with vel !
	move	a1,*a13(p_store4),l	; avoid double drone kicks
	movi	0c000H,a3
	move	a3,*a8(ograv),l
	jsrp	flight_loop

jfk8
;	movi	act_fk_sd,a0
;	move	a0,*a13(p_action),w	; flag: I'm not kicking anymoe !
	jauc	angle_jump_land_jsrp



do_flip_punch
	calla	face_opponent
	calla	rsnd_whoosh
	clr	a0
	calla	group_sound

	movi	00cH,a0
	move	a0,*a13(p_stk),w
	movi	act_flypunch,a0
	move	a0,*a13(p_action),w

	movi	00cH,a0			; stk table offset
	movk	16,a1			; # strike check frames
	movk	3,a2			; animation speed
	movi	018H,a9			; animation table offset
	movi	angle_grav,a3
	movk	pow_flipkp,a4
	jsrp	air_strike
	jrnc	jfp8
*
* pow !!
*
fly_punch_hit
	movk	8,a0
	jsrp	mid_air_pause

	movi	act_fk_sd,a0
	move	a0,*a13(p_action),w	; flag: I'm not kicking anymoe !
	clr	a1			; dont mess with vel !
	move	a1,*a13(p_store4),l	; avoid double drone kicks

	movk	3,a0
	clr	a1			; dont mess with vel !
	movi	0c000H,a3
	move	a3,*a8(ograv),l
	jsrp	flight_loop

jfp8	movi	act_fk_sd,a0
	move	a0,*a13(p_action),w	; flag: I'm not kicking anymoe !
	jauc	angle_jump_land_jsrp


**************************************************************************
*											     *
*  air_strike - routine for making a strike animation while in the air   *
* 											     *
*  input:  a0 = strike stk table offset						     *
*          a1 = number of frames to check for a strike			     *
*          a2 = animation speed									*
*          a3 = gravity										*
*          a4 = power level which I CAN NOT handle	 				*
* 	  a9 = animation table offset						     *
* 											     *
*  carry set: contact was made !!!							     *
*											     *
**************************************************************************
air_strike
	move	a3,*a8(ograv),l		; set yer gravity
	move	a1,*a13(p_store1),w	; save # of strike check frames
	move	a4,*a13(p_store2),w	; save power level

	move	a0,a11			; stk offset
	move	a2,a0
	calla	init_anirate
	calla	get_char_ani		; a9 = animation table

as2	sleep	1
	calla	next_anirate
	move	*a9,a0,l		; strike frame ??
	jrne	as3			; no

	move	*a13(p_store2),a4,w	; power level I can take on !!
	move	*a13(p_otherproc),a0,l
	movb	*a0(p_power),a0
	cmp	a0,a4
	jrle	as5			; too much for me = no collision check

	move	a11,a0
	calla	strike_check_a0		; wham ?
	jrc	as6			; yes
as5	move	*a13(p_store1),a0,w
	dec	a0
	move	a0,*a13(p_store1),w	; no, count this attempt !!
	jreq	as7			; out of tries ---> we outta here
	
as3	move	*a8(oyvel),a0,l
	jrn	as2			; heading upwards = loop

	move	*a8(oypos),a2,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	cmp	a0,a2			; am i on the ground ?
	jrlt	as2			; no...loop

	calla	stop_me
	calla	ground_player		; landed ---> attack failed !!
	jruc	as8
*
* strike successful
*
as6	setc				; signal: wham !
as9	retp

*
* strike failed / land on the ground
*
as7	addi	32,a9			; a9 = 2nd part of animation
	clr	a0
	move	a0,*a13(p_store4),l	; drones ---> dont try to kick again
	jsrp	flight_loop
as8	clrc
	jruc	as9


**************************************************************************
*											     *
*  mid_air_pause - pause a dude (a8) in the air for a0 ticks		     *
*											     *
**************************************************************************
mid_air_pause
	push	a0
	calla	stop_me
	pull	a0			; sleep time
	calla	prcslp
	retp


;*************************************************************************
; sample
;	movi	030000H,a0		; initial x vel
;	movi	-060000H,a1		; initial y vel
;	movi	08000H,a2		; grav
;	movk	4,a3			; ani speed
;	movk	1,a9			; ani offset
;	jsrp	flight

**************************************************************************
*											     *
*  flight routines for people to fly with given:				     *
* 											     *
*  input: a0 = initial x velocity							     *
*         a1 = initial y velocity							     *
*         a2 = gravity to use								     *
*         a3 = animation speed (sleep ticks)						*
*         a9 = animation offset to use 							*
*											     *
**************************************************************************
flight
	clr	a6

flight_call
	push	a3
	cmpi	dont_touch,a1		; set y vel ?
	jreq	flgt2			; no, dont touch !!
	move	a1,*a8(oyvel),l		; yes, do it
flgt2	cmpi	dont_touch,a2		; modify gravity ?
	jreq	flgt3			; sans, dont touch
	move	a2,*a8(ograv),l		; yes, set gravity
flgt3
	cmpi	dont_touch,a0
	jreq	flgt6
	calla	away_x_vel
*
* setup animation (a9)
*
flgt6	move	a9,a9
	jrn	flgt5			; neg a9 = animation already setup
	movi	get_char_ani,a0
	move	a9,a1
	zext	a9,w
	srl	16,a1			; ani 2 ??
	jreq	flgt4			; no
	movi	get_char_ani2,a0
flgt4	call	a0			; get char ani #?
flgt5	pull	a0			; pull ani speed
	cmpi	dont_touch,a0		; animation speed ?
	jreq	flgt8			; dont touch !!

	calla	init_anirate		; set things up to animate

flgt8	move	a6,*a13(p_store4),l	; routine to call every tick !!

*
* check if starting underground
*
	move	*a8(oypos),a1,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	cmp	a0,a1			; starting below ground level ?
	jrlt	flight_loop		; no, we are ok

	move	a0,*a8(oypos),w		; yes, start at ground level !!

flight_loop
	sleep	1
	move	*a13(p_store4),a6,l	; routine to call 
	jreq	flgt7			; none ---> skip o
	push	a10
	call	a6
	pull	a10

flgt7	calla	next_anirate
	move	*a8(oypos),a1,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	cmp	a0,a1			; hit ground yet ?
	jrlt	flight_loop 		; no, keep falling

	clr	a0
	move	a0,*a8(ograv),l		; no gravity
	calla	stop_me			; and stop me !
	calla	ground_player
	retp

**************************************************************************
*											     *
*  away_x_vel - left or right velocity   						     *
* 											     *
*  input: a0 = speed desired								     *
*											     *
**************************************************************************
away_x_vel
	calla	is_he_right
	janc	set_x_vel
      	neg	a0
	jauc	set_x_vel

towards_x_vel
	calla	is_he_right
	jac	set_x_vel
      	neg	a0
	jauc	set_x_vel

*
* a0 = closest / furthest
*
fatality_xfer_range
	move	a0,a1
	srl	16,a0		; a0 = closest
	zext	a1,w		; a1 = furthest

	calla	get_x_dist
	cmp	a1,a3
	jrhi	death
	cmp	a0,a3
	jrlo	death
	jruc	fatality_xfer

fatality_xfer_close
	calla	get_x_dist
	cmp	a1,a3
	jrhi	death			; too far away


close_animality_xfer
	calla	get_x_dist
	cmpi	050H,a3
	jrhi	death

animality_xfer
	move	@f_mercy,a5,w

	.if ejbbug
	jruc	fatality_xfer		; skip only on debug
	.endif

;	jreq	q_no
	jreq	death			; rev2.1 change (fix)

fatality_xfer
	move	@f_no_violence,a0,w
	jrne	death			; sorry, this is not allowed
	move	@f_no_blood,a0,w
	jrne	death			; sorry, this is not allowed

babality_xfer
friendship_xfer
mercy_xfer
	move	@winner_status,a0,w
	cmpi	3,a0
	jrne	death			; only during "finish him" mode

	move	@f_death,a0,w
	jrne	death			; only 1 fatality at a time

	calla	is_he_airborn
	jrc	death			; not while he is in the air

	move	*a13(p_otherproc),a0,l
	move	*a0(pwake),a0,l
	cmpi	dizzy_wake,a0		; he in dizzy move ?
	jrne	death			; no, no fatality

	jruc	restricted_xfer


restricted_xfer
	push	a13
	move	*a13(p_store4),a13,l	; trickery here, i'm pretending im his proc
	calla	am_i_airborn
	pull	a13
	jrc	death			; airborn = no xfer

airborn_xfer
	move	*a13(p_store4),a0,l
	move	*a0(p_flags),a4,w
	andi	pm_reacting|pm_special|pm_sitduck,a4
	jrne	death			; not allowed !!

free_xfer
	calla	get_my_strength		; a0 = my strength
	move	a0,a0
	jreq	death			; no power left = no move allowed

	move	*a13(p_store4),a0,l
	calla	fastxfer

	movi	reaction_exit,a7
	move	*a0(psptr),a1,l		; grab proc stack pointer
	move	a7,-*a1,l		; return address = reaction_exit
	move	a1,*a0(psptr),l		; and stuff back in

death	die


is_my_proj_alive
	movi	(pid_proj1*010000H)+pid_proj2,a0
	calla	p1p2_pick
	clr	a1
	not	a1
	calla	existp
	jrne	impay
	clrc
	rets
impay	setc
	rets

**************************************************************************
*											     *
*  stick_look_lr - routine to look and see if a certain joystick combo   *
*                  was made.								     *
* 											     *
*  input:  a0 = player 1 legal buttons						     *
*          a1 = player 2 legal buttons						     *
*         a11 = combo table								     *
* 											     *
*         p_store4 = dude in question's proc					     *
*											     *
**************************************************************************
;button_look_lr
;	push	a8
;	move	*a11+,a9,w		; a9 = time frame allowed
;	callr	get_bcq_next_pointer	; a7 = next queue entry pointer
;	jruc	combo4

stick_look_lr
	push	a8
	callr	illegal_button_check
	jrne	combono			; other buttons pressed ---> NO !!!

	move	*a11+,a9,w		; a9 = time frame allowed
	jreq	comboyes
	push	a13
	move	*a13(p_store4),a13,l
	calla	is_he_right
	pull	a13			; trickery !!

	pushst
;*****************
	move	*a11,a7,w
	cmpi	sw_up,a7
	jrge	combo3			; greater than "RUN" = stick
	callr	get_bcq_next_pointer	; "RUN" or less = button
	jruc	combo6
;*****************

combo3	callr	get_jcq_next_pointer	; a7 = next queue entry pointer
combo6	popst
	jrc	combo4			; use "face-right" combo
	addi	16*6,a11		; use "face-left" combo

combo4	move	@tick,a10,w

combo5	move	*a11+,a8,w		; get a switch state from table
	jreq	combo7			; zero ---> done
	callr	previous_q_entry	; a0 = previous [switch,time]
	sll	16,a8
	cmpxy	a8,a0 			; match ?
	jryeq	combo5			; yes, loop

combono	pull	a8
	clrc
	rets

combo7	zext	a0,w			; a0 = time only
	sub	a0,a10			; a10 = ticks since we started
	cmp	a9,a10
	jrhi	combono			; too much time !!

comboyes
	pull	a8
	setc
	rets

**************************************************************************
*											     *
*  previous_q_entry									     *
* 											     *
*  Input: a6 = top of queue we are talking about				     *
* 											     *
*  Returns: a0 = previous entry (from a7)						     *
*											     *
**************************************************************************
previous_q_entry
	subi	32,a7			; a7 = last entry made !!
	cmp	a6,a7			; are we at the top ?
	jrhi	back4			; no, we are cool
	addi	32*sqs,a7		; yes, a7 ---> bottom of queue
back4	move	*a7,a0,l		; a0 = [switch,time]
	rets

**************************************************************************
*											     *
* get_jcq_next_pointer										*
* 											     *
*    input: a8 = player object								     *
*  returns: a7 = pointer to next queue entry						*
*											     *
**************************************************************************
get_bcq_next_pointer
	movi	p1_bcq,a7
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	gjq4
	movi	p2_bcq,a7
	jruc	gjq4

get_jcq_next_pointer
	movi	p1_jcq,a7
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	gjq4
	movi	p2_jcq,a7
gjq4	move	a7,a6	  	; a6 = top of queue we are inspecting
	move	*a7,a7,l	; a7 = next available spot
	rets


does_p1p2_exist
	calla	p1p2_pick  	; a0 = correct pid
	clr	a1
	not	a1
	calla	existp
	jrne	dpey
	clrc
	rets
dpey	setc
	rets


do_st_2_kano
	clr	a9
	jruc	shang_morph

do_st_2_sonya
	movk	ft_sonya,a9
	jruc	shang_morph

do_st_2_jax
	movk	ft_jax,a9
	jruc	shang_morph

do_st_2_ind
	movk	ft_indian,a9
	jruc	shang_morph

do_st_2_sz
	movk	ft_subzero,a9
	jruc	shang_morph

do_st_2_swat
	movk	ft_swat,a9
	jruc	shang_morph

do_st_2_lia
	movk	ft_lia,a9
	jruc	shang_morph

do_st_2_robo1
	movk	ft_robo1,a9
	jruc	shang_morph

do_st_2_robo2
	movk	ft_robo2,a9
	jruc	shang_morph

do_st_2_lao
	movk	ft_lao,a9
	jruc	shang_morph

do_st_2_tusk
	movk	ft_tusk,a9
	jruc	shang_morph

do_st_2_sg
	movk	ft_sg,a9
	jruc	shang_morph

do_st_2_lk
	movk	ft_lk,a9
	jruc	shang_morph


*
* a0 = ochar of dude to turn into
*
shang_morph
	movi	act_morph,a1
	callr	init_special_act
	calla	stop_me

	movk	4,a0	
	calla	ochar_sound		; morph sound

	pushp	a9
	calla	get_char_ani2			; get animation
	calla	set_no_block			; no blocking while morphing

smorph2	movk	4,a0
	jsrp	mframew
	pullp	a9
	move	a9,*a8(ochar),w
	calla	ground_ochar				; new ground position
	calla	ochar_bank_bit

	move	*a8(oypos),*a13(p_ganiy),w    	; new grounded y pos

;	move	*a13(p_otherguy),a1,l
;	move	*a8(ochar),a0,w
;	move	*a1(ochar),a1,w
;	cmp	a0,a1		    		; are we the same person now ?
;	jrne	smorph4		    		; no
;	
;	move	*a13(p_otherguy),a0,l	
;	move	*a0(oflags2),a0,w
;	btst	b_ugly_pal,a0			; yes, he using ugly pal ?
;	jrne	smorph4				; yes...we are fine with original
;
;	move	*a8(oflags2),a4,w
;	push	a4
;	ori	m_ugly_pal,a4
;	move	a4,*a8(oflags2),w		; trick next routine
;	calla	player_normpal			; switch to ugly pal
;	pull	a4
;	move	a4,*a8(oflags2),w		; restore original pal state
;	jruc	smorph5
;smorph4

	calla	player_normpal			; new normal palette

;smorph5
	clr	a9
	calla	get_char_ani			; stance ani
	calla	do_next_a9_frame		; pose = stance #1 frame
	movi	l_morph,a0
	calla	update_tsl    			; mark this point
	retp

**************************************************************************
*											     *
*  init_special - set things up before doing a special move !!		     *
*											     *
**************************************************************************
air_init_special
	calla	stop_me
	jruc	isp2

init_special_act
	move	a1,*a13(p_action),w	; define my action !!

init_special
	calla	stop_me
	calla	ground_player

isp2	calla	face_opponent
	calla	set_no_block		; i can't block !!
	calla	me_in_front
	calla	player_normpal		; keep raiden at correct pal

	move	*a13(p_flags),a4,w
	ori	pm_special,a4
	move	a4,*a13(p_flags),w	; flag: i am doing a special move
	jauc	disable_all_buttons

*
*   Input: a0 = LONGWORD p1p2 ram
* Returns: a0 = WORD p1p2 ram
*
getram_p1p2
	move	*a8(oid),a1,w
	cmpi	oid_p1,a1
	jreq	grp9
	addi	16,a0
grp9	rets

*
*   Input: a0 = LONGWORD p1p2 ram
*          a1 = value to stuff in
*
stuffram_p1p2
	move	*a8(oid),a1,w
	cmpi	oid_p1,a1
	jreq	srp9
	addi	16,a0
srp9	move	a1,*a0,w
	rets

**************************************************************************
*											     *
*  update_tsl_a1										     *
* 											     *
*    input: a1 = points to two 16 bit locations (p1-p2)			     *
*           a8 = dude who wants 2 know						     *
*											     *
**************************************************************************
;update_tsl_a1
;	move	*a8(oid),a14,w
;	cmpi	pid_p1,a14	; player 1 ??
;	jreq	usl1
;    	addk	16,a1		; no, point to player 2's tick ram
;usl1	move	@tick,a14,w
;	move	a14,*a1,w	; update this player's ram
;	rets

**************************************************************************
*											     *
*   Jumps and Landings	  								     *
*											     *
**************************************************************************
angle_jump_land_jsrp
	movi	act_land,a1
	move	a1,*a13(p_action),w	; action: landing on the ground
	calla	face_opponent
	tsound	018H			; feet gently landing on the ground

	movi	01aH,a9
	calla	get_char_ani

	callr	allow_moves
	calla	do_next_a9_frame
	sleep	3
	retp

land_on_yer_feet
	clr	a0	 		; a0 = initial x vel
	clr	a1	  		; a1 = initial y vel
	movi	08000H,a2		; a2 = gravity	
	movi	never_ani,a3 		; a3 = ani speed
	jsrp	flight

jump_up_land_jump
	jsrp	jump_up_land_jsrp
	jruc	reaction_exit

**************************************************************************
*											     *
*  do_jump_up - joy/drone jumpup routine					   	     *
* 											     *
*  input: a11 = routine to call everytick (zero for joydudes)		     *
*											     *
**************************************************************************
do_jump_up
	movk	1,a0
	calla	group_sound  	; group speech: jump "huh"
	movi	act_jumpup,a0
	move	a0,*a13(p_action),w
	movk	016H,a9			; animation offset
	calla	get_char_ani
	addi	32,a9			; start with frame 2
	move	a11,a6
	clr	a0			; initial x vel
  	movi	up_vel,a1		; initial y vel
	movi	up_grav,a2		; grav
	movk	4,a3			; animation speed
 	jsrp	flight_call

jump_up_land_jsrp
	movi	act_land,a1
	move	a1,*a13(p_action),w
	tsound	018H			; feet gently landing on the ground

	movi	016H,a9
	calla	get_char_ani		; land animation
	calla	am_i_joy
	janc	d_land

	callr	allow_moves
	move	a9,a10
	addi	32,a9
	calla	do_next_a9_frame
	sleep	3
	move	a10,a9
	calla	do_next_a9_frame
	sleep	3
	retp

allow_moves
	calla	enable_all_buttons
	jauc	back_to_normal	  	; back 2 reality

;*************************************************************************

scom_robo_zap1
	.word	020H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

scom_robo_zap2
	.word	016H		   	; time to do entire switch combo
	.word	sw_left
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	0

	.word	sw_right
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

scom_robo_net
	.word	020H		   	; time to do entire switch combo
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

scom_bomb_mid
	.word	018H		   	; time to do entire switch combo
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

scom_bomb_full
scom_robo_tele
	.word	018H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0


scom_robo2_tele
	.word	018H		   	; time to do entire switch combo
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0


scom_robo_air_grab
	.word	018H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0



scom_fly
	.word	028H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0


scom_lia_anglez
	.word	012H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0


scom_dash
	.word	010H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0


scom_jax_zap2
	.word	02aH		   	; time to do entire switch combo
	.word	sw_left
	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0


scom_jax_zap1
	.word	010H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

scom_bike
	.word	020H		   	; time to do entire switch combo
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0


scom_ind_charge
	.word	018H
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0


scom_sonya_zap
	.word	018H
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

scom_sky_zap_on
	.word	020H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

scom_sky_zap_behind
	.word	030H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0

scom_sky_zap_front
	.word	030H		   	; time to do entire switch combo
	.word	sw_left
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.word	sw_right
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0

scom_sw_zap
	.word	024H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0


scom_lao_teleport
	.word	010H
	.word	sw_up
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_up
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

scom_lao_angle_kick
	.word	020H		   	; time to do entire switch combo
	.word	sw_down
	.word	sw_up
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_down
	.word	sw_up
	.word	0
	.word	0
	.word	0
	.word	0


scom_lao_zap
	.word	018H
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

**************************************************************************
*											     *
*  Secret Move tables									     *
*											     *
**************************************************************************
sm_smoke_lkc
	.long	p1b4     		; player 1 requirements
	.long	p2b4      		; player 2 requirements
	.word	x_airborn
	.long	q_smoke_tele		; yes/no routine
	.long	do_smoke_tele		; address of secret move
	.word	018H
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b4
	.long	p2b4
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	020H
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	0			; NEEDED !!


q_smoke_tele
	callr	get_his_p_hit
	cmpi	2,a0
	jrge	q_no			; dont over do it !
	calla	get_his_action
	cmpi	act_robo_teled,a1
	jreq	q_no    			; not again and again !!!
	jruc	q_yes



sm_smoke_uc
	.long	p1b2|p1b5     		; player 1 requirements
	.long	p2b2|p2b5      		; player 2 requirements
	.word	x_fatal
	.long	q_eatit_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	030H
	.word	sw_up
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	sw_up
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0

	.long	0			; NEEDED !!



sm_smoke_dc
	.long	p1b2|p1b5     		; player 1 requirements
	.long	p2b2|p2b5      		; player 2 requirements
	.word	x_fatal
	.long	q_earth_fatal		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	030H
	.word	sw_down
	.word	sw_right
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	sw_down
	.word	sw_left
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0

	.long	0			; NEEDED !!


sm_smoke_hkc
	.long	p1b3	     		; player 1 requirements
	.long	p2b3	      		; player 2 requirements
	.word	x_friend
	.long	q_smoke_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_hi_kick
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	sw_hi_kick
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0

	.long	p1b3
	.long	p2b3
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0

	.long	0



sm_smoke_bc
	.long	p1b2	     	; player 1 requirements
	.long	p2b2	     	; player 2 requirements
	.word	x_animal
	.long	q_smoke_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0


sm_smoke_lpc
	.long	p1b1     	; player 1 requirements
	.long	p2b1     	; player 2 requirements
	.word	x_ground
	.long	q_spear_ok	; yes/no routine
	.long	do_smoke_spear 	; address of secret move
	.word	014H
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0

q_spear_ok
	calla	get_his_action
	cmpi	act_speared_sd,a1
	jreq	q_no
	jruc	q_yes


sm_smoke_rc
	.long	p1b5|p1b2     	; player 1 requirements
	.long	p2b5|p2b2     	; player 2 requirements
	.word	x_ground
	.long	0		; yes/no routine
	.long	do_inviso 	; address of secret move
	.word	028H
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0
	.word	0

	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0

**************************************************************************
*											     *
*     Kano										     *
*											     *
**************************************************************************
sm_kano_hpc
	.long	p1b0|p1b4      	; player 1 requirements
	.long	p2b0|p2b4      	; player 2 requirements
	.word	x_ground
	.long	0		; yes/no routine
	.long	do_kano_swipe 	; address of secret move
	.word	018H
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b0|p1b4      	; player 1 requirements
	.long	p2b0|p2b4      	; player 2 requirements
	.word	x_ground
	.long	0		; yes/no routine
	.long	do_kano_zap 	; address of secret move
	.word	018H
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0


sm_kano_lpo
	.long	p1b1			; player 1 requirements
	.long	p2b1			; player 2 requirements
	.word	x_fatal
	.long	q_skel_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move

	.word	030H
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0

	.long	0


sm_kano_lkc
	.long	p1b4
	.long	p2b4
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	p1b2|p1b4
	.long	p2b2|p2b4
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0

	.long	0


sm_kano_hpo
	.long	p1b0	     	; player 1 requirements
	.long	p2b0	     	; player 2 requirements
	.word	x_animal
	.long	q_kano_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	028H
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	0
	.word	0
	.word	0
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	0
	.word	0
	.word	0

	.long	0


*
* Sektor !!
*
sm_robo2_uc
	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	0

sm_robo1_dc
	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_friend
	.long	q_dinger_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0

	.long	p1b5
	.long	p2b5
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	020H
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	0



sm_robo1_uc
	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_animal
	.long	q_close_animal		; yes/no routine
	.long	do_animality		; address of secret move
	.word	028H		   	; time to do entire switch combo
	.word	sw_up
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_up
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	0


sm_robo_hkc
	.long	p1b3
	.long	p2b3
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0

	.long	0



sm_robo_bc
	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_fatal
	.long	q_robo_flame_fatal	; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_fatal
	.long	q_robo_crush_fatal	; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	028H
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	sw_lo_punch
	.word	0
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	sw_lo_punch
	.word	0
	.word	0

	.long	0

*
* Cyrax
*
sm_robo2_hpc
	.long	p1b0|p1b2     		; player 1 requirements
	.long	p2b0|p2b2      		; player 2 requirements
	.word	x_fatal
	.long	q_fatality_req		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_up
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	sw_down
	.word	sw_up
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0

	.long	p1b0
	.long	p2b0
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	0


sm_robo2_dc
	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_animal
	.long	q_close_animal		; yes/no routine
	.long	do_animality		; address of secret move
	.word	028H		   	; time to do entire switch combo
	.word	sw_down
	.word	sw_down
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0

	.long	0


sm_robo2_rc
	.long	p1b5
	.long	p2b5
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	012H
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	p1b5|p1b2     		; player 1 requirements
	.long	p2b5|p2b2      		; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	028H
	.word	sw_up
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	sw_up
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0

	.long	0

;********************************************

sm_lia_uc
	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0

	.long	p1b2
	.long	p2b2
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	0


sm_lia_hpc
	.long	p1b0	     		; player 1 requirements
	.long	p2b0	      		; player 2 requirements
	.word	x_ground
	.long	q_lia_scream		; yes/no routine
	.long	do_lia_scream		; address of secret move
	.word	020H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	p1b0	     		; player 1 requirements
	.long	p2b0	      		; player 2 requirements
	.word	x_animal
	.long	q_animal_req		; yes/no routine
	.long	do_animality		; address of secret move
	.word	02aH		   	; time to do entire switch combo
	.word	sw_up
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_up
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	0

q_lia_scream
	callr	get_his_p_hit
	cmpi	3,a0
	jrge	q_no			; dont over do it !

	calla	q_is_he_a_boss
	jrc	q_no			; oh yeah, this is fair!
	jruc	q_yes

;********************************************

sm_lia_bc
	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_fatal
	.long	q_lia_hair_fatal	; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	030H
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	0

	.long	p1b2|p1b5     		; player 1 requirements
	.long	p2b2|p2b5      		; player 2 requirements
	.word	x_fatal
	.long	q_scream_fatal		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	030H
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0

	.long	0


sm_lia_lpc
	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_lia_forward		; address of secret move
	.word	018H
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b1
	.long	p2b1
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	020H
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0


*
* Subzero
* 
sm_sz_rc
	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_fatal
	.long	q_half_screen_fatal	; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0

	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	028H
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_block
	.word	0
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_block
	.word	0

	.long	0


sm_sz_uc
	.long	p1b2|p1b5	    	; player 1 requirements
	.long	p2b2|p2b5	    	; player 2 requirements
	.word	x_animal
	.long	q_close_animal		; yes/no routine
	.long	do_animality 		; address of secret move
	.word	028H
	.word	sw_up
	.word	sw_up
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_up
	.word	sw_up
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0
	.word	0

	.long	0


sm_sz_lpc
	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_airborn
	.long	q_sz_decoy		; yes/no routine
	.long	do_sz_decoy		; address of secret move
	.word	014H		   	; time to do entire switch combo
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_ground
	.long	q_sz_forward_zap	; yes/no routine
	.long	do_sz_forward_zap	; address of secret move
	.word	014H		   	; time to do entire switch combo
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0

q_sz_decoy
	movi	l_sz_decoy,a0
	calla	get_tsl
	cmpi	040H*4,a1
	jrlo	q_no			; too soon since last time
	calla	get_his_action
	cmpi	act_frozen,a1
	jreq	q_no
	jruc	q_yes


q_sz_forward_zap
	callr	get_his_p_hit
	cmpi	2,a0
	jrge	q_no			; dont over do it !

	movi	pid_decoy1*010000H+pid_decoy2,a0
	calla	p1p2_pick
	clr	a1
	not	a1
	calla	existp
	jrne	q_no

	jruc	q_yes

;*************************

sm_sz_hkc
	.long	p1b3
	.long	p2b3
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0

	.long	p1b3
	.long	p2b3
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0

;****************************************************************


sm_ind_lpc
	.long	p1b1
	.long	p2b1
	.word	x_ground
	.long	0
	.long	do_ind_zap
	.word	018H
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b1
	.long	p2b1
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_right
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	sw_right
	.word	sw_left
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0

	.long	0


sm_ind_bc
	.long	p1b2
	.long	p2b2
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	018H
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	02aH
	.word	sw_right
	.word	sw_left
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	sw_left
	.word	sw_right
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0

	.long	0


sm_ind_dc
	.long	p1b2	     	; player 1 requirements
	.long	p2b2	     	; player 2 requirements
	.word	x_animal
	.long	q_close_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_friend
	.long	q_ind_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_hi_punch
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_hi_punch
	.word	0
	.word	0

	.long	0


sm_ind_hpo
	.long	p1b0	     		; player 1 requirements
	.long	p2b0	      		; player 2 requirements
	.word	x_fatal
	.long	q_ind_axe_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0

	.long	0


sm_ind_hpc
	.long	p1b0	     		; player 1 requirements
	.long	p2b0	      		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_axe_up		; address of secret move
scom_axe_up
	.word	018H
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0


sm_ind_hkc
	.long	p1b3	     		; player 1 requirements
	.long	p2b3	      		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_reflect		; address of secret move
	.word	020H
	.word	sw_left
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0

	.long	0			; NEEDED !!


sm_sonya_hpc
	.long	p1b0     		; player 1 requirements
	.long	p2b0      		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_square_wave		; address of secret move
	.word	018H
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b0	     		; player 1 requirements
	.long	p2b0	      		; player 2 requirements
	.word	x_fatal
	.long	q_pit_fatal		; yes/no routine
	.long	do_pit_fatality		; address of secret move
	.word	022H
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	0



sm_sonya_dc
	.long	p1b2|p1b5     	; player 1 requirements
	.long	p2b2|p2b5     	; player 2 requirements
	.word	x_fatal
	.long	q_bubble_fatal	; yes/no routine
	.long	do_fatality_2 	; address of secret move
	.word	030H
	.word	sw_down
	.word	sw_left
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	sw_down
	.word	sw_right
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0

	.long	0			; NEEDED !!


sm_sonya_rc
	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_friend
	.long	q_sonya_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_down
	.word	sw_left
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	sw_down
	.word	sw_right
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0

	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_fatal
	.long	q_fatality_req		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_down
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0

	.long	0


sm_sonya_lpo
	.long	p1b1	     	; player 1 requirements
	.long	p2b1	     	; player 2 requirements
	.word	x_animal
	.long	q_close_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0

	.long	0



sm_sonya_lkc
	.long	p1b4
	.long	p2b4
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0		; NEEDED !!


sm_jax_lpc
	.long	p1b1|p1b4
	.long	p2b1|p1b4
	.word	x_ground
	.long   0			; yes/no routine
	.long	do_noogy
	.word	018H
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b1
	.long	p2b1
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0


sm_jax_lkc
	.long	p1b4	     	; player 1 requirements
	.long	p2b4     	; player 2 requirements
	.word	x_fatal
	.long	q_grow_fatal	; yes/no routine
	.long	do_fatality_2 	; address of secret move
	.word	030H
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0

	.long	p1b4
	.long	p2b4
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	p1b4			; player 1 requirements
	.long	p2b4			; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	02aH
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0

	.long	0


sm_jax_bo
	.long	p1b2	     	; player 1 requirements
	.long	p2b2	     	; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal	; yes/no routine
	.long	do_fatality_1 	; address of secret move
	.word	028H
	.word	sw_up
	.word	sw_right
	.word	sw_down
	.word	sw_up
	.word	0
	.word	0
	.word	sw_up
	.word	sw_left
	.word	sw_down
	.word	sw_up
	.word	0
	.word	0

	.long	0


sm_jax_lpo
	.long	p1b1	     	; player 1 requirements
	.long	p2b1	     	; player 2 requirements
	.word	x_animal
	.long	q_close_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	0
*
* Swat
*
sm_sw_bc
	.long	p1b2|p1b5     		; player 1 requirements
	.long	p2b2|p2b5      		; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	030H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0

	.long	p1b2	     	; player 1 requirements
	.long	p2b2	     	; player 2 requirements
	.word	x_animal
	.long	q_swat_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	028H
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0

	.long	0


sm_sw_lkc
	.long	p1b4	     		; player 1 requirements
	.long	p2b4	      		; player 2 requirements
	.word	x_fatal

	.long	q_taser_fatal		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	01fH
	.word	sw_right
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	p1b4	     		; player 1 requirements
	.long	p2b4	      		; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	030H
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_lo_punch
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_lo_punch
	.word	sw_run
	.word	0
	.word	0

	.long	0			; NEEDED !!


sm_swat_hkc
	.long	p1b2|p1b3      		; player 1 requirements
	.long	p2b2|p2b3      		; player 2 requirements
	.word	x_ground
	.long	0	     		; yes/no routine
	.long	do_swat_zoom		; address of secret move
	.word	01fH
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b3|p1b2
	.long	p2b3|p2b2
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_up
	.word	sw_up
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_up
	.word	sw_up
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	0			; NEEDED !!


sm_swat_lpc
	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_ground
	.long	0	     		; yes/no routine
	.long	do_swat_bomb_lo		; address of secret move
	.word	010H
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_ground
	.long	0	     		; yes/no routine
	.long	do_stick_sweep		; address of secret move
	.word	010H
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_friend
	.long	q_friend     		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	028H
	.word	sw_lo_punch
	.word	sw_run
	.word	sw_run
	.word	sw_lo_punch
	.word	0
	.word	0
	.word	sw_lo_punch
	.word	sw_run
	.word	sw_run
	.word	sw_lo_punch
	.word	0
	.word	0

	.long	0			; NEEDED !!


sm_swat_hpc
	.long	p1b0				; player 1 requirements
	.long	p2b0		 		; player 2 requirements
	.word	x_ground
	.long	0				; yes/no routine
	.long	do_swat_bomb_hi			; address of secret move
	.word	010H
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b0
	.long	p2b0
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0

	.long	0			; NEEDED !!

*
* Sheeva
*
sm_sg_bc
	.long	p1b2		    	; player 1 requirements
	.long	p2b2	     		; player 2 requirements
	.word	x_animal
	.long	q_close_animal		; yes/no routine
	.long	do_animality 		; address of secret move
	.word	028H
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0

	.long	0			; NEEDED !!


sm_sg_hko
	.long	p1b3	     		; player 1 requirements
	.long	p2b3	      		; player 2 requirements
	.word	x_fatal
	.long	q_sherip_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0

	.long	0


sm_sg_lpc
	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0

	.long	p1b1
	.long	p2b1
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0

	.long	0


sm_sg_hkc
	.long	p1b3	     		; player 1 requirements
	.long	p2b3	      		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_sg_quake		; address of secret move
	.word	01aH
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	0

	.long	p1b3
	.long	p2b3
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0

	.long	0


sm_sg_hpc
	.long	p1b0				; player 1 requirements
	.long	p2b0		 		; player 2 requirements
	.word	x_ground
	.long	0				; yes/no routine
	.long	do_sg_zap			; address of secret move
	.word	010H
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b0			; player 1 requirements
	.long	p2b0			; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	0			; NEEDED !!

sm_sg_uc
	.long	p1b0|p1b1|p1b2|p1b3|p1b4		; player 1 requirements
	.long	p2b0|p2b1|p2b2|p2b3|p2b4 		; player 2 requirements
	.word	x_ground
	.long	q_pounce_ok_now				; yes/no routine
	.long	do_sg_pounce				; address of secret move
	.word	010H
	.word	sw_up
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_up
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0			; NEEDED !!

*
* Kung Lao
*
sm_lao_lkc
	.long	p1b4			; player 1 requirements
	.long	p2b4	 		; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	030H
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_lo_punch
	.word	sw_run
	.word	0
	.word	0
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_lo_punch
	.word	sw_run
	.word	0
	.word	0

	.long	p1b4
	.long	p2b4
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_lao_bc
	.long	p1b2		    	; player 1 requirements
	.long	p2b2	     		; player 2 requirements
	.word	x_animal
	.long	q_close_animal		; yes/no routine
	.long	do_animality 		; address of secret move
	.word	028H
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0

	.long	0			; NEEDED !!

sm_lao_hpc
	.long	p1b0           		; player 1 requirements
	.long	p2b0         	  	; player 2 requirements
	.word	x_fatal
	.long	q_lao_hat_fatal		; yes/no routine
	.long	do_fatality_2 		; address of secret move
	.word	030H
	.word	sw_down
	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_down
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	p1b0
	.long	p2b0
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0


sm_lao_dc
	.long	p1b0	     		; player 1 requirements
	.long	p2b0	      		; player 2 requirements
	.word	x_fatal
	.long	q_fatality_req		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	02aH
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0

	.long	0


sm_lao_rc
	.long	p1b5		; player 1 requirements
	.long	p2b5 		; player 2 requirements
	.word	x_ground
	.long	0		; yes/no routine
	.long	do_lao_spin	; address of secret move
	.word	010H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	0  			; NEEDED !!

*
* Liu Kang
*
sm_lk_dc
	.long	p1b2|p1b5		; player 1 requirements
	.long	p2b2|p2b5 		; player 2 requirements
	.word	x_friend
	.long	q_lk_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	020H
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_lk_uc
	.long	p1b2	     	; player 1 requirements
	.long	p2b2	     	; player 2 requirements
	.word	x_animal
	.long	q_lk_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	030H
	.word	sw_up
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_up
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0			; NEEDED !!



sm_lk_bc
	.long	p1b2|p1b5     		; player 1 requirements
	.long	p2b2|p2b5      		; player 2 requirements
	.word	x_fatal
	.long	q_lk_mk_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	030H
	.word	sw_up
	.word	sw_up
	.word	sw_down
	.word	sw_up
	.word	0
	.word	0
	.word	sw_up
	.word	sw_up
	.word	sw_down
	.word	sw_up
	.word	0
	.word	0

	.long	0


sm_lk_lkc
	.long	p1b4	     		; player 1 requirements
	.long	p2b4	      		; player 2 requirements
	.word	x_fatal
	.long	q_fatality_req		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	030H
	.word	sw_down
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	p1b4
	.long	p2b4
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_lo_kick
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0
	.word	sw_lo_kick
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0

	.long	0


sm_lk_hkc
	.long	p1b3|p1b4		; player 1 requirements
	.long	p2b3|p2b4 		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_super_kang		; address of secret move
	.word	01eH
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b3
	.long	p2b3
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	020H
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0


sm_lk_hpc
	.long	p1b0|p1b4		; player 1 requirements
	.long	p2b0|p2b4 		; player 2 requirements
	.word	x_airborn
	.long	0			; yes/no routine
	.long	lk_zap_hi		; address of secret move
	.word	01aH
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0


sm_lk_lko
	.long	p1b4			; player 1 requirements
	.long	p2b4 			; player 2 requirements
	.word	x_ground
	.long	q_bike_req		; yes/no routine
	.long	lk_bike_kick		; address of secret move
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0


sm_lk_lpc
	.long	p1b1|p1b4		; player 1 requirements
	.long	p2b1|p2b4		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	lk_zap_lo		; address of secret move
	.word	01aH
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0


*
* Shang Tsung
*
sm_st_hpo
	.long	p1b0	     	; player 1 requirements
	.long	p2b0	     	; player 2 requirements
	.word	x_animal
	.long	q_shang_animal	; yes/no routine
	.long	do_animality 	; address of secret move
	.word	022H
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	0

sm_st_lpo
	.long	p1b1	     		; player 1 requirements
	.long	p2b1	      		; player 2 requirements
	.word	x_fatal
	.long	q_st_spike_fatal	; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	030H
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0

	.long	p1b1|p1b2|p1b5 		; player 1 requirements
	.long	p2b1|p2b2|p2b5 		; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	030H
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0
	.word	sw_block
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_st_dc
	.long	p1b2			; player 1 requirements
	.long	p2b2			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_lk		; address of secret move
	.word	018H
	.word	sw_down
	.word	sw_right
	.word	sw_up
	.word	sw_left
	.word	0
	.word	0
	.word	sw_down
	.word	sw_left
	.word	sw_up
	.word	sw_right
	.word	0
	.word	0

	.long	p1b2			; player 1 requirements
	.long	p2b2			; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	028H
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0
	.word	0

	.long	0

sm_st_lko
	.long	p1b5			; player 1 requirements
	.long	p2b5			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_sg		; address of secret move
	.word	020H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	0


sm_st_rc
	.long	p1b5			; player 1 requirements
	.long	p2b5			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_lao		; address of secret move
	.word	020H
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	sw_run
	.word	sw_block
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0

	.long	p1b5			; player 1 requirements
	.long	p2b5			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_robo1		; address of secret move
	.word	020H
	.word	sw_left
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0

	.long	0



sm_st_hkc
	.long	p1b3			; player 1 requirements
	.long	p2b3			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_swat		; address of secret move
	.word	020H
	.word	sw_right
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	p1b3			; player 1 requirements
	.long	p2b3			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_tusk		; address of secret move
	.word	010H
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_lo_punch
	.word	0
	.word	0
	.word	0
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_lo_punch
	.word	0
	.word	0
	.word	0

	.long	0


sm_st_uc
	.long	p1b2			; player 1 requirements
	.long	p2b2			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_ind		; address of secret move
	.word	020H
	.word	sw_up
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0
	.word	sw_up
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0

	.long	0


sm_st_bc
	.long	p1b2			; player 1 requirements
	.long	p2b2			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_robo2		; address of secret move
	.word	013H
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	0
	.word	0
	.word	0
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	0
	.word	0
	.word	0

	.long	p1b2			; player 1 requirements
	.long	p2b2			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_kano		; address of secret move
	.word	008H
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0


sm_st_lpc
	.long	p1b1			; player 1 requirements
	.long	p2b1			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_jax		; address of secret move
	.word	01dH
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	p1b1|p1b2
	.long	p2b1|p2b2
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_up
	.word	sw_up
	.word	0
	.word	0
	.word	0

	.long	0


sm_st_hpc
	.long	p1b0			; player 1 requirements
	.long	p2b0			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_sz		; address of secret move
	.word	018H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	0
*
* shang tsung zap 1
*
	.long	p1b0			; player 1 requirements
	.long	p2b0			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_zap1		; address of secret move

	.word	024H
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0
*
* shang zap 2
*
	.long	p1b0			; player 1 requirements
	.long	p2b0			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_zap2		; address of secret move

	.word	028H
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
*
* shang zap 3
*
	.long	p1b0			; player 1 requirements
	.long	p2b0			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_zap3		; address of secret move

	.word	030H
	.word	sw_right
	.word	sw_right
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	sw_left
	.word	sw_left
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!

*
* Kabal (Tusk)
*
sm_tusk_hpo
	.long	p1b0			; player 1 requirements
	.long	p2b0			; player 2 requirements
	.word	x_close_animal
	.long	q_kabal_animal		; yes/no routine
	.long	do_animality		; address of secret move
	.word	028H
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0

	.long	0

q_kabal_animal
	movi	l_hp,a0
	calla	get_tsl			; a1 = time that has actually passed
	cmpi	040H,a1
	jrlo	q_no
	jruc	q_yes

;********************************************

sm_st_lkc
	.long	p1b4			; player 1 requirements
	.long	p2b4			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_st_2_lia		; address of secret move
	.word	018H
	.word	sw_left
	.word	sw_down
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_down
	.word	sw_right
	.word	0
	.word	0
	.word	0
*
* summon
*
	.long	p1b4			; player 1 requirements
	.long	p2b4			; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_summon		; address of secret move
	.word	028H
	.word	sw_left
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0

	.long	p1b4
	.long	p2b4
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_tusk_uc
	.long	p1b5			; player 1 requirements
	.long	p2b5			; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	038H
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	sw_run
	.word	0
	.word	0
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	sw_run
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_tusk_hkc
	.long	p1b3	     		; player 1 requirements
	.long	p2b3	      		; player 2 requirements
	.word	x_fatal
	.long	q_close_fatal		; yes/no routine
	.long	do_fatality_2		; address of secret move
	.word	030H
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_block
	.word	sw_block
	.word	sw_run
	.word	0

	.long	p1b3
	.long	p2b3
	.word	x_ground
	.long   q_pit_fatal		; yes/no routine
	.long	do_pit_fatality 	; address of secret move
	.word	018H
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_block
	.word	0
	.word	0
	.word	0
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_block
	.word	0
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_tusk_lkc
	.long	p1b4			; player 1 requirements
	.long	p2b4			; player 2 requirements
	.word	x_ground
	.long	q_blurred_req	 	; yes/no routine
	.long	do_tusk_blur		; address of secret move
	.word	012H
	.word	sw_right
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.long	p1b4
	.long	p2b4
	.word	x_baby
	.long	q_babality	; yes/no routine
	.long	do_baby 	; address of secret move
	.word	028H
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0
	.word	sw_lo_kick
	.word	sw_run
	.word	sw_run
	.word	0
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_tusk_bc
	.long	p1b2	     		; player 1 requirements
	.long	p2b2	      		; player 2 requirements
	.word	x_fatal
	.long	q_inflate_fatal		; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	030H
	.word	sw_right
	.word	sw_left
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0
	.word	sw_left
	.word	sw_right
	.word	sw_down
	.word	sw_down
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_tusk_rc
	.long	p1b5	     		; player 1 requirements
	.long	p2b5	      		; player 2 requirements
	.word	x_ground

	.long	q_floor_blade		; yes/no routine
	.long	do_floor_blade		; address of secret move
	.word	020H
	.word	sw_left
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


q_floor_blade
	clr	a1
	not	a1
	movi	pid_blade,a0
	calla	existp
	jrne	q_no			; blade out there = NO !!!

	clr	a1
	not	a1
	movi	pid_dead_blade,a0
	calla	existp
	jrne	q_no			; blade out there = NO !!!

	jruc	q_yes


sm_tusk_zap
	.long	p1b0			; player 1 requirements
	.long	p2b0			; player 2 requirements
	.word	x_airborn
	.long	0			; yes/no routine
	.long	do_tusk_zap		; address of secret move

	.word	018H
	.word	sw_left
	.word	sw_left
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_right
	.word	sw_right
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_kano_hkc
	.long	p1b3			; player 1 requirements
	.long	p2b3			; player 2 requirements
	.word	x_fatal
	.long	q_half_screen_fatal	; yes/no routine
	.long	do_fatality_1		; address of secret move
	.word	028H
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_block
	.word	sw_lo_punch
	.word	0
	.word	0
	.word	sw_hi_kick
	.word	sw_block
	.word	sw_block
	.word	sw_lo_punch
	.word	0
	.word	0

	.long	p1b3			; player 1 requirements
	.long	p2b3			; player 2 requirements
	.word	x_friend
	.long	q_friend		; yes/no routine
	.long	do_friendship		; address of secret move
	.word	028H
	.word	sw_hi_kick
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0
	.word	sw_hi_kick
	.word	sw_run
	.word	sw_run
	.word	sw_lo_kick
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!


sm_kano_lpc
	.long	p1b1|p1b4		; player 1 requirements
	.long	p2b1|p2b4		; player 2 requirements
	.word	x_ground
	.long	0			; yes/no routine
	.long	do_shake		; address of secret move

	.word	018H
	.word	sw_right
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0
	.word	sw_left
	.word	sw_down
	.word	0
	.word	0
	.word	0
	.word	0

	.long	0			; ENDING ZERO NEEDED HERE !!!!

;***************************************************************************
;***************************************************************************

search_again
	addi	(32*4)+(16*14),a14	; a14 ---> next entry

secret_move_search
	move	*a14,a0,l		; player 1 button requirements
	jreq	secret9			; zero ---> we are done
	move	*a14(32),a1,l		; player 2 button requirements
	move	a14,a11
	addi	32+32+16+32+32,a11	; a11 ----> switch combo table
	callr	stick_look_lr 		; switch combo made ??
	jrnc	search_again

	move	*a14(32+32+16),a7,l
	jreq	sms5
	push	a14
	call	a7
	pull	a14
	jrnc	secret9	    		; carry clear = failure

sms5	move	*a14(32+32+16+32),a7,l	; grab address of secret move
	move	*a14(32+32),a0,w
	sll	5,a0
	addi	xfer_types_table,a0
	move	*a0,a0,l
	jump	a0			; xfer

secret9	die


x_ground		.set	0
x_airborn	.set	1
x_fatal		.set	2
x_mercy		.set	3
x_animal		.set	4
x_close_animal	.set	5
x_friend		.set	6
x_baby		.set	7
x_lastone	.set	x_baby

xfer_types_table
	.long	restricted_xfer		; 0 - on the ground (very restricting)
	.long	airborn_xfer		; 1 - in the air allowed
	.long	fatality_xfer		; 2 - fatality xfer
	.long	mercy_xfer		; 3 - mercy
	.long	animality_xfer		; 4 - animality
	.long	close_animality_xfer	; 5 - close animality
	.long	friendship_xfer		; 6 - friendship xfer
	.long	babality_xfer		; 7 -


get_his_p_hit
	move	*a13(p_otherproc),a0,l
	move	*a0(p_hit),a0,w
	rets

q_eatit_fatal
	movi	p1b2|p1b5,a0		; player 1 requirement
	movi	p2b2|p2b5,a1		; player 2 requirement
	callr	button_bit_check
	jrnc	q_no
	movi	070H,a5
	movi	0a0H,a6
	jruc	q_fatal_dist


q_bubble_fatal
	movi	p1b2|p1b5,a0		; player 1 requirement
	movi	p2b2|p2b5,a1		; player 2 requirement
	callr	button_bit_check
	jrnc	q_no

q_earth_fatal
	movi	0d0H,a5
	movi	0140H,a6
	jruc	q_fatal_dist


q_st_spike_fatal
	movi	l_lp,a0
	calla	get_tsl   		; get dis event !!
	cmpi	040H,a1
	jrlo	q_no
	calla	q_am_i_cornered
	jrc	q_no			; not if I is cornered
	jruc	q_close_fatal		

q_lk_mk_fatal
	movi	p1b2|p1b5,a0		; player 1 requirement
	movi	p2b2|p2b5,a1		; player 2 requirement
	callr	button_bit_check
	jrnc	q_no
	jruc	q_fatality_req

q_pit_fatal
	move	@curback,a0,w
	jreq	qpit3			; subway = ok !
	cmpi	7,a0
	jreq	qpit3			; bell tower = ok !
	cmpi	10,a0
	jrne	q_no			; only on da pit !!

qpit3	calla	is_he_facing_me
	jrnc	q_no
	jruc	q_close_fatal

q_inflate_fatal
	calla	q_is_he_cornered
	jrc	q_no
	movi	060H,a5
	movi	0e0H,a6
	jruc	q_fatal_dist

q_robo_crush_fatal
	movi	060H,a5
	movi	090H,a6
	jruc	q_fatal_dist

q_robo_flame_fatal
	movi	0c0H,a5
	movi	0100H,a6
	jruc	q_fatal_dist

q_taser_fatal
	movi	0100H,a5
	movi	0130H,a6
	jruc	q_fatal_dist

q_swat_animal
	movi	058H,a5
	movi	078H,a6
	jruc	q_animal_dist

q_lao_hat_fatal
	movi	020H,a5
	movi	070H,a6
	jruc	q_fatal_dist

q_scream_fatal
	movi	p1b2|p1b5,a0		; player 1 requirement
	movi	p2b2|p2b5,a1		; player 2 requirement
	callr	button_bit_check
	jrnc	q_no
	jruc	q_close_fatal


q_lia_hair_fatal
	movi	050H,a5
	movi	090H,a6
	jruc	q_fatal_dist

q_grow_fatal
	movi	0d0H,a5
	movi	0140H,a6
	jruc	q_fatal_dist


q_kano_animal
	movi	l_hp,a0
	calla	get_tsl   		; get dis event !!
	cmpi	040H,a1
	jrlo	q_no
	jruc	q_close_animal

q_close_animal
	move	@f_mercy,a5,w
	.if ejbbug
	jruc	q_close_fatal		; skip only on debug
	.endif
	jreq	q_no


q_sherip_fatal
	movi	l_hk,a0
	calla	get_tsl   		; get dis event !!
	cmpi	040H,a1
	jrlo	q_no
	jruc	q_close_fatal


q_skel_fatal
	movi	l_lp,a0
	calla	get_tsl   		; get dis event !!
	cmpi	040H,a1
	jrlo	q_no
	jruc	q_close_fatal

q_close_fatal
	movi	020H,a5
	movi	050H,a6
	jruc	q_fatal_dist

q_ind_axe_fatal
	movi	l_lk,a0
	calla	get_tsl
	cmpi	040H,a1
	jrlo	q_no			; too soon since last time

	movi	0a0H,a5
	movi	0e0H,a6
	jruc	q_fatal_dist

q_half_screen_fatal
	movi	080H,a5
	movi	0b0H,a6
	jruc	q_fatal_dist

q_lk_animal
	movi	058H,a5
	movi	090H,a6
	jruc	q_animal_dist

q_smoke_animal
	movi	0a0H,a5
	movi	0150H,a6
	jruc	q_animal_dist

q_shang_animal
	movi	l_hp,a0
	calla	get_tsl   		; get dis event !!
	cmpi	040H,a1
	jrlo	q_no

	movi	070H,a5
	movi	0a0H,a6
	jruc	q_animal_dist

q_animal_dist
	calla	get_x_dist
	cmp	a5,a3
	jrlo	q_no
	cmp	a6,a3
	jrhi	q_no
	jruc	q_animal_req

q_fatal_dist
	calla	get_x_dist
	cmp	a5,a3
	jrlo	q_no
	cmp	a6,a3
	jrhi	q_no
	jruc	q_fatality_req

q_mercy_req
	callr	is_master_in_finish
	jrnc	q_no
	move	@f_mercy,a0,w
	jrne	q_no				; only 1 mercy / round
	calla	get_x_dist
	cmpi	0a0H,a3
	jrlo	q_no

	move	@p1_matchw,a0,w
	jreq	q_no
	move	@p2_matchw,a0,w
	jreq	q_no				; each must have at least 1 win

	movi	l_run,a0
	calla	get_tsl
	cmpi	030H,a1
	jrlo	q_no				; you must "charge" run button !!

	jruc	q_fatality_req


q_dinger_friend
	calla	get_x_dist
	cmpi	0c0H,a3
	jrlo	q_no
	jruc	q_friend

q_smoke_friend
	calla	get_x_dist
	cmpi	0d0H,a3
	jrlo	q_no
	jruc	q_friend

q_ind_friend
	calla	get_x_dist
	cmpi	0a0H,a3
	jrlo	q_no
	jruc	q_friend

q_sonya_friend
	calla	is_stick_down
	jrnc	q_no
	jruc	q_friend

q_lk_friend
	movi	p1b5,a0				; player 1 requirement
	movi	p2b5,a1				; player 2 requirement
	callr	button_bit_check
	jrnc	q_no
	jruc	q_friend

q_friend
q_babality
	movi	l_block,a0
	move	*a8(oid),a1,w
	cmpi	oid_p1,a1
	jreq	qbab3
	addk	16,a0			; player 2 area !!
qbab3	move	*a0,a0,w
	jrne	q_no

	jruc	q_fatality_req


q_animal_req
	move	@f_mercy,a5,w
	.if ejbbug
	jruc	q_fatality_req
	.endif
	jreq	q_no			; must do a mercy 1st !!!

q_fatality_req
	move	@winner_status,a4,w
	cmpi	3,a4
	jrne	q_no	      	 		; only during "finish him" mode
	jruc	q_yes


q_blurred_req
	move	*a13(p_otherproc),a0,l
	move	*a0(p_hit),a0,w
	cmpi	1,a0
	jrhi	q_no
	calla	get_his_action

	cmpi	act_fk_sd,a1
	jreq	q_no			; retract from flip kick = no !
	cmpi	act_ret_kick,a1
	jreq	q_no			; retract from kick = no !
	cmpi	act_blurred,a1
	jreq	q_no			; already blured
	cmpi	act_sweep_sd,a1
	jreq	q_no			; not sfter a sweep

;************
	calla	get_x_dist
	cmpi	0a0H,a3
	jrhi	q_yes
	movi	act_sweep,a1
	jreq	q_no			; not during sweep
;************

	jruc	q_yes


q_pounce_ok_now
	calla	get_his_action
	cmpi	act_reacting,a1
	jreq	q_no
	jruc	q_yes

q_bike_req
	movi	l_lk,a0
	calla	get_tsl
	cmpi	040H*2,a1
	jrlo	q_no			; too soon since last time
	jruc	q_yes

q_yes	setc
	rets

q_no	clrc

local_rets
	rets

is_master_in_finish
	clr	a1
	not	a1
	movi	pid_master,a0
	calla	existp				; master proc ?
	jreq	q_no				; no, show no mercy says KI !!
	move	*a0(pwake),a7,l
	cmpi	fatality_waiting,a7
	jrne	q_no				; we must be in "finish him" mode !!
	jruc	q_yes

do_mercy
	callr	is_master_in_finish
	janc	victory_animation		; bummer !!
	movi	master_proc_mercy,a7
	calla	fastxfer			; master ---> start over again
	movk	3,a0
	move	a0,@winner_status,w		; otherguy ---> stay dizzy
	movk	1,a1
	move	a1,@f_mercy,w			; flag: mercy
	jauc	mercy_start			; wait for round 2 start

;***********************************************************************

	.end

