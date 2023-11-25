**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: main.asm ---  main game flow							*
* 											     *
*  copyright (c) 1994 Midway Manufacturing							*
*											     *
**************************************************************************
	.file	'mkguys.asm'
	.width	132
	.option	b,d,l,t
	.mnolist
*
* get the system stuff
*
	.include dispequ.asm
	.include sysequ.asm
	.include macros.hdr
	.include mainequ.asm
	.include imgtbl.glo

	.text

**************************************************************************
*											     *
*                      SEARCH FOR XXX							     *
*                      SEARCH FOR XXX							     *
*                      SEARCH FOR XXX							     *
*											     *
**************************************************************************


**************************************************************************
*											     *
*  setup_players - Create the objects and procs for both players !!	     *
*											     *
**************************************************************************
setup_players
	move	@p1_char,a0,w
	movi	p1_shadadj,a1
	callr	stuff_shad_adj		; setup shadow adjust ram
	move	@p2_char,a0,w
	movi	p2_shadadj,a1
	callr	stuff_shad_adj		; setup shadow adjust ram

	move	@rand,a0,l
	jrn	advantage_p1

	callr	setup_player_2
	callr	setup_player_1
	jruc	init_p_others

advantage_p1
	callr	setup_player_1
	callr	setup_player_2

init_p_others
	move	@p1_obj,a8,l
	move	@p2_obj,a9,l
	move	@p1_proc,a0,l
	move	@p2_proc,a1,l
	move	a0,*a1(p_otherproc),l
	move	a1,*a0(p_otherproc),l
	move	a8,*a1(p_otherguy),l
	move	a9,*a0(p_otherguy),l
	rets


setup_player_1
	callr	make_player_1_obj
	movi	pid_p1,a1		; set proc id
	movi	drone_begin,a7
	move	@p1_state,a0,w
	cmpi	ps_active,a0
	jrne	sag6
	movi	joy_begin,a7
sag6	calla	getprc
	move	a0,@p1_proc,l
	move	*a8(oypos),*a0(p_ganiy),w		; set the grounded y pos
	move	a8,*a0(pa8),l				; pass a8 to proc

	calla	clear_p_ram				; clear process ram
	move	*a8(oypos),*a0(p_ganiy),w		; set grounded y (player 2)
	movi	switch,a1
	move	a1,*a0(p_joyport),l
	movi	switch+33,a1
	move	a1,*a0(p_butport),l			; setup switch stuff
	movi	character_palettes_1,a0
	callr	get_player_palette
	calla	insobja8
	rets


setup_player_2
	calla	make_player_2_obj
	movi	pid_p2,a1		    	; set proc id
	movi	drone_begin,a7
	move	@p2_state,a0,w
	cmpi	ps_active,a0
	jrne	sag7
	movi	joy_begin,a7
sag7	calla	getprc

	move	*a8(oypos),*a0(p_ganiy),w	; set the grounded y pos
	move	a8,*a0(pa8),l		    	; pass a8 to proc
	calla	clear_p_ram		    	; clear process ram

	move	*a8(oypos),*a0(p_ganiy),w	; set grounded y (player 2)
	movi	switch+8,a1
	move	a1,*a0(p_joyport),l
	movi	switch+25,a1
	move	a1,*a0(p_butport),l		; setup switch stuff
	move	a0,@p2_proc,l
*
* player 2 ---> check player 1 ochar (dont use same palette)
*
	movi	character_palettes_1,a0	; assume "normal" palettes
	move	@gstate,a4,w
	cmpi	gs_psel,a4
	jreq	sag9				; player select = normal palette

	push	a0
	callr	q_nice_pal			; can I use the nice pal ???
	pull	a0
	jrc	sag9				; yes

;	move	@p1_char,a2,w
;	move	@p2_char,a1,w
;	cmp	a2,a1				; same character ?
;	jrne	sag9				; no

	move	*a8(oflags2),a0,w
	ori	m_ugly_pal,a0
	move	a0,*a8(oflags2),w		; set the "ugly" bit
	movi	character_palettes_2,a0	; yes, use alternate palettes

sag9	callr	get_player_palette
	calla	insobja8
	rets


make_player_1_obj
	move	@p1_char,a0,w
	movk	1,a1			; shadow = yes
	clr	a2			; player = 1
	movi	p1_ram,a6		; a6 = input: multipart ram
	callr	make_player_obj		; a8 = player 1 object

	move	a8,@p1_obj,l   		; player 1 object
	movi	oid_p1,a0
	move	a0,*a8(oid),w
	movi	front_z,a0
	move	a0,*a8(ozval),l		; set x
	callr	set_x_woff  		; player 1 x offset
	clr	a9
	jauc	do_first_a9_frame	; pose: stance frame #1

make_player_2_obj
	move	@p2_char,a0,w
	movk	1,a1			; shadow = yes
	movk	1,a2			; player = 2
	movi	p2_ram,a6		; a6 = input: multipart ram
	callr	make_player_obj

	move	a8,@p2_obj,l   		; a8 = player 2 object
	movi	oid_p2,a0
	move	a0,*a8(oid),w
	movi	back_z,a0
	move	a0,*a8(ozval),l		; set x

	callr	set_x_woff  		; player 1 x offset
	clr	a9
	calla	do_first_a9_frame	; pose: stance frame #1
	jauc	flip_multi


