**************************************************************************
*											     *
*  video game project:	mortal kombat 3							*
* 											     *
*  game software:    	ed boon									*
* 											     *
*  module: attract mode									     *
* 											     *
*  copyright (c) 1995 Midway Manufacturing							*
*											     *
**************************************************************************
	.file	'mkmark.asm'
	.title	" <<< mortal kombat code >>> "

	.width	132
	.option	b,d,l
	.mnolist
*
* get the system stuff
*
	.include	dispequ.asm		; display processor equates
	.include	sysequ.asm		; sys.inc and gsp.inc
	.include	macros.hdr		; macros
	.include	mainequ.asm
	.include	imgtbl.glo
	.include	bgndtbl.glo
	.include	dipequ.asm
	.include	stringh.asm
	.include	mkdef.tbl
	.include	mkkent.tbl

	.even
	.text

	.bss	player_1_ships,16
	.bss	player_1_ship,32
	.bss	player_1_missile,32
	.bss	player_1_missile2,32
	.bss	player_1_missile3,32
	.bss	player_1_missile4,32
	.bss	player_1_bstate,16

	.bss	player_2_ships,16
	.bss	player_2_ship,32
	.bss	player_2_missile,32
	.bss	player_2_missile2,32
	.bss	player_2_missile3,32
	.bss	player_2_missile4,32
	.bss	player_2_bstate,16

	.bss	wave_x_position,16
	.bss	wave_y_position,16
	.bss	wave_x_velocity,16
	.bss	wave_y_velocity,16
	.bss	dive_randper,16
	.bss	shoot_randper,16
	.bss	count_left,16
	.bss	last_star,32
	.bss	ok_exit,16

hidden_game
	movi	gs_space_game,a0
	move	a0,@gstate,w

	calla	amode_init_no_score
	calla	page_0_zip_setup
	calla	clr_scrn

	movi	green_grad_pal,a0
	jsrp	do_the_grad_thang
	movi	txt_space_game_intro,a8
	movi	>005000c8,a9
	jsrp	pds_centered

	movi	>45,a3
	calla	send_code_a3

	calla	display_on
	calla	view_page_0
	movi	>40*5,a10
	jsrp	fadein_jsrp
*
* start the game
*
	movi	>25,a3
	calla	send_code_a3

	calla	murder_myoinit_score
	movi	dlists_bogus,a0
	move	a0,@dlists,l
	movi	pid_pong_speed,a1
	movi	make_stars,a7
	calla	getprc
	movi	44,a0
	move	a0,@count_left,w
	clr	a0
	move	a0,@irqskye,w
	move	a0,@p1_button,l
	move	a0,@p2_button,l
	move	a0,@p1_state,w
	move	a0,@p2_state,w

	move	a0,@ok_exit,w
	move	a0,@player_1_missile,l
	move	a0,@player_1_missile2,l
	move	a0,@player_1_missile3,l
	move	a0,@player_1_missile4,l
	move	a0,@player_2_missile,l
	move	a0,@player_2_missile2,l
	move	a0,@player_2_missile3,l
	move	a0,@player_2_missile4,l
	move	a0,@player_1_bstate,l
	move	a0,@player_2_bstate,l
	move	a0,@wave_x_position,w
	movi	40,a0
	move	a0,@wave_y_position,w
	movi	6,a0
	move	a0,@dive_randper,w
	move	a0,@shoot_randper,w
	callr	create_player_ships
	callr	create_enemy_dispatchers
	movi	60*60/2,a10
hg1x	movk	3,a11
hg1	mmtm	sp,a10,a11
	callr	move_player_ships
	callr	watch_buttons_or_missiles
	mmfm	sp,a10,a11
	sleep	1
	move	@ok_exit,a0,w
	jrnz	hgsh9
	dsjs	a11,hg1
	callr	animate_player_ships
	dsjs	a10,hg1x

	callr	game_over_d
	sleep	>40*3

hgsh9	calla	murder_myoinit_score
	movi	dlists_bogus,a0
	move	a0,@dlists,l

	clr	a0
	move	a0,@f_nosound,w
	RETP

game_over_w
	create	pid_pong_speed,game_over_win_proc
	rets

game_over_win_proc
	calla	nosounds
	sleep	2
	tsound	>6d
	jruc	game_over_entry

game_over_d
	movi	pid_pong_speed,a3
	movi	gopr,a7
	jauc	getprc

gopr	calla	nosounds
	sleep	2
	tsound	>82

