**************************************************************************
*											     *
*  video game project:	  mortal kombat							*
* 											     *
*  programmer:		  edward j. boon						     *
* 											     *
*  module: mkdebug.asm --  debugging / toddview related routines	     *
* 											     *
*  copyright (c) 1995 williams electronics games, inc.			     *
*											     *
**************************************************************************
	.file	"mkbug.asm"
	.title	" <<< debugging related code >>> "

	.width	132
	.option	b,d,l
	.mnolist
*
* get the system stuff
*
	.include	macros.hdr		; macros
	.include	dispequ.asm		; display processor equates
	.include	sysequ.asm 		; sys.inc and gsp.inc
	.include	mainequ.asm
	.include	diagsequ.asm
	.include	diagaudn.asm
	.include	stringh.asm
	.include	imgtbl.glo

	.GLOBAL	TVPATCH,TVPATCHX
	.globl	curview,gangel
*
* routines defined in this module
*
	.DEF	TVBP,TVBPX,errort
	.def	illegal_opcode

	.if	printer
	.ref	print_dump,print_process
	.endif

	.bss	ram_intenb,16,w
	.bss	ram_intpend,16,w

	.even
	.text

	.if ejbbug

	addi	32,a12		; fake pullp
	addi	32,a12		; fake pullp
	addi	32,a12		; fake pullp
	addi	32,a12		; fake pullp
	addi	32,a12		; fake pullp

	subi	32,a12		; fake pushp
	subi	32,a12		; fake pushp
	subi	32,a12		; fake pushp
	subi	32,a12		; fake pushp
	subi	32,a12		; fake pushp
	subi	32,a12		; fake pushp

	.endif

***********************************************************************
*
* System Errors:
*
*  1 = 1 player state has 2 players active (THIS IS NOT GOOD)
*  2 = winner_status bad (JOY)
*  3 = exobj_er (MKUTIL)
*  4 = exprc_er (MKUTIL)
*  5 = object_setup could not get an object (mkutil)
*  6 = 
*  7 = 
*  8 = swpal ran out of pals
*  9 = rgbstuff could not find a pal
* 10 = rgbstuff could not find a pal
* 11 = color cycler could not find a pal
* 12 = scroll error
*
*************************** CHECKSUMMED **********************************
**************************************************************************
**************************************************************************
**************************************************************************
	.def	seccall2
seccall2
	move	a8,a0			;0CHheck security
	addi	0e9d30h,a0
	getpc	a7
	addi	40h,a7
	move	a7,-*sp,l
	jump	a0			;Rets: A0=0 if OK!
**************************************************************************
**************************************************************************
**************************************************************************
*************************** CHECKSUMMED **********************************
	rets

split_screen_line
	movi	000000001H,a4
	callr	make_vertical_line
	movi	0000000c8H,a4
	callr	make_vertical_line
	movi	00000018fH,a4

make_vertical_line
	movi	bpal_white,a0
	push	a4
	movi	000ff0001H,a3
	calla	make_solid_object
	pull	a4
	calla	set_xy_coordinates
	calla	set_noscroll
	jauc	insobja8



debug_grid
	movk	11,a10
	clr	a9
ddd	movi	bpal_hot_green,a0
	movi	000010330H,a3
	calla	make_solid_object
	calla	set_noscroll
	move	a9,a4
	calla	set_xy_coordinates
	calla	insobja8
	addi	25*010000H,a9
	dsj	a10,ddd

	movk	11,a10
	clr	a9
eee	movi	bpal_blue,a0
	movi	001000001H,a3
	calla	make_solid_object
	calla	set_noscroll
	move	a9,a4
	calla	set_xy_coordinates
	calla	insobja8
	addi	40,a9
	dsj	a10,eee
	rets

**************************************************************************
*												*
*  freeze											*
*												*
*  freezes the screen										*
*												*
**************************************************************************
freeze
	clr	a0
	move	a0,@f_auto_erase,w
	dint

frz2	move	@switch,a0,l
	not	a0
	btst	20,a0			; switch still in ?
	jrne	frz2			; yes
	eint
	movk	1,a0
	move	a0,@f_auto_erase,w
	die