get_player_palette
	calla	get_char_long
	calla	getfpal
	move	a0,*a8(opal),l
	rets


set_x_woff
	movi	>60,a3
	move	*a8(ochar),a0,w
	cmpi	ft_motaro,a0
	jrne	setx3
	addi	>30,a3
setx3	move	@worldtlx+16,a2,w
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	setx6
	addi	scrrgt,a2
	neg	a3
setx6	add	a3,a2
	move	a2,*a8(oxpos),w
	rets


stuff_shad_adj
	sll	4,a0
	addi	shadow_adjustments,a0
	move	*a0,a0,w
	move	a0,*a1,w
	rets

;xxx
shadow_adjustments
	.word	-6	;  0 - kano
	.word	-6	;  1 - sonya
 	.word	-10	;  2 - jax
	.word	-10	;  3 - indian
	.word	-6	;  4 - turk (subzero)
	.word	-6	;  5 - swat dude
	.word	-10	;  6 - lia
	.word	-8	;  7 - robot ninja
	.word	-8	;  8 - robot ninja
	.word	-13	;  9 - kung lao
	.word	-6	; 10 - tusk
	.word	-6	; 11 - she goro
	.word	->0c	; 12 - shang tsung
	.word	->0c	; 13 - liu kang
	.word	-8	; 14 - smoke
	.word	-6	; 15 - motaro
	.word	-6	; 16 - shao kahn
	.word	-6	; 17 - noob saibot (kano)


get_char_ani2
	movi	character_anitabs2,a14	; a14 ---> proper anitab
	jruc	gca5

get_char_ani
	movi	character_anitabs1,a14	; a14 ---> proper anitab

gca5	move	*a8(ochar),a0,w
	sll	5,a0
	add	a14,a0
	move	*a0,a0,l
	sll	5,a9
	add	a0,a9
	move	*a9,a9,l		; a9 = correct animation
	rets

;xxx
character_anitabs1
	.long	kano_anitab1
	.long	sonya_anitab1
	.long	jax_anitab1
	.long	ind_anitab1
	.long	sz_anitab1
	.long	swat_anitab1
	.long	lia_anitab1
	.long	robo_anitab1
	.long	robo_anitab1
	.long	lao_anitab1
	.long	tusk_anitab1
	.long	sg_anitab1
	.long	st_anitab1
	.long	lk_anitab1
	.long	robo_anitab1
	.long	mot_anitab1
	.long	sk_anitab1
	.long	kano_anitab1

;xxx
character_anitabs2
	.long	kano_anitab2
	.long	sonya_anitab2
	.long	jax_anitab2
	.long	ind_anitab2
	.long	sz_anitab2
	.long	swat_anitab2
	.long	lia_anitab2
	.long	robo_anitab2
	.long	robo_anitab2
	.long	lao_anitab2
	.long	tusk_anitab2
	.long	sg_anitab2
	.long	st_anitab2
	.long	lk_anitab2
	.long	robo_anitab2
	.long	mot_anitab2
	.long	sk_anitab2
	.long	kano_anitab2



stance_setup
	movi	act_stance,a0
	move	a0,*a13(p_action),w

	move	a9,a5			; a10 = previous frame
	clr	a9			; assume animation #0
	calla	get_char_ani

;	move	*a8(ochar),a0,w
;	cmpi	ft_robo2,a0
;	jrne	stset2
;	movk	10,a9
;	calla	get_char_ani		; robo 2 stance

stset2	move	a9,a7			; a7 = stance frame #1

	movi	stance_speeds,a0
	calla	get_char_word
	calla	init_anirate		; set animation speed

stset0	move	*a7,a0,l
	cmpi	ani_ochar_jump,a0
	jrne	stset1
	move	*a7(32+32),a7,l
	jruc	stset0

stset1	addi	32*6,a7			; at least this far !!
stset3	move	*a7+,a0,l
	cmpi	ani_jump,a0		; are we at the "loop back" part ?
	jrne	stset3
	cmp	a7,a5
	jrhi	stset8			; we were not in stance ---> new ani
	cmp	a9,a5
	jrlo	stset8			; we were not in stance ---> new ani
	move	a5,a9			; we were in stance ---> keep same ani
stset8	rets

	
;xxx
stance_speeds
	.word	6       ;  0 - kano
	.word	6	;  1 - sonya
	.word	6	;  2 - jax
	.word	6	;  3 - indian
	.word	6	;  4 - turk (subzero)
 	.word	6	;  5 - swat
	.word	6	;  6 - lia
	.word	6	;  7 - robot ninja
	.word	6	;  8 - robot ninja
	.word	6	;  9 - kung lao
	.word	6	; 10 - tusk
	.word	6	; 11 - she goro
	.word	6	; 12 - shang tsung
	.word	4	; 13 - kang
	.word	6	; 14 - robot ninja
	.word	6	; 15 - motaro
	.word	8	; 16 - shao kahn
	.word	6       ;  0 - kano