game_over_entry
	movk	1,a0
	move	a0,@f_nosound,w	 	; are we allowed ??
	sleep	>40*3
	callr	gameover
	die


gameover
	movk	1,a0
	move	a0,@ok_exit
	rets

animate_player_ships
	move	@player_1_ship,a8,l
	jrz	aps_2
	movi	ship1,a1
	move	*a8(oimg),a14,l
	cmp	a1,a14
	jrnz	aps11
	movi	ship2,a1
aps11	move	*a8(oflags),a4,w
	calla	ani
aps_2	move	@player_2_ship,a8,l
	jrz	aps_3
	movi	ship3,a1
	move	*a8(oimg),a14,l
	cmp	a1,a14
	jrnz	aps112
	movi	ship4,a1
aps112	move	*a8(oflags),a4,w
	calla	ani
aps_3	rets

create_player_ships
	movk	3,a0
	move	a0,@player_1_ships,w
	move	a0,@player_2_ships,w
	callr	create_player_1_ship
	;
create_player_2_ship
	movi	ship3,a5
	calla	gso_dmawnz_ns
	movi	>00e00140,a4
	calla	set_xy_coordinates
	move	a8,@player_2_ship,l
	jauc	insobja8
create_player_1_ship
	movi	ship1,a5
	calla	gso_dmawnz_ns
	movi	>00e00050,a4
	calla	set_xy_coordinates
	move	a8,@player_1_ship,l
	jauc	insobja8

move_player_ships
	callr	read_player_1_joystick
	sll	1,a0
	move	@player_1_ship,a8,l
	jrz	mps2
	callr	mpss1
mps2	callr	read_player_2_joystick
	sll	1,a0
	move	@player_2_ship,a8,l
	jrz	mps3
	callr	mpss1
mps3	rets

mpss1	move	*a8(oxpos),a14,w
	cmpi	5,a14
	jrgt	rmm1
	move	a0,a0
	jrnn	rmm1
	clr	a0
rmm1	cmpi	386,a14
	jrlt	rmm2
	move	a0,a0
	jrn	rmm2
	clr	a0
rmm2	move	a0,*a8(oxvel+>010),w
	rets

watch_buttons_or_missiles
	move	@player_1_missile,a0,l
	jrz	wbom1
	callr	wte1
	move	a0,@player_1_missile,l
wbom1	move	@player_1_missile2,a0,l
	jrz	wbom2
	callr	wte1
	move	a0,@player_1_missile2,l
wbom2	move	@player_2_missile,a0,l
	jrz	wbom3
	callr	wte1
	move	a0,@player_2_missile,l
wbom3	move	@player_2_missile2,a0,l
	jrz	wbom4
	callr	wte1
	move	a0,@player_2_missile2,l
wbom4	move	@player_1_missile3,a0,l
	jrz	wbom5
	callr	wte1
	move	a0,@player_1_missile3,l
wbom5	move	@player_1_missile4,a0,l
	jrz	wbom6
	callr	wte1
	move	a0,@player_1_missile4,l
wbom6	move	@player_2_missile3,a0,l
	jrz	wbom7
	callr	wte1
	move	a0,@player_2_missile3,l
wbom7	move	@player_2_missile4,a0,l
	jrz	wbom8
	callr	wte1
	move	a0,@player_2_missile4,l
wbom8	movi	player_1_missile,a2
	move	*a2,a0,l
	jrz	wp1s
	movi	player_1_missile2,a2
	move	*a2,a0,l
	jrz	wp1s
	movi	player_1_missile3,a2
	move	*a2,a0,l
	jrz	wp1s
	movi	player_1_missile4,a2
	move	*a2,a0,l
	jrnz	wp2r
wp1s	move	@player_1_ship,a14,l
	jrz	wp2r
	callr	read_player_1_button
	move	a0,a0
	jrz	wp1nb
	move	@player_1_bstate,a14,w
	jrnz	wp1nb
	callr	start_player_1_missile
	movk	1,a0
wp1nb	move	a0,@player_1_bstate,w
wp2r	move	@player_2_ship,a14,l
	jrz	wp3r
	movi	player_2_missile,a2
	move	*a2,a0,l
	jrz	wp2s
	movi	player_2_missile2,a2
	move	*a2,a0,l
	jrz	wp2s
	movi	player_2_missile3,a2
	move	*a2,a0,l
	jrz	wp2s
	movi	player_2_missile4,a2
	move	*a2,a0,l
	jrnz	wp3r
