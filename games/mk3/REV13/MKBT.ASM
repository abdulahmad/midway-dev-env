**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: mkbt.asm - background tables							*
* 											     *
*  copyright (c) 1995 williams electronics games, inc.			     *
*											     *
**************************************************************************
	.file	"mkbt.asm"
	.width	132
	.option	b,d,l,t
	.mnolist
*
* get the system stuff
*

	.include	macros.hdr
	.include	imgtbl.glo
	.include	bgndtbl.glo
	.include	dispequ.asm
	.include	sysequ.asm
	.include	mainequ.asm
	.include	mkfloor1.tbl
	.include	mkbgani.tbl
	.include	mkbgani2.tbl
	.text

table_o_mods
	.long	subway_mod	; 0
	.long	street_mod	; 1
	.long	bank_mod	; 2
	.long	roof_mod	; 3
	.long	tower_mod	; 4
	.long	bridge_mod	; 5
	.long	soul_mod	; 6
	.long	bell_mod	; 7
	.long	temple_mod	; 8
	.long	grave_mod 	; 9
	.long	pit_mod		; a
	.long	portal_mod	; b
	.long	buyin_mod	; c
	.long	bio_mod		; d
	.long	ladder_mod	; e
	.long	vs_mod		; f  - vs screen
	.long	coin_mod	; 10	- coin page
	.long	story_mod	; 11 - attract mode stories
	.long	nowall_mod	; 12 - hidden (so 2 speak) background
	.long	buyin_mod	; 13
	.long	buyin_mod	; 14
	.long	buyin_mod	; 15
	.long	buyin_mod	; 16
	.long	buyin_mod	; 17
	.long	ending_mod	; 18


skdie1_mod
	.word	0      	 	; autoerase color
	.word	000H    	   	; initial world y
	.word	0d8H	     	; ground y offset
	.word	400	     	; initial world x
	.word	0 	       	; scroll left limit
	.word	1200-scrrgt  	; scroll right limit
	.long	skdie_calla	; routine: make lightning proc
	.long	portal_scroll	; scroll table
	.long	dlists_roof
	.long	bak1mods
	.long	TEXT1BMOD 	; baklst1
	.word	-010H,060H
	.long	center_x
	.long	TEXT1BMOD,worldtlx1
	.long	TEXT1BMOD,worldtlx4
	.long	0,0

skdie_calla
	create	pid_bani,storm_proc
	movi	skdie_ani_table,a6
	jruc	create_dumb_animators	; animating stationary newspapers

skdie_ani_table
	.word	5					; animation speed
	.long	0002f00d3H,a_sknado,baklst5	; image, coordinates
	.word	0


a_sknado
	.long	SKNADO1
	.long	SKNADO2
	.long	SKNADO3
	.long	SKNADO4
	.long	SKNADO5
	.long	SKNADO6
	.long	SKNADO7
	.long	SKNADO8
	.long	0


skdie2_mod
	.word	0      	 	; autoerase color
	.word	000H    	   	; initial world y
	.word	0d8H	     	; ground y offset
	.word	400	     	; initial world x
	.word	0 	       	; scroll left limit
	.word	1200-scrrgt  	; scroll right limit
	.long	return	     	; routine: make lightning proc
	.long	portal_scroll	; scroll table
	.long	dlists_roof
	.long	bak1mods
	.long	TEXT2BMOD 		; baklst1
	.word	-010H,060H
	.long	center_x
	.long	TEXT2BMOD,worldtlx1
	.long	0,0



coin_mod
	.word	0	  	 	; autoerase color
	.word	0	      		; initial world y
	.word	0	      		; ground y
	.word	0	      		; initial worldx
	.word	0 	      		; scroll left limit
	.word	0	      		; scroll right limit
	.long	return
	.long	no_scroll     		; scroll table
	.long	dlists_buyin
	.long	bak1mods
	.long	coinmodBMOD
	.word	-048H,000H
	.long	0ffffffffH
	.long	0


ending_mod
	.word	0	  	 	; autoerase color
	.word	0	      		; initial world y
	.word	0	      		; ground y
	.word	0	      		; initial worldx
	.word	0 	      		; scroll left limit
	.word	0	      		; scroll right limit
	.long	return
	.long	no_scroll     		; scroll table
	.long	dlists_buyin
	.long	bak1mods
	.long	ENDMODBMOD
	.word	000H,-029H-11
	.long	0ffffffffH
	.long	0


story_mod
	.word	0	  	 	; autoerase color
	.word	0	      		; initial world y
	.word	0	      		; ground y
	.word	0	      		; initial worldx
	.word	0 	      		; scroll left limit
	.word	0	      		; scroll right limit
	.long	return
	.long	no_scroll     		; scroll table
	.long	dlists_buyin
	.long	bak1mods
	.long	WIDEMODBMOD
	.word	000H,-029H
	.long	0ffffffffH
	.long	0


bio_mod
	.word	0	  	 	; autoerase color
	.word	0	      		; initial world y
	.word	0	      		; ground y
	.word	0	      		; initial worldx
	.word	0 	      		; scroll left limit
	.word	0	      		; scroll right limit
	.long	return
	.long	no_scroll     		; scroll table
	.long	dlists_buyin
	.long	bak1mods
	.long	BIOMODBMOD
	.word	080H,001H
	.long	0ffffffffH
	.long	0


buyin_mod
	.word	0	  	 	; autoerase color
	.word	0				; initial world y
	.word	0e8H	     			; ground y
	.word	0				; initial worldx
	.word	-050H 	  			; scroll left limit
	.word	0fffH	  			; scroll right limit

	.long	return
	.long	no_scroll			; scroll table
	.long	dlists_buyin

	.long	bak1mods
	.long	buyintopBMOD
	.word	000H,000H
	.long	buyinbotBMOD
	.word	000H,070H

	.long	0ffffffffH
	.long	0

dlists_buyin
	.long	baklst4,worldtlx+16
	.long	baklst3,worldtlx+16
	.long	baklst2,worldtlx+16
	.long	baklst1,worldtlx+16
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

no_scroll
	.long	0,0,0,0,0,0,0,0,0

**************************************************************************
*											     *
*  module: portal (hidden)									*
*											     *
**************************************************************************
portal_mod
	.word	0			 	; autoerase color
	.word	000H   	 		   	; initial world y
	.word	0d8H			   	; ground y offset
	.word	400			   	; initial world x
	.word	0 	  	   		; scroll left limit
	.word	1200-scrrgt		   	; scroll right limit

	.long	mk3_calla			; routine: make lightning proc
	.long	portal_scroll			; scroll table
	.long	dlists_portal

	.long	bak1mods
	.long	skip_bakmod 	 		; baklst1 = skip (lightning)
	.long	HIDDEN1BMOD			; baklst2 = floor
	.word	000H,0c0H
	.long	HIDDEN2BMOD			; baklst3 = portal sky
	.word	000H,000H

	.long	center_x
	.long	HIDDEN2BMOD,worldtlx1
	.long	HIDDEN1BMOD,worldtlx2
	.long	HIDDEN2BMOD,worldtlx3
	.long	0,0

portal_scroll
	.long	0		; 8
	.long	0		; 7
	.long	0		; 6
	.long	0		; 5
	.long	0		; 4
	.long	0		; 3
	.long	020000H		; 2
	.long	0		; 1
	.long	020000H		; player list

dlists_portal
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	baklst1,worldtlx1+16
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

**************************************************************************
*											     *
*  module: pit chamber										*
*											     *
**************************************************************************
pit_mod
	.word	0			 	; autoerase color
	.word	000H   	 		   	; initial world y
	.word	0e0H			   	; ground y offset
	.word	400			   	; initial world x
	.word	0 	  	   		; scroll left limit
	.word	1200-scrrgt		   	; scroll right limit

	.long	return				; routine to call
	.long	pit_scroll			; scroll table
	.long	dlists_pit

	.long	bak1mods
	.long	MKPIT1BMOD			; baklst1 =
	.word	000H,-02bH
	.long	MKPIT2BMOD			; baklst2 =
	.word	000H,-007H
	.long	MKPIT3BMOD			; baklst3 =
	.word	000H,06dH
	.long	MKPIT4BMOD			; baklst4 =
	.word	000H,01cH

	.long	center_x
	.long	MKPIT1BMOD,worldtlx1
	.long	MKPIT2BMOD,worldtlx2
	.long	MKPIT3BMOD,worldtlx3
	.long	MKPIT4BMOD,worldtlx4
	.long	0,0

pit_scroll
	.long	0		; 8
	.long	0		; 7
	.long	000H		; 6
	.long	000H		; 5

;	.long	04000H		; 4
	.long	0		; 4

	.long	08000H		; 3
	.long	0c000H		; 2
	.long	020000H		; 1
	.long	020000H		; player list


dlists_pit
	.long	baklst4,worldtlx4+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	baklst1,worldtlx1+16
;	.long	-1,floor_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0


;dlists_down_the_pit
;	.long	-1,use_next_y,worldtly4
;	.long	baklst4,worldtlx4+16
;	.long	-1,use_next_y,worldtly3
;	.long	baklst3,worldtlx3+16
;
;;	.long	-1,use_next_y,worldtly2
;	.long	baklst2,worldtlx2+16
;	.long	baklst1,worldtlx1+16
;	.long	-1,floor_code
;	.long	objlst,worldtlx+16
;	.long	objlst2,worldtlx+16
;	.long	0


build_pit_saw
	push	a8
	move	a8,a10
	move	*a10(oxpos),a9,w

	calla	get_my_dfe

	movi	-0a0H,a7			; left edge adjust
	cmpi	070H,a5
	jrlo	build2	  		; close to left edge !!

	movi	-0100H,a7
	cmpi	070H,a6
	jrhi	build2			; normal
	movi	-0180H,a7		; right corner

build2	add	a7,a9
	movk	3,a11