**************************************************************************
*											     *
*  get_walk_info_f - Returns the following walk forward info		     *
* 											     *
*  a0 = walk forward animate speed							     *
*  a1 = walk forward velocity								     *
*  a2 = walk forward ani offset								     *
*											     *
**************************************************************************
get_walk_info_b
	movk	2,a2			; walk backward ani = 2
	movi	walk_backward_info,a0
	callr	decode_walk_table
	neg	a1
	jruc	walk_flip_reverse

get_walk_info_f
	movk	1,a2			; walk forward ani = 1
	movi	walk_forward_info,a0
	callr	decode_walk_table

walk_flip_reverse
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	gwi9
	neg	a1
gwi9	rets

decode_walk_table
	calla	get_char_long
	move	a0,a1
	zext	a0,w			; a0 = animation speed
	srl	16,a1
	sll	4,a1			; a1 = vel
	rets


;xxx
walk_forward_info
	.word	5,>3800		;  0 - kano
	.word	5,>3000		;  1 - sonya
	.word	5,>3000		;  2 - jax
	.word	5,>3400		;  3 - indian
	.word	5,>3400		;  4 - turk (subzero)
	.word	5,>3000		;  5 - swat
	.word	5,>3800		;  6 - lia
	.word	5,>3400		;  7 - robot ninja
	.word	5,>3400		;  8 - robot ninja
	.word	5,>3400		;  9 - kung lao
	.word	5,>3000		; 10 - tusk
	.word	5,>3000		; 11 - she goro
	.word	5,>3200		; 12 - shang tsung
	.word	5,>3200		; 13 - kang
	.word	5,>3400		; 14 - robot ninja
	.word	5,>4000		; 15 - motaro
	.word	4,>4200		; 16 - motaro
	.word	3,>5000		; 17 - noob saibot


;xxx
walk_backward_info
	.word	5,>2400		; 0 - kano
	.word	5,>2400		; 1 - sonya
	.word	5,>2400		; 2 - jax
	.word	5,>2400		; 3 - indian
	.word	5,>2400		; 4 - turk (subzero)
	.word	5,>2400		; 5 - swat
	.word	5,>2400		; 6 - lia
	.word	5,>2400		; 7 - robo
	.word	5,>2400		; 8 - robo
	.word	5,>2400		; 9 - kung lao
	.word	5,>2400		;10 - tusk
	.word	5,>2400		;11 - she goro
 	.word	5,>2400		;12 - shang tsung 
	.word	5,>2400		;13 - kang
	.word	5,>2400		;14 - robo
	.word	5,>3000		;15 - motaro
	.word	4,>3000		;16 - shao kahn
	.word	4,>4000		;17 - noob saibot

**************************************************************************
*											     *
*  make_player_obj										*
* 											     *
*  input: a0 = ochar offset							     	*
*         a1 = shadow flag (1=shadow  0=sans shadow)				     *
*         a2 = 0-1 for player 1 or 2								*
* 											     *
**************************************************************************
make_player_obj
	mmtm	sp,a0,a1,a7
	move	a0,a9

	clr	a5
	movi	character_palettes_1,a3	; assume original cool palette
	sll	5,a0
	add	a3,a0

	mmtm	sp,a0,a2,a5,a9

	sll	5,a9
	addi	character_anitabs1,a9
	move	*a9,a9,l			; a9 = stance ani
	move	*a9,a9,l			; a9 = frame #1 (stance ani)
mpo5	move	*a9,a0,l			; a9 = stance ani
	cmpi	ani_ochar_jump,a0
	jrne	mpo7				; no
	move	*a9(32+32),a9,l
	jruc	mpo5

mpo7	move	*a9,a5,l   			; a5 = frame #1
	clr	a7
	calla	get_multi_obj			; get multipart obj for player
	mmfm	sp,a0,a2,a5,a9
	move	a9,*a8(ochar),w			; set my ochar
	move	*a8(oflags2),a0,w
	or	a5,a0				; ugly or no !!
	move	a0,*a8(oflags2),w		; set the "multipart" bit

	callr	ochar_bank_bit
	callr	ground_ochar

	clr	a0
	move	a0,*a13(p_flags),w		; clear process flags
	calla	player_normpal
	mmfm	sp,a0,a1,a7
	rets

ochar_bank_bit
	movi	clear_bank_bit,a14
	move	*a8(ochar),a0
	cmpi	ft_sg,a0
	jrlo	obb4
	movi	set_bank_bit,a14
obb4	jump	a14

**************************************************************************
*											     *
*  player_swpal - players use this routine to switch to alternate	     *
*                 palettes								     *
* 											     *
*  input: a0 = palette to switch to								*
*	 a8 = object									     *
*        a13 = controlling process							     *
*											     *
**************************************************************************
player_swpal_a0_image
	move	*a0(icmap),a0,1

player_swpal
	calla	swpal
	move	*a13(p_flags),a0,w
	ori	pm_alt_pal,a0
	move	a0,*a13(p_flags),w	; flag: i am using aleternate palette
	rets

