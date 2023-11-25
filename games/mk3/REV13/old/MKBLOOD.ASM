**************************************************************************
*											     *
*  video game project:	MK3									*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: BLOOD !										*
* 											     *
*  copyright (c) 1993 Midway Manufacturing							*
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
	.include	imgtbl.glo
	.include	mkblood.tbl
	.include	mkblood2.tbl

	.text


create_blood_proc
	push	a2
	move	@f_no_blood,a2,w
	jrne	cbp9						; blood is turned off
	movi	(blood_procs_end-blood_procs)/32,a2
	cmp	a2,a0
	jrhs	cbp9
	sll	5,a0
	addi	blood_procs,a0
	move	*a0,a7,l
	movi	pid_blood,a1
	calla	getprc
cbp9	pull	a2
	move	a0,a0
	rets

blood_procs
	.long	roundhouse_blood	; 0
	.long	upcutted_blood		; 1
	.long	face_blood_2		; 2
	.long	face_punch_blood	; 3
	.long	combo_blood		; 4
	.long	hat_blood		; 5
	.long	spider_blood		; 6
	.long	lion_blood		; 7
	.long	dino_blood		; 8
	.long	saw_blood		; 9
	.long	pit_spike_blood		; a
blood_procs_end


;combo_blood
;	create	pid_blood,face_punch_blood
;	jruc	face_punch_blood

;*********************************************************************

saw_blood
	movk	4,a11
sawb2	create	pid_blood,sawb3
	sleep	8
	dsj	a11,sawb2

sawb3	move	a8,a11
	movi	>20000,a0		; x vel range
	movi	>10000,a1		; x vel minimum
	movi	>50000,a2		; y vel range
	movi	>30000,a3		; y vel minimum
	movi	>00810001,a4		; coordinate adjust
	movi	>00040000,a5		; ani speed / drip table ani offset
	movk	3,a10
	calla	spawn_drip_a10		; do 6 drips for uppercut

	create	pid_blood,saw_right
	callr	get_tg_blood
	movi	>00880005,a0
	callr	lineup_with_a11_offset
	calla	flip_single
	jruc	upcb3

saw_right
	callr	get_tg_blood
	movi	>00880000,a0
	callr	lineup_with_a11_offset
	jruc	upcb3

;*********************************************************************

dino_blood
	create	pid_blood,dblood3
	sleep	8

dblood3	move	a8,a11
	movi	>20000,a0		; x vel range
	movi	>10000,a1		; x vel minimum
	movi	>50000,a2		; y vel range
	movi	>30000,a3		; y vel minimum
	movi	>00410001,a4		; coordinate adjust
	movi	>00040000,a5		; ani speed / drip table ani offset
	movk	3,a10
	calla	spawn_drip_a10		; do 6 drips for uppercut

	create	pid_blood,dino_right
	callr	get_tg_blood
	movi	>00480005,a0
	callr	lineup_with_a11_offset
	calla	flip_single
	jruc	upcb3

dino_right
	callr	get_tg_blood
	movi	>00480000,a0
	callr	lineup_with_a11_offset
	jruc	upcb3

;*********************************************************************

lion_blood
	move	a8,a11

	movi	>20000,a0		; x vel range
	movi	>10000,a1		; x vel minimum
	movi	>50000,a2		; y vel range
	movi	>30000,a3		; y vel minimum
	movi	>00710001,a4		; coordinate adjust
	movi	>00040000,a5		; ani speed / drip table ani offset
	movk	3,a10
	calla	spawn_drip_a10		; do 6 drips for uppercut

	create	pid_blood,lion_right
	callr	get_tg_blood
	movi	>00780005,a0
	callr	lineup_with_a11_offset
	calla	flip_single
	jruc	upcb3

lion_right
	callr	get_tg_blood
	movi	>00780000,a0
	callr	lineup_with_a11_offset
	jruc	upcb3

;*********************************************************************

spider_blood
	create	pid_fx,spider_sounds

	movk	5,a11
