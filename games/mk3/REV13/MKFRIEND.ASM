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
	.file	"mkfriend.asm"
	.width	132
	.option	b,d,l,t
	.mnolist
*
* get the system stuff
*
	.include	dispequ.asm
	.include	sysequ.asm
	.include	macros.hdr
	.include	stringh.asm
	.include	mainequ.asm
	.include	imgtbl.glo

	.include	mkfriend.tbl
	.include	mkfrend2.tbl

	.text


do_friendship
	jsrp	friendship_start_pause
	calla	init_special
	movi	ochar_animalities,a0
	jauc	ochar_jump

friendship_start_pause
	movi	fat_friend,a1
	calla	init_death_blow
	sleep	030H

	calla	nosounds
	sleep	1
	movi	042H,a3
	calla	send_code_a3
	retp

ochar_animalities
	.long	f_kano			; 0
	.long	f_sonya			; 1
	.long	f_jax			; 2
	.long	f_indian   		; 3
	.long	f_sz			; 4
	.long	f_swat			; 5
	.long	f_sindel   		; 6
	.long	f_sektor   		; 7
	.long	f_cyrax			; 8
	.long	f_lao			; 9
	.long	f_kabal			; 10
	.long	f_sheeva   		; 11
	.long	f_shang			; 12
	.long	f_liu			; 13
	.long	f_smoke_ninja		; 14

f_kano
	movi	a_kano_friend,a9
	callr	mframew_5
	jruc	friendship_complete

f_sonya
	create	pid_bani,end_friend_proc
	movi	a_sonya_friend,a9
	callr	mframew_5
	callr	mframew_3
	jruc	friendship_complete

;********************************

f_jax
	create	pid_bani,end_friend_proc
	movi	a_jax_friend,a9
	calla	do_next_a9_frame
	sleep	020H
	callr	mframew_3
	jruc	friendship_complete

end_friend_proc
	sleep	080H
	calla	death_blow_complete
	die

;********************************

f_indian   
	movi	a_ind_friend,a9

	movk	ft_st,a1
	movk	4,a0
	callr	other_ochar_sound

	callr	mframew_5
	sleep	020H

	pushp	a8
	move	a8,a10
	movi	MK2GAME,a5
	calla	gso_dmawnz
	move	a8,a0
	move	a10,a1
	calla	lineup_1pwm
	movi	-070H,a0
	movi	-0100H,a1
	calla	multi_adjust_xy
	calla	insobja8
	movi	020000H,a1
	movi	06000H,a10
	jsrp	gravity_ani_ysize
	calla	shake_n_sound

	movi	txt_kano,a8
	move	@rand,a0,l
	jrn	kano3
	movi	txt_raiden,a8
kano3	movi	000f000c8H,a9
	jsrp	p7_centered
	pullp	a8

;	move	@objlst2,a9,l
;	clr	a0
;	move	a0,@objlst2,l
	sleep	040H
	calla	death_blow_complete

;	move	a9,@objlst2,l
	jauc	wait_forever


txt_kano
	.string	"I'VE NEVER SEEN A KANO TRANSFORMATION",0
	.even

txt_raiden
	.string	"NO, BUT I KNOW HOW TO DO A RAIDEN TRANSFORMATION",0
	.even


other_ochar_sound
	move	*a8(ochar),a2,w
	push	a2
	move	a1,*a8(ochar),w
	calla	ochar_sound
	pull	a2
	move	a2,*a8(ochar),w
	rets

;***********************************************************************

f_sz
	movi	a_sz_friend,a9

	clr	a0
	calla	ochar_sound
	callr	mframew_5
	jruc	friendship_complete


f_swat
	create	pid_bani,swat_friend_proc

	movk	6,a11
	move	@curback,a0,w
	jreq	swatf3
	movk	13,a11

swatf3	create	pid_bani,swat_crossing_people
	dsj	a11,swatf3

	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	swatf5
      	calla	flip_multi
swatf5

	movi	a_swat_friend,a9
	callr	mframew_5
	movk	8,a0
	calla	ochar_sound
	sleep	040H
	callr	mframew_5
	jruc	friendship_complete

swat_friend_proc
	sleep	0a0H
	calla	death_blow_complete
	die

swat_crossing_people
	move	a8,*a13(p_otherguy),l

	movi	020H,a0
	movi	020H,a1
	calla	randu_minimum
	calla	prcslp

	move	a11,a0
	sll	3,a0
	calla	prcslp

;	movi	010H,a0
;	movi	090H,a1
;	calla	randu_minimum
;	calla	prcslp

	move	a11,a0
	push	a0

	clr	a0			; use kano as a base
	sll	5,a0
	addi	character_anitabs1,a0
	move	*a0,a0,l
	move	*a0,a9,l
	calla	gmo_proc
	pull	a0
	move	a0,*a8(ochar),w
	move	*a13(p_flags),a0,w
	ori	pm_alt_pal,a0		; am i using an alternate palette ??
	move	a0,*a13(p_flags),w
	calla	player_normpal

	calla	match_me_with_him

	movi	080000H,a7
	move	a7,*a8(oxvel),l
	move	@worldtlx+16,a0,w
	subi	050H,a0
	move	a0,*a8(oxpos),w		; start at left side of screen

	movi	100,a0
	move	a0,*a8(ozpos),w

	calla	insobja8

	movi	03eH,a9
	calla	get_char_ani
	movk	3,a0
	calla	init_anirate

	movi	050H,a10
cross3	sleep	1
	calla	next_anirate
	dsj	a10,cross3

	move	a8,a0
	calla	delobjp
	die

;***********************************************************************