wp2s	callr	read_player_2_button
	move	a0,a0
	jrz	wp2nb
	move	@player_2_bstate,a14,w
	jrnz	wp2nb
	callr	start_player_2_missile
	movk	1,a0
wp2nb	move	a0,@player_2_bstate,w
wp3r	rets
wte1	move	*a0(oypos),a1,w
	jrp	wbom22
	calla	delobj
	clr	a0
wbom22	rets

start_enemy_missile
	mmtm	sp,a8
	move	a8,a9
	movi	bpal_red,a0
	movi	>00060002,a3
	calla	make_solid_object
	move	*a9(oypos),a14,w
	sll	16,a14
	move	*a9(oxpos),a4,w
	addk	4,a4
	movy	a14,a4
	calla	set_xy_coordinates
	calla	insobja8
	movk	2,a0
	move	a0,*a8(oyvel+>10),l
	movi	pid_pong_speed,a1
	movi	watch_enemy_missile,a7
	calla	getprc
	mmfm	sp,a8
	rets

watch_enemy_missile
wem1	move	*a8(oypos),a0,w
	cmpi	260,a0
	jrgt	wem9
	callr	are_we_hitting_player
	move	a0,a0
	jrz	wem2
	callr	kill_player
	jruc	wem9
wem2	SLEEP	1
	jruc	wem1
wem9	move	a8,a0
	calla	delobj
	jauc	sucide

start_player_1_missile
	tsound	>80

	movi	bpal_yellow,a0
	movi	>00060002,a3
	calla	make_solid_object
	move	@player_1_ship,a0,l
	callr	sp1m1
	move	a8,*a2,l
	rets

start_player_2_missile
	tsound	>80

	movi	bpal_yellow,a0
	movi	>00060002,a3
	calla	make_solid_object
	move	@player_2_ship,a0,l
	callr	sp1m1
	move	a8,*a2,l
	rets

sp1m1	move	*a0(oypos),a14,w
	sll	16,a14
	move	*a0(oxpos),a4,w
	addk	4,a4
	movy	a14,a4
	calla	set_xy_coordinates
	calla	insobja8
	movi	-5,a0
	move	a0,*a8(oyvel+>10),l
	rets

read_player_1_joystick
	clr	a0
	move	@switch,a14
	btst	2,a14
	jrnz	rpj1
	dec	a0
rpj1	btst	3,a14
	jrnz	rpj2
	inc	a0
rpj2	rets

read_player_2_joystick
	clr	a0
	move	@switch,a14
	btst	10,a14
	jrnz	rp2j1
	dec	a0
rp2j1	btst	11,a14
	jrnz	rp2j2
	inc	a0
rp2j2	rets

read_player_1_button
	clr	a0
	move	@switch,a14
	btst	4,a14
	jrnz	rpb19
	inc	a0
rpb19	rets

read_player_2_button
	clr	a0
	move	@switch,a14
	btst	12,a14
	jrnz	rpab19
	inc	a0
rpab19	rets

are_we_hitting_player	;output	a11 = bits of players hit
	clr	a11
	move	@player_1_ship,a9,l
	jrz	awn1
	callr	do_objects_collide
	jrnc	awn1
	addk	1,a11
awn1	move	@player_2_ship,a9,l
	jrz	awn2
	callr	do_objects_collide
	jrnc	awn2
	addk	2,a11
awn2	move	a11,a0
	rets

kill_player		;input a0 = bits of player to kill
	move	a0,a11
	btst	0,a11
	jrz	kp_p2

kp_p1
	push	a0
	tsound	>81				; player explode sound
	create	pid_fx,toast
	pull	a0

	move	@player_1_ship,a0,l
	jrz	kp_p2
	callr	kilj1
	move	a0,@player_1_ship,l
	move	@player_1_ships,a0,w
	dec	a0
	move	a0,@player_1_ships,w
	jrp	kp_rp1
	jruc	kp_p2
kp_rp1	movi	restart_player_1,a7
	movi	pid_pong_speed,a1
	calla	getprc
kp_p2	btst	1,a11
	jrz	kp_p3

	push	a0
	tsound	>81				; player explode sound
	create	pid_fx,toast
	pull	a0

	move	@player_2_ship,a0,l
	jrz	kp_p3
	callr	kilj1
	move	a0,@player_2_ship,l
	move	@player_2_ships,a0,w
	dec	a0
	move	a0,@player_2_ships,w
	jrp	kp_rp2
	jruc	kp_p3
