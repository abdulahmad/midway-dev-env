**************************************************************************
*											     *
*  video game project:	  Mortal Kombat 3							*
* 											     *
*  program by:		  Edward J. Boon						     *
* 											     *
*  module: mkutil.asm --   often used utilites					     *
* 											     *
*  copyright (c) 1994 midway manufacturing							*
*											     *
**************************************************************************
 	.file	'mkutil.asm'
	.title	" <<< utilities >>> "

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
	.include	diagaudn.asm

	.even
	.text

	.ref	get_aud,store_audit


sonya_zap_pal
	movi	SBENG1A,a0
	move	*a0(16*7),a0,1
	move	*a8(oflags2),a14,w
	btst	b_ugly_pal,a14
	jreq	szp3
	movi	sbENG2_p,a0
szp3	calla	player_swpal
	rets

sbENG2_p:
   .word   64 
   .word   0001fh,0794bh,06109h,0514bh,07dd2h,05caah,074edh,06d90h
   .word   02c24h,07eb8h,04868h,060edh,07df5h,068efh,0252fh,06d11h
   .word   04c6bh,06cf3h,07176h,07e3ah,03409h,065d6h,06e38h,0486eh
   .word   050b0h,058f2h,076bbh,05491h,06515h,07599h,0727ah,06e59h
   .word   05c73h,054d2h,061b6h,05d75h,069d8h,0721ah,070f9h,059b5h
   .word   06a19h,04c73h,03cefh,04531h,07edfh,07f3fh,0286bh,02049h
   .word   02c4dh,059b9h,03892h,0529ah,03df7h,04e7ch,0463bh,03198h
   .word   04a59h,04638h,0210fh,03192h,02950h,07a0fh,02110h,07fffh



advance_him
	mmtm	sp,a8,a9,a13
	move	*a13(p_otherproc),a13,l
	move	a11,a9				; input a11 = animation table
	move	a10,a8
	calla	do_next_a9_frame
	move	a9,a11
	mmfm	sp,a8,a9,a13
	rets


bogus_dlist
	movi	dlists_bogus,a0
	move	a0,@dlists,l
	rets

**************************************************************************
*											     *
*  back_to_normal - player characters call this routine to clear any     *
*                   funky states or flags to get normal again		     *
* 											     *
*   1 - i can now be flipped								     *
*   2 - dont ignore my block button							     *
*   3 - rid of slave objects								     *
*											     *
**************************************************************************
back_to_normal
	movb	*a13(p_hit),a5
	cmpi	2,a5
	jrlt	btn3

	movi	>0d,a0
	calla	create_fx			; combo message
	move	a5,*a0(pa11),l			; pass # of hits
	move	*a13(p_damage),a1,w
	movi	full_strength,a7
	sll	16,a1
	divs	a7,a1
	movi	>64,a3
	mpys	a3,a1				; cross multiplication
	srl	16,a1				; a1 = % damage
	move	a1,*a0(pa10),l			; pass % of damage this combo did

btn3	clr	a0
	movb	a0,*a13(p_hit)			; hit count = 0
	movb	a0,*a13(p_block) 		; block count = 0
	movb	a0,*a13(p_power) 		; power = 0
	move	a0,*a13(p_damage),w		; reset combo damage
	move	a0,*a13(p_action),w		; sans action
	move	a0,*a13(p_stk),w		; I am no longer striking !!

	calla	ochar_bank_bit
	calla	player_normpal
	callr	delete_slave
	move	*a8(oflags2),a4,w
	andni	m_noflip|m_noblock|m_nocol|m_noedge|m_half_damage,a4

	btst	b_inviso,a4			; inviso ?
	jrne	btn5				; yes, dont set shadow
	ori	m_shadow,a4			; no, set shadow !
btn5	move	a4,*a8(oflags2),w

	move	*a8(oflags),a4,w
	andni	m_flipv,a4
	move	a4,*a8(oflags),w

	move	*a13(p_flags),a4,w
	andni	pm_special,a4		; flag: i am not doing a special move
	andni	pm_reacting,a4	  	; flag: i am not reacting to an attack
	andni	pm_sitduck,a4
	andni	pm_finish,a4
	move	a4,*a13(p_flags),w
	rets

*
* a14 = amount to add to his damage
*
zero_my_p_hit
	push	a0
	clr	a0
	movb	a0,*a13(p_hit)
	pull	a0
	rets



set_game_state
	move	@gstate,a1,w
	cmpi	gs_amode,a1
	jreq	sgs9			; amode = dont change game state
	move	a0,@gstate,w		; game state
sgs9	rets


add_combo_damage
	mmtm	sp,a0,a1
	move	*a13(p_otherproc),a0,l
	move	*a0(p_damage),a1,w
	add	a14,a1
	move	a1,*a0(p_damage),w	; add to the damage count...
	jruc	dmrets

dec_my_p_hit
	mmtm	sp,a0,a1
	move	a13,a0
	jruc	decp3

dec_his_p_hit
	mmtm	sp,a0,a1
	move	*a13(p_otherproc),a0,l
decp3	movb	*a0(p_hit),a1
	jreq	dmrets			; no negative allowed
	dec	a1
	movb	a1,*a0(p_hit)		; count this as a hit
	jruc	dmrets

inc_his_p_hit
	mmtm	sp,a0,a1
	move	*a13(p_otherproc),a0,l
	movb	*a0(p_hit),a1
	inc	a1
	movb	a1,*a0(p_hit)		; count this as a hit
dmrets	mmfm	sp,a0,a1
	rets

;*******************************************************************

audit_event_check
	calla	aud1			; bumb audit counter
	calla	get_aud			; a1 = current audit value
	cmp	a2,a1
	jrlo	aec_no

	clr	a1			; clear the audit
	calla	store_audit		; store zero
	setc
	rets

aec_no	clrc
	rets

*******************************************************************
*
* a0 = range
* a1 = minimum
*
randu_minimum
	calla	randu
	dec	a0
	add	a1,a0
	rets


lineup_on_a9
	callr	new_scroll_init
	create	pid_scroll,scroll_a9		; make new one
	rets

center_around_me
	callr	new_scroll_init
	create	pid_scroll,scroll_center	; make new one
	rets

new_scroll_init
	movi	pid_scroll,a0
	callr	dallprc				; kill old scroller
	movi	pid_shaker,a0
	callr	dallprc
	clr	a0
	move	a0,@worldtly,l
	rets

;*******************************************************************

start_shadows
	movk	1,a0
	move	a0,@f_shadows,w		; flag: do shadows
	move	@p1_obj,a0,l
	callr	ss3
	move	@p2_obj,a0,l
ss3	move	*a0(oflags2),a1,w
	ori	m_shadow,a1		; set the shadow bit
	move	a1,*a0(oflags2),w
	rets

**************************************************************************
*											     *
*  get_his_action - get other players current p_action			     *
* 											     *
*  returns: a1 = it									     *
*											     *
**************************************************************************
get_his_action
	move	*a13(p_otherproc),a0,l
	move	*a0(p_action),a1,w		; a1 = his action
	rets

**************************************************************************
*											     *
*  get_my_height - Returns how tall I am in A1					     *
*											     *
**************************************************************************
get_my_height
	calla	highest_mpart
	move	@ground_y,a1,w
	sub	a0,a1
	rets


half_x_vel
	movi	p1_xvel,a1,l
	move	@p1_obj,a2,l
	cmp	a2,a8
	jreq	sxv4			; one of the players ---> zero p?_xvel

	movi	p2_xvel,a1,l
	move	@p2_obj,a2,l
	cmp	a2,a8
	jreq	sxv4			; one of the players ---> zero p?_xvel

	move	*a8(oxvel),a0,l
	sra	1,a0
	move	a0,*a8(oxvel),l
	rets

sxv4	move	*a1,a0,l
	sra	1,a0
	move	a0,*a1,l		; make the request !!
	rets

**************************************************************************
*											     *
*  screen_half_a0 - Picks a negative or positive A0 based on		     *
* 											     *
*  a8 = left half of screen = negative / a8 = right half of screen = pos *
*											     *
**************************************************************************
screen_half_a0
	move	@worldtlx+16,a2,w
	addi	scrrgt/2,a2
	move	*a8(oxpos),a1,w
	move	*a8(osizex),a4,w
	srl	1,a4
	add	a4,a1			; a1 = middle of object
	cmp	a2,a1
	jrgt	sha0
	neg	a0
sha0	rets

inc_a0_word
	move	*a0,a1,w
	inc	a1
	move	a1,*a0,w
	rets

no_edge_both_players
	push	a8
	move	@p1_obj,a8,l
	callr	set_noedge
	move	@p2_obj,a8,l
	jruc	hise9

set_his_noedge
	push	a8
	move	*a13(p_otherguy),a8,l
hise9	callr	set_noedge
	pull	a8
	rets

set_half_damage
	move	*a8(oflags2),a14,w
	ori	m_half_damage,a14
	jruc	stuff_oflags2_a14

set_noedge
	move	*a8(oflags2),a14,w
	ori	m_noedge,a14
	jruc	stuff_oflags2_a14