f_sindel   
	movi	a_lia_friend,a9
	callr	mframew_5

	calla	rsnd_big_block
	movi	000030003H,a11
	calla	shake_a11

	create	pid_bani,football_proc
	move	*a13(p_slave),*a0(pa9),l
	move	a0,a10
	clr	a1
	move	a1,*a13(p_slave),l
	calla	do_next_a9_frame
	sleep	010H

	callr	mframew_5
	movk	9,a0
	calla	ochar_sound		; that was fun
	sleep	040H
	jruc	friendship_complete

football_proc
	movi	0a0000H,a0
	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jreq	foot4
     	neg	a0
foot4	move	a0,*a9(oxvel),l
	movi	-0a0000H,a0
	move	a0,*a9(oyvel),l
	move	a9,a8
	movi	a_football,a9
	calla	find_part2
	movk	2,a0
	calla	init_anirate

foot5	sleep	1
	calla	next_anirate
	jruc	foot5

;*********************************

f_sektor
	create	pid_bani,dinger_proc
	movi	a_robo1_friend,a9
	calla	do_next_a9_frame
	sleep	050H
	callr	mframew_5
	jruc	friendship_complete

dinger_proc
	movi	021H,a0
	calla	ochar_sound

	move	a8,a10
	movi	a_dinger,a9
	calla	gmo_proc
	move	a8,a0
	move	a10,a1
	calla	lineup_a0_onto_a1
	calla	insobja8
	movk	4,a0
	jsrp	mframew
	sleep	040H
	movk	4,a0
	jsrp	mframew
	die

;*********************************

f_cyrax
	create	pid_bani,end_friend_proc
	movi	a_robo2_friend,a9
	callr	mframew_5
	jruc	friendship_complete

;**************************************

f_lao
	create	pid_bani,end_friend_proc
	create	pid_bani,cute_lil_doggy
	create	pid_bani,lao_dog_sounds

	movi	a_lao_friend,a9
	callr	mframew_4
	create	pid_bani,hat_proc
	sleep	060H

	tsound	08bH
	callr	mframew_4		; yikes
	sleep	030H

	movk	8,a0
	jsrp	mframew			; shake yer head
	jruc	friendship_complete


lao_dog_sounds
	sleep	8

	movk	5,a10
dogs3	tsound	08aH
	sleep	010H
	dsj	a10,dogs3
	die


cute_lil_doggy
	move	a8,a10

	movi	LAODOG1,a5
	calla	gso_dmawnz
	movi	060000H,a5
	move	@worldtlx+16,a0,w
	subi	030H,a0
	move	*a10(oflags),a4,w
	btst	b_fliph,a4
	jreq	cute3

	neg	a5
	addi	scrrgt+030H+030H,a0
	mmtm	sp,a0,a5
	calla	flip_single
	mmfm	sp,a0,a5

cute3	move	a0,*a8(oxpos),w
	move	@ground_y,a0,w
	subi	020H,a0
	move	a0,*a8(oypos),w
	move	a5,*a8(oxvel),l
	movi	100,a0
	move	a0,*a8(ozpos),w		; in front
	calla	insobja8

	movi	a_dog,a9
	movk	3,a0
	jsrp	framew
	jauc	wait_forever


a_dog	.long	LAODOG1
	.long	LAODOG2
	.long	LAODOG3
	.long	LAODOG4
	.long	LAODOG5
	.long	LAODOG6
	.long	ani_jump,a_dog


hat_proc
	move	a8,a10
	movi	FETCHHAT2,a5
	calla	gso_dmawnz
	move	a8,a0
	move	a10,a1
	calla	lineup_a0_onto_a1
	movi	060H,a0
	movi	010H,a1
	calla	multi_adjust_xy
	calla	insobja8

	movi	-040000H,a0
	move	a0,*a8(oyvel),l
	movi	0a0000H,a0
	calla	set_proj_vel
	die

;**************************************

f_kabal
	create	pid_bani,end_friend_proc
	movi	a_tusk_friend,a9
	callr	mframew_5
	jruc	friendship_complete

;**************************************

f_sheeva   
	create	pid_bani,end_friend_proc
	movi	a_sg_friend,a9
	callr	mframew_5
	movk	6,a0
	calla	ochar_sound
	callr	mframew_5
	jruc	friendship_complete

;**************************************

f_shang
	create	pid_bani,end_friend_proc
	movi	01eH,a0
	calla	create_fx

	sleep	8

	calla	set_inviso
	move	a8,a10
	movi	ostrich1,a5
	calla	gso_dmawnz
	move	*a10(oxpos),*a8(oxpos),w
	move	@ground_y,a0,w
	subi	020H,a0
	move	a0,*a8(oypos),w
	calla	insobja8
	sleep	040H

	jsrp	bounce
	jsrp	bounce

	movi	030000H,a0
	move	a0,*a8(oxvel),l
shang4	movk	5,a10
shang5	jsrp	bounce
	dsj	a10,shang5
	calla	stop_a8
	jauc	wait_forever

bounce
	movi	040000H,a0
	movi	040000H,a1
	calla	randu_minimum
	move	a0,a11
	neg	a11
	move	a11,*a8(oyvel),l
	sleep	2

bnc3	sleep	1
	move	a11,*a8(oyvel),l
	addi	08000H,a11
	move	*a8(oypos),a0,w
	addi	020H,a0
	move	@ground_y,a1,w
	cmp	a1,a0
	jrlo	bnc3
	tsound	071H

	retp

;**************************************


f_liu	create	pid_bani,wall_dragon_proc
	movi	a_kang_friend,a9
	callr	mframew_5
	sleep	020H
	callr	mframew_5
	sleep	10
	callr	mframew_5
	sleep	030H
	jruc	friendship_complete


