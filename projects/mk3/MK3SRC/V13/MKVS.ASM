**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mkvs.asm --- player select								*
* 											     *
*  copyright (c) 1995 williams electronics games, inc.			     *
*											     *
**************************************************************************
	.file	'mkvs.asm'
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
	.include	imgtbl.glo
	.include	diagaudn.asm
	.include	mkvs.tbl
	.include	mkvs2.tbl

	.ref	get_aud

vs_or_ladder
	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jreq	vs3

	.if ejbbug
	move	@f_fastrun,a0,w
	jrne	vs_exit
	.endif

	calla	count_active_players
	cmpi	1,a0
	jaeq	mk_ladder

	movi	gs_vs,a0
	calla	set_game_state		; use routine cuz we do this in amode !

vs3	move	@battle_num,a2,w	; a2 = current battle number
	movi	aud_hibattle,a0
	calla	get_aud			; a1 = highest battle reached
	sub	a2,a1		  	; highest ever ?
	jrnn	not_highest_battle	; sans

	neg	a1			; a1 = amount we wanna adjust audit by
	movi	aud_hibattle,a0
	calla	aud			; adjust - o - ra - ma - vitch

not_highest_battle

;	clr	a0
;	move	a0,@f_auto_erase,w
;	calla	display_off
;	calla	sync_wait_dma_q
;	calla	bakclr
;	calla	grab_screen

;	clr	a0
;	not	a0
;	move	a0,@noflip,w	   	; take control of page flipping !!
;	calla	view_page_1
;	movi	page0adr+xpadding,a1	; plot to page 0
;	move	a1,@pageaddr,l		; plot to page 0
;	movi	[253,0],a0
;	move	a0,@dmatplft,l 		; set dma window to page 0

loopit
	calla	murder_myoinit
	clr	a0
	move	a0,@irqskye,w		; black sky
	calla	display_off
	sleep	>10

	create	pid_fx,mk_bat_signal
	create	pid_fx,mk_bat_signal_f
	create	pid_fx,mk_battle
	create	pid_fx,mk_vs
	create	pid_comb,combination_proc

	movi	vs_mod,a0
	calla	init_bakmods
	calla	multi_plane
	movi	dlists_bogus,a0
	move	a0,@dlists,l

	sleep	1
	calla	display_on

	clr	a10
	jsrp	fadein_jsrp
	jsrp	slide_in_huge_players

	calla	nosounds
	sleep	1
	movi	>35,a3
	calla	send_code_a3		; Mortal Sans !!!
	sleep	>b0

	movi	pid_comb,a0
	calla	dallprc	      		; stop combination proc
	sleep	>04
	calla	murder_myoinit_score
	calla	clr_scrn
	sleep	>08

vs_exit	retp


;*******************************************************************
;*******************************************************************
;*******************************************************************
;*******************************************************************

mk_vs
	sleep	>18
	movi	BURNV1,a5
	movi	>005000ab,a4
	calla	gso_dmawnz_ns_coor
	calla	insobja8
	movi	a_vs_v,a9
	movk	2,a0
	jsrp	framew

	movi	BURNS1,a5
	movi	>005000d3,a4
	calla	gso_dmawnz_ns_coor
	calla	insobja8
	movi	a_vs_s,a9
	movk	2,a0
	jsrp	framew
	die


mk_bat_signal_f
	movi	>0000013d,a4
	callr	make_a_mk_light
	calla	flip_single
	jruc	signal4

mk_bat_signal
	clr	a4
	callr	make_a_mk_light
signal4	movi	a_mklight,a9
	movk	4,a0
	jsrp	framew
	die

make_a_mk_light
	push	a4
	movi	MKLIGHT1,a5
	calla	gso_dmawnz_ns
	pull	a4
	calla	set_xy_coordinates
	jauc	insobja8


a_mklight
	.long	MKLIGHT1
	.long	MKLIGHT2
	.long	MKLIGHT3
	.long	MKLIGHT4
	.long	MKLIGHT5
	.long	MKLIGHT6
	.long	MKLIGHT7
	.long	MKLIGHT8
	.long	MKLIGHT9
	.long	MKLIGHT10
	.long	MKLIGHT11
	.long	MKLIGHT12
	.long	MKLIGHT13
	.long	MKLIGHT14
	.long	MKLIGHT15
	.long	MKLIGHT16
	.long	MKLIGHT17
	.long	MKLIGHT18
	.long	MKLIGHT19
	.long	MKLIGHT20
	.long	ani_jump,a_mklight

*************************************************************************
*************************************************************************

mk_battle
	movi	BATTLE,a5
	calla	gso_dmawnz_ns
	movk	10,a0
	move	a0,*a8(oypos),w
	calla	center_obj_x
	calla	insobja8		; text: BATTLE

	move	@battle_num,a0,w
	cmpi	999,a0
	jrlo	mkbat3
     	movi	999,a0

mkbat3	move	a0,a7
	movi	100,a2
	divs	a2,a7
	move	a7,b0			; b0 = 100's

	movi	100,a2
	mpys	a2,a7
	move	a0,a3
	sub	a7,a3			; a3 = tens/ones
	move	a3,a7
	movk	10,a2
	divs	a2,a3
	move	a3,b1			; b1 = tens 

	mpys	a2,a3
	sub	a3,a7
	move	a7,b2			; b2 = ones

	move	b0,a7
	jreq	mint6
*
* 3 digits
*
	callr	do_mk_number		; print 100's
	move	a8,a10
	move	b1,a7
	callr	do_mk_number		; print 10's
	move	a8,a9
	move	b2,a7
	callr	do_mk_number		; print 1's
	
	move	*a8(osizex),a0,w
	move	*a9(osizex),a1,w
	move	*a10(osizex),a2,w
	add	a1,a0
	add	a2,a0			; a0 = width of all #'s
	movi	scrrgt/2,a3
	sra	1,a0
	sub	a0,a3
	move	a3,*a10(oxpos),w
	add	a2,a3
	move	a3,*a9(oxpos),w
	add	a1,a3
	move	a3,*a8(oxpos),w
	jruc	mint9