clear_bank_bit
	move	*a8(oflags2),a14,w
	andni	m_bank1,a14     		; bank 0 ---> clear it
	jruc	stuff_oflags2_a14

set_bank_bit
	move	*a8(oflags2),a14,w
	ori	m_bank1,a14
	jruc	stuff_oflags2_a14

set_no_block
	move	*a8(oflags2),a14,w
	ori	m_noblock,a14
	jruc	stuff_oflags2_a14

set_shadow_bit
	move	*a8(oflags2),a14,w
	ori	m_shadow,a14
	jruc	stuff_oflags2_a14

clear_shadow_bit
	move	*a8(oflags2),a14,w
	andni	m_shadow,a14
	jruc	stuff_oflags2_a14

set_noflip
	move	*a8(oflags2),a14,w
	ori	m_noflip,a14
	jruc	stuff_oflags2_a14

clear_half_damage
	move	*a8(oflags2),a14,w
	andni	m_half_damage,a14
	jruc	stuff_oflags2_a14

clear_noflip
	move	*a8(oflags2),a4,w
	andni	m_noflip,a4
	move	a4,*a8(oflags2),w	; I can't be flipped
	rets

set_dmawnz
	move	*a8(oflags),a14,w
	andi	>fff0,a14 		; stip off dma commands
	ori	dmawnz,a14		; set "constant on non-zero"
	move	a14,*a8(oflags),w	
	rets

set_dmacnz
	move	*a8(oflags),a14,w
	andi	>fff0,a14 		; stip off dma commands
	ori	dmacnz,a14		; set "constant on non-zero"
	move	a14,*a8(oflags),w	
	rets

set_noscroll
	move	*a8(oflags2),a14,w
	ori	m_noscroll,a14
	jruc	stuff_oflags2_a14

set_inviso
	callr	clear_shadow_bit
	move	*a8(oflags2),a14,w
	ori	m_inviso,a14
	jruc	stuff_oflags2_a14

clear_inviso
	move	*a8(oflags2),a14,w
	andni	m_inviso,a14
	jruc	stuff_oflags2_a14



slave_viso
	movi	clear_inviso,a14
	jruc	inviso_call

slave_inviso
	movi	set_inviso,a14
;	jauc	inviso_call


inviso_call
	push	a8
	move	*a13(p_slave),a8,l
	call	a14
	pull	a8
	rets

clear_nocol
	move	*a8(oflags2),a14,w
	andni	m_nocol,a14
	jruc	stuff_oflags2_a14

set_nocol
	move	*a8(oflags2),a14,w
	ori	m_nocol,a14
	jruc	stuff_oflags2_a14

set_ignore_y
	move	*a8(oflags2),a14,w
	ori	m_ignore_y,a14
	jruc	stuff_oflags2_a14

clear_ignore_y
	move	*a8(oflags2),a14,w
	andni	m_ignore_y,a14
	jruc	stuff_oflags2_a14

clear_noscroll
	move	*a8(oflags2),a14,w
	andni	m_noscroll,a14

stuff_oflags2_a14
	move	a14,*a8(oflags2),w	; screen coordinates
	rets


olist_noscroll
	push	a8
oln7	move	*a0,a8,l
	jreq	olns9
	callr	set_noscroll		; sky dont scroll
	move	a8,a0
	jruc	oln7
olns9	pull	a8
	rets

**************************************************************************
*											     *
*  wait_for_start - fighters wait here for the fight to start !!!	     *
*											     *
**************************************************************************
wait_for_start
	calla	stance_setup		; get stance ani / ani speed

wfs4	sleep	1
	calla	next_anirate
	move	@f_start,a0,w 		; start fighting ??
	jreq	wfs4	      		; no ---> loop
	retp

**************************************************************************
*											     *
*  wait_for_landing - wait for him 2 land						     *
*											     *
**************************************************************************
wait_for_landing
	sleep	1

	calla	get_his_action
	cmpi	act_frozen,a1
	jreq	wfl_abort

	calla	is_he_airborn
	jrc	wait_for_landing

wfl_abort
	retp


wait_for_his_dog
	sleep	1
	calla	get_his_dog
	cmp	a10,a0
	jrhi	wait_for_his_dog
	retp

closest_edge_a5
	callr	get_my_dfe
	cmp	a6,a5
	jrlo	cled3
	move	a6,a5		; a6 = smaller
cled3	rets

**************************************************************************
*											     *
*  get_his_dfe - get his distance from each edge of the universe	     *
* 											     *
*  returns: a5 = distance from left edge						     *
*           a6 = distance from right edge						     *
*											     *
**************************************************************************
get_my_dfe
	move	*a8(oxpos),a3,w
	jruc	gdfe4

get_his_dfe
	move	*a13(p_otherguy),a0,l
	move	*a0(oxpos),a3,w		; a3 = his x

gdfe4	move	@left_edge,a5,w
	sub	a3,a5
	abs	a5			; a5 = distance from left

	move	@right_edge,a6,w
	addi	scrrgt,a6		; shift to right edge of screen
	sub	a3,a6
	abs	a6			; a6 = distance from right
	rets


no_edge_limits
	movi	->500,a0
	move	a0,@left_edge,w
	neg	a0
	move	a0,@right_edge,w	; clear the edge limits
	rets

edge_pick_a0
	push	a0
	callr	get_my_dfe
	pull	a0
	cmp	a5,a6
	jrhi	epic3
	neg	a0
epic3	rets

**************************************************************************
*											     *
*  get_his_dfeos - get his distance from the edge of the screen	     *
* 											     *
*  returns: a5 = distance from left edge						     *
*           a6 = distance from right edge						     *
*											     *
**************************************************************************
get_my_dfeos
	move	*a8(oxpos),a3,w
	jruc	gdfeos4

get_his_dfeos
	move	*a13(p_otherguy),a3,l
	move	*a3(oxpos),a3,w

gdfeos4	move	@worldtlx+16,a5,w
	move	a5,a6
	addi	scrrgt,a6

	sub	a3,a5
	sub	a3,a6
	abs	a5
	abs	a6
	rets

**************************************************************************
*											     *
*  is_he_blocking - answers the question: is the other dude trying to    *
*                   block this punch ?						     *
* 											     *
*           carry set = yes        carry clear = no				     *
* 											     *
*  b1 = duck flag									     *
*											     *
**************************************************************************
is_he_blocking
	clr	b1			; assume "sans blocking"

	move	@f_sans_block,a0,w
	jrne	q_no			; no blocking allowed

	callr	is_he_joy		; other dude a joy ?
	jrc	ihb1			; yes
*
* other dude is a drone
*
	move	*a0(p_action),a1,w
	cmpi	act_blockhi,a1		; he blocking ?
	jreq	ihby			; yes
	cmpi	act_blocklo,a1		; duck blocking ?
	jreq	ihby_duck		; yes
	jruc	ihbn
*
* other dude = joystick controlled
*
ihb1	callr	is_he_airborn
	jrc	ihbn			; can't block while airborn

	move	*a13(p_otherguy),a0,l
	move	*a0(oflags2),a0,w
	btst	b_noblock,a0		; is he in a "no block" situation
	jrne	ihbn			; yes = button or no button yer screwed

	push	a13
	move	*a13(p_otherproc),a13,l
	calla	check_block_bit
	pull	a13
	jrc	ihb2			; button pressed ---> blocked

ihbn	clrc
	rets

*
* block = yes
*
ihb2	move	*a13(p_otherproc),a10,l
	move	*a10(p_joyport),a0,l
	move	*a0,a0,l
	not	a0
	btst	bit_jdown,a0
	jreq	ihb3
ihby_duck
	movk	1,b1			; he's ducking ---> flag it !!
ihby	setc
	rets
*
* standing up block
*
ihb3	btst	1,a5			; does this require "duck" block ?
	jrne	ihbn			; yes ---> no block
	setc
	rets

**************************************************************************
*											     *
*  is_he_airborn - answers the question with a carry				     *
*											     *
**************************************************************************
is_he_airborn
	move	*a13(p_otherguy),a0,l
	move	*a13(p_otherproc),a1,l
	move	*a1(p_ganiy),a1,w	; a1 = grounded ani y

aborn4	move	*a0(oyvel),a3,l
	jrne	iha_yes			; moving y ---> yes

	move	*a0(oypos),a2,w		; a2 = current y
	cmp	a2,a1
	jrne	iha_yes			; not grounded = airborn
	clrc
	rets

iha_yes	setc
	rets

**************************************************************************
*											     *
*  am_i_airborn - answers the question with a carry				     *
*											     *
**************************************************************************
am_i_airborn
	move	a8,a0
	move	*a13(p_ganiy),a1,w	; a1 = grounded ani y
	jruc	aborn4


**************************************************************************
*											     *
*  is_he_joy - answers the question with a carry				     *
* 											     *
*  returns: a0 = other dudes proc							     *
*											     *
**************************************************************************
is_he_joy
	move	*a13(p_otherproc),a0,l
	move	*a0(p_flags),a4,w
	btst	pb_joy,a4			; joy dude ?
	jrne	ihjy				; yes
	clrc					; nope
	rets
ihjy	setc
	rets