wall_dragon_proc
	move	a8,a10
	movi	a_wall_dragon,a9
	calla	gmo_proc
	move	a8,a0
	move	a10,a1
	calla	lineup_a0_onto_a1
	clr	a0
	movi	-030H,a1
	calla	multi_adjust_xy
	calla	insobja8
	movk	5,a0
	jsrp	mframew
	sleep	020H
	movk	4,a0
	jsrp	mframew
	die



f_smoke_ninja
	create	pid_bani,end_friend_proc
	jsrp	robo_open_chest
	movi	a_smoke_friend,a9
	callr	mframew_5

	movi	022H,a0
	calla	ochar_sound		; horn !
	callr	mframew_5

	sleep	010H
	callr	mframew_5
	calla	delete_slave
	jsrp	robo_close_chest
	jauc	victory_animation


a_smoke_friend
	.long	ani_sladd,HORN1
	.long	ani_slani_sleep,HORN1
	.long	ani_slani_sleep,HORN2
	.long	ani_slani_sleep,HORN3
	.long	0

	.long	ani_slani_sleep,HORN4
	.long	ani_slani_sleep,HORN5
	.long	ani_slani_sleep,HORN4
	.long	ani_slani_sleep,HORN5
	.long	ani_slani_sleep,HORN4
	.long	ani_slani_sleep,HORN5
	.long	ani_slani_sleep,HORN4
	.long	ani_slani_sleep,HORN5
	.long	ani_slani_sleep,HORN4
	.long	ani_slani_sleep,HORN5
	.long	ani_slani_sleep,HORN3
	.long	0

	.long	ani_slani_sleep,HORN2
	.long	ani_slani_sleep,HORN1
	.long	0


HORN1	.long	BIGHORN1,0
HORN2	.long	BIGHORN2,0
HORN3	.long	BIGHORN3,0
HORN4	.long	BIGHORN4,0
HORN5	.long	BIGHORN5,0

;***************************************************

a_kano_friend
	.long	KNFRIEND1
	.long	KNFRIEND2
	.long	KNFRIEND3
	.long	KNFRIEND4
	.long	KNFRIEND5
	.long	KNFRIEND6
	.long	KNFRIEND7
	.long	KNFRIEND8
	.long	KNFRIEND9
	.long	KNFRIEND10
	.long	KNFRIEND11
	.long	KNFRIEND12
	.long	KNFRIEND13
	.long	KNFRIEND14
;	.long	KNFRIEND15
	.long	KNFRIEND16
	.long	KNFRIEND17
	.long	KNFRIEND18
	.long	KNFRIEND19
	.long	ani_sladd,BUBGUM1
	.long	ani_slani_sleep,BUBGUM1
	.long	ani_slani_sleep,BUBGUM2
	.long	ani_slani_sleep,BUBGUM3
	.long	ani_slani_sleep,BUBGUM4
	.long	ani_slani_sleep,BUBGUM5
	.long	ani_slani_sleep,BUBGUM5
	.long	ani_slani_sleep,BUBGUM5
	.long	ani_slani_sleep,BUBGUM5
	.long	ani_slani_sleep,BUBGUM5

	.long	ani_calla,rsnd_big_block
	.long	ani_slani_sleep,BUBGUM6
	.long	ani_slani_sleep,BUBGUM7
	.long	0

KNFRIEND1
	.long	KNFRIEND1A,KNFRIEND1B,0
KNFRIEND2
	.long	KNFRIEND2A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND3
	.long	KNFRIEND3A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND4
	.long	KNFRIEND4A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND5
	.long	KNFRIEND5A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND6
	.long	KNFRIEND6A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND7
	.long	KNFRIEND7A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND8
	.long	KNFRIEND8A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND9
	.long	KNFRIEND9A,KNFRIEND9B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND10
	.long	KNFRIEND10A,KNFRIEND10B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND11
	.long	KNFRIEND11A,KNFRIEND11B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND12
	.long	KNFRIEND12A,KNFRIEND12B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND13
	.long	KNFRIEND13A,KNFRIEND13B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND14
	.long	KNFRIEND14A,KNFRIEND14B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
;KNFRIEND15
;	.long	KNFRIEND15A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND16
	.long	KNFRIEND16A,KNFRIEND16B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND17
	.long	KNFRIEND17A,KNFRIEND17B,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND18
	.long	KNFRIEND18A,KNFRIENDLEG1A,KNFRIENDLEG1B,0
KNFRIEND19
	.long	KNFRIEND19A,KNFRIENDLEG1A,KNFRIENDLEG1B,0

BUBGUM1	.long	BUBGUM1A,0
BUBGUM2	.long	BUBGUM2A,0
BUBGUM3	.long	BUBGUM3A,0
BUBGUM4	.long	BUBGUM4A,0
BUBGUM5	.long	BUBGUM5A,0
BUBGUM6	.long	BUBGUM6A,0
BUBGUM7	.long	BUBGUM7A,0

;************************************************************************

a_sonya_friend
	.long	SBFRIENDSHIP1
	.long	SBFRIENDSHIP2
	.long	SBFRIENDSHIP3
	.long	SBFRIENDSHIP4
	.long	SBFRIENDSHIP5
	.long	SBFRIENDSHIP6
	.long	SBFRIENDSHIP7
	.long	0

j_sonyaf	.long	SBFRIENDSHIP8
	.long	SBFRIENDSHIP9
	.long	ani_calla,rsnd_whoosh
	.long	SBFRIENDSHIP10
	.long	SBFRIENDSHIP11
	.long	ani_calla,rsnd_whoosh
	.long	SBFRIENDSHIP10
	.long	SBFRIENDSHIP9
	.long	ani_calla,rsnd_whoosh
	.long	SBFRIENDSHIP8
	.long	SBFRIENDSHIP7
	.long	SBFRIENDSHIP6
	.long	SBFRIENDSHIP5
	.long	SBFRIENDSHIP4
	.long	SBFRIENDSHIP5
	.long	SBFRIENDSHIP6
	.long	SBFRIENDSHIP7
	.long	ani_jump,j_sonyaf