build3	movi	SAW1,a5
	calla	gso_dmawnz
	move	*a13(p_ganiy),*a8(oypos),w
	move	a9,*a8(oxpos),w			; lineup !!
	addi	080H,a9				; spacing of saws
	calla	insobja8
	create	pid_bani,saw_spin_proc
	dsj	a11,build3

	clr	a1
	not	a1
	movi	pid_scroll,a0
	calla	existp
	move	a8,*a0(p_store1),l  		; pass info to scroller !!

	pull	a8
	rets

saw_spin_proc
	movi	a_saw,a9
	movk	1,a0
	jsrp	framew
	jruc	saw_spin_proc

a_saw	.long	SAW1
	.long	SAW2
	.long	SAW3
	.long	SAW4
	.long	SAW5
	.long	SAW6
	.long	0

**************************************************************************
*											     *
*  module: Soul chamber										*
*											     *
**************************************************************************
soul_mod
	.word	(32*32*2)+(32*3)+3	 	; autoerase color
	.word	000H   	 		   	; initial world y
	.word	0f7H			   	; ground y offset
	.word	400			   	; initial world x
	.word	0 	  	   		; scroll left limit
	.word	1200-scrrgt  		   	; scroll right limit

	.long	soul_calla			; routine to call
	.long	soul_scroll			; scroll table
	.long	dlists_soul

	.long	bak1mods
	.long	SOUL1BMOD			; baklst1 =
	.word	000H,09cH
	.long	SOUL2BMOD			; baklst2 =
	.word	000H,052H
	.long	skip_bakmod 	 		; baklst3 = skip (soulnado)

	.long	SOUL3BMOD			; baklst4 =
	.word	000H,-016H
	.long	SOUL4BMOD			; baklst5 =
	.word	000H,076H
	.long	SOUL5BMOD			; baklst6 =
	.word	000H,00eH

	.long	center_x
	.long	SOUL1BMOD,worldtlx1
	.long	SOUL2BMOD,worldtlx2
	.long	SOUL3BMOD,worldtlx3
	.long	SOUL3BMOD,worldtlx4
	.long	SOUL4BMOD,worldtlx5
	.long	SOUL5BMOD,worldtlx6
	.long	0

	.long	FL_SOUL	   			; sag
	.long	SOFLOR_P   			; palette for floor
	.word	42				; floor height
	.long	scrollx1			; which scroll variable to follow
	.long	skew_7

soul_scroll
	.long	0		; 8
	.long	0		; 7
	.long	08000H		; 6
	.long	0c000H		; 5
	.long	010000H		; 4
	.long	010000H		; 3
	.long	018000H		; 2
	.long	01c000H		; 1
	.long	020000H		; player list

dlists_soul
;	.long	-1,use_next_y,worldtly7
	.long	baklst7,worldtlx7+16

;	.long	-1,use_next_y,worldtly6
	.long	baklst6,worldtlx6+16

;	.long	-1,use_next_y,worldtly5
	.long	baklst5,worldtlx5+16

;	.long	-1,use_next_y,worldtly4
	.long	baklst4,worldtlx4+16

;	.long	-1,use_next_y,worldtly3
	.long	baklst3,worldtlx3+16

;	.long	-1,use_next_y,worldtly2
	.long	baklst2,worldtlx2+16

;	.long	-1,use_next_y,worldtly1
	.long	baklst1,worldtlx1+16

	.long	-1,floor_code
	.long	-1,shadow_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

soul_calla
	movi	SONADO1,a5
	calla	gso_dmawnz
	movi	0004802c8H,a4
	calla	set_xy_coordinates

	movi	baklst3,b4
	move	a8,a0
	calla	insobj_v
	create	pid_bani,soul_na_do
	rets

soul_na_do
	movi	a_soul_na_do,a9
	movk	4,a0
	jsrp	framew
	die

a_soul_na_do
	.long	SONADO1
	.long	SONADO2
	.long	SONADO3
	.long	SONADO4
	.long	SONADO5
	.long	SONADO6
	.long	SONADO7
	.long	SONADO8
	.long	SONADO9
	.long	SONADO10
	.long	SONADO11
	.long	SONADO12
	.long	ani_jump,a_soul_na_do

**************************************************************************
*											     *
*  module: Grave	yard										*
*											     *
**************************************************************************
grave_mod
	.word	(32*32*0)+(32*0)+4	 	; autoerase color
	.word	000H    				; initial world y
	.word	0f7H		  		; ground y offset
	.word	400				; initial world x
	.word	0 	  			; scroll left limit
	.word	1200-scrrgt  			; scroll right limit

	.long	grave_calla			; routine to call
	.long	grave_scroll			; scroll table
	.long	dlists_grave

	.long	bak1mods
	.long	GRAVE1BMOD			; baklst1 =
	.word	000H,007H
	.long	GRAVE2BMOD			; baklst2 =
	.word	000H,-008H
	.long	GRAVE3BMOD			; baklst3 =
	.word	000H,05bH
	.long	GRAVE4BMOD			; baklst4 =
	.word	000H,05cH
	.long	GRAVE5BMOD			; baklst5 =
	.word	0190H,033H
	.long	GRAVE6BMOD			; baklst6 =
	.word	000H,07dH
	.long	GRAVE7BMOD			; baklst7 =
	.word	000H,04aH

	.long	center_x
	.long	GRAVE1BMOD,worldtlx1
	.long	GRAVE2BMOD,worldtlx2
	.long	GRAVE3BMOD,worldtlx3
	.long	GRAVE4BMOD,worldtlx4
;	.long	GRAVE6BMOD,worldtlx6
	.long	GRAVE7BMOD,worldtlx7
	.long	0

	.long	FL_GRAVE   			; sag
	.long	CEMFLR_P   			; palette for floor
	.word	42				; floor height
	.long	scrollx1			; which scroll variable to follow
	.long	skew_7


grave_scroll
	.long	0		; 8
	.long	00000H		; 7
	.long	08000H		; 6
	.long	0c000H		; 5
	.long	010000H		; 4
	.long	014000H		; 3
	.long	018000H		; 2
	.long	01c000H		; 1
	.long	020000H		; player list

dlists_grave
;	.long	-1,use_next_y,worldtly8
	.long	baklst8,worldtlx8+16

;	.long	-1,use_next_y,worldtly7
	.long	baklst7,worldtlx7+16

;	.long	-1,use_next_y,worldtly6
	.long	baklst6,worldtlx6+16

;	.long	-1,use_next_y,worldtly5
	.long	baklst5,worldtlx5+16

;	.long	-1,use_next_y,worldtly4
	.long	baklst4,worldtlx4+16

;	.long	-1,use_next_y,worldtly3
	.long	baklst3,worldtlx3+16

;	.long	-1,use_next_y,worldtly2
	.long	baklst2,worldtlx2+16

;	.long	-1,use_next_y,worldtly1
	.long	baklst1,worldtlx1+16
	.long	baklst9,worldtlx1+16

	.long	-1,floor_code
	.long	-1,shadow_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

grave_calla
	movi	MOONA1,a5
	movi	000180040H,a4
	calla	gso_dmawnz_ns_coor		; get moon object
	create	pid_bani,moon_proc
	movi	baklst8,b4
	move	a8,a0
	calla	insobj_v

	movk	3,a0
	calla	randu	
	dec	a0
	sll	5,a0
	addi	stone_lists,a0
	move	*a0,a10,l

	movk	4,a11
tomb3	move	a11,a0
	dec	a0
	sll	5,a0
	add	a10,a0
	move	*a0,a5,l
	calla	gso_dmawnz

	move	a11,a0
	dec	a0
	sll	4,a0
	addi	tomb_spots,a0
	move	*a0+,a1,w
	move	@worldtlx1+16,a0,w
	add	a0,a1
	move	a1,*a8(oxpos),w

	move	@ground_y,a0,w
	subi	058H,a0
	move	a0,*a8(oypos),w			; position tomb stone !!

	movi	baklst9,b4
	move	a8,a0
	calla	insobj_v
	dsj	a11,tomb3
	rets


stone_lists
	.long	tomb_stones1
	.long	tomb_stones2
	.long	tomb_stones3

tomb_stones1
	.long	BOON
	.long	BERAN
	.long	TOBIAS
	.long	GOSKIE

tomb_stones2
	.long	GOSKIE
	.long	FORDEN
	.long	VOGEL
	.long	MICHIC

tomb_stones3
	.long	BERAN
	.long	FORDEN
	.long	TOBIAS
	.long	MICHIC


tomb_spots
	.word	-0100H
	.word	000H
	.word	0100H
	.word	0200H
	.word	0300H

moon_proc
	movi	040H,a0
	movi	040H,a1
	calla	randu_minimum
	calla	prcslp

	movi	a_moon,a9
	movk	5,a0
	jsrp	framew
	jruc	moon_proc

a_moon	.long	MOONA1
	.long	MOONA2
	.long	MOONA3
	.long	MOONA4
	.long	MOONA5
	.long	MOONA6
	.long	MOONA7
	.long	MOONA8
	.long	MOONA9
	.long	MOONA10
	.long	MOONA11
	.long	MOONA12
	.long	MOONA13
	.long	MOONA14
	.long	MOONA15
	.long	MOONA16
	.long	MOONA17
	.long	MOONA18
	.long	MOONA19
	.long	MOONA20
	.long	MOONA21
	.long	MOONA22
	.long	MOONA23
	.long	MOONA24
	.long	MOONA25
	.long	MOONA26
	.long	MOONA27
	.long	MOONA28
	.long	0

**************************************************************************
*											     *
*  module: Bell 2										*
*											     *
**************************************************************************
bell2_mod
	.word	(32*32*0)+(32*0)+4	 	; autoerase color
	.word	000H				; initial world y
	.word	0f8H 				; ground y
	.word	400				; initial world x
	.word	0 	  			; scroll left limit
	.word	1200-scrrgt  			; scroll right limit
	.long	return				; routine to call
	.long	bell_scroll			; scroll table
	.long	dlists_bell

	.long	bak1mods
	.long	skip_bakmod 	 		; baklst1 =
	.long	skip_bakmod 	 		; baklst2 =
	.long	skip_bakmod 	 		; baklst3 =
	.long	skip_bakmod 	 		; baklst4 =
	.long	skip_bakmod 	 		; baklst5 =
	.long	skip_bakmod 	 		; baklst6 =
	.long	skip_bakmod 	 		; baklst7 =
	.long	MKTOWERBMOD			; baklst8 = the only plane
	.word	000H,-070H

	.long	center_x
	.long	MKTOWERBMOD,worldtlx8
	.long	0,0

