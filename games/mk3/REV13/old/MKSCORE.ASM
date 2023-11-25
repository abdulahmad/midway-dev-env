**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mkscore - score area code							 	*
* 											     *
*  copyright (c) 1994-95 Midway Manufacturing	   					*
*											     *
**************************************************************************
	.file	"mkscore.asm"
	.title	"gsp display processor"

	.width	132
	.option	b,d,l,t
	.mnolist
*
* files required for assembly
*
	.include	sysequ.asm
	.include	macros.hdr
	.include	dispequ.asm
	.include	mainequ.asm
	.include	imgtbl.glo
	.include	mkscore.tbl

backbar_width	.set	168

backbar_y	.set	>19*>10000
p1_backbar_x	.set	>14
p1_turbo_x	.set	p1_backbar_x+1
p1_turbo_y	.set	>23*>10000
p2_turbo_y	.set	p1_turbo_y

p2_backbar_x	.set	scrrgt-backbar_width-p1_backbar_x
p2_turbo_x	.set	scrrgt-full_turbo-p1_turbo_x-1

p1_msg_yx  	.set	>000a0015
;p2_msg_yx  	.set	>000a0164
p2_msg_yx  	.set	>000a0164

p1_sic_yx	.set	>000a0014	; p1 "START/INSERT COIN" y:x coordinate
p2_sic_yx	.set	>000a011d	; p2 "START/INSERT COIN" y:x coordinate

clock_tens_yx	.set	>000700bb
clock_ones_yx	.set	>000700c8

digit_size	.set	10

**************************************************************************
*											     *
*  setup_score_ram - initialize things so we can display the score area  *
*                    stuff								     *
*											     *
**************************************************************************
setup_score_ram
	clr	a0
	move	a0,@f_doscore,w		; flag: don't do score area dma's
	movi	score_ram_end,a0	; a0 = 1st entry
	movi	>01000100,a1		; a1 = scale
*
* win knotches (1-2-3-4)
*
	movi	MEDAL1,a7
	movi	>00000101,a2		; const:pal (score_p)
	move	*a7(isag),a5,l		; sag
	move	*a7(icontrol),a6,w	; control word
	ori	dmawnz,a6
	sll	16,a6
	clr	a3			; x size = 0 ---> no dma needed !!

	movi	>002a0018,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; p1 knotch #1 = null
	movi	>002a0026,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; p1 knotch #2 = null
	movi	>002a016b,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; p2 knotch #1 = null
	movi	>002a015d,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; p2 knotch #2 = null
*
* coin message / player score (5-6)
*
	movi	>00000101,a2		; const:pal (score_p)
	clr	a3
	clr	a4
	clr	a5
	clr	a6
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 1 = null entry
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 2 = null entry
*
* character names in front of powerbars (7-8)
*
	move	@p1_char,a7,w
	sll	6,a7
	addi	p1_powerbar_names,a7
	move	*a7(32),a4,l		; a4 = y:x coordinates
	move	*a7,a7,l
	movi	>00000101,a2		; const:pal
	move	*a7(isize),a3,l		; y:x size
	move	*a7(isag),a5,l		; sag
	move	*a7(icontrol),a6,w	; control word
	ori	dmawnz,a6
	sll	16,a6
	mmtm	a0,a1,a2,a3,a4,a5,a6	; put in score dma ram

	move	@p2_char,a7,w
	sll	6,a7
	addi	p2_powerbar_names,a7
	move	*a7(32),a4,l		; a4 = y:x coordinates
	move	*a7,a7,l
	move	*a7(isize),a3,l		; y:x size
	move	*a7(isag),a5,l		; sag
	move	*a7(icontrol),a6,w	; control word
	ori	dmawnz,a6
	sll	16,a6
	mmtm	a0,a1,a2,a3,a4,a5,a6	; put in score dma ram