SBFRIENDSHIP1
	.long	SBFRIENDSHIP1A,SBFRIENDSHIP1B,0
SBFRIENDSHIP2
	.long	SBFRIENDSHIP2A,SBFRIENDSHIP2B,SBFRIENDSHIP2C,0
SBFRIENDSHIP3
	.long	SBFRIENDSHIP3A,SBFRIENDSHIP3B,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP4
	.long	SBFRIENDSHIP4A,SBFRIENDSHIP4B,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP5
	.long	SBFRIENDSHIP5A,SBFRIENDSHIP5B,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP6
	.long	SBFRIENDSHIP6A,SBFRIENDSHIP6B,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP7
	.long	SBFRIENDSHIP7A,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP8
	.long	SBFRIENDSHIP8A,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP9
	.long	SBFRIENDSHIP9A,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP10
	.long	SBFRIENDSHIP10A,SBFRIENDLEG1A,SBFRIENDLEG1B,0
SBFRIENDSHIP11
	.long	SBFRIENDSHIP11A,SBFRIENDLEG1A,SBFRIENDLEG1B,0

;************************************************************************

a_st_friend
a_ind_friend
	.long	ani_swpal
	.long	RNBEAMUP3
	.long	RNBEAMUP4
	.long	RNBEAMUP5
	.long	RNBEAMUP6
	.long	RNBEAMUP7
	.long	ani_swpal
	.long	RNVICTORY1
	.long	RNVICTORY2
	.long	RNVICTORY3
	.long	RNVICTORY5
	.long	RNVICTORY6
	.long	RNVICTORY7
	.long	0

RNBEAMUP3
	.long	RNBEAMUP3A,RNBEAMUP3B,0
RNBEAMUP4
	.long	RNBEAMUP4A,RNBEAMUP4B,0
RNBEAMUP5
	.long	RNBEAMUP5A,RNBEAMUP5B,0
RNBEAMUP6
	.long	RNBEAMUP6A,RNBEAMUP6B,0
RNBEAMUP7
	.long	RNBEAMUP7A,RNBEAMUP7B,0
RNVICTORY1
	.long	RNVICTORY1A,RNVICTORY1B,RNVICTORY1C,RNVICTORY1D,0
RNVICTORY2
	.long	RNVICTORY2A,RNVICTORY2B,RNVICTORY2C,RNVICTORY2D,0
RNVICTORY3
	.long	RNVICTORY3A,RNVICTORY3B,0
RNVICTORY5
	.long	RNVICTORY5A,RNVICTORY5B,0
RNVICTORY6
	.long	RNVICTORY6A,RNVICTORY6B,RNVICTORY6C,RNVICTORY6D,0
RNVICTORY7
	.long	RNVICTORY7A,RNVICTORY7B,RNVICTORY7C,RNVICTORY7D,0

;*************************************************************************

;INJUGAXE1
;	.long	INJUGAXE1A,0
;INJUGAXE2
;	.long	INJUGAXE2A,INJUGAXE2B,0
;INJUGAXE3
;	.long	INJUGAXE3A,INJUGAXE3B,0
;INJUGAXE4
;	.long	INJUGAXE4A,0
;INJUGAXE5
;	.long	INJUGAXE5A,0
;INJUGAXE6
;	.long	INJUGAXE6A,0
;INJUGAXE7
;	.long	INJUGAXE7A,0
;INJUGAXE8
;	.long	INJUGAXE8A,0
;INJUGAXE9
;	.long	INJUGAXE9A,0
;INJUGAXE10
;	.long	INJUGAXE10A,0


a_sz_friend
	.long	SZSNOW1
	.long	SZSNOW2

	.long	ani_sladd,SWHITE3
	.long	SZSNOW3
	.long	ani_slani,SWHITE4
	.long	SZSNOW4
	.long	ani_slani,SWHITE5
	.long	SZSNOW5
	.long	ani_slani,SWHITE6
	.long	SZSNOW6
	.long	ani_slani,SWHITE7
	.long	SZSNOW7
	.long	ani_slani,SWHITE8
	.long	SZSNOW8
	.long	ani_slani,SWHITE9
	.long	SZSNOW9
	.long	ani_slani_sleep,SWHITE10
	.long	ani_slani_sleep,SWHITE11
	.long	ani_slani_sleep,SWHITE12
	.long	0

SZSNOW1
	.long	SZSNOW1A,SZSNOW1B,0
SZSNOW2
	.long	SZSNOW2A,SZSNOW2B,0
SZSNOW3
	.long	SZSNOW3A,SZSNOW3B,0
SZSNOW4
	.long	SZSNOW4A,SZSNOW4B,SZSNOW4C,0
SZSNOW5
	.long	SZSNOW5A,0
SZSNOW6
	.long	SZSNOW6A,0
SZSNOW7
	.long	SZSNOW7A,0
SZSNOW8
	.long	SZSNOW8A,0
SZSNOW9
	.long	SZSNOW9A,0

SWHITE3	.long	SZSNOW3C,0
SWHITE4	.long	SZSNOW4C,0
SWHITE5	.long	SZSNOW5B,0
SWHITE6	.long	SZSNOW6B,0
SWHITE7	.long	SZSNOW7B,0
SWHITE8	.long	SZSNOW8B,0
SWHITE9	.long	SZSNOW9B,0
SWHITE10	.long	SZSNOW10,0
SWHITE11	.long	SZSNOW11,0
SWHITE12	.long	SZSNOW12,0