spid3	clr	a0
	callr	create_blood_proc
	movk	1,a0
	callr	create_blood_proc
	movk	5,a0
	callr	create_blood_proc
	sleep	>12
	dsj	a11,spid3
	jruc	local_sucide

spider_sounds
	calla	death_scream

	movk	4,a11
ssnd	tsound	>24
	sleep	>10
	tsound	>25
	sleep	>10
	dsj	a11,ssnd
	jruc	local_sucide

;*********************************************************************

hat_blood
	movk	3,a11
hatb0	create	pid_blood,hatb1
	create	pid_blood,hatb_drip
	sleep	1
	dsjs	a11,hatb0
	die


hatb1	move	a8,a11
	callr	get_jt_blood
	movi	>10,a0
	movi	>38,a1
	callr	a11_blood_lineup

	movi	>10000,a0
	calla	srand
	move	a0,*a8(oyvel),l

	movi	>20000,a0
	calla	randu
	addi	>10000,a0
	calla	set_proj_vel

	calla	flip_single
	calla	insobja8

	movi	a_bigger,a9
	movk	6,a0
	jsrp	framew
	jruc	blood_death


hatb_drip
	move	a8,a11
	callr	get_jt_blood
	movi	>10,a0
	movi	>60,a1
	callr	a11_blood_lineup

	movi	>60000,a0
	calla	randu
	addi	>20000,a0
	calla	set_proj_vel

	movi	>40000,a0
	calla	randu
	addi	>30000,a0
	neg	a0
	move	a0,*a8(oyvel),l

	calla	flip_single
	calla	insobja8
	
	movk	8,a0	 	; a0 = ani speed
	movi	a_drip,a9	; a9 = ani
	movi	>6000,a10	; a10 = grav
	jruc	blood_fall_splat_12_die

;**************************************************************

pit_spike_blood
	movk	4,a11
pitb2	create	pid_blood,sawb3
	sleep	8
	dsj	a11,pitb2
	die

;**************************************************************

upcutted_blood
	move	a8,a11

	movi	>20000,a0		; x vel range
	movi	>10000,a1		; x vel minimum
	movi	>50000,a2		; y vel range
	movi	>30000,a3		; y vel minimum
	movi	>00010001,a4		; coordinate adjust
	movi	>00040000,a5		; ani speed / drip table ani offset
	movk	3,a10
	calla	spawn_drip_a10		; do 6 drips for uppercut

	create	pid_blood,upcut_right
	callr	get_tg_blood
	movi	>00180005,a0
	callr	lineup_with_a11_offset
	calla	flip_single
	jruc	upcb3

upcut_right
	callr	get_tg_blood
	movi	>00180000,a0
	callr	lineup_with_a11_offset

upcb3	calla	insobja8
	movi	a_decap_spray,a9
	movk	3,a0
	jsrp	framew
	jruc	blood_death

*
*  a0 = y:x adjust
* a11 = dude to lineup with
*
lineup_with_a11_offset
	move	a0,a7
	move	a11,a1
	move	a8,a0
	calla	lineup_1pwm		; start with same coordinates as dude
	move	a7,a0

adjust_blood_a0
	move	a0,a1
	sext	a0,w 			; a0 = x adjust
	sra	16,a1			; a1 = y adjust
	jauc	multi_adjust_xy

**************************************************************************

roundhouse_blood
	move	a8,a11

	movi	>20000,a0		; x vel range
	movi	>10000,a1		; x vel minimum
	movi	>50000,a2		; y vel range
	movi	>30000,a3		; y vel minimum
	movi	>0000fff0,a4		; coordinate adjust
	movi	>00040000,a5		; ani speed / drip table ani offset
	movk	3,a10
	calla	spawn_drip_a10		; do 6 drips for uppercut

	create	pid_blood,rhouse_right
	callr	get_tg_blood
	movi	>0018fff5,a0
	callr	lineup_with_a11_offset
	calla	flip_single
	jruc	rhb3

rhouse_right
	callr	get_tg_blood
	movi	>0018fff0,a0
	callr	lineup_with_a11_offset