*
* 2 digits
*
mint6	move	b1,a7			; 10's ?
	jreq	mint7			; no

	move	b1,a7
	callr	do_mk_number		; print 10's
	move	a8,a9
	move	b2,a7
	callr	do_mk_number		; print 1's

	move	*a8(osizex),a0,w
	move	*a9(osizex),a1,w
	add	a1,a0		 	; a0 = width of all #'s
	movi	scrrgt/2,a3
	sra	1,a0
	sub	a0,a3
	move	a3,*a9(oxpos),w
	add	a1,a3
	move	a3,*a8(oxpos),w
	jruc	mint9
*
* 1 digit
*
mint7	move	b2,a7
	callr	do_mk_number

	move	*a8(osizex),a0,w
	movi	scrrgt/2,a3
	sra	1,a0
	sub	a0,a3
	move	a3,*a8(oxpos),w

mint9	die



	MOVI	BATTLE0,A5
	calla	gso_dmawnz_ns
;	movi	>002d00b8,a4
	movi	>002000a5,a4
	calla	set_xy_coordinates
	MOVI	BATTLE3,a1
	calla	ani_flag
	calla	insobja8

	MOVI	BATTLE0,A5
	calla	gso_dmawnz_ns
;	movi	>002d00c8,a4
	movi	>002000c8,a4
	calla	set_xy_coordinates
	MOVI	BATTLE4,a1
	calla	ani_flag
	calla	insobja8
	die


do_mk_number
	mmtm	sp,a0,a4,a7,a9
	MOVI	BATTLE0,a5
	calla	gso_dmawnz_ns
	sll	5,a7
	addi	battle_digits,a7
	move	*a7,a1,l
	calla	ani_flag
	movi	>20,a0
	move	a0,*a8(oypos),w		; all on the same y
	calla	insobja8
	mmfm	sp,a0,a4,a7,a9
	rets

battle_digits
	.long	BATTLE0
	.long	BATTLE1
	.long	BATTLE2
	.long	BATTLE3
	.long	BATTLE4
	.long	BATTLE5
	.long	BATTLE6
	.long	BATTLE7
	.long	BATTLE8
	.long	BATTLE9

;***********************************************************************

ochar_pieces
	.long	kano_pieces
	.long	sonya_pieces
	.long	jax_pieces
	.long	ind_pieces
	.long	sz_pieces
	.long	swat_pieces

	.long	lia_pieces
	.long	robo1_pieces
	.long	robo2_pieces
	.long	lao_pieces
	.long	tusk_pieces

	.long	sg_pieces
	.long	st_pieces
	.long	lk_pieces
	.long	smoke_pieces
	.long	sonya_pieces

;**********************************************************************

kano_pieces
	.word	>5e,>32,>12d,>32
	.long	kano_1,kano_2,kano_3,kano_4,0

kano_1	.long	BGKANO1,0
kano_2	.long	BGKANO2,BGKNBLU_P
kano_3	.long	BGKANO3,0
kano_4	.long	BGKANO4,0

BGKANO1	.long	BGKANO1A,BGKANO1B,BGKANO1C,BGKANO1D,0
BGKANO2	.long	BGKANO2A,BGKANO2B,BGKANO2C,BGKANO2D,BGKANO2E,0
BGKANO3	.long	BGKANO3A,BGKANO3B,BGKANO3C,BGKANO3D,0
BGKANO4	.long	BGKANO4A,0

;**********************************************************************

sonya_pieces
	.word	>5e,>32,>12d,>32
	.long	sonya_1,sonya_2,sonya_3,0

sonya_1	.long	BGSONYA1,0
sonya_2	.long	BGSONYA2,BGSNBLU_P
sonya_3	.long	BGSONYA3,0

BGSONYA1	.long	BGSONYA1A,BGSONYA1B,BGSONYA1C,BGSONYA1D,BGSONYA1E,BGSONYA1F,0
BGSONYA2	.long	BGSONYA2A,BGSONYA2B,BGSONYA2C,BGSONYA2D,0
BGSONYA3	.long	BGSONYA3A,BGSONYA3B,BGSONYA3C,BGSONYA3D,BGSONYA3E,BGSONYA3F,BGSONYA3G,0

;**********************************************************************

ind_pieces
	.word	>63,>25,>125,>25
	.long	ind_1,ind_2,ind_3,a0

ind_1	.long	INGRY1,0
ind_2	.long	INBLU1,VINTAN_P
ind_3	.long	INSKIN1,0

INGRY1	.long	INGRY1A,INGRY1B,INGRY1C,INGRY1D,INGRY1E,0
INBLU1	.long	INBLU1A,INBLU1B,INBLU1C,INBLU1D,0
INSKIN1	.long	INSKIN1A,INSKIN1B,INSKIN1C,INSKIN1D,INSKIN1E,INSKIN1F,INSKIN1G,0

;**********************************************************************

jax_pieces
	.word	>63,>20,>125,>20
	.long	jax_1,jax_2,jax_3,a0

jax_1	.long	JXFLESH1,0
jax_2	.long	JXPURP1,VJXGRN_P
jax_3	.long	JXGREY1,0

JXFLESH1	.long	JXFLESH1A,0
JXPURP1	.long	JXPURP1A,JXPURP1B,0
JXGREY1	.long	JXGRY1A,JXGRY1B,JXGRY1C,0

;**********************************************************************

sz_pieces
	.word	>63,>2d,>125,>2d
	.long	sz_1,sz_2,sz_3,a0

sz_1	.long	SZBLUE1,VSZGRN_P
sz_2	.long	SZFLESH1,0
sz_3	.long	SZGREY1,0

SZBLUE1
	.long	SZBLUE1A,SZBLUE1B,SZBLUE1C,SZBLUE1D
	.long	0
SZFLESH1
	.long	SZFLESH1A,SZFLESH1B,SZFLESH1C,SZFLESH1D
	.long	SZFLESH1E,SZFLESH1F,SZFLESH1G,SZFLESH1H
	.long	0