**************************************************************************
*											     *
*  am_i_joy - answers the question with a carry					     *
*											     *
**************************************************************************
am_i_joy
	move	*a13(p_flags),a4,w
	btst	pb_joy,a4			; joy dude ?
	jrne	ihjy				; yes
	clrc					; nope
	rets

**************************************************************************
*											     *
*  am_i_facing_him - answers the question with a carry			     *
* 											     *
*  carry set ---> yes									     *
*											     *
**************************************************************************
am_i_facing_him
	clr	a6				; assume: no flip needed
	calla	is_he_right			; to the right of me ?
	jrc	aif4
	movi	m_fliph,a6
aif4	move	*a8(oflags),a4,w
	andi	m_fliph,a4			; a4 = flip state
	cmp	a4,a6				; are we correct ?
	jreq	aify
	clrc
	rets
aify	setc
	rets

is_he_facing_me
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	calla	am_i_facing_him
	mmfm	sp,a8,a13
	rets


**************************************************************************
*											     *
*  is_he_helpless - checks if the otherguy is in the air and reacting to *
*                   a collision. if so, carry set				     *
*											     *
**************************************************************************
is_he_helpless
	calla	is_he_airborn
	jrnc	ihh9			; on ground ---> he isn't helpless

	move	*a13(p_otherproc),a0,l
	move	*a0(p_flags),a0,w
	btst	pb_reacting,a0		; is he reacting to another hit ?
	jreq	ihh9			; no, he is jumping

	setc
	rets

ihh9	clrc
	rets


am_i_short
	calla	get_my_height		; a1 = my height
;	cmpi	>60,a1
;	cmpi	>64,a1
	cmpi	>67,a1			; cuz jax = >66
	jrhi	ais_no
	setc
	rets
ais_no	clrc
	rets


is_he_short
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	callr	am_i_short
	jruc	him_rets


is_he_close_to_edge
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	callr	am_i_close_to_edge
	mmfm	sp,a8,a13
	rets

am_i_close_to_edge
	calla	get_my_dfe		; a5 - a6 edge distances
	calla	is_he_right
	jrc	bsep5
	move	a6,a5
bsep5	movi	>40000,a0		; faster stumble for punched escape
	cmpi	close_to_edge,a5 	; enough room behind me ??
	jrlo	aicy
	clrc
	rets
aicy	setc
	rets




sync_wait_dma_q
	move	@tick,a0,w
vss2	move	@tick,a1,w
	cmp	a0,a1
	jreq	vss2
*
* a1 = current tick
*
swd7	move	b13,b13
	jreq	swd9
	move	@tick,a0,w
	cmp	a0,a1			; still in same interupt ?
	jreq	swd7			; yes, keep waiting
swd9	rets


freeze_2_pages
	movk	1,a0
	move	a0,@f_novel,l
	clr	a0
	move	a0,@scrolly,l
	calla	stop_scrolling		; no scrolling !!
	sleep	2
	clr	a0
	move	a0,@f_auto_erase,w
	sleep	2			; time 4 both pages to show same thing
	calla	display_off
	calla	sync_wait_dma_q		; let dma q empty out
	calla	grab_screen
	retp

**************************************************************************
*											     *
*  page_0_setup - set things up for a static (sans object) plot to	     *
*                 page zero. by doing the following:				     *
* 											     *
*  1. turn display off									     *
*  2. turn off autoerase									     *
*  3. look at page 0									     *
*  4. plot to page 0									     *
*											     *
**************************************************************************
page_0_setup
	calla	oinit			; clear objects !
	callr	dont_show_scores

page_0_setup_no_init
	clr	a0
	move	a0,@displayon,w
	move	a0,@f_auto_erase,w
	not	a0
	move	a0,@noflip,w	   	; take control of page flipping !!
	callr	view_page_0
	movi	page0adr+xpadding,a1	; plot to page 0
	move	a1,@pageaddr,l		; plot to page 0
	movi	[253,0],a0
	move	a0,@dmatplft,l 		; set dma window to page 0
	rets


view_page_1
	movi	dpystrt1,a0
	jruc	view2

view_page_0
	movi	dpystrt0,a0
view2	move	a0,@dpystrt,w		; look at page 0
	rets

**************************************************************************
*											     *
*  reset_proc_stack - reset the proc stack pointer a12 to its initial    *
*                     spot.								     *
*											     *
**************************************************************************
reset_proc_stack
	move	a13,a12
	addi	prcsiz,a12
	rets

**************************************************************************
*											     *
*  clear_p_ram - Clear a proc's (a0) "p" ram					     *
*											     *
**************************************************************************
clear_p_ram
	mmtm	sp,a0,a1,a2
	clr 	a1
	move	a0,a2
	addi	pdata,a0		; a0 --> pdata area
	addi	p_end,a2		; a2 --> end of pdata area

cpr4	movb	a1,*a0
	addk	8,a0
	cmp	a0,a2
	jrhs	cpr4

	mmfm	sp,a0,a1,a2
	rets

**************************************************************************
*											     *
*  double_compare - double compare command. if either a0 or a1 = a2	     *
*               	   then we return equal, else ne 				     *
*											     *
**************************************************************************
double_compare
	cmp	a0,a2
	jreq	dc_yes
	cmp	a1,a2
dc_yes	rets

**************************************************************************
*											     *
*  make_solid_object - create a solid color object given			     *
* 											     *
*  input: a0 = constant color to use							     *
*         a3 = y:x size of object	 						     *
*											     *
**************************************************************************
make_solid_object
	mmtm	sp,a0,a3
	movi	solid_object_img,a5
	calla	get_single_obj		; single object needed here

	move	*a8(oflags),a4,w
	andni	m_wrnonz,a4
	move	a4,*a8(oflags),w	; we dont want "write non-zero" set
	mmfm	sp,a0,a3

	move	a0,*a8(oconst),w 	; set color
	move	a3,*a8(osize),l	 	; set size
	rets

solid_object_img
	.word   10,10,0,0
	.long   >2000000
	.word   dmacal|>1000		; 1 bit per pixel
	.long   boonpal

**************************************************************************
*											     *
*  set_xy_coordinates - set an object exactly on a certain point	     *
* 											     *
*  input: a4 = y:x coordinate								     *
*         a8 = object									     *
*											     *
**************************************************************************
set_xy_coordinates
	move	a4,a14
	sra	16,a4
	move	a4,*a8(oypos),w
	sll	16,a14
	sra	16,a14
	move	a14,*a8(oxpos),w
	rets

**************************************************************************
*											     *
*  center_obj_x - center an object (a8) in the middle of the screen	     *
*											     *
**************************************************************************
center_obj_x
	movi	scrrgt/2,a0

center_about_x
	move	*a8(osizex),a1,w
	srl	1,a1			; 1/2 x size
	sub	a1,a0
	move	a0,*a8(oxpos),w		; set centered x
	rets

**************************************************************************
*											     *
*  display_on/off - put a "1/0" in displayon  					     *
*											     *
**************************************************************************
display_off
	clr	a0
	jruc	disp3

display_on
	movk	1,a0
disp3	move	a0,@displayon,w
	rets

**************************************************************************
*											     *
*  killfx - kill all fx procs and objects						     *
*											     *
**************************************************************************
killfx
	movi	oid_fx,a0
	calla	dallobj
	movi	pid_fx,a0
	jruc	dallprc



unimmune_mpp
	move	@active,a0,l
binit5	move	*a0(procid),a1,w
	zext	a1,w
	andni	>8000,a1
	cmpi	pid_mpo,a1    			; multi part object ??
	jrne	binit6				; no, skip
	calla	unimmune_a0   	 		; yes, back 2 normal
binit6	move	*a0(plink),a0,l
	jrne	binit5
	rets

immune_mpp
	move	@active,a0,l
binit3	move	*a0(procid),a1,w
	cmpi	pid_mpo,a1    		; multi part object ??
	jrne	binit4			; no, skip
	calla	immune_a0    		; yes, protect it..(its gonna linger)
binit4	move	*a0(plink),a0,l
	jrne	binit3
	rets

**************************************************************************
*											     *
*  immune_a0 - Make a proc (a0) unkillable						     *
*											     *
**************************************************************************
immune_a0
	move	*a0(procid),a1,w
	ori	>8000,a1	
	move	a1,*a0(procid),w		; dont kill other guys proc
	rets

unimmune_a0
	move	*a0(procid),a1,w
	andni	>8000,a1	
	move	a1,*a0(procid),w	; other proc ---> back 2 normal id
	rets

**************************************************************************
*											     *
*  damage_to_him - routine to cause damage to other player		     *
* 											     *
*  input: a0 = damage to inflict								     *
*											     *
**************************************************************************
damage_to_him
	mmtm	sp,a8,a10
	move	a0,a10
	move	*a13(p_otherguy),a8,l
	clr	b0
	callr	damage_to_me
	mmfm	sp,a8,a10
	rets


**************************************************************************
*											     *
*  damage_to_me - dudes call this routine to give awards to the other    *
*                 player.								     *
* 											     *
*  input: b0 = score value (coded)							     *
*         a8 = me 										*
*        a10 = damage value								     *
*											     *
**************************************************************************
damage_to_me
	clr	a6
	movk	1,a1
	move	@p1_obj,a7,l
	cmp	a7,a8
	jreq	gett5
     	movk	1,a6
	clr	a1
