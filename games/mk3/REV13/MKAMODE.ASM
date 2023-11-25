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
	.file	"mkamode.asm"
	.title	" <<< mortal kombat attract mode code >>> "

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

	.ref	coin_page,read_dip,coinflag

	.even
	.text

**************************************************************************
*												*
*		     attract mode entry point						*
*												*
**************************************************************************
amode
	.if ejbbug
	movk	1,a0
	move	a0,@f_fastrun,w			; run fast
	move	a0,@f_nopower,w			; run fast
	.endif

;*****************
;	.if ejbbug
;	sleep	020H
;	jauc	round_loop
;	.endif
;*****************

	callr	amode_init
	movk	gs_amode,a0
	move	a0,@gstate,w			; game state = amode 

	jsrp	aama_message

	movk	4,a0				; # of times to run look w/sounds

amode_loop
	pushp	a0

	jsrp	midway_presents
	jsrp	raiden_intro
	jsrp	quote
	jsrp	title_page
	clr	a3
	calla	send_code_a3
	jsrp	print_rankings
	jsrp	amode_coin_page

	clr	a0
	jsrp	amode_story
	movk	1,a0
	jsrp	amode_story
	movk	2,a0
	jsrp	amode_story			; story time 1-2-3

	jsrp	coin_bio_fight

	movk	3,a0
	jsrp	amode_story
	movk	4,a0
	jsrp	amode_story
	movk	5,a0
	jsrp	amode_story
	movk	6,a0
	jsrp	amode_story

	jsrp	coin_bio_fight

	movk	7,a0
	jsrp	amode_story
	jsrp	coin_bio_fight
	movk	8,a0
	jsrp	amode_story
	jsrp	coin_bio_fight
	movk	9,a0
	jsrp	amode_story
	jsrp	coin_bio_fight

	jsrp	aama_message

	pullp	a0
	dsj	a0,amode_loop

	push	a0
	calla	nosounds
	movk	1,a0
	move	a0,@f_nosound,w	  	; flag: no sounds allowed
	pull	a0
	jruc	amode_loop


coin_bio_fight
	jsrp	amode_coin_page
	jsrp	mk3_bio
	jauc	amode_demo_fight

;*********************************************

raiden_intro
	calla	view_page_1
	calla	oinit
	calla	page_0_zip_setup
	calla	view_page_1

	clr	a10			; a10 = coordinates of movie clip
	movk	010H,a0
	jsrp	display_zipped_pic

	movi	0429H,a3
	calla	send_code_a3  		; bell

	movi	000180108H,a9
	movi	txt_raiden,a8
	movi	dlists_bogus,a0
	move	a0,@dlists,l
	jruc	story_print


amode_story
	move	a0,a1
	sll	4,a1			; word
	sll	5,a0
	add	a1,a0
	addi	story_pointers,a0
	move	*a0(16),a8,l		; a8 = text
	move	*a0,a0,w		; table offset


	move	a0,*a13(p_store1),w
	pushp	a8
	calla	view_page_1
	calla	oinit
	calla	page_0_zip_setup
	calla	view_page_1

	move	*a13(p_store1),a0,w
	movi	(01000H*01bH)+(8*0),a10	; a10 = coordinates of movie clip
	jsrp	display_zipped_pic

	movi	011H,a0
	sll	5,a0
	addi	table_o_mods,a0
	move	*a0,a0,l
	calla	init_bakmods
	calla	multi_plane

	movi	000a400c7H,a9
	pullp	a8

story_print
	clr	a6
	move	a6,@f_auto_erase,w
	jsrp	pds_centered

	calla	display_on
	sleep	3
	calla	view_page_0
	sleep	040H*13
	jruc	smooth_black_retp


story_pointers
	.word	022H
	.long	txt_story2a
	.word	023H
	.long	txt_story2b
	.word	024H
	.long	txt_story2c

	.word	025H
	.long	txt_story3a
	.word	026H
	.long	txt_story3b
	.word	027H
	.long	txt_story3c
	.word	028H
	.long	txt_story3d

	.word	011H
	.long	txt_kano_story
	.word	012H
	.long	txt_subzero_story
	.word	00fH
	.long	txt_liu_story