SZGREY1
	.long	SZGREY1A,SZGREY1B,SZGREY1C,SZGREY1D
	.long	SZGREY1E,SZGREY1F,SZGREY1G,0

;**********************************************************************

swat_pieces
	.word	>63,>25,>125,>25
	.long	swat_1,swat_2,swat_3,a0
swat_pieces_end


swat_1	.long	COPBLUE1,VCOPRED_P
swat_2	.long	COPFLESH1,0
swat_3	.long	COPGREY1,0

COPBLUE1
	.long	COPBLUE1A,COPBLUE1B,COPBLUE1C,0
COPFLESH1
	.long	COPFLESH1A,COPFLESH1B,COPFLESH1C,COPFLESH1D
	.long	0
COPGREY1
	.long	COPGREY1A,COPGREY1B,COPGREY1C,COPGREY1D
	.long	0

;**********************************************************************

lia_pieces
	.word	>5d,>35,>12a,>35
	.long	lia_1,lia_2,lia_3,a0

lia_1	.long	LIAFLESH1,0
lia_2	.long	LIAGREY1,0
lia_3	.long	LIAPURP1,VLIABLU_P

LIAFLESH1
	.long	LIAFLESH1A,LIAFLESH1B,LIAFLESH1C,LIAFLESH1D
	.long	LIAFLESH1E,0
LIAGREY1
	.long	LIAGREY1A,LIAGREY1B,LIAGREY1C,0
LIAPURP1
	.long	LIAPURP1A,LIAPURP1B,0

;**********************************************************************

robo2_pieces
	.word	>55,>35,>130,>35
	.long	robo1_1,robo1_2,0

robo1_1	.long	RB1GOLD1,VRBDYEL_P
robo1_2	.long	RB1GREY1,0

RB1GOLD1
	.long	RB1GOLD1A,RB1GOLD1B,RB1GOLD1C,RB1GOLD1D
	.long	RB1GOLD1E,0
RB1GREY1
	.long	RB1GREY1A,RB1GREY1B,RB1GREY1C,RB1GREY1D
	.long	RB1GREY1E,RB1GREY1F,RB1GREY1G,0

;***********************

smoke_pieces
	.word	>55,>35,>130,>35
	.long	smoke_1,smoke_2,0

smoke_1	.long	SMOKE1,VSMOK2_P
smoke_2	.long	RB1GREY1,0

SMOKE1	.long	SMOKE1A,RB1GOLD1B,RB1GOLD1C,RB1GOLD1D
	.long	RB1GOLD1E,0

;RB1GREY1	.long	RB1GREY1A,RB1GREY1B,RB1GREY1C,RB1GREY1D
;	.long	RB1GREY1E,RB1GREY1F,RB1GREY1G,0

SMOKE1A	.word   36,57,98,-30
	.long   05849d7cH
	.word   07580H
	.long   VSMOK1_P

VSMOK1_P:
   .word   128
   .word   00000h,00c46h,07fffh,07bbfh,07fffh,0671dh,06b3eh,06f5eh
   .word   0737fh,039b5h,07fdfh,06b3eh,05279h,05abbh,0569ah,0671dh
   .word   05abbh,05edch,05abbh,0569ah,05279h,0671dh,0737fh,02d52h
   .word   03173h,03594h,041d6h,04a18h,041d6h,04a18h,03594h,04a18h
   .word   05279h,07fdfh,03594h,04a18h,03173h,02d52h,02d52h,039b5h
   .word   03173h,01cceh,03594h,03594h,045f7h,039b5h,04e38h,04a18h
   .word   041d6h,04a18h,05279h,04a18h,02d52h,03573h,03594h,02510h
   .word   03594h,03594h,02931h,041d6h,03173h,02d52h,03594h,041d6h
   .word   04a18h,0671dh,020efh,02931h,03173h,020efh,039b5h,039b5h
   .word   02d52h,03594h,039b5h,041d6h,039b5h,04a18h,05edch,020efh
   .word   039b5h,02510h,018adh,02931h,03594h,01069h,0148ah,018adh
   .word   01cceh,02510h,02931h,02d52h,03173h,041d6h,045f7h,02931h
   .word   020efh,01cceh,0188ch,020efh,02931h,045f7h,00825h,0188ch
   .word   01cceh,020efh,018adh,0148ah,00823h,00c26h,01069h,00c48h
   .word   01069h,00825h,00c26h,00823h,00823h,00823h,018adh,00825h
   .word   00823h,00823h,00823h,02510h,00823h,00823h,01069h,07fffh

;**********************************************************************

robo1_pieces
	.word	>5c,>35,>128,>35
	.long	robo2_1,robo2_2,0

robo2_1	.long	RB2GREY1,0
robo2_2	.long	RB2RED1,VRBDRED_P

RB2GREY1
	.long	RB2GREY1A,RB2GREY1B,RB2GREY1C,RB2GREY1D
	.long	RB2GREY1E,RB2GREY1F,0
RB2RED1
	.long	RB2RED1A,RB2RED1B,RB2RED1C,RB2RED1D
	.long	RB2RED1E,RB2RED1F,RB2RED1G,0

;**********************************************************************

lao_pieces
	.word	>5c,>35,>128,>35
	.long	lao_1,lao_2,lao_3,0

lao_1	.long	KLFLESH1,0
lao_2	.long	KLGREY1,0
lao_3	.long	KLPANTS1,VKLBLU_P

KLFLESH1
	.long	KLFLESH1A,KLFLESH1B,KLFLESH1C,KLFLESH1D
	.long	KLFLESH1E,0
KLGREY1
	.long	KLGREY1A,KLGREY1B,KLGREY1C,KLGREY1D
	.long	KLGREY1E,KLGREY1F,KLGREY1G,0
KLPANTS1
	.long	KLPANTS1A,KLPANTS1B,0

;**********************************************************************

tusk_pieces
	.word	>5c,>35,>128,>35
	.long	tusk_1,tusk_2,tusk_3,0