**************************************************************************
*											     *
*  module: Bell											*
*											     *
**************************************************************************
bell_mod
	.word	(32*32*0)+(32*0)+4	 	; autoerase color
	.word	000H				; initial world y
	.word	0f8H	 			; ground y
	.word	400				; initial world x
	.word	0 	  			; scroll left limit
	.word	1200-scrrgt  			; scroll right limit

	.long	return				; routine to call
	.long	bell_scroll			; scroll table
	.long	dlists_bell

	.long	bak1mods
	.long	MKBELL1BMOD			; baklst1 =
	.word	000H,-030H
	.long	MKBELL2BMOD			; baklst2 =
	.word	000H,-031H
	.long	MKBELL3BMOD			; baklst3 =
	.word	000H,-011H
	.long	MKBELL4BMOD			; baklst4 =
	.word	000H,-030H
	.long	MKBELL5BMOD			; baklst5 =
	.word	000H,-050H
	.long	MKBELL6BMOD			; baklst6 =
	.word	000H,-036H
	.long	MKBELL7BMOD			; baklst7 =
	.word	038H,020H

	.long	center_x
	.long	MKBELL1BMOD,worldtlx1
	.long	MKBELL2BMOD,worldtlx2
	.long	MKBELL3BMOD,worldtlx3
	.long	MKBELL4BMOD,worldtlx4
	.long	MKBELL5BMOD,worldtlx5
	.long	MKBELL6BMOD,worldtlx6
	.long	MKBELL7BMOD,worldtlx7
	.long	0

	.long	FL_BELL	   	; sag
	.long	BELFLR_P   	; palette for floor
	.word	77	   	; floor height
	.long	scrollx2   	; which scroll variable to follow
	.long	skew_7


bell_scroll
	.long	0		; 8
	.long	04000H		; 7
	.long	08000H		; 6
	.long	0d000H		; 5
	.long	010000H		; 4
	.long	014000H		; 3 - back fence
	.long	018000H		; 2 - front fence
	.long	028000H		; 1 - bells
	.long	020000H		; player list

dlists_bell
	.long	baklst8,worldtlx8+16		; for bell2 use !!
	.long	baklst7,worldtlx7+16
	.long	baklst6,worldtlx6+16
	.long	baklst5,worldtlx5+16
	.long	baklst4,worldtlx4+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	baklst1,worldtlx1+16

	.long	-1,floor_code
	.long	-1,shadow_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

**************************************************************************
*											     *
*   Ladder										     *
*											     *
**************************************************************************
ladder_mod
	.word	0		 		; autoerase color
	.word	000H				; initial world y
	.word	000H	     			; ground y
	.word	000H				; initial worldx
	.word	-0500H 	  			; scroll left limit
	.word	0500H	  			; scroll right limit

	.long	return
	.long	no_scroll			; scroll table
	.long	dlists_ladder
	.long	bak1mods
	.long	skip_bakmod 	 		; baklst1 = lightning
	.long	skip_bakmod 	 		; baklst2 =
	.long	skip_bakmod 	 		; baklst3 =
	.long	skip_bakmod 	 		; baklst4 =
	.long	skip_bakmod 	 		; baklst5 =

	.long	LADDERBMOD			; baklst6
	.word	000H,000H
	.long	0ffffffffH
	.long	0				; no floor here !!


dlists_ladder
	.long	baklst6,worldtlx+16
	.long	baklst5,worldtlx+16
	.long	baklst4,worldtlx+16
	.long	baklst3,worldtlx+16		; mugs in front of stone !
	.long	baklst2,worldtlx+16

	.long	objlst,worldtlx+16
	.long	baklst1,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0


mk3_calla
	create	pid_bani,portal_zap
	rets

	movi	MKBRICK,a5
	calla	gso_dmawnz_ns
	calla	center_obj_x
	movi	060H,a0
	move	a0,*a8(oypos),w
	calla	insobja8
	create	pid_fx,brick_scale
	rets

portal_zap
	movi	PORTAL01,a5
	movi	0005c00b0H,a4
	calla	gso_dmawnz_coor
	movi	baklst1,b4
	move	a8,a0
	calla	insobj_v
	
pzap3	movi	a_portal_zap,a9
	movk	3,a0
	jsrp	framew
	move	*a8(oypos),a11,w
	movi	04000H,a0
	move	a0,*a8(oypos),w
	sleep	030H
	move	a11,*a8(oypos),w
	jruc	pzap3

a_portal_zap
	.long	PORTAL01
	.long	PORTAL02
	.long	PORTAL03
	.long	PORTAL04
	.long	PORTAL05
	.long	PORTAL06
	.long	PORTAL07
	.long	PORTAL08
	.long	PORTAL09
	.long	PORTAL11
	.long	PORTAL12
	.long	PORTAL13
	.long	PORTAL14
	.long	PORTAL17
	.long	0

**************************************************************************
*											     *
*  Vs screen module									     *
*											     *
**************************************************************************
vs_mod
	.word	0		 		; autoerase color
	.word	000H				; initial world y
	.word	000H	     			; ground y
	.word	000H				; initial worldx
	.word	-0500H 	  			; scroll left limit
	.word	0500H	  			; scroll right limit

	.long	return
	.long	no_scroll			; scroll table
	.long	dlists_bogus
	.long	bak1mods

	.long	STEELMODBMOD
	.word	000H,007H
	.long	0ffffffffH
	.long	0				; no floor here !!

**************************************************************************
*											     *
*  module: player select screen									*
*											     *
**************************************************************************
psel_mod
	.word	0ffH	 	 	; autoerase color

	.word	0	 		; initial world y
	.word	0edH	 		; ground y
	.word	0			; initial worldx
	.word	-050H 	  		; scroll left limit
	.word	0fffH	  		; scroll right limit

	.long	return
	.long	no_scroll		; scroll table
	.long	dlists_psel

	.long	bak1mods
	.long	MKSELECTBMOD
	.word	0,0
	.long	0ffffffffH
	.long	0

dlists_psel
	.long	baklst1,worldtlx+16
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

**************************************************************************
*											     *
*  module: bridge										*
*											     *
**************************************************************************
bridge_mod
	.word	(32*32*4)+(32*2)+0 	; autoerase color
	.word	000H    		   	; initial world y
	.word	0f7H		   	; ground y offset
	.word	400		   	; initial world x
	.word	0+4 	  	   	; scroll left limit
	.word	1200-scrrgt-4  	   	; scroll right limit

	.long	bridge_calla
	.long	bridge_scroll	  	; scroll table
	.long	dlists_bridge

	.long	bak1mods
	.long	BRIDGE1BMOD	  	; baklst1 = bridge
	.word	000H,-02bH
	.long	BRIDGE2BMOD	  	; baklst2 = buildings
	.word	0120H,-00dH
	.long	BRIDGE3BMOD	  	; baklst3 = sky
	.word	019cH,011H

	.long	center_x
	.long	BRIDGE1BMOD,worldtlx1
	.long	BRIDGE1BMOD,worldtlx4
	.long	0

bridge_floor_info
	.long	FL_BRIDG  	   	; sag
	.long	BRGRD_P		   	; palette for floor
	.word	50
	.long	scrollx1
	.long	skew_7

bridge_scroll
	.long	0		; 8
	.long	0		; 7
	.long	0		; 6
	.long	0		; 5
	.long	0		; 4 - papers (this follows scroll1)
	.long	0		; 3 - far buildings and sky
	.long	08000H		; 2 - close buildings
	.long	01a000H		; 1 - bridge wall
	.long	020000H		; 0 - players

dlists_bridge
;	.long	-1,use_next_y,worldtly3
	.long	baklst3,worldtlx3+16

;	.long	-1,use_next_y,worldtly2
	.long	baklst2,worldtlx2+16

;	.long	-1,use_next_y,worldtly1
	.long	baklst1,worldtlx1+16

	.long	-1,floor_code
	.long	-1,shadow_code

;	.long	-1,use_next_y,worldtly1
	.long	baklst4,worldtlx1+16		; draw papers 1st

	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

bridge_calla
	create	pid_bani,wind_sound

	movk	2,a5
brc2	movi	a_big_paper,a9
	create	pid_bani,garbage_straight
	movi	a_lil_paper,a9
	create	pid_bani,garbage_straight
	movi	a_leaf,a9
	create	pid_bani,garbage_straight
	create	pid_bani,garbage_straight
	create	pid_bani,garbage_straight

	movi	a_big_paper,a9
	create	pid_bani,garbage_loop
	movi	a_lil_paper,a9
	create	pid_bani,garbage_loop
	dsj	a5,brc2
*
	movi	paper_table,a6
	jruc	create_dumb_animators_w	; animating stationary newspapers


wind_sound
	tsound	005H				; wind sound
	sleep	0c8H
	jruc	wind_sound


garbage_straight
	callr	get_paper_object
simp4	callr	paper_start_position
	callr	paper_glide
	callr	paper_glide
	clr	a1				; dx
	clr	a2	 			; dy
	jsrp	paper_fly_offscreen
	jruc	simp4


garbage_loop
	callr	get_paper_object

ploop1	callr	paper_start_position
	callr	paper_glide

	movi	-02800H,a10			; dy
ploop2	movi	-04000H,a1			; dx
	move	*a8(oxvel),a0,l
	abs	a0
	cmpi	08000H,a0
	jrhi	ploop3
	movi	05000H,a10			; reached peak ---> head downwards