kp_rp2	movi	restart_player_2,a7
	movi	pid_pong_speed,a1
	calla	getprc
kp_p3	move	@player_1_ships,a0,w
	jrz	game_over_d
	jrn	game_over_d
	move	@player_2_ships,a0,w
	jrz	game_over_d
	jrn	game_over_d
	rets

kilj1	move	*a0(oypos),a14,w
	sll	16,a14
	move	*a0(oxpos),a4,w
	movy	a14,a4
	callr	create_explosionb_a4
	calla	delobj
	clr	a0
	rets


toast
	sleep	>30
	tsound	>1b
	die


restart_player_1
	sleep	100
	callr	create_player_1_ship
	jauc	sucide

restart_player_2
	sleep	100
	callr	create_player_2_ship
	jauc	sucide

are_we_shot
;	input	a8 = us
;	output	cs = hit
;		cc = not hit
	callr	are_we_shot_by_p1
	jrc	aws9
	callr	are_we_shot_by_p2
aws9	rets

are_we_shot_by_p1
	movi	player_1_missile,a10
	callr	dooc
	jrc	aws19
	movi	player_1_missile2,a10
	callr	dooc
	jrc	aws19
	movi	player_1_missile3,a10
	callr	dooc
	jrc	aws19
	movi	player_1_missile4,a10
	callr	dooc
aws19	rets

dooc	move	*a10,a9,l
	jrz	dc9n
	callr	do_objects_collide
	jrnc	dc9n
	callr	awsp11
	clr	a0
	move	a0,*a10,l
	setc
	rets
dc9n	clrc
	rets

are_we_shot_by_p2
	movi	player_2_missile,a10
	callr	dooc
	jrc	bws19
	movi	player_2_missile2,a10
	callr	dooc
	jrc	bws19
	movi	player_2_missile3,a10
	callr	dooc
	jrc	bws19
	movi	player_2_missile4,a10
	callr	dooc
bws19	rets

awsp11	move	a9,a0
	move	*a8(oypos),a14,w
	sll	16,a14
	move	*a8(oxpos),a4,w
	movy	a14,a4
	callr	create_explosions_a4
	jauc	delobj

do_objects_collide
;	input	a8,a9 = objects
;	output	cs = hit
;		cc = not hit
	move	*a8(oxpos),a0,w
	move	*a8(oypos),a1,w
	move	*a8(osizex),a2,w
	move	*a8(osizey),a3,w
	add	a0,a2
	add	a1,a3
	dec	a2
	dec	a3
	move	*a9(oxpos),a4,w
	move	*a9(oypos),a5,w
	move	*a9(osizex),a6,w
	move	*a9(osizey),a7,w
	add	a4,a6
	add	a5,a7
	dec	a6
	dec	a7

	cmp	a0,a6
	jrlt	doc_n
	cmp	a1,a7
	jrlt	doc_n
	cmp	a4,a2
	jrlt	doc_n
	cmp	a5,a3
	jrlt	doc_n
doc_y	setc
	rets
doc_n	clrc
	rets

create_enemy_dispatchers
	callr	create_baiters
	movi	pid_pong_speed,a1
	movi	move_wave,a7
	calla	getprc
;	movi	pid_pong_speed,a1
;	movi	dispatch_grunts,a7
;	jauc	getprc
	rets

move_wave
mw1	sleep	2
	move	@wave_x_position,a14,w
	inc	a14
	move	a14,@wave_x_position,w
	cmpi	155,a14
	jrlt	mw1
	move	@dive_randper,a0,w
	addk	2,a0
	move	a0,@dive_randper,w
	move	@shoot_randper,a0,w
	addk	5,a0
	move	a0,@shoot_randper,w
	cmpi	25,a0
	jrlo	mw2
	addk	25,a0
	move	a0,@shoot_randper,w
	move	a0,@dive_randper,w
mw2	sleep	2
	move	@wave_x_position,a14,w
	dec	a14
	move	a14,@wave_x_position,w
	jrp	mw2
	jruc	mw1
follow_path_11
	movi	[1,0],a0
	movi	[1,0],a1
follow_path
	;a10 = address of path
	;a0 = scale factor for x speed
	;a1 = scale factor for y speed
	move	a0,*a13(p_store1),l
	move	a1,*a13(p_store2),l
