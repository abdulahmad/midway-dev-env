**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mksel.asm --- player select							*
* 											     *
*  copyright (c) 1995 williams electronics games, inc.			     *
*											     *
**************************************************************************
	.file	"mksel.asm"
	.width	132
	.option	b,d,l,t
	.mnolist
*
* get the system stuff
*
	.include	imgtbl.glo

	.include	dispequ.asm
	.include	sysequ.asm
	.include	macros.hdr
	.include	mainequ.asm
	.include	stringh.asm
	.include	diagaudn.asm

	.include	mksel.tbl
	.include	mksel2.tbl
	.include	mksel3.tbl

	.ref	get_aud

cthick	.set	4

x_size	.set	48
y_size	.set	59

mug1_x	.set	045H
mug1_y	.set	025H
x_space	.set	53
y_space	.set	65

s2_ochar		.set	2
s12_ochar	.set	12
s6_ochar		.set	6
s8_ochar		.set	8

	.text


join_in_during_psel
	tsound	03bH		; join in sound

	movi	ps_psel,a0
	move	a0,*a2,w  	; my player state = player select mode
	movi	pid_master,a0
	calla	exprc_er	; find central controller

	move	*a0(psptr),a3,l	; his stack pointer (return address)
	move	*a3,a4,l	; a4 = retp address

	movi	player_joinin,a7
	calla	fastxfer
	move	a3,*a0(psptr),l	; restore proc stack to spot we found it in
	move	a4,*a3,l	; and place it !
	die

**************************************************************************
*											     *
*  player_select - code to let the players choose who they want to be !  *
*											     *
**************************************************************************
player_select

	.if ejbbug
	move	@f_fastrun,a0,w
	jrne	l_retp
	.endif

	calla	murder_myoinit
	clr	a0
	move	a0,@f_doscore,w		; dont display score 'n stuff
	calla	init_player_variables
	calla	nosounds
	calla	display_off

	movi	psel_mod,a0
	calla	init_bakmods
	calla	multi_plane		; player select background !!

	clr	a0
	move	a0,@f_start,w		; flag: dont fight !!
	not	a0
	move	a0,@p1_char,w
	move	a0,@p2_char,w		; null the characters = 0ffffH
*
* display mugshots
*
	movi	mug_shot_table,a0
	movi	mug_shot_table_with_smoke,a1
	callr	smoke_pick_a0
	move	a0,a7

	move	@ofree,a9,l		; a9 = last object
	move	a9,*a13(p_store1),l	; save here

psel3	move	*a7+,a5,l		; a5 = mugshot image
	jreq	psel2

	push	a7
	calla	gso_dmawnz_ns
	pull	a7
	move	a8,*a9(oslink),l	; link mugshots together
	move	a8,a9
	move	*a7+,a4,l
	calla	set_xy_coordinates

	move	*a7+,a4,w
	addk	16,a7
	move	a4,*a8(oshape),w	; character id here !

	movi	bpal_white,a1
	move	a1,*a8(oconst),w	; temp
	calla	insobja8		; on list 2
	jruc	psel3


psel2	clr	a0
	move	a0,*a8(oslink),l	; last object = 0 link

	movi	txt_select_msg,a8
	movi	0000b00c8H,a9
	jsrp	p15_centered

	move	@curback,a0,w
	cmpi	10,a0
	jrhi	psela
	sll	5,a0
	addi	background_names,a0
	move	*a0,a8,l
	movi	000ec00c8H,a9
	jsrp	pds_centered		; print the name of the background

psela	jsrp	position_badge
	calla	display_on

	movi	032H,a3
	calla	send_code_a3	    	; player select tune
	movi	021bH,a3
	calla	send_code_a3		; gong !!
	callr	create_cursor_procs

	move	@f_smoke,a5,w
	jrne	psel6			; smoke is active ---> no tease needed

	movi	BOX_01,a5
	movi	0006600afH,a4
	calla	gso_dmawnz_coor
	calla	insobja8
	clr	a0
	move	a0,*a8(ozpos),w
	create	pid_fx,box_flip_proc

	jruc	psel6

player_joinin
	callr	create_cursor_procs	; 2nd time = sans fancy

psel6	movi	040H*5,a11
psel5	sleep	3

waiting_for_psel
	dec	a11
	jreq	psel9			; timed out !!

	movi	pid_p1sel,a0
	calla	exprc
	jrne	psel5
	movi	pid_p2sel,a0
	calla	exprc
	jrne	psel5			; select proc exists ---> loop
	jruc	psel4

psel9	movi	pid_p1sel,a0
	callr	force_psel_choice
	movi	pid_p2sel,a0
	callr	force_psel_choice	; timeout ---> force a choice now !!

psel4	sleep	01cH

	movi	ps_active,a1		; activate the dudes who are in
	move	@p1_char,a0,w
	jrnn	psel7
	clr	a1			; assume non-active
psel7   	move	a1,@p1_state,w
	movi	ps_active,a1		; activate the dudes who are in
	move	@p2_char,a0,w
	jrnn	psel8
	clr	a1
psel8	move	a1,@p2_state,w

	movi	gs_post_psel,a0
	move	a0,@gstate,w		; game state: post player select
	sleep	020H

	movi	oid_cursor1,a0
	calla	dallobj
	movi	oid_cursor2,a0
	calla	dallobj			; delete cursor objects !!
	calla	murder			; stop color flash procs

;	calla	fade_all_fast
;	sleep	8

l_retp	retp

**************************************************************************
*											     *
*  create_cursor_procs - create a cursor proc for any player who is in   *
*                        the game.							     *
*											     *
**************************************************************************
create_cursor_procs
	move	@p1_state,a0,w
	cmpi	ps_active,a0
	jrne	ccp3
	movi	ps_psel,a0
ccp3	move	a0,@p1_state 	; active players --> now in pselect mode
	cmpi	ps_psel,a0
	jrne	ccp5

	movi	p1_select,a7
	movi	pid_p1sel,a0
	calla	create_if_gone

ccp5 	move	@p2_state,a1,w
	cmpi	ps_active,a1
	jrne	ccp6
	movi	ps_psel,a1
ccp6	move	a1,@p2_state,w	; active players --> now in pselect mode
	cmpi	ps_psel,a1
	jrne	ccp4

	movi	p2_select,a7
	movi	pid_p2sel,a0
	calla	create_if_gone

ccp4	rets


txt_select_msg
	.byte	"SELECT YOUR FIGHTER",0
	.even


a0_ochar_to_position
	mmtm	sp,a1,a2,a3
	clr 	a3				; 1st position = 0
	not	a3				; start at -1
	movi	mug_shot_table,a1
what3	inc	a3
	move	*a1(32+16+16),a2,w
	addi	32+16+16+16+16,a1		; a1 ---> next entry
	cmp	a0,a2				; found matching ochar ?
	jrne	what3				; no
	move	a3,a0				; return ---> a0 = position
	mmfm	sp,a1,a2,a3
	rets


mug_shot_table
	.long	HDSHANG
	.word	mug1_x+(x_space*0),mug1_y+(y_space*0),ft_st,0
	.long	HDBRIDE
	.word	mug1_x+(x_space*1),mug1_y+(y_space*0),ft_lia,0
	.long	HDJAX
	.word	mug1_x+(x_space*2),mug1_y+(y_space*0),ft_jax,0
	.long	HDKANO
	.word	mug1_x+(x_space*3),mug1_y+(y_space*0),ft_kano,0
	.long	HDLIUKANG
	.word	mug1_x+(x_space*4),mug1_y+(y_space*0),ft_lk,0

	.long	HDSONYA
	.word	mug1_x+(x_space*0),mug1_y+(y_space*1),ft_sonya,0
	.long	HDSWAT
	.word	mug1_x+(x_space*1),mug1_y+(y_space*1),ft_swat,0
	.long	BOX_01
	.word	mug1_x+(x_space*2)-3,mug1_y+(y_space*1)-2,ft_smoke,0
	.long	HDSUBZERO
	.word	mug1_x+(x_space*3),mug1_y+(y_space*1),ft_subzero,0
	.long	HDMUSTARD
	.word	mug1_x+(x_space*4),mug1_y+(y_space*1),ft_robo2,0

	.long	HDKETCHUP
	.word	mug1_x+(x_space*0),mug1_y+(y_space*2),ft_robo1,0
	.long	HDINDIAN
	.word	mug1_x+(x_space*1),mug1_y+(y_space*2),ft_indian,0
	.long	HDSHEGORO
	.word	mug1_x+(x_space*2),mug1_y+(y_space*2),ft_sg,0
	.long	HDLAO
	.word	mug1_x+(x_space*3),mug1_y+(y_space*2),ft_lao,0
	.long	HDTUSKAN
	.word	mug1_x+(x_space*4),mug1_y+(y_space*2),ft_tusk,0
	.long	0


mug_shot_table_with_smoke
	.long	HDSHANG
	.word	mug1_x+(x_space*0),mug1_y+(y_space*0),ft_st,0
	.long	HDBRIDE
	.word	mug1_x+(x_space*1),mug1_y+(y_space*0),ft_lia,0
	.long	HDJAX
	.word	mug1_x+(x_space*2),mug1_y+(y_space*0),ft_jax,0
	.long	HDKANO
	.word	mug1_x+(x_space*3),mug1_y+(y_space*0),ft_kano,0
	.long	HDLIUKANG
	.word	mug1_x+(x_space*4),mug1_y+(y_space*0),ft_lk,0

	.long	HDSONYA
	.word	mug1_x+(x_space*0),mug1_y+(y_space*1),ft_sonya,0
	.long	HDSWAT
	.word	mug1_x+(x_space*1),mug1_y+(y_space*1),ft_swat,0
	.long	BOX_09
	.word	mug1_x+(x_space*2),mug1_y+(y_space*1),ft_smoke,0
	.long	HDSUBZERO
	.word	mug1_x+(x_space*3),mug1_y+(y_space*1),ft_subzero,0
	.long	HDMUSTARD
	.word	mug1_x+(x_space*4),mug1_y+(y_space*1),ft_robo2,0

	.long	HDKETCHUP
	.word	mug1_x+(x_space*0),mug1_y+(y_space*2),ft_robo1,0
	.long	HDINDIAN
	.word	mug1_x+(x_space*1),mug1_y+(y_space*2),ft_indian,0
	.long	HDSHEGORO
	.word	mug1_x+(x_space*2),mug1_y+(y_space*2),ft_sg,0
	.long	HDLAO
	.word	mug1_x+(x_space*3),mug1_y+(y_space*2),ft_lao,0
	.long	HDTUSKAN
	.word	mug1_x+(x_space*4),mug1_y+(y_space*2),ft_tusk,0
	.long	0