system_lockup
	move	a0,@pf_ram,l
	pull	a0
	move	a0,b14
         movi    aud_syslock,a0
         calla   aud1
	move	@pf_ram,a0,l
         .if debug
	dint
	jruc	$			; in my office ---> hold it right there !!
         .endif
	jauc	recovery		; in the real world ---> recover

**************************************************************************

	.if debug



mk3_demo_message
	calla	oinit
	movi	dlists_bogus,a0
	move	a0,@dlists,l
	movi	pf_mk3_message,a8
	jsrp	lm_printf
	sleep	040H*8
	retp

pf_mk3_message
	mess_mac rd15font,2,0C7H,050H,bpal_red*010000H,strcnrmo,0
	.string	"MORTAL KOMBAT 3\n"
	.string	"DEMO\n\n"
;	.string	"NOVEMBER 10, 1994"
	.string	"DECEMBER 12, 1994"
	.byte	0
	.even



background_debug
;	jsrp	mk3_demo_message

	movi	gs_debug,a0
	move	a0,@gstate,w

	calla	murder_myoinit_score

	movk	1,a0
	move	a0,@round_num,w

	movk	1,a11
	move	a11,@curback,w
	calla	do_a11_background
	sleep	2
	calla	play_background_tune

	clr	a0
	move	a0,*a13(p_store1),l
	move	a0,*a13(p_store2),l
	move	a0,*a13(p_store3),l
	move	a0,*a13(p_store4),l
	move	a0,*a13(p_store5),l
	move	a0,*a13(p_store6),l
	move	a0,*a13(p_store7),l

	move	@worldtly,@worldtly1,l
	move	@worldtly,@worldtly2,l
	move	@worldtly,@worldtly3,l
	move	@worldtly,@worldtly4,l
	move	@worldtly,@worldtly5,l
	move	@worldtly,@worldtly6,l
	move	@worldtly,@worldtly7,l
	move	@worldtly,@worldtly8,l

	movi	pf_instr,a8
	jsrp	lm_printf  		; print instructions

	movi	0200H,a0
	callr	new_oids

	clr	a0
	move	@objlst2,a1,l
	move	a0,@objlst2,l
	move	a1,@objlst,l  		; instruction text ---> list #1

	movi	plane_debug_info,a11
	move	a11,a0
	move	*a0+,a10,l		; worldtly?

	jsrp	print_background_data

bgnd2	move	@switch,a0,l
	not	a0
	btst	25,a0			; lo kick ?
	jreq	bgnd3			; no
	sleep	5			; yes, move slower

bgnd3	sleep	1
	move	@switch,a0,l
	not	a0
	btst	0,a0			; up ?
	jreq	bgnd4

	move	*a11(0),a1,l		; grab worldtly
	move	*a1(16),a2,w
	inc	a2
	move	a2,*a1(16),w		; move up 1 pixel

	callr	get_a11_ram
	move	*a0,a1,w
	dec	a1
	move	a1,*a0,w		; update ram
	jruc	bgnd2

bgnd4	btst	1,a0			; down ?
	jreq	bgnd41

	move	*a11(0),a1,l		; grab worldtly
	move	*a1(16),a2,w
	dec	a2
	move	a2,*a1(16),w		; move up 1 pixel

	callr	get_a11_ram
	move	*a0,a1,w
	inc	a1
	move	a1,*a0,w		; update ram
	jruc	bgnd2


bgnd41	btst	2,a0			; left ?
	jreq	bgnd45			; no

	move	@worldtlx+16,a0,w
	move	@left_edge,a1,w
	cmp	a0,a1
	jrge	bgnd2
	calla	ss_20000_neg
bgnd42	sleep	1
	move	@switch,a0,l
	not	a0
	btst	2,a0			; still left ?
	jreq	bgnd44
	move	@worldtlx+16,a0,w
	move	@left_edge,a1,w
	cmp	a0,a1
	jrlt	bgnd42
bgnd44	calla	stop_scrolling
	jruc	bgnd2


bgnd45	btst	3,a0			; right ?
	jreq	bgnd5			; no

	move	@worldtlx+16,a0,w
	move	@right_edge,a1,w
	cmp	a0,a1
	jrle	bgnd2
	calla	ss_20000