ploop3	move	a10,a2
	callr	paper_loop_sleep
	cmpi	-020000H,a1
	jrgt	ploop2

ploop4	movi	03000H,a1			; dx
	movi	03000H,a2			; dy
	callr	paper_loop_sleep

	cmpi	030000H,a2
	jrlt	ploop5
	movi	030000H,a2
ploop5
	cmpi	030000H,a1
	jrlt	ploop4

	movi	03000H,a1			; dx
	movi	-02000H,a2			; dy
	jsrp	paper_fly_offscreen
	jruc	ploop1				; offscreen = start over agin !


paper_fly_offscreen
	move	a1,*a13(p_store1),w
	move	a2,*a13(p_store2),w

pfo4	move	*a13(p_store1),a1,w
	move	*a13(p_store2),a2,w
	callr	paper_loop_sleep
	calla	next_anirate
	move	@worldtlx1+16,a1,w
	addi	scrrgt,a1			; a1 = right edge
	move	*a8(oxpos),a0,w			; a0 = obj position
	cmp	a1,a0
	jrlt	pfo4		 		; on screen = loopy
	retp


paper_loop_sleep
	move	*a8(oyvel),a0,l
	add	a2,a0
	move	a0,*a8(oyvel),l
	move	*a8(oxvel),a0,l
	add	a1,a0
	move	a0,*a8(oxvel),l

	pull	a11			; return address
	sleep	1
	calla	next_anirate

	move	*a8(oxvel),a1,l
	move	*a8(oyvel),a2,l
	jump	a11			; return


paper_glide
	pull	a11
	movi	020000H,a0
	calla	srand
	subi	04000H,a0		; nudge things up
	move	a0,*a8(oyvel),l

	movi	020H,a0
	movi	008H,a1
	calla	randu_minimum
	move	a0,a10
glid3	sleep	1
	calla	next_anirate
	dsj	a10,glid3
	jump	a11			; return

;******************

get_paper_object
	pull	a11

	movi	030H,a0
	calla	randu
	calla	prcslp

	movk	4,a0
	calla	init_anirate
	move	*a9,a5,l
	calla	gso_dmawnz
	movi	baklst4,b4
	move	a8,a0
	calla	insobj_v   		; on baklst 4 !!
	jump	a11


paper_start_position
	movi	00000fff0H,a4
	movi	040H,a0				; this range !!
	movi	080H,a1				; at least this low on the screen
	calla	randu_minimum			; a1 = randomness #
	sll	16,a0				; random starting y position
	addxy	a0,a4
	callr	a4_to_world_coor		; and rets

	movi	040000H,a0
	movi	040000H,a1
	calla	randu_minimum
	move	a0,*a8(oxvel),l			; random starting vel
	rets

a4_to_world_coor
	move	@worldtlx1+16,a0,w
	move	@worldtly+16,a1,w
	sll	16,a1
	or	a0,a1
	addxy	a1,a4				; a4 = coordinate for obj
	calla	set_xy_coordinates
	rets


dumb_animator
	move	a9,a11
	move	a10,a0
	jsrp	framew				; single object animator !!
	move	a11,a9
	jruc	dumb_animator

paper_table
	.word	3						; animation speed
	.long	PAPER1,000b0ffb0H,a_paper1,baklst4	; image, coordinates
	.word	4						; animation speed
	.long	PAPER1,000b00050H,a_paper1,baklst4	; image, coordinates
	.word	3						; animation speed
	.long	PAPER1,000b40100H,a_paper1,baklst4	; image, coordinates
	.word	5						; animation speed
	.long	PAPER1,000ad01d0H,a_paper1,baklst4	; image, coordinates
	.word	4						; animation speed
	.long	PAPER1,000b002a0H,a_paper1,baklst4	; image, coordinates
	.word	0

a_paper1	.long	PAPER1
	.long	PAPER2
	.long	PAPER3
	.long	PAPER4
	.long	PAPER5
	.long	PAPER6
	.long	PAPER7
	.long	PAPER8
	.long	PAPER9
	.long	0


a_big_paper
	.long	LGSHEET1
	.long	LGSHEET2
	.long	LGSHEET3
	.long	LGSHEET4
	.long	LGSHEET5
	.long	LGSHEET6
	.long	LGSHEET7
	.long	LGSHEET8
	.long	LGSHEET9
	.long	ani_jump,a_big_paper

a_lil_paper
	.long	SMSHEET1
	.long	SMSHEET2
	.long	SMSHEET3
	.long	SMSHEET4
	.long	SMSHEET5
	.long	SMSHEET6
	.long	SMSHEET7
	.long	SMSHEET8
	.long	SMSHEET9
	.long	ani_jump,a_lil_paper

a_leaf	.long	LEAF1
	.long	LEAF2
	.long	LEAF3
	.long	LEAF4
	.long	LEAF5
	.long	LEAF6
	.long	LEAF7
	.long	LEAF8
	.long	ani_jump,a_leaf

**************************************************************************
*											     *
*  module: NO WALL TOWER										*
*											     *
**************************************************************************
nowall_mod
 	.word	000H		 	; autoerase color
	.word	000H    			; initial world y
	.word	0f7H			; ground y offset
	.word	400			; initial world x
	.word	0 	  		; scroll left limit
	.word	1200-scrrgt  		; scroll right limit
	.long	return
	.long	tower_scroll	  	; scroll table
	.long	dlists_tower

	.long	bak1mods

;	.long	BALCONY1BMOD	  	; baklst1 = front walls
;	.word	000H,-011H
	.long	skip_bakmod 		; baklst1 = skip (see through)

	.long	BALCONY2BMOD	  	; baklst2 = 2 side walls
	.word	000H,000H
	.long	BALCONY3BMOD	  	; baklst3 = well
	.word	000H,07bH
	.long	BALCONY4BMOD	  	; baklst4 = pillars
	.word	000H,012H
	.long	BALCONY5BMOD	  	; baklst5 = distant candles
	.word	000H,045H

	.long	center_x
	.long	BALCONY1BMOD,worldtlx1
;	.long	BALCONY1BMOD,worldtlx6	; torch

	.long	BALCONY2BMOD,worldtlx2
	.long	BALCONY3BMOD,worldtlx3
	.long	BALCONY4BMOD,worldtlx4
	.long	BALCONY5BMOD,worldtlx5
	.long	0

	.long	FL_BALC      	; sag
	.long	BALCO_P	     	; palette for floor
	.word	75
	.long	scrollx1
	.long	skew_7

**************************************************************************
*											     *
*  module: tower											*
*											     *
**************************************************************************
tower_mod
 	.word	000H		 	; autoerase color
	.word	000H    			; initial world y
	.word	0f7H			; ground y offset
	.word	400			; initial world x
	.word	0 	  		; scroll left limit
	.word	1200-scrrgt  		; scroll right limit

	.long	tower_calla
	.long	tower_scroll	  	; scroll table
	.long	dlists_tower

	.long	bak1mods
	.long	BALCONY1BMOD	  	; baklst1 = front walls
	.word	000H,-011H
	.long	BALCONY2BMOD	  	; baklst2 = 2 side walls
	.word	000H,000H
	.long	BALCONY3BMOD	  	; baklst3 = well
	.word	000H,07bH
	.long	BALCONY4BMOD	  	; baklst4 = pillars
	.word	000H,012H
	.long	BALCONY5BMOD	  	; baklst5 = distant candles
	.word	000H,045H

	.long	center_x
	.long	BALCONY1BMOD,worldtlx1
;	.long	BALCONY1BMOD,worldtlx6	; torch

	.long	BALCONY2BMOD,worldtlx2
	.long	BALCONY3BMOD,worldtlx3
	.long	BALCONY4BMOD,worldtlx4
	.long	BALCONY5BMOD,worldtlx5
	.long	0

	.long	FL_BALC      	; sag
	.long	BALCO_P	     	; palette for floor
	.word	75
	.long	scrollx1
	.long	skew_7

tower_scroll
	.long	0		; 8
	.long	0		; 7
	.long	0		; 6
	.long	04000H		; 5
	.long	08000H		; 4
	.long	0c000H		; 3
	.long	010000H		; 2
	.long	016000H		; 1
	.long	020000H		; 0

tower_calla
	movi	torch_table,a6
	jruc	create_dumb_animators	; animating stationary newspapers

torch_table
	.word	5				; animation speed
	.long	0004e00c3H,a_torch,baklst8	; image, coordinates
	.word	5				; animation speed
	.long	0004e0310H,a_torch,baklst8	; image, coordinates
	.word	0

dlists_tower
	.long	baklst5,worldtlx5+16
	.long	baklst4,worldtlx4+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	-1,floor_code
	.long	baklst1,worldtlx1+16
	.long	baklst8,worldtlx1+16		; torch
	.long	-1,shadow_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

a_torch	.long	BALFIRE1
	.long	BALFIRE2
	.long	BALFIRE3
	.long	BALFIRE4
	.long	BALFIRE5
	.long	BALFIRE6
	.long	ani_jump,a_torch

brick_scale
	move	a9,*a8(oscale),l	; start off real small
	move	*a5(isizex),a11,w
	sll	8,a11			; shift for the formula
	move	*a5(isizey),a10,w
	sll	8,a10			; shift for the formula
	movi	003000300H,a9
	callr	center_scaled
*
* grow loop
*
grow3	move	a9,*a8(oscale),l	; start off real small
	callr	center_scaled
	sleep	1
	subi	000080008H,a9
	cmpi	001000100H,a9
	jrne	grow3
	move	a9,*a8(oscale),l	; full size !
	calla	center_obj_x

	sleep	040H

*
* shrink loop
*
	movi	001000100H,a9
grow7	move	a9,*a8(oscale),l	; start off real small
	callr	center_scaled
	sleep	1
	addi	000080008H,a9
	cmpi	003000300H,a9
	jrne	grow7
	move	a9,*a8(oscale),l	; full size !

	sleep	040H

	jruc	grow3



