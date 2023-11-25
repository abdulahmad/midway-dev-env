**************************************************************************
*											     *
*  video game project:	mortal kombat							*
* 											     *
*  game software:    	ed boon								     *
* 											     *
*  module: mkbuyin       Buy-in logic								*
* 											     *
*  copyright (c) 1993 Midway Manufacturing							*
*											     *
**************************************************************************
	.file	"mkbuyin.asm"
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
	.include	bgndtbl.glo
	.include	stringh.asm
	.include	diagaudn.asm

	.text

slide_vel	.set	3
slide_time	.set	040H

**************************************************************************
*											     *
*  do_buyin - main game loop goes here to run the buyin count    		*
*             down while there is only one player on the game.   		*
* 											     *
*  input: a10 --> winner's game state ram						     *
*         a11 --> loser's game state ram						     *
*											     *
**************************************************************************
do_buyin
	move	@p1_state,a0,w
	move	@p2_state,a1,w
	movi	ps_buyin,a2
	calla	double_compare		; anybody need a buyin ?
	jrne	buyin_retp

	movk	gs_buyin,a0
	move	a0,@gstate,w		; game state = buyin

	movi	p1_wiar,a6
;	movi	p1_score,a7
	move	@p1_state,a0,w
	cmpi	ps_buyin,a0
	jreq	opb5
	movi	p2_wiar,a6
;	movi	p2_score,a7

opb5	clr	a0
	move	a0,*a6,w		; loser = zero wins in a row
;	move	a0,*a7,l		; loser = zero score
	calla	murder			; stop all other procs !
	sleep	4			; allow flash_pmsg to settle in
*
* freeze the screen
*
	jsrp	freeze_2_pages

	calla	bakclr
	clr	a0
	move	a0,@p1_obj,l
	move	a0,@p2_obj,l
	move	a0,@f_shadows,w
	calla	dont_show_scores

	movi	buyin_mod,a0
	calla	init_bakmods
	calla	multi_plane		; buyin mod
*
* player 1 text
*
	move	@p1_state,a0,w
	cmpi	ps_active,a0
	jreq	buy1			; player 1 active ----> no text for him

	movi	pf_player1,a8
	jsrp	lm_printf		; player 1
	movi	pf_pmessage,a8
	move	@p1_state,a0,w
	callr	get_buyin_msg

	movi	000b60065H,a9		; player 1 y:x coordinates
	jsrp	p15_centered

	movi	objlst2,a0		; from
	movi	objlst,a1		; to
	calla	move_object_list	; move text to list #1
	move	@objlst,a0,l
	callr	adjust_menu_down
*
* player 2 text
*
buy1	move	@p2_state,a0,w
	cmpi	ps_active,a0
	jreq	buy2			; player 2 active ----> no text for him

	movi	pf_player2,a8
	jsrp	lm_printf		; player 2
	movi	pf_pmessage,a8
	move	@p2_state,a0,w
	callr	get_buyin_msg

	movi	000b60128H,a9		; player 2 y:x coordinates
	jsrp	p15_centered

	move	@objlst2,a0,l
	callr	adjust_menu_down
	movi	objlst2,a0		; from
	movi	objlst,a1		; to
	calla	move_object_list	; move text to list #1

buy2	movi	fl_num,a11
	create	pid_fx,boonpal_stuff	; flash letters (not boonpal!)

	movi	baklst1,a0
buy3 	move	a0,a1			; a1 = previous obj
	move	*a0,a0,l
	move	*a0(ozval),a14,l
	cmpi	100,a14			; zpos = 100 ----> "thickness piece"
	jrne	buy3

	clr	a14
	move	a14,*a1,l		; end the NON-100 list
	move	a0,@baklst3,l		; list 3 = thickness pieces

;	movi	baklst2,a0
;buy4 	move	a0,a1			; a1 = previous obj
;	move	*a0,a0,l
;	move	*a0(ozval),a14,l
;	jreq	buy4
;
;	clr	a14
;	move	a14,*a1,l		; end the z-zero list
;	move	@baklst2,a2,l
;	move	a0,@baklst2,l		; list 2 = first non-zero obj
;	move	a2,@baklst4,l		; list 4 = thickness pieces

*
* move each door piece offscreen
*
	move	@baklst1,a0,l
	callr	adjust_menu_up
	move	@baklst3,a0,l
	callr	adjust_menu_up
	move	@baklst2,a0,l
	callr	adjust_menu_down

	movi	slide_time+1,a0
	move	a0,@l_hp,w		; set ticks till we stop menu
	movi	menu_monitor,a0		; monitor menu movement in the interupt
	move	a0,@call_every_tick,l
	clr	a0
	move	a0,@f_novel,w		; allow menu movement !!
	calla	display_on		; go !!

	tsound	003H			; doors closing sound