txt_liu_story
	.string "AFTER WINNING THE FIRST MORTAL KOMBAT AND\n"
	.string "ESCAPING FROM THE OUTWORLD, LIU KANG LOOKS\n"
	.string "TO THE FUTURE. HE BEGINS TRAINING A NEW\n"
	.string "GENERATION OF SHAOLIN ALONGSIDE KUNG LAO.\n"
	.string "BUT NOTHING COULD PREPARE THEM FOR THE\n"
	.string "UNEXPECTED OUTWORLD INVASION.\n"
	.byte	0
	.even

txt_kano_story
	.string "AFTER THE FIRST TOUNAMENT SONYA BLADE\n"
	.string "TURNED UP MISSING. JAX THEN EMBARKED ON A\n"
	.string "RESCUE MISSION INTO THE OUTWORLD. HE FOUND\n"
	.string "SONYA BEING HELD CAPTIVE WITH HER NEMESIS\n"
	.string "KANO. IN FREEING SONYA, JAX ALSO FREES KANO.\n"
	.string "KANO THEN USES THE CHANCE TO ESCAPE ARREST.\n"
	.byte	0
	.even

txt_subzero_story
	.string "THE ULTIMATE ADVANCEMENT IN LIN KUEI TECH-\n"
	.string "NOLOGY COMES WITH THE CREATION OF THE FIRST\n"
	.string "CYBER-ASSASIN. THEY BEGIN CONVERTING THEIR\n"
	.string "HUMAN NINJAS INTO SOULLESS MACHINES. BUT\n"
	.string "SUB-ZERO REFUSES TO TAKE PART AND IS\n"
	.string "MARKED FOR DEATH BY HIS OWN CLAN.\n"
	.byte	0
	.even

txt_raiden
	.string	"YOU HAVE BEEN CHOSEN\n"
	.string "TO REPRESENT EARTH IN\n"
	.string "MORTAL KOMBAT.\n"
	.string "BE WARNED.\n"
	.string	"ALTHOUGH YOUR SOULS ARE\n"
	.string "PROTECTED AGAINST SHAO\n"
	.string "KAHN'S EVIL; YOUR\n"
	.string "LIVES ARE NOT.\n"
	.string "I CANNOT INTERFERE\n"
	.string "ANY LONGER AS YOUR\n"
	.string "EARTH IS NOW RULED BY\n"
	.string "THE OUTWORLD GODS.\n\n"
	.string "THESE ARE THE WORDS OF\n"
	.string "RAIDEN.\n"
	.byte	0
	.even

txt_story2a
	.string "FOR CENTURIES EARTH HAS USED MORTAL KOMBAT\n"
	.string "TO DEFEND ITSELF AGAINST THE OUTWORLD'S\n"
	.string "EMPEROR SHAO KAHN. BUT, KAHN BECOMES\n"
	.string "FRUSTRATED BY FAILED ATTEMPTS AT TAKING\n"
	.string "EARTH THROUGH TOURNAMENT BATTLE. HE ENACTS\n"
	.string "A PLAN WHICH BEGAN 10,000 YEARS AGO.\n"
	.byte	0
	.even

txt_story2b
	.string "DURING THIS TIME KAHN HAD A QUEEN. HER\n"
	.string "NAME WAS SINDEL AND HER YOUNG DEATH WAS\n"
	.string "UNEXPECTED. KAHN'S SHADOW PRIESTS, LEAD\n"
	.string "BY SHANG TSUNG, MAKE IT SO SINDEL'S SPIRIT\n"
	.string "WOULD SOMEDAY BE REBORN; NOT ON THE\n"
	.string "OUTWORLD BUT ON THE EARTH REALM ITSELF.\n"
	.byte	0
	.even

txt_story2c
	.string "THIS UNHOLY ACT GIVES SHAO KAHN THE POWER\n"
	.string "TO STEP THROUGH THE DIMENSIONAL GATES AND\n"
	.string "RECLAIM HIS QUEEN. THUS ENABLING HIM TO\n"
	.string "FINALLY SEIZE THE EARTH REALM.\n"
	.byte	0
	.even

txt_story3a
	.string "UPON BREACHING THE PORTAL INTO EARTH,\n"
	.string "SHAO KAHN SLOWLY TRANSFORMS THE PLANET\n"
	.string "INTO A PART OF THE OUTWORLD ITSELF.\n"
	.byte	0
	.even