tusk_1	.long	KBFLESH1,0
tusk_2	.long	KBGRVEST1,0
tusk_3	.long	KBPANTS1,VKBBLU_P

KBFLESH1
	.long	KBFLESH1A,KBFLESH1B,KBFLESH1C,KBFLESH1D
	.long	KBFLESH1E,0
KBGRVEST1
	.long	KBGRVEST1A,KBGRVEST1B,KBGRVEST1C,KBGRVEST1D
	.long	KBGRVEST1E,0
KBPANTS1
	.long	KBPANTS1A,KBPANTS1B,0

;**********************************************************************

sg_pieces
	.word	>5c,>33,>128,>33
	.long	sg_1,sg_2,sg_3,0

sg_1	.long	SHFLESH1,0
sg_2	.long	SHGREY1,0
sg_3	.long	SHRED1,VSHBLU_P

SHFLESH1
	.long	SHFLESH1A,SHFLESH1B,SHFLESH1C,SHFLESH1D
	.long	SHFLESH1E,SHFLESH1F,SHFLESH1G,SHFLESH1H
	.long	SHFLESH1I,0
SHGREY1
	.long	SHGREY1A,SHGREY1B,SHGREY1C,SHGREY1D
	.long	SHGREY1E,SHGREY1F,SHGREY1G,0
SHRED1
	.long	SHRED1A,SHRED1B,SHRED1C,SHRED1D,0

;**********************************************************************

lk_pieces
	.word	>60,>35,>12c,>35
	.long	lk_1,lk_2,lk_3,0

lk_1	.long	LKFLESH1,0
lk_2	.long	LKGREY1,0
lk_3	.long	LKRED1,VLKYEL_P

LKFLESH1
	.long	LKFLESH1A,LKFLESH1B,LKFLESH1C,LKFLESH1D
	.long	LKFLESH1E,0
LKGREY1
	.long	LKGREY1A,LKGREY1B,LKGREY1C,LKGREY1D
	.long	LKGREY1E,0
LKRED1
	.long	LKRED1A,LKRED1B,LKRED1C,0

;**********************************************************************

st_pieces
	.word	>58,>35,>135,>35
	.long	st_1,st_2,st_3,0

st_1	.long	TSFLESH1,0
st_2	.long	TSGREY1,0
st_3	.long	TSPANT1,VTSRED_P

TSFLESH1
	.long	TSFLESH1A,TSFLESH1B,TSFLESH1C,TSFLESH1D
	.long	TSFLESH1E,0
TSGREY1
	.long	TSGREY1A,TSGREY1B,TSGREY1C,TSGREY1D
	.long	TSGREY1E,0
TSPANT1
	.long	TSPANT1A,TSPANT1B,0

**************************************************************************

sspeed	.set	>60000
sdist	.set	>b0

slide_in_huge_players
	movi	>451,a3
	calla	send_code_a3		; Mortal Sans Pre-whoosh buildup

	movk	1,a0
	move	a0,@f_novel,w

	move	@p1_char,a10,w
	sll	5,a10
	addi	ochar_pieces,a10
	move	*a10,a10,l		; grab the ochar frame

	move	*a10,a0,w		; x
	move	*a10(16),a1,w		; y
	addi	16*4,a10

	clr	a2			; player 1 = no flip
slide3	move	*a10,a7,l
	jreq	slide4

	clr	a14
	callr	create_1_piece
	jruc	slide3

slide4	move	@p2_char,a10,w
	sll	5,a10
	addi	ochar_pieces,a10
	move	*a10,a10,l		; grab the ochar frame

	move	*a10(16*2),a0,w		; x
	move	*a10(16*3),a1,w		; y
	addi	16*4,a10

	movk	1,a2			; player 2 = flip
slide5	move	*a10,a7,l
	jreq	slide6

	movk	1,a14
	callr	create_1_piece
	jruc	slide5

slide6	clr	a0
	move	a0,@f_novel,w

	movi	sdist/(sspeed/>10000),a0
	subk	2,a0
	calla	prcslp
	movk	1,a0
	move	a0,@f_novel,w
	retp


create_1_piece
	mmtm	sp,a0,a1,a2
	push	a1
	push	a0
	push	a2
	move	*a10+,a9,l
	calla	gmo_proc

;***************
	move	a14,a14			; player 2 ?
	jreq	c1p3			; no....
	move	@p1_char,a0,w
	move	@p2_char,a1,w
	cmp	a0,a1
	jrne	c1p3			; different characters = skip
	move	*a9(32),a0,l		; alternate palette ?
	jreq	c1p3			; no.

	calla	swpal			; yes, now Gary Penacho is happy :-)
c1p3
;***************

	pull	a3

	movi	sdist,a7
	movi	sspeed,a6		; slide in speed
	move	a3,a3
	jreq	cone3

	neg	a7
	neg	a6
	mmtm	sp,a6,a7
	calla	flip_multi		; player 2 side = face left
	mmfm	sp,a6,a7

cone3	move	a6,*a8(oxvel),l
	pull	a3
	sub	a7,a3
	move	a3,*a8(oxpos),w
	pull	a3
	move	a3,*a8(oypos),w

	calla	set_noscroll

	clr	a0
	move	a0,*a8(ozpos),w		; players in front

	calla	insobja8
	mmfm	sp,a0,a1,a2
	rets

**************************************************************************

combination_proc
	movi	BOX2,a5
	calla	gso_dmawnz_ns

	movi	1,a0
	move	a0,*a8(ozpos),w

	movi	>e9,a4
	move	a4,*a8(oypos),w		; position on bottom of screen
	calla	center_obj_x
	callr	start_off_screen
	move	a8,a9
*
* symbols
*
	move	a13,a3
	addi	p_store1,a3	 	; a3 ---> 1st symbol object
	movk	6,a7		 	; 6 symbols
	movk	2,a6
