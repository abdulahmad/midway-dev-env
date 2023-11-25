**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mkbonus										*
* 											     *
*  copyright (c) 1994-95 Midway Manufacturing	   					*
*											     *
**************************************************************************
	.file	'mkbonus.asm'
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
	.include	stringh.asm

	.global	setup

	.text


bonus_count
	movi	gs_bonus,a0
	move	a0,@gstate,w		; game state = bonus count !!

	callr	kill_lingerings		; kill fx/dangers/etc...

	move	@p1_bar,a0,w
	move	@p2_bar,a1,w
	cmp	a0,a1
	jreq	bonus_count_draw
*
* Print the winner
*
	callr	get_winner_text		; a8 = winner text
	movi	>003800c8,a9		; a9 = centered coordinates
	jsrp	p15_centered

	movi	objlst2,a0
	movi	oid_text,a1		; from 
	movi	oid_fx,a2		; to
	calla	change_oid_list		; change oid of PLAYER WINS text
*
* speech: "Whoever Wins"
*
	callr	play_ending_chord
	sleep	>28

	movi	rsnd_sk_bonus_win,a5	; shao kahn = random speech call
	callr	get_winner_ochar	; a0 = winner ochar
	cmpi	ft_sk,a0
	jreq	bonus2
	movi	triple_sound,a5		; normal = say "???? wins"
bonus2	addi	>3d,a0
	call	a5

	move	@p1_bar,a0,w
	move	@p2_bar,a1,w
	movi	full_strength,a2
	calla	double_compare		; flawless victory ?
	jrne	bonus3			; no

	tsound	>72

;********** ejbnew
;	sleep	>10
bonus3
;	sleep	>12
	callr	wait_for_bonusv
;********** ejbnew
					; stop flashing "??? wins"
	move	@p1_state,a0,w
	move	@winner_status,a1,w
	cmpi	1,a1
	jreq	bonus4
	move	@p2_state,a0,w
bonus4	cmpi	ps_active,a0		; winner a human ?
	jrne	win6			; winner = drone ---> no bonus count
*
* flawless victory ?
*
	move	@p1_bar,a3,w
	movi	p1_perfect,a4		; a4 = winners perfect
	movi	p2_perfect,a5		; a5 = losers perfect

	move	@winner_status,a0,w
	cmpi	1,a0
	jreq	bonus5
	move	@p2_bar,a3,w		; grab winners strength bar
	movi	p2_perfect,a4		; a4 = winners perfect
	movi	p1_perfect,a5		; a5 = losers perfect

bonus5

	clr	a0
	not	a0
	move	a0,*a5,w		; loser = no chance for double perfect
	cmpi	full_strength,a3	; perfection ?
	jrne	win6			; no ---> say la vee

; ejbnew
;	sleep	>40


;	push	a4
;	movi	>4d,a0
;	pull	a4			; a4 = pointer to "flawless" ram
;	move	*a4,a0,w		; was the last round perfect too ?
;	jreq	win5			; no
;	jrn	win5			; neg = blew his chance for double !!
	jruc	win5

	movk	2,a0
	move	a0,*a4,w		; flag: double flawless !!
	movi	txt_double_flawless,a8
	jruc	win51

win5	movk	1,a0
	move	a0,*a4,w		; flag: perfect round
	movi	txt_single_flawless,a8
win51
;	sleep	>30			; dont interupt: "Xxxxx Wins" speech
	movi	>006000c8,a9
	jsrp	pds_centered
	tsound	>61			; speech: flawless victory

	callr	wait_for_bonusv

*
* fatality ?
*
win6	move	@f_death,a0,w
	jreq	bonus_exit

;	sleep	>30
	movi	oid_text,a0	
	calla	dallobj

	move	@f_final_act,a0,w
	jrne	win7
	movk	1,a0
win7	dec	a0
	sll	4,a0
	addi	fatality_animations,a0
	move	*a0,a0,w
	calla	create_fx		; fatality drip fx

;******************************** ejbnew
	sleep	2
	callr	wait_for_bonusv
;	sleep	>30
;******************************** ejbnew

bonus_exit
	move	@p1_matchw,a0,w
	move	@p2_matchw,a1,w
	movk	2,a2
	calla	double_compare		; anyone won 2 yet ?
	jreq	bonus7

	jsrp	freeze_2_pages		; look into this fade REQIREMENT (ejbpatch)
	calla	murder
	movi	>20,a10
	jsrp	fast_fadeout_jsrp

; ************************ amode display reset *************
	clr	a0
	move	a0,@f_doscore,w		; score bars = no
	calla	clr_scrn
	movk	1,a0
	move	a0,@f_auto_erase,w
	calla	murder_myoinit
	calla	clr_scrn
; ************************ amode display reset *************

l_retp	retp

bonus7
;	sleep	>50
	jruc	l_retp