txt_story3b
	.string "KAHN STRIPS THE EARTH OF ALL HUMAN LIFE;\n"
	.string "CLAIMING EVERY SOUL AS HIS OWN.\n"
	.byte	0
	.even

txt_story3c
	.string "BUT THERE ARE SOULS WHICH KAHN CANNOT TAKE.\n"
	.string "THESE SOULS BELONG TO THE WARRIORS CHOSEN\n"
	.string "TO REPRESENT EARTH IN A NEW MORTAL KOMBAT.\n"
	.byte	0
	.even

txt_story3d
	.string "THE REMAINING HUMANS ARE SCATTERED\n"
	.string "THROUGH OUT THE PLANET. SHAO KAHN SENDS\n" 
	.string "AN ARMY OF FIERCE OUTWORLD WARRIORS\n" 
	.string "TO FIND AND ELIMINATE THEM.\n"
	.byte	0
	.even

;raid1 with heads
	.string "SOME OF EARTH'S WARRIORS\n"
	.string "SURVIVE THE ATTACKS.\n"
	.byte	0
	.even

;raid1 with kilcage
	.string "MOST DO NOT.\n"
	.byte	0
	.even

;words alone
	.string "BUT THE REMAINING FEW HOLD THE ONE\n"
	.string "CHANCE AT SAVING ALL OF HUMAN KIND.\n"
	.byte	0
	.even

;*********************************************

quote
	callr	amode_init_no_score
	movi	txt_quote1,a8
	movi	0007000c8H,a9
	jsrp	pds_centered
	jruc	prepare_for_zip_pic

quote_table
	.long	txt_quote1
	.long	txt_quote1
	.long	txt_quote1
	.long	txt_quote1

txt_quote1
	.string	"THERE IS NO KNOWLEDGE THAT IS NOT POWER",0
	.even


;*********************************************

aama_message
	callr	amode_init_no_score
	calla	page_0_zip_setup

	calla	clr_scrn

	movi	blue_grad_pal,a0
	jsrp	do_the_grad_thang
	movi	txt_warning,a8
	movi	0005000c8H,a9
	jsrp	pds_centered

	calla	display_on
	calla	view_page_0
	movi	040H*6,a10
	jsrp	fadein_jsrp
	jruc	amode_fade_retp

txt_warning
	.string	"AAMA PARENTAL ADVISORY\n\n"
	.string	"LIFE-LIKE VIOLENCE - STRONG\n"
	.string	"CONTAINS SELECTED, GRAPHIC SCENES\n"
	.string	"INVOLVING HUMAN-LIKE CHARACTERS\n"
	.string	"ENGAGED IN INTENSE COMBATIVE ACTIVITY."
	.byte	0
	.even

;*********************************************

midway_presents
	calla	nosounds
	sleep	1

	movi	03eH,a3
	calla	send_code_a3
	callr	amode_init_no_score
	movi	0007000c8H,a9
	movi	txt_midway_presents,a8
;	jsrp	pds_centered
	jsrp	p15_centered

prepare_for_zip_pic
	movi	040H*2,a10
	jsrp	fadein_jsrp

	calla	page_0_zip_setup
	calla	view_page_1
	movk	1,a0
	move	a0,@f_auto_erase,w
	sleep	2
	clr	a0
	move	a0,@f_auto_erase,w
	retp

;*********************************************

;motaro_bio
;	movi	029H,a0
;	clr	a10
;	jsrp	show_full_screen_zip
;	tsound	090H				; MOTARO !!
;
;	sleep	038H
;	movi	038H,a3
;	calla	send_code_a3
;
;	sleep	040H*10
;
;	clr	a3
;	calla	send_code_a3
;	jruc	smooth_black_retp
;
;	movi	0007000c8H,a9
;	movi	txt_midway_presents,a8
;	jsrp	pds_centered

;*********************************************

title_page
	movk	14,a0
	movi	(01000H*8)+(8*024H),a10	; a10 = coordinates of movie clip
	jsrp	show_full_screen_zip
	sleep	040H*5
	jruc	smooth_black_retp

show_full_screen_zip
	mmtm	sp,a0,a10
	calla	view_page_1
	calla	oinit
	calla	page_0_zip_setup
	calla	view_page_1
	mmfm	sp,a0,a10

	jsrp	display_zipped_pic
	calla	view_page_0
	retp