fp_e0	move	*a10+,a0,l
	cmpi	[>0eac,>0eac],a0
	jrz	fpp9
	move	*a13(p_store1),a1,l
	callr	safe32mult
	move	a1,*a8(oxvel),l
	move	*a10+,a0,l
	move	*a13(p_store2),a1,l
	callr	safe32mult
	move	a1,*a8(oyvel),l
	move	*a10+,a11,w	;time
	move	*a10+,a9,w	;shot%
fp_e2
	move	*a8(oxpos),a14,w
	cmpi	-40,a14
	jrge	fer1
	movi	-40,a14
fer1	cmpi	440,a14
	jrle	fer2
	movi	440,a14
fer2	move	a14,*a8(oxpos),w

	sleep	1
	mmtm	sp,a9,a10,a11
	callr	are_we_shot
	jrc	fp_9d
	callr	are_we_hitting_player
	move	a0,a0
	jrz	fp_e3
	callr	kill_player
	jruc	fp_9d
fp_e3	mmfm	sp,a9,a10,a11
	move	a9,a0
	move	@shoot_randper,a14,w
	add	a14,a0
	calla	randper
	mmtm	sp,a9,a10,a11
	jrnc	fp_e4
	callr	start_enemy_missile
	callr	start_enemy_missile
fp_e4	mmfm	sp,a9,a10,a11
	dsj	a11,fp_e2
	jruc	fp_e0
fp_9d	mmfm	sp,a9,a10,a11
	move	a8,a0
	calla	delobj
	setc
	retp
fpp9	clrc
	retp

dispatch_grunts
cge_2	movk	1,a0
	calla	randu
	move	a0,a11
	movi	pid_pong_speed,a1
	movi	grunt_enemy,a7
cge_1	calla	getprc
	dsjs	a11,cge_1
	sleep	800
	jruc	cge_2


create_baiters
	movi	baiter_pos_list,a10
cb_1	movk	3,a0
;	calla	randu
;	sll	5,a0
;	addi	lglst-32,a0
;	move	*a0,a5,l
	move	*a10+,a0,w
	move	*a10+,a1,w
	jrn	cb_4
	move	*a10+,a5,l
	mmtm	sp,a0,a1,a10
	calla	gso_dmawnz_ns
	mmfm	sp,a0,a1,a10
	mmtm	sp,a0,a1,a10
	move	a0,*a8(ochar),w
	move	a1,*a8(ochar+>10),w
	move	@wave_x_position,a14,w
	add	a14,a0
	move	@wave_y_position,a14,w
	add	a14,a1
	sll	16,a1
	move	a1,a4
	movx	a0,a4
	calla	set_xy_coordinates
	calla	insobja8
	movi	pid_pong_speed,a1
	movi	baiter_enemy,a7
	calla	getprc
	mmfm	sp,a0,a1,a10
	jruc	cb_1
cb_4	rets

lglst	.long	BAITER1
	.long	LANDER1
	.long	ostrich1

baiter_pos_list
	.word	0,20
	.long	enemy3
	.word	15,20
	.long	enemy3
	.word	30,20
	.long	enemy3
	.word	45,20
	.long	enemy3
	.word	60,20
	.long	enemy3
	.word	75,20
	.long	enemy3
	.word	90,20
	.long	enemy3
	.word	105,20
	.long	enemy3
	.word	120,20
	.long	enemy3
	.word	135,20
	.long	enemy3
	.word	150,20
	.long	enemy3
	.word	165,20
	.long	enemy3
	.word	180,20
	.long	enemy3
	.word	195,20
	.long	enemy3

	.word	0,40
	.long	enemy9
	.word	15,40
	.long	enemy9
	.word	30,40
	.long	enemy9
	.word	45,40
	.long	enemy9
	.word	60,40
	.long	enemy9
	.word	75,40
	.long	enemy9
	.word	90,40
	.long	enemy9
	.word	105,40
	.long	enemy9
	.word	120,40
	.long	enemy9
	.word	135,40
	.long	enemy9
	.word	150,40
	.long	enemy9
	.word	165,40
	.long	enemy9
	.word	180,40
	.long	enemy9
	.word	195,40
	.long	enemy9

	.word	0,60
	.long	enemy5
	.word	15,60
	.long	enemy5
	.word	30,60
	.long	enemy5
	.word	45,60
	.long	enemy5
	.word	60,60
	.long	enemy5
	.word	75,60
	.long	enemy5
	.word	90,60
	.long	enemy5
	.word	105,60
	.long	enemy5
	.word	120,60
	.long	enemy5
	.word	135,60
	.long	enemy5
	.word	150,60
	.long	enemy5
	.word	165,60
	.long	enemy5
	.word	180,60
	.long	enemy5
	.word	195,60
	.long	enemy5

	.word	50,0
	.long	enemy1
	.word	150,0
	.long	enemy1
	.word	-1,-1