center_scaled
	move	a11,a1
	move	a9,a3
	zext	a3,w			; only look at x
	divs	a3,a1			; a1 = new scaled x size
	movi	scrrgt/2,a2
	srl	1,a1			; 1/2 of x size
	sub	a1,a2			; center the image on the screen
	move	a2,*a8(oxpos),w

	move	a10,a1
	move	a9,a3
	srl	16,a3			; only look at y
	divs	a3,a1			; a1 = new scaled x size
	movi	(scrbot/2)-030H,a2
	srl	1,a1			; 1/2 of x size
	sub	a1,a2			; center the image on the screen
	move	a2,*a8(oypos),w
	rets

**************************************************************************
*											     *
*  module: street										*
*											     *
**************************************************************************
street_mod
	.word	000H			; background color
	.word	000H	  		; initial world y
	.word	0f6H	  		; ground y offset
	.word	400	  		; initial world x
	.word	0 	  		; scroll left limit
	.word	1200-scrrgt		; scroll right limit

	.long	street_calla
	.long	street_scroll	  	; scroll table
	.long	dlists_street

	.long	bak1mods
	.long	street1BMOD	  	; baklst1 =
	.word	000H,-012H
	.long	street2BMOD	  	; baklst2 =
	.word	000H,0a5H
	.long	street3BMOD	  	; baklst3 =
	.word	000H,-093H
	.long	skip_bakmod 		; baklst4 = 
	.long	street4BMOD	  	; baklst5 =
	.word	000H,-009H+01cH

	.long	center_x
	.long	street1BMOD,worldtlx1
	.long	street2BMOD,worldtlx2
	.long	street3BMOD,worldtlx3
	.long	street4BMOD,worldtlx5
	.long	0

street_floor_info
	.long	FL_STRT		   	; sag
	.long	STREET_P	   	; palette for floor
	.word	51			; skew height
	.long	scrollx1		; which scroll variable to follow
	.long	skew_7

street_scroll
	.long	0 		; 8
	.long	0 		; 7
	.long	0		; 6
	.long	0		; 5
	.long	0		; 4
	.long	010000H		; 3
	.long	014000H		; 2
	.long	01a000H		; 1
	.long	020000H		; player object list

dlists_street
;	.long	-1,use_next_y,worldtly6
	.long	baklst6,worldtlx6+16

;	.long	-1,use_next_y,worldtly5
	.long	baklst5,worldtlx5+16

;	.long	-1,use_next_y,worldtly3
	.long	baklst3,worldtlx3+16

;	.long	-1,use_next_y,worldtly2
	.long	baklst2,worldtlx2+16

	.long	-1,floor_code

;	.long	-1,use_next_y,worldtly1
	.long	baklst1,worldtlx1+16

;	.long	-1,use_next_y,worldtly1
	.long	baklst4,worldtlx1+16

;  	.long	-1,use_next_y,worldtly
	.long	-1,shadow_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

street_calla
	create	pid_bani,storm_proc
	jruc	bridge_calla

storm7_proc
	movi	STORM01,a5
	movi	0fff000a8H,a4
	calla	gso_dmawnz_coor
	movi	baklst7,b4
	jruc	storm3

storm_proc
	movi	STORM01,a5
	movi	0fff301ffH,a4
	calla	gso_dmawnz_coor
	movi	baklst6,b4
storm3	move	a8,a0
	calla	insobj_v		; candle
	movi	a_storm,a9
	movk	6,a0
	jsrp	framew

a_storm
	.long	STORM01
	.long	STORM02
	.long	STORM03
	.long	STORM04
	.long	STORM05
	.long	STORM06
	.long	STORM07
	.long	STORM08
	.long	STORM09
	.long	STORM10
	.long	STORM11
	.long	STORM12
	.long	ani_jump,a_storm

**************************************************************************
*											     *
*  module: temple										*
*											     *
**************************************************************************
temple_mod
	.word	000H			; background color
	.word	000H	  		; initial world y
	.word	0f6H	  		; ground y offset
	.word	400	  		; initial world x
	.word	0 	  		; scroll left limit
	.word	1200-scrrgt		; scroll right limit

	.long	temple_calla
	.long	temple_scroll	  	; scroll table
	.long	dlists_temple

	.long	bak1mods
	.long	temple1BMOD	  	; baklst1 =
	.word	000H,07dH
	.long	temple2BMOD	  	; baklst2 =
	.word	010fH,058H
	.long	temple3BMOD	  	; baklst3 =
	.word	000H,-00bH
	.long	temple4BMOD	  	; baklst4 =
	.word	000H,008H
	.long	temple0BMOD	  	; baklst5 =
	.word	000H,0d4H

	.long	center_x
	.long	temple1BMOD,worldtlx1
	.long	temple3BMOD,worldtlx3
	.long	temple4BMOD,worldtlx4
	.long	temple0BMOD,worldtlx5
	.long	temple2BMOD,worldtlx7
	.long	0


temple_floor_info
	.long	FL_TEMP		   	; sag
	.long	templfl_p	   	; palette for floor
	.word	54			; skew height
	.long	scrollx1		; which scroll variable to follow
	.long	skew_7

temple_calla
	movk	10,a10
	movi	-1,a11

candd	movi	KANDLE1,a5
	movi	RCANDLE_P,a6
	calla	gso_dmawnz

	move	a11,*a8(oxpos),w
	movi	0b8H,a0
	move	a0,*a8(oypos),w
	movi	baklst6,b4
	move	a8,a0
	calla	insobj_v		; candle
*
* flame
*
	move	a8,a9
	movi	wik1,a5
	calla	gso_dmawnz
	movi	baklst6,b4
	move	a8,a0
	calla	insobj_v

	move	*a9(oxpos),a0,w
	addi	7,a0
	move	a0,*a8(oxpos),w
	move	*a9(oypos),a0,w
	subk	12,a0
	move	a0,*a8(oypos),w

	create	pid_bani,candle_flame

	addi	096H,a11
	dsj	a10,candd

	movi	tony_candle_table,a6
	callr	create_dumb_animators
	rets

tony_candle_table
	.word	4				  	; animation speed
	.long	00027010fH,a_tflame,baklst7	; coordinates animation
	.word	4				  	; animation speed
	.long	0002701a4H,a_tflame,baklst7	; coordinates animation
	.word	4|08000H				  	; animation speed
	.long	00027030fH,a_tflame,baklst7	; coordinates animation
	.word	4|08000H				  	; animation speed
	.long	0002703a4H,a_tflame,baklst7	; coordinates animation
	.word	0


a_tflame
	.long	SKTORCH1
	.long	SKTORCH2
	.long	SKTORCH3
	.long	SKTORCH4
	.long	SKTORCH5
	.long	SKTORCH6
	.long	ani_jump,a_tflame


candle_flame
	movk	10,a0
	calla	randu
	calla	prcslp
	movi	a_candle_flame,a9
	movk	2,a0
	calla	randu
	addk	3,a0
	jsrp	framew
	jauc	wait_forever

a_candle_flame
	.long	wik1
	.long	wik2
	.long	wik3
	.long	wik4
	.long	ani_jump,a_candle_flame


temple_scroll
	.long	0 		; 8
	.long	0		; 7 - tony flame
	.long	0		; 6 - vogel flame
	.long	028000H		; 5 - candle

	.long	0a000H		; 4
	.long	010000H		; 3
	.long	014000H		; 2
	.long	016000H		; 1 - this matches the floor
	.long	020000H		; 0 - player object list

dlists_temple
;	.long	-1,use_next_y,worldtly4
	.long	baklst4,worldtlx4+16

;	.long	-1,use_next_y,worldtly3
	.long	baklst3,worldtlx3+16

;	.long	-1,use_next_y,worldtly2
	.long	baklst7,worldtlx2+16		; tony flames

;	.long	-1,use_next_y,worldtly2
	.long	baklst2,worldtlx2+16

	.long	-1,floor_code
	.long	-1,shadow_code

;	.long	-1,use_next_y,worldtly1
	.long	baklst1,worldtlx1+16

	.long	objlst,worldtlx+16

;	.long	-1,use_next_y,worldtly5
	.long	baklst5,worldtlx5+16

;	.long	-1,use_next_y,worldtly5
	.long	baklst6,worldtlx5+16
	.long	objlst2,worldtlx+16
	.long	0

**************************************************************************
*											     *
*  module: bank											*
*											     *
**************************************************************************
bank_mod
	.word	0
	.word	0				; initial world y
	.word	0f7H		  		; ground y offset
	.word	400				; initial world x
	.word	0 	  			; scroll left limit
	.word	1200-scrrgt  			; scroll right limit

	.long	return
	.long	bank_scroll			; scroll table
	.long	dlists_bank

	.long	bak1mods
	.long	BANK1BMOD			; baklst1 = wall / windows
	.word	000H,-013H-040H
	.long	BANK2BMOD			; baklst2 = sky line
	.word	000H,055H-040H

	.long	center_x
	.long	BANK1BMOD,worldtlx1
	.long	BANK2BMOD,worldtlx2
	.long	0

	.long	FL_CITY			   	; sag
	.long	CITYFLR_P   			; palette for floor
	.word	50
	.long	scrollx1
	.long	skew_7


bank_scroll
	.long	0 		; 8
	.long	0		; 7
	.long	0		; 6
	.long	0		; 5
	.long	0		; 4
	.long	0		; 3
	.long	0		; 2 - sky line
	.long	018000H		; 1 - marble pillars / such
	.long	020000H		; 0 - players

dlists_bank
;	.long	-1,use_next_y,worldtly2
	.long	baklst2,worldtlx2+16
	.long	-1,floor_code
;	.long	-1,use_next_y,worldtly1
	.long	baklst1,worldtlx1+16
	.long	-1,shadow_code
	.long	-1,use_next_y,worldtly 
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