rhb3	calla	insobja8
	movi	a_decap_spray,a9
	movk	3,a0
	jsrp	framew
	jruc	blood_death

**************************************************************************

combo_blood
	move	a8,a11

	movk	2,a6
comb3	create	pid_blood,face_blood
	dsj	a6,comb3

	movi	>20000,a0		; x vel range
	movi	>30000,a1		; x vel minimum
	movi	>40000,a2		; y vel range
	movi	>30000,a3		; y vel minimum
	movi	>00010001,a4		; coordinate adjust
	movi	>00060001,a5		; ani speed / drip table ani offset
	callr	spawn_drip_neg
	callr	spawn_drip_neg
	jruc	local_sucide

**************************************************************************
*											     *
*  face_blood_2 - Hit in the face HARD blood					     *
*											     *
**************************************************************************
face_blood_2
	move	a8,a11

	movk	4,a6
facb3	create	pid_blood,face_blood
	dsj	a6,facb3

	movi	>20000,a0		; x vel range
	movi	>30000,a1		; x vel minimum
	movi	>40000,a2		; y vel range
	movi	>30000,a3		; y vel minimum
	movi	>00010001,a4		; coordinate adjust
	movi	>00060001,a5		; ani speed / drip table ani offset
	callr	spawn_drip_neg
	callr	spawn_drip_neg
	callr	spawn_drip_neg
	callr	spawn_drip_neg
	jruc	local_sucide


face_blood
	callr	get_jt_blood

	movi	>fff00000,a0
	callr	lineup_with_a11_offset
	calla	insobja8

	movi	>12000,a0
	calla	randu
	neg	a0
	move	a0,*a8(oyvel),l		; upwards

	movi	>20000,a0
	calla	randu
	addi	>30000,a0
	neg	a0
	calla	set_proj_vel

	movi	a_bigger,a9
	movk	6,a0
	jsrp	framew
	jruc	blood_death



face_punch_blood
	move	a8,a11

	move	@rand,a0,l
	jrn	face3

	movi	>00000,a0		; x vel range
	movi	>30000,a1		; x vel minimum
	movi	>20000,a2		; y vel range
	movi	>20000,a3		; y vel minimum
	movi	>0010fff0,a4		; coordinate adjust
	movi	>00040002,a5		; ani speed / drip table ani offset
	callr	spawn_drip_neg

face3	callr	get_tg_blood

	move	a8,a0
	move	a11,a1
	calla	lineup_1pwm
	calla	flip_single

	move	*a11(ochar),a0,w
	sll	5,a0
	addi	face_blood_adjustments,a0
	move	*a0,a0,l
	move	a0,a1
	zext	a0,w
	srl	16,a1
	calla	multi_adjust_xy

	movi	->8000,a0
	move	a0,*a8(oyvel),l

	movi	>10000,a0
	calla	set_proj_vel

	calla	insobja8

	movi	a_face_blood,a9
	movk	3,a0
	jsrp	framew
	jruc	blood_death



face_blood_adjustments
	.long	>00100008
	.long	>00100008
	.long	>0015000c
	.long	>00100008

	.long	>00100008
	.long	>00100008
	.long	>00100008
	.long	>00100008

	.long	>00100008
	.long	>00100008
	.long	>00100008
	.long	>00100008

	.long	>00100008
	.long	>00100008
	.long	>00100008
	.long	>00100008

a_face_blood
	.long	SPLAT1
	.long	SPLAT2
	.long	SPLAT3
	.long	SPLAT4
	.long	SPLAT5
	.long	SPLAT6
	.long	SPLAT7
	.long	0


**************************************************************************
*											     *
*  spawn_drip - Spawn a drip of blood given				     	*
* 											     *
*  a0 = x vel range									     *
*  a1 = x vel minimum									     *
*  a2 = y vel range									     *
*  a3 = y vel minimum									     *
*  a4 = y:x coordinate adjust									*
*  a5 = animation to use										*
*											     *
**************************************************************************
spawn_drip_a10
	callr	spawn_drip
	callr	spawn_drip_neg
	dsj	a10,spawn_drip_a10
	rets