**************************************************************************
*											     *
*  player_normpal - players use this routine to switch back to their     *
*                   normal palette							     *
* 											     *
*  input: a8 = object									     *
*        a13 = controlling process 							     *
*											     *
**************************************************************************
player_normpal
	move	*a13(p_flags),a0,w
	btst	pb_alt_pal,a0		; am i using an alternate palette ??
	jreq	pnorm3			; sans ---> dont switch

	callr	q_nice_pal		; can I use the nice pal ???
	jrnc	player_ugly_pal		; no

player_nice_pal
	move	*a8(oflags2),a1,w
	andni	m_ugly_pal,a1
	move	a1,*a8(oflags2),w	; flag: ugly pal
	movi	character_palettes_1,a0
	jruc	pnorm2

player_ugly_pal
	move	*a8(oflags2),a1,w
	ori	m_ugly_pal,a1
	move	a1,*a8(oflags2),w	; flag: ugly pal
	movi	character_palettes_2,a0

pnorm2	calla	get_char_long
	calla	swpal

	move	*a13(p_flags),a0,w
	andni	pm_alt_pal,a0
	move	a0,*a13(p_flags),w	; flag: i am not using aleternate palette

pnorm3	rets



;******************************************************************
;******************************************************************

q_nice_pal
	move	@p1_char,a0,w		; a0 = me
	move	@p2_char,a1,w		; a1 = him
	move	@p1_obj,a2,l
	cmp	a8,a2
	jreq	pnp3
    	swap	a0,a1			; thats better !!
pnp3	cmpi	ft_st,a1		; is he shang tsung ?
	jrne	he_is_not_shang

he_is_shang
	cmp	a0,a1			; am I also shang ?
	jreq	we_are_shangs
	jruc	he_is_shang_i_am_not	; nice = yes

we_are_shangs
	move	@p2_obj,a2,l
	cmp	a2,a8
	jreq	q_nice_no		; 2 shangs p2 = ugly
	jruc	q_nice_yes		; 2 shangs p1 = nice

he_is_not_shang
	cmpi	ft_st,a0		; am I shang ?
	jreq	i_am_shang_he_is_not

neither_are_shang
	cmp	a0,a1				; we same player ?
	jrne	neither_shang_different	; no use the nice one !!

neither_shang_same
	move	@p2_obj,a2,l
	cmp	a2,a8
	jreq	q_nice_no			; p2 ---> ugly pal
	jruc	q_nice_yes			; p1 ---> nice pal

i_am_shang_he_is_not
	move	*a8(ochar),a2,w
	cmpi	ft_st,a2
	jreq	q_nice_yes			; I am in shang form = nice pal
	cmp	a2,a1				; am I in his form ?
	jreq	q_nice_no			; yes = ugly

neither_shang_different
he_is_shang_i_am_not
q_nice_yes
	setc
	rets

q_nice_no
	clrc
	rets

;******************************************************************
;******************************************************************


;xxx
character_palettes_1
	.long	KANORED_P    	;  0 - kano
	.long	SBGREEN_P    	;  1 - sonya
	.long	JAXPRP_P     	;  2 - jax
	.long	INBLU_P	     	;  3 - indian
	.long	SZBLU_P	     	;  4 - turk (subzero)
	.long	OLTBLU_P	;  5 - swat
	.long	LPRP_P	     	;  6 - lia
	.long	R1PAL1_P     	;  7 - robo1
	.long	R2PAL1_P	;  8 - robo2
	.long	KUNG_P		;  9 - kung lao
	.long	TSKTAN_P	; 10 - tusk
	.long	FGRED_P		; 11 - she goro
	.long	TSYEL_P		; 12 - shang tsun
	.long	LKRED_P		; 13 - kang
	.long	SMOKE1_P     	; 14 - robo1
	.long	MOTARO_P	; 15 - motaro
	.long	BGPAL1_P	; 16 - shao kahn
	.long	noob_p		; 17 - Noob Saibot
	
;xxx
character_palettes_2
	.long	KANOBLU_P	;  0 - kano
	.long	SBLTBLU_P	;  1 - sonya
	.long	JZXGRN_P	;  2 - jax
	.long	INYEL_P		;  3 - indian
	.long	SZBLUGR_P	;  4 - subzero
	.long	OBRED_P	     	;  5 - swat
	.long	LBLU_P		;  6 - lia
	.long	R1PAL2_P     	;  7 - robo1
	.long	R2PAL2_P	;  8 - robo2
	.long	KUNGBLU_P	;  9 - kung lao
	.long	TSBLU_P		; 10 - tusk
	.long	FGBLUE_P	; 11 - she goro
	.long	TSRED_P		; 12 - shang tsung
	.long	LKYELO_P	; 13 - kang
	.long	SMOKE2_P     	; 14 - robo1
	.long	MOTARO_P	; 15 - motaro
	.long	BGPAL1_P	; 16 - shao kahn
	.long	noob_p		; 17 - Noob Saibot

;***********************************************************************

ground_ochar
	move	*a8(ochar),a0,w
	sll	4,a0
	addi	ochar_ground_offsets,a0
	move	*a0,a0,w		; grab the offset
	move	@ground_y,a1,w
	sub	a0,a1
	move	a1,*a8(oypos),w		; and set the y on the ground too
	rets