;********************************************************************

a_swat_friend
	.long	OBFRIENDSHIP1
	.long	OBFRIENDSHIP2
	.long	OBFRIENDSHIP3
	.long	0
	.long	OBFRIENDSHIP5

	.long	ani_sladd,STP1
	.long	OBFRIENDSHIP6
	.long	ani_slani,STP3
	.long	OBFRIENDSHIP8
	.long	ani_slani,STP4
	.long	OBFRIENDSHIP9

j_swatf	.long	ani_slani,STP5
	.long	OBFRIENDSHIP10
	.long	ani_slani,STP6
	.long	OBFRIENDSHIP11
	.long	ani_slani,STP7
	.long	OBFRIENDSHIP12
	.long	OBFRIENDSHIP12
	.long	OBFRIENDSHIP12
	.long	ani_slani,STP6
	.long	OBFRIENDSHIP11

	.long	ani_jump,j_swatf

OBFRIENDSHIP1
	.long	OBFRIENDSHIP1A,OBFRIENDSHIP1B,0
OBFRIENDSHIP2
	.long	OBFRIENDSHIP2A,OBFRIENDSHIP2B,0
OBFRIENDSHIP3
	.long	OBFRIENDSHIP3A,OBFRIENDSHIP3B,0
OBFRIENDSHIP5
	.long	OBFRIENDSHIP5A,OBFRIENDSHIP5B,0
OBFRIENDSHIP6
	.long	OBFRIENDSHIP6A,OBFRIENDSHIP6B,0
OBFRIENDSHIP8
	.long	OBFRIENDSHIP8A,OBFRIENDSHIP8B,0
OBFRIENDSHIP9
	.long	OBFRIENDLEG1A,OBFRIENDLEG1B,OBFRIENDSHIP9A,0
OBFRIENDSHIP10
	.long	OBFRIENDLEG1A,OBFRIENDLEG1B,OBFRIENDSHIP10A,0
OBFRIENDSHIP11
	.long	OBFRIENDLEG1A,OBFRIENDLEG1B,OBFRIENDSHIP11A,0
OBFRIENDSHIP12
	.long	OBFRIENDLEG1A,OBFRIENDLEG1B,OBFRIENDSHIP12A,0

STP1	.long	STOP1,0
STP2	.long	STOP2,0
STP3	.long	STOP3,0
STP4	.long	STOP4,0
STP5	.long	STOP5,0
STP6	.long	STOP6,0
STP7	.long	STOP7,0

;***********************************************************************

a_lia_friend
	.long	ani_sladd,FBALL1
	.long	ani_slani_sleep,FBALL1
	.long	ani_slani_sleep,FBALL2
	.long	ani_slani_sleep,FBALL3
	.long	ani_slani_sleep,FBALL4
	.long	ani_slani_sleep,FBALL5
	.long	ani_slani_sleep,FBALL6
	.long	ani_slani_sleep,FBALL7
	.long	LIFRIENDSHIP1
	.long	LIFRIENDSHIP1
	.long	LIFRIENDSHIP2
	.long	0			; send the ball flying
	.long	LIFRIENDSHIP3
	.long	LIFRIENDSHIP4
	.long	LIFRIENDSHIP5
	.long	LIFRIENDSHIP6
	.long	LIFRIENDSHIP7
	.long	LIFRIENDSHIP8
	.long	0

LIFRIENDSHIP1
	.long	LIFRIENDSHIP1A,0
LIFRIENDSHIP2
	.long	LIFRIENDSHIP2A,0
LIFRIENDSHIP3
	.long	LIFRIENDSHIP3A,LIFRIENDSHIP3B,0
LIFRIENDSHIP4
	.long	LIFRIENDSHIP4A,LIFRIENDSHIP4B,0
LIFRIENDSHIP5
	.long	LIFRIENDSHIP5A,0
LIFRIENDSHIP6
	.long	LIFRIENDSHIP6A,LIFRIENDSHIP6B,0
LIFRIENDSHIP7
	.long	LIFRIENDSHIP7A,LIFRIENDSHIP7B,0
LIFRIENDSHIP8
	.long	LIFRIENDSHIP8A,LIFRIENDSHIP8B,LIFRIENDSHIP8C,0

a_football
	.LONG	FBALL1
	.LONG	FBALL2
	.LONG	FBALL3
	.LONG	FBALL4
	.LONG	FBALL5
	.LONG	FBALL6
	.LONG	FBALL7
	.LONG	0
j_footb	.LONG	FBALL8
	.LONG	FBALL9
	.LONG	FBALL10
	.LONG	FBALL11
	.LONG	ani_jump,j_footb

FBALL1	.long	FTBALLGROW6,0
FBALL2	.long	FTBALLGROW7,0
FBALL3	.long	FTBALLGROW8,0
FBALL4	.long	FTBALLGROW9,0
FBALL5	.long	FTBALLGROW10,0
FBALL6	.long	FTBALLGROW11,0
FBALL7	.long	FTBALLGROW12,0
FBALL8	.long	FTBALLROT1,0
FBALL9	.long	FTBALLROT2,0
FBALL10	.long	FTBALLROT3,0
FBALL11	.long	FTBALLROT4,0

;***********************************************************************

a_robo1_friend
	.long	RBHAMMER1
	.long	RBHAMMER2
	.long	RBHAMMER3
	.long	RBHAMMER4
	.long	RBHAMMER5
	.long	RBHAMMER6
	.long	0

RBHAMMER1
	.long	RBHAMMER1A,RBHAMMER1B,0
RBHAMMER2
	.long	RBHAMMER2A,RBHAMMER2B,0