*
* solid color powerbars (9-10)
*
	movi	p1_bar,a3
	callr	get_safe_powerbar		; a3 = powerbar y:x size

	movi	bpal_blue*>10000,a2		; const:pal
	movi	(backbar_y+p1_backbar_x)+(>00010001),a4
	movi	>2000000,a5			; a5 = sag	
	movi	dmacal|>2000,a6
	sll	16,a6
	mmtm	a0,a1,a2,a3,a4,a5,a6		; put in ram queue

	movi	p2_bar,a3
	callr	get_safe_powerbar		; a3 = powerbar y:x size
	movi	(backbar_y+p2_backbar_x)+(>00010001),a4
	mmtm	a0,a1,a2,a3,a4,a5,a6		; put in ram queue
*
* clock digits (11-12)
*
	movi	>00000101,a2		; const:pal (score_p)
	movi	COUNTDOWN_9,a7		; initialize with "9"
	move	*a7(isize),a3,l
	movi	clock_tens_yx,a4

	move	*a7(isag),a5,l
	move	*a7(icontrol),a6,w	; control word
	ori	dmawnz,a6
	sll	16,a6
	mmtm	a0,a1,a2,a3,a4,a5,a6	; put in ram
	movi	clock_ones_yx,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; put in ram
*
* score digits for player "# of wins" (13-14-15-16-17-18)
*
	movi	X_SHADNUM0,a7
	move	*a7(isize),a3,l
	move	*a7(isag),a5,l
	move	*a7(icontrol),a6,w	; control word
	ori	dmawnz,a6
	sll	16,a6
	movi	p1_msg_yx,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 1 = digit #1 (hundreds)
	addk	digit_size,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 1 = digit #2 (tens)
	addk	digit_size,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 1 = digit #3 (ones)

	movi	p2_msg_yx,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 2 = digit #1 (hundreds)
	addk	digit_size,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 2 = digit #2 (tens)
	addk	digit_size,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; player 2 = digit #3 (ones)
*
* turbo bars (19-20)
*
	movi	bpal_hot_green,a2	; a2 = const:pal
	sll	16,a2
	movi	>40000+full_turbo,a3	; a3 = y:x size
	movi	p1_turbo_y+p1_turbo_x,a4
	movi	>2000000,a5		; a5 = sag	
	movi	dmacal|>2000,a6
	sll	16,a6
	mmtm	a0,a1,a2,a3,a4,a5,a6	; put in ram queue
	movi	p2_turbo_y+p2_turbo_x,a4
	mmtm	a0,a1,a2,a3,a4,a5,a6	; put in ram queue
*
* backdrops for powerbars (21-22)
*
	movi	PWRBAR_LA,a7
	movi	>00000101,a2				; const:pal
	move	*a7(isize),a3,l				; y:x size
	movi	backbar_y+p1_backbar_x,a4

	move	*a7(isag),a5,l				; sag
	move	*a7(icontrol),a6,w			; control word
	ori	dmawnz,a6
	sll	16,a6
	mmtm	a0,a1,a2,a3,a4,a5,a6			; put in ram

	movi	PWRBAR_RA,a7
	move	*a7(icontrol),a6,w			; control word
	ori	dmawnz,a6
	sll	16,a6
	move	*a7(isag),a5,l				; sag
	movi	backbar_y+p2_backbar_x,a4		; y:x coordinates
	mmtm	a0,a1,a2,a3,a4,a5,a6		 	; put in ram
	move	a0,@score_1st,l				; set "1st dma" location
	rets

update_win_counters
	move	@p1_state,a0,w
	cmpi	ps_active,a0		; player 1 in ?
	jrne	uwc3			; no

	move	@p1_wiar,a3,w		; how many wins in a row ?
	movi	entry_13,a0
	movi	p1_msg_yx+>2d,a5    	; wins digits coordinate start here
	callr	uwc_stuff

	movi	p1_msg_yx,a5
	movi	entry_6,a0
	move	a5,*a0(scr_coor),l	; coordinate for player 1 "WINS:" image

uwc3	move	@p2_state,a0,w
	cmpi	ps_active,a0		; player 2 in ?
	jrne	uwc9			; no

	move	@p2_wiar,a3,w		; how many wins in a row ?
	movi	p2_msg_yx->0e,a5	; assume more than 99 wins (yea right)
	movi	entry_16,a0
	callr	uwc_stuff

	movi	p2_msg_yx->3a,a5
	cmpi	100,a3			; 100 or more wins??? (3 digits)
	jrlo	uwc4			; no
	subi	digit_size,a5		; yes ---> make room for 3rd digit