ochar_order_mugs
	.long	HDKANO		; 0
	.long	HDSONYA		; 1
	.long	HDJAX		; 2
	.long	HDINDIAN	; 3
	.long	HDSUBZERO	; 4
	.long	HDSWAT		; 5
	.long	HDBRIDE		; 6
	.long	HDKETCHUP	; 7
	.long	HDMUSTARD	; 8
	.long	HDLAO		; 9
	.long	HDTUSKAN	; a
	.long	HDSHEGORO	; b
	.long	HDSHANG		; c
	.long	HDLIUKANG	; d
	.long	BOX_09		; e = smoke
	.long	HDMOTARO	; f = motaro
	.long	HDSHAO		; 10 = shao kahn

	.long	QUESTION	; 11
	.long	QUESTION	; 12
	.long	QUESTION	; 13
	.long	QUESTION	; 14
	.long	QUESTION	; 15
	.long	QUESTION	; 16
	.long	QUESTION	; 17
	.long	QUESTION	; 18
	.long	QUESTION	; 19
	.long	QUESTION	; 1a
	.long	QUESTION	; 1b
	.long	QUESTION	; 1c
	.long	QUESTION	; 1d
	.long	QUESTION	; 1e
	.long	QUESTION	; 1f

	.long	ENDUR_BLUE 	; 20 = endurance 2a
	.long	ENDUR_RED	; 21 = endurance 2b
	.long	ENDUR_GOLD 	; 22 = endurance 2c
	.long	ENDUR_MAG  	; 23 = endurance 2d
	.long	ENDUR_GREEN	; 24 = endurance 2e
	.long	ENDUR_GOLD	; 25 = endurance 2f
	.long	ENDUR_BLUE 	; 26 = endurance 3a
	.long	ENDUR_BLUE 	; 27 = endurance 3b


p_mychar		.set	p_store6
p_hischar	.set	p_otherproc

fl_cursor1
	.word	bpal_flash1,4
	.word	0000000111100000b
	.word	0000001111100000b
	.word	end_stuff

fl_cursor2
	.word	bpal_flash2,4
	.word	0011110000000000b
	.word	0111110000000000b
	.word	end_stuff

fl_auto	.word	bpal_flash3,4
	.word	0ffffH
	.word	rgb_blue
	.word	end_stuff


psel_drone_2
	movi	oid_p2,a0
	calla	dallobj			; kill any previous objects
	movi	pid_p2,a0
	calla	dallprc			; kill any previous procs

	calla	make_player_2_obj
	movi	scrrgt-024H,a0
	jruc	psd4

psel_drone_1
	movi	oid_p1,a0
	calla	dallobj			; kill any previous objects
	movi	pid_p1,a0
	calla	dallprc			; kill any previous procs

	calla	make_player_1_obj
	movi	025H,a0
psd4	move	a0,*a8(oxpos),w		; position to the left of the mugshots

	movi	character_palettes_1,a0
	calla	get_player_palette

	calla	insobja8
	calla	stance_setup
	move	*a8(oypos),*a13(p_ganiy),w	; set the grounded y pos

psel_drone_loop
	sleep	1
	calla	next_anirate

	move	*a8(oid),a7,w
	cmpi	2,a7			; player 2 ?
	jrne	psel_drone_loop		; no, palette is fine
*
* player 2 ---> check if alternate palette is needed
*
	move	@p1_char,a0,w
	move	*a8(ochar),a7,w		; a7 = my ochar

	move	*a8(oflags2),a4,w
	btst	b_ugly_pal,a4
	jrne	psd8			; using alternate pal

	cmp	a0,a7			; player 1 same character as me ?
	jrne	psel_drone_loop		; no
	ori	m_ugly_pal,a4
	move	a4,*a8(oflags2),w	; set alternate palette bit
	jruc	psd9

psd8	cmp	a0,a7			; player 1 same character as me ?
	jreq	psel_drone_loop		; yes

	andni	m_ugly_pal,a4
	move	a4,*a8(oflags2),w	; clear alternate palette bit
  	movi	character_palettes_1,a0
	jruc	psda

psd9	movi	character_palettes_2,a0
psda	calla	get_char_long
	calla	player_swpal
	jruc	psel_drone_loop

**************************************************************************

box_flip_proc
	movi	50,a0
	calla	randper
	jrnc	l_die

	sleep	080H
	movi	a_box_flip,a9
	movk	6,a0
	jsrp	framew
	sleep	050H
	movk	6,a0
	jsrp	framew

l_die	die

a_box_flip
	.long	BOX_01
	.long	BOX_02
	.long	BOX_03
	.long	BOX_04
	.long	BOX_05
	.long	BOX_06
	.long	BOX_07
	.long	BOX_08
	.long	BOX_09
	.long	0
	.long	BOX_08
	.long	BOX_07
	.long	BOX_06
	.long	BOX_05
	.long	BOX_04
	.long	BOX_03
	.long	BOX_02
	.long	BOX_01
	.long	0

**************************************************************************

menu_to_ochar
	sll	4,a0
	addi	mto_table,a0
	move	*a0,a0,w
	rets

mto_table
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6

	.word	00eH

	.word	7
	.word	8
	.word	9 
	.word	10
	.word	11
	.word	12 
	.word	13

**************************************************************************
*											     *
*  player select process						     			*
*											     *
**************************************************************************
p2_select
	create	pid_p2,psel_drone_2

	movi	fl_cursor2,a11
	create	pid_fx,boonpal_stuff		; flash letters
	move	a0,*a13(p_store2),l		; save cursor flash process

	movi	switch+8,a0
	move	a0,*a13(p_joyport),l

	movi	p2_char,a0
	move	a0,*a13(p_mychar),l		; pointer to my "char"
	movi	p1_char,a0
	move	a0,*a13(p_hischar),l		; pointer to his "char"

	movi	00202H,a11

	movi	mug_shot_table+((32+32+32)*4),a4
	move	*a4(32+16+16),a4,w		; position 4 ochar

	movi	(mug1_x-cthick)+(x_space*4),a5  	; initial x
	movi	mug1_y-cthick,a6	 		 	; initial y

	movi	mug_shot_table+((32+32+32)*1),b4
	move	*b4(32+16+16),b4,w		; position 5 ochar

	movi	(mug1_x-cthick)+(x_space*4),b5  	; initial x
	movi	mug1_y-cthick+y_space,b6 	  	 	; initial y
	movi	oid_cursor2,a2
	jruc	curs3


p1_select
	create	pid_p1,psel_drone_1

	movi	fl_cursor1,a11
	create	pid_fx,boonpal_stuff		; flash letters
	move	a0,*a13(p_store2),l		; save cursor flash process

	movi	switch,a0
	move	a0,*a13(p_joyport),l

	movi	p1_char,a0
	move	a0,*a13(p_mychar),l		; pointer to my "char"
	movi	p2_char,a0
	move	a0,*a13(p_hischar),l		; pointer to his "char"

	movi	00101H,a11			; color to use
	movi	mug_shot_table,a4
	move	*a4(32+16+16),a4,w		; position 0 ochar
	movi	mug1_x-cthick,a5	 	; initial x
	movi	mug1_y-cthick,a6	 	; initial y

	movi	mug_shot_table+((32+32+32)*5),b4
	move	*b4(32+16+16),b4,w		; position 5 ochar
	movi	mug1_x-cthick+x_space,b5 	; initial x
	movi	mug1_y-cthick,b6 		; initial y
	movi	oid_cursor1,a2

curs3 	move	a2,*a13(p_store4),w

curs2	move	*a13(p_mychar),a0,l
	move	a4,*a0,w

	movi	cursor_table,a0
	move	@ofree,a9,l			; a9 = previous cursor object
	move	a9,a10

curs4	mmtm	sp,a0,a5,a6
	move	a11,a0			; a0 = constant color to use
	calla	make_solid_object
	calla	set_noscroll
	mmfm	sp,a0,a5,a6

	move	*a13(p_store4),a2,w
	move	a2,*a8(oid),w		; set oid of cur

	move	*a0+,a3,w
	move	a3,*a8(osizex),w	; define x size
	move	*a0+,a2,w
	move	a2,*a8(osizey),w	; define y size
	sll	16,a2
	or	a2,a3			; a3 = y:x size

	move	a8,*a9(oslink),l	; link cursor object together
	move	a11,*a8(oconst),w	; color of cursor

	move	*a0+,a1,w
	add	a5,a1
	move	a1,*a8(oxpos),w
	move	*a0+,a1,w
	add	a6,a1
	move	a1,*a8(oypos),w		; set coordinates

	push	a0
	calla	insobj2a8
	pull	a0
	move	a8,a9

	cmpi	cursor_table_end,a0
	jrne	curs4
*
* now do the player # indicator part of the cursor
*

	movi	solid_object_img,a5
;	movi	BIGFONT_1,a5
	calla	gso_dmacnz

	move	*a13(p_store4),a2,w
	move	a2,*a8(oid),w			; set oid of cursor #

	movi	BIGFONT_1,a1			; a1 = character shape
	movi	010H,a5				; a5 = y offset in box
	move	*a13(procid),a0,w
	cmpi	pid_p1sel,a0
	jreq	curs5
	movi	BIGFONT_2,a1			; a1 = character shape
	movi	028H,a5	 			; a5 = y offset in box