RBHAMMER3
	.long	RBHAMMER3A,RBHAMMER3B,RBHAMMER3C,0
RBHAMMER4
	.long	RBHAMMER4A,RBHAMMER4B,0
RBHAMMER5
	.long	RBHAMMER5A,RBHAMMER5B,RBHAMMER5C,0
RBHAMMER6
	.long	RBHAMMER6A,RBHAMMER6B,0

a_dinger
	.long	RBDINGER1
	.long	RBDINGER2
	.long	RBDINGER3
	.long	RBDINGER4
	.long	RBDINGER5
	.long	RBDINGER6
	.long	RBDINGER7
	.long	RBDINGER8
	.long	RBDINGER9
	.long	RBDINGER10
	.long	RBDINGER11
	.long	RBDINGER12
	.long	0

	.long	RBDINGER13
	.long	RBDINGER14
	.long	RBDINGER15
	.long	0

RBDINGER1
	.long	RBDINGER1A,0
RBDINGER2
	.long	RBDINGER2A,0
RBDINGER3
	.long	RBDINGER3A,0
RBDINGER4
	.long	RBDINGER4A,0
RBDINGER5
	.long	RBDINGER5A,0
RBDINGER6
	.long	RBDINGER6A,0
RBDINGER7
	.long	RBDINGER7A,0
RBDINGER8
	.long	RBDINGER8A,0
RBDINGER9
	.long	RBDINGER9A,0
RBDINGER10
	.long	RBDINGER10A,0
RBDINGER11
	.long	RBDINGER11A,0
RBDINGER12
	.long	RBDINGER12A,0
RBDINGER13
	.long	RBDINGER13A,0
RBDINGER14
	.long	RBDINGER14A,0
RBDINGER15
	.long	RBDINGER15A,0

;**********************************************************************

a_robo2_friend
	.long	RBCHACHA1
	.long	RBCHACHA2
	.long	RBCHACHA3
	.long	RBCHACHA4
	.long	RBCHACHA5
	.long	RBCHACHA4
	.long	RBCHACHA3
	.long	RBCHACHA2
	.long	ani_jump,a_robo2_friend

RBCHACHA1
	.long	RBCHACHA1A,RBCHACHA1B,0
RBCHACHA2
	.long	RBCHACHA2A,RBCHACHA2B,0
RBCHACHA3
	.long	RBCHACHA3A,RBCHACHA3B,0
RBCHACHA4
	.long	RBCHACHA4A,RBCHACHA4B,0
RBCHACHA5
	.long	RBCHACHA5A,RBCHACHA5B,0

;**********************************************************************

a_tusk_friend
	.long	TRFRIENDSHIP1
	.long	TRFRIENDSHIP2

	.long	TRFRIENDSHIP3
	.long	TRFRIENDSHIP4
	.long	TRFRIENDSHIP5
	.long	TRFRIENDSHIP6

	.long	TRFRIENDSHIP71
	.long	TRFRIENDSHIP72
	.long	TRFRIENDSHIP73
	.long	TRFRIENDSHIP74
	.long	TRFRIENDSHIP75
	.long	TRFRIENDSHIP76
	.long	TRFRIENDSHIP77
	.long	TRFRIENDSHIP78
	.long	TRFRIENDSHIP79

	.long	TRFRIENDSHIP81
	.long	TRFRIENDSHIP82
	.long	TRFRIENDSHIP83
	.long	TRFRIENDSHIP84

	.long	TRFRIENDSHIP9
	.long	TRFRIENDSHIP10

	.long	ani_sladd,CAMPFIRE1
	.long	ani_slani_sleep,CAMPFIRE1
	.long	ani_slani_sleep,CAMPFIRE2
	.long	ani_calla,camp_fire_sound

	.long	ani_slani_sleep,CAMPFIRE3
j_camp	.long	ani_slani_sleep,CAMPFIRE4
	.long	ani_slani_sleep,CAMPFIRE5
	.long	ani_slani_sleep,CAMPFIRE6
	.long	ani_slani_sleep,CAMPFIRE7
	.long	ani_slani_sleep,CAMPFIRE8
	.long	ani_jump,j_camp

camp_fire_sound
	movi	00aH,a0
	jauc	ochar_sound


TRFRIENDSHIP1
	.long	TRFRIENDSHIP1A,TRFRIENDSHIP1B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP2
	.long	TRFRIENDSHIP2A,TRFRIENDSHIP2B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP3
	.long	TRFRIENDSHIP3A,TRFRIENDSHIP3B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP4
	.long	TRFRIENDSHIP4A,TRFRIENDSHIP4B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP5
	.long	TRFRIENDSHIP5A,TRFRIENDSHIP5B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP6
	.long	TRFRIENDSHIP6A,TRFRIENDSHIP6B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP71
	.long	MELLOW1A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP72
	.long	MELLOW2A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP73
	.long	MELLOW3A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP74
	.long	MELLOW4A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP75
	.long	MELLOW5A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP76
	.long	MELLOW6A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP77
	.long	MELLOW7A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP78
	.long	MELLOW8A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP79
	.long	MELLOW9A
	.long	TRFRIENDSHIP7A,TRFRIENDSHIP7B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP81
	.long	MELLOWSWORD1A
	.long	TRFRIENDSHIP8A,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP82
	.long	MELLOWSWORD2A
	.long	TRFRIENDSHIP8A,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP83
	.long	MELLOWSWORD3A
	.long	TRFRIENDSHIP8A,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP84
	.long	MELLOWSWORD4A
	.long	TRFRIENDSHIP8A,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP9
	.long	TRFRIENDSHIP9A,TRFRIENDSHIP9B,TRFRIENDLEG1A,TRFRIENDLEG1B,0