buyin2	sleep	1
	move	@f_novel,a0,w		; still sliding menu in ?
	jreq	buyin2			; yes

	tsound	004H			; door slam sound

	movk	1,a0
	move	a0,@f_auto_erase,w		; we want autoerase

	movi	baklst3,a2
	calla	delolist
	movi	000030005H,a11
	calla	shake_a11    			; skake a bit

;	create	pid_cred,show_credits	; keep current # of credits up

	sleep	020H				; cuz dan says so
	movi	038H,a3
	calla	send_code_a3			; buyin tune

	movk	3,a0				; # of times u r allowed to
	move	a0,*a13(p_anicount),w	; reset buyin timer !!

coins_were_added
	move	*a13(p_store1),a8,l

	calla	get_credits
	move	a0,*a13(p_anirate),w		; a10 = latest # of credits
	clr	a0
	move	a0,@f_start_pressed,w	; let player reset with start !!
	movk	9,a11

**************************************************************************
*											     *
*   tick,tick,tick...									     *
*											     *
**************************************************************************

bcount3	callr	shape_buyin_num
	movi	060H/2,a10		; a10 = tick timer speed
bcount4	sleep	2
	calla	get_credits		; a0 = current # of creds
	move	*a13(p_anirate),a1,w	; a1 = saved creds
	cmp	a0,a1			; same # creds as last time we checked
	jrne	coins_were_added	; no, update the message

	move	@f_start_pressed,a0,w	; start pressed ?
	jreq	bcount5				; sans
	clr	a0
	move	a0,@f_start_pressed,w	; reset
	move	*a13(p_anicount),a0,w	; allowed to reset ?
	jreq	bcount5				; sans
	dec	a0
	move	a0,*a13(p_anicount),w	; yes
	jruc	coins_were_added		; reset clock

bcount5	move	@switch,a0,l
	not	a0				; look at switches
	andi	p1b0|p1b1|p1b2|p1b3|p1b4|p1b5|p2b0|p2b1|p2b2|p2b3|p2b4|p2b5,a0
	jrne	bcount7				; button pressed !!
	jruc	bcount6

bcount7	cmpi	5,a10
	jrls	bcount6				; already blazing !
	movk	5,a10				; pressed ---> speed things up

bcount6	dsj	a10,bcount4
	dec	a11
	jrnn	bcount3

	callr	elminate_buyins

buyin_retp
	retp

*
* countdown # objects
*
countdown_objects
	mmtm	sp,a0,a1,a5,a8,a9,a10,a11

	movi	BIGFONT_1,a5
	calla	gso_dmawnz

;	movi	count_img,a5
;	calla	get_single_obj
;	movi	00202H,a0
;	move	a0,*a8(oconst),w

	movk	2,a0
	move	a0,*a8(ozpos),w
	callr	buyin_pick
	calla	set_xy_coordinates
	calla	insobj2a8
	move	a8,a9	   		; a9 = front number obj

;	movi	count_img,a5
;	calla	get_single_obj
;	movi	bpal_black,a0
;	move	a0,*a8(oconst),w
;	callr	buyin_pick
;	addi	000020002H,a4
;	calla	set_xy_coordinates
;	calla	insobj2a8

	movk	9,a11
	callr	shape_buyin_num
	move	a8,*a13(p_store1),l

	mmfm	sp,a0,a1,a5,a8,a9,a10,a11
	rets

;************************************************

get_buyin_msg
	push	a0
	calla	lm_setup
	movi	txt_prepare,a8
	pull	a14
	sll	5,a14
	addi	ps_buyin_offsets,a14
	move	*a14,a14,l
	jump	a14

ps_buyin_offsets
	.long	gb_join_in	; 0
	.long	gb_active	; 1
	.long	gb_buyin	; 2
	.long	gb_messup	; 3
	.long	gb_messup	; 4

gb_join_in
	movi	txt_press_join,a8
	calla	cr_strtp		; enough to start ?
	jahs	gbuy9			; yes
gb_messup
	movi	txt_insert_start,a8	; no, say INSERT COIN
	jruc	gbuy9			; yes

gb_buyin
	callr	get_ctc_msg
	callr	countdown_objects

gb_active
gbuy9	rets


;************************************************