uwc4	movi	entry_5,a0
	move	a5,*a0(scr_coor),l	; coordinate for player 2 "WINS:" image
uwc9	rets


uwc_stuff
	move	a0,a1
	clr	a7
	move	a7,*a1(scr_size),l	; zero ones
	subi	32*6,a1
	move	a7,*a1(scr_size),l	; zero tens
	subi	32*6,a1
	move	a7,*a1(scr_size),l	; zero hundreds
*
* make each digit prove it should be displayed
*
	move	a3,a1
	movi	100,a7
	divs	a7,a1			; a1 = hundreds of wins
	jreq	uwc5			; yea right

	move	a1,a2
	movi	100,a7
	mpys	a7,a1			; 100x
	sub	a1,a3			; take off 100's
	callr	update_score_digit	; update hundreds digit !
	addk	digit_size,a5  		; next digit over

uwc5	subi	sns,a0			; next dma entry
	move	a3,a1
	movk	10,a7
	divs	a7,a1			; a1 = tens of wins
;	jreq	uwc6			; no

	move	a1,a2
	sll	1,a1			; 2x
	sub	a1,a3
	sll	2,a1			; 8x
	sub	a1,a3			; take off 10's
	callr	update_score_digit	; update tens digit !
	addk	digit_size,a5  		; next digit over

uwc6	subi	sns,a0
	move	a3,a2

*
* a2 = digit we want to use (0-9)
* a3 = 3 digit total
* a5 = y:x coordinates
*
update_score_digit
	clr	a7
	cmpi	1,a2				; "1" character ?
	jrne	usd4				; no
	movk	2,a7				; yes, nudge coordinates

usd4	sll	5,a2
	addi	score_nums_tbl,a2
	move	*a2,a2,l	    		; a1 = hundred's digit image
	move	*a2(isag),*a0(scr_sag),l
	move	*a2(isize),*a0(scr_size),l
	move	*a2(icontrol),a4,w
	ori	dmawnz,a4
	sll	16,a4
	move	a4,*a0(scr_control),l
	add	a7,a5				; nudge if its a "1"
	move	a5,*a0(scr_coor),l
	sub	a7,a5
	rets

;************************************************************************

update_clock_ones
	movi	clock_ones_yx,a5
	jruc	update_clock_digit

update_clock_tens
	movi	clock_tens_yx,a5

update_clock_digit
	cmpi	1,a1
	jrne	ucd4
	addk	2,a5			; adjust for digit "1"
ucd4	sll	5,a1
	addi	clock_nums,a1
	move	*a1,a1,l		; a1 = digit oimg
	move	*a1(isag),a2,l		; a2 = digit sag
	move	*a1(isize),a3,l		; a3 = digit y:x size
	move	*a1(icontrol),a4,w	; a4 = control word
	ori	dmawnz,a4
	sll	16,a4

	move	a2,*a0(scr_sag),l
	move	a3,*a0(scr_size),l
	move	a4,*a0(scr_control),l
	move	a5,*a0(scr_coor),l
	rets

p1_powerbar_names
	.long	N_KANO,>001a0019
	.long	N_SONYA,>001a0019
	.long	N_JAX,>001a0019
	.long	N_NIGHTWOLF,>001a0019
	.long	N_SUBZERO,>001a0019
	.long	N_STRYKER,>001a0019
	.long	N_SINDEL,>001a0019
	.long	N_SEKTOR,>001a0019
	.long	N_CYRAX,>001a0019
	.long	N_KUNGLAO,>001a0019
	.long	N_KABAL,>001a0019
	.long	N_SHEEVA,>001a0019
	.long	N_SHANGTSUNG,>001a0019
	.long	N_LIUKANG,>001a0019
	.long	N_SMOKE,>001a0019
	.long	N_MOTARO,>001a0019
	.long	N_SHAOKAHN,>001a0019
	.long	N_NOOBSAIBOT,>001a0019