bgnd46	sleep	1
	move	@switch,a0,l
	not	a0
	btst	3,a0			; still left ?
	jreq	bgnd47
	move	@worldtlx+16,a0,w
	move	@right_edge,a1,w
	cmp	a0,a1
	jrgt	bgnd46
bgnd47	calla	stop_scrolling
	jruc	bgnd2

*
* hi punch = print
*
bgnd5 	btst	4,a0			; p1 hi punch ?
	jreq	bgnd6			; no
	jsrp	print_background_data
	jruc	bgnd2

*
* block = change plane / print current plane #
*
bgnd6 	btst	5,a0			; block
	jreq	bgnd8

	addi	32*2,a11		; a11 = next plane
	cmpi 	plane_debug_end,a11
	jrne	bgnd7
     	movi	plane_debug_info,a11
bgnd7	jsrp	print_background_data

	sleep	10
	jruc	bgnd2
*
* hi kick = sky
*
bgnd8	btst	6,a0			; hi kick
	jreq	bgndA			; no

	calla	get_curback_mod		; a1 = current module table
	move	*a1,a1,w		; normal auto erase color

	move	@irqskye,a0,w
	cmpi	0ffH,a0
	jreq	bgnd9
	movi	0ffH,a1
bgnd9	move	a1,@irqskye,w		; alternate ---> bright / normal sky
	sleep	20		
	jruc	bgnd2

bgndA	btst	26,a0			; run ?
	jreq	bgndB

	movi	objlst,a2
	calla	delolist
	movi	objlst2,a2
	calla	delolist		; rid of all text
	sleep	2
	movi	pf_scroll_demo,a8
	jsrp	lm_printf
	sleep	070H
	movi	objlst2,a2
	calla	delolist		; rid of all text
	movi	objlst2,a2
	calla	delolist		; rid of all text
	jruc	scroll_demo

bgndB	jruc	bgnd2


pf_scroll_demo
	mess_mac rd7font,2,scrrgt/2,020H,bpal_red*010000H,strcnrmo,0
	.string	"SCROLL DEMO",0
	.even

*****************************************************************************

print_background_data
	pushp	a11

	movi	oid_text,a0
	calla	dallobj			; erase previous characters
	move	a9,*a13(p_slave),l

	movi	000300050H,a9		; a9 = coordinates
	movk	1,a0
bgnd52	move	a0,*a13(p_anicount),w
	move	a0,@pf_ram,l
*
* left half of "="
*
	move	a9,*a13(p_joyport),l	; save coordinates here !!!
	movi	pf_baklst,a8
	calla	lm_setup		; get yer variables
	move	*a13(p_joyport),a9,l

	push	a9
	jsrp	printf
	pull	a9
*
* right side of "="
*
	move	*a13(p_anicount),a2,w
	dec	a2
	sll	4,a2
	add	a13,a2
	addi	p_store1,a2
	move	*a2,a2,w		; read the value from ram

	addk	8,a9			; move to the right of "="
	push	a9
	movi	pf_baklst_eq_pos,a8

	move	a2,a2
	jrnn	printb3
	abs	a2
	movi	pf_baklst_eq_neg,a8

printb3	move	a2,@pf_ram,l
	calla	lm_setup		; get yer variables
	pull	a9
	jsrp	printf

	move	*a13(p_joyport),a9,l
	addi	0000d0000H,a9		; down 1 line
	move	*a13(p_anicount),a0,w
	inc	a0
	cmpi	9,a0
	jrlo	bgnd52

	move	*a12,a11,l
	jsrp	print_current_plane
	movi	oid_text,a0
	callr	new_oids

	pullp	a11
	retp


print_current_plane
	callr	get_a11_offset		; a0 = offset
	inc	a0
	move	a0,a1
	sll	4,a1
	add	a13,a1
	addi	p_store1,a1
	move	*a1,a9,w		; grab current value of this offset

	push	a9
	movi	pf_current,a5
	jsrp	info_print
	pull	a9
	retp


new_oids
	move	@objlst2,a1,l
	move	a1,a4			; a4 = 1st on list 2