cproc5	movi	I_DRAGON,a5
	calla	gso_dmawnz
	move	*a9(oxpos),a0,w
	add	a6,a0
	move	a0,*a8(oxpos),w
	move	*a9(oypos),a0,w
	addk	2,a0
	move	a0,*a8(oypos),w
	move	a8,*a3+,l	 	; save object here
	addi	>18,a6		 	; next symbol to the right
	clr	a0
	move	a0,*a8(oslink),w 	; symbol offset
	callr	soff3

	movk	2,a0
	move	a0,*a8(ozpos),w
	dsj	a7,cproc5

	move	@gstate,a0,w
	cmpi	gs_amode,a0
	jaeq	sucide			; attact mode ----> die

	clr	a0
	move	a0,@f_novel,w
	movi	c_hp,a1
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l   		; clear out button ram

cproc7	movi	l_lp,a1
  	clr	a0
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l   		; clear out button ram

	sleep	1

	clr	a4			; bit 0 = player 1 stick up
	callr	setup_direction	
	clr	a0
	move	*a13(p_store1),a8,l
	callr	check_button
	move	*a13(p_store2),a8,l
	callr	check_button
	move	*a13(p_store3),a8,l
	callr	check_button

	movk	8,a4			; bit 8 = player 2 stick up
	callr	setup_direction
	move	*a13(p_store4),a8,l
	callr	check_button
	move	*a13(p_store5),a8,l
	callr	check_button
	move	*a13(p_store6),a8,l
	callr	check_button
	jruc	cproc7



check_button
	push	a0

	move	a0,a2
	sll	5,a0
	addi	button_ram_spots,a0
	move	*a0,a0,l
	move	*a0,a1,w   		; grab it
	jreq	cbut9	   		; not pressed ---> exit

	sll	4,a2
	addi	combo_1,a2		; a2 ---> combo ram to change

	move	*a8(oslink),a0,w
	add	a3,a0
	jrnn	cbut3			; non neg = cool
	movk	9,a0			; neg = back up to 9
	jruc	cbut5
cbut3	cmpi	10,a0
	jrlo	cbut5
     	clr	a0
cbut5	move	a0,*a8(oslink),w
	move	a0,a6			; a6 = new offset for this symbol
	move	a0,a1
	move	a0,*a2,w		; stuff intro combo ram as well

	sll	4,a1
	addi	c_hp,a1
	move	a6,*a1,w		; stuff new offset into ram !!!

	sll	5,a0
	addi	symbol_table,a0
	move	*a0,a1,l
	move	*a1(icmap),a0,l
	calla	swpal	    		; new palette
	calla	ani_flag    		; reshape the symbol

cbut9	pull	a0
	inc	a0
	rets


start_off_screen
	move	*a8(oypos),a0,w
	addi	>25,a0
;	move	a0,*a8(oypos),w

soff3
;	movi	->16000,a0
;	move	a0,*a8(oyvel),l
	jauc	insobja8


setup_direction
	movk	1,a3
	move	@switch,a2,l
	not	a2
	btst	a4,a2			; is our stick bit set ???
	jreq	setd3			; no ---> click forwards
	neg	a3			; yes --> clock backwards
setd3	rets


symbol_table
	.long	I_DRAGON	; 0
	.long	I_MK		; 1
	.long	I_YINYANG	; 2
	.long	I_THREE		; 3
	.long	I_QUESTION	; 4
	.long	I_LIGHTNING	; 5
	.long	I_GORO		; 6
	.long	I_RAIDEN	; 7
	.long	I_SHOKAHN	; 8
	.long	I_SKULL		; 9


button_ram_spots
	.long	l_lp		; symbol #1
	.long	l_block		; symbol #2
	.long	l_lk		; symbol #3
	.long	l_lp+16		; symbol #4
	.long	l_block+16   	; symbol #5
	.long	l_lk+16		; symbol #6

;**************************************************

a_vs_v	.long	BURNV1
	.long	BURNV2
	.long	BURNV3
	.long	BURNV4
	.long	BURNV5
	.long	BURNV6
	.long	BURNV7
	.long	BURNV8
	.long	BURNV9
	.long	BURNV10
	.long	BURNV11
	.long	BURNV12
	.long	BURNV13
	.long	0

a_vs_s	.long	BURNS1
	.long	BURNS2
	.long	BURNS3
	.long	BURNS4
	.long	BURNS5
	.long	BURNS6
	.long	BURNS7
	.long	BURNS8
	.long	BURNS9
	.long	BURNS10
	.long	BURNS11
	.long	BURNS12
	.long	BURNS13
	.long	BURNS14
	.long	BURNS15
	.long	0

;**************************************************

;ochar_alternate_vs
;	.long	BGKNBLU_P
;	.long	BGSNBLU_P
;	.long	VJXGRN_P
;	.long	VINTAN_P
;	.long	VSZGRN_P
;	.long	VCOPRED_P
;	.long	VLIABLU_P
;	.long	VRBDRED_P
;	.long	VRBDYEL_P
;	.long	VKLBLU_P
;	.long	VKBBLU_P
;	.long	VSHBLU_P
;	.long	VTSRED_P
;	.long	VLKYEL_P
;	.long	VSMOK2_P

BGKNBLU_P:
   .word   127
   .word   00000h,0083ch,0317fh,041ffh,00405h,0455fh,00c06h,00803h
   .word   06fdfh,00ca6h,01909h,0679fh,077dfh,04f1fh,05f5fh,05b3fh
   .word   004aeh,00444h,03e9fh,0571fh,046bfh,06f9fh,00048h,000fch
   .word   0093fh,00469h,02e1fh,000feh,000ffh,0115fh,0088bh,021bfh
   .word   0363fh,00421h,00025h,000b8h,000ddh,004d9h,0155dh,01959h
   .word   01936h,029dfh,010a9h,03e5fh,000bbh,008ffh,025bfh,052dfh
   .word   00072h,00074h,0009ah,0009ch,004bch,00494h,00cffh,00868h
   .word   00c8ah,0004fh,00077h,00078h,0009fh,004bfh,00497h,00470h
   .word   008b8h,00cdch,00cdbh,010fch,00cb3h,0151eh,0193fh,01d5fh
   .word   014f5h,0217fh,010abh,014cch,018c6h,00029h,00051h,00053h
   .word   00473h,00cb5h,010d6h,0215bh,018f0h,031dfh,05affh,00056h
   .word   0044dh,010dfh,00c90h,00c8fh,010b1h,04e9fh,00034h,018fah
   .word   01d1dh,01d1ah,0255dh,02d9fh,031bfh,039ffh,03e1fh,0423fh
   .word   0465fh,00038h,0003ah,0003ch,0003fh,0087ch,0255fh,00003h
   .word   00006h,00007h,0000ah,0000ch,0000dh,0000fh,0085fh,00856h
   .word   014beh,00423h,014aeh,00c65h,01cebh,056bfh,0631fh