;xxx
ochar_ground_offsets
	.word	>90	; kano
	.word	>8f	; sonya
	.word	>9e	; jax
	.word	>90	; indian
	.word	>8e	; turk (subzero)
	.word	>93	; swat
	.word	>90	; lia
	.word	>93	; robo
	.word	>93	; robo
	.word	>8c	; kung lao
 	.word	>94	; tusk
	.word	>9e	; she goro
	.word	>88	; shang tsung
	.word	>8b	; kang
	.word	>93	; robo
	.word	>aa	; motaro
	.word	>ad	; kahn
	.word	>90	; noob

death_fade_excludes
	.long	KANORED_P    	; 0 - kano
	.long	SBGREEN_P    	; 1 - sonya
	.long	JAXPRP_P     	; 2 - jax
	.long	INBLU_P	     	; 3 - indian
	.long	SZBLU_P	     	; 4 - turk (subzero)
	.long	OBRED_P	     	; 5 - swat
	.long	LPRP_P	     	; 6 - lia
	.long	R1PAL1_P     	; 7 - robo1
	.long	R2PAL1_P	; 8 - robo2
	.long	KUNG_P		; 9 - kung lao
	.long	TSKTAN_P	; 10 - tusk
	.long	FGRED_P		; 11 - she goro
	.long	TSYEL_P		; 12 - shang tsun
	.long	LKRED_P		; 13 - kang
	.long	BGPAL1_P	; 14 - shao kahn
	.long	SMOKE1_P
	.long	SMOKE2_P

	.long	KANOBLU_P	;  0 - kano
	.long	SBLTBLU_P	;  1 - sonya
	.long	JZXGRN_P	;  2 - jax
	.long	INYEL_P		;  3 - indian
	.long	SZBLUGR_P	;  4 - subzero
	.long	OLTBLU_P	;  5 - swat
	.long	LBLU_P		;  6 - lia
	.long	R1PAL2_P     	;  7 - robo1
	.long	R2PAL2_P	;  8 - robo2
	.long	KUNGBLU_P	;  9 - kung lao
	.long	TSBLU_P		; 10 - tusk
	.long	FGBLUE_P	; 11 - she goro
	.long	TSRED_P		; 12 - shang tsung
	.long	LKYELO_P	; 13 - kang
	.long	boonpal
	.long	BLOOD_P
	.long	OIL_P
	.long	SHEEBL_P
	.long	WHITE_p

	.long	0


;xxx - remember noogie lineups
;     - leg grab
;     - kano air throw

**************************************************************************
*											     *
*   Palette Source code									     *
*											     *
**************************************************************************
;xxx

noob_p
	.word	64
	.word	0,0,0,0,0,0,0,0
	.word	0,0,0,0,0,0,0,0
	.word	0,0,0,0,0,0,0,0
	.word	0,0,0,0,0,0,0,0
	.word	0,0,0,0,0,0,0,0
	.word	0,0,0,0,0,0,0,0
	.word	0,0,0,0,0,0,0,0
	.word	0,0,0,0,0,0,0,0

SMOKE1_P:
   .word   64 
   .word   00000h,0779fh,0737fh,06f5fh,06b3fh,0671fh,062ffh,05edfh
   .word   05abfh,0569eh,0527dh,04e5ch,04a3bh,0461ah,041f9h,03dd8h
   .word   039b7h,03596h,03175h,02d54h,02933h,02512h,020f1h,018afh
   .word   0148eh,0106dh,00c4ch,0082bh,0040ah,00009h,00008h,00007h
   .word   07fffh,07fffh,07bdeh,077bdh,0739ch,06f7bh,06b5ah,06739h
   .word   06318h,05ef7h,05ad6h,056b5h,05294h,04e73h,04a52h,04631h
   .word   04210h,03defh,039ceh,035adh,0318ch,02d6bh,0294ah,02108h
   .word   01ce7h,018c6h,014a5h,01084h,00c63h,00842h,00421h,00000h

SMOKE2_P:
   .word   64 
   .word   00000h,066fch,062dch,05ebch,05a9ch,0567ch,0525ch,04e3ch
   .word   04a1ch,045fbh,041dah,03db9h,03998h,03577h,03156h,02d35h
   .word   02914h,024f3h,020d2h,01cb1h,01890h,0146fh,0104eh,0080ch
   .word   0040bh,0000ah,00009h,00008h,00007h,00006h,00005h,00004h
   .word   07fffh,07fffh,07bdeh,077bdh,0739ch,06f7bh,06b5ah,06739h
   .word   06318h,05ef7h,05ad6h,056b5h,05294h,04e73h,04a52h,04631h
   .word   04210h,03defh,039ceh,035adh,0318ch,02d6bh,0294ah,02108h
   .word   01ce7h,018c6h,014a5h,01084h,00c63h,00842h,00421h,00000h