TRFRIENDSHIP10
	.long	TRFRIENDSHIP10A,TRFRIENDLEG1A,TRFRIENDLEG1B,0

;********************************************

CAMPFIRE1
	.long	CAMPFIRE1A,0
CAMPFIRE2
	.long	CAMPFIRE2A,0
CAMPFIRE3
	.long	CAMPFIRE3A,0
CAMPFIRE4
	.long	CAMPFIRE4A,0
CAMPFIRE5
	.long	CAMPFIRE5A,0
CAMPFIRE6
	.long	CAMPFIRE6A,0
CAMPFIRE7
	.long	CAMPFIRE7A,0
CAMPFIRE8
	.long	CAMPFIRE8A,0

;********************************************

a_kang_friend
	.long	LUFRIENDSHIP1
	.long	LUFRIENDSHIP3
	.long	0

	.long	LUFRIENDSHIP4
	.long	LUFRIENDSHIP5
	.long	LUFRIENDSHIP6
	.long	LUFRIENDSHIP5

	.long	LUFRIENDSHIP4
	.long	LUFRIENDSHIP5
	.long	LUFRIENDSHIP6
	.long	LUFRIENDSHIP5
	.long	0

	.long	LUFRIENDSHIP7
	.long	LUFRIENDSHIP8
	.long	0

LUFRIENDSHIP1
	.long	LUFRIENDSHIP1A,LUFRIENDSHIP1B,0
LUFRIENDSHIP3
	.long	LUFRIENDSHIP3A,LUFRIENDSHIP2A,LUFRIENDSHIP2B,0
LUFRIENDSHIP4
	.long	LUFRIENDSHIP4A,LUFRIENDSHIP2A,LUFRIENDSHIP2B,0
LUFRIENDSHIP5
	.long	LUFRIENDSHIP5A,LUFRIENDSHIP2A,LUFRIENDSHIP2B,0
LUFRIENDSHIP6
	.long	LUFRIENDSHIP6A,LUFRIENDSHIP2A,LUFRIENDSHIP2B,0
LUFRIENDSHIP7
	.long	LUFRIENDSHIP7A,LUFRIENDSHIP2A,LUFRIENDSHIP2B,0
LUFRIENDSHIP8
	.long	LUFRIENDSHIP8A,LUFRIENDSHIP2A,LUFRIENDSHIP2B,0

;***************************************************************

a_wall_dragon
	.long	WDRAG1
	.long	WDRAG2
	.long	WDRAG3
	.long	WDRAG4
	.long	WDRAG5
	.long	WDRAG6
	.long	WDRAG7
	.long	0
	.long	WDRAG8
	.long	WDRAG9
	.long	WDRAG10
	.long	0
	
WDRAG1	.long	SHADOWDRAG1,0
WDRAG2	.long	SHADOWDRAG2,0
WDRAG3	.long	SHADOWDRAG3,0
WDRAG4	.long	SHADOWDRAG4,0
WDRAG5	.long	SHADOWDRAG5,0
WDRAG6	.long	SHADOWDRAG6,0
WDRAG7	.long	SHADOWDRAG7,0
WDRAG8	.long	SHADOWDRAG8,0
WDRAG9	.long	SHADOWDRAG9,0
WDRAG10	.long	SHADOWDRAG10,0

;***************************************************************

a_sg_friend
	.long	SGFRIENDSHIP1
	.long	SGFRIENDSHIP2
	.long	SGFRIENDSHIP3
	.long	SGFRIENDSHIP4
	.long	SGFRIENDSHIP5

	.long	SGFRIENDSHIP6
	.long	SGFRIENDSHIP7
	.long	SGFRIENDSHIP6
	.long	SGFRIENDSHIP7
	.long	SGFRIENDSHIP6
	.long	SGFRIENDSHIP7

	.long	SGFRIENDSHIP8
	.long	SGFRIENDSHIP9
	.long	SGFRIENDSHIP10
	.long	0

j_spind	.long	SGSPINDISH1
	.long	SGSPINDISH2
	.long	SGSPINDISH3
	.long	SGSPINDISH4
	.long	SGSPINDISH5
	.long	SGSPINDISH6
	.long	ani_jump,j_spind


SGFRIENDSHIP1
	.long	SGFRIENDSHIP1A,SGFRIENDSHIP1B,0
SGFRIENDSHIP2
	.long	SGFRIENDSHIP2A,SGFRIENDSHIP2B,0
SGFRIENDSHIP3
	.long	SGFRIENDSHIP3A,0
SGFRIENDSHIP4
	.long	SGFRIENDSHIP4A,SGFRIENDSHIP4B,0
SGFRIENDSHIP5
	.long	SGFRIENDSHIP5A,SGFRIENDSHIP5B,0


SGFRIENDSHIP6
	.long	SGFRIENDSHIP6A,SGFRIENDLEG1A,0
SGFRIENDSHIP7
	.long	SGFRIENDSHIP7A,SGFRIENDLEG1A,0
SGFRIENDSHIP8
	.long	SGFRIENDSHIP8A,SGFRIENDLEG1A,0
SGFRIENDSHIP9
	.long	SGFRIENDSHIP9A,SGFRIENDSHIP9B,SGFRIENDSHIP9C,0
SGFRIENDSHIP10
	.long	SGFRIENDSHIP10A,SGFRIENDSHIP10B,SGFRIENDSHIP10C,0

SGSPINDISH1
	.long	SGFRIENDSHIP11A,SGSPINDISH1A,SGSPINDISH1B,0
SGSPINDISH2
	.long	SGFRIENDSHIP11A,SGSPINDISH2A,SGSPINDISH2B,0