baiter_enemy
be_e1	move	*a8(ochar),a0,w
	move	@wave_x_position,a14,w
	add	a14,a0
	move	*a8(ochar+>10),a1,w
	move	@wave_y_position,a14,w
	add	a14,a1
	move	a0,*a8(oxpos),w
	move	a1,*a8(oypos),w
	sll	16,a1
	move	a1,a4
	movx	a0,a4
	calla	set_xy_coordinates
	move	@wave_x_velocity,a14,w
	move	a14,*a8(oxvel+>10),w
	move	@wave_y_velocity,a14,w
	move	a14,*a8(oyvel+>10),w
	callr	are_we_shot
	jrc	be_9d
	callr	are_we_hitting_player
	move	a0,a0
	jrz	be_e3
	callr	kill_player
	jruc	be_9d
be_e3	sleep	1
	move	@dive_randper,a0,w
	calla	randper
	jrnc	be_e1
	movi	be_pr,a10
	movi	[0,>2000],a0
	calla	srand
	addi	[1,>2000],a0
	move	a0,a1
	movi	[2,0],a0
	calla	srand
	jsrp	follow_path
	jrc	be_99
	movi	-5,a0
	move	a0,*a8(oypos),w
be_e5	move	*a8(ochar),a0
	move	@wave_x_position,a14,w
	add	a14,a0
	move	*a8(ochar+>10),a1
	move	@wave_y_position,a14,w
	add	a14,a1
	movi	2,a2
	callr	move_to_point
	cmpi	2,a4
	jrlt	be_e1
	sleep	1
	callr	are_we_shot
	jrc	be_9d
	callr	are_we_hitting_player
	move	a0,a0
	jrz	be_e4
	callr	kill_player
	jruc	be_9d
be_e4	jruc	be_e5

be_9d	calla	rsnd_enemy_boom
	move	a8,a0
	calla	delobj
be_99	move	@count_left,a0,w
	dec	a0
	move	a0,@count_left,w
	jrp	be_999
	callr	game_over_w
be_999	jauc	sucide

be_pr
	.long	>08000,>10000
	 .word	1,20
	.long	>10000,>10000
	 .word	1,20
	.long	>18000,>10000
	 .word	2,20
	.long	>20000,>10000
	 .word	2,20
	.long	>28000,>10000
	 .word	4,20
	.long	>30000,>10000
	 .word	4,20
	.long	>28000,>10000
	 .word	8,20
	.long	>20000,>10000
	 .word	8,20
	.long	>18000,>10000
	 .word	10,20
	.long	>10000,>10000
	 .word	10,20
	.long	>08000,>10000
	 .word	12,20
	.long	>00000,>10000
	 .word	12,20
	.long	->08000,>10000
	 .word	15,20
	.long	->10000,>10000
	 .word	15,20
	.long	->18000,>10000
	 .word	17,20
	.long	->20000,>10000
	 .word	17,20
	.long	->28000,>10000
	 .word	20,20
	.long	->30000,>10000
	 .word	20,20
	.long	->28000,>10000
	 .word	21,20
	.long	->20000,>10000
	 .word	21,20
	.long	->18000,>10000
	 .word	22,20
	.long	->10000,>10000
	 .word	22,20
	.long	>00000,>00000
	.word	1,20
	.long	[>0eac,>0eac]


;be_1
;	movi	be_pt1,a10
;	jsrp	follow_path_11
;	jrc	be_99
;	jruc	be_1
;be_99	jauc	sucide

be_pt1	.long	>030000,>e00
	 .word	45,0
	.long	->030000,>e00
	 .word	90,0
	.long	>030000,>e00
	 .word	45,0
	.long	[>0eac,>0eac]

move_to_point
;	input	a0 = x destination point
;		a1 = y destination point
;		a2 = maximum x and y velocities
;		a8 = object
;	output	a4 = distance from destination
;		a3 = trashed
	move	*a8(oxpos),a14,w
	sub	a0,a14
	neg	a14
	cmp	a14,a2
	jrge	mtp1
	move	a2,a14