INYEL_P:
   .word   64 
   .word   00000h,01441h,01861h,02081h,024a2h,028c1h,02d01h,03541h
   .word   03d82h,045a2h,04dc2h,051e2h,05602h,05a22h,05e43h,06283h
   .word   066a3h,06aa3h,06ec3h,01462h,01841h,01882h,02061h,020a3h
   .word   02481h,02881h,02ca2h,02cc3h,03082h,02ca4h,034c4h,03906h
   .word   03d06h,04127h,04525h,040e2h,04947h,04d45h,04d68h,04d8ah
   .word   055aah,059cbh,061ebh,065eeh,06a2dh,06e4dh,0726fh,06690h
   .word   07ab0h,07ed2h,07f17h,07fdch,03c00h,05800h,07c21h,00001h
   .word   01084h,018c6h,02529h,0318ch,04210h,056b5h,06b5ah,07fffh

OBRED_P:
   .word   63 
   .word   00000h,07f14h,07f78h,07f54h,07fdbh,07f15h,07ad2h,07aafh
   .word   06a4ch,06628h,05de9h,05e0eh,05188h,04da9h,04945h,04986h
   .word   04968h,045aah,04587h,04525h,03925h,03904h,034e3h,02cc3h
   .word   02ca1h,01ca3h,07fffh,077bdh,06f7bh,06318h,056b5h,04a52h
   .word   04210h,03defh,039ceh,035adh,0318ch,02d6bh,0294ah,02529h
   .word   02108h,01ce7h,018c6h,014a5h,01084h,00c63h,00842h,00421h
   .word   00000h,07c00h,06c00h,06000h,05400h,04c00h,04000h,03c00h
   .word   03400h,03000h,02c00h,02400h,02000h,01c00h,01400h

LBLU_P:
   .word   63 
   .word   00000h,07f99h,07f76h,07b14h,06ab3h,0666fh,0624fh,05a50h
   .word   05a0ch,0560fh,05a0bh,059eah,051ech,04dcbh,051a7h,04daah
   .word   04d88h,04987h,0458ah,04188h,04167h,03d46h,03526h,03504h
   .word   02905h,028c5h,02483h,01ca3h,01441h,07fffh,077bdh,06f7bh
   .word   06318h,056b5h,04a52h,04210h,039ceh,0318ch,02d6bh,0294ah
   .word   02529h,02108h,01ce7h,018c6h,014a5h,01084h,00c63h,00842h
   .word   00000h,0439bh,0373ah,032dbh,02677h,01e55h,015f1h,00dafh
   .word   0058dh,0016bh,00149h,00128h,00107h,000e6h,000c5h

**************************************************************************
*											     *
*   Frozen Palettes									     *
*											     *
**************************************************************************
player_froze_pal
	movi	ochar_froze_pals,a0
	calla	get_char_long
	jruc	player_swpal

ochar_froze_pals
	.long	KNFROZN_P	; 0
	.long	SBFROZN_P	; 1
	.long	JXFROZN_P	; 2
	.long	INFROZN_P	; 3
	.long	SZFROZN_P	; 4
	.long	OBFROZN_P	; 5
	.long	LIFROZN_P	; 6
	.long	RBFROZN_P	; 7
	.long	RBFROZN_P	; 9
	.long	KLFROZN_P	; 9 - kung lao
	.long	TRFROZN_P	; 10
	.long	SHFROZN_P	; 11
	.long	TSFROZN_P	; 12
	.long	LUFROZN_P	; 13
	.long	RBFROZN_P	; 14
	.long	white_froze_p	; 15
	.long	sk_shadow_p	; 16 - shao kahn
	.long	white_froze_p	;
	.long	white_froze_p	;
	.long	white_froze_p	;
	.long	white_froze_p	;
	.long	white_froze_p	;

white_froze_p
	.word	64
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff
	.word	>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff,>ffff

LUFROZN_P:
   .word   64 
   .word   00000h,07fffh,07fffh,07fffh,07fffh,07fffh,077ffh,077ffh
   .word   067ffh,073dfh,0739fh,0739eh,067bfh,05f7fh,05b1eh,052dfh
   .word   046ffh,04addh,04abbh,0429ch,0365ah,03a37h,03219h,029d8h
   .word   021d8h,01db7h,01996h,01596h,01197h,07fffh,073ffh,06bffh
   .word   05fffh,053bfh,04b7fh,0433fh,03affh,032bfh,02e9fh,02a7eh
   .word   0225dh,0223ch,01e1bh,019fah,011b8h,00976h,00134h,02fffh
   .word   04bffh,04bffh,04bffh,043bfh,0375fh,0333fh,02affh,022bfh
   .word   01e9fh,01e7fh,01e5eh,01e3dh,01e3ch,01e1ah,01dd9h,01dd7h

TSFROZN_P:
   .word   64 
   .word   00000h,063ffh,063ffh,063ffh,063ffh,063ffh,05fffh,04fffh
   .word   053ffh,053dfh,04fdfh,04bbfh,0477fh,0479fh,03f9fh,0377fh
   .word   0375fh,03b3fh,0333fh,02b1fh,02efch,02adch,026bch,0229ch
   .word   02678h,02237h,01e38h,0165ch,0125bh,0163ah,01219h,00e18h
   .word   00df8h,009d6h,001d9h,001b7h,07fffh,06bffh,057ffh,04bdfh
   .word   03f7fh,0331fh,026bdh,01e7bh,01639h,01218h,009d6h,00195h
   .word   063ffh,05bffh,0537fh,04b3fh,0471fh,042ffh,03edfh,03abfh
   .word   0369fh,0327fh,02e3fh,02a1fh,025dfh,021dfh,021dfh,021dfh