gett5	jauc	bar_reducer


**************************************************************************
*												*
*  exobj_er											*
*												*
*  finds an object, if it does not exist then it errors.				*
*												*
*  input: a0 = object id 									*
*												*
**************************************************************************
exobj_er
	push	a1
	clr	a1
	not	a1
	calla	existobj		; anybody home ?
	jrne	eobjex
	ermac	3
eobjex	pull	a1
	rets

**************************************************************************
*												*
*  exprc_er											*
*												*
*  finds a process, if it does not exist then it errors.				*
*												*
*  input: a0 = process id									*
*												*
**************************************************************************
exprc_er
	push	a1
	clr	a1
	not	a1
	calla	existp			 ; anybody home ?
	jrne	eobjex
	ermac	4
eprcex	pull	a1
	rets


show_scores
	movk	1,a0
	jruc	ds3

dont_show_scores
	clr	a0
ds3	move	a0,@f_doscore,w		; dont display score
	rets

**************************************************************************
*											     *
*  get_single_obj - Get a single (non-multipart) object			     *
* 											     *
*  Input: a5 = OIMG to get info from								*
*											     *
**************************************************************************
get_single_obj
	push	a7
	movk	1,a7				; flag: get a palette for object
	callr	object_setup
gso3	pull	a7
	move	a5,*a8(oimg),l
	move	*a5(isag),*a8(osag),l	; pass sag
	move	*a5(isize),*a8(osize),l	; pass size
	rets

get_single_obj_np
	push	a7
	clr	a7				; np = no palette
	callr	object_setup
	jruc	gso3

*
* set bits: dmawnz + m_noscroll
*
gso_dmawnz_ns_coor
	push	a4
	callr	gso_dmawnz
	pull	a4
	callr	set_xy_coordinates
	jruc	set_noscroll

gso_dmawnz_coor
	push	a4
	callr	gso_dmawnz
	pull	a4
	jruc	set_xy_coordinates

gso_dmawnz_ns
	callr	gso_dmawnz
	jruc	set_noscroll

gso_dmawnz
	callr	get_single_obj
	jruc	set_dmawnz

gso_dmawnz_np
	callr	get_single_obj_np
	jruc	set_dmawnz

gso_dmacnz
	callr	get_single_obj
	jruc	set_dmacnz


gbo_dmawnz
	calla	getobj
	jrne	gbo3
	ermac	5	       		; error #8 - no objects left
gbo3  	move	a0,a8			; a8 = the obj

	move	*a5(icmap),a0,l		; a0 = multipart palette
	cmpi	rom,a0			; is there a palette with this image ?
	jrhi	gbo6			; yes, use it
	move	a6,a0			; no, use the one supplied to us
gbo6	calla	getbpal
	move	a0,*a8(opal),w
	clr	a0
	move	a0,*a8(ozval),l    	; initial z
	move	*a5(icontrol),a4,w
	ori	dmago,a4
	move	a4,*a8(oflags),w
	move	a5,*a8(oimg),l
	move	*a5(isag),*a8(osag),l	; pass sag
	move	*a5(isize),*a8(osize),l	; pass size
	jruc	set_dmawnz

**************************************************************************
*											     *
*  gmo_proc - Get multipart object using a process for the multipart ram *
* 											     *
*  Input: a9 = frame with all the info						     *
* 											     *
*  Returns: a0 = dummy process created						     *
*											     *
**************************************************************************
gmo_proc
	movi	multi_dummy_proc,a7
	movi	pid_mpo,a1
	calla	getprc	   	; grab a process for ram

	movi	>1000,a6
	move	a6,*a0(ptime),w	; sans wakeup

	push	a0
	move	a0,a6
	addi	pdata,a6   	; a6 = multipart ram starts here !!
	move	*a9,a5,l   	; a5 = frame #1
	movk	1,a7		; a7 = palette flag
	callr	get_multi_obj
	pull	a0

	rets

**************************************************************************
*											     *
*  kmo_proc - Kill multipart object / process					     *
* 											     *
*  Input: a2 = object in question							     *
*											     *
**************************************************************************
kmo_proc
	move	*a2(oslink),a0,l	; proc
	move	*a0(pwake),a1,l
	cmpi	multi_dummy_wake,a1	; still a dummy proc ?
	jrne	kmop3			; no
	calla	kill			; yes, kill proc
kmop3	move	a2,a0
	jauc	delobjp			; kill obj


multi_dummy_proc
	sleep	>1000
multi_dummy_wake
	jruc	multi_dummy_proc

**************************************************************************

world_a5
	mmtm	sp,a0,a1,a2,a3
	move	*a5(oxpos),a0,w
	move	*a5(oypos),a1,w

	move	@worldtlx+16,a2,w
	move	@worldtly+16,a3,w
	add	a2,a0
	add	a3,a1
	move	a0,*a5(oxpos),w
	move	a1,*a5(oypos),w
	jruc	wld9

screen_a5
	mmtm	sp,a0,a1,a2,a3
	move	*a5(oxpos),a0,w
	move	*a5(oypos),a1,w

	move	@worldtlx+16,a2,w
	move	@worldtly+16,a3,w
	sub	a2,a0
	sub	a3,a1
	move	a0,*a5(oxpos),w
	move	a1,*a5(oypos),w

wld9	mmfm	sp,a0,a1,a2,a3
	rets


get_screen_coordinates
	mmtm	sp,a2,a3
	move	*a5(oxpos),a0,w
	move	*a5(oypos),a1,w
	move	@worldtlx+16,a2,w
	move	@worldtly+16,a3,w
	sub	a2,a0
	sub	a3,a1
	mmfm	sp,a2,a3
	rets

**************************************************************************
*											     *
*  get_multi_obj - Get a multipart object						     *
* 											     *
*  Input: a5 = frame #1									     *
*         a6 = multipart ram									*
*         a7 = "should I get a palette" flag						*
*											     *
**************************************************************************
get_multi_obj
	push	a5
	move	*a5,a5,l
	callr	object_setup

	move	*a5(icontrol),a4,w
	ori	dmawnz,a4
	move	a4,*a8(oflags),w

	move	*a8(oflags2),a4,w
	ori	m_multipart,a4
	move	a4,*a8(oflags2),w	; set the multipart bit

	move	a6,*a8(oimg),l		; multipart ram
	pull	a0
	jruc	ani2			; object shape = frame #1

*
* Input: a7 = get a palette flag (0=no ; 1=yes)
*
object_setup
	calla	getobj
	jrne	gobj3
	ermac	5	       		; error #8 - no objects left
gobj3  	move	a0,a8			; a8 = the obj
	move	a7,a7			; get a palette ?
	jreq	gobj8			; no....

	move	*a5(icmap),a0,l		; a0 = multipart palette
	cmpi	rom,a0			; is there a palette with this image ?
	jrhi	gobj6			; yes, use it
	move	a6,a0			; no, use the one supplied to us
gobj6	calla	getfpal
	jrne	gobj7
     	move	a0,a0
gobj7	move	a0,*a8(opal),w

gobj8	clr	a0
	move	a0,*a8(ozval),l    	; initial z
	move	*a5(icontrol),a4,w
	ori	dmago,a4
	move	a4,*a8(oflags),w
	rets

**************************************************************************
*											     *
*  get_char_long - get a characters longword entry from a table  	     *
* 											     *
*  input: a0 = table of entries (longwords)					     *
*											     *
**************************************************************************
get_char_long
	move	a0,a1
	move	*a8(ochar),a0,w
	sll	5,a0
	add	a1,a0
	move	*a0,a0,l
	rets

**************************************************************************
*											     *
*  ochar_call - character specific routine caller				     *
* 											     *
*  input: a0 = table of routines for each character				     *
*											     *
**************************************************************************
ochar_call
	callr	get_char_long
	jreq	chc4			; zero = no routine to call
	jump	a0
chc4	rets

ochar_jump
	callr	get_char_long
	jump	a0

**************************************************************************
*											     *
*  get_char_word - get a characters word entry from a table 		     *
* 											     *
*  input: a0 = table of entries (words)						     *
*											     *
**************************************************************************
get_char_word
	move	*a8(ochar),a1,w
	sll	4,a1
	add	a0,a1
	move	*a1,a0,w
	rets


**************************************************************************
*											     *
*  face_opponent - make sure i am pointing at the other dude.		     *
* 											     *
*  input: a8 = object (multipart)							     *
*											     *
**************************************************************************
face_opponent
	move	*a8(oflags),a0,w
	andi	m_fliph,a0		; only interested in this bit
	movi	m_fliph,a1
	calla	is_he_right		; attacker to the right of me ??
	jrnc	face3			; no, i should be flipped
	clr	a1			; yes, i should not be flipped
face3	cmp	a1,a0			; are we cool ?
	jreq	face4
    	jauc	flip_multi		; no, correct me
face4	rets

**************************************************************************
*											     *
*  is_he_right - answers the question: is the other dude to the right 	*
*                of me ?								     	*
* 											     *
*  returns: carry set = yes								     *
*											     *
**************************************************************************
is_he_left
	callr	is_he_right
	jrnc	right_yes
	clrc
	rets