curs5	calla	ani_flag

	move	a8,*a9(oslink),l  		; link cursor object together
	move	*a9(oconst),*a8(oconst),w

	move	*a9(oypos),a0,w
	add	a5,a0
	move	a0,*a8(oypos),w	  	; y offset
	move	*a9(oxpos),a0,w
	subi	01dH,a0
	move	a0,*a8(oxpos),w	  	; centered in x
	calla	insobja8

	clr	a0
	move	a0,*a8(oslink),l	; last object = 0 link
	move	a10,a8			; a8 = 1st object of cursor

**************************************************************************
*											     *
*   scan joystick / buttons								     *
*											     *
**************************************************************************

	sleep	020H

	clr	a10			; a10 = joystick debounce
cmove3	sleep	1

psel_cursor_loop
	move	a10,a10
	jreq	cmove4
	dec	a10

cmove4	move	@switch,a0,l
	not	a0			; a0 = bit state ?
	movi	m_p1action,a2		; player 1 port 1 mask
	move	*a13(procid),a7,w
	cmpi	pid_p1sel,a7
	jreq	cmove41
	movi	m_p2action,a2		; player 2 port 1 mask

cmove41	and	a2,a0
	jrne	cmove9			; choice made !!
	
	calla	joystick_in_a0		; any joystick movement ?
	jreq	cmove3			; no

	move	a10,a10			; still debouncing joystick ?
	jrne	cmove3			; yes, wait

	movk	12,a10			; joystick debounce speed
	move	*a13(p_mychar),a1,l
	move	*a1,a1,w		; a1 = my current ochar
*
* joystick = up
*
cmove5	btst	0,a0
	jreq	cmove6

	movi	upsans,a2
	callr	is_move_legal		; is this move legal ?
	jrnc	cmove6

	movi	up_change,a2
	clr	a3
	movi	-y_space,a4		; delta y
	jruc	new_cursor_position
*
* joystick = down
*
cmove6	btst	1,a0
	jreq	cmove7

	movi	dnsans,a2
	callr	is_move_legal		; is this move legal ?
	jrnc	cmove7

	movi	down_change,a2
	clr	a3
	movi	y_space,a4		; delta y
	jruc	new_cursor_position
*
* joystick = left
*
cmove7	btst	2,a0
	jreq	cmove8

	movi	lfsans,a2
	callr	is_move_legal		; is this move legal ?
	jrnc	cmove8

	movi	left_change,a2
	movi	-x_space,a3		; delta x
	clr	a4
	jruc	new_cursor_position
*
* joystick = right
*
cmove8	btst	3,a0
	jreq	cmove3

	movi	rtsans,a2
	callr	is_move_legal		; is this move legal ?
	jrnc	cmove3

	movi	right_change,a2
	movi	x_space,a3		; delta x
	clr	a4
	jruc	new_cursor_position
*
* button pressed ---> choice is made
*
cmove9	move	*a13(p_mychar),a0,l
	move	a0,a2
	move	*a0,a0,w		; a0 = my choice

	mmtm	sp,a0,a10
	move	a0,a10
	create	pid_selspeech,select_speech
	mmfm	sp,a0,a10

	movi	pid_master,a0
	calla	exprc_er		; a0 = master proc (or else)
	move	*a0(p_store1),a1,l	; a1 = 1st mugshot object

	move	*a2,a0,w
	move	a0,*a13(p_store1),w

;	calla	ochar_to_menu		; xlate to menu position
;	jreq	cmoveb			; zero ---> we got our object

	move	a1,a2

cmovea	move	a2,a1
	move	*a1(oshape),a4,w
	move	*a1(oslink),a2,l	; grab next link now
	cmp	a0,a4			; match ?
	jrne	cmovea

*
* flash the mugshot chosen
*
cmoveb	move	a1,a8
	movi	bpal_white,a0
	move	a0,*a8(oconst),w	; use this constant color

	movi	00eH,b1
	movi	00fH,b2
	callr	cursor_sound

	move	@p1_char,a6,w
	movi	pid_p1,a3
	movi	pid_p2sel,a1		; assume we are looking for 2 !
	move	*a13(procid),a5,w
	cmpi	pid_p1sel,a5
	jreq	look2

	move	@p2_char,a6,w
	movi	pid_p2,a3
	movi	pid_p1sel,a1		; we are lookin for 1 !!

look2	push	a1			; save pid of other player cursor !!!
	move	a3,a0
	calla	exprc_er		; a0 = dude doing the stance proc
	movi	psel_victory_animation,a7
	calla	fastxfer
	move	a6,a0
	addi	aud_pik_kano,a0
	calla	aud1			; audit: chose this character
	pull	a0			; a0 = pid of other cursor proc

	clr	a1
	not	a1
	calla	existp			; a0 = other proc flashing ?
	jreq	look3			; sans

	move	*a0(pwake),a7,l
	cmpi	i_am_flashing,a7	; is he flashing a cursor too ??
	jrne	look3			; sans

	move	*a0(pa8),a1,l
	cmp	a8,a1	     		; he flashing the same as me ??
	jrne	look3			; no

	push	a0
	move	*a0(p_store4),a0,w
	calla	dallobj			; kill his cursor objects
	pull	a0
	calla	kill			; yes, sorry there can be only one !

look3	movk	6,a11
	movi	0f00cH,a10		; white flags
	movi	0f002H,a9		; normal flags

	move	*a13(p_store1),a0,w	; get char offset
	cmpi	ft_smoke,a0
	jrne	look4
	movi	08002H,a9		; smoke = 256 colors !!!

look4	movi	boonpal,a0
	move	a10,*a8(oflags),w	; white flag
	jsrp	flash_sleep

	move	a9,*a8(oflags),w	; back to normal flags
	move	*a8(oimg),a1,l
	move	*a1(icmap),a0,l		; get back old palette
	jsrp	flash_sleep

	dsj	a11,look4

	move	*a13(p_store1),a0,w	; get char offset
	sll	5,a0
	addi	ochar_picked_palettes,a0
	move	*a0,a0,l
	jreq	smoke_skip
	calla	swpal			; dim down

smoke_skip
	move	*a13(p_store4),a0,w
	calla	dallobj

	movi	ps_post_psel,a0		; new player state
	movi	p1_state,a2
	move	*a13(procid),a1,w
	cmpi	pid_p1sel,a1
	jreq	cmoved
	movi	p2_state,a2
cmoved	move	a0,*a2,w		; my player state = post player select
	die


flash_sleep
	calla	swpal			; switch to boonpal
	sleep	2
i_am_flashing
	retp

**************************************************************************
*											     *
*  select_speech - make a speech call for the choice that was selected   *
* 											     *
*  input: a10 = offset									     *
*											     *
**************************************************************************
select_speech
	sleep	8

selsp1	clr	a1
	not	a1
	movi	pid_selspeech,a0
	calla	existp
	jreq	selsp3			; dont interupt another proc

	move	*a0(pwake),a0,l
	cmpi	selsp1,a0		; has he made a speech call yet ?
	jreq	selsp3			; no, make mine now
	sleep	1
	jruc	selsp1			; yes ---> wait till he is done

selsp3	addi	028H,a10
	move	a10,a0
	calla	triple_sound
	sleep	030H
	die

**************************************************************************
*											     *
*  is_move_legal - answers this questions with a carry			     *
* 											     *
*  input: a1 = my current ochar									*
*         a2 = table of sans values.							     *
*											     *
**************************************************************************
is_move_legal
	mmtm	sp,a0,a1
	move	a1,a0
	callr	a0_ochar_to_position
	move	a0,a1

	move	*a2+,a3,w		; grab a table entry
	cmp	a1,a3			; sans ??
	jreq	imlno
	move	*a2+,a3,w		; grab a table entry
	cmp	a1,a3			; sans ??
	jreq	imlno
	move	*a2+,a3,w		; grab a table entry
	cmp	a1,a3			; sans ??
	jreq	imlno
	move	*a2+,a3,w		; grab a table entry
	cmp	a1,a3			; sans ??
	jreq	imlno
	move	*a2+,a3,w		; grab a table entry
	cmp	a1,a3			; sans ??
	jreq	imlno
	setc
	jruc	imlx

imlno	clrc
imlx	mmfm	sp,a0,a1
	rets

upsans	.word	0,1,2,3,4
dnsans	.word	10,11,12,13,14
lfsans	.word	0,5,10,10,10
rtsans	.word	4,9,14,14,14

**************************************************************************
*											     *
*  cursor_sound - make a cursor sound							     *
* 											     *
*  input: b1 = player 1 sound								     *
*         b2 = player 2 sound								     *
*											     *
**************************************************************************
cursor_sound
	mmtm	sp,a0,a3,a4
	move	*a13(procid),a0,w
	cmpi	pid_p1sel,a0
	jreq	csnd3
	move	b2,b1			; player 2 use sound #2
csnd3	move	b1,a0
	calla	triple_sound
	mmfm	sp,a0,a3,a4
	rets

up_change
	.word	0		; 0 -
	.word	1		; 1 -
	.word	2		; 2 -
	.word	3		; 3 -
	.word	4		; 4 -
	.word	0		; 5 -
	.word	1		; 6 -
	.word	2		; 7 -
	.word	3		; 8 -
	.word	4		; 9 -
	.word	5		; 10 -
	.word	6		; 11 -
	.word	7		; 12 -
	.word	8		; 13 -
	.word	9		; 14 -

down_change
	.word	5	        ; 0 -
	.word	6		; 1 -
    	.word	7		; 2 -
	.word	8		; 3 -
	.word	9		; 4 -
	.word	10		; 5 -
	.word	11		; 6 -
	.word	12		; 7 -
	.word	13		; 8 -
	.word	14		; 9 -
	.word	10		; 10 -
	.word	11		; 11 -
	.word	12		; 12 -
	.word	13		; 13 -
	.word	14		; 14 -

left_change
	.word	0		; 0 -
	.word	0		; 1 -
	.word	1		; 2 -
	.word	2		; 3 -
	.word	3		; 4 -
	.word	5		; 5 -
	.word	5		; 6 -
	.word	6		; 7 -
	.word	7		; 8 -
	.word	8		; 9 -

	.word	10		; 10 -
	.word	10		; 11 -
	.word	11		; 12 -
	.word	12		; 13 -
	.word	13		; 14 -