new8	move	a0,*a1(oid),w
	move	a1,a2			; a2 = last on list	2
	move	*a1(olink),a1,l		; give all character objects same oid
	jrne	new8

;	move	@objlst,a3,l
;	move	a3,*a2(olink),l
;	move	a4,@objlst,l
;	clr	a0
;	move	a0,@objlst2,l		; clear list 2
	rets


get_a11_ram
	callr	get_a11_offset
	sll	4,a0
	add	a13,a0
	addi	p_store1,a0
	rets

get_a11_offset
	move	a11,a0
	movi	plane_debug_info,a1
	sub	a1,a0
	sra	6,a0			; divide by 64
	rets


plane_debug_info
	.long	worldtly1,pf_baklst
	.long	worldtly2,pf_baklst
	.long	worldtly3,pf_baklst
	.long	worldtly4,pf_baklst
	.long	worldtly5,pf_baklst
	.long	worldtly6,pf_baklst
	.long	worldtly7,pf_baklst
	.long	worldtly8,pf_baklst
plane_debug_end


baky	.set	050H


pf_baklst
	mess_mac rd7font,2,000H,000H,bpal_red*010000H,strrnrmo,0
	.string	"BAKLST%d = "
	.byte	0
	.long	pf_ram
	.even

pf_baklst_eq_pos
	mess_mac rd7font,2,000H,000H,bpal_red*010000H,strlnrmo,0
	.string	"%x"
	.byte	0
	.long	pf_ram
	.even

pf_baklst_eq_neg
	mess_mac rd7font,2,000H,000H,bpal_red*010000H,strlnrmo,0
	.string	"-%x"
	.byte	0
	.long	pf_ram
	.even





pf_instr
	mess_mac rd7font,2,0c7H,010H,bpal_red*010000H,strcnrmo,0
	.string	"HP = PRINT\n"
	.string	"BLOCK = CHANGE\n"
	.string	"HK = SKY\n"
	.string	"LK = SLOW\n"
	.string	"YELLOW = SCROLL DEMO\n",0
	.even

pf_current
	mess_mac rd7font,2,0c7H,0e8H,bpal_red*010000H,strcnrmo,0
	.string	"CURRENT = "
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

;*******************************************************

scroll_demo

bdemo0	calla	ss_20000
bdemo1	sleep	1
	move	@worldtlx+16,a0,w
	move	@right_edge,a1,w
	cmp	a0,a1
	jrgt	bdemo1

	calla	stop_scrolling
	sleep	020H

	calla	ss_20000_neg
bdemo2	sleep	1

;**************
;	calla	stop_scrolling
;	sleep	020H
;	calla	ss_20000_neg
;	sleep	02cH
;**************

	move	@worldtlx+16,a0,w
	move	@left_edge,a1,w
	cmp	a0,a1
	jrlt	bdemo2

	calla	stop_scrolling
	sleep	020H

	jruc	bdemo0

**************************************************************************

air_slam_debug
	pull	a0
	callr	slam_debug_init
	jruc	bs0

double_mframew_debug
	callr	slam_debug_init
	jruc	bs0


body_slam_debug
	pull	a0			; no return
	callr	slam_debug_init
*
* grab
*
	movk	10,a0
	jsrp	mframew			; grab animation
bs0	sleep	8

	calla	do_next_a9_frame
	calla	advance_him		; both of us ---> frame #1 of throw

bs_loop
	sleep	1

	clr	a1
	clr	a2
bs1	move	@switch,a0,l
	not	a0
	btst	0,a0			; up ?
	jreq	bs4
	dec	a2
bs4	btst	1,a0			; down ?
	jreq	bs6
	inc	a2
bs6	btst	2,a0			; left ?
	jreq	bs7
	dec	a1
bs7	btst	3,a0			; right ?
	jreq	bs8
	inc	a1

bs8 	btst	4,a0			; p1 hi punch ?
	jreq	bsa

	mmtm	a12,a0,a1,a2
	calla	advance_him
	sleep	020H
	mmfm	a12,a0,a1,a2