is_he_right
	move	*a13(p_otherguy),a4,l
	move	*a4(oxval),a4,l
	move	*a8(oxval),a3,l
	cmp	a3,a4
	jrgt	right_yes
	clrc
	rets

right_yes
	setc
	rets

**************************************************************************
*											     *
*  distance_from_ground										*
* 											     *
*  returns: a0 = distance								     *
*											     *
**************************************************************************
distance_from_ground
	move	@ground_y,a0,w
dfg2	move	*a8(oypos),a2,w
	sub	a2,a0
	rets

distance_off_ground
	move	*a13(p_ganiy),a0,w
	jruc	dfg2

**************************************************************************
*											     *
*  gravity_ani - gravity / animation loop routine				     *
* 											     *
*  input:  a0 = animation speed								     *
*          a1 = initial y velocity							     *
* 	  a6 = routine to call everytick (zero = no routine)		     *
*          a9 = animation table								     *
*         a10 = gravity									     *
* 											     *
*        *a13(p_ganiy) = ground level							     *
*											     *
**************************************************************************
gravity_ani
	move	*a8(oflags2),a4,w
	btst	b_multipart,a4
	jreq	gravani_single

	move	a6,*a13(p_store4),l	; save routine to call 

	move	a1,a1
	jreq	gani1			; zero yvel ---> don't stuff
	move	a1,*a8(oyvel),l		; send 'em skywards
gani1	calla	init_anirate		; setup animation speed

gani2	sleep	1

	move	*a13(p_store4),a6,l	; routine to call 
	jreq	gani3			; none ---> skip o
	push	a10
	call	a6
	pull	a10

gani3	calla	next_anirate
	move	*a8(oyvel),a0,l
	add	a10,a0
	move	a0,*a8(oyvel),l		; gravity
	jrn	gani2			; heading upwards = loop
	callr	hit_ground_yet
	jrnc	gani2

	calla	stop_me
	calla	ground_player
	clr	a0
	movb	a0,*a13(p_hit)
	retp

*
* single object version of gravity ani
*
gravani_single
	cmpi	gnull,a1
	jreq	gani5
	move	a1,*a8(oyvel),l		; send 'em skywards
gani5	cmpi	gnull,a0
	jreq	gani6
	calla	init_anirate		; setup animation speed
gani6	cmpi	gnull,a6
	jreq	gani7
	move	a6,*a13(p_store4),l	; save routine to call 
*
* single part object gravity loop
*
gani7	sleep	1
	cmpi	gnull,a9
	jreq	gani8
	calla	next_anirate

gani8	move	*a8(oyvel),a0,l
	add	a10,a0
	move	a0,*a8(oyvel),l		; single object = gravity by hand
	jrn	gani7			; heading upwards = loop

	callr	hit_ground_yet 		; well ??
	jrnc	gani7
	calla	stop_a8
	retp

hit_ground_yet
	move	*a8(oypos),a2,w
	move	*a8(osizey),a0,w
	add	a0,a2			; a2 = bottom of object
	move	*a13(p_ganiy),a0,w
	cmp	a0,a2
	jrlt	hgy5
	setc
	rets
hgy5	clrc
	rets


get_his_strength
	push	a8
	move	*a13(p_otherguy),a8,l
	callr	get_my_strength
	pull	a8
	rets

**************************************************************************
*											     *
*  get_my_strength - returns my current strength value in a0		     *
* 											     *
*  input: a8 = object in question							     *
*											     *
**************************************************************************
get_my_strength
	movi	p1_bar,a0
	move	@p1_obj,a2,l
	cmp	a2,a8			; player 1 ?
	jreq	gmst4
	movi	p2_bar,a0
gmst4	move	*a0,a0,w		; a0 = current value
	rets

**************************************************************************
*											     *
*  get_my_matchw - get my (a8) # of wins this match in a0			     *
*											     *
**************************************************************************
get_my_matchw
	move	@p1_matchw,a0,w
	move	@p1_obj,a1,l
	cmp	a1,a8
	jreq	getmmw
	move	@p2_matchw,a0,w
getmmw	move	a0,a0
	rets

get_his_matchw
	push	a8
	move	*a13(p_otherguy),a8,l
	callr	get_my_matchw
	pull	a8
	rets

get_char_ani_a11
	push	a9
	move	a11,a9
	calla	get_char_ani
	move	a9,a11
	pull	a9
	rets

**************************************************************************
*											     *
*  lineup_1pwm - Lineup a 1 part obj (a0) with a multipart obj (a1) 	*
*											     *
**************************************************************************
lineup_1pwm
	move	*a1(oxpos),*a0(oxpos),w
	move	*a1(oypos),*a0(oypos),w

	move	*a1(oflags),a5,w
	andi	m_fliph,a5		; look only at flip from multi	
	move	*a0(oflags),a4,w
	andni	m_fliph,a4		; clear flip bit from single obj
	or	a5,a4
	move	a4,*a0(oflags),w	; match flip bits
*
* adjust single part obj according to animation points
*
ani_adjust_single
	move	*a0(oimg),a1,l
	move	*a1(ianioffx),a2,w
	move	*a1(ianioffy),a3,w	; grab the animation points
	move	*a1(isize),a6,l

	btst	b_fliph,a4		; horz flip ?
	jreq	aas3			; no
	neg	a2			; yes, reverse x
	zext	a6,w			; a6 = [0,x] size
	addxy	a6,a2

aas3	btst	b_flipv,a4		; vert flip ?
	jreq	aas4
	neg	a3
aas4	move	*a0(oxpos),a1,w
	sub	a2,a1
	move	a1,*a0(oxpos),w
	move	*a0(oypos),a1,w
	sub	a3,a1
	move	a1,*a0(oypos),w
	rets

**************************************************************************
*											     *
*  sans_repell - disables the repell process					     *
*											     *
**************************************************************************
sans_repell_3
	movk	3,a7
	jruc	srep3

sans_repell
	movi	>40,a7
srep3	move	a7,@f_norepell,w	; start the count down
	rets

***************** end of multipart object routines ***********************
***************** end of multipart object routines ***********************
***************** end of multipart object routines ***********************
***************** end of multipart object routines ***********************
***************** end of multipart object routines ***********************


**************************************************************************
*											     *
*  back_to_shang_check - checks if it is time to revert back to shang    *
*                        tsung !								     *
*											     *
**************************************************************************
back_to_shang_check
	callr	am_i_shang		; everybody shang tsung tonight ?
	jrnc	btst9			; without !

	move	*a8(ochar),a0,w
	cmpi	ft_st,a0
	jreq	btst9			; I am in shang form ---> exit

	movi	l_morph,a0
	calla	get_tsl			; a1 = when I changed ?
	cmpi	>40*8,a1		; too much time passed ?
	jrlo	btst9			; no, you are ok
	pull	a0			; yes, time to revert back !!
	jauc	back_to_shang_form	; and away we go

btst9	rets


am_i_shang
	move	@p1_char,a1,w
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	ais1
	move	@p2_char,a1,w
ais1	cmpi	ft_st,a1     	; was I originally shang tsung ?
	jreq	q_yes	     	; yup
	jruc	q_no


back_to_shang_form
	movi	act_morph,a1
	calla	init_special_act

	move	a8,a0
	calla	clear_inviso

	movk	4,a0
	movi	ft_st,a1
	calla	borrow_ochar_sound	; morph sound

	movi	st_anitab2,a0
	calla	get_char_long		; get proper animation table
	move	a0,a9
	addi	32*3,a0
	move	*a0,a0,l
	move	*a0,a0,l
	move	*a0(icmap),a0,l
	calla	player_swpal		; change to morph pal

	addi	32*5,a9			; a9 ---> frame 3 of morph
	calla	set_bank_bit
*
* adjust y for the morph
*
	move	*a8(ochar),a0,w
	sll	4,a0
	addi	ochar_ground_offsets,a0
	move	*a0,a0,w		; my current ground offset
	movi	ochar_ground_offsets,a1
	move	*a1(ft_st*>10),a1,w	; shang tsung's ground offset
	sub	a1,a0
	move	*a8(oypos),a2,w
	add	a0,a2
	move	a2,*a8(oypos),w	

	jsrp	back_shang_ani
	jsrp	back_shang_ani
	jsrp	back_shang_ani		; 3 morph frames
*
* switch to shang pal
*
	movk	ft_st,a0
	move	a0,*a8(ochar),w		; define my original ochar
	calla	ochar_bank_bit
	calla	player_normpal	 	; new normal palette
	clr	a9
	calla	do_first_a9_frame			; pose: stance1		
	calla	ground_ochar				; new ground position
	move	*a8(oypos),*a13(p_ganiy),w    	; new grounded y pos
	sleep	4
	jauc	reaction_exit

back_shang_ani
	calla	do_next_a9_frame
	subi	32*2,a9			; move backwards
back9	sleep	4
	retp