**************************************************************************
*											     *
*  module: roof											*
*											     *
**************************************************************************
roof_mod
 	.word	000H			 	; autoerase color
	.word	000H				; initial world y
	.word	0f7H		  		; ground y offset
	.word	400				; initial world x
	.word	0 	  			; scroll left limit
	.word	1200-scrrgt  			; scroll right limit

	.long	roof_calla			; routine to call

	.long	city_scroll			; scroll table
	.long	dlists_roof
	.long	bak1mods
	.long	mkcity1BMOD			; baklst1 = gargoyles

	.word	000H,03bH-040H
	.long	mkcity2BMOD			; baklst2 = wall

	.word	000H,0c2H-040H
	.long	mkcity3BMOD			; baklst3 = background city
	.word	000H,09cH-040H
	.long	skip_bakmod 	 		; baklst4 = fire animation
	.long	mkcity4BMOD			; baklst5 = background city
	.word	000H,044H-040H
	.long	mkcity5BMOD			; baklst6 = background city
	.word	000H,06dH-040H

	.long	center_x
	.long	mkcity1BMOD,worldtlx1
	.long	mkcity2BMOD,worldtlx2
	.long	mkcity3BMOD,worldtlx3
	.long	mkcity4BMOD,worldtlx4
	.long	mkcity4BMOD,worldtlx5
	.long	mkcity5BMOD,worldtlx6
	.long	mkcity5BMOD,worldtlx7
	.long	0

	.long	FL_CITY	   			; sag
	.long	CITYFLR_P   			; palette for floor
	.word	50				; floor height
	.long	scrollx2			; which scroll variable to follow
	.long	skew_7

roof_calla
	create	pid_bani,storm7_proc
	movi	burn_table,a6
	jruc	create_dumb_animators	; animating stationary newspapers

burn_table
	.word	5				; animation speed
	.long	000560043H,a_burn,baklst4	; image, coordinates
	.word	0

a_burn	.long	BURNING1
	.long	BURNING2
	.long	BURNING3
	.long	BURNING4
	.long	BURNING5
	.long	BURNING6
	.long	BURNING7
	.long	BURNING8
	.long	ani_jump,a_burn

city_scroll
	.long	0 		; 8
	.long	0		; 7
	.long	0		; 6
	.long	08000H		; 5
	.long	08000H		; 4
	.long	010000H		; 3
	.long	018000H		; 2 - gargoyles
	.long	01d000H		; 1 - back wall	
	.long	020000H		; player list

dlists_roof
	.long	baklst7,worldtlx5+16
	.long	baklst6,worldtlx6+16
	.long	baklst5,worldtlx4+16
	.long	baklst4,worldtlx4+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	-1,floor_code
	.long	baklst1,worldtlx1+16
	.long	-1,shadow_code
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0

**************************************************************************
*											     *
*  module: subway										*
*											     *
**************************************************************************
subway_mod
 	.word	0			 	; autoerase color

	.word	000H    				; initial world y
	.word	0f7H		  		; ground y offset
	.word	400				; initial world x
	.word	0 	  			; scroll left limit
	.word	1200-scrrgt  			; scroll right limit

	.long	calla_subway
	.long	subway_scroll			; scroll table
	.long	dlists_subway

	.long	bak1mods
	.long	skip_bakmod			; baklst1 = skip (gleam)
	.long	skip_bakmod			; baklst2 = skip (gleam)
	.long	skip_bakmod			; baklst3 = skip (rails)
	.long	skip_bakmod			; baklst4 = lit / unlit images

	.long	SUBWAY1BMOD			; baklst5 = front plane / pillars
	.word	000H,-028H

	.long	skip_bakmod			; baklst6 = train

	.long	SUBWAY2BMOD			; baklst7 = blurry back wall
	.word	000H,028H

	.long	center_x
	.long	SUBWAY1BMOD,worldtlx1	; gleam
	.long	SUBWAY1BMOD,worldtlx2	; gleam
	.long	SUBWAY1BMOD,worldtlx4	; lit/unlit
	.long	SUBWAY1BMOD,worldtlx5	; front plane
	.long	SUBWAY2BMOD,worldtlx7	; blurry back wall
	.long	0

	.long	FL_SUB	   			; sag
	.long	SUBFLR_P  		 	; palette for floor
	.word	85				; floor height
	.long	scrollx5			; which scroll variable to follow
	.long	skew_7


subway_scroll
	.long	0		; 8
	.long	08000H		; 7 - back
	.long	0		; 6 - train
	.long	014000H		; 5 - front
	.long	014000H		; 4 - lit/unlit images
	.long	0 		; 3 - rails
	.long	014000H		; 2 - gleams of light #2
	.long	014000H		; 1 - gleams of light #1
	.long	020000H		; player list

dlists_subway
	.long	baklst7,worldtlx7+16		; blurry wall
	.long	baklst6,worldtlx6+16		; train
	.long	baklst4,worldtlx4+16		; lit / unlit
	.long	baklst5,worldtlx5+16		; front / pillars
	.long	-1,floor_code
	.long	-1,shadow_code
	.long	baklst3,worldtlx3+16		; rails
	.long	baklst2,worldtlx2+16		; gleam
	.long	baklst1,worldtlx1+16		; gleam
	.long	objlst,worldtlx+16		; players
 	.long	objlst2,worldtlx+16		; text
	.long	0

calla_subway
	movi	BACKRAIL,a5
;	calla	gso_dmawnz
	calla	gbo_dmawnz
	movi	000ac0190H,a4
	calla	set_xy_coordinates
	movi	baklst3,b4
	move	a8,a0
	calla	insobj_v

	movi	FRONTRAIL,a5
;	calla	gso_dmawnz
	calla	gbo_dmawnz

	movi	000c10190H,a4
	calla	set_xy_coordinates
	movi	baklst3,b4
	move	a8,a0
	calla	insobj_v
*
* gleams 'o' light on the tracks
*
	movk	3,a9				; # of gleams
	movi	000ac0180H,a4			; 1st coordinate
gleam2	push	a4
	movi	baklst1,b4
	callr	make_a_gleam
	move	*sp,a4,l		; pull coordinate
	addi	000150000H,a4		; down to the lower rail
	movi	baklst1,b4
	callr	make_a_gleam
	pull	a4
	addi	0e0H*2,a4 		; move under the next lamp
	dsj	a9,gleam2

	movk	2,a9			; # of gleams
	movi	000ac0260H,a4		; 1st coordinate
gleam3	push	a4
	movi	baklst2,b4
	callr	make_a_gleam
	move	*sp,a4,l		; pull coordinate
	addi	000150000H,a4		; down to the lower rail
	movi	baklst2,b4
	callr	make_a_gleam
	pull	a4
	addi	0e0H*2,a4 		; move under the next lamp
	dsj	a9,gleam3
*
* lights on  /  lights off
*
	movi	lit_object_table,a0
	callr	get_lit_list
	move	a0,a10			; a10 = lit objects
	move	a10,@baklst4,l 		; on the list

	movi	unlit_object_table,a0
	callr	get_lit_list
	move	a0,a11			; a11 = unlit objects
	create	pid_bani,light_proc
;	create	pid_bani,train_proc	; choo choo train
	rets

make_a_gleam
	push	a4
	movi	RAILGLEAM,a5
	calla	gbo_dmawnz
	pull	a4
	calla	set_xy_coordinates
	move	a8,a0
	jauc	insobj_v

;************************************************************************

train_proc

;	movi	040H*2,a0	
;	calla	randu
;	addi	040H*2,a0
;	calla	prcslp

	clr	a9	       		; a9 = previous train piece
	movi	train_table,a11
train3	move	*a11+,a5,w     		; grab image offset
	jrne	train2

	clr	a11   			; flag: all train pieces are put on !!
	jruc	train5

train2	dec	a5
	sll	5,a5
	addi	train_pieces,a5
	move	*a5,a5,l
;	calla	gso_dmawnz_ns
	calla	gbo_dmawnz

;*************
;	calla	set_noscroll
;*************

	move	*a11+,a7,w     		; grab x coordinate

;***********
	move	a9,a9
	jrne	train1
	move	@worldtlx6+16,a0,w	; 1st = xlate to screen coorinates
	add	a0,a7
train1
;***********

	move	*a11+,a0,w     		; flip ?
	jreq	train4

	calla	flip_single

train4	move	a9,a9	       		; previous piece ?
	jreq	train6	       		; no, just set coordinates

	move	*a9(oxpos),a0,w
	sub	a7,a0
	move	a0,a7	       		; yes, use as an offset

train6	move	a7,*a8(oxpos),w

	movi	02aH,a0
	move	a0,*a8(oypos),w		; same y for all pieces
	movi	060000H,a0
	move	a0,*a8(oxvel),l		; train speed

	move	a8,a0
	movi	baklst6,b4
	calla	insobj_v
*
* delete loop
*
train5	sleep	1

	move	@baklst6,a0,l
;	jreq	train_proc		; empty list ----> we are done
	jaeq	sucide


train7	move	*a0,a2,l   		; peek ahead
	jreq	train8			; last piece ---> exit
	move	a0,a1
	move	a2,a0
	jruc	train7

train8
;	move	*a0(oxpos),a3,w
	callr	get_train_screen_x

	cmpi	scrrgt,a3		; off the right of the screen ?
	jrlt	traina			; no

	movi	baklst6,a4
	calla	delobj_lista4

traina 
;	move	*a8(oxpos),a0,w
	move	a8,a0
	callr	get_train_screen_x
	move	a3,a0

	cmpi	-010H,a0	   		; time for a new piece ??
	jrlt	train5	   		; no
	move	a8,a9	   		; yes, a9 = previous piece
	move	a11,a11
	jreq	train5
	jruc	train3



get_train_screen_x
	move	*a0(oxpos),a3,w
	move	@worldtlx6+16,a4,w
	sub	a4,a3
	rets


trainx	.set	-050H

train_table
	.word	1,trainx,1
	.word	2,051H,1
	.word	3,064H,1
	.word	3,064H,0
	.word	2,051H,0
	.word	1,05cH,0

	.word	1,05cH,1
	.word	2,051H,1
	.word	3,064H,1
	.word	3,064H,0
	.word	2,051H,0
	.word	1,05cH,0
	.word	0