right_change
	.word	1		; 0 -
	.word	2		; 1 -
	.word	3		; 2 -
	.word	4		; 3 -
	.word	4		; 4 -
	.word	6		; 5 -
	.word	7		; 6 -
	.word	8		; 7 -
	.word	9		; 8 -
	.word	9		; 9 -
	.word	11		; 10 -
	.word	12		; 11 -
	.word	13		; 12 -
	.word	14		; 13 -
	.word	14		; 14 -

**************************************************************************
*											     *
*  new_cursor_position - handles moving cursor to a new position, hence  *
*                        the name...							     *
* 											     *
*  input: a1 = current ochar									*
*         a2 = position change for new spot					     *
*         a3 = coordinate delta x							     *
*         a4 = corrdinate delta y							     *
*											     *
**************************************************************************
new_cursor_position
	callr	new_cursor_calla
      	jruc	cmove3

new_cursor_calla
	move	a1,a0
	calla	a0_ochar_to_position
	move	a0,a1
	sll	4,a1
	add	a2,a1			; direction table
	move	*a1,a1,w		; new position
*
* skip center spot
*
	move	@f_smoke,b1,w
	jrne	ncp3			; smoke active = let him be picked

	cmpi	7,a1			; middle square ?
	jrne	ncp3			; nope.

	cmpi	up_change,a2		; trying to move up to the middle ?
	jrne	ncp0			; no.

	sll	1,a4			; yes, double dy
	movk	s2_ochar,a1 		; force new spot = 2
	jruc	ncp3

ncp0	cmpi	down_change,a2
	jrne	ncp1
	sll	1,a4			; yes, double dy
	movk	s12_ochar,a1 		; force new spot = 12
	jruc	ncp3

ncp1	cmpi	left_change,a2
	jrne	ncp2
	sll	1,a3			; yes, double dx
	movk	s6_ochar,a1 		; force new spot = 6
	jruc	ncp3

ncp2	cmpi	right_change,a2
	jrne	ncp3
	sll	1,a3			; yes, double dx
	movk	s8_ochar,a1 		; force new spot = 8
*
* position ---> ochar
*
ncp3	sll	5,a1			; 32 bits
	move	a1,a5
	sll	1,a1			; 64 bits
	add	a5,a1
	addi	mug_shot_table,a1
	move	*a1(32+16+16),a1,w	; grab character id from table
	move	*a13(p_mychar),a5,l
	move	a1,*a5,w		; update my new ochar

	movi	00cH,b1
 	movi	00dH,b2
	callr	cursor_sound

	move	a8,a7
ncp4	move	*a7(oxpos),a5,w
	add	a3,a5
	move	a5,*a7(oxpos),w
	move	*a7(oypos),a5,w
	add	a4,a5
	move	a5,*a7(oypos),w		; do the deltas !!
	move	*a7(oslink),a7,l
	jrne	ncp4
*
* display new choice a fight'n
*
	movi	pid_p1,a1
	movi	psel_drone_1,a7

	move	*a13(procid),a0,w
	cmpi	pid_p1sel,a0
	jreq	ncp5

	movi	pid_p2,a1
	movi	psel_drone_2,a7

ncp5	calla	getprc
	rets


cursor_table
	.word	x_size+4+4,4
	.word	0,0		; x:y size / x:y offset (top)
	.word	x_size+4+4,4
	.word	0,y_size+4	; x:y size / x:y offset (bottom)
	.word	4,y_size+4+4
	.word	0,0		; x:y size / x:y offset (left)
	.word	4,y_size+4+4
	.word	x_size+4,0	; x:y size / x:y offset (right)
cursor_table_end

;*********************************************************************

; make sure this displays 1/2 credits (ejbejbejb)
**************************************************************************
*											     *
*  show_credits - show credits during the player select menu	     	*
*											     *
**************************************************************************
show_credits
	jsrp	print_credits

msc4	calla	get_credits
	move	a0,a10	  	; a10 = latest # of credits
	sleep	2
	calla	get_credits
	cmp	a0,a10
	jreq	msc4

	movi	objlst2,a2
	calla	delolist
	jruc	show_credits


print_credits
	movi	coin_mess,a8
	move	@gstate,a0,w
	cmpi	gs_buyin,a0
	jrne	pcred4
	movi	buyin_coin_mess,a8	; buyin ---> position inside box

pcred4	calla	lm_setup
	calla	get_cstr  		; get the current credits
	jauc	printf

coin_mess
	mess_mac  rd7font,spacing20,200,0e9H,bpal_yellow*010000H,strcnrmos,0
        .even

buyin_coin_mess
	mess_mac  rd7font,spacing20,200,0e9H,bpal_yellow*010000H,strcnrmos,0
        .even

;************************************************************************

do_ladder
	.if ejbbug
	move	@f_fastrun,a1,w
	jrne	lad9
	.endif

	jruc	lad9

	calla	murder_myoinit_score
	clr	a1
	move	a1,*a13(p_store6),w	; clear button press count
	jsrp	setup_ladder_screen

	movi	036H,a3
	calla	send_code_a3	    	; start the mountain tune

	move	@winner_status,a0,w 	; have we played a tune yet ?
	jrne	lad2		  	; yes, skip pan down
	move	@map_position,a0,w	; no, position 1 ??
	jreq	mountain_pandown	; yes, pan down the entire mountain

lad2	move	*a13(p_store3),a8,l
	move	*a13(p_store4),a9,l
	move	*a13(p_store5),a10,l	; grab player box object / frame
*
* player box ----> move up !
*
	movi	030H,a0
	jsrp	ladder_sleep
	move	@map_position,a1
	jreq	lad5			; position 0 ---> dont move player box

	jsrp	box_move_up_1
	move	@map_position,a1
	dec	a1			; a1 = previous position
	sll	4,a1

	move	@map_start,a0,l
	add	a0,a1
	move	*a1,a1,w		; ochar last position ???
	cmpi	ft_smoke,a1		; secrets char ?
	jrne	lad5			; no

	jsrp	box_move_up_1		; yes, be sneaky, pass it up

lad5	movi	040H,a0
	jsrp	ladder_sleep
	jruc	ladder_exit


mountain_pandown
	create	pid_fx,player_box_decend
	move	*a13(p_store3),*a0(pa8),l
	move	*a13(p_store4),*a0(pa9),l
	move	*a13(p_store5),*a0(pa10),l	; pass player box objects

	movi	030H,a0
	jsrp	ladder_sleep
	
;	movi	020000H,a0
	movi	030000H,a0

	move	a0,@scrolly,l
mpan3	sleep	1

	callr	escape_button_update
	jrnc	mpan4
	movi	0a0000H,a0
	move	a0,@scrolly,l			; button pressed = scroll fast

mpan4	move	@worldtly+16,a0,w
	cmpi	0310H,a0
	jrlt	mpan3	    			; wait till we hit bottom

	clr	a0
	move	a0,@scrolly,l
	movi	0310H,a0
	move	a0,@worldtly+16,w

	movi	020H,a0
	jsrp	ladder_sleep

ladder_exit
	calla	fade_all_sky
	sleep	040H
	calla	murder_myoinit_score
lad9	retp	


ladder_sleep
	move	a0,*a13(p_anicount),w
	sleep	1
	callr	escape_button_update
	jrc	lslp9
	move	*a13(p_anicount),a0,w
	dec	a0
	jrne	ladder_sleep
lslp9	retp

*
* return carry set ---> player wants to escape this boring shit
*
escape_button_update
	move	@switch,a1,l
	not	a1
	andi	p1b0|p1b2|p1b3|p1sf2|p2b0|p2b2|p2b3|p2sf2,a1
	jrne	ebu_add

	move	@switch2,a1,l
	not	a1
	andi	p1b1|p1b4|p2b1|p2b4,a1
	jreq	ebu_check

ebu_add	move	*a13(p_store6),a1,w
	inc	a1
	move	a1,*a13(p_store6),w		; count this tick

ebu_check
	move	*a13(p_store6),a1,w
	cmpi	010H,a1
	jrlo	ebu_no
	setc
	rets
ebu_no	clrc
	rets


box_move_up_1
	movi	-020000H,a2
	movi	-060000H,a3
	callr	set_box_vel

	movi	y_spacing,a1
	move	@map_position,a0,w
	cmpi	00eH,a0
	jrne	bmu0
	sll	1,a1			; last guy = move up 2x as long
bmu0
	move	*a9(oypos),a0,w
	sub	a1,a0
	move	a0,*a9(ograv),w
	move	*a10(oypos),a0,w
	sub	a1,a0
	move	a0,*a10(ograv),w
	move	*a8(oypos),a11,w
	sub	a1,a11

bmu1	sleep	1
	movi	-020000H,a2
	movi	-060000H,a3
	callr	set_box_vel
	move	*a8(oypos),a1,w
	cmp	a1,a11
	jrlo	bmu1			; loop till traveled y_spacing

	callr	restore_box_start_y
	retp

restore_box_start_y
	clr	a0
	move	a0,*a8(oyvel),l
	move	a0,*a9(oyvel),l
	move	a0,*a10(oyvel),l	; box/frame ---> stop
	move	a11,*a8(oypos),w
	move	*a9(ograv),*a9(oypos),w		; end on exact spot
	move	*a10(ograv),*a10(oypos),w		; end on exact spot
	rets


player_box_decend
	clr	a1
	move	a1,*a13(p_store6),w	; clear button press count

	movi	030H,a0
	jsrp	ladder_sleep

	move	*a9(oypos),a0,w
	addi	040H,a0
	move	a0,*a9(ograv),w
	move	*a10(oypos),a0,w
	addi	040H,a0
	move	a0,*a10(ograv),w
	move	*a8(oypos),a11,w
	addi	040H,a11

pbd3	sleep	1
	movi	010000H,a2
	movi	020000H,a3
	callr	set_box_vel
	move	*a8(oypos),a1,w
	cmp	a1,a11
	jrhi	pbd3			; loop till traveled y_spacing

	callr	restore_box_start_y
	die