*
* delete multipart slave object
*
delete_slave
	move	*a13(p_slave),a0,l	; slave object ?
	jreq	dels2			; nope...

	move	a0,a1
	move	*a1(oslink),a0,l
	calla	kill			; kill dummy proc !!

	move	a1,a0
	callr	delobjp			; delete object and palette

	clr	a0
	move	a0,*a13(p_slave),l	; clear slave lw
dels2	rets

**************************************************************************
*											     *
*  grab_screen - does the following						     	*
* 											     *
*  1. turns off autoerase								     *
*  2. zeros all object lists								     *
*  3. returns with a screwed up system (beware)					     *
*											     *
**************************************************************************
grab_screen
	clr	a0
	move	a0,@f_auto_erase,w

	clr	a0
	movi	baklst8,a1
grab3	move	a0,*a1+,l		; zero object list
	cmpi	last_objlst,a1		; all of 'em
	jrne	grab3
*
* free up objects
*
	movi	objstr,a1,l
	move	a1,@ofree,l		; setup free list
	movi	nobj,a3			; # of object blocks to init
gscr4	move	a1,a2
	addi	obsiz,a1,w
	move	a1,*a2,l		; link em up
	dsjs	a3,gscr4		; continue for nproc
	rets

set_all_worldtlx
	move	a0,@worldtlx1,l
	move	a0,@worldtlx,l
	move	a0,@worldtlx2,l
	move	a0,@worldtlx3,l
	move	a0,@worldtlx4,l
	move	a0,@worldtlx5,l
	move	a0,@worldtlx6,l
	move	a0,@worldtlx7,l
	move	a0,@worldtlx8,l
	rets

**************************************************************************
*											     *
*  murder_myoinit_score - calls murder_myoinit and then set the second   *
*                         palette to the vogel score palette		     *
*											     *
**************************************************************************
murder_myoinit_score
	callr	murder_myoinit
	calla	setup_score_ram

	movi	SCORE_P,a0
	jauc	getfpal 		; palette #2 = vogel's score palette


murder_myoinit
	calla	oinit
	calla	clear_sound_ram

;	<<<<<<<<<<<<<< fall through >>>>>>>>>>>>>>>

**************************************************************************
*												*
*  murder											*
*												*
*  kill every process except "indestuctables"						*
*												*
**************************************************************************
murder
	clr	a0
	movi	>8000,a1
	jauc	kilall				; kill all but indestructables

insobj3a8
	move	a8,a0
	jauc	insobj3

insobj2a8
	move	a8,a0
	jauc	insobj2

insobja8
	move	a8,a0
	jauc	insobj


**************************************************************************
*											     *
*  clear_ram - Clears a bank of ram given						     *
* 											     *
*  a0 = 1st location									     *
*  a1 = word count									     *
*											     *
**************************************************************************
clear_ram
	mmtm	sp,a0,a1,a2

	clr	a2
clr2	move	a2,*a0+,w	; clear one word
	dsjs	a1,clr2

	mmfm	sp,a0,a1,a2
	rets

**************************************************************************
*												*
*  unclip											*
*												*
*  unclips everything										*
*												*
**************************************************************************
unclip
	push	a0
	movi	scrnst,a0,l	; init screen top left [y,x]
	move	a0,@scrntl,l
	move	a0,@scrntl2,l
;	move	a0,@shad_scrntl,l

	movi	scrnend,a0,l	; init screen lower right [y,x]
	move	a0,@scrnlr,l
	move	a0,@scrnlr2,l
	pull	a0
	rets

totally_clip
	push	a0
	clr	a0
	move	a0,@scrntl,l
	move	a0,@scrntl2,l
;	move	a0,@shad_scrntl,l

	move	a0,@scrnlr,l
	move	a0,@scrnlr2,l
	pull	a0
	rets

**************************************************************************
*												*
*  fastxfer											*
*												*
*  like xferproc except you cannot give a new id or new a8-a11 values.	*
*												*
*  input: a0 - process to xfer									*
*   	 a7 - wakeup address									*
*												*
**************************************************************************
fastxfer
	mmtm	sp,a0,a2
	addi	ptime,a0		; a0 --> wake up timer
	movk	1,a2
	move	a2,*a0+,w		; wake up right away !!
	move	a0,a2
	addi	prcsiz-psptr,a2 	; a2 = top of process stack
	move	a2,*a0,l		; store into pointer ram
	addi	pwake-psptr,a0		; a0 --> wake up area
	move	a7,*a0,l
	mmfm	sp,a0,a2
	rets

**************************************************************************
*												*
*  waitproc (jsrp)										*
*												*
*  wait for a process to die. a10 = id of process to wait for			*
*												*
**************************************************************************
waitproc
	sleep	1
	clr	a1
	not	a1
	move	a10,a0
	calla	existp
	jrne	waitproc
	retp

**************************************************************************
*												*
*  dallobj											*
*												*
*  deletes every object with the id of a0. no masking bullshit needed	*
*  in a1.											*
*												*
**************************************************************************
dallobj
	clr	a1	
	not	a1
	jauc	kill_ocp	    ; kill with no "dont care" bits

**************************************************************************
*												*
*  dallprc											*
*												*
*  deletes every process with the id of a0. no masking bullshit needed	*
*  in a1.											*
*												*
**************************************************************************
dallprc
	clr	a1	
	not	a1
	jauc	kilall			; kill with no "dont care" bits

**************************************************************************
*											     *
*  create_and_kill - creates a process and kills any old ones with	     *
*  		  the same id								     *
* 											     *
*  input: a0 = id									     *
*         a7 = address of proc								     *
*											     *
**************************************************************************
create_and_kill
	callr	dallprc
	move	a0,a1
	jauc	getprc

create_if_gone
	clr	a1
	not	a1
	push	a0
	calla	existp
	pull	a0
	jreq	cig4  		; not there ---> create one
q_no	clrc	      		; carry clear ---> process already there
	rets

cig4	move	a0,a1
	calla	getprc
q_yes	setc	      		; carry set ---> process was created
	rets


exprc	clr	a1
	not	a1		; get this hassle out of the way
	jauc	existp

**************************************************************************
*											     *
*  move_object_list - Move a list of object list from one objlst	     *
*                     to another								     *
* 											     *
*  Input: a0 = from list									     *
*         a1 = to list									     *
*											     *
**************************************************************************
move_object_list
	mmtm	sp,a2,a14
	clr	a14
	move	*a0,a2,l		; grab "from"
	move	*a1,a3,l		; grab "to"
	jreq	mol6

mol4	move	a3,a1
	move	*a3,a3,l
	jrne	mol4			; find the end of the "to" list
*
* "to" list is empty
*
mol6	move	a14,*a0,l		; clear "from"
	move	a2,*a1,l		; tack onto "to" list
	mmfm	sp,a2,a14
	rets

**************************************************************************
*												*
*  delolist											*
*												*
*  deletes and zeros an object list. input: a2 = list to delete		*
*												*
**************************************************************************
delolist
	move	*a2,a0,l		; list empty ??
	jreq	delo9			; yes, skip
	clr	a1
	move	a1,*a2,l		; null the list
delo2	move	*a0(olink),a1,l 	; a1 = next in list
	calla	delpal			; delete the palette 1st
	move	@ofree,a2,l
	move	a2,*a0(olink),l 	; object ---> top o free list
	move	a0,@ofree,l		; objest is top o free list
	move	a1,a0			; end of list ??
	jrne	delo2			; no
delo9	rets

**************************************************************************
*												*
*  delete object and palette									*
*												*
*  delete an object from the object list and from the palette count.	*
*  use this routine for deleting objects to avoid mismatching palette	*
*  counts with # of objects.									*
*												*
*  input: a0 --> object block to delete							*
*												*
**************************************************************************
delobjp
	calla	delpal
	jauc	delobj

delobjp2
	calla	delpal
	jauc	delobj2

delobjp3
	calla	delpal
	jauc	delobj3


**************************************************************************
*											     *
*  set_oid_list - Set every object on a list to a specific id		     *
* 											     *
*  Input: a0 = object list								     *
*         a1 = oid									     *
*											     *
**************************************************************************
;set_oid_list
;	move	*a0,a0,l
;	jreq	sol3
;	move	a1,*a0(oid),w
;	jruc	set_oid_list
;sol3	rets

**************************************************************************
*											     *
*  change_oid_list - Change objects from one oid to another		     *
* 											     *
*  Input: a0 = object list								     *
*         a1 = from oid									     *
*         a2 = to oid									     *
*											     *
**************************************************************************
change_oid_list
	push	a3
col2	move	*a0,a0,l
	jreq	col3
	move	*a0(oid),a3,w
	cmp	a1,a3			; match with "from" ???
	jrne	col2			; no, skip
	move	a2,*a0(oid),w		; yes, set to new oid
	jruc	col2
col3	pull	a3
	rets


**************************************************************************
*												*
*  kill object class and palettes								*
*												*
*  kill a class of objects and delete them from the palette count they	*
*  were on.											*
*	   input: a0 = id of object								*
*		  a1 = mask bits								*
*												*
**************************************************************************
kill_ocp
	mmtm	sp,a0,a2,a3,a4,a5
	and	a1,a0		; form match
	movi	objlst,a2,l	; traverse object list #1
	callr	koc2
	movi	objlst2,a2,l	; traverse object list #2
	callr	koc2
	movi	objlst3,a2,l	; traverse object list #3
	callr	koc2
	mmfm	sp,a0,a2,a3,a4,a5
	rets