mtp1	neg	a2
	cmp	a14,a2
	jrle	mtp2
	move	a2,a14
mtp2	neg	a2
	move	*a8(oxpos),a3,w
	add	a14,a3
	move	a3,*a8(oxpos),w
	move	a3,a4
	sub	a0,a4
	abs	a4
	move	*a8(oypos),a14,w
	sub	a1,a14
	neg	a14
	cmp	a14,a2
	jrge	mtp3
	move	a2,a14
mtp3	neg	a2
	cmp	a14,a2
	jrle	mtp4
	move	a2,a14
mtp4	neg	a2
	move	*a8(oypos),a3,w
	add	a14,a3
	move	a3,*a8(oypos),w
	sub	a1,a3
	abs	a3
	add	a3,a4
	rets

grunt_enemy
	movi	ostrich1,a5
	calla	gso_dmawnz_ns
	movi	400,a0
	calla	randu
	movi	[30,0],a4
	movx	a0,a4
	calla	set_xy_coordinates
	calla	insobja8
ge_23	movi	ge_pt1,a10
	jsrp	follow_path_11
	jrc	ge_99
	movi	ge_pt2,a10
	jsrp	follow_path_11
	jrc	ge_99
	movi	ge_pt3,a10
	jsrp	follow_path_11
	jrc	ge_99
	jruc	ge_23
ge_99	jauc	sucide

ge_pt1	.long	>030000,>e00
	 .word	45,50
	.long	[>0eac,>0eac]

ge_pt2	.long	->030000,>e00
	 .word	90,50
	.long	[>0eac,>0eac]

ge_pt3	.long	>030000,>e00
	 .word	45,50
	.long	[>0eac,>0eac]

safe32mult
	mmtm	sp,a0,a2
	sra	4,a0
	sra	4,a1
	mpys	a1,a0
	sll	16,a0
	move	a1,a2
	srl	16,a2
	movx	a2,a0
	sll	8,a0
	srl	8,a1
	movy	a0,a1
	mmfm	sp,a0,a2
	rets


create_explosionb_a4
	mmtm	sp,a0,a1,a7,a9
	movi	pid_pong_speed,a1
	movi	ce4b,a7
	move	a4,a9
	calla	getprc
	mmfm	sp,a0,a1,a7,a9
	rets

ce4b	movi	expld1,a5
	calla	gso_dmawnz_ns
	move	a9,a4
	addi	>50002,a4
	calla	set_xy_coordinates
	calla	insobja8
	sleep	2
	move	a9,a4
	calla	set_xy_coordinates
	movi	expld2,a1
	callr	ce4ss
	sleep	2
	movi	expld3,a1
	callr	ce4ss
	sleep	2
	movi	expld4,a1
	callr	ce4ss
	sleep	2
	movi	expld5,a1
	callr	ce4ss
	sleep	2
	move	a8,a0
	calla	delobj
	jauc	sucide

create_explosions_a4
	mmtm	sp,a0,a1,a7,a9
	movi	pid_pong_speed,a1
	movi	ce4s,a7
	move	a4,a9
	calla	getprc
	mmfm	sp,a0,a1,a7,a9
	rets

ce4s	movi	expld6,a5
	calla	gso_dmawnz_ns
	move	a9,a4
	calla	set_xy_coordinates
	calla	insobja8
	sleep	2
	movi	expld7,a1
	callr	ce4ss
	sleep	2
	movi	expld8,a1
	callr	ce4ss
	sleep	2
	move	a8,a0
	calla	delobj
	jauc	sucide

ce4ss	move	*a8(oflags),a4,w
	jauc	ani


create_explosion_a4
	mmtm	sp,a0,a1,a7,a9
	movi	pid_pong_speed,a1
	movi	ce4,a7
	move	a4,a9
	calla	getprc
	mmfm	sp,a0,a1,a7,a9
	rets
ce4	movk	10,a10
ce6	movk	10,a11
	movi	pid_pong_speed,a1
	movi	ce5,a7
	calla	getprc
	sleep	1
	dsjs	a10,ce6
	jauc	sucide
ce5	movi	bpal_white,a0
	movi	>00020002,a3
	calla	make_solid_object
	move	a9,a4
	calla	set_xy_coordinates
	movi	[1,>8000],a0
	calla	srand
	move	a0,*a8(oxvel),l
	movi	[1,>8000],a0
	calla	srand
	move	a0,*a8(oyvel),l
	calla	insobja8
	sleep	8
	move	a8,a0
	calla	delobj
	jauc	sucide