get_ctc_msg
	calla	cr_strtp		; enough to start ?
	jahs	ctc6			; yes

	movi	txt_1_coin,a8		; assume 1 credit to continue
        	movi    adjccont,a0
        	calla   get_adj			; get number needed
	cmpi	1,a0
	jreq	ctc4			; 1 = we have correct msg
	movi	txt_2_coins,a8
	cmpi	2,a0
	jreq	ctc4			; 2 = we have correct msg
	movi	txt_x_coins,a8
ctc4	rets

ctc6	movi	txt_start_to_continue,a8
	rets

;************************************************

adjust_menu_down
	movi	(slide_time*slide_vel),a1
	movi	-slide_vel*010000H,a2
	jruc	amenu2

adjust_menu_up
	movi	-(slide_time*slide_vel),a1
	movi	slide_vel*010000H,a2

amenu2	move	*a0(oypos),a3,w
	add	a1,a3
	move	a3,*a0(oypos),w		; adjust 1 piece at a time
	move	a2,*a0(oyvel),l		; give piece a velocity

	move	*a0(oflags2),a3,w
	andni	m_noscroll,a3
	move	a3,*a0(oflags2),w	; clear no scroll bit

	move	*a0,a0,l
	jrne	amenu2
	rets

menu_monitor
	move	@l_hp,a0,w
	dec	a0
	move	a0,@l_hp,w
	jrne	mm3
	movk	1,a0
	move	a0,@f_novel,w		; flag: stop menu movement !
mm3	rets


buyin_pick
	movi	000e00068H,a4
	move	@p1_state,a0,w
	cmpi	ps_buyin,a0
	jreq	bip4
	movi	000e00128H,a4
bip4	rets


**************************************************************************
*											     *
*  elminate_buyins - eliminate any players who are currently in	     *
*                     buyin state							     *
*											     *
**************************************************************************
elminate_buyins
	movi	p1_state,a1
	movi	p1_wiar,a2
	callr	elim2
	movi	p2_state,a1
	movi	p2_wiar,a2


elim2	move	*a1,a0,w		; current state ?
	cmpi	ps_buyin,a0		; buyin ?
	jrne	elim3			; nope

	clr	a0
	move	a0,*a1,w		; yes ---> you're history
	move	a0,*a2,w		; zero wins in a row
elim3	rets



shape_buyin_num
	move	a11,a0
	sll	5,a0
	addi	font15_nums,a0
	move	*a0,a1,l
	calla	ani_flag		; shape the drop shadow
	rets

count_img
	.word   10,10,0,0
	.long   02000000H
	.word   dmacnz
	.long   boonpal

bbox_image
	.word	10,071H,0,0
	.long	02000000H

fl_num
	.word	bpal_flash2,6
	.word	rgb_red
	.word	rgb_white
	.word	end_stuff

pf_start_info
	mess_mac rd7font,2,200,0eaH,bpal_white*010000H,strcnrmos,0
	.STRING	"START BUTTON RESETS TIMER",0
	.even

pf_player1
	mess_mac rd7font,2,068H,0a8H,bpal_white*010000H,strcnrmos,0
	.STRING	"PLAYER 1",0
	.even

pf_player2
	mess_mac rd7font,2,0128H,0a8H,bpal_white*010000H,strcnrmos,0
	.STRING	"PLAYER 2",0
	.even

pf_pmessage
	mess_mac rd15font,0,011H,060H,bpal_hot_green*010000H,strcnrmos,0
	.byte	0
	.even

txt_prepare
	.STRING	"PREPARE\n"
	.STRING	"FOR YOUR\n"
	.STRING	"NEXT\n"
	.STRING	"CHALLENGE"
	.byte	0
	.even

txt_start_to_continue
	.STRING	"PRESS START\n"
	.STRING	"TO KONTINUE"
	.byte	0
	.even

txt_press_join
	.STRING	"PRESS START\n"
	.STRING	"TO\n"
	.STRING	"JOIN IN"
	.byte	0
	.even

txt_insert_start
	.STRING	"INSERT KOIN\n"
	.STRING	"TO\n"
	.STRING	"JOIN IN"
	.byte	0
	.even

txt_1_coin
	.STRING	"1 KREDIT\n"
	.STRING	"TO KONTINUE",0
	.even

txt_2_coins
	.STRING	"2 KREDITS\n"
	.STRING	"TO KONTINUE",0
	.even

txt_x_coins
	.STRING	"INSERT KOIN\n"
	.STRING	"TO KONTINUE",0
	.even

txt_press_start
	.STRING	"PRESS\n"
	.STRING	"START"
	.byte	0
	.even

txt_insert_coin
	.word	088H,05cH-010H,bpal_red
	.STRING	"INSERT KOIN",0
	.even

***************************************************

 	.end