bsa	btst	5,a0			; p1 block ?
	jreq	bsb

	mmtm	a12,a0,a1,a2
	calla	do_next_a9_frame
	sleep	020H
	mmfm	a12,a0,a1,a2

bsb 
	move	@switch2,a0,l
	not	a0
	btst	012H,a0			; start ?
	jreq	bs9

	mmtm	sp,a0,a1,a2
	jsrp	print_slam_data
	mmfm	sp,a0,a1,a2

bs9	move	*a13(p_otherguy),a5,l
	move	*a5(oxpos),a3,w
	add	a1,a3
	move	a3,*a5(oxpos),w
	move	*a5(oypos),a3,w
	add	a2,a3
	move	a3,*a5(oypos),w
	jruc	bs_loop

slam_debug_init
	mmtm	sp,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13
	calla	murder
	calla	stop_scrolling
	clr	a0
	move	a0,@scrolly,l

	movi	bpal_white,a0
	movi	000500080H,a3
	calla	make_solid_object
	movi	000200000H,a4
	calla	set_xy_coordinates
	calla	set_noscroll
	calla	insobja8
	mmfm	sp,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13
	rets

;*************************************************************************

print_slam_data
	clr	a1
	not	a1
	movi	oid_text,a0
	calla	kilobj2	 		; erase any old text

	movi	pf_deltax,a5		; assume positive #
	move	*a8(oxpos),a0,w
	move	*a10(oxpos),a1,w
	sub	a1,a0
	move	*a10(oflags),a4,w
	btst	b_fliph,a4
	jrne	pslam3
      	neg	a0			; if he has been flipped ---> flip x
pslam3	move	a0,a0
	jrnn	pslam4
	movi	pf_deltax_neg,a5
	abs	a0
pslam4	jsrp	info_print

	movi	pf_deltay,a5
	move	*a8(oypos),a0,w
	move	*a10(oypos),a1,w
	sub	a1,a0
	neg	a0
	jrnn	pslam5
	abs	a0
	movi	pf_deltay_neg,a5
pslam5	jsrp	info_print
	retp


pf_deltax
	mess_mac rd7font,2,infox,infoy,bpal_red*010000H,strrnrmo,0
	.string	"DELTA X = "
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

pf_deltax_neg
	mess_mac rd7font,2,infox,infoy,bpal_red*010000H,strrnrmo,0
	.string	"DELTA X = -"
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

pf_deltay
	mess_mac rd7font,2,infox,infoy+12,bpal_red*010000H,strrnrmo,0
	.string	"DELTA Y = "
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

pf_deltay_neg
	mess_mac rd7font,2,infox,infoy+12,bpal_red*010000H,strrnrmo,0
	.string	"DELTA Y = -"
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

;*************************************************************************

colbox_table
	mmtm	sp,a0,a1,a4,a8

	mmtm	sp,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14
	add	a1,a3
	add	a2,a4
	sll	16,a2
	movy	a2,a1			; a1 = "strike" top left [y,x]
	sll	16,a4
	movy	a4,a3			; a3 = "strike" bottom right [y,x]
	mmtm	sp,a1,a3
	move	*a13(p_otherguy),a10,l

	mmtm	sp,a7,a8
	move	a10,a8
	calla	highest_mpart		; a0 = high point
	calla	lowest_mpart		; a1 = low point
	calla	leftmost_mpart		; a2 = left point
	calla	rightmost_mpart		; a3 = right point
	mmfm	sp,a7,a8

	move	a3,a4
	sub	a2,a4
	abs	a4			; a4 = x size of other dude
	pullp	a6

	calla	cbox_squeeze		; yea

	calla	victim_box
	mmfm	sp,a1,a3
	mmfm	sp,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14


	calla	slam_debug_init
	clr	a1
	move	a1,*a8(oxvel),l
	move	a1,*a8(oyvel),l
	move	a1,*a8(ograv),l		; stop me !!
	move	a1,@p1_xvel,l
	move	a1,@p2_xvel,l

	move	*a13(p_otherguy),a10,l
	move	a1,*a10(oxvel),l
	move	a1,*a10(oyvel),l
	move	a1,*a10(ograv),l  	; stop him

	not	a1
	movi	oid_cbox,a0
	calla	kilobj2	   		; kill all other collision box objects

	push	a3
	movi	bpal_hot_green,a0	; color of box
	movi	000050005H,a3		; bs size for now
	calla	make_solid_object
	pull	a3
	movi	oid_cbox,a0
	move	a0,*a8(oid),w		; set id

	move	a8,a10		    	; a10 = collision box object
	mmfm	sp,a0,a1,a4,a8

	move	a1,*a10(oxpos),w
	move	a2,*a10(oypos),w
	move	a3,*a10(osizex),w
	move	a4,*a10(osizey),w	; define size and shape
	move	a10,a0
	calla	insobj2			; put on list #2 (in front of dudes)

	mmfm	sp,a1,a2,a3		; pull what was pushed on
	pull	a0			; pull return address

	movi	wait_forever,a7
	calla	xfer_otherguy
	calla	reset_proc_stack
	sleep	3