bonus_count_draw
	movi	txt_tie,a8
	movi	>005800c8,a9		; a9 = centered coordinates
	jsrp	p15_centered
	sleep	>40
	jruc	bonus_exit

**************************************************************************

kill_lingerings
	movi	pid_danger1,a0
	calla	dallobj
	calla	dallprc
	movi	pid_danger2,a0
	calla	dallobj
	calla	dallprc

	movi	pid_fx,a0
	calla	dallprc
	movi	oid_fx,a0
	calla	dallobj
	movi	oid_text,a0
	jauc	dallobj			; avoid conflict with double-ice backfire text


get_winner_ochar
	move	@p1_char,a0,w		; assume p1
	move	@winner_status,a1,w
	cmpi	1,a1
	jreq	gwo9
	move	@p2_char,a0,w		; p2 wins
gwo9	rets


play_ending_chord
	move	@f_death,a0,w
	cmpi	-1,a0
	jreq	pec9			; death blow = let gloom linger
	move	@curback,a3,w
	sll	4,a3
	addi	winner_tunes,a3
	move	*a3,a3,w
	calla	send_code_a3		; send correct ending tune
pec9	rets


fatality_animations
	.word	>16			; fatality
	.word	>16			; fatality
	.word	>1c			; animality
	.word	>2a			; friendship
	.word	>2b			; babality

	.word	>16			; fatality
	.word	>16			; fatality

;***************************************************************************

get_winner_text
	callr	get_winner_ochar	; a0 = winner ochar
	sll	5,a0
	addi	ochar_winner_text,a0
	move	*a0,a8,l		; a8 = correct "pf"
	rets

ochar_winner_text
	.long	txt_kano_wins
	.long	txt_sonya_wins
	.long	txt_jax_wins
	.long	txt_sal_wins
	.long	txt_sz_wins
	.long	txt_swat_wins
	.long	txt_lia_wins
	.long	txt_robo1_wins
	.long	txt_robo2_wins
	.long	txt_lao_wins
	.long	txt_tusk_name_wins
	.long	txt_sg_wins
	.long	txt_st_wins
	.long	txt_lk_wins
	.long	txt_smoke_wins
	.long	txt_motaro_wins
	.long	txt_shao_kahn_wins
	.long	txt_noob_wins
	.long	txt_noob_wins

txt_kano_wins
	.string	"KANO WINS",0
	.even

txt_sonya_wins
	.string	"SONYA WINS",0
	.even

txt_jax_wins
	.string	"JAX WINS",0
	.even

txt_sal_wins
	.string	"NIGHTWOLF WINS",0
	.even

txt_sz_wins
	.string	"SUB-ZERO WINS",0
	.even

txt_swat_wins
	.string	"STRYKER WINS",0
	.even

txt_lia_wins
	.string	"SINDEL WINS",0
	.even

txt_robo1_wins
	.string	"SEKTOR WINS",0
	.even

txt_robo2_wins
	.string	"CYRAX WINS",0
	.even

txt_lao_wins
	.string	"KUNG LAO WINS",0
	.even

txt_tusk_name_wins
	.string	"KABAL WINS",0
	.even

txt_sg_wins
	.string	"SHEEVA WINS",0
	.even

txt_st_wins
	.string	"SHANG TSUNG WINS",0
	.even

txt_lk_wins
	.string	"LIU KANG WINS",0
	.even

txt_motaro_wins
	.string	"MOTARO WINS",0
	.even

txt_smoke_wins
	.string	"SMOKE WINS",0
	.even

txt_shao_kahn_wins
	.string	"SHAO KAHN WINS",0
	.even

txt_noob_wins
	.string	"NOOB SAIBOT WINS",0
	.even

	.string	"JOHNNY CAGE WINS",0
	.even
	.string	"SCORPION WINS",0
	.even
	.string	"REPTILE WINS",0
	.even
	.string	"KITANA WINS",0
	.even
	.string	"MILEENA WINS",0
	.even
	.string	"TOBIAS WINS",0
	.even


txt_tie	.byte	"DRAW",0	;ejbpatch
	.even

txt_single_flawless
	.byte	"FLAWLESS VICTORY",0
	.even

txt_double_flawless
	.byte	"DOUBLE FLAWLESS",0
	.even


	.string	"JOHHNY CAGE TRANSFORMATION ACTIVATED",0
	.even


*
* wait for shao kahn bonus voice to finish
*
wait_for_bonusv
	pull	a11

	movi	>40*4,a10		; we do have our limits
wfb3	sleep	1
	dec	a10
	jreq	wfb5			; enough already !

	movi	chan1pri,a5
wfb4	move	*a5,a0,w
	sll	8,a0
	cmpi	sp_bonusv,a0		; shao kahn bonus speech ?
	jreq	wfb3			; yes, wait
	addi	16*4,a5			; a5 ---> next channel pri
	cmpi	chan5pri+(16*4),a5
	jrne	wfb4

wfb5	jump	a11

;*************************************************************************

	.end