p2_powerbar_names
	.long	N_KANO,>001a0153
	.long	N_SONYA,>001a014c
	.long	N_JAX,>001a015a
	.long	N_NIGHTWOLF,>001a0132
	.long	N_SUBZERO,>001a013c
	.long	N_STRYKER,>001a0140
	.long	N_SINDEL,>001a0149
	.long	N_SEKTOR,>001a0149
	.long	N_CYRAX,>001a0149
	.long	N_KUNGLAO,>001a0139
	.long	N_KABAL,>001a014f
	.long	N_SHEEVA,>001a0149
	.long	N_SHANGTSUNG,>001a0123
	.long	N_LIUKANG,>001a013d
	.long	N_SMOKE,>001a0149
	.long	N_MOTARO,>001a0144
	.long	N_SHAOKAHN,>001a0132
	.long	N_NOOBSAIBOT,>001a0127
	.long	BAR_NULL,>001a0149


BAR_NULL
	.long	0,0,0,0,0

score_nums_tbl
	.long	X_SHADNUM0
	.long	X_SHADNUM1
	.long	X_SHADNUM2
	.long	X_SHADNUM3
	.long	X_SHADNUM4
	.long	X_SHADNUM5
	.long	X_SHADNUM6
	.long	X_SHADNUM7
	.long	X_SHADNUM8
	.long	X_SHADNUM9

**************************************************************************
*											     *
*  update_knotches - updates the ram so the correct "knotches" state     *
*                    is represented in the score area.			     *
*											     *
**************************************************************************
update_knotches
	mmtm	sp,a0,a1,a2,a3,a4,a5
	movi	MEDAL1,a5      
	move	*a5(isize),a5,l		; a5 = medal image y:x size
*
* player 1
*
	clr	a0
	clr	a1
	move	@p1_matchw,a2,w		; any wins for p1 ?
	jreq	uk2			; no
	move	a5,a0
	dec	a2
	jreq	uk2
	move	a5,a1
uk2	move	a0,@p1_knotch1,l
	move	a1,@p1_knotch2,l	; update both knotches for p1
*
* player 2
*
	clr	a0
	clr	a1
	move	@p2_matchw,a2,w		; any wins for p2 ?
	jreq	uk4			; no
	move	a5,a0
	dec	a2
	jreq	uk4
	move	a5,a1
uk4	move	a0,@p2_knotch1,l
	move	a1,@p2_knotch2,l	; update both knotches for p2

uk7	mmfm	sp,a0,a1,a2,a3,a4,a5
	rets

**************************************************************************
*											     *
*  update_pmsg - update player message						     *
*											     *
**************************************************************************
update_pmsg
	mmtm	sp,a0,a1,a2,a3,a4,a5
	clr	a5				; for clearin'
*
* player 1 message
*
	movi	X_SHADWINS,a0
;	movi	>000c0034,a4
	movi	p1_msg_yx,a4

	move	@p1_state,a1,w
	cmpi	ps_active,a1			; player 1 in ?
	jreq	up2				; yea

	move	a5,@entry_13+scr_size,l	; 100's digit = off
	move	a5,@entry_14+scr_size,l	;  10's digit = off
	move	a5,@entry_15+scr_size,l	;   1's digit = off
	callr	start_or_insertcoin		; msg = insert coin or push start
	movi	p1_sic_yx,a4

up2	callr	grab_oimg_data
	movi	entry_6,a0			; 4 knotch + p1 + p2 = 6 entries
	clr	a5
	callr	stuff_info
*
* player 2 message
*
	movi	X_SHADWINS,a0
	movi	p2_msg_yx->3a,a4

	move	@p2_state,a1,w
	cmpi	ps_active,a1			; player 2 in ?
	jreq	up4				; yes

	move	a5,@entry_16+scr_size,l	; 100's digit = off
	move	a5,@entry_17+scr_size,l	;  10's digit = off
	move	a5,@entry_18+scr_size,l	;   1's digit = off
	callr	start_or_insertcoin
	movi	p2_sic_yx,a4