*
* joystick scan
*
	move	*a10(oxpos),a9,w 			;  a9 = x
	move	*a10(oypos),a11,w			; a11 = y

js1	move	@switch,a0,l
	not	a0
	btst	0,a0			; up ?
	jreq	js4
	dec	a11
js4	btst	1,a0			; down ?
	jreq	js6
	inc	a11
js6	btst	2,a0			; left ?
	jreq	js7
	dec	a9
js7	btst	3,a0			; right ?
	jreq	js8
	inc	a9
*
* p2 stick
*
js8   	move	*a10(osizex),a1,w
	move	*a10(osizey),a2,w
	move	@switch,a0,l
	not	a0

	btst	8,a0			; up ?
	jreq	js9
	dec	a2
js9	btst	9,a0			; down ?
	jreq	js10
	inc	a2
js10	btst	10,a0			; left ?
	jreq	js11
	dec	a1
js11	btst	11,a0			; right ?
	jreq	js12
	inc	a1
*
* update collision box
*
js12	cmpi	2,a1
	jrhi	js13
	movk	2,a1
js13	cmpi	2,a2
	jrhi	js14
	movk	2,a2

js14   	move	a1,*a10(osizex),w
	move	a2,*a10(osizey),w
	move	a9,*a10(oxpos),w
	move	a11,*a10(oypos),w
	sleep	1

	move	@switch2,a0,l
	not	a0
	btst	18,a0			; player 1 start ?
	jreq	js16			; nope..

	clr	a1
	not	a1
	movi	oid_text,a0
	calla	kilobj2	 		; erase any old text

	move	*a8(oflags),a0,w
	btst	b_fliph,a0
	jrne	js17		 	; flipped ---> x is invalid

	move	*a8(oxpos),a1,w
	move	*a10(oxpos),a0,w
	move	*a10(osizex),a2,w
	add	a2,a0
	sub	a1,a0
	movi	pf_xoffset,a5
	jsrp	info_print

js17	move	*a8(oypos),a1,w
	move	*a10(oypos),a0,w
	sub	a1,a0			; a0 = y offset
	movi	pf_yoffset,a5
	jsrp	info_print

	move	*a10(osizex),a0,w
	movi	pf_xsize,a5
	jsrp	info_print

	move	*a10(osizey),a0,w
	movi	pf_ysize,a5
	jsrp	info_print

	sleep	020H			; qqq
	jruc	js1

js16	move	@switch,a0,l
	not	a0
 	btst	26,a0			; p1 run ?
	jreq	js1			; no
	calla	murder_myoinit
	jauc	amode

	jruc	js1


*
* a0 = # to print
* a5 = text pointer
*
info_print
	move	a0,@pf_ram,w			; stuff #
	mmtm	a12,a8,a9,a10,a11
	move	a5,a8				; a8 = text pointer
	jsrp	lm_printf
	mmfm	a12,a8,a9,a10,a11		; get our shit back
	retp

infox	.set	060H
infoy	.set	040H


pf_xoffset
	mess_mac rd7font,2,infox,infoy,bpal_hot_green*010000H,strrnrmo,0
	.string	"X OFFSET = "
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

pf_yoffset
	mess_mac rd7font,2,infox,infoy+12,bpal_hot_green*010000H,strrnrmo,0
	.string	"Y OFFSET = "
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