setup_ladder_screen
	calla	display_off

	movi	00dH,a11
	calla	do_a11_background	; put up mountain and sky background
	movi	pid_backg,a0
	calla	dallprc			; kill background updater

	movi	pf_battle_plan,a8
	jsrp	lm_printf		; text: Mortal Kombat Battle Plan

;	movi	peakboss,a5
;	calla	gso_dmawnz
;	movi	0000800ebH,a4
;	calla	set_xy_coordinates
;	calla	insobj2a8

*
* player's box
*
	move	@p1_char,a0,w
	move	@p1_state,a1,w
	cmpi	ps_active,a1
	jreq	ladder0
	move	@p2_char,a0,w		; a0 = player's ochar
ladder0
	movi	0009e0080H,a4
	move	@winner_status,a1,w	; first time around ?
	jrne	ladder3			; no.
	move	@map_position,a1,w
	jrne	ladder3			; no.
	movi	0005e0080H,a4		; yes, start higher

ladder3	callr	plot_a_box		; your players box !!
	move	a8,*a13(p_store3),l
	move	a9,*a13(p_store4),l
	move	a10,*a13(p_store5),l

	movi	objlst,a0
	calla	olist_noscroll

	move	@map_start,a3,l
	movi	box_coordinate_table,a1
ladder1	move	*a3+,a0,w		; ochar
	jrn	ladder2
;	cmpi	ft_final_boss,a0
;	jreq	ladder2			; final boss = no box for him

	move	*a1+,a4,w		; y coordinate
	sll	16,a4
	addi	0f8H,a4
	mmtm	sp,a1,a3
	callr	plot_a_box
	mmfm	sp,a1,a3
	jruc	ladder1

ladder2
	calla	multi_plane
	callr	set_starting_worldy

	movi	baklst3,a0
	calla	olist_noscroll		; sky is stationary
	movi	skip_bakmod,a0
	move	a0,@bak3mods,l		; dont update the sky list anymore

	calla	multi_plane
	create	pid_backg,background
	calla	display_on
	sleep	1
	retp

*
*  a4 = y:x coordinates
* a0 = character offset
*
plot_a_box
	push	a0

;	move	a4,a2
;	movi	smframe1,a5
;	calla	gso_dmawnz
;	move	a2,a4
;	subi	000030003H,a4			; adjust for left frame
;	calla	set_xy_coordinates
;	calla	insobja8
;	move	a8,a10

;	movi	smframe2,a5
;	calla	gso_dmawnz
;	move	a2,a4
;	addk	18,a4
;	subi	000030000H,a4			; adjust for right frame
;	calla	set_xy_coordinates
;	calla	insobja8
;	move	a8,a9

	pull	a0
	sll	5,a0
	addi	mini_mug_table,a0
	move	*a0,a5,l
	calla	gso_dmawnz
	move	a2,a4
	calla	set_xy_coordinates
	jauc	insobja8

set_box_vel
	move	a2,a0
	callr	escape_button_update
	jrnc	sbv5
	move	a3,a0
sbv5	move	a0,*a8(oyvel),l
	move	a0,*a9(oyvel),l
	move	a0,*a10(oyvel),l	; box/frame ---> heading upwards
	rets

;**********************************************************************

set_starting_worldy
	move	@winner_status,a0,w 	; have we played a tune yet ?
	jreq	sswy9
	move	@map_position,a0,w
;	jreq	sswy9

	sll	4,a0
	addi	world_y_spots,a0
	move	*a0,a0,w
	sll	16,a0
	move	a0,@worldtly,l
sswy9	rets

;**********************************************************************

mini_mug_table

;	.long	smhhbox		; 0
;	.long	smlkbox		; 1
;	.long	smjcbox		; 2
;	.long	smugbox		; 3
;	.long	smktbox		; 4
;	.long	smlabox		; 5
;	.long	smstbox		; 6
;	.long	smrdbox		; 7
;	.long	smszbox		; 8
;	.long	smrpbox		; 9
;	.long	smscbox		; 10
;	.long	smjxbox		; 11
;	.long	smgorobox	; 12 = kintaro = goro
;	.long	mysterybox	; 13 - shao kahn
;	.long	mysterybox	; 14 - 3 hidden characters
;	.long	mysterybox	; 15 - 3 hidden characters
;	.long	mysterybox	; 16 - 3 hidden characters


world_y_spots
	.word	0310H
	.word	0310H
	.word	0310H-(1*y_spacing)
	.word	0310H-(2*y_spacing)
	.word	0310H-(3*y_spacing)
	.word	0310H-(4*y_spacing)
	.word	0310H-(5*y_spacing)
	.word	0310H-(6*y_spacing)
	.word	0310H-(7*y_spacing)
	.word	0310H-(8*y_spacing)
	.word	0310H-(9*y_spacing)
	.word	0310H-(10*y_spacing)

	.word	0310H-(10*y_spacing)	; secret

	.word	0310H-(12*y_spacing)
	.word	0310H-(13*y_spacing)-01aH


y_spacing	.set	03aH

**************************************************************************

box_coordinate_table
	.word	080H+(14*y_spacing)
	.word	080H+(13*y_spacing)
	.word	080H+(12*y_spacing)
	.word	080H+(11*y_spacing)
	.word	080H+(10*y_spacing)
	.word	080H+(9*y_spacing)
	.word	080H+(8*y_spacing)
	.word	080H+(7*y_spacing)
	.word	080H+(6*y_spacing)
	.word	080H+(5*y_spacing)
	.word	080H+(4*y_spacing)
	.word	080H+(3*y_spacing)
	.word	080H+(2*y_spacing)
	.word	080H+(1*y_spacing)
	.word	080H
	.word	-1

pf_battle_plan
	mess_mac rd15font,2,200,-022H,bpal_yellow*010000H,strcnrmos,0
	.byte	"MORTAL KOMBAT BATTLE PLAN",0
	.even


;************************************************************************

force_psel_choice
	clr	a1
	not	a1
	calla	exprc			; player select proc out there ?
	jreq	fpc9
	movi	cmove9,a7
	calla	fastxfer		; yes ---> make him select
fpc9	rets

**************************************************************************
*											     *
*  New code for "auto player select" feature					     *
*											     *
**************************************************************************
a_up	.set	1
a_down	.set	2
a_left	.set	3
a_right	.set	4


auto_player_select
	clr	a1
	not	a1
	movi	pid_master,a0
	calla	existp
	jreq	aps0

	move	*a0(pwake),a1,l		; grab master wakeup address
	cmpi	waiting_for_psel,a1	; where he should be ?
	jrne	aps0			; no, skip
	movi	040H*5,a1
	move	a1,*a0(pa11),l		; yes, tell him to wait longer

aps0	clr	a1
	not	a1
	movi	pid_auto_cycle,a0
	calla	existp	   		; already got letters up there ?
	jrne	aps1

	movi	fl_auto,a11
	create	pid_auto_cycle,boonpal_stuff		; flash letters

aps1
;	tsound	0f8H    			; musical hit !

	pushp	a8
	movi	pf_auto_msg_1,a8
	move	*a13(procid),a1,w
	cmpi	pid_p1sel,a1
	jreq	aps6
	movi	pf_auto_msg_2,a8
aps6	jsrp	lm_printf
	pullp	a8

	sleep	4

	movk	14,a0
	move	@f_smoke,a1,w
	jreq	aps7
	movk	15,a0			; smoke enabled ---> include him here
aps7	calla	randu
	dec	a0
	sll	5,a0
	movi	p1_movements,a2
	move	*a13(procid),a1,w
	cmpi	pid_p1sel,a1
	jreq	aps2
	movi	p2_movements,a2
aps2	add	a2,a0
	move	*a0,a11,l

aps3	movb	*a11,a0		; grab a direction
	jreq	aps9
	addk	8,a11
	cmpi	1,a0
	jreq	auto_move_up
	cmpi	2,a0
	jreq	auto_move_down
	cmpi	3,a0
	jreq	auto_move_left
	jruc	auto_move_right

aps9	sleep	6
	jruc	cmove9

auto_move_down
	movi	down_change,a2
	clr	a3
	movi	y_space,a4		; delta y
	jruc	new_auto_position

auto_move_up
	movi	up_change,a2
	clr	a3
	movi	-y_space,a4		; delta y
	jruc	new_auto_position

auto_move_left
	movi	left_change,a2
	movi	-x_space,a3		; delta x
	clr	a4
	jruc	new_auto_position

auto_move_right
	movi	right_change,a2
	movi	x_space,a3		; delta x
	clr	a4
*
*  input: a1 = current ochar
*         a2 = position change for new spot
*         a3 = coordinate delta x
*         a4 = corrdinate delta y
*
new_auto_position
	move	*a13(p_mychar),a1,l
	move	*a1,a1,w		; a1 = my current ochar
	callr	new_cursor_calla
	sleep	00aH
	jruc	aps3

pf_auto_msg_1
	mess_mac rd7font,2,021H,048H,bpal_flash3*010000H,strcnrmos_scr,0
	.byte	"RANDOM\nSELECT",0
	.even

pf_auto_msg_2
	mess_mac rd7font,2,016aH,048H,bpal_flash3*010000H,strcnrmos_scr,0
	.byte	"RANDOM\nSELECT",0
	.even

p1_movements
	.long	p1_kano	
	.long	p1_sonya	
	.long	p1_jax	
	.long	p1_ind	
	.long	p1_sz	
	.long	p1_swat	
	.long	p1_lia	
	.long	p1_robo1	
	.long	p1_robo2	
	.long	p1_lao	
	.long	p1_tusk	
	.long	p1_sg	
	.long	p1_st	
	.long	p1_lk
	.long	p1_smoke

p2_movements
	.long	p2_kano	
	.long	p2_sonya	
	.long	p2_jax	
	.long	p2_ind	
	.long	p2_sz	
	.long	p2_swat	
	.long	p2_lia	
	.long	p2_robo1	
	.long	p2_robo2	
	.long	p2_lao	
	.long	p2_tusk	
	.long	p2_sg	
	.long	p2_st	
	.long	p2_lk
	.long	p2_smoke