spawn_drip_neg
	mmtm	sp,a0,a1,a2,a3,a4,a5
	mmtm	sp,a0,a1
	movi	tobias_drip_neg,a7
	jruc	spawnd3

spawn_drip
	mmtm	sp,a0,a1,a2,a3,a4,a5
	mmtm	sp,a0,a1
	movi	tobias_drip,a7

spawnd3	movi	pid_blood,a1
	calla	getprc
	move	a0,a6			; a6 = blood proc
	mmfm	sp,a0,a1

	move	a0,*a6(p_store1),l
	move	a1,*a6(p_store2),l
	move	a2,*a6(p_store3),l
	move	a3,*a6(p_store4),l	; pass velocity info to proc
	move	a4,*a6(p_store5),l
	move	a5,*a6(p_store6),l

	mmfm	sp,a0,a1,a2,a3,a4,a5
	rets

tobias_drip_neg
	callr	tdrip_getobj
	neg	a0
	calla	set_proj_vel
	jruc	tdrip2

tobias_drip
	callr	tdrip_getobj
	calla	set_proj_vel
	calla	flip_single

tdrip2	calla	insobja8
	move	*a13(p_store6),a9,l
	move	a9,a0
	srl	16,a0
	zext	a9,w
	sll	5,a9
	addi	drip_ani_table,a9
	move	*a9,a9,l

	movi	>4000,a10
	jruc	drip_fall_2


tdrip_getobj
	callr	get_tg_blood

	move	*a13(p_store5),a0,l
	callr	lineup_with_a11_offset

	move	*a13(p_store3),a0,l
	calla	randu
	move	*a13(p_store4),a1,l
	add	a1,a0
	neg	a0
	move	a0,*a8(oyvel),l		; head upwards

	move	*a13(p_store1),a0,l
	calla	randu
	move	*a13(p_store2),a1,l
	add	a1,a0
	rets

**************************************************************************
*											     *
*  blood_fall										     *
* 											     *
*  Input: a0 = ani speed									     *
*         a9 = ani									     *
*        a10 = gravity									     *
*											     *
**************************************************************************
blood_fall
	calla	init_anirate
bldf3	move	*a8(oyvel),a0,l
	add	a10,a0
	move	a0,*a8(oyvel),l
	calla	next_anirate
	sleep	1

	move	*a8(oyvel),a0,l
	jrn	bldf3			; heading up = loop

	move	*a8(oypos),a0,w
	move	@ground_y,a1,w

;	subi	>14,a1			; higher on screen
	subi	>1d,a1			; higher on screen
	cmp	a1,a0
	jrlt	bldf3

	calla	stop_a8
;	move	a1,*a8(oypos),w		; set on ground
	retp


get_tg_blood
      	movi	STAB1,a5
	jruc	gbld3

get_jt_blood
	movi	BIGBLD1,a5

gbld3	move	a8,a3  		; save player object we are following
	calla	gso_dmawnz

	move	*a3(ochar),a0,w
	cmpi	ft_sk,a0
	jrlo	gbld6
	clr	a0
gbld6	sll	5,a0
	addi	ochar_blood_palettes,a0
	move	*a0,a0,l
	cmpi	BLOOD_P,a0
	jreq	gbld5			; normal blood pal ---> we are fine
	calla	swpal			; special pal, switcher ooo

gbld5	movi	front_z+1,a0
	move	a0,*a8(ozval),l

	move	*a11(oflags),a4,w
	move	*a8(oflags),a5,w
	andi	m_fliph,a4		; look only at flip of dude
	andni	m_fliph,a5		; clear flip bit of blood
	or	a4,a5
	move	a5,*a8(oflags),w	; match flip bit of dude
	rets