BGSNBLU_P:
   .word   126
   .word   00000h,0771fh,06f1fh,05f1fh,0571fh,0531fh,0471eh,042ddh
   .word   03ebch,03258h,025f6h,021b3h,01d93h,02194h,02173h,0044ah
   .word   0631fh,042fdh,03679h,02e38h,01db4h,025b5h,00cadh,04f1fh
   .word   04b1fh,03237h,014f0h,03a9ah,02df7h,076ffh,03ebbh,029f5h
   .word   0367ah,01552h,03a59h,03a79h,0429bh,042deh,025f5h,00c09h
   .word   01911h,00005h,010cfh,0631fh,05b1fh,0531fh,04addh,0465ah
   .word   02553h,03e18h,0727dh,03e9ch,0014eh,02ed9h,01e14h,03218h
   .word   06f1fh,035b5h,02d95h,04db5h,05afeh,00c4bh,00c05h,00004h
   .word   00005h,00006h,00006h,0088dh,00caeh,010efh,0146dh,0144ch
   .word   00027h,0188dh,0088eh,0148eh,00009h,00007h,010d0h,0046dh
   .word   01cafh,004ceh,0048eh,018d0h,01d12h,01d53h,020d0h,00cd0h
   .word   024f1h,0180ah,01512h,01d74h,02953h,029b5h,02512h,01d54h
   .word   008efh,00d10h,02912h,0092fh,01d31h,02dd6h,025d6h,035f7h
   .word   035d6h,0365ah,052fdh,03efdh,02531h,03e5ah,0471fh,04e9ch
   .word   010adh,04e7bh,02e79h,04afdh,01d71h,008abh,000abh,00d0dh
   .word   04abbh,03df5h,06b1fh,052ddh,04adeh,01a76h

VJXGRN_P:
   .word   64 
   .word   00000h,02245h,03e0bh,039ebh,039cbh,035ebh,031cah,02566h
   .word   02165h,01944h,01543h,00d22h,00901h,000a0h,008c0h,01102h
   .word   01523h,01d45h,01924h,01964h,00100h,000c0h,00d21h,00d61h
   .word   00160h,00180h,036abh,02da8h,00cc1h,00080h,00080h,00520h
   .word   03e4bh,02987h,00080h,00080h,00540h,00120h,026a6h,02d87h
   .word   004a0h,000c0h,000c0h,03aabh,000e0h,000a0h,01140h,011a1h
   .word   00220h,03b0bh,02567h,01221h,000a0h,000c0h,00180h,036eah
   .word   005e0h,00080h,02927h,02905h,00d60h,021a0h,00080h,00000h

VINTAN_P:
   .word   63 
   .word   0541dh,00821h,03504h,03d24h,06e27h,07e89h,07a48h,06a07h
   .word   061a3h,07e06h,069e5h,05520h,04965h,04545h,059a6h,05dc7h
   .word   061e7h,038c0h,05164h,05da4h,04d22h,044e0h,040c0h,04dc2h
   .word   07e4bh,05921h,04900h,05542h,06209h,04160h,05984h,03904h
   .word   05d63h,030c1h,02060h,07a8dh,071e5h,05183h,07269h,0660bh
   .word   024a2h,05587h,04544h,040e3h,04923h,04523h,06e8bh,04927h
   .word   04d86h,044e5h,01441h,03d25h,04566h,01862h,00000h,051a7h
   .word   00c63h,024a4h,0420dh,05ab1h,07f98h,06ef3h,0628eh

VSZGRN_P:
   .word   128
   .word   00000h,04790h,00124h,005c9h,01252h,026f8h,02b18h,00144h
   .word   00121h,00141h,02f38h,00122h,00147h,0016bh,0016ch,00190h
   .word   00168h,02718h,02b15h,00101h,00121h,00145h,0016ah,0018fh
   .word   001b1h,001f4h,00213h,00212h,001a9h,016b8h,00168h,001afh
   .word   001d3h,00166h,001ceh,00655h,016d8h,01ef8h,02318h,00121h
   .word   00143h,001d2h,00188h,00238h,00234h,00212h,00141h,00186h
   .word   001cah,00a75h,00eb8h,00e95h,0060ch,00183h,01af8h,00166h
   .word   001ach,001cfh,001d0h,00237h,00258h,00187h,00255h,0020fh
   .word   00121h,012d8h,00141h,02338h,00101h,00188h,001abh,001f1h
   .word   001f2h,00214h,00235h,00256h,00210h,00298h,00184h,00673h
   .word   00ab8h,00ab7h,01b18h,0168eh,00141h,00164h,00187h,001cdh
   .word   001f0h,00212h,00256h,00277h,001c9h,00296h,001eah,00ad8h
   .word   001c7h,01718h,00121h,00186h,00276h,00253h,00162h,00274h
   .word   00251h,00ef8h,0064eh,001a4h,001a8h,001cah,002b7h,00294h
   .word   00af8h,01318h,01317h,01b58h,001c4h,001a6h,001ebh,01f78h
   .word   01ecdh,012f2h,00101h,00161h,00183h,00181h,00e48h,003e1h