p1_kano	.byte	a_right,a_down,a_left,a_right,a_up,a_right,a_right,0
p1_sonya	.byte	a_right,a_right,a_right,a_down,a_down,a_left,a_left,a_left,a_up,0
p1_jax	.byte	a_right,a_right,a_right,a_right,a_left,a_left,a_left,a_right,0
p1_ind	.byte	a_down,a_down,a_right,a_right,a_right,a_left,a_left,0
p1_sz	.byte	a_right,a_right,a_right,a_down,0
p1_swat	.byte	a_down,a_down,a_right,a_right,a_left,a_up,0
p1_lia	.byte	a_right,a_right,a_right,a_down,a_down,a_left,a_left,a_up,a_up,0
p1_robo1	.byte	a_right,a_right,a_left,a_left,a_down,a_down,0
p1_robo2	.byte	a_right,a_right,a_right,a_down,a_right,0
p1_lao	.byte	a_down,a_down,a_right,a_right,a_right,0
p1_tusk	.byte	a_right,a_right,a_right,a_right,a_down,a_left,a_down,a_right,0
p1_sg	.byte	a_right,a_down,a_down,a_right,a_right,a_left,0
p1_st	.byte	a_down,a_down,a_right,a_right,a_left,a_up,a_up,a_left,0
p1_lk	.byte	a_right,a_right,a_right,a_down,a_up,a_right,0
p1_smoke	.byte	a_right,a_down,a_right,a_down,a_up,0

p2_kano	.byte	a_left,a_left,a_left,a_left,a_right,a_right,a_right,0
p2_sonya	.byte	a_left,a_left,a_left,a_left,a_right,a_down,a_left,0
p2_jax	.byte	a_down,a_down,a_left,a_up,a_up,a_left,a_left,a_right,0
p2_ind	.byte	a_left,a_left,a_left,a_left,a_right,a_down,a_down,0
p2_sz	.byte	a_left,a_left,a_left,a_down,a_up,a_right,a_right,a_down,0
p2_swat	.byte	a_left,a_left,a_left,a_down,a_up,a_down,0
p2_lia	.byte	a_left,a_left,a_left,a_right,a_left,a_right,a_left,0
p2_robo1	.byte	a_left,a_left,a_left,a_left,a_down,a_down,0
p2_robo2	.byte	a_left,a_down,a_right,a_down,a_up,a_down,a_up,0
p2_lao	.byte	a_down,a_down,a_left,a_left,a_left,a_right,a_right,0
p2_tusk	.byte	a_left,a_left,a_right,a_right,a_down,a_down,0
p2_sg	.byte	a_left,a_left,a_left,a_down,a_down,a_right,0
p2_st	.byte	a_left,a_down,a_up,a_left,a_left,a_left,0
p2_lk	.byte	a_left,a_down,a_down,a_left,a_right,a_right,a_up,a_up,0
p2_smoke	.byte	a_left,a_down,a_left,a_down,a_up,0

	.even

;**********************************

position_badge
	move	@winner_status,a0,w
	jreq	posb9

	movi	p1_state,a7
	cmpi	1,a0
	jreq	mint3
	movi	p2_state,a7
mint3	move	*a7,a7,w
	cmpi	ps_active,a7
	jrne	posb9			; winner = drone: no badge

	movi	00010000dH,a4		; assume player 1
	move	@winner_status,a0,w	; who won the last match ?
	cmpi	1,a0			; player 1 ?
	jreq	mint2			; yes, we are cool
	movi	000100153H,a4		; player 2 side
mint2	movi	MKCOIN_01,a5
	calla	gso_dmawnz_ns_coor
	calla	insobja8
	create	pid_bani,badge_spinner
*
* print "?? Wins in a Row"
*
	movi	022H,a6			; x position for player 1
	movi	pf_iar_num,a8		; msg: "x wins in a row"
	move	@winner_status,a0,w
	movi	p1_wiar,a7
	cmpi	1,a0
	jreq	mint1
	movi	p2_wiar,a7		; a7 = "wins in a row"
	movi	016cH,a6			; x position for player 2
mint1	move	*a7,a0,w
	move	a0,@pf_ram,l
	cmpi	2,a0			; a0 = # of wins in a row
	jrhs	mint0			; 2 or more ---> "x wins in a row"

	movi	pf_new_champ,a8		; 1 win ---> "new champ"
mint0	calla	lm_setup
	movx	a6,a9
	jsrp	printf
posb9	retp


pf_iar_num
	mess_mac rd7font,2,030H,03aH,bpal_yellow*010000H,strcnrmos_scr,0
	.byte	"%d WINS",0
	.long	pf_ram
	.even

pf_new_champ
	mess_mac rd7font,2,200,03aH,bpal_yellow*010000H,strcnrmos_scr,0
	.string	"CHAMPION",0
	.even

badge_spinner
	movi	a_badge_spin,a9
	movk	5,a0
	jsrp	framew
	jauc	wait_forever

a_badge_spin
	.long	MKCOIN_01
	.long	MKCOIN_02
	.long	MKCOIN_03
	.long	MKCOIN_04
	.long	MKCOIN_05
	.long	MKCOIN_06
	.long	MKCOIN_07
	.long	MKCOIN_08
	.long	MKCOIN_09
	.long	ani_jump,a_badge_spin

background_names
	.long	txt_subway
	.long	txt_steet
	.long	txt_bank
	.long	txt_roof
	.long	txt_tower
	.long	txt_bridge
	.long	txt_soul
	.long	txt_bell
	.long	txt_temple
	.long	txt_grave
	.long	txt_pit

txt_subway
	.string	"KOMBAT ZONE: THE SUBWAY",0
	.even

txt_steet
	.string	"KOMBAT ZONE: THE STREET",0
	.even

txt_bank
	.string	"KOMBAT ZONE: THE BANK",0
	.even

txt_roof
	.string	"KOMBAT ZONE: ROOFTOP",0
	.even

txt_tower
	.string	"KOMBAT ZONE: THE BALCONY",0
	.even

txt_bridge
	.string	"KOMBAT ZONE: THE BRIDGE",0
	.even

txt_soul
	.string	"KOMBAT ZONE: SOUL CHAMBER",0
	.even

txt_bell
	.string	"KOMBAT ZONE: SHAO KAHN TOWER",0
	.even

txt_temple
	.string	"KOMBAT ZONE: THE TEMPLE",0
	.even

txt_grave
	.string	"KOMBAT ZONE: GRAVEYARD",0
	.even
txt_pit
	.string	"KOMBAT ZONE: THE PIT 3",0
	.even


smoke_pick_a0
	move	@f_smoke,a14,w		; smoke activated ?
	jreq	smpick9			; no
	move	a1,a0			; yes !!
smpick9	rets


ochar_picked_palettes
	.long	HDKANOD_P
	.long	HDSOYND_P
	.long	HDJAXD_P
	.long	HDINDYD_P
	.long	HDSUBZD_P
	.long	HDSWATD_P
	.long	HDBRDED_P
	.long	HDKETCD_P
	.long	HDMUSTD_P
	.long	HDLAOD_P
	.long	HDSANDD_P
	.long	HDGOROD_P
	.long	HDSHAGD_P
	.long	HDKANGD_P
	.long	0


HDKANOD_P:
   .word   128
   .word   00000h,00000h,0631fh,031cbh,014c1h,02527h,0252ah,0631ah
   .word   0631ch,04a57h,05efdh,01062h,062d8h,062d9h,062b7h,05e96h
   .word   049f2h,04526h,02485h,00000h,02ceah,05634h,02066h,0454bh
   .word   055adh,04d8dh,059f0h,06254h,0452ah,02487h,01c67h,055aeh
   .word   051afh,02cebh,03d0ah,0454ch,05e34h,024cbh,02466h,038c8h
   .word   00c05h,0518eh,02ccah,06212h,055f2h,049b1h,01c03h,02024h
   .word   02c87h,00003h,0412ch,04d8fh,051b0h,00c01h,02046h,055b0h
   .word   024aah,00002h,030a9h,0310dh,05a9ah,01402h,01803h,03466h
   .word   02c88h,0454eh,05e57h,00000h,048eah,04d0bh,034a9h,038cah
   .word   01c02h,00404h,01448h,055f4h,06257h,01c05h,0590bh,01427h
   .word   00000h,01402h,04c87h,05d6fh,01c69h,05d2dh,0392fh,00402h
   .word   02c05h,03468h,01c00h,02c03h,01003h,030cch,04c26h,04c47h
   .word   02005h,02c48h,061f5h,01000h,03c01h,05004h,02003h,03c27h
   .word   0510eh,044edh,03000h,02c02h,04004h,04005h,03c06h,060cch
   .word   05405h,06069h,00000h,05c28h,060ach,020ach,03951h,0627ah
   .word   024eeh,02d30h,03151h,041d5h,0567ah,062ddh,04617h,04e59h

HDSOYND_P:
   .word   128
   .word   00000h,00000h,03802h,03002h,02402h,03c05h,00006h,00008h
   .word   00009h,00004h,010adh,029b0h,00004h,039d4h,04216h,056bbh
   .word   0631eh,05672h,062fbh,05a72h,00800h,01022h,00402h,00004h
   .word   049f0h,0356fh,0312ch,062b8h,04a14h,05abbh,01402h,01c44h
   .word   00001h,028c9h,0416dh,0310bh,05612h,05e54h,05634h,041b1h
   .word   045d2h,05656h,05a77h,062b9h,03db2h,024ech,0290dh,03592h
   .word   030eah,0392ch,049b0h,05a34h,05e55h,01c67h,0350bh,028cah
   .word   049d2h,05a56h,05e77h,01026h,03d2ch,01447h,00804h,034eah
   .word   03d4eh,01c89h,055f2h,01404h,030a8h,03d0bh,02488h,04590h
   .word   03087h,034a8h,02467h,03ceah,024aah,00806h,01826h,02ccbh
   .word   04d90h,01004h,01405h,02068h,0452dh,04170h,028edh,02d0eh
   .word   01804h,02c89h,04970h,02426h,00c05h,05191h,02003h,00803h
   .word   00c04h,00801h,034cch,01801h,04cabh,04800h,00000h,00c00h
   .word   01c01h,02802h,02402h,02c03h,00001h,00002h,04007h,00002h
   .word   0346ah,00001h,0388bh,0308bh,028ach,04617h,00002h,00004h
   .word   00006h,00428h,014ach,01ceeh,02530h,04a59h,05addh,0631fh