ochar_blood_palettes
	.long	BLOOD_P
	.long	BLOOD_P
	.long	BLOOD_P
	.long	BLOOD_P
	.long	BLOOD_P
	.long	BLOOD_P	    ; 5
	.long	BLOOD_P
	.long	OIL_P
	.long	OIL_P
	.long	BLOOD_P
	.long	BLOOD_P
	.long	SHEEBL_P
	.long	BLOOD_P
	.long	BLOOD_P
	.long	OIL_P

	.long	SHEEBL_P	; motaro
	.long	BLOOD_P
	.long	BLOOD_P
	.long	BLOOD_P
	.long	BLOOD_P

*
* a11 = disappear flag: 1 = disappear  0 = stay on ground
*
drip_fall
	movk	6,a0	 	; a0 = ani speed
	movi	a_drip,a9	; a9 = ab
	movi	>6000,a10	; a10 = grav
*
* drip_fall_2 - supply your own input regs
*
drip_fall_2
	jsrp	blood_fall

; ejbpatch
;	callr	random_splish_sound
	movi	back_z-1,a0
	move	a0,*a8(ozval),l

	movi	a_drip,a9	; a9 = ab
	calla	find_part2
	movk	6,a0
	jsrp	framew

	move	a11,a11
	jreq	local_sucide
	jruc	blood_12_death

blood_12_death
	sleep	12

blood_death
	move	a8,a0
	calla	delobjp

local_sucide
	die


*
* Lineup blood with a11 then adjust by:
*    a0 = x adjust
*    a1 = y adjust
*
a11_blood_lineup
	move	*a11(oxpos),*a8(oxpos),w
	move	*a11(oypos),*a8(oypos),w
	jauc	multi_adjust_xy


blood_fall_splat_12_die
	jsrp	blood_fall
	movi	a_drip,a9	; a9 = ab
	calla	find_part2

	callr	rsnd_splish

	movk	6,a0
	jsrp	framew
	jruc	blood_12_death

;*************************************************************************

a_decap_spray
	.long	SPRAY1
	.long	SPRAY2
	.long	SPRAY3
	.long	SPRAY4
	.long	SPRAY5
	.long	SPRAY6
	.long	SPRAY7
	.long	SPRAY8
	.long	SPRAY9
	.long	SPRAY10
	.long	SPRAY11
	.long	SPRAY12
	.long	SPRAY13
	.long	0

a_bigger
	.long	BIGGERBLUD1
	.long	BIGGERBLUD1

	.long	BIGGERBLUD2
	.long	BIGGERBLUD2

	.long	BIGGERBLUD3
	.long	BIGGERBLUD4
	.long	BIGGERBLUD5
	.long	BIGGERBLUD6
	.long	0


a_drip
	.long	DRIP1
	.long	DRIP2
	.long	DRIP3
	.long	DRIP4
	.long	0
*
* splat on ground ani !
*
a_drip_splat
	.long	DRIP5
	.long	DRIP6
	.long	DRIP7
	.long	0




drip_ani_table
	.long	a_rotate_12
	.long	a_rotate_standard
	.long	a_rotate_9
	.long	a_rotate_7

a_rotate_12
	.long	bludglob1
	.long	bludglob2
	.long	bludglob3

a_rotate_standard
	.long	bludglob4
	.long	bludglob5

a_rotate_9
	.long	bludglob6
	.long	bludglob7
	.long	bludglob8

a_rotate_7
	.long	bludglob9
	.long	bludglob10
	.long	bludglob11
	.long	bludglob12
	.long	0

;	.long	ani_jump,a_drip_splat



a_pork
	.long	PORK01,PORK02,PORK03,PORK04,PORK05,PORK06,PORK07,PORK08
	.long	PORK09,PORK10,PORK11,PORK12,ani_jump,a_pork



OIL_P:
   .word   15 
   .word   00000h,022f9h,011f2h,0096dh,000cah,000a8h,000a6h,00066h
   .word   00085h,00063h,00064h,00000h,00000h,00000h,00000h

SHEEBL_P:
   .word   15 
   .word   00000h,037f0h,03389h,02e81h,032c0h,03600h,03660h,021c0h
   .word   025a0h,021c0h,01da0h,00920h,001a0h,00120h,00120h


;**********************************************************************

	.end