up4	callr	grab_oimg_data
	movi	entry_5,a0		; 4 knotch + p1 = 5 entries
	clr	a5
	callr	stuff_info

	clr	a1
	not	a1
	movi	pid_flasher,a0
	calla	existp	      		; flasher proc running ?
	jreq	up9			; no

	movi	flash_pmsg2,a7
	calla	fastxfer		; yes, start him over again

up9	mmfm	sp,a0,a1,a2,a3,a4,a5
	rets


stuff_info
	move	a5,*a0(32*3),l		; zero size so dirq wont mess with us
	move	a3,*a0,l		; control:offset
	move	a2,*a0(32*1),l		; sag
	move	a4,*a0(32*2),l		; stuff y:x coordinates
	move	a1,*a0(32*3),l		; stuff y:x size (also says go to dirq)
	rets

start_or_insertcoin
	movi	INSERTCOIN,a0
	calla	cr_strtp		; enough credits 2 start ?
	jrlo	soic9			; no
	movi	PUSHSTART,a0
soic9	rets
	

grab_oimg_data
	move	*a0(isize),a1,l
	move	*a0(isag),a2,l
	move	*a0(icontrol),a3,w
	ori	dmawnz,a3
	sll	16,a3
	rets

clock_nums
	.long	COUNTDOWN_0
	.long	COUNTDOWN_1
	.long	COUNTDOWN_2
	.long	COUNTDOWN_3
	.long	COUNTDOWN_4
	.long	COUNTDOWN_5
	.long	COUNTDOWN_6
	.long	COUNTDOWN_7
	.long	COUNTDOWN_8
	.long	COUNTDOWN_9

qwerty
	movi	PWRBAR_LB,a2			; assume ---> stuff in part B
	movi	PWRBAR_RA,a4			; p2 part A

	move	@entry_21+scr_sag,a0,l
	movi	PWRBAR_LA,a1
	move	*a1(isag),a3,l			; part A sag
	cmp	a0,a3				; were we using part A ?
	jrne	qwe3				; no ---> now we are

	move	*a2(isag),a3,l			; part B sag
	movi	PWRBAR_RB,a4			; p2 part B

qwe3	move	a3,@entry_21+scr_sag,l	; p1 sag
	move	*a4(isag),a3,l
	move	a3,@entry_22+scr_sag,l	; into p2 sag
	rets

**************************************************************************
*											     *
*  get_safe_powerbar - gives u back a powerbar x size that can be	     *
*                      stuffed into the dma ram area.			     *
* 											     *
*  input: a3 ---> ram variable p?_bar							     *
* 											     *
*  returns: a3 = value >= 3								     *
*											     *
**************************************************************************
get_safe_powerbar
	move	*a3,a3,w
	cmpi	3,a3				; danger zone ?
	jrhs	upw3
	movk	3,a3				; yes ---> keep at minimum of 3
upw3	ori	>00080000,a3			; a3 = y:x size o bar
	rets

**************************************************************************
*											     *
*  recharge_bars - give both players full power and cancell any bar_drop *
*                  values								     *
*											     *
**************************************************************************
recharge_bars
	movi	full_strength,a0
	move	a0,@p1_bar,w
	move	a0,@p2_bar,w		; sans sans power
	move	a0,@p1_bar_view,w
	move	a0,@p2_bar_view,w

	movi	full_turbo,a0
	move	a0,@p1_turbo,w
	move	a0,@p1_turbo_view,w
	move	a0,@p2_turbo,w
	move	a0,@p2_turbo_view,w	; fresh supply 'o' turbo !!

position_p2_bar
	move	@p2_bar_view,a1,w
	movi	full_strength,a0
	sub	a1,a0
	addi	p2_backbar_x+1,a0
	move	a0,@p2_bar_xpos,w

	move	@p2_turbo_view,a1,w
	movi	full_turbo,a0
	sub	a1,a0
	addi	p2_turbo_x+1,a0
	move	a0,@p2_turbo_xpos,w
	rets

refresh_score
	calla	setup_score_ram
	calla	show_scores
	calla	update_knotches
	calla	update_win_counters
	calla	update_pmsg
	rets

;**************************************************************************

	.end