koc2	move	a2,a3		; save previous
	move	*a2,a2,l	; get next
	jreq	koc5		; zero --> we are done
	move	*a2(oid),a4,w	; get id
	and	a1,a4		; can dont care bits
	cmp	a0,a4		; match?
	jrne	koc2		; no

	push	a0
	move	*a2(opal),a0,w
	calla	freepal 	; decrement the palette count
	pull	a0
	move	*a2,*a3,l
	move	@ofree,a5,l	; delete object from list
	move	a5,*a2,l
	move	a2,@ofree,l
	move	a3,a2
	jruc	koc2		; loop til we reach the end
koc5	rets			; end reached ---> return


**************************************************************************
*												*
*  a5a6ol2											*
*												*
*  used along with getblimp, adds a list of objects onto objlst2.		*
*												*
*  input: a5 --> list of objects to add to objlst2					*
*	 a6 --> end of object list to add to objlst2				*
*												*
**************************************************************************
a5a6ol2
	move	@objlst2,a0,l
	move	a0,*a6(olink),l 	; end of menu --> objlst2
	move	a5,@objlst2,l		; objlst2 --> beginning of list
	rets

a5a6ol1
	move	@objlst,a0,l
	move	a0,*a6(olink),l 	; end of menu --> objlst
	move	a5,@objlst,l		; objlst --> beginning of list
	rets

a5a6ol3
	move	@objlst3,a0,l
	move	a0,*a6(olink),l 	; end of menu --> objlst3
	move	a5,@objlst3,l		; objlst3 --> beginning of list
	rets

**************************************************************************
*												*
*      section: palette utilities								*
*												*
**************************************************************************