pf_xsize
	mess_mac rd7font,2,infox,infoy+24,bpal_hot_green*010000H,strrnrmo,0
	.string	"X SIZE = "
	.string	"%x"				; in hex please
	.byte	0
	.long	pf_ram
	.even

pf_ysize
	mess_mac rd7font,2,infox,infoy+36,bpal_hot_green*010000H,strrnrmo,0
	.string	"Y SIZE = "
	.string	"%x" 			; in hex please
	.byte	0
	.long	pf_ram
	.even


victim_box
	move	@f_colbox,a14,w		; collision box object ?
	jrne	vicbox3
	rets

vicbox3	mmtm	sp,a0,a1,a2,a3,a4,a8

	push	a3
	movi	bpal_red,a0		; color of victim box
	movi	000050005H,a3		; bs size for now
	calla	make_solid_object
	pull	a3
	movi	oid_vbox,a0
	move	a0,*a8(oid),w		; set id

	move	a8,a10		     ; a10 = collision box object
	mmfm	sp,a0,a1,a2,a3,a4,a8

	mmtm	sp,a0,a1,a2,a3
	move	a0,*a10(oypos),w
	sub	a0,a1
	abs	a1
	move	a1,*a10(osizey),w

	move	a2,*a10(oxpos),w
	sub	a2,a3
	abs	a3
	move	a3,*a10(osizex),w

	move	a10,a0
	calla	insobj2			; put on list #2 (in front of dudes)
	mmfm	sp,a0,a1,a2,a3
	rets

**************************************************************************
*											     *
*  test_obj - put a test object on object list #2 given:			     *
* 											     *
*  Input: a5 = img table									     *
*         a4 = y:x coordinates								     *
*											     *
**************************************************************************
test_obj
	push	a4
	calla	gso_dmawnz_ns
	pull	a4
	calla	set_xy_coordinates
	jauc	insobj2a8

	.endif


normal	.set	0f8ffH	; sysctrl normal = 3 security bits cleared
m_read	.set	07e00H	; read mask

sb_rand	.set	 0100H	; security bits ---> 001 = random mode
sb_zero	.set	 0200H	; security bits ---> 010 = zero
sb_shift	.set	 0300H	; security bits ---> 011 = shift right
sb_write	.set	 0600H	; security bits ---> 110 = write mode
sb_read	.set	 0700H	; security bits ---> 111 = read mode


security
	movi	0edH,a5

	movi	sysctrl,a1		; a1 = system control register
	movi	syscopy,a2		; a2 = ram copy
	movi	dmaregs,a3

	move	*a2,a0,w		; read from ram copy
	andi	normal,a0		; clear out security bits
	ori	sb_write,a0		; put into "write mode"
	move	a0,*a1,w
	move	a0,*a2,w		; stuff in sysctrl and ram copy

	sll	8,a5
	move	a5,*a3,w
	move	a5,*a3,w
	move	a5,*a3,w
	move	a5,*a3,w		; 4th write is the new state
*
* random mode
*
	move	*a2,a0,w		; read from ram copy
	andi	normal,a0		; clear out security bits
	ori	sb_rand,a0
	move	a0,*a1,w
	move	a0,*a2,w		; stuff in sysctrl and ram copy
	move	a0,*a3,w
*
* read mode
*
	move	*a2,a0,w		; read from ram copy
	andi	normal,a0		; clear out security bits
	ori	sb_read,a0		; put into "read mode"
	move	a0,*a1,w
	move	a0,*a2,w		; stuff in sysctrl and ram copy
	move	*a3,a0,w
	andi	m_read,a0		; mask off garbage data
*
* shift right mode (1 position)
*
	move	*a2,a0,w		; read from ram copy
	andi	normal,a0		; clear out security bits
	ori	sb_shift,a0
	move	a0,*a1,w
	move	a0,*a2,w		; stuff in sysctrl and ram copy
	move	a0,*a3,w

	move	*a2,a0,w		; read from ram copy
	andi	normal,a0		; clear out security bits
	ori	sb_read,a0		; put into "read mode"
	move	a0,*a1,w
	move	a0,*a2,w		; stuff in sysctrl and ram copy
	move	*a3,a0,w
	andi	m_read,a0		; mask off garbage data