VCOPRED_P:
   .word   128
   .word   00000h,00000h,00400h,00800h,00c00h,01000h,01400h,01800h
   .word   01c00h,02000h,02000h,02400h,02800h,02c00h,03000h,03400h
   .word   03800h,03c00h,03c00h,04000h,04400h,04400h,04800h,04c00h
   .word   05000h,05400h,05400h,05800h,05820h,00c00h,01800h,05820h
   .word   05c20h,05c40h,02800h,05c40h,06040h,06060h,03801h,05841h
   .word   06061h,06461h,06481h,03402h,04402h,05042h,06482h,06882h
   .word   068a2h,03803h,05023h,06483h,064a3h,068a3h,06ca3h,06cc3h
   .word   06cc4h,070c4h,070e4h,05ca5h,068a5h,074e5h,07505h,03806h
   .word   05c66h,06c86h,07906h,07926h,06c87h,06ca7h,060e7h,07927h
   .word   04ca8h,068e8h,06ce8h,07528h,07928h,07948h,06cc9h,07949h
   .word   064cah,06d0ah,0796ah,06d0bh,0612bh,06d4bh,0796bh,0798bh
   .word   06cach,06cech,06d0ch,05d2ch,0612ch,06d2ch,0712ch,0694ch
   .word   06d4ch,0798ch,060edh,0692dh,06d2dh,0714dh,06d6dh,0798dh
   .word   079adh,06d0eh,06d2eh,06d4eh,0714eh,079aeh,0714fh,0716fh
   .word   079afh,079cfh,079d0h,06d71h,07171h,07191h,079f1h,07172h
   .word   06d92h,07192h,07a13h,071b5h,05dd5h,071d5h,071d6h,07617h

VLIABLU_P:
   .word   128
   .word   00000h,00103h,02358h,00189h,02f57h,03378h,00148h,006d6h
   .word   00060h,01f38h,00210h,001ach,012f7h,01b18h,02b37h,00233h
   .word   001ceh,00253h,02317h,0016bh,0018ch,00233h,00276h,006b8h
   .word   00253h,00ed8h,016f8h,022f6h,0014ah,001f2h,0018dh,001d0h
   .word   00213h,001aeh,001f1h,00255h,00234h,00298h,00277h,00106h
   .word   0016ah,00ab8h,0018bh,00eb7h,012d8h,016d7h,00e0eh,0120dh
   .word   01a4fh,0012ah,0014bh,0018eh,001f3h,0016ch,00214h,001afh
   .word   0014ah,001f2h,00256h,0018dh,001d0h,0016bh,00698h,00676h
   .word   00eb8h,012b7h,01ad7h,022f7h,00060h,00108h,00236h,001d1h
   .word   001f3h,00257h,00235h,0016ch,001f2h,00256h,00a98h,000e4h
   .word   0012ah,00040h,0018eh,00081h,00129h,000c4h,00107h,0014ah
   .word   0018dh,00678h,000a2h,000e5h,00128h,001cfh,00106h,000c3h
   .word   02ef5h,03b58h,00109h,000e7h,0014ch,0016bh,00061h,000e9h
   .word   000a3h,000e6h,00107h,00128h,000e5h,00109h,00040h,005f2h
   .word   000a2h,00109h,000c5h,0012ah,00082h,000e7h,00020h,000c6h
   .word   0012bh,00060h,00081h,00040h,00080h,011c6h,00040h,000e1h

VRBDRED_P:
   .word   128
   .word   00000h,02000h,03000h,02800h,02c00h,02c00h,02800h,02800h
   .word   02000h,01800h,03400h,03400h,03c00h,01000h,01000h,01c00h
   .word   04400h,01400h,02820h,01c00h,02400h,03c42h,02821h,03020h
   .word   01400h,04442h,02462h,05021h,02c00h,03021h,04020h,02000h
   .word   03462h,00000h,00000h,00400h,00800h,00400h,00000h,01000h
   .word   01800h,01821h,02021h,01000h,04107h,03063h,034e7h,02483h
   .word   03421h,00401h,00000h,00000h,00000h,00800h,00400h,03c84h
   .word   01021h,040e6h,0414ah,051ach,0560fh,0458ch,02c00h,01820h
   .word   03863h,04929h,040a5h,03ca4h,06442h,050a5h,04d29h,044e7h
   .word   04484h,044c6h,00000h,06108h,065adh,03420h,0516ah,024e7h
   .word   03400h,01020h,04820h,01863h,02020h,03c00h,0458ah,038a4h
   .word   06b39h,04062h,058a4h,05062h,05484h,05cc5h,06672h,030a5h
   .word   05ce6h,06630h,06694h,04c83h,058a5h,050a4h,05506h,069eeh
   .word   0656ah,048a4h,038a5h,066f5h,03c00h,06462h,04128h,02400h
   .word   03400h,04928h,02800h,04e0eh,00000h,01800h,020e6h,02c00h
   .word   034e6h,0318bh,02cc4h,05694h,01401h,01861h,00000h,00000h

VRBDYEL_P:
   .word   128
   .word   00000h,00000h,06b56h,05ec8h,06b2dh,04e20h,05240h,05661h
   .word   05a82h,02920h,06b07h,062efh,049e0h,05220h,05640h,04e00h
   .word   05220h,05640h,04e21h,04e23h,05a86h,05666h,05eceh,03960h
   .word   03d80h,041a0h,049e0h,05220h,049e0h,04e24h,04e25h,05668h
   .word   05a89h,06712h,049c0h,05620h,03d80h,03960h,045c0h,045c0h
   .word   041a0h,024e0h,04e01h,049e1h,04e02h,05223h,05644h,05247h
   .word   04e27h,05669h,05eabh,05a8bh,03d60h,04180h,045a0h,03120h
   .word   049c0h,045a0h,03540h,05200h,03d80h,03d80h,045c1h,049e2h
   .word   05645h,05a8ch,024c0h,03940h,04180h,02d00h,049c0h,049c0h
   .word   03960h,041a2h,045c3h,049e4h,04e05h,05226h,05eadh,03100h
   .word   051c0h,03520h,024c0h,03940h,045a0h,01860h,01c80h,028c0h
   .word   02ce0h,03920h,03d40h,04560h,04980h,059e0h,05e00h,03d40h
   .word   03100h,02ce0h,020a0h,03100h,03940h,05204h,00800h,024a0h
   .word   030e0h,03500h,028c0h,02080h,00000h,01020h,01c60h,01840h
   .word   01c60h,00c00h,01020h,00400h,00000h,00800h,03546h,01000h
   .word   00000h,00400h,00000h,04189h,00400h,00000h,01063h,07fffh