**************************************************************************
*												*
*  swpal 											*
*												*
*  handy routine to switch the palette of an object. 				*
*  input: a8 = object to switch palette							*
*	 a0 = palette to switch to (in address form)				*
*												*
**************************************************************************
swpal	push	a0
	push	a0
	move	a8,a0
	calla	delpal	      		; delete old palette
	pull	a0	      		; restore new palette
	calla	getfpal       		; get it in [#,#] form
	jrne	allm5
	ermac	8
allm5	move	a0,*a8(opal),w		; store new palette "double" #'s
	pull	a0
	rets


boonpal_stuff
	movi	boonpal,a0		; assume "boonpal" is our palette
	jruc	nrgbs0

rgb_stuff
	move	*a11+,a0,l		; a0  = palette

nrgbs0	move	*a11+,a10,w		; a10 = color
	srl	8,a10			; get rid of double shit
	move	*a11+,a9,w		; a9  = sleep time (speed)

	calla	findpal 		; find the palette address
	jrne	nrgbs1			; non-zero ---> ok
	ermac	9
nrgbs1	srl	8,a0			; a0 = palette offset
	move	a0,a2
	sll	8,a2			; [palette #,0]
	or	a2,a10			; a10 = [palette,color]

nrgbs2	move	a11,a8			; a8 ---> rgb table of colors
nrgbs3	movk	1,a2			; a2 = color count
	move	a10,a1			; a1 = [palette,color]
	move	a8,a0			; a0 = source
	calla	palset
	move	a9,a0
	calla	prcslp			; tick
	addi	>10,a8			; a8 --> next rgb value in table
	move	*a8,a0,w
	sll	16,a0
	srl	16,a0
	cmpi	end_stuff,a0		; end of "rgb" table ??
	jrne	nrgbs3			; no
	jruc	nrgbs2			; yes --> reset and loop


rgbs0	move	*a11+,a0,l		; get palette
	move	*a11,a8,l		; table of "rgb" values
	move	*a11(32),a10,w		; color to mess with	
	move	*a11(32+16),a9,w	; sleep time between messings
*
* keep a11 --> rgb table
*
	calla	findpal 		; find the palette address
	jrne	rgbs1			; non-zero ---> ok
	ermac	10
rgbs1	srl	8,a0			; a0 = palette offset
	move	a0,a2
	sll	8,a2			; [palette #,0]
	or	a2,a10			; a10 = [palette,color]

rgbs2	movk	1,a2			; a2 = color count
	move	a10,a1			; a1 = [palette,color]
	move	a8,a0			; a0 = source
	calla	palset
	move	a9,a0
	calla	prcslp			; tick
	addi	>10,a8			; a8 --> next rgb value in table
	move	*a8,a0,w
	sll	16,a0
	srl	16,a0
	cmpi	end_stuff,a0		; end of "rgb" table ??
	jrne	rgbs2			; no
	move	*a11,a8,l		; yes --> back to beginning of table		
	jruc	rgbs2			; don't stop till you get enough !!!


**************************************************************************
*											     *
*  cycle_forward	 / cycle_backward								*
* 											     *
*  a10 = palette										     *
*  a11 = [a,b,c,d]	a = starting color				     	*
* 			b = # of colors to cycle				     *
* 			c = sleep time between each iteration		     *
* 			d = unused							     *
*											     *
**************************************************************************
cycle_forward
	movk	1,a0
	jruc	cyc0

cycle_backward
	clr	a0			; a0 = 0 ---> forward

cyc0	pushp	a0
	move	a11,a9			; save parameters
	move	a10,a0
	calla	findpal
	jrne	cyc1
	ermac	11			; huh ?

cyc1	srl	8,a0			; a0 = palette offset
	movi	palram,a1		; a1 = top of palette ram
	movi	palrsiz,a5
	mpys	a0,a5
	add	a5,a1			; a1 --> palette to cycle
	sll	8,a0			; in upper nibble only
	move	a0,a8			; a8 = [palette,0]

	srl	24,a11			; a11 = starting color
	add	a11,a8			; a8 = [palette,starting color]

	sll	4,a11			; one word per color
	move	*a1,a4,l		; a4 --> palette data
	addi	>10,a4			; skip "# of colors word"
	add	a11,a4			; a4 = source

	move	a13,a1
	addi	pdata,a1		; a1 = 1st copy
	
	move	a9,a10
	sll	8,a10
	srl	24,a10			; a10 = color count
	move	a10,a2
	sla	4,a2			; each color is a word
	add	a1,a2			; a2 = 2nd copy
	move	a10,a0			; a0 = color count

*	
* block move:
* a0 = count
* a4 = source
* a1 = destination 1
* a2 = destination 2
*
cyc2	move	*a4+,a7,w
	move	a7,*a1+,w		; 1st copy
	move	a7,*a2+,w		; 2nd copy
	dsjs	a0,cyc2
	sll	16,a9
	srl	24,a9			; a9 = sleep time

	movi	>10,a1			; assume forward cycle
	pullp	a0
	move	a0,a0			; forward or backward ??
	jreq	cyc5
	movi	->10,a1 		; backward color cycle
cyc5	pushp	a1			; save "movement" on process stack
*
* color cycle loop
*
cyc3	move	a10,a4			; a4 = reset counter
	move	a13,a11
	addi	pdata,a11		; a11 = beginning of pdata
	move	*a12,a0,l		; pull "movement" but keep stack same
	move	a0,a0
	jrp	cyc4			; positive movement = forward cycle
	move	a10,a0
	sll	4,a0
	add	a0,a11			; backward cycle = start at end of pdata

cyc4	move	a11,a0			; a0 = source
	move	a8,a1			; a1 = [palette,starting color]
	move	a10,a2			; a2 = count
	calla	palset			; do the transfer
	pushp	a4
	move	a9,a0
	calla	prcslp			; snooze
	pullp	a4
	move	*a12,a0,l		; pull "movement" but keep stack same
	add	a0,a11			; advance to next color
	dec	a4
	jrne	cyc4
	jruc	cyc3

**************************************************************************
*											     *
*  zero_table_o_words									     *
* 											     *
*  Input: a1 = table of pointers to words (ends with zero)		     *
*											     *
**************************************************************************
zero_table_o_words
	clr	a0
ztow3	move	*a1+,a2,l		; grab an address
	jreq	ztow9			; zero ---> end of list
	move	a0,*a2,w		; clear it
	jruc	ztow3
ztow9	rets

zero_table_o_longs
	clr	a0
ztol3	move	*a1+,a2,l		; grab an address
	jreq	ztol9			; zero ---> end of list
	move	a0,*a2,l		; clear it
	jruc	ztol3
ztol9	rets


**************************************************************************
*											     *
*  p1p2_pick - Pick either a0 or a1 based on a8(oid)			     	*
* 											     *
*  Input: a0 = [player 1 choice, player 2 choice]					*
*											     *
**************************************************************************
p1p2_pick
	move	*a8(oid),a2,w
	cmpi	oid_p2,a2
	jreq	p1p2
	srl	16,a0
p1p2	zext	a0,w
	rets

**************************************************************************
*											     *
*  get_tsl - get the amount of time (ticks) that has elapsed     		*
*            since the last time we updated this ram. (a0)	     	*
* 											     *
*  input: a0 = points to two 16 bit locations (p1-p2)			     *
*         a8 = dude who wants 2 know							     *
* 											     *
*  returns: a1 = elapsed time								     *
*											     *
**************************************************************************
get_tsl
	move	*a8(oid),a1,w
	cmpi	pid_p1,a1	; player 1 ??
	jreq	tsl4
    	addk	16,a0		; no, point to player 2's tick ram
tsl4	move	*a0,a0,w	; when was the last time we did this ?
	jreq	tsl8		; never
	move	@tick,a1,w
	sub	a0,a1		; a1 = time elapsed since last time !!
	rets

tsl8	movi	>40*30,a1	; default setting = 30 seconds ago
	rets

**************************************************************************
*											     *
*  update_tsl - stuff current value of @tick into "last time" ram	     *
* 											     *
*  input: a0 = points to two 16 bit locations (p1-p2)			     *
*         a8 = dude who wants 2 know							     *
*											     *
**************************************************************************
update_tsl
	move	*a8(oid),a1,w
	cmpi	pid_p1,a1	; player 1 ??
	jreq	usl4
    	addk	16,a0		; no, point to player 2's tick ram
usl4	move	@tick,a1,w
	move	a1,*a0,w	; update this player's ram
	rets

**************************************************************************
*												*
*	  section: unrelated utilities							*
*												*
**************************************************************************
wait_forever
	sleep	>40

wait_forever_wake
	jruc	wait_forever

**************************************************************************
*											     *
*              Controlling of the other player routines				*
*              Controlling of the other player routines				*
*              Controlling of the other player routines				*
*              Controlling of the other player routines				*
*              Controlling of the other player routines				*
*											     *
**************************************************************************
match_him_with_me_f
	push	a8
	callr	match_him_with_me
	move	*a13(p_otherguy),a8,l
	calla	flip_multi			; flip him !
	pull	a8
	rets

match_him_with_me
	move	*a13(p_otherguy),a0,l
	jauc	match_ani_points		; lineup victim with me

match_me_with_him
	mmtm	sp,a0,a8
	move	*a13(p_otherguy),a0,l
	swap	a0,a8
	calla	match_ani_points
	mmfm	sp,a0,a8
	rets

**************************************************************************
*											     *
*  shake_him_up - Shake other player by A0 where:				     *
* 											     *
*  a0 = [y pixels , x pixels]							     	*
*  a1 = sleep time between shakes								*
*  a2 = # of shakes										*
*											     *
**************************************************************************
shake_him_up
	mmtm	a12,a9,a10,a11
	pushp	a1		; push sleep time
	move	*a13(p_otherguy),*a13(p_store1),l
	jruc	shake2

shake_a8_up
	mmtm	a12,a9,a10,a11
	pushp	a1		; push sleep time
	move	a8,*a13(p_store1),l

shake2	move	a2,a11
	move	a0,a9
	move	a0,a10
	zext	a9,w		;  a9 = x pixels
	srl	16,a10		; a10 = y pixels

shake3	move	*a13(p_store1),a3,l
	move	*a3(oxpos),a0,w
	add	a9,a0
	move	a0,*a3(oxpos),w
	move	*a3(oypos),a0,w
	add	a10,a0
	move	a0,*a3(oypos),w
	move	*a12,a0,l	; borrow sleep time from proc stack
	calla	prcslp

	move	*a13(p_store1),a3,l
	move	*a3(oxpos),a0,w
	sub	a9,a0
	move	a0,*a3(oxpos),w
	move	*a3(oypos),a0,w
	sub	a10,a0
	move	a0,*a3(oypos),w
	move	*a12,a0,l	; borrow sleep time from proc stack
	calla	prcslp

	dsj	a11,shake3

	pullp	a1
	mmfm	a12,a9,a10,a11
	retp


**************************************************************************
*											     *
*  takeover_him - routine to do the chores of taking over someone.	     *
*											     *
**************************************************************************
takeover_him
	push	a7
	jruc	take3

takeover_him_sr
	push	a7
	callr	sans_repell

take3	calla	stop_him
	calla	disable_his_buttons

	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l	; put on disguise !!
	move	*a13(p_otherproc),a13,l
	clr	a0
	move	a0,*a13(p_action),w		; sans his action !!

	move	*a13(p_flags),a4,w
	ori	pm_reacting,a4
	move	a4,*a13(p_flags),w		; flag: reacting !!

	calla	player_normpal			; make sure he is using correct pal
	callr	delete_slave
	mmfm	sp,a8,a13
	pull	a7

xfer_otherguy
	move	*a13(p_otherproc),a0,l
	jauc	fastxfer


**************************************************************************
*											     *
*  stop_him - stop other guy								     *
*											     *
**************************************************************************
stop_him
	push	a8
	move	*a13(p_otherguy),a10,l
	move	a10,a8
	calla	stop_me
	pull	a8
	rets

**************************************************************************
*											     *
*  adjust_him_x - adjust the other player x coordinates			     *
* 											     *
*  input: a0 = amount to adjust								     *
*											     *
**************************************************************************
adjust_him_x
	push	a8
	move	*a13(p_otherguy),a8,l
	clr	a1			; no y adjusting needed
	jruc	adhim3

adjust_him_xy
	push	a8
	move	*a13(p_otherguy),a8,l
adhim3	calla	multi_adjust_xy
	pull	a8
	rets

adjust_him_tbl
	calla	get_his_char_long

adjust_him_a0
	move	a0,a1
	zext	a0,w
	srl	16,a1
	jauc	adjust_him_xy


get_his_dog
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	callr	distance_off_ground
	jruc	him_rets

calla_for_him
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	call	a0
	jruc	him_rets

ground_him
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	calla	ground_player
	jruc	him_rets

away_x_vel_him
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	calla	away_x_vel
	jruc	him_rets

get_his_a11_ani
	push	a9
	move	a11,a9
	calla	get_his_char_ani
	move	a9,a11
	move	*a13(p_otherguy),a10,l
	pull	a9
	rets

get_his_char_ani
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l	; pretend I am him
	calla	get_char_ani
	jruc	him_rets

get_his_char_ani2
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l	; pretend I am him
	calla	get_char_ani2
	jruc	him_rets

get_his_char_long
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l	; pretend I am him
	calla	get_char_long
	jruc	him_rets

get_his_char_word
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l	; pretend I am him
	calla	get_char_word

him_rets
	mmfm	sp,a8,a13
	rets

get_curback_mod
	move	@curback,a1,w
	sll	5,a1
	addi	table_o_mods,a1
	move	*a1,a1,l
	rets

air_dragon
	push	a8
	move	*a13(p_slave),a8,l
	movi	>28,a0
	movi	->28,a1
	jruc	drag3

lower_dragon
	push	a8
	move	*a13(p_slave),a8,l
	movi	>1d,a0
	movi	>30,a1
drag3	calla	multi_adjust_xy
	pull	a8
	rets

**************************************************************************
*											     *
*  get_rough_hypotenuse									     *
* 											     *
*  Returns a rough estimate of a hypotenuse (in a14) given		     *
* 											     *
*   a7 = x value										     *
*  a14 = y value										     *
*											     *
**************************************************************************
get_rough_hypotenuse
	abs	a7
	abs	a14
	cmp	a14,a7
	jrlo	grh5
	swap	a14,a7		; we want a7 = smaller of the 2
grh5	srl	1,a7		; a7 = 1/2 smaller
	add	a7,a14
	rets

a5_front_plus_1
	movi	front_z+1,a0
	jruc	minstuf

a5_back_minus_1
	movi	back_z-1,a0
minstuf	move	a0,*a5(ozval),l
	rets

a8_front_plus_1
	movi	front_z+1,a0
	jruc	plstuf

a8_back_minus_1
	movi	back_z-1,a0
plstuf	move	a0,*a8(ozval),l
	rets


slave_in_front
	move	*a13(p_slave),a0,l
	movi	100,a1
	move	a1,*a0(ozpos),w
	rets


get_ochar_stance1
	movi	ochar_fake_stances,a0
	jauc	get_char_long

ochar_fake_stances
	.long	f_kano
	.long	f_sonya
	.long	f_jax
	.long	f_ind
	.long	f_sz
	.long	f_swat
	.long	f_lia
	.long	f_robo1
	.long	f_robo2
	.long	f_lao
	.long	f_tusk
	.long	f_sg
	.long	f_st
	.long	f_lk
	.long	f_robo3
	.long	f_motaro
	.long	f_shao

f_kano	.long	KNSTANCE1
f_sonya	.long	SBSTANCE1
f_jax	.long	JXSTANCE1
f_ind	.long	INSTANCE1
f_sz	.long	SZSTANCE1
f_swat	.long	OBSTANCE1
f_lia	.long	LIASTANCE1
f_robo1	.long	RBSTANCE1
f_robo2	.long	RBSTANCE1
f_lao	.long	KLSTANCE1
f_tusk	.long	TRSTANCE1
f_sg	.long	SHSTANCE1
f_st	.long	TSSTANCE1
f_lk	.long	LUSTANCE1
f_robo3	.long	RBSTANCE1
f_motaro	.long	MOSTANCE1
f_shao	.long	BGSTANCE1

;***********************************************

	.end