HDJAXD_P:
   .word   128
   .word   01ce7h,00000h,0673fh,04993h,03593h,00005h,00829h,039b5h
   .word   00008h,00c4ah,00007h,02511h,02d53h,0082bh,0040ah,00c4ch
   .word   0106dh,0148eh,020f1h,02512h,018b0h,01cd1h,020f2h,00003h
   .word   00004h,02d74h,0108bh,01ceeh,04638h,04a59h,04e7ah,031b4h
   .word   03e17h,00869h,039f5h,056dch,0633eh,0673ch,0673eh,0671bh
   .word   066f9h,066d8h,05eb8h,0498bh,049f2h,066d9h,0456ch,055f0h
   .word   05e54h,03084h,028c9h,05a55h,01c45h,02cc9h,0350bh,0416eh
   .word   051f2h,05613h,05e55h,041b1h,03ca5h,02444h,02865h,030a7h
   .word   038e9h,0412bh,028a8h,0454ch,04d8eh,02466h,03ce9h,02887h
   .word   034eah,0518eh,0414dh,04df3h,01c00h,01004h,034c9h,02088h
   .word   055d1h,01c03h,01003h,01c46h,03d0bh,0412ch,0496eh,02ccah
   .word   04dd2h,02424h,05df2h,01447h,0392dh,05614h,01002h,01868h
   .word   04990h,04db1h,020aah,06677h,02401h,01c04h,03466h,00402h
   .word   00c04h,05190h,00802h,03025h,01405h,00002h,00002h,00403h
   .word   00003h,00404h,00805h,00c06h,01448h,04992h,01048h,01469h
   .word   020cch,024edh,0148ah,020edh,00002h,018cch,02950h,05efdh

HDINDYD_P:
   .word   128
   .word   02d6bh,00000h,06b5fh,00002h,020d1h,00005h,010d2h,0006bh
   .word   00007h,0004ah,00d74h,00006h,000aeh,00176h,00112h,00007h
   .word   0025fh,0023dh,0008ch,001b8h,00175h,001fah,000efh,000cch
   .word   00150h,001b3h,00005h,00003h,06b5ah,06ae0h,06b17h,04560h
   .word   024a0h,030e0h,06a20h,02cc0h,01464h,06ad4h,00802h,01886h
   .word   01c62h,04127h,03907h,01466h,02463h,030a4h,034e7h,028a6h
   .word   04549h,05e31h,03083h,06630h,055ceh,06502h,01001h,01c22h
   .word   04928h,059ach,055adh,03484h,05dceh,00000h,02c21h,04482h
   .word   0452ah,0494bh,034e9h,04d6ch,05df0h,01007h,04062h,050a3h
   .word   00801h,038a6h,0516ch,060a2h,04063h,03043h,0454ch,04d8eh
   .word   05c61h,03821h,03022h,02c65h,028a8h,03401h,01001h,02402h
   .word   01c24h,020a9h,03c86h,04d8fh,04065h,034a8h,04ca7h,038a8h
   .word   03cc9h,01403h,05001h,02c67h,03c01h,01401h,050a8h,02425h
   .word   04401h,03801h,068ebh,00000h,01001h,00401h,02847h,00403h
   .word   00805h,020cbh,018aah,00002h,00426h,00847h,01089h,018cbh
   .word   01cech,0294fh,02d70h,039d3h,04215h,04a57h,056bah,0631dh

HDSUBZD_P:
   .word   128
   .word   00000h,00000h,0631fh,00007h,0000bh,00c3eh,01497h,02d5dh
   .word   00415h,020ffh,01cdbh,00014h,00019h,000beh,0001eh,0001ch
   .word   00017h,00cdfh,0083fh,0000ch,00010h,00010h,00856h,00c74h
   .word   0253ch,035dah,00076h,039fah,01d36h,02ddah,01d78h,01d99h
   .word   025b9h,000d4h,01136h,00074h,000b3h,000d3h,004f4h,01157h
   .word   01578h,00093h,00071h,000d4h,00537h,01599h,000f7h,000b4h
   .word   00118h,000d5h,00159h,00579h,04235h,00c69h,049f0h,062fch
   .word   062dah,01c00h,01025h,05a55h,02cc9h,06276h,030a7h,01846h
   .word   01c24h,02045h,03d2ch,04db0h,04190h,05214h,02067h,034eah
   .word   028a9h,02ccah,0456eh,0392dh,028ech,02866h,03d0bh,02488h
   .word   04d8fh,06234h,05614h,01c25h,02046h,01426h,030cah,05df2h
   .word   0414eh,02888h,06299h,01004h,01003h,01404h,01805h,059b1h
   .word   034ech,04991h,05e9ah,0512dh,03004h,00804h,0208ah,01c03h
   .word   04488h,04003h,03c03h,00402h,050cbh,04426h,054aah,05d0dh
   .word   0308ah,03402h,00001h,00002h,00004h,00002h,00006h,00007h
   .word   018cdh,0210fh,02530h,02d72h,039d5h,03df6h,04a59h,056bch

HDSWATD_P:
   .word   128
   .word   02532h,00000h,0631fh,010abh,014cch,03e15h,018cbh,00848h
   .word   00c69h,018cch,01cedh,0252fh,0210eh,0631dh,04a58h,0529ah
   .word   024e7h,062fbh,062d9h,049f1h,02484h,00804h,020a8h,062b8h
   .word   01423h,028a6h,05633h,034c5h,02043h,01823h,00402h,04949h
   .word   062b9h,05edch,01c88h,01c45h,034e9h,0454bh,06276h,04109h
   .word   02487h,02cebh,0352dh,00000h,0496dh,0414dh,055d0h,01447h
   .word   024cbh,05214h,06298h,05657h,03ca6h,02c65h,01c46h,00c05h
   .word   028a9h,02ccah,0456eh,04dd2h,02001h,034c9h,059f2h,05e13h
   .word   06234h,04590h,04463h,030cah,04d6eh,034ebh,055b0h,059d1h
   .word   03d2dh,051d2h,06256h,05636h,02025h,04990h,05215h,01803h
   .word   01826h,0598fh,038ebh,03d0ch,0454eh,0496fh,03088h,0452dh
   .word   06214h,030cbh,034ech,0414fh,04570h,04db2h,06257h,04402h
   .word   01002h,02868h,0352fh,01c04h,00804h,055b2h,00803h,01801h
   .word   01c48h,00401h,01003h,01004h,02005h,04002h,04004h,00c02h
   .word   04c05h,02c04h,00001h,02404h,01804h,00002h,00001h,01428h
   .word   0350fh,00002h,00003h,00004h,00006h,00007h,02d72h,035b4h

HDBRDED_P:
   .word   128
   .word   0318ch,00000h,05adfh,048b1h,044b2h,03892h,03052h,02832h
   .word   01c11h,01410h,00c10h,0040fh,0000eh,0399ch,00001h,0529ch
   .word   00005h,04a16h,05a9ah,03150h,0106bh,01027h,05a79h,03594h
   .word   05658h,0208ah,04df5h,05a58h,05a7ah,02425h,01827h,02069h
   .word   028abh,030edh,0350eh,0392fh,049b3h,05a37h,02003h,01c48h
   .word   038ech,02847h,01806h,02469h,02cabh,0390eh,059d3h,01c6ah
   .word   04571h,04992h,05a16h,00808h,05217h,04a18h,01428h,030cch
   .word   04150h,00006h,028cdh,03951h,01cadh,041d6h,02448h,01407h
   .word   0248bh,04550h,04d92h,051b3h,030eeh,04172h,0308ah,01828h
   .word   0452fh,04950h,028ach,059d4h,02ccdh,00803h,01406h,03069h
   .word   038abh,040edh,0288bh,030cdh,04151h,04db4h,01405h,00c07h
   .word   00001h,038cdh,0410fh,04530h,04d72h,045b5h,00003h,00404h
   .word   00c06h,0248ch,028adh,00c05h,01006h,01002h,00001h,00002h
   .word   00002h,00003h,00001h,00004h,00004h,05abeh,00003h,00004h
   .word   00005h,00007h,00008h,0042ah,00c6ch,0108dh,018cfh,02111h
   .word   02532h,02953h,03195h,035b6h,039d7h,03df8h,0463ah,04a5bh

HDKETCD_P:
   .word   128
   .word   020ech,00000h,0633fh,0208bh,00005h,041d5h,0527ah,02930h
   .word   04e39h,01c6dh,00002h,00004h,00005h,0108bh,04a39h,0210fh
   .word   035b4h,039d5h,04638h,04217h,05efeh,00409h,03595h,0417ah
   .word   0100fh,02d15h,0084ah,00c6ch,0527fh,01052h,00008h,0000ch
   .word   041ffh,0042eh,0317dh,02d77h,01499h,04a5fh,01cf9h,018d7h
   .word   0000eh,00011h,0000eh,0000ah,00010h,00008h,00033h,00005h
   .word   00454h,00c95h,010b6h,00011h,00474h,00166h,00182h,00264h
   .word   00102h,00203h,00062h,00064h,000c2h,00263h,00001h,0396eh
   .word   01824h,05a56h,055d1h,04443h,0612ah,04dd2h,03c00h,0616dh
   .word   02000h,03800h,04e15h,03803h,038cah,02c00h,04866h,054a8h
   .word   040cah,02000h,03825h,03c67h,03c88h,04d0ch,0392eh,04004h
   .word   05088h,04ca9h,01400h,02004h,0492eh,02c04h,00000h,00c00h
   .word   00803h,01805h,02827h,03048h,0388ah,02448h,01827h,00002h
   .word   01448h,00003h,024cch,00827h,03d71h,04a16h,04e58h,00003h
   .word   00027h,00869h,00c8ah,014cch,018edh,01d0eh,02971h,031b3h
   .word   04658h,04a79h,04e9ah,056dch,04e99h,04e73h,03df0h,05ef8h