train_pieces
	.long	TRAINA
	.long	TRAINB
	.long	TRAINC

**************************************************************************
*											     *
*  light_proc										     *
* 											     *
*  a10 = lit list									     *
*  a11 = unlit list									     *
*											     *
**************************************************************************
light_proc
	sleep	040H				; let the fade happen

	move	@baklst1,a9,l			; a9 ---> gleam object list

lproc2	movk	5,a0
lproc3	move	a0,*a13(p_anicount),w
	move	a10,a8
	jsrp	fast_sleep
	move	a11,a8
	jsrp	fast_sleep

	move	*a13(p_anicount),a0,w
	dsj	a0,lproc3
*
* lights on !!
*
	move	a9,@baklst1,l			; gleam list = on
	move	a10,@baklst4,l			; background list = on

	movi	020H,a0
	calla	randu
	addi	020H,a0
	calla	prcslp
	jruc	lproc2


fast_sleep
	clr	a2				; assume gleam list "off"
	cmp	a8,a10				; lights on ?
	jrne	fast5				; no
	move	a9,a2				; gleam list "on"
fast5
	move	a2,@baklst1,l

	movk	5,a0
	calla	randu
	addk	2,a0

lslp	move	a8,@baklst4,l			; on the list
	calla	prcslp

	retp

;**************************************************************************

get_lit_list
	move	@ofree,a1,l
	push	a1

	clr	a9
lit3	move	*a0+,a5,l			; oimg
	jreq	lit4
	move	*a0+,a6,l			; pal
	move	*a0+,a4,l			; coordinates

;	addi	wy_sub*010000H,a4

	mmtm	sp,a0,a4
	calla	gso_dmawnz
;	calla	gbo_dmawnz

	mmfm	sp,a0,a4
	calla	set_xy_coordinates
	move	*a0+,a4,l			; flip ?
	jreq	lit5				; sans
	calla	flip_single			; yes, flip it

lit5	push	a0
	move	a8,a0
	
	move	a9,a9
	jreq	lit7
	move	a8,*a9(olink),l			; tack on the end
lit7	move	a8,a9
	pull	a0
	jruc	lit3

lit4   	clr	a0
	move	a0,*a9(olink),l
	pull	a0
	rets

unlit_object_table
	.long	DARK1,P_DARK1,0001d0154H,0
	.long	DARK2,P_DARK1,0001d01c2H,0
	.long	DARK6,P_DARK6,000840155H,0
	.long	DARK7,P_DARK6,0008401c2H,0
	.long	DARK4,P_DARK3,000220165H,0
	.long	DARK9,P_DLITE,00028019fH,0		; left side

	.long	DARK1,P_DARK1,0001d053bH,1
	.long	DARK2,P_DARK1,0001d04ccH,1
	.long	DARK6,P_DARK6,00084053dH,1
	.long	DARK7,P_DARK6,0008404ccH,1
	.long	DARK3,P_DARK3,000220594H,1
	.long	DARK9,P_DLITE,000280513H,1		; right side

	.long	DARK8,P_DARK8,00084030fH,0
	.long	DARK8,P_DARK8,00084037fH,1
	.long	DARK1,P_DARK1,0001d0312H,0
	.long	DARK1,P_DARK1,0001d0380H,1
	.long	DARK3,P_DARK3,0002203d8H,1
	.long	DARK4,P_DARK3,000220321H,0
	.long	DARK10,P_DLITE,00029035cH,0
	.long	DARK11,P_DARK11,0005f0360H,0
	.long	DARK11,P_DARK11,0005f037fH,1	; middle
	.long	0

lit_object_table
	.long	LITE1,P_LITE1,0001d0154H,0
	.long	LITE2,P_LITE1,0001d01c2H,0
	.long	LITE6,P_LITE6,000840155H,0
	.long	LITE7,P_LITE6,0008401c2H,0
	.long	LITE4,P_LITE3,000220165H,0
	.long	LITE9,P_LLITE,00028019fH,0		; left side

	.long	LITE1,P_LITE1,0001d053bH,1
	.long	LITE2,P_LITE1,0001d04ccH,1
	.long	LITE6,P_LITE6,00084053dH,1
	.long	LITE7,P_LITE6,0008404ccH,1
	.long	LITE3,P_LITE3,000220594H,1
	.long	LITE9,P_LLITE,000280513H,1		; right side

	.long	LITE8,P_LITE8,00084030fH,0
	.long	LITE8,P_LITE8,00084037fH,1
	.long	LITE1,P_LITE1,0001d0312H,0
	.long	LITE1,P_LITE1,0001d0380H,1
	.long	LITE3,P_LITE3,0002203d8H,1
	.long	LITE4,P_LITE3,000220321H,0
	.long	LITE10,P_LLITE,00029035cH,0
	.long	LITE11,P_LITE11,0005f0360H,0
	.long	LITE11,P_LITE11,0005f037fH,1	; middle
	.long	0

;***************************************************************************

setup_floor_info
	move	*a0+,a1,l
	addi	02000000H+(400*6),a1	; centered
	move	a1,@skew_sag,l		; #1 = sag

	move	*a0+,a1,l
	push	a0
	move	a1,a0
	calla	getfpal
	move	a0,@skew_constpal,l	; #2 = set const:pal
	pull	a0

	clr	a1
	move	a1,@skew_oc,l		; off center = 0

;	move	*a0+,a1,w
;	move	a1,@skew_y,w		; # = y position of floor

	move	*a0+,a1,w
	move	a1,@skew_height,w 	; #3 = height of floor piece

	move	@worldtly+16,a2,w
	addi	254,a2
	sub	a1,a2	     		; new automatic
	move	a2,@skew_y,w 		; align floor with bottom of screen

	move	*a0+,a1,l
	move	a1,@skew_scroll,l	; #4 = scroll x to use

	move	*a0+,a1,l
	move	a1,@skew_calla,l	; #5 = scroll call routine

	jruc	set_skew_flag		; rets

;**********************************************************************

set_skew_flag
	movk	1,a0
	move	a0,@f_skew,w
	rets

skew_7	move	@skew_dx,a11,l	; dx per line
	sra	7,a9
	sub	a9,a11		; adjust with scroll
	move	a11,@skew_dx,l
	jauc	skew_rets


create_dumb_animators_w
	move	*a6+,a3,w			; animation speed
	jreq	return

	move	*a6+,a5,l			; image
	calla	gso_dmawnz
	move	*a6+,a4,l			; coordinate offset (from world)
	move	*a6+,a9,l			; animation table
	callr	a4_to_world_coor

	move	*a6+,a0,l			; baklst to use
	move	a0,b4
	move	a8,a0
	calla	insobj_v			; on baklst 4 !!
	create	pid_bani,dumb_animator
	move	a3,*a0(pa10),w			; pass a10 = ani speed
	jruc	create_dumb_animators_w

create_dumb_animators
	move	*a6+,a3,w			; animation speed
	jreq	return

	move	*a6+,a4,l			; coordinates
	move	*a6+,a9,l			; animation table
	move	*a9+,a5,l			; image

	push	a4
	calla	gso_dmawnz
	pull	a4
	calla	set_xy_coordinates

	btst	15,a3				; flipped image ??
	jreq	cda3

	andi	07fffH,a3			; mask off bs
	push	a6
	calla	flip_single
	pull	a6

cda3	move	*a6+,a0,l			; baklst to use
	move	a0,b4
	move	a8,a0
	calla	insobj_v			; on baklst #?
	create	pid_bani,dumb_animator
	move	a3,*a0(pa10),w			; pass a10 = ani speed
	jruc	create_dumb_animators



dlists_bogus
	.long	baklst8,worldtlx8+16
	.long	baklst7,worldtlx7+16
	.long	baklst6,worldtlx6+16
	.long	baklst5,worldtlx5+16
	.long	baklst4,worldtlx4+16
	.long	baklst3,worldtlx3+16
	.long	baklst2,worldtlx2+16
	.long	baklst1,worldtlx1+16
dlists_objlst
	.long	objlst,worldtlx+16
	.long	objlst2,worldtlx+16
	.long	0


shadow_code
	move	a1,b8			; yes, remember this spot
return	rets

use_next_y
	move	*a3+,a4,l
	move	*a4,a4,l
	rets

**************************************************************************
*											     *
*               Palettes Palettes Palettes Palettes				     *
*               Palettes Palettes Palettes Palettes				     *
*               Palettes Palettes Palettes Palettes				     *
*               Palettes Palettes Palettes Palettes				     *
*											     *
**************************************************************************

TOMBFLR_p:
   .word   61 
   .word   035adh,034e6h,02483h,01820h,028a5h,02082h,01c41h,04147h
   .word   04988h,055cah,04da9h,04989h,04568h,03d27h,01821h,028c4h
   .word   030e4h,04146h,01c21h,02ca3h,0412ah,05e0bh,0664fh,01c40h
   .word   055c8h,05e2eh,02463h,04da8h,05a0eh,06e8fh,01c20h,02482h
   .word   01000h,0664bh,01400h,04566h,02cc5h,045abh,0418bh,045aah
   .word   049cbh,0416bh,0418ah,0498dh,0456ah,03949h,03106h,03506h
   .word   030e7h,0560eh,0456ch,03d6ah,051ech,06693h,03927h,04148h
   .word   03948h,05a4fh,03529h,05e70h,04da7h

SUBFLR_P
   .word   64 
   .word   007e3h,030a5h,034c6h,02ca5h,028a5h,01c63h,02484h,02084h
   .word   02884h,034c5h,038c6h,03ce7h,03ce6h,040e7h,044e7h,02063h
   .word   03cc6h,02ca4h,02c84h,034a5h,04908h,038c5h,04907h,048e7h
   .word   040c6h,040e6h,030a4h,02463h,044e6h,04d08h,038a5h,04ce7h
   .word   03cc5h,044c6h,03084h,040a5h,03ca5h,02863h,03484h,040c5h
   .word   02c83h,00c42h,01862h,01084h,01062h,02c62h,02862h,03062h
   .word   03508h,014a5h,018c6h,018a5h,01484h,020c6h,01ca5h,04129h
   .word   04d29h,03483h,03083h,034a4h,030c6h,04108h,0494ah,0454ah