VKLBLU_P:
   .word   30 
   .word   00000h,00d93h,01192h,0090dh,00d50h,011b5h,01193h,015d6h
   .word   01171h,015b4h,019d5h,004cbh,00930h,00d73h,00d2fh,015d7h
   .word   01172h,01150h,0112eh,01571h,019b4h,01992h,019d7h,00d52h
   .word   00d0eh,0112fh,01572h,0110dh,0048ah,008ach

VKBBLU_P:
   .word   30 
   .word   00000h,01e96h,02296h,02297h,02276h,01e34h,01e35h,01e14h
   .word   019d2h,01df3h,01591h,019b2h,01990h,01570h,0112dh,0112eh
   .word   0154fh,01d91h,00cebh,0110dh,00ccbh,010ech,010edh,00888h
   .word   00ca9h,00caah,00867h,00c67h,00423h,00845h

VSHBLU_P:
   .word   127
   .word   00000h,00831h,0359fh,024d8h,01068h,001e0h,021dbh,021b8h
   .word   0199bh,01979h,01534h,02595h,0088bh,0219ah,0219ch,010cfh
   .word   029bch,0217bh,0259ch,01d35h,029beh,01d34h,02154h,01d5dh
   .word   01917h,0217fh,01d38h,02158h,035fdh,03a1fh,03e3fh,0425fh
   .word   0044ah,00cb8h,0086ch,010d8h,014f7h,00c8dh,014f6h,0191ah
   .word   01d3bh,01d39h,0215bh,02159h,0299fh,0299dh,02dbfh,018f0h
   .word   031dfh,031ddh,00cbah,0086eh,00c92h,00c91h,00c8fh,014fah
   .word   0191ch,01d3eh,010b1h,010b0h,0215eh,0257fh,018f3h,01d16h
   .word   02d9ah,02977h,02554h,02d97h,00c96h,00c95h,010b5h,010b3h
   .word   014d6h,014d4h,018f8h,014d3h,018f6h,01d19h,018f4h,02139h
   .word   0297ch,02559h,02136h,02d9dh,0297ah,031bfh,02557h,02d9bh
   .word   035dfh,031bch,039ffh,03e1fh,0423fh,010bbh,0255eh,00003h
   .word   00004h,00005h,00007h,00431h,0042dh,0042ch,0042bh,00429h
   .word   00852h,00428h,0084eh,00c75h,00426h,0084bh,00c6dh,01092h
   .word   01091h,00848h,00c6ch,01090h,00c6bh,014b2h,01cf9h,0108eh
   .word   00846h,00423h,0108ch,018d1h,02116h,02536h,02955h

VTSRED_P:
   .word   32 
   .word   00000h,01401h,03c0ah,02c06h,03007h,0540fh,05810h,0440bh
   .word   04c0dh,06412h,06813h,07015h,02404h,02805h,0400ah,0540eh
   .word   0580fh,06011h,02003h,03808h,03c09h,0500dh,06c13h,02404h
   .word   01c02h,01801h,02804h,02000h,02422h,00800h,00800h,00800h

VLKYEL_P:
   .word   64 
   .word   00000h,02d46h,018e3h,028a0h,03900h,07aeah,038c0h,044e0h
   .word   04900h,07ac9h,04ce0h,03880h,04080h,05080h,04c80h,04080h
   .word   058a0h,054a0h,04ca0h,048a0h,058c0h,03080h,054c0h,064e0h
   .word   050c0h,060e0h,02c80h,058e0h,054e0h,06100h,07120h,02480h
   .word   07940h,06920h,030a0h,06520h,06d40h,02080h,07560h,02ca0h
   .word   07160h,07980h,05d40h,06560h,079a1h,024a0h,06980h,01880h
   .word   079c2h,04520h,079e3h,061a1h,07a04h,03500h,01ca0h,07a25h
   .word   04140h,07a46h,07a67h,01080h,07a88h,0770ch,07b2dh,00000h

VSMOK2_P:
   .word   128
   .word   00000h,00002h,06f7bh,06b3bh,06f7bh,05699h,05abah,05edah
   .word   062fbh,02931h,06f5bh,05abah,041f5h,04a37h,04616h,05699h
   .word   04a37h,04e58h,04a37h,04616h,041f5h,05699h,062fbh,01cceh
   .word   020efh,02510h,03152h,03994h,03152h,03994h,02510h,03994h
   .word   041f5h,06f5bh,02510h,03994h,020efh,01cceh,01cceh,02931h
   .word   020efh,00c4ah,02510h,02510h,03573h,02931h,03db4h,03994h
   .word   03152h,03994h,041f5h,03994h,01cceh,024efh,02510h,0148ch
   .word   02510h,02510h,018adh,03152h,020efh,01cceh,02510h,03152h
   .word   03994h,05699h,0106bh,018adh,020efh,0106bh,02931h,02931h
   .word   01cceh,02510h,02931h,03152h,02931h,03994h,04e58h,0106bh
   .word   02931h,0148ch,00829h,018adh,02510h,00005h,00406h,00829h
   .word   00c4ah,0148ch,018adh,01cceh,020efh,03152h,03573h,018adh
   .word   0106bh,00c4ah,00808h,0106bh,018adh,03573h,00001h,00808h
   .word   00c4ah,0106bh,00829h,00406h,00000h,00002h,00005h,00004h
   .word   00005h,00001h,00002h,00000h,00000h,00000h,00829h,00001h
   .word   00000h,00000h,00000h,0148ch,00000h,00000h,00005h,06f7bh

;**************************************************************************

	.end