HDMUSTD_P:
   .word   128
   .word   0318ch,00000h,02406h,02008h,00406h,045d6h,00003h,00005h
   .word   00c29h,00004h,00002h,00005h,00003h,00007h,00004h,00408h
   .word   02d32h,03995h,00c4ah,0525ch,04619h,020f0h,062f6h,00000h
   .word   06260h,05600h,05603h,05e8eh,055e1h,00800h,03920h,04980h
   .word   04da0h,04da1h,03d41h,04583h,03523h,05a28h,01020h,03d20h
   .word   04560h,024a1h,05a2ah,01c60h,028a0h,04961h,01862h,04586h
   .word   03105h,01840h,030c0h,034e0h,034e1h,04d83h,04143h,02ce5h
   .word   049a9h,01022h,024a4h,049cdh,02ca1h,01842h,028c6h,03d6bh
   .word   00400h,01c41h,038e2h,03d26h,01444h,018abh,02442h,020a9h
   .word   00000h,0354fh,00804h,01cabh,02d2fh,01c02h,040c8h,00004h
   .word   01048h,020cch,03150h,00002h,030cbh,00c06h,0288ah,00800h
   .word   01400h,01c02h,01c00h,02800h,02c00h,02c02h,00000h,00000h
   .word   00000h,03401h,02c01h,02801h,02001h,01402h,01004h,02c8bh
   .word   0246ah,0288bh,02cach,00c07h,00004h,028eeh,0146ah,02d0fh
   .word   01cach,024eeh,03572h,05a7ah,03993h,03db4h,04a17h,04e38h
   .word   05259h,0567ah,05a9bh,04617h,02808h,03267h,03272h,0341fh

HDLAOD_P:
   .word   128
   .word   018c6h,00000h,0631fh,030ceh,02cceh,0248ch,024aeh,01c6ch
   .word   00006h,01c8eh,00005h,0188dh,0106bh,01086h,0631ch,0631eh
   .word   062f8h,04e55h,03d8bh,00001h,01c86h,062dah,05677h,028eah
   .word   01c21h,02cc7h,0418eh,05212h,02c83h,04128h,02043h,038e7h
   .word   02486h,01c66h,02cc8h,030e9h,0414bh,0350ah,024a8h,0498dh
   .word   049afh,04dd0h,06275h,06297h,045d2h,062b9h,03db2h,03d90h
   .word   02044h,01824h,038e8h,03d2bh,02cc9h,0414ch,0456dh,0498eh
   .word   0392ch,03d4dh,05a34h,05e55h,01425h,0352dh,0394eh,02088h
   .word   00c02h,01868h,055f2h,0350ch,01426h,0352eh,00002h,01005h
   .word   01c68h,02cech,05215h,01803h,00c03h,028aah,01004h,00001h
   .word   00404h,00805h,01c8ah,05e9ah,00403h,00002h,034cch,04d50h
   .word   02449h,030ach,0410fh,00002h,00004h,024cdh,051f6h,01049h
   .word   05a38h,03130h,05217h,00006h,03d93h,03151h,041d5h,045f6h
   .word   0250fh,020eeh,00001h,00002h,00003h,00004h,00005h,00006h
   .word   00007h,00428h,00849h,00c6ah,0108bh,01ceeh,02951h,03193h
   .word   035b4h,03df6h,04638h,04e7ah,0529bh,056bch,05addh,018cch

HDSANDD_P:
   .word   128
   .word   02d6bh,00000h,06b7fh,00c03h,01404h,00001h,014aah,01ceeh
   .word   00002h,00003h,00005h,02130h,0254fh,0214eh,00022h,00062h
   .word   00040h,00060h,000a0h,000e0h,00100h,00140h,000c2h,00001h
   .word   00064h,00003h,00466h,00003h,04e93h,018eah,0212ch,04234h
   .word   04a76h,052b8h,056d9h,056b3h,04630h,06738h,04a52h,01ce7h
   .word   02d6bh,018c7h,056b6h,02d6ch,04e51h,00002h,020c4h,02929h
   .word   04a31h,0294ch,041aah,00822h,03548h,03969h,045cch,020c6h
   .word   045efh,0210bh,00c00h,00801h,01c84h,02d08h,020c7h,0354ah
   .word   01486h,018a7h,018c9h,039d1h,00c44h,028c6h,01022h,01c85h
   .word   03d6bh,03d8dh,00800h,0290ah,01465h,0314ch,041d0h,00000h
   .word   01023h,00824h,039b0h,01444h,00000h,00001h,01000h,01c02h
   .word   01c01h,02004h,00001h,00002h,00003h,00846h,041f3h,014a9h
   .word   03190h,04a56h,00002h,00003h,00004h,00025h,00446h,00867h
   .word   00c88h,010a9h,014cah,018ebh,01d0ch,0212dh,0254eh,0296fh
   .word   02d90h,031b1h,035d2h,039f3h,03e14h,04656h,04a77h,04e98h
   .word   052b9h,05afbh,0633dh,0675eh,04a76h,052b8h,056d9h,056b3h

HDGOROD_P:
   .word   128
   .word   02108h,00000h,00004h,00002h,00001h,00000h,00006h,00005h
   .word   00000h,00001h,00003h,00004h,00004h,00001h,00003h,00005h
   .word   00006h,00001h,00002h,00006h,00402h,00802h,00805h,00848h
   .word   00c04h,00c45h,00c69h,01000h,01022h,01024h,01045h,01089h
   .word   0108ah,01405h,01867h,01468h,014abh,014b0h,01864h,018ach
   .word   018cbh,018cch,01c00h,01ca4h,01ca7h,01ca8h,01caah,02006h
   .word   020a8h,020a9h,020abh,02407h,024c4h,024c7h,024c9h,024ebh
   .word   028e9h,0292ch,0294fh,02c00h,02c08h,02d0bh,03008h,030eah
   .word   03107h,0310ah,03401h,03465h,034e7h,03505h,0352bh,0354dh
   .word   0392ah,03946h,0394bh,0394dh,039b1h,03c62h,03d4ch,03d6bh
   .word   03d6ch,03d8dh,03d8fh,04023h,0418fh,04400h,04587h,04589h
   .word   0458dh,045aeh,04637h,04866h,049aeh,049cfh,04dceh,04dcfh
   .word   04df1h,04e0fh,051eeh,051f0h,05211h,05212h,05234h,05487h
   .word   05611h,05632h,058e9h,05ab7h,05d29h,05d2ch,05e36h,05e53h
   .word   05eb6h,0616dh,06274h,06296h,062f9h,065afh,065d2h,06636h
   .word   06695h,06696h,066b6h,066d7h,066f9h,06719h,0673ah,0673ch

HDSHAGD_P:
   .word   128
   .word   035adh,00000h,0631fh,00002h,00005h,06209h,02040h,01c20h
   .word   02860h,061c8h,061eah,04d02h,05123h,02020h,048e2h,044e3h
   .word   05d87h,00003h,04a37h,02021h,04d04h,05546h,05d88h,061cbh
   .word   01446h,028c9h,020a9h,00005h,05235h,02820h,03ca3h,04906h
   .word   01c88h,02d0ch,024ech,05678h,05a99h,01000h,01800h,02465h
   .word   03d4dh,0416eh,05a34h,01c00h,02400h,03462h,02422h,048c4h
   .word   040a4h,034a6h,01425h,01400h,02c21h,01801h,02865h,02c86h
   .word   01004h,02088h,051d1h,024cbh,04190h,045d3h,01c01h,030ebh
   .word   0498fh,03d4eh,0416fh,04dd2h,028ech,04e15h,01c03h,061aeh
   .word   00003h,04d8fh,0350ch,05ebbh,04ca5h,00004h,04db1h,055f3h
   .word   0352eh,06256h,045b2h,00806h,0310dh,05a14h,04df4h,02001h
   .word   03c65h,0594ch,028aah,02ccbh,01000h,01401h,02004h,01027h
   .word   020abh,00000h,00404h,034ech,02d0eh,01427h,05e15h,0352fh
   .word   00c00h,01848h,055b2h,03950h,00402h,00400h,04d92h,00800h
   .word   00002h,00002h,00003h,03593h,00001h,00004h,00005h,00007h
   .word   00849h,00c6ah,0108bh,014ach,018cdh,0210fh,02530h,00000h

HDKANGD_P:
   .word   128
   .word   02529h,00000h,05adfh,03807h,03407h,03808h,04009h,01402h
   .word   03c04h,04c05h,02406h,02c08h,05975h,05996h,059b7h,059d9h
   .word   05a1dh,0521ch,00005h,05adch,03df6h,05adeh,05609h,0562dh
   .word   05a97h,055eah,051edh,05210h,055c8h,05234h,05a99h,05212h
   .word   05168h,05236h,05547h,05a35h,05636h,05a57h,04908h,050e5h
   .word   01826h,051b0h,05a14h,05a36h,04cc5h,050e6h,048c6h,03087h
   .word   059d1h,059f3h,02cedh,044a6h,02468h,04064h,02047h,04d6fh
   .word   055b1h,028abh,0414fh,04db2h,04171h,04592h,02003h,04086h
   .word   038a9h,030aah,01c48h,0412eh,0454fh,01402h,03c44h,03024h
   .word   03c66h,01c04h,02005h,01405h,03089h,038cbh,03cech,0410dh
   .word   0288ah,02cabh,02ceeh,05a16h,028cdh,00400h,01400h,01c02h
   .word   04844h,02c8ah,03c02h,03002h,00c05h,0410eh,00000h,00000h
   .word   02401h,01001h,03069h,01802h,00004h,05a5ah,0450fh,00002h
   .word   00402h,00c03h,048adh,03002h,03005h,05008h,00002h,00c05h
   .word   0588dh,058cfh,00001h,00004h,05911h,05953h,0106ch,00001h
   .word   00003h,00006h,00007h,00008h,0042ah,014aeh,02111h,02d74h

**************************************************************************

	.end