CITYFLR_P:
   .word   64 
   .word   00000h,02528h,02107h,01ce7h,02108h,02529h,018c6h,02949h
   .word   0294ah,02d6bh,01ce6h,02d6ah,0318ch,014a5h,0318bh,035adh
   .word   018c5h,035ach,039cdh,039ceh,03deeh,03defh,01084h,014a4h
   .word   04210h,04a52h,07ffbh,07ffch,06f78h,07bdah,06b57h,06736h
   .word   05ad4h,06315h,056b3h,056b2h,05ad3h,05ef4h,04e71h,05292h
   .word   0462fh,04a50h,077b9h,0420eh,07ffeh,07ffdh,06f77h,07398h
   .word   03dedh,06b56h,039cch,05291h,06735h,035abh,06314h,04e70h
   .word   077b8h,07397h,07bd9h,06f76h,07ffah,07fffh,0318ah,07ff9h

WAREFLR_P
   .word   64 
   .word   0bd73h,018c7h,014c6h,01085h,00843h,00c64h,00422h,00822h
   .word   00420h,014a6h,02109h,02949h,01ce8h,01d09h,0212ah,0296bh
   .word   0254bh,02d8dh,0296ch,01d0ah,0256ch,031afh,0318dh,02daeh
   .word   04233h,031cfh,0258ch,035d0h,02d6eh,039f1h,039cfh,03a11h
   .word   031b0h,03e12h,02dcfh,039f2h,035f2h,04234h,04253h,04255h
   .word   03611h,03612h,03e34h,03e53h,04a75h,04676h,04a97h,04a76h
   .word   052b7h,04231h,04ab8h,052d9h,01064h,0000ah,0000dh,02db0h
   .word   00010h,06bbeh,05b39h,0677ch,0316bh,039cdh,0252ch,04678h

FLAG_P:
   .word   64 
   .word   0001fh,01cc4h,02927h,02d48h,03148h,03969h,02906h,020e5h
   .word   018a4h,02d27h,024e6h,01063h,00c42h,03568h,03569h,03989h
   .word   01483h,01cc5h,02506h,03d89h,018a3h,03548h,041aah,02907h
   .word   03147h,020e6h,01ce5h,020c6h,018c4h,03da9h,02d47h,024e5h
   .word   014a3h,020c5h,01482h,01062h,03128h,02927h,00c62h,02d26h
   .word   02926h,03968h,01ca5h,02906h,02d06h,01083h,01ca4h,020c4h
   .word   02905h,03988h,03146h,03547h,041c9h,03126h,028e5h,03546h
   .word   02d05h,03946h,024e4h,03d66h,04586h,04166h,03d46h,04da7h

BRGRD_P:
   .word   59 
   .word   01931h,018a5h,014a5h,01484h,01084h,014a4h,018c6h,018c5h
   .word   00842h,01cc6h,01ce6h,01ce7h,00c63h,020e7h,01063h,01083h
   .word   02108h,02107h,02528h,02529h,02508h,02929h,02949h,0294ah
   .word   02d4ah,02d6bh,02d6ah,030e2h,02ce3h,02cc1h,02d05h,028e4h
   .word   028c1h,028a1h,024c3h,024a1h,02081h,020a1h,020c3h,020a2h
   .word   020a3h,020c4h,01c81h,01ca2h,01ca3h,01861h,01881h,01882h
   .word   01461h,01441h,01482h,01041h,01061h,01062h,00c41h,00420h
   .word   00000h,03504h,030e3h

SOFLOR_P:
   .word   64 
   .word   00000h,00c84h,00863h,045e9h,041c8h,041c9h,03da7h,03987h
   .word   03988h,03968h,03567h,03147h,03146h,03167h,02d26h,02926h
   .word   02906h,02506h,02526h,020e5h,020e6h,02106h,01cc5h,01cc6h
   .word   018a5h,018a4h,014a4h,01084h,01da6h,01d86h,01985h,01965h
   .word   01545h,01525h,01125h,01105h,01104h,00ce4h,00cc4h,008a4h
   .word   00883h,00463h,00c85h,00024h,00443h,00023h,00043h,00023h
   .word   00043h,010a4h,01085h,00c64h,00cc6h,008a5h,00884h,00484h
   .word   00463h,01d25h,01d05h,018e5h,014c4h,00000h,00000h,00000h

CAVEFL_P
   .word   47 
   .word   07c00h,00842h,00c42h,00c62h,00c63h,01063h,01083h,01084h
   .word   01483h,01484h,014a4h,014a5h,01883h,018a4h,018a5h,018c5h
   .word   018c6h,01cc5h,01cc6h,01ce6h,020c6h,020e6h,020e7h,02107h
   .word   024e6h,024e7h,02507h,02508h,02907h,02908h,02928h,02929h
   .word   02d28h,02d29h,02d48h,02d49h,02d4ah,03149h,03169h,0316ah
   .word   0356ah,0356bh,0358bh,0398bh,039ach,03dach,03dcch

;BELFLR_P:
;   .word   64 
;   .word   01931h,03568h,03567h,03566h,03168h,03167h,03166h,03148h
;   .word   03147h,03146h,02d48h,02d47h,02d46h,02d28h,02d27h,02d26h
;   .word   02928h,02927h,02926h,02925h,02907h,02906h,02905h,02507h
;   .word   02506h,02505h,02504h,024e6h,024e5h,024e4h,020e6h,020e5h
;   .word   020e4h,01ce5h,01ce4h,020c6h,020c5h,020c4h,01cc6h,01cc5h
;   .word   01cc4h,01cc3h,018c5h,018c4h,018c3h,01ca4h,018a5h,018a4h
;   .word   018a3h,014a4h,014a3h,01484h,01483h,01482h,01083h,01082h
;   .word   01063h,01062h,00c62h,00c42h,00c41h,00842h,00841h,00821h

templfl_p:
   .word   64 
   .word   00000h,035adh,04210h,039ceh,02d6bh,0294ah,02529h,02108h
   .word   04631h,05293h,056b4h,056b5h,05294h,05ad6h,05ad5h,05ef7h
   .word   05ef6h,04e73h,0318ch,018c6h,014a5h,018c5h,01ce7h,02d6ah
   .word   04e72h,06317h,04a52h,06738h,03defh,03deeh,06b59h,039cdh
   .word   04630h,04a51h,0420fh,02107h,02949h,02528h,035ach,0318bh
   .word   01084h,01ce6h,00c63h,014a4h,05ef5h,05ad4h,05292h,056b3h
   .word   04e71h,0462fh,04a50h,0420eh,03dedh,039cch,035abh,06736h
   .word   0318ah,05291h,04a4fh,04e70h,0420dh,0462eh,07397h,04e6fh

CEMFLR_P:
   .word   64 
   .word   01931h,03dcdh,039adh,039ach,035ach,0398bh,0358ch,0358bh
   .word   0318ch,0356bh,0356ah,0316bh,0316ah,03169h,02d6bh,02d6ah
   .word   02d4ah,02d49h,0294ah,02949h,0254ah,02549h,02d29h,02929h
   .word   02928h,02529h,02528h,02129h,02128h,02509h,02508h,02109h
   .word   02108h,02107h,01d08h,01d07h,020e8h,01ce7h,018e8h,018e7h
   .word   014e6h,018c7h,014c7h,018c6h,018c5h,014c6h,010c6h,014c5h
   .word   014a6h,014a5h,00ca6h,010a5h,00ca5h,010a4h,01085h,00c85h
   .word   00885h,00c84h,00884h,00c64h,00864h,00863h,00844h,00843h

BALCO_P:
   .word   64 
   .word   03863h,00000h,014a2h,01082h,014a3h,00c62h,01ce5h,01083h
   .word   0462dh,02527h,039cbh,0318ah,02528h,02503h,04a2ch,02504h
   .word   03dcah,0526eh,03167h,03986h,03da7h,0524bh,039aah,020e4h
   .word   03168h,05270h,03145h,045eah,01482h,045c7h,018a3h,02506h
   .word   039abh,0460eh,04a2fh,024e3h,02d25h,03146h,01cc4h,03da9h
   .word   04a0ch,0524eh,02d48h,03dcch,020e5h,03989h,020c3h,0524fh
   .word   02d04h,024e4h,01483h,020a2h,00c41h,03104h,03946h,02906h
   .word   02d27h,045cbh,01cc5h,04a0eh,045edh,03925h,00821h,00421h


**************************************************************************
*											     *
*  module: mk3 logo										*
*											     *
**************************************************************************
;mk3_mod
;	.word	rgb_dark_blue		 	; autoerase color
;	.word	0				; initial world y
;	.word	220	     			; ground y
;	.word	0				; initial worldx
;	.word	-0500H 	  			; scroll left limit
;	.word	0500H	  			; scroll right limit
;
;	.long	return
;	.long	no_scroll			; scroll table
;	.long	dlists_bogus
;
;	.long	bak1mods
;	.long	mk3logoBMOD			; baklst1 = mk3 logo
;	.word	038H,008H
;
;	.long	-1
;	.long	0
;*************************

;vs_mk3vs
;	.word	0		 		; autoerase color
;	.word	0200H				; initial world y
;	.word	000H	     			; ground y
;	.word	-007H				; initial worldx
;	.word	-0500H 	  			; scroll left limit
;	.word	0500H	  			; scroll right limit
;
;	.long	return
;	.long	no_scroll			; scroll table
;	.long	dlists_bogus
;	.long	bak1mods
;
;	.long	MK3VSBMOD
;	.word	000H,007H
;	.long	0ffffffffH
;	.long	0				; no floor here !!
;


;**************************************************************************

	.end