make_stars
	callr	makestar
	move	a8,@last_star,l
	clr	a0
	move	a0,*a8(oslink),l
amx2	movi	100,a4
amx1	mmtm	sp,a4
	callr	makestar
	mmfm	sp,a4
	move	@last_star,a0,l
	move	a0,*a8(oslink),l
	move	a8,@last_star,l
	dsj	a4,amx1
amx5	sleep	1
	move	@last_star,a8,l
amx4	move	*a8(oypos),a0,w
	cmpi	260,a0
	jrlt	amx3
	subi	270,a0
	move	a0,*a8(oypos),w
	movi	400,a0
	calla	randu
	dec	a0
	move	a0,*a8(oxpos),w
amx3	move	*a8(oslink),a8,l
	jrnz	amx4
	jruc	amx5

makestar
	movi	>00010001,a3
	movi	bpal_blue,a0
	calla	make_solid_object
	movi	-100,a0
	move	a0,*a8(ozpos),w
	movi	400,a0
	calla	randu
	dec	a0
	move	a0,*a8(oxpos),w
	move	a0,a1
	movi	254,a0
	calla	randu
	dec	a0
	move	a0,*a8(oypos),w
	calla	insobja8
	movi	[2,0],a0
	calla	randu
	addi	[2,0],a0
	move	a0,*a8(oyvel),l
	rets



green_grad_pal
	.word	32

	.word	31*32
	.word	30*32
	.word	29*32
	.word	28*32
	.word	27*32
	.word	26*32
	.word	25*32
	.word	24*32
	.word	23*32
	.word	22*32
	.word	21*32
	.word	20*32
	.word	19*32
	.word	18*32
	.word	17*32
	.word	16*32
	.word	15*32
	.word	14*32
	.word	13*32
	.word	12*32
	.word	11*32
	.word	10*32
	.word	9*32
	.word	8*32
	.word	7*32
	.word	6*32
	.word	5*32
	.word	4*32
	.word	3*32
	.word	2*32
	.word	1*32
	.word	0*32


txt_space_game_intro
	.string	"YOU HAVE BEEN TRANSPORTED\n"
	.string	"TO ANOTHER REALM\n\n"
	.string	"A REALM WHERE NEITHER THE EARTH WARRIORS\n"
	.string	"NOR SHAO KAHN HAVE ANY CONTROL\n\n"
	.string	"BEWARE THE REALM OF\n"
	.string	"RELLIM OHCANEP"
	.byte	0
	.even

;
;grunt_enemy
;	movk	4,a0
;	calla	randu
;	dec	a0
;	sll	5,a0
;	addi	shape_list,a0
;	move	*a0,a5,l
;	calla	gso_dmawnz_ns
;	movi	400,a0
;	calla	randu
;	move	a0,a4
;	calla	set_xy_coordinates
;	calla	insobja8
;ge_l2	movi	40,a0
;	calla	randu
;	move	a0,a10
;ge_l1	callr	are_we_shot
;	jrc	ge9d
;	callr	are_we_hitting_player
;	move	a0,a0
;	jrz	ge_l3
;	callr	kill_player
;	jruc	ge9d
;ge_l3	SLEEP	1
;	dsjs	a10,ge_l1
;	movi	200,a0
;	calla	randper
;	jrnc	ge_l4
;	callr	start_enemy_missile
;ge_l4	movk	8,a0
;	calla	randu
;	addk	4,a0
;	move	*a8(oypos),a14,w
;	add	a0,a14
;	move	a14,*a8(oypos),w
;	move	@player_1_ship,a9,l
;	jrz	ge_rx
;	movk	8,a0
;	calla	randu
;	move	*a9(oxpos),a2,w
;	move	*a8(oxpos),a1,w
;	sub	a1,a2
;	jrnn	ge_a3
;	neg	a0
;ge_a3	add	a0,a1
;	move	a1,*a8(oxpos),w
;	jruc	ge_a4
;ge_rx	movk	15,a0
;	calla	randu
;	subi	8,a0
;	move	*a8(oxpos),a1,w
;	jruc	ge_a3
;ge_a4	move	*a8(oypos),a0,w
;	cmpi	260,a0
;	jrlt	ge_l2
;ge9d	move	a8,a0
;	calla	delobj
;	die
;
;shape_list
;	.long	BAITER1
;	.long	PACMAN
;	.long	grunt_1
;	.long	ostrich1