txt_midway_presents
	.string	"MIDWAY PRESENTS",0
	.even

;************************************************************

amode_demo_fight
	callr	amode_init_no_score

	move	@c_amode_bio,a0,w
	cmpi	13,a0
	jrls	adg4
	movk	1,a0
adg4	move	a0,@p1_char,w		; player 1 = bio dude

	movk	14,a0
	move	@f_smoke,a1,w
	jreq	adg5
	movk	15,a0			; smoke active = include him !!
adg5	calla	randu
	dec	a0
	move	a0,@p2_char,w		; random player 2

	jsrp	vs_or_ladder

	create	pid_amode,amode_demo_game
	sleep	6
	create	pid_repell,repell

	sleep	040H*12

	calla	play_ending_chord
	calla	murder
	jsrp	freeze_2_pages
	sleep	030H

	move	@c_amode_bio,a0,w
	inc	a0
	cmpi	13,a0
	jrls	bio2
	clr	a0
bio2	move	a0,@c_amode_bio,w

	jruc	amode_fade_retp

;	movi	040H,a10
;	jsrp	fast_fadeout_jsrp
;	jruc	amode_init_system

;************************************************************

amode_init
	movk	4,a0
	movb	a0,*a13(p_hit)
	clr	a0
	move	a0,@c_amodeloop,w
	calla	read_dip
	andi	dip_amsounds,a0		; attract sounds ?
	jreq	ainit4			; yes
	callr	amode_shutup
ainit4	movk	7,a0
	calla	randu
	dec	a0
	move	*a13(p_action),a0,w

	calla	update_pmsg		; update player message
	clr	a0
	move	a0,@coinflag,w		; flag: coin page not up

	movk	14,a0
	calla	randu
	dec	a0
	move	a0,@c_amode_bio,w
	rets

amode_shutup
	calla	nosounds
	movk	1,a0
	move	a0,@f_nosound,w		; no, shut up
	clr	a0
	movb	a0,*a13(p_hit)
	rets


amode_init_no_score
	callr	amode_oinit
	jauc	dont_show_scores

amode_oinit
	calla	murder_myoinit_score

	movi	dlists_bogus,a0
	move	a0,@dlists,l

	clr	a0
	move	a0,@irqskye,w
	move	a0,@noflip,w			; page flipping on
	movk	1,a0
	move	a0,@f_doscore,w			; show scores
	rets

amode_init_system
	calla	murder_myoinit_score
;	calla	clr_scrn
	clr	a0
	move	a0,@irqskye,w
	move	a0,@noflip,w			; page flipping on
	movk	1,a0
;	move	a0,@f_doscore,w			; show scores
	move	a0,@f_auto_erase,w
	calla	dont_show_scores
	calla	nosounds
	calla	clr_scrn

	sleep	2
	retp

**************************************************************************
*											     *
*  gover_amode_entry - game over attract mode entry point			     *
*											     *
**************************************************************************
gover_amode_entry
	movi	0800H,a9
	create	pid_fade,skydown
	jsrp	amode_fade_retp

	callr	amode_init
	movk	gs_amode,a0
	move	a0,@gstate,w   		; game state = amode 

	jsrp	advertise_mk_movie
	jsrp	print_rankings
	jruc	amode	  		; start the attract mode

advertise_mk_movie
	movi	02cH,a0
	movi	0160H,a10		; a10 = coordinates of movie clip
	jsrp	show_full_screen_zip
	sleep	040H*7
	jruc	smooth_black_retp


amode_fade_retp
	movi	020H,a10
	jsrp	fadeout_jsrp

smooth_black_retp
	callr	amode_display_reset
	sleep	6

amode_retp
	retp

amode_display_reset
	calla	murder_myoinit
	clr	a0
	move	a0,@f_doscore,w		; score bars = no
	movk	1,a0
	move	a0,@f_auto_erase,w

	calla	clr_scrn
	rets

;*************************************************************************

blue_grad_pal
	.word	32

	.word	31
	.word	30
	.word	29
	.word	28
	.word	27
	.word	26
	.word	25
	.word	24
	.word	23
	.word	22
	.word	21
	.word	20
	.word	19
	.word	18
	.word	17
	.word	16

	.word	15
	.word	14
	.word	13
	.word	12
	.word	11
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	0

	.end