SGSPINDISH3
	.long	SGFRIENDSHIP11A,SGSPINDISH3A,SGSPINDISH3B,0
SGSPINDISH4
	.long	SGFRIENDSHIP11A,SGSPINDISH4A,SGSPINDISH4B,0
SGSPINDISH5
	.long	SGFRIENDSHIP11A,SGSPINDISH5A,SGSPINDISH5B,0
SGSPINDISH6
	.long	SGFRIENDSHIP11A,SGSPINDISH6A,SGSPINDISH6B,0

;KLFRIENDHEAD
;	.long	KLFRIENDHEADA,KLFRIENDHEADB,KLFRIENDHEADC,KLFRIENDHEADD
;	.long	0


a_lao_friend
	.long	KLFRIEND3
	.long	KLFRIEND4
;	.long	KLFRIEND5	; bad data here
	.long	KLFRIEND6
	.long	KLFRIEND7
	.long	KLFRIEND8
	.long	KLFRIEND9
	.long	0	 	; throw

	.long	KLFRIEND10
	.long	KLFRIEND11
	.long	0		; yikes

	.long	KLFRIEND12
	.long	KLFRIEND13


j_lao	.long	KLFRIEND14
	.long	KLFRIEND15
	.long	KLFRIEND16
	.long	KLFRIEND17
	.long	KLFRIEND16
	.long	KLFRIEND15
	.long	ani_jump,j_lao

;*************************
; not used
;KLFRIEND1
;	.long	KLFRIEND1A,KLFRIEND1B,0
;KLFRIEND2
;	.long	KLFRIEND2A,0
;*************************


KLFRIEND3
	.long	KLFRIEND3A,KLFRIEND3B,0
KLFRIEND4
	.long	KLFRIEND4A,KLFRIEND4B,0
KLFRIEND5
	.long	KLFRIEND5A,KLFRIEND5B,0
KLFRIEND6
	.long	KLFRIEND6A,KLFRIEND6B,0
KLFRIEND7
	.long	KLFRIEND7A,KLFRIEND7B,0
KLFRIEND8
	.long	KLFRIEND8A,KLFRIEND8B,0
KLFRIEND9
	.long	KLFRIEND9A,KLFRIEND9B,0
KLFRIEND10
	.long	KLFRIEND10A,KLFRIEND10B,0
KLFRIEND11
	.long	KLFRIEND11A,KLFRIEND11B,0
KLFRIEND12
	.long	KLFRIEND12A,KLFRIEND12B,0
KLFRIEND13
	.long	KLFRIEND13A,KLFRIEND13B,0

KLFRIEND14
	.long	KLFRIEND14A,KLFRIEND14B,KLFRIENDHEADA,0
KLFRIEND15
	.long	KLFRIEND14A,KLFRIEND14B,KLFRIENDHEADB,0
KLFRIEND16
	.long	KLFRIEND14A,KLFRIEND14B,KLFRIENDHEADC,0
KLFRIEND17
	.long	KLFRIEND14A,KLFRIEND14B,KLFRIENDHEADD,0



;KLHATSLICE1
;	.long	KLHATSLICE1A,KLHATSLICE1B,0
;KLHATSLICE2
;	.long	KLHATSLICE2A,KLHATSLICE2B,0
;KLHATSLICE3
;	.long	KLHATSLICE3A,KLHATSLICE3B,0
;KLHATSLICE4
;	.long	KLHATSLICE4A,KLHATSLICE4B,0
;KLHATSLICE6
;	.long	KLHATSLICE6A,KLHATSLICE6B,0






a_jax_friend
	.long	JXJUMPROPE1

j_jax_rope
	.long	JXJUMPROPE9
	.long	JXJUMPROPE8
	.long	JXJUMPROPE7
	.long	ani_calla,rsnd_whoosh
	.long	JXJUMPROPE6
	.long	JXJUMPROPE5
	.long	ani_calla,rsnd_whoosh
	.long	JXJUMPROPE4
	.long	JXJUMPROPE3
	.long	JXJUMPROPE2
	.long	ani_jump,j_jax_rope

JXJUMPROPE1
	.long	JXJUMPROPE1A,JXJUMPROPE1B,JXJUMPROPE1C,JXJUMPROPE1D
	.long	0
JXJUMPROPE2
	.long	JXJUMPROPE2A,JXJUMPROPE2B,JXJUMPROPE2C,JXJUMPROPE2D
	.long	0
JXJUMPROPE3
	.long	JXJUMPROPE3A,JXJUMPROPE3B,JXJUMPROPE3C,JXJUMPROPE3D
	.long	0
JXJUMPROPE4
	.long	JXJUMPROPE4A,JXJUMPROPE4B,0
JXJUMPROPE5
	.long	JXJUMPROPE5A,JXJUMPROPE5B,0
JXJUMPROPE6
	.long	JXJUMPROPE6A,JXJUMPROPE6B,JXJUMPROPE6C,JXJUMPROPE6D
	.long	0
JXJUMPROPE7
	.long	JXJUMPROPE7A,JXJUMPROPE7B,0
JXJUMPROPE8
	.long	JXJUMPROPE8A,JXJUMPROPE8B,0
JXJUMPROPE9
	.long	JXJUMPROPE9A,JXJUMPROPE9B,JXJUMPROPE9C,JXJUMPROPE9D
	.long	0

;*************************************************************************

friendship_complete
	calla	death_blow_complete
	calla	player_normpal
	jauc	wait_forever
;	jauc	victory_animation

mframew_3
	movk	3,a0
	jruc	mfrm4

mframew_4
	movk	4,a0
	jruc	mfrm4

mframew_5
	movk	5,a0
mfrm4	pull	a11
	jsrp	mframew
	jump	a11

;*************************************************************************


	.end