*
* zero mode
*
	move	*a2,a0,w		; read from ram copy
	andi	normal,a0		; clear out security bits
	ori	sb_zero,a0
	move	a0,*a1,w
	move	a0,*a2,w		; stuff in sysctrl and ram copy
	move	a0,*a3,w

	move	*a2,a0,w		; read from ram copy
	andi	normal,a0		; clear out security bits
	ori	sb_read,a0		; put into "read mode"
	move	a0,*a1,w
	move	a0,*a2,w		; stuff in sysctrl and ram copy
	move	*a3,a0,w
	andi	m_read,a0		; mask off garbage data

	jauc	wait_forever


**************************************************************************
*												*
*  illegal_opcode										*
*												*
*  illegal opcode jumps here.									*
*												*
**************************************************************************
illegal_opcode
	movi	aud_illop,a0
	calla	aud1			; audit this

**************************************************************************
*												*
*  recovery											*
*												*
*  this code tries to salvage the game when either a error trap or a	*
*  bad opcode occurs. follow the comments, they always know !! 		*
*												*
**************************************************************************
recovery
	jauc	$

**************************************************************************
*												*
*  error trap section										*
*												*
*  this code is specifically for debugging purposes. calling consists of *
*  using the macro error_trap p1 where "p1" is the code which will be	*
*  printed on screen after everything is frozen on the screen. 		*
*												*
**************************************************************************
errort
	movi	aud_traps,a0
	calla	aud1
	jauc	$


**************************************************************************
*												*
*  toddview breakpoint routines									*
*												*
*  everytime a breakpoint is hit in toddview "tvbp" is called and before *
*  execution starts again "tvbpx" is called.						*
*												*
**************************************************************************
TVBP
	mmtm	sp,a0,a1

;**************** b4
	move	@intenb,a0,w	; disable rom protect interrupt (ext2)
;	andni	x2e|x1e|die,a0
	andni	x2e|die,a0
	move	a0,@intenb,w
;**************** b4

	push	a3

;	clr	a3
;	move	a3,@scrolly,l
;	move	a3,@scrollx,l
;	move	a3,@scrollx1,l
;	move	a3,@scrollx2,l
;	move	a3,@scrollx3,l
;	move	a3,@scrollx4,l
;	move	a3,@scrollx5,l
;	move	a3,@scrollx6,l
;	move	a3,@scrollx7,l
;	move	a3,@scrollx8,l		; stop annoying scroll smear

;	calla	send_code_a3		; stop music
	pull	a3

;	move	@intenb,a0,w
;	move	a0,@ram_intenb,w
;	andni	x2e,a0	    		; rom protect
;	ori	die,a0			; disable display interupt
;	move	a0,@intenb,w

;	move	@intpend,a0,w
;	move	a0,@ram_intpend,w
;	andni	x2e,a0	    		; rom protect
;	andni	x1e,a0			; disable dma interupt
;	andni	die,a0			; disable display interupt
;	move	a0,@intpend,w

	mmfm	sp,a0,a1
	rets


TVBPX	
;********************** b4
	push	a0
	move	a0,@1e00000h,w	; clear write-to-rom interrupt

	move	@intenb,a0,w
;	ori	x2e,a0	    	; enable rom protect interrupt (ext2)
	ori	die,a0
	move	a0,@intenb,w

	move	@intpend,a0,w
	andni	x2e|die,a0
	move	a0,@intpend,w
;********************** b4

;	move	@ram_intenb,a0,w
;	move	a0,@intenb,w
;	move	@ram_intpend,a0,w
;	move	a0,@intpend,w
;	move	@ram_intenb,a0,w
;	ori	x2e,a0
;	move	a0,@intenb,w
;	move	@intpend,a0,w
;	andni	x1e,a0			; disable dma interupt
;	move	a0,@intpend,w
;	calla	test_it

	pull	a0
	rets

**************************************************************************
*											     *
*   tv patch area									     *
*											     *
**************************************************************************
TVPATCH:
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
TVPATCHX:
