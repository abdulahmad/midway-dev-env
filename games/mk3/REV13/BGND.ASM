**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: bgnd.asm  --- background code							*
* 											     *
*  copyright (c) 1995 williams electronics games, inc.			     *
*											     *
**************************************************************************
	.file	"bgnd.asm"
	.width	132
	.option	b,d,l,t
	.mnolist
*
* get the system stuff
*
	.include	imgtbl.glo
	.include	bgndtbl.glo

	.include	dispequ.asm
	.include	sysequ.asm
	.include	macros.hdr
	.include	mainequ.asm
	.include	stringh.asm

	.text

**************************************************************************
*											     *
*  do_a11_background - create a background update process			     *
* 											     *
*  input: a11 = offset into table of background modules			     *
*											     *
**************************************************************************
do_a11_background
	.if ejbbug

	jruc	skippy

	clr	a11
 	move	a11,@curback,w

skippy
	.endif

	sll	5,a11
	addi	table_o_mods,a11
	move	*a11,a11,l	 	; a11 = background
	move	a11,a0
	callr	init_bakmods
	create	pid_backg,background
	rets

;	.long	subway_mod	; 0
;	.long	street_mod	; 1
;	.long	bank_mod	; 2
;	.long	roof_mod	; 3
;	.long	tower_mod	; 4
;	.long	bridge_mod	; 5
;	.long	soul_mod	; 6
;	.long	bell_mod	; 7
;	.long	temple_mod	; 8
;	.long	grave_mod 	; 9
;	.long	pit_mod		; a

**************************************************************************
*											     *
*  background - background update process						     *
* 											     *
*  input: a11 = multiplane bmod table							     *
*											     *
**************************************************************************
background
	movk	8,a10			; sleep time for updater
back1	callr	multi_plane
	move	a10,a0
	calla	prcslp			; sleep the requested time !
	jruc	back1


multi_plane
	movi	plane_info_table,a1

	movi	baklst1+32,a8		; start with furthest plane back !!

mulpl5	mmfm	a1,a0,a3,a4,a7		; load up the input registers

	subi	32,a8			; a8 ---> next background list
	cmpi	baklst8-32,a8		; all done ?
 	jreq	mulpl6			; yes, exit

	move	*a0,a0,l
	cmpi	skip_bakmod,a0
	jreq	mulpl5			; skip this plane

	cmpi	dumbgnd,a0
	jreq	mulpl6			; dumbgnd ---> thats all !!
	callr	mp_bgnd_ud1  		; update another plane
	jruc	mulpl5

mulpl6	rets

*
* multi-plane background update call
*
mp_bgnd_ud1
	move	*a3,a3,l		; a3 = worldtl x
	move	*a4,a4,l		; a4 = worldtl y
	srl	16,a3			; position x in the x half
	srl	16,a4
	sll	16,a4			; position y in the y half
	or	a4,a3
	move	a3,a4
	jauc	bgnd_ud1		; background update routine


plane_info_table
	.long	bak1bits,worldtly,worldtlx1,bak1mods
	.long	bak2bits,worldtly,worldtlx2,bak2mods
	.long	bak3bits,worldtly,worldtlx3,bak3mods
	.long	bak4bits,worldtly,worldtlx4,bak4mods
	.long	bak5bits,worldtly,worldtlx5,bak5mods
	.long	bak6bits,worldtly,worldtlx6,bak6mods
	.long	bak7bits,worldtly,worldtlx7,bak7mods
	.long	bak8bits,worldtly,worldtlx8,bak8mods
	.long	0

*************************************************************************

init_bakmods
	clr	a1
	move	a1,@bak1bits,l
	move	a1,@bak2bits,l
	move	a1,@bak3bits,l
	move	a1,@bak4bits,l
	move	a1,@bak5bits,l
	move	a1,@bak6bits,l
	move	a1,@bak7bits,l
	move	a1,@bak8bits,l		; cear this stuff out primero !!

	move	*a0+,a1,w
	cmpi	null_irqskye,a1
	jreq	ibak1	       		; null = dont touch !!

	move	a1,@irqskye,w		; word #1 = background color

ibak1	move	*a0+,a1,w		; word #2 = worldtly / ceiling y
	move	a1,@worldtly+16,w
	move	a1,@ceiling_y,w

	move	*a0+,a2,w		; word #3 = ground y offset
	add	a2,a1
	move	a1,@ground_y		

	move	*a0+,a1,w		; word #4 = world x
	cmpi	center_x,a1		; this background centered ??
	jreq	ibak2			; yes skip

	sll	16,a1
	push	a0
	move	a1,a0
	calla	set_all_worldtlx	; 3rd word = initial worldtlx
	pull	a0
	
ibak2	move	*a0+,a1,w
	move	a1,@left_edge,w
	move	*a0+,a1,w
	move	a1,@right_edge,w	; scroll limits

	move	*a0+,a1,l
	mmtm	sp,a0,a9,a10,a11
	call	a1			; call routine
	mmfm	sp,a0,a9,a10,a11

	move	*a0+,a1,l
	move	a1,@scrtab,l		; set scroll table
	move	*a0+,a1,l
	move	a1,@dlists,l		; display lists

	move	*a0+,a1,l		; starting bak?mod to fill
ibak3	move	*a0+,a2,l

	cmpi	skip_bakmod,a2		; skip a plane ?
	jrne	ibak4			; no
	move	a2,*a1+,l		; yes, signal ---> skip plane
	jruc	ibak3

ibak4	cmpi	0ffffffffH,a2		; end of module list ?
	jreq	ibak5			; yup
	cmpi	center_x,a2		; center world coordinates ?
	jreq	ibak8

	subi	32,a0
	move	a0,*a1+,l		; nope...stuff module pointer
	addi	64,a0			; a0 ---> next entry
	jruc	ibak3

ibak5	move	*a0,a1,l		; floor info ?
	jreq	ibak9			; no...
	calla	setup_floor_info	; yes ---> use it

ibak9	rets

*
* center all world coordinates
*
ibak8	move	*a0+,a1,l	; a1 = module
	jreq	ibak5	 	; zero ---> we done
	move	*a0+,a2,l	; a2 = world coordinates to set
	move	*a1,a1,w     	; a1 = module x size
	srl	1,a1		; 1/2 length of module
	subi	scrrgt/2,a1	; middle of screen
	sll	16,a1
	move	a1,*a2,l
	jruc	ibak8

**************************************************************************
*											     *
*  scroller - process to keep players on screen					     *
*											     *
**************************************************************************

far	.set	100
midzone	.set    150
mz_out	.set	(scrrgt-midzone)/2


scroller
	clr	a11			; a11 = flag: dont pit scroll !!
	sleep	4

scrstop	calla	stop_scrolling

scrloop	sleep	1

	move	@p2_obj,a8,l
	move	*a8(oxpos),a1,w		; a1 = player 2 ani x
	move	@p1_obj,a8,l
	move	*a8(oxpos),a0,w		; a0 = player 1 ani x

	cmp	a0,a1
	jrgt	scr4

	swap	a0,a1			; make sure a0 < a1

scr4	move	a1,a2
	sub	a0,a2			; a2 = distance between players
	move	a2,a3			; a3 = distance between players
	srl	1,a2
	add	a0,a2			; a2 = center point between 'em
	cmpi	far,a3
	jrhi	sc_far			; dudes are far apart
*
* dudes are close together
*
	move	@worldtlx+16,a3,w
	addi	scrrgt/2,a3   		; a3 = center o screen
	sub	a3,a2
	abs	a2
	cmpi	midzone/2,a2
	jrls	scr_stop		; center point in range
	cmp	a0,a3
	jrgt	scr_left
	jruc	scr_right
*
* dudes are far apart (just keep 'em on screen)
*
sc_far	move	@worldtlx+16,a3,w
	move	a3,a4
	addi	scrrgt-40,a4		; a4 = right edge
	addi	40,a3			; a3 = left edge

	cmp	a3,a0			; within left edge ?
	jrlt	scr_left		; no --> scroll left
	cmp	a4,a1			; within right edge ?
	jrle	scr_stop		; yes ---> stop
*
* scroll right
*
scr_right
	move	@right_edge,a3,w
	move	@worldtlx+16,a1,w
	cmp	a3,a1
	jrge	scr_stop		; too far right ----> no scroll

	movi	right_scrolls,a2
	movi	ss_28000,a3
	jruc	scr_choose
*
* scroll left
*
scr_left
	move	@left_edge,a2,w
	move	@worldtlx+16,a1,w
	cmp	a2,a1
	jrle	scr_stopl		; too far right ----> no scroll

	movi	left_scrolls,a2
	movi	ss_28000_neg,a3

scr_choose
	move	@p1_xvel,a4,l
	move	@p2_xvel,a5,l
	abs	a4
	abs	a5
	cmp	a5,a4
	jrhs	scrch4
	move	a5,a4			; a4 = fastest moving dude
scrch4	move	a4,a4
	jreq	scrr6

	move	a2,a5
scrr3	move	*a5+,a3,l		; grab a table speed
	jrne	scrr7			; legit..

	subi	32*2,a5			; last entry = use fastest scroll speed
	jruc	scrr5			; use dat routine...

scrr7	cmp	a4,a3			; how does table entry compare ?
	jrhs	scrr5			; faster or same ---> use it
	addi	32,a5			; a5 = next table entry !!
	jruc	scrr3

scrr5	move	*a5,a3,l		; grab a routine
scrr6	move	@scrtab,b0,l
	call	a3
	jruc	scrl3

scr_stopl
	move	a0,a0

scr_stop	calla	stop_scrolling

**************************************************************************
*											     *
*   y scrolling										     *
*											     *
**************************************************************************
scrl3	move	@ground_y,a3,w
	move	@ceiling_y,a5,w

	move	@p1_obj,a6,l
	move	*a6(oflags2),a4,w
	move	*a6(oypos),a6,w		; a6 = player 1 ani y
	btst	b_ignore_y,a4		; should I ignore this y ???
	jreq	scrl4			; no...
	move	@p1_proc,a6,l
	move	*a6(p_ganiy),a6,w	; yes, pretend like he is grounded

scrl4 	move	@p2_obj,a7,l
	move	*a7(oflags2),a4,w
	move	*a7(oypos),a7,w		; a7 = player 2 ani y
	btst	b_ignore_y,a4		; should I ignore this y ???
	jreq	scrl5			; no...
	move	@p2_proc,a7,l
	move	*a7(p_ganiy),a7,w	; yes, pretend like he is grounded

scrl5	move	@worldtly+16,a0,w
	move	a0,a1
	addi	40,a1			; a1 = upper barrier
	cmp	a1,a6
	jrle	scrl7			; we need to scroll up
	cmp	a1,a7
	jrle	scrl7			; we need to scroll up

	cmp	a5,a0
	jreq	scrl9			; we are perfect ---> stop scrolling
	jrgt	scrl8			; we are too low ---> adjust back up

	movi	018000H,a0
   	jruc	scrla			; scroll down
*
* scroll up
*
scrl7	subi	010H,a5			; a5 = highest we are allowed to scroll
	cmp	a5,a0
	jrle	scrl9			; too high

	sub	a6,a1
	abs	a1			; a1 = how far we are from the limit
	cmpi	2,a1
	jrlo	scrl9			; too close ---> avoid jittering

	sub	a7,a1
	abs	a1			; a1 = how far we are from the limit
	cmpi	2,a1
	jrlo	scrl9			; too close ---> avoid jittering

	movi	-018000H,a0
	jruc	scrla

scrl8	move	a5,@worldtly+16,w	; stuff exactly where we want to be
scrl9	clr	a0
scrla	move	a0,@scrolly,l		; stop scroll
	jruc	scrloop

right_scrolls
	.long	010000H,ss_10000
	.long	020000H,ss_20000
	.long	028000H,ss_28000
	.long	030000H,ss_30000
	.long	040000H,ss_40000
	.long	060000H,ss_60000
	.long	070000H,ss_70000
	.long	080000H,ss_80000
	.long	0a0000H,ss_a0000
	.long	0

left_scrolls
	.long	010000H,ss_10000_neg
	.long	020000H,ss_20000_neg
	.long	028000H,ss_28000_neg
	.long	030000H,ss_30000_neg
	.long	040000H,ss_40000_neg
	.long	060000H,ss_60000_neg
	.long	070000H,ss_70000_neg
	.long	080000H,ss_80000_neg
	.long	0a0000H,ss_a0000_neg
	.long	0


ss_10000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_neg_values,b0
	jruc	ss_10

ss_10000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_scroll_values,b0

ss_10	sra	1,a1
	sra	1,a2
	sra	1,a3
	sra	1,a4
	sra	1,a5
	sra	1,a6
	sra	1,a7
	sra	1,a8
	sra	1,a9
	jump	b0


ss_20000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	jruc	stuff_neg_values

ss_20000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9	; grab the values from table
	jruc	stuff_scroll_values

ss_28000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9	; grab the values from table
	movi	stuff_neg_values,b0
	jruc	ss_28

ss_28000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9	; grab the values from table
	movi	stuff_scroll_values,b0

ss_28	move	a1,a10
	sra	2,a10
	add	a10,a1		; subtract 1/4 table value
	move	a2,a10
	sra	2,a10
	add	a10,a2
	move	a3,a10
	sra	2,a10
	add	a10,a3
	move	a4,a10
	sra	2,a10
	add	a10,a4
	move	a5,a10
	sra	2,a10
	add	a10,a5
	move	a6,a10
	sra	2,a10
	add	a10,a6
	move	a7,a10
	sra	2,a10
	add	a10,a7
	move	a8,a10
	sra	2,a10
	add	a10,a8
	move	a9,a10
	sra	2,a10
	add	a10,a9
	jump	b0


ss_30000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_neg_values,b0
	jruc	ss_30

ss_30000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_scroll_values,b0

ss_30	move	a1,a10
	sra	1,a10
	add	a10,a1		; 2 + 1 = 3
	move	a2,a10
	sra	1,a10
	add	a10,a2
	move	a3,a10
	sra	1,a10
	add	a10,a3
	move	a4,a10
	sra	1,a10
	add	a10,a4
	move	a5,a10
	sra	1,a10
	add	a10,a5
	move	a6,a10
	sra	1,a10
	add	a10,a6
	move	a7,a10
	sra	1,a10
	add	a10,a7
	move	a8,a10
	sra	1,a10
	add	a10,a8
	move	a9,a10
	sra	1,a10
	add	a10,a9
	jump	b0

;********************************** may be eliminated (for kano) ejbejbejb
ss_80000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_neg_values,b0
	jruc	ss_80

ss_80000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_scroll_values,b0

ss_80	sll	2,a1
	sll	2,a2
	sll	2,a3
	sll	2,a4
	sll	2,a5
	sll	2,a6
	sll	2,a7
	sll	2,a8
	sll	2,a9
	jump	b0
;********************************** may be eliminated (for kano) ejbejbejb


ss_40000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_neg_values,b0
	jruc	ss_40

ss_40000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_scroll_values,b0

ss_40	sll	1,a1
	sll	1,a2
	sll	1,a3
	sll	1,a4
	sll	1,a5
	sll	1,a6
	sll	1,a7
	sll	1,a8
	sll	1,a9
	jump	b0


ss_60000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_neg_values,b0
	jruc	ss_60

ss_60000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_scroll_values,b0

ss_60	move	a1,a10
	sll	1,a10
	add	a10,a1		; 2 + 4 = 6
	move	a2,a10
	sll	1,a10
	add	a10,a2
	move	a3,a10
	sll	1,a10
	add	a10,a3
	move	a4,a10
	sll	1,a10
	add	a10,a4
	move	a5,a10
	sll	1,a10
	add	a10,a5
	move	a6,a10
	sll	1,a10
	add	a10,a6
	move	a7,a10
	sll	1,a10
	add	a10,a7
	move	a8,a10
	sll	1,a10
	add	a10,a8
	move	a9,a10
	sll	1,a10
	add	a10,a9
	jump	b0


ss_70000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_neg_values,b0
	jruc	ss_70

ss_70000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_scroll_values,b0

ss_70	move	a1,a10
	move	a1,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a1
	add	a11,a1		; 2 + 4 + 1 = 7
		
	move	a2,a10
	move	a2,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a2
	add	a11,a2

	move	a3,a10
	move	a3,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a3
	add	a11,a3

	move	a4,a10
	move	a4,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a4
	add	a11,a4

	move	a5,a10
	move	a5,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a5
	add	a11,a5

	move	a6,a10
	move	a6,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a6
	add	a11,a6

	move	a7,a10
	move	a7,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a7
	add	a11,a7

	move	a8,a10
	move	a8,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a8
	add	a11,a8

	move	a9,a10
	move	a9,a11
	sll	1,a10
	sra	1,a11	
	add	a10,a9
	add	a11,a9

	jump	b0


ss_a0000_neg
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_neg_values,b0
	jruc	ss_a0

ss_a0000
	move	@scrtab,a0,l
	mmfm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	movi	stuff_scroll_values,b0

ss_a0	move	a1,a10
	sll	2,a10
	add	a10,a1			; 2 + 8 = a

	move	a2,a10
	sll	2,a10
	add	a10,a2

	move	a3,a10
	sll	2,a10
	add	a10,a3

	move	a4,a10
	sll	2,a10
	add	a10,a4

	move	a5,a10
	sll	2,a10
	add	a10,a5

	move	a6,a10
	sll	2,a10
	add	a10,a6

	move	a7,a10
	sll	2,a10
	add	a10,a7

	move	a8,a10
	sll	2,a10
	add	a10,a8

	move	a9,a10
	sll	2,a10
	add	a10,a9
	jump	b0


stuff_neg_values
	neg	a1
	neg	a2
	neg	a3
	neg	a4
	neg	a5
	neg	a6
	neg	a7
	neg	a8
	neg	a9	; <<<<<<<<<<<< fall through >>>>>>>>>>>>

stuff_scroll_values
	movi	scrollx+32,a0
	mmtm	a0,a1,a2,a3,a4,a5,a6,a7,a8,a9
	rets

stop_scrolling
	clr	b0
	move	b0,@scrollx,l
	move	b0,@scrollx1,l
	move	b0,@scrollx2,l
	move	b0,@scrollx3,l
	move	b0,@scrollx4,l
	move	b0,@scrollx5,l
	move	b0,@scrollx6,l
	move	b0,@scrollx7,l
	move	b0,@scrollx8,l
	rets

;************************************************

scroll_a9
	clr	a0
	move	a0,@scrolly,l
	move	@ceiling_y,a0,w
	sll	16,a0
	move	a0,@worldtly,l

scrol9	push	a9
	callr	scroll_to_x_a9
	pull	a9
	sleep	1
	jruc	scrol9

scroll_to_x_a9
	move	@worldtlx+16,a1,w
	movi	stop_scrolling,a5
	move	a9,a3
	sub	a1,a3
	abs	a3
	cmpi	6,a3
	jrlo	kcen3 		; just about centered ---> stop scroll
	cmp	a1,a9
	jrgt	kcen_right
	jrlt	kcen_left
	jruc	kcen3

;************************************************

*
* a8 = dude to follow
*
scroll_center
	clr	a0
	move	a0,@scrolly,l

	move	@ceiling_y,a0,w
	sll	16,a0
	move	a0,@worldtly,l

scrc3	callr	keep_centered_on_a8
	sleep	1
	jruc	scrc3

keep_centered_on_a8
	move	*a8(oxpos),a0,w
	move	@worldtlx+16,a1,w
	addi	scrrgt/2,a1

	movi	stop_scrolling,a5
	move	a0,a3
	sub	a1,a3
	abs	a3
	cmpi	6,a3
	jrlo	kcen3			; just about centered ---> stop scroll

	cmp	a1,a0
	jrgt	kcen_right
	jrlt	kcen_left
	jruc	kcen3

kcen_right
	move	@right_edge,a0,w
	move	@worldtlx+16,a1,w
	sub	a0,a1
	abs	a1
	cmpi	6,a1
	jrlo	kcen3			; too close to edge ---> stop scrolling

	move	@scrtab,b0,l
;	movi	ss_20000,a5
	movi	ss_40000,a5
	jruc	kcen3

kcen_left
	move	@left_edge,a0,w
	move	@worldtlx+16,a1,w
	sub	a0,a1
	abs	a1
	cmpi	6,a1
	jrlo	kcen3			; too close to edge ---> stop scrolling

	move	@scrtab,b0,l
;	movi	ss_20000_neg,a5
	movi	ss_40000_neg,a5

kcen3	push	a8
	call	a5
	pull	a8
	rets

**************************************************************************
*											     *
*   Falling down the pit scroll proc !!						     *
*											     *
**************************************************************************
pit_scroll_proc
	calla	stop_scrolling
	clr	a0
	move	a0,@scrolly,l

	jsrp	white_flash
*
* NOW...we put up the grad wall
*
	movi	THRONEWALL,a5
	calla	gso_dmawnz_ns
	movi	000fe0000H,a4
	calla	set_xy_coordinates
	move	a8,a0
	move	a8,a9
	movi	baklst4,b4
	calla	insobj_v      		; left side slab

	movi	THRONEWALL,a5
	calla	gso_dmawnz_ns
	calla	flip_single
	move	*a9(oypos),*a8(oypos),w
	move	*a9(oxpos),a0,w
	move	*a9(osizex),a1,w
	add	a1,a0
	move	a0,*a8(oxpos),w		; lineup next to one on the left
	move	a8,a0
	movi	baklst4,b4
	calla	insobj_v


;	movi	baklst2,a0
;	move	@worldtlx2+16,a5,w
;	callr	bridge_list_fixed

	movi	baklst3,a0
	move	@worldtlx3+16,a5,w
	callr	bridge_list_fixed
	movi	baklst4,a0
	move	@worldtlx4+16,a5,w
	callr	bridge_list_fixed	; these lists follow a different y

;	clr	a0
;	move	a0,@baklst2,l

	movi	skip_bakmod,a0
;	move	a0,@bak2mods,l
	move	a0,@bak3mods,l
	move	a0,@bak4mods,l		; dont update these lists !!

	clr	a1
	not	a1
	movi	pid_backg,a0
	calla	existp
	movk	1,a1
	move	a1,*a0(pa10),l		; background updater = every tick !!
	clr	a9
	move	a9,*a13(p_store1),l	; init: clear this long
	movi	040H,a10
*
* follow him down the pit !!
*
pits1	sleep	1

	move	*a11(oxpos),a0,w
	move	@worldtlx+16,a1,w
	addi	scrrgt/2,a1
	movi	stop_scrolling,a5
	move	a0,a3
	sub	a1,a3
	abs	a3
	cmpi	6,a3
	jrlo	pits3			; just about centered ---> stop scroll
	cmp	a1,a0
	jrhi	pit_scroll_right
	jrlo	pit_scroll_left
pits3	call	a5

	move	a10,a10
	jreq	pits5
	dsj	a10,pits1		; dont scroll down just yet

	clr	a10
	movi	-010000H,a1
	movi	baklst3,a0
	callr	bridge_list_scroll
	movi	baklst4,a0
	callr	bridge_list_scroll	; start the slower scroll !!

pits5	move	*a11(oyvel),a6,l
	move	a6,a0
	sra	3,a0
	add	a0,a6			; scroll faster than fall !!
	move	a6,@scrolly,l		; follow him down da pit

	move	*a13(p_store1),a9,l	; machine object yet ???
	jreq	pits1			; no

	move	*a9(oypos),a0,w
	subi	scrbot-060H,a0
	move	@worldtly+16,a1,w
	cmp	a1,a0			; have we reached the bottom ???
	jrgt	pits1			; no, loopy

	clr	a2
	move	a2,@scrolly,l
	move	a0,@worldtly+16,w	; stop exactly here
	callr	stop_scrolling		; yes, stop

	clr	a1
	movi	baklst3,a0
	callr	bridge_list_scroll
	movi	baklst4,a0
	callr	bridge_list_scroll	; stop the slower scroll !!

pits6	sleep	10
pit_scroll_stopped
	jruc	pits6


pit_scroll_right
	move	@right_edge,a3,w
	move	@worldtlx+16,a1,w
	cmp	a3,a1
	jrge	pit_stop_scroll		; too far right ----> no scroll

	move	@scrtab,b0,l
	movi	ss_20000,a5
	jruc	pits3


pit_scroll_left
	move	@left_edge,a2,w
	move	@worldtlx+16,a1,w
	cmp	a2,a1
	jrle	pit_stop_scroll		; too left right ----> no scroll

	move	@scrtab,b0,l
	movi	ss_20000_neg,a5
	jruc	pits3

pit_stop_scroll
	callr	stop_scrolling
	jruc	pits3


bridge_list_fixed
	move	@worldtly+16,a6,w

blf5	move	*a0,a8,l
	jreq	olns9

	move	*a8(oxpos),a0,w
	sub	a5,a0
	move	a0,*a8(oxpos),w
	move	*a8(oypos),a0,w
	sub	a6,a0
	move	a0,*a8(oypos),w
	calla	set_noscroll		; sky don't scroll

	move	a8,a0
	jruc	blf5

olns9	rets

**************************************************************************
*											     *
*   a0 = list										     *
*   a1 = scroll value to stuff in							     *
*											     *
**************************************************************************
bridge_list_scroll
	move	*a0,a0,l
	jreq	olns9
	move	a1,*a0(oyvel),l
	jruc	bridge_list_scroll

**************************************************************************
*											     *
*  background_blast - transition when blasting through one background    *
*                     to another								     *
*											     *
**************************************************************************
background_blast
	movi	03e1H,a3
	calla	send_code_a3		; stop music !!
	calla	stop_scrolling
*
* block #1 = centered about player who is crashing through
*
	move	a8,a9
	callr	get_ceiling_block1
	move	*a9(oxpos),a0,w
	calla	center_about_x		; lineup with victum
	calla	insobja8		; on list 1
	move	a8,a10			; a10 = 1st ceiling block
*
* build blocks left
*
	move	*a10(oxpos),a5,w	; a5 = current xpos
blast0	callr	get_ceiling_block1
	move	*a10(oypos),*a8(oypos),w
	move	*a8(osizex),a0,w
	move	a5,a4
	sub	a0,a4
	move	a4,*a8(oxpos),w
	calla	insobja8		; on list 
	move	a4,a5			; new current xpos
	move	@worldtlx+16,a3,w
	sub	a3,a4			; a4 = screen xpos of this piece
	cmpi	-010H,a4
	jrgt	blast0
*
* build blocks right
*
	move	*a10(oxpos),a5,w	; a5 = current xpos
blast1	callr	get_ceiling_block1
	move	*a10(oypos),*a8(oypos),w
	move	*a10(osizex),a0,w
	move	a5,a4
	add	a0,a4
	move	a4,*a8(oxpos),w
	calla	insobja8		; on list 
	move	a4,a5			; new current xpos
	move	@worldtlx+16,a3,w
	sub	a3,a4			; a4 = screen xpos of this piece
	cmpi	scrrgt,a4
	jrlt	blast1
*
* broken pieces
*
	callr	get_ceiling_block2
	movk	1,a0
	move	a0,*a8(ozpos),w		; in front of fixed pieces
	move	*a9(oxpos),a4,w
	move	*a8(osizex),a3,w
	sub	a3,a4
	move	a4,*a8(oxpos),w
	move	a8,*a13(p_store1),l	; save 1st broken piece here

	callr	get_ceiling_block3
	movk	1,a0
	move	a0,*a8(ozpos),w		; in front of fixed pieces
	move	*a9(oxpos),*a8(oxpos),w
	move	a8,*a13(p_store2),l	; save 2nd broken piece here
*
* wait for the floor to scroll offscreen
*
	movi	-0a0000H,a0
	move	a0,@scrolly,l
blast2	sleep	1
	move	@worldtly+16,a0,w
	move	@ceiling_y,a1,w
	sub	a0,a1 			; a1 = # of pixels above ceiling
	move	@skew_height,a2,w
	sub	a1,a2			; higher than floor height ?
	jrp	blast2			; no, loop

	move	@skew_constpal,a0,l
	calla	freepal	   		; delete old floor palette !!

	movi	pid_combo_msg,a0
	calla	dallprc
	movi	oid_combo_msg,a0
	calla	dallobj			; dont need these anymore
*
* pull player objects off "objlst"
*
	move	@p1_obj,a0,l
	calla	delobj			; take off objlst
	move	@p2_obj,a0,l
	calla	delobj			; take off objlst

	move	@ofree,a5,l
	move	*a5(olink),a6,l
	move	*a6(olink),a0,l
	move	a0,@ofree,l		; take player obj's off free list

	push	a5
	move	@p2_obj,a5,l
	calla	screen_a5
	move	@p1_obj,a5,l
	calla	screen_a5
	pull	a5
*
* object list block move
*
	clr	a0
	movi	bgnd_move_table,a1
blast3	move	*a1+,a2,l		; grab "from" list
	jreq	blast4
	move	*a1+,a3,l		; grab "to" list
	move	*a2,a4,l		; get "from"
	move	a0,*a2,l		; clear "from"
	move	a4,*a3,l		; stuff "to"
	jruc	blast3
*
* both player objects ----> objlst
*
blast4	move	@worldtly,@worldtly_t,l	; pass along y

	move	a6,*a5(olink),l			; a5 ---> a6
	move	a0,*a6(olink),l			; a6 ---> 0
	move	a5,@objlst,l

;newnew
;	movi	street_mod,a0
	move	*a13(p_store8),a0,l
	calla	init_bakmods
	calla	no_edge_limits			; no limits just yet
*
* plot the new background objects
*
	movk	1,a0
	move	a0,@f_only_t,w			; avoid "plot while on screen race"

	move	*a13(p_store7),a0,l
	move	a0,@dlists,l
	calla	multi_plane

	move	@worldtly+16,a5,w

	move	*a13(p_store5),a0,w
	add	a0,a5
	move	a5,@worldtly+16,w		; start underneath upper background

	move	@p2_obj,a5,l
	calla	world_a5
	move	@p1_obj,a5,l
	calla	world_a5			; new world coordinates

	clr	a0
	move	a0,@f_only_t,w			; ok to plot now
*
* disable interfering procs
*
	movi	pid_repell,a0
	calla	dallprc
	movi	pid_scroll,a0
	calla	dallprc

blast5	sleep	1
	move	*a9(oypos),a0,w
	cmpi	0f8H,a0
	jrgt	blast5		; wait for player to reach ceiling/floor

	move	*a13(p_store1),a0,l
	movi	objlst_t,b4
	calla	insobj_v
	move	*a13(p_store2),a0,l
	movi	objlst_t,b4
	calla	insobj_v  			; put broken pieces on object list
	movk	2,a0
	calla	create_fx			; exploding rock pieces
*
* wait for scroll to reach broken floor
*
blast8	sleep	1
	move	@worldtly+16,a0,w
	move	@ceiling_y,a1,w
	addi	63,a1
	cmp	a1,a0
	jrgt	blast8				; part 1 = zoom up to floor

	clr	a2
	move	a2,@scrolly,l			; stop scrolling
	sub	a0,a1
	move	@worldtly+16,a2,w
	sub	a1,a2
	move	a2,@worldtly+16,w
	move	@worldtly_t+16,a2,w
	sub	a1,a2
	move	a2,@worldtly_t+16,w		; set both worldy's to match

	movi	-020000H,a0
	move	a0,@scrolly,l			; scroll up slow
blast9	sleep	1
	move	@worldtly+16,a0,w
	move	@ceiling_y,a1,w
	cmp	a1,a0
	jrgt	blast9				; part 2 = scroll up slowly

	clr	a0
	move	a0,@scrolly,l			; stop scrolling
	move	@ceiling_y,@worldtly+16,w

	create	pid_repell,repell
	create	pid_scroll,scroller
	create	pid_backg,background

;**********
	create	pid_flasher,flash_pmsg
	calla	update_pmsg
;**********

	move	*a13(p_store6),a0,w
	move	a0,@curback,w	   	; new current background
	calla	get_curback_mod
	move	*a1(16*4),a0,w
	move	a0,@left_edge,w
	move	*a1(16*5),a0,w
	move	a0,@right_edge,w   	; reset the edge limits

	calla	get_curback_mod
	move	*a1(16*10),a0,l
	move	a0,@dlists,l	   	; activate proper dlist

	movi	baklst8_t,a3
blastA	move	a3,a2
	calla	delolist
	addi	32,a3
	cmpi	objlst_t+32,a3	   	; delete objects on temporary lists
	jrne	blastA

	sleep	040H

	movi	028H,a3	    		; street/roof hip hoppin tune.
	move	@curback,a0,w
	cmpi	4,a0
	jrne	blastB

	callr	chord_hit
	callr	chord_hit
	callr	chord_hit
	sleep	010H
	movi	01dH,a3
blastB	calla	send_code_a3		; street/roof hip hoppin tune.
	die


chord_hit
	pull	a11
	movi	044H,a3
	calla	send_code_a3
	sleep	10
	jump	a11


get_ceiling_block3
	movi	STBREAK3,a6
	jruc	gcb3

get_ceiling_block2
	movi	STBREAK2,a6
	jruc	gcb3

get_ceiling_block1
	movi	STBREAK1,a6
gcb3	push	a5
	move	a6,a5
	calla	gso_dmawnz
	move	@ceiling_y,a0,w
	subi	060H,a0
	move	a0,*a8(oypos),w		; position block over victum
	clr	a0
	move	a0,*a8(ozpos),w
	pull	a5
	rets

bgnd_move_table
	.long	baklst8,baklst8_t	; from , to
	.long	baklst7,baklst7_t
	.long	baklst6,baklst6_t
	.long	baklst5,baklst5_t
	.long	baklst4,baklst4_t
	.long	baklst3,baklst3_t
	.long	baklst2,baklst2_t
	.long	baklst1,baklst1_t
	.long	objlst,objlst_t

	.long	worldtlx8,worldtlx8_t
	.long	worldtlx7,worldtlx7_t
	.long	worldtlx6,worldtlx6_t
	.long	worldtlx5,worldtlx5_t
	.long	worldtlx4,worldtlx4_t
	.long	worldtlx3,worldtlx3_t
	.long	worldtlx2,worldtlx2_t
	.long	worldtlx1,worldtlx1_t
	.long	worldtlx,worldtlx_t
	.long	0

dlists_subway_to_street
	.long	-1,use_worldtly_t
	.long	baklst8_t,worldtlx8_t+16		; blurry wall
	.long	baklst7_t,worldtlx7_t+16		; train
	.long	baklst6_t,worldtlx6_t+16		; front / pillars
	.long	baklst5_t,worldtlx5_t+16		; lit / unlit
	.long	baklst4_t,worldtlx4_t+16		; rails
	.long	baklst3_t,worldtlx3_t+16		; gleam
	.long	baklst2_t,worldtlx2_t+16		; gleam
	.long	objlst_t,worldtlx_t+16	    	; players

	.long	-1,check_only_t
	.long	-1,use_worldtly
	.long	baklst6,worldtlx6+16
	.long	baklst5,worldtlx5+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	-1,floor_code
	.long	baklst1,worldtlx1+16
	.long	baklst4,worldtlx1+16
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0


dlists_bank_to_roof
	.long	-1,use_worldtly_t
	.long	baklst2_t,worldtlx2_t+16
	.long	baklst1_t,worldtlx1_t+16
	.long	objlst_t,worldtlx_t+16
	.long	-1,check_only_t
	.long	-1,use_worldtly

	.long	baklst7,worldtlx5+16
	.long	baklst6,worldtlx6+16
	.long	baklst5,worldtlx4+16
	.long	baklst4,worldtlx4+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	-1,floor_code
	.long	baklst1,worldtlx1+16
;	.long	-1,shadow_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0


dlists_soul_to_tower
	.long	-1,use_worldtly_t
	.long	baklst7_t,worldtlx7_t+16
	.long	baklst6_t,worldtlx6_t+16
	.long	baklst5_t,worldtlx5_t+16
	.long	baklst4_t,worldtlx4_t+16
	.long	baklst3_t,worldtlx3_t+16
	.long	baklst2_t,worldtlx2_t+16
	.long	baklst1_t,worldtlx1_t+16
	.long	objlst_t,worldtlx_t+16
*
* tower
*
	.long	-1,check_only_t
	.long	-1,use_worldtly

	.long	baklst5,worldtlx5+16
	.long	baklst4,worldtlx4+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	-1,floor_code
	.long	baklst1,worldtlx1+16
	.long	baklst8,worldtlx1+16		; torch
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

;*************************************************************
;*************************************************************

dlists_end
	.long	0

dlist_jump
	move	*a3,a3,l
	rets

use_worldtly
	move	@worldtly,a4,l
	rets

use_worldtly_t
	move	@scrolly,a7,l
	move	@worldtly_t,a4,l
	add	a7,a4
	move	a4,@worldtly_t,l	; do y scrolling for temp planes
	rets

check_only_t
	move	@f_only_t,a7,w		; only t lists ??
	jreq	cot9			; no, do them all !!!
	movi	dlists_end,a3		; yes, skip the remaining lists
cot9	rets

;**************************************************************************

	.end