SHFROZN_P:
   .word   64 
   .word   00000h,047ffh,043ffh,043ffh,03fffh,03bffh,03bffh,037ffh
   .word   033ffh,033ffh,02fdfh,02bbfh,0279fh,0277fh,0235fh,01f3fh
   .word   01f1fh,01affh,016dfh,00ebfh,00a9fh,0067fh,0025eh,0023eh
   .word   0023eh,0021dh,001fdh,001ddh,0021eh,001feh,001fdh,001ddh
   .word   001dfh,001dfh,001bfh,001bfh,001bfh,001bfh,001bfh,001bfh
   .word   001bfh,001bfh,001dfh,00a1fh,00e5fh,0169fh,01edfh,0231fh
   .word   0537fh,009feh,0123fh,01a7fh,022bfh,02affh,0333fh,03b7fh
   .word   043bfh,04bffh,053ffh,05bffh,063ffh,06bffh,073ffh,001bch

TRFROZN_P:
   .word   64 
   .word   00000h,02fffh,01fffh,017ffh,00bffh,003ffh,003dfh,0037fh
   .word   0033fh,002ffh,002bfh,0029fh,0027fh,0025fh,0023fh,0021fh
   .word   001feh,01bffh,013ffh,00bbfh,0037fh,0033fh,0031fh,002dch
   .word   0029ch,0027ch,0025ch,0023ch,0021ch,001fch,001dch,001dch
   .word   02fffh,02fffh,02fffh,01bffh,013dfh,007bfh,0037fh,0033fh
   .word   0031fh,002ffh,002beh,0029fh,0027eh,0023dh,0021dh,001bch
   .word   001bch,02fffh,01fffh,00fffh,003ffh,003dfh,003bfh,0039fh
   .word   0035fh,0033fh,0031fh,002ffh,002dfh,002bfh,0027eh,0023eh

SBFROZN_P:
   .word   64 
   .word   00000h,03fffh,03fffh,03fffh,03fffh,03fffh,03bffh,037ffh
   .word   033bfh,0339fh,02fbfh,02e5fh,02b9fh,02b7fh,0277fh,0231fh
   .word   01ebfh,0025fh,016ffh,0133fh,00edfh,00ebfh,0021fh,0067fh
   .word   002bfh,0023fh,0021fh,0019fh,001ffh,001dfh,001bfh,027ffh
   .word   01bffh,013ffh,013ffh,007ffh,017ffh,003ffh,007ffh,0039fh
   .word   0037fh,0037fh,0035fh,0031fh,002ffh,002bfh,0029fh,0027fh
   .word   0025fh,001ffh,03bffh,033ffh,02bffh,01fffh,013ffh,0037fh
   .word   0031fh,002bfh,0027fh,0025fh,0023fh,0021fh,001ffh,001bfh

INFROZN_P:
   .word   64 
   .word   00000h,00257h,0029ah,002dch,002fch,002ffh,0031fh,0033fh
   .word   0035fh,0037fh,0039fh,003bfh,003dfh,003ffh,003ffh,003ffh
   .word   003ffh,003ffh,003ffh,00296h,00275h,002b6h,00295h,002d7h
   .word   002b5h,002b5h,002d6h,002f7h,006b6h,002d8h,00af8h,00f3ah
   .word   0133ah,0175bh,01b59h,01716h,01f7bh,02379h,0239ch,023beh
   .word   02bdeh,02fffh,037ffh,03bffh,03fffh,043ffh,047ffh,03bffh
   .word   04fffh,053ffh,053ffh,053ffh,01234h,02e34h,05255h,00235h
   .word   002b8h,002fah,0035dh,007bfh,017ffh,02bffh,03fffh,053ffh

LIFROZN_P:
   .word   64 
   .word   00000h,07bffh,07bffh,077ffh,067ffh,063ffh,05fffh,057ffh
   .word   057ffh,053ffh,057ffh,057feh,04fffh,04bffh,04ffbh,04bfeh
   .word   04bfch,047fbh,043feh,03ffch,03ffbh,03bdah,033bah,03398h
   .word   02799h,02759h,02317h,01b37h,012d5h,07bffh,073ffh,06bffh
   .word   05fffh,053ffh,047ffh,03fffh,037ffh,02fffh,02bffh,027deh
   .word   023bdh,01f9ch,01b7bh,0175ah,01339h,00f18h,00af7h,006d6h
   .word   00294h,06fffh,063ffh,05fffh,053ffh,04bffh,043ffh,03bffh
   .word   033ffh,02fffh,02bffh,023dfh,01fbfh,01fbfh,013bfh,00294h

OBFROZN_P:
   .word   64 
   .word   00000h,067ffh,067ffh,067ffh,067ffh,063ffh,05fffh,05fffh
   .word   04fffh,04bfch,043fdh,043ffh,037fch,033fdh,02fd9h,02ffah
   .word   02ffch,02bfeh,02bfbh,02bb9h,01fb9h,01f98h,01b77h,01357h
   .word   01335h,00337h,067ffh,05fffh,057ffh,04bffh,03fffh,033ffh
   .word   02bffh,027ffh,023ffh,01fffh,01bffh,017ffh,013deh,00fbdh
   .word   00b9ch,0077bh,0035ah,00339h,00318h,002f7h,002d6h,002b5h
   .word   00294h,01fffh,01bffh,013ffh,007ffh,003dfh,0037fh,0037fh
   .word   0035fh,0035fh,0035fh,0033dh,0031bh,002d9h,00295h,00294h

JXFROZN_P:
   .word   64 
   .word   00000h,07bffh,06fffh,067ffh,05fffh,057ffh,04fffh,047ffh
   .word   03fffh,037ffh,033dfh,02fbfh,02b9eh,0277dh,0235ch,01f3bh
   .word   01b1ah,016f9h,012d8h,00eb7h,00a96h,00675h,0439fh,033bfh
   .word   02bbfh,0239fh,01b9fh,0037fh,0037fh,0031bh,00319h,00317h
   .word   073ffh,06fffh,063ffh,05bffh,053ffh,04fffh,053b5h,04ffeh
   .word   047bbh,043bch,04379h,03fbdh,03f7ah,03bbeh,03b59h,03b37h
   .word   0375ah,03718h,03319h,032d6h,02f19h,02ed6h,02b3ah,02af7h
   .word   026d7h,02694h,022b6h,01a96h,01a54h,01275h,01254h,00a54h

RBFROZN_P:
   .word   64 
   .word   00000h,04bffh,04bffh,04bffh,043ffh,03fffh,03bffh,037ffh
   .word   033ffh,033bch,02f9bh,02b59h,01b59h,01738h,03ad6h,032b5h
   .word   02af7h,026d5h,022b5h,01ad6h,01718h,012f7h,00ed6h,00af6h
   .word   006d6h,002d5h,002d6h,00294h,002b5h,002b5h,002b5h,002b4h
   .word   04bffh,047ffh,043ffh,03fffh,03bffh,037ffh,033ffh,02fffh
   .word   02bffh,027ffh,023ffh,01fffh,01bffh,017ffh,013ffh,00fffh
   .word   00bffh,007ffh,003ffh,003ffh,003ffh,003deh,0039ch,0037bh
   .word   0035ah,00339h,00318h,002f7h,002d6h,002b5h,00294h,00294h

SZFROZN_P:
   .word   64 
   .word   00000h,0031bh,002fbh,0033bh,00b1bh,00b5ch,00f3bh,0133bh
   .word   0175bh,0177ch,0179eh,01bbfh,023dfh,027ffh,02bffh,02fffh
   .word   033ffh,02ffeh,03bffh,03fffh,03fffh,03fffh,047ffh,04bffh
   .word   053ffh,057ffh,05bffh,05fffh,063ffh,057ffh,067ffh,067ffh
   .word   067ffh,067ffh,002ffh,002ffh,002ffh,002ffh,002ffh,002ffh
   .word   002ffh,002ffh,002ffh,0037fh,0039fh,003dfh,003ffh,003ffh
   .word   003ffh,003ffh,003ffh,002fch,0037fh,003bfh,00bffh,013ffh
   .word   01bffh,023ffh,02bffh,033ffh,047ffh,057ffh,067ffh,033beh

KNFROZN_P:
   .word   64 
   .word   00000h,06bffh,067ffh,05fffh,04fffh,03fffh,03bffh,03a9fh
   .word   03bffh,03bffh,03bdfh,03bbfh,03b5fh,03b3fh,03b1fh,03adfh
   .word   073ffh,073ffh,073ffh,073ffh,073ffh,06fffh,06bffh,067ffh
   .word   067ffh,063ffh,05fffh,05bffh,057ffh,057ffh,057ffh,053ffh
   .word   04bffh,047ffh,047ffh,043ffh,043bfh,03b3eh,03fffh,03bffh
   .word   03b9fh,03bdfh,03b9fh,03b5fh,03b1fh,03b3fh,03abeh,03b1fh
   .word   03a9eh,03affh,03adfh,067bfh,067ffh,03adfh,02adfh,0333fh
   .word   01adfh,012dfh,006dfh,002bfh,002bfh,002bfh,0029fh,0729eh

KLFROZN_P:
   .word   64 
   .word   00000h,04fffh,043ffh,03bffh,02b9fh,01b1fh,00a9fh,0021ch
   .word   001b9h,00177h,00156h,00114h,000d3h,047bfh,03b5eh,0373dh
   .word   02f1ch,026fbh,01edah,01a99h,01258h,00a37h,00616h,001f5h
   .word   001d4h,00194h,00173h,00152h,04fffh,04fffh,04fffh,04fffh
   .word   04bdfh,047bfh,0479fh,0437fh,03f5fh,03b9fh,03b5fh,03b3bh
   .word   036b9h,0375fh,0371fh,0331fh,02f1fh,02e73h,022bfh,01a9eh
   .word   01a7ch,01a59h,01637h,0125bh,00e3ah,009f8h,005b5h,00174h
   .word   00196h,00133h,00173h,00134h,04cd2h,030d2h,018d2h,008d2h

;*****************************************************************

	.end

