**************************************************************************
*												*
*  video game project:	  mortal kombat 3							*
*												*
*  programmer:		  Ed boon								*
*												*
*  module: sound processor									*
*												*
*  copyright (c) 1995 midway manufacturing							*
*												*
**************************************************************************
	.width	132
	.option	b,d,l,t
	.mnolist

	.include	mainequ.asm
	.include	sysequ.asm 	; sys.inc and gsp.inc
	.include	macros.hdr
	.include	dispequ.asm

	.text

send	.set	00001H			; script command --> send sound code
setpri	.set	00002H			; script command --> set priority
endtune	.set	00003H			; script command --> end of tune script
sleep	.set	00004H			; script command --> sleep next byte
send2	.set	00005H

sndpri	.set	0			; priority offset
snddur	.set	10h			; duration offset
sndscp	.set	20h			; script pointer offset

ex	.set	08000H			; flag: extended sound call !!

	.bss	chan1ram,0,1
	.bss	chan1pri,16,1		; sound channel #1 priority
	.bss	chan1dur,16,1		; sound channel #1 duration (timer)
	.bss	chan1scp,32,1		; sound channel #1 script pointer

	.bss	chan2pri,16,1		; sound channel #2 priority
	.bss	chan2dur,16,1		; sound channel #2 duration (timer)
	.bss	chan2scp,32,1		; sound channel #2 script pointer

	.bss	chan3pri,16,1		; sound channel #3 priority
	.bss	chan3dur,16,1		; sound channel #3 duration (timer)
	.bss	chan3scp,32,1		; sound channel #3 script pointer

	.bss	chan4pri,16,1		; sound channel #4 priority
	.bss	chan4dur,16,1		; sound channel #4 duration (timer)
	.bss	chan4scp,32,1		; sound channel #4 script pointer

	.bss	chan5pri,16,1		; sound channel #5 priority
	.bss	chan5dur,16,1		; sound channel #5 duration (timer)
	.bss	chan5scp,32,1		; sound channel #5 script pointer

**************************************************************************
*												*
*	these strobe equates are for the pinball sound card			*
*												*
**************************************************************************
resetbit		equ	0fe00h			; this is the reset bit
musicbit		equ	0fd00h			; this is the yamaha side strobe

sp_woosh1	.set	010H*0100H
sp_ground	.set	018H*0100H
sp_block1	.set	01fH*0100H

sp_dontin	.set	030H*0100H		; 30's = dont interupt myself
sp_runrun	.set	031H*0100H

sp_only1		.set	040H*0100H		; 40's = special (dont overlap)
sp_voice1	.set	041H*0100H		; player 1 voice 
sp_voice2	.set	042H*0100H		; player 2 voice
sp_windy1	.set	043H*0100H

sp_effect	.set	050H*0100H
sp_animal	.set	053H*0100H
sp_hit1		.set	055H*0100H
sp_hit2		.set	061H*0100H
sp_kahnvc	.set	062H*0100H
;sp_bonusv	.set	063H*0100H

sp_train		.set	065H*0100H

sp_coin		.set	07fH*0100H

**************************************************************************
*											     *
*    TRIPLE SOUND TABLE format:								     *
* 											     *
*              .word   0aaaaH,0bbbbH							     *
* 											     *
*       where:  aaaa = priority / duration						     *
*               bbbb = channel 1 sound call					     *
*											     *
**************************************************************************
triple_sndtab
	.word	sp_effect|102,0140H	; 0 - Explode thru street
	.word	sp_effect|99,0145H	; 1 - Explode thru street
	.word	sp_woosh1|28,016dH	; 2 - roundhouse whoosh
	.word	sp_effect|62,040bH	; 3 - big door closing
	.word	sp_effect|102,0410H	; 4 - big door slam shut
	.word	sp_windy1|217,03e8H	; 5 - wind
	.word	sp_woosh1|16,0a5H 	; 6 - whoosh #1
	.word	sp_woosh1|20,0afH 	; 7 - whoosh #3
	.word	sp_effect|54,03edH  	; 8 - subway approaching
	.word	sp_effect|17,03f2H   	; 9 - subway steady state
	.word	sp_effect|62,03f7H   	; a - subway going away
	.word	sp_effect|87,042eH   	; b - crowd: "Ooooo"
	.word	sp_effect|14,043dH   	; c - p1 cursor
	.word	sp_effect|17,0442H   	; d - p2 cursor
	.word	sp_effect|50,0447H   	; e - p1 picked
	.word	sp_effect|48,044cH   	; f - p2 picked
	.word	sp_kahnvc|49,0233cH	; 10 - Shao Kahn: Fight! #3
	.word	sp_kahnvc|84,02341H	; 11 - Shao Kahn: Round One
	.word	sp_kahnvc|77,02346H	; 12 - Shao Kahn: Round Two
	.word	sp_kahnvc|72,0234bH	; 13 - Shao Kahn: Round Three
	.word	sp_kahnvc|69,02350H	; 14 - Shao Kahn: Round Four
	.word	sp_kahnvc|54,02328H	; 15 - Shao Kahn: Finish Him!
	.word	sp_kahnvc|62,0232dH	; 16 - Shao Kahn: Finish Her!
	.word	sp_effect|10,0424H  	; 17 - clock time down tik !!
	.word	sp_effect|10,0186H  	; 18 - players feet landing on ground
	.word	sp_effect|58,0460H	; 19 - 1 player map zoom sound
	.word	sp_coin|90,024ccH	; 1a - COIN = Shao Kahn: Outstanding

	.word	sp_effect|38,01095H	; 1b - DF: toasty
	.word	sp_effect|43,01090H	; 1c - DF: frosty
	.word	sp_effect|47,01077H	; 1d - DF: crispy
	.word	sp_effect|37,0276fH 	; 1e - shock sound !!

	.word	sp_effect|69,02d5H 	; 1f - flame throw
	.word	sp_effect|144,027b5H 	; 20 - burning flames!!
	.word	sp_effect|29,0277eH 	; 21 - bones fall
	.word	sp_effect|40,02823H 	; 22 - pit machine sound
	.word	sp_effect|56,02779H 	; 23 - pit machine sound
	.word	sp_effect|32,0d2H 	; 24 - crunch #1
	.word	sp_effect|33,0d7H 	; 25 - crunch #2
	.word	sp_effect|47,0288cH 	; 26 - animality sizzle
	.word	sp_effect|43,0357H 	; 27 - animality morph

	.word	sp_kahnvc|54,0236eH	; 28 - Shao Kahn: Kano
	.word	sp_kahnvc|58,02391H	; 29 - Shao Kahn: Sonya
	.word	sp_kahnvc|59,02369H	; 2a - Shao Kahn: Jax
	.word	sp_kahnvc|79,02490H	; 2b - Shao Kahn: Night Wolf
	.word	sp_kahnvc|65,0239bH	; 2c - Shao Kahn: Sub-Zero
	.word	sp_kahnvc|53,02396H	; 2d - Shao Kahn: Stryker
	.word	sp_kahnvc|64,0249aH	; 2e - Shao Kahn: Sindel
	.word	sp_kahnvc|66,02495H	; 2f - Shao Kahn: Sektor
	.word	sp_kahnvc|68,0248bH	; 30 - Shao Kahn: Cyrax
	.word	sp_kahnvc|57,023a0H	; 31 - Shao Kahn: Kung Lao
	.word	sp_kahnvc|42,02364H	; 32 - Shao Kahn: Kabal
	.word	sp_kahnvc|52,02387H	; 33 - Shao Kahn: Sheeva
	.word	sp_kahnvc|74,02382H	; 34 - Shao Kahn: Shang Tsung
	.word	sp_kahnvc|65,02378H	; 35 - Shao Kahn: Liu Kang
	.word	sp_kahnvc|50,0238cH	; 38 - Shao Kahn: Smoke
	.word	sp_kahnvc|56,0237dH	; 37 - Shao Kahn: Motaro
	.word	0,0			; 38 -
	.word	sp_kahnvc|109,024feH	; 39 - Shao Kahn: Choose your destiny
	.word	sp_animal|78,04e34H	; 3a - Huge animal ROAR!
	.word	sp_effect|10,046fH 	; 3b - player buys in !!
	.word	sp_effect|47,04e39H 	; 3c - animality sizzle

	.word	sp_bonusv|111,02413H	; 3d - Shao Kahn: Kano wins
	.word	sp_bonusv|115,02436H	; 3e - Shao Kahn: Sonya wins
	.word	sp_bonusv|108,0240eH	; 3f - Shao Kahn: Jax wins
	.word	sp_bonusv|137,024a4H	; 3f - Shao Kahn: Nightwolf wins
	.word	sp_bonusv|121,02440H	; 41 - Shao Kahn: Sub-Zero wins
	.word	sp_bonusv|111,0243bH	; 42 - Shao Kahn: Stryker wins
	.word	sp_bonusv|113,024aeH	; 43 - Shao Kahn: Sindel wins
	.word	sp_bonusv|112,024a9H	; 44 - Shao Kahn: Sector wins
	.word	sp_bonusv|113,0249fH	; 45 - Shao Kahn: Cyrax wins
	.word	sp_bonusv|116,02445H	; 46 - Shao Kahn: Kung Lao wins
	.word	sp_bonusv|100,02409H	; 47 - Shao Kahn: Cabal wins
	.word	sp_bonusv|110,0242cH	; 48 - Shao Kahn: Sheeva wins
	.word	sp_bonusv|131,02427H	; 49 - Shao Kahn: Shang Tsung wins
	.word	sp_bonusv|121,0241dH	; 4a - Shao Kahn: Liu Kang wins
	.word	sp_bonusv|108,02431H	; 4b - Shao Kahn: Smoke wins
	.word	sp_bonusv|113,02422H	; 4c - Shao Kahn: Motaro wins
	.word	sp_bonusv|53,023a5H	; 4d - Shao Kahn: I win

	.word	sp_kahnvc|142,02454H	; 4e - Shao Kahn: Kano shows mercy
	.word	sp_kahnvc|146,02477H	; 4f - Shao Kahn: Sonya shows mercy
	.word	sp_kahnvc|138,0244fH	; 50 - Shao Kahn: Jax shows mercy
	.word	sp_kahnvc|132,024b8H	; 51 - Shao Kahn: Nightwolf shows mercy
	.word	sp_kahnvc|153,02481H	; 52 - Shao Kahn: Sub-Zero shows mercy
	.word	sp_kahnvc|141,0247cH	; 53 - Shao Kahn: Stryker shows mercy
	.word	sp_kahnvc|125,024c2H	; 54 - Shao Kahn: Sindel shows mercy
	.word	sp_kahnvc|144,024bdH	; 55 - Shao Kahn: Sektor shows mercy
	.word	sp_kahnvc|144,024b3H	; 56 - Shao Kahn: Cyrax shows mercy
	.word	sp_kahnvc|145,02486H	; 57 - Shao Kahn: Kung Lao shows mercy
	.word	sp_kahnvc|130,0244aH	; 58 - Shao Kahn: Cabal shows mercy
	.word	sp_kahnvc|140,0246dH	; 59 - Shao Kahn: Sheeva shows mercy
	.word	sp_kahnvc|162,02468H	; 5a - Shao Kahn: Shang Tsung shows mercy
	.word	sp_kahnvc|153,0245eH	; 5b - Shao Kahn: Liu Kang shows mercy
	.word	sp_kahnvc|124,02472H	; 5c - Shao Kahn: Smoke shows mercy
	.word	sp_effect|117,0045bH	; 5d - mercy music hit
	.word	0,0			; 5e
	.word	0,0			; 5f
	.word	sp_bonusv|60,04e39H	; 60 - animality bonus count roar !!

	.word	sp_bonusv|90,02337H	; 61 - Shao Kahn: Flawless Victory
	.word	sp_bonusv|79,02332H	; 62 - Shao Kahn: Fatality!
	.word	sp_bonusv|54,023d2H	; 63 - Shao Kahn: Mercy
	.word	sp_bonusv|62,023d7H	; 64 - Shao Kahn: Animality
	.word	sp_bonusv|63,023dcH	; 65 - Shao Kahn: Babality

	.word	sp_kahnvc|63,023e1H	; 66 - Shao Kahn: Crispy
	.word	sp_kahnvc|66,023e6H	; 67 - Shao Kahn: Frosty
	.word	sp_bonusv|56,023ebH	; 68 - Shao Kahn: Friendship
	.word	sp_bonusv|49,023f0H	; 69 - Shao Kahn: Friendship!?!
	.word	sp_bonusv|51,023f5H	; 6a - Shao Kahn: Again?
	.word	0,0			; 6b - 
	.word	sp_kahnvc|66,023ffH	; 6c - Shao Kahn: Toasty Low
	.word	sp_kahnvc|66,02404H	; 6d - Shao Kahn: Oh maw

	.word	0,0			; 6e
	.word	0,0			; 6f
	.word	sp_effect|61,0279cH  	; 70 - nasty goo
	.word	sp_effect|53,0406H  	; 71 - danger !!
	.word	sp_effect|120,047eH  	; 72 - flawless tone
	.word	0,0			; 73
	.word	sp_kahnvc|64,023aaH	; 74 - Shao Kahn: Superb
	.word	sp_kahnvc|66,023afH	; 75 - Shao Kahn: Well Done
	.word	sp_kahnvc|46,023b4H	; 76 - Shao Kahn: ... versus ...
	.word	sp_kahnvc|68,023b9H	; 77 - Shao Kahn: ... wins
	.word	sp_kahnvc|88,023cdH	; 78 - Shao Kahn: ... shows mercy
	.word	sp_kahnvc|151,023beH	; 79 - Shao Kahn: Laugh #1
	.word	sp_kahnvc|126,023c3H	; 7a - Shao Kahn: Laugh #2
	.word	sp_kahnvc|149,023c8H	; 7b - Shao Kahn: Laugh #3

	.word	sp_kahnvc|67,024c7H	; 7c - Shao Kahn: Excellent
	.word	sp_kahnvc|110,024e0H	; 7d - Shao Kahn: You will never win
	.word	sp_kahnvc|90,024ccH	; 7e - Shao Kahn: Outstanding
	.word	sp_hit2|45,0f0H		; 7f - Shao Kahn last hit

	.word	sp_effect|50,0334H	; 80 - hidden game fire sound
	.word	sp_effect|20,02f3H  	; 81 - player ship explodes
	.word	sp_kahnvc|122,024efH	; 82 - Shao Kahn: That was Pathetic
	.word	sp_coin|23,018bH		; 83 - klang 1 !!

	.word	sp_train|50,03edH	; 84 - subway approaching
	.word	sp_train|117,03f2H	; 85 - subway steady state
	.word	sp_train|62,03f7H	; 86 - subway going away

	.word	sp_train|69,02805H	; 87 - Final Death Quake Loop
	.word	sp_train|228,0280aH	; 88 - Shao Kahn Death Scream
	.word	sp_train|209,0280fH	; 89 - Final Death Quake Loop Crescendo (3x)
	.word	sp_effect|21,027e2H	; 8a - dog
	.word	sp_effect|21,027e7H	; 8b - dog ouch
	.word	sp_effect|20,02f3H  	; 8c - babality poof
	.word	sp_train|160,027fbH  	; 8d - baby cry
	.word	sp_effect|130,0429H  	; 8e - bell

	.word	sp_kahnvc|149,024e5H	; 8f - Shao Kahn: Its official
	.word	sp_kahnvc|64,0237dH	; 90 - Shao Kahn: Motaro
triple_end

;*************************************************************************

*
* a0 = group offset
*
group_sound
	mmtm	sp,a1,a2,a3,a4

	callr	get_group_table
	move	*a0+,a2,w		; a2 = # of entries
	move	a2,a3
	sll	5,a2			; x32 - size of each group
	move	*a8(ochar),a1,w	
	sll	4,a1
	addi	ochar_voice_groups,a1
	move	*a1,a1,w		; a1 = my group
	jrn	gsnd6			; neg = no group for me
	jreq	gsnd5

gsnd3	add	a2,a0
	dsjs	a1,gsnd3		; get to my group position

gsnd5	move	a0,a1			; a1 = table position
	move	a3,a0			; a0 = # of entries

	movi	gsnd6,a3
	push	a3			; return address
	push	a1			; this is expected to be on the stack
	jruc	next_table_sound

gsnd6	mmfm	sp,a1,a2,a3,a4
	rets

his_group_sound
	push	a8
	move	*a13(p_otherguy),a8,l
	callr	group_sound
	pull	a8
	rets

get_group_table
	sll	5,a0
	addi	group_table,a0
	move	*a0,a0,l
	rets

;**************************************************************************

;	.word	sp_voice1|35,25e4	; Shao Kahn: Attack #1
;	.word	sp_voice1|37,25e9	; Shao Kahn: Attack #2
;	.word	sp_voice1|26,25ee	; Shao Kahn: React #1
;	.word	sp_voice1|31,25f3	; Shao Kahn: React #2
;	.word	sp_voice1|38,25f8	; Shao Kahn: React #3
;	.word	sp_voice1|49,25fd	; Shao Kahn: React #4
;	.word	sp_voice1|55,2602	; Shao Kahn: Wast #1
;	.word	sp_voice1|61,2607	; Shao Kahn: Wast #2


group_table
	.long	gs_attack		; 0 = quick attacks
	.long	gs_jump			; 1 = jump
	.long	gs_wasted		; 2 = wasted
	.long	gs_grab			; 3 = grab
	.long	gs_slam			; 4 = throw voice
	.long	gs_tripped_voice	; 5 =
	.long	gs_face_hit_voice	; 6 =
	.long	gs_run			; 7 =
	.long	gs_shook		; 8 =
	.long	gs_death		; 9

gs_death
	.word	1
	.word	sp_voice1|203,081bH 	; girl = eb
	.word	sp_voice1|269,0c03H 	; vp = hey
	.word	sp_voice1|121,0febH 	; df = df
	.word	sp_voice1|193,017bbH 	; eb
	.word	sp_voice1|193,013d3H 	; 4 = eb
	.word	sp_voice1|193,017bbH 	; 5 = hey
	.word	sp_voice1|229,015c7H 	; kang
	.word	sp_voice1|90,0627H	; Sheeva death
	.word	sp_voice1|61,02607H	; Shao Kahn: Wast #2

gs_shook
	.word	1
	.word	sp_voice1|63,0816H   	; Girl #1: Wast #2
	.word	sp_voice1|95,0c80H	; VP: shook
	.word	sp_voice1|95,0c80H	; DF: shook
	.word	sp_voice1|151,01455H	; EB: shook
	.word	sp_voice1|151,01455H	; EB: shook
	.word	sp_voice1|61,01b6cH 	; robo: shook
	.word	sp_runrun|80,01595H 	; kang: run (borrow)
	.word	sp_voice1|74,061dH	; Sheeva wasted #1
	.word	sp_voice1|55,02602H	; Shao Kahn: Wast #1



gs_run
	.word	1
	.word	sp_runrun|107,07e9H  	; Girl #1: run
	.word	sp_runrun|70,0bd1H	; VP: run
	.word	sp_runrun|89,0fb9H	; DF: run
	.word	sp_runrun|69,013a1H	; EB: run
	.word	sp_runrun|71,01789H	; JH: run
	.word	sp_runrun|61,01b6cH 	; robo: run
	.word	sp_runrun|80,01595H 	; kang: run
	.word	sp_voice1|73,05f5H	; Sheeva running attack
	.word	sp_voice1|73,05f5H	; Sheeva running attack
	.word	0,0


gs_tripped_voice
	.word	1
	.word	sp_voice1|21,0807H   	; Girl #1: tripped voice
	.word	sp_voice1|30,0bc7H	; VP: attack #1
	.word	sp_voice1|18,0fd7H	; DF: tripped
	.word	sp_voice1|21,013bfH	; EB: tripped
	.word	sp_voice1|26,017a7H	; JH: tripped
	.word	0,0			; robo
	.word	sp_voice1|26,015b3H	; JH: tripped
	.word	sp_voice1|21,0613H	; Sheeva tripped
	.word	sp_voice1|26,025eeH	; Shao Kahn: React #1

gs_face_hit_voice
	.word	3
	.word	sp_voice1|34,07f3H   	; Girl: hit in face voice
	.word	sp_voice1|33,07f8H   	; Girl: hit in face voice
	.word	sp_voice1|33,07f8H   	; Girl: hit in face voice

	.word	sp_voice1|28,0bdbH	; VP: hit in face voice
	.word	sp_voice1|28,0bdbH	; VP: hit in face voice
	.word	sp_voice1|31,0be0H	; VP: hit in face voice

	.word	sp_voice1|26,0fc3H  	; DF: hit in face voice
	.word	sp_voice1|26,0fc3H  	; DF: hit in face voice
	.word	sp_voice1|30,0fc8H  	; DF: hit in face voice

	.word	sp_voice1|20,013abH  	; EB: hit in face voice
	.word	sp_voice1|29,013b0H  	; EB: hit in face voice
	.word	sp_voice1|29,013b0H  	; EB: hit in face voice

	.word	sp_voice1|30,01793H  	; JH: hit in face voice
	.word	sp_voice1|27,01798H  	; JH: hit in face voice
	.word	sp_voice1|22,0185bH  	; JH: hit in face voice

	.word	sp_effect|28,0299H  	; robo: hit in face
	.word	sp_effect|28,0299H  	; robo: hit in face
	.word	sp_effect|40,029eH 	; robo: hit in face

	.word	sp_voice1|28,0159fH  	; kang: hit in face voice
	.word	sp_voice1|28,0159fH  	; kang: hit in face voice
	.word	sp_voice1|19,015a4H  	; kang: hit in face voice

	.word	sp_voice1|25,05ffH	; Sheeva face hit #1
	.word	sp_voice1|17,060eH	; Sheeva body hit #2
	.word	sp_voice1|33,0604H	; Sheeva face hit #2

	.word	sp_voice1|26,025eeH	; Shao Kahn: React #1
	.word	sp_voice1|31,025f3H	; Shao Kahn: React #2
	.word	sp_voice1|38,025f8H	; Shao Kahn: React #3


gs_attack
	.word	2			; 2 entries per group
	.word	sp_voice1|28,07d0H   	; Girl #1: attack #1
	.word	sp_voice1|22,07d5H   	; Girl #1: attack #2
	.word	sp_voice1|26,0bb8H	; VP: attack #1
	.word	sp_voice1|26,0bbdH	; VP: attack #2
	.word	sp_voice1|19,0fa0H  	; DF: attack #1
	.word	sp_voice1|18,0fa5H  	; DF: attack #2
	.word	sp_voice1|19,01388H  	; EB: attack #1
	.word	sp_voice1|21,0138dH  	; EB: attack #2
	.word	sp_voice1|23,01770H  	; JH: attack #1
	.word	sp_voice1|31,01775H  	; JH: attack #2
	.word	0,0			; robo attack #1
	.word	0,0			; robo attack #2
	.word	sp_voice1|16,0157cH  	; kang: attack #1
	.word	sp_voice1|23,01581H  	; kang: attack #2
	.word	sp_voice1|20,05dcH	; Sheeva attack #1
	.word	sp_voice1|22,05e1H	; Sheeva attack #2
	.word	sp_voice1|35,025e4H	; Shao Kahn: Attack #1
	.word	sp_voice1|37,025e9H	; Shao Kahn: Attack #2



gs_jump
	.word	1
	.word	sp_voice1|21,07eeH   	; Girl #1: jump
	.word	sp_voice1|19,0bd6H	; VP: jump
	.word	sp_voice1|12,0fbeH	; DF: jump
	.word	sp_voice1|15,013a6H	; EB: jump
	.word	sp_voice1|15,0178eH	; JH: jump
	.word	0,0			; robo = sans
	.word	sp_voice1|20,0159aH 	; kang: jump
	.word	sp_voice1|20,05faH	; Sheeva jump
	.word	sp_voice1|37,025e9H	; Shao Kahn: Attack #2

gs_grab
	.word	1
	.word	sp_voice1|20,07dfH	; girl grab
	.word	sp_voice1|17,0bc7H	; VP: grab ??
	.word	sp_voice1|17,0fafH	; DF: grab ??
	.word	sp_voice1|21,01397H	; EB: grab ??
	.word	sp_voice1|18,0177fH	; JH: grab ??
	.word	sp_voice1|36,01b5dH 	; robo: grab
	.word	sp_voice1|11,0158bH 	; kang: grab
	.word	sp_voice1|22,05ebH	; Sheeva grab
	.word	sp_voice1|35,025e4H	; Shao Kahn: Attack #1


gs_slam
	.word	1
	.word	sp_voice1|60,07e4H	; girl throw voice
	.word	sp_voice1|52,0bccH	; VP: throw voice
	.word	sp_voice1|44,0fb4H	; DF: throw voice
	.word	sp_voice1|54,0139cH	; EB: throw voice
	.word	sp_voice1|41,01784H	; JH: throw voice
	.word	sp_voice1|43,01b62H 	; robo: throw voice
	.word	sp_voice1|40,01590H 	; kang: throw voice
	.word	sp_voice1|53,05f0H	; Sheeva throw
	.word	sp_voice1|35,025e4H	; Shao Kahn: Attack #1

gs_wasted
	.word	2
	.word	sp_voice1|58,0811H   	; Girl #1: Wast #1
	.word	sp_voice1|63,0816H   	; Girl #1: Wast #2
	.word	sp_voice1|46,0bf9H	; VP: Wast #1
	.word	sp_voice1|59,0bfeH	; VP: Wast #2
	.word	sp_voice1|57,0fe1H	; DF: Wast
	.word	sp_voice1|54,0fe6H	; DF: Wast
	.word	sp_voice1|63,013c9H  	; EB: Wast #1
	.word	sp_voice1|57,013ceH  	; EB: Wast #2
	.word	sp_voice1|82,017b1H  	; JH: Wast #1
	.word	sp_voice1|72,017b6H  	; JH: Wast #2
	.word	sp_effect|62,01b58H 	; robo: wasted
	.word	sp_effect|54,01b67H 	; robo: wasted
	.word	sp_voice1|126,015bdH 	; kang: Wast #1
	.word	sp_voice1|105,015c2H 	; kang: Wast #2
	.word	sp_voice1|74,061dH	; Sheeva wasted #1
	.word	sp_voice1|72,0622H	; Sheeva wasted #2
	.word	sp_voice1|55,02602H	; Shao Kahn: Wast #1
	.word	sp_voice1|61,02607H	; Shao Kahn: Wast #2


; free sheeva speech call (ejbpatch)
	.word	sp_voice1|42,0618H	; Sheeva medium wasted



gp_female	.set	0
gp_male1		.set	1	; Vince
gp_male2		.set	2	; Dan Forden
gp_male3		.set	3	; E Boon
gp_male4		.set	4
gp_robo		.set	5
gp_kang		.set	6
gp_sheeva	.set	7
gp_shao_kahn	.set	8

ochar_voice_groups
	.word	gp_male3	; 0
	.word	gp_female	; 1
	.word	gp_male3	; 2
	.word	gp_male2	;
	.word	gp_male4	;

	.word	gp_male1	;
	.word	gp_female	;
	.word	gp_robo		;
	.word	gp_robo		;
	.word	gp_male4	;

	.word	gp_male1	;
	.word	gp_sheeva	;
	.word	gp_male3	;
	.word	gp_kang		;
	.word	gp_robo		; smoke

	.word	-1
	.word	gp_shao_kahn	; shao kahn
	.word	gp_male4	;
	.word	gp_male4	;

;************************************************************************

rsnd_enemy_boom
	movk	3,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_effect|28,02daH 	; 3 - lia fireball hit
	.word	sp_effect|20,02f3H  	; 0 - swat bomb explode (borrow)
	.word	sp_effect|78,01f4H	; 0 - Jax Cannon fire



rsnd_sk_bonus_win
	movk	5,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_voice1|122,024efH	; 1 - Shao Kahn: That was Pathetic
	.word	sp_voice1|110,024e0H	; 2 - Shao Kahn: You will never win
	.word	sp_voice1|118,024f4H	; 3 - Shao Kahn: You're still trying to win?
	.word	sp_voice1|86,02503H	; 4 - Shao Kahn: Don't make me laugh
	.word	sp_kahnvc|63,023a5H	; 5 - Shao Kahn: I win

rsnd_splish
	movk	3,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_effect|18,0415H 	; 22 - splish 1
	.word	sp_effect|14,041aH 	; 23 - splish 2
	.word	sp_effect|39,041fH 	; 24 - splish 3

rsnd_stab
	movk	4,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_effect|25,0dcH 	;
	.word	sp_effect|25,0e1H 	;
	.word	sp_effect|46,0e6H 	;
	.word	sp_effect|30,0ebH 	;
	
rsnd_footstep
	movk	4,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_effect|11,014aH	; 5 - foot step #1
	.word	sp_effect|13,014fH	; 6 - foot step #2
	.word	sp_effect|12,0154H	; 7 - foot step #3
	.word	sp_effect|7,0159H	; 8 - foot step #4


rsnd_big_block
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_block1|33,06eH	; block a Major hit
	.word	sp_block1|33,06eH	; block a Major hit

rsnd_small_block
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_block1|15,073H	; block
	.word	sp_block1|15,073H	; block

rsnd_smack
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_hit1|17,082H		; 13 - face hit #1
	.word	sp_hit1|18,087H		; 14 - face hit #2

rsnd_med_smack
	movk	3,a0
	callr	next_table_sound
	.word	sp_hit1|45,010eH
	.word	sp_hit1|35,0118H
	.word	sp_hit1|43,011dH

rsnd_klang
	movk	2,a0
	callr	next_table_sound
	.word	sp_hit1|23,018bH		; 2 - klang 1 !!
	.word	sp_hit1|26,0190H		; 3 - klang 2 (the sequel) !!


rsnd_big_smack
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_hit2|45,0f0H		; 2 - Old big hit #1
	.word	sp_hit2|45,0f5H		; 3 - Old big hit #2

rsnd_rocks
	movk	5,a0
	callr	next_table_sound
	.word	sp_effect|18,0127H		;      Rock #1
	.word	sp_effect|13,012cH		;      Rock #2
	.word	sp_effect|30,0131H		;      Rocks #1
	.word	sp_effect|18,0136H		;      Rocks #2
	.word	sp_effect|21,013bH		;      Rocks #3

sweep_sounds
	callr	rsnd_big_whoosh
	clr	a0
	jruc	group_sound

; *********************************************************** end of voices

rsnd_body_hit
	movk	2,a0
	callr	next_table_sound
	.word	sp_hit1|22,078H 		; 10 - body hit #1
	.word	sp_hit1|21,07dH		; 11 - body hit #2

rsnd_ground
	movk	4,a0
	callr	next_table_sound
	.word	sp_ground|32,0b9H  	; 2c - fall #1
	.word	sp_ground|22,0beH  	; 2d - fall #2
	.word	sp_ground|40,0c3H  	; 2e - fall #3
	.word	sp_ground|35,0c8H  	; 2f - fall #4

rsnd_whoosh
	movk	4,a0
	callr	next_table_sound
	.word	sp_woosh1|16,0a5H 	; 24 - whoosh #1
	.word	sp_woosh1|23,0aaH 	; 25 - whoosh #2
	.word	sp_woosh1|20,0afH 	; 26 - whoosh #3
	.word	sp_woosh1|18,096H 	; 21 - big whoosh #2

rsnd_big_whoosh
	movk	2,a0
	callr	next_table_sound
	.word	sp_woosh1|26,091H 	; 20 - big whoosh #1
	.word	sp_woosh1|20,09bH 	; 22 - big whoosh #3


; weapon whoosh
	.word	sp_woosh1|20,0a0H 	; 23 - big whoosh #4

; medium wasted
	.word	sp_voice1|23,0177aH  	; JH

;*************************************************************************

next_table_sound
	pull	a1			; a1 = first sound table entry

	move	@f_nosound,b3,w	 	; are we allowed ??
	jrne	send_rets	 	; no

	calla	randu
	dec	a0
	sll	5,a0
	add	a1,a0

	mmtm	sp,a0,a1,a2,a3,a4,a5
	jruc	tsnd0

**************************************************************************
*											     *
*  triple_sound - Make a sound call from the triple_sndtab sound table   *
* 											     *
*  input: a0 = sound call offset into table					     *
*											     *
**************************************************************************
triple_sound
	move	@f_nosound,b3,w	 	; are we allowed ??
	jrne	send_rets	 	; no

	mmtm	sp,a0,a1,a2,a3,a4,a5
	sll	5,a0		 	; 32 bits per table entry
	addi	triple_sndtab,a0 	; a0 --> our entry
	cmpi	triple_end,a0	 	; past the end of the table ?
	jrhs	tsnd9		 	; yes, sans

tsnd0	move	*a0+,a1,w		; a1 = [priority , duration]
	jreq	tsnd9			; zero entry = skip
;	jrn	triple_tune		; ffff = tune script

	move	a1,a4
	srl	8,a1			; a1 = priority only
	sll	32-8,a4
	srl	32-8,a4			; a4 = duration only
	move	*a0+,a3,w		; a3 = channel 1 sound call
*
* a1 = priority
* a3 = channel 1 sound call
* a4 = duration
*
	move	a1,a5
	srl     4,a5
	sll	12,a5
	cmpi	sp_dontin,a5		; dont interupt myself special call ??
	jrne	only2			; no, we are fine....

	movi	chan1pri,a5
only3	move	*a5,a0,w		; get this channel's priority
	cmp	a0,a1			; same priority as me ?
	jreq	tsndno			; yes ---> dont send another
	addi	16+16+32,a5
	cmpi	chan5pri+(16+16+32),a5
	jrne	only3			; check every channel
	jruc	only1			; no match ----> business as usual
*
* if only 1 channel allowed ---> send on same channel (avoid overlap)
*
only2	cmpi	sp_only1,a5		; only 1 allowed ?
	jrne	only1			; no, we are fine....

	move	a1,a5
	sll	8,a5
	cmpi	sp_voice1,a5		; player voice ?
	jrne	only4			; no
	move	*a8(oid),a2,w
	cmpi	oid_p1,a2		; player 1 ?
	jreq	only4			; yes, we are fine
	movi	sp_voice2/0100H,a1  	; no, look for voice 2 priority.

only4	clr	b0
	not	b0
	movi	chan1dur-(16+16+32),a2
	movi	chan1pri-(16+16+32),a5
only0	inc	b0
	cmpi	5,b0
	jreq	only1			; no matching priority ---> do sound
	addi	16+16+32,a2
	addi	16+16+32,a5
	move	*a5,a0,w		; get this channel's priority
	cmp	a0,a1			; same priority as me ?
	jrne	only0
	sll	5,b0
	addi	send_code_longs,b0
	move	*b0,b0,l
	jump	b0			; send on same channel to avoid overlap

only1	movi	chan1pri,a5
	movi	chan1dur,a2
	move	@chan1pri,a0,w
	jreq	tsnd1			; channel 1

	movi	chan2pri,a5
	movi	chan2dur,a2
	move	@chan2pri,a0,w
	jreq	tsnd2			; channel 2

	movi	chan3pri,a5
	movi	chan3dur,a2
	move	@chan3pri,a0,w
	jreq	tsnd3			; channel 3

	movi	chan4pri,a5
	movi	chan4dur,a2
	move	@chan4pri,a0,w
	jreq	tsnd4			; channel 4

	movi	chan5pri,a5
	movi	chan5dur,a2
	move	@chan5pri,a0,w
	jreq	tsnd5			; channel 5
*
* all channels used up ---> find the smallest priority
*
	clr	a14			; assume channel 1
	movi	chan1pri,a5
	move	*a5,a0,w		; chan 1 pri
	move	@chan2pri,a2,w		; chan 2 pri
	cmp	a0,a2			; channel 2 bigger priority ??
	jrhs	used4			; yes
	movi	chan2pri,a5		; ok, now 2 is the smallest
	movk	1,a14			; channel = 2

used4	move	*a5,a0,w		; chan ? pri
	move	@chan3pri,a2,w		; chan 3 pri
	cmp	a0,a2			; channel 3 bigger priority ??
	jrhs	used5			; yes
	movi	chan3pri,a5		; ok, now 3 is the smallest
	movk	2,a14			; channel = 3

used5	move	*a5,a0,w		; chan ? pri
	move	@chan4pri,a2,w		; chan 4 pri
	cmp	a0,a2			; channel 4 bigger priority ??
	jrhs	used6			; yes
	movi	chan4pri,a5		; ok, now 4 is the smallest
	movk	3,a14			; channel = 4

used6	move	*a5,a0,w		; chan ? pri
	move	@chan5pri,a2,w		; chan 5 pri
	cmp	a0,a2			; channel 5 bigger priority ??
	jrhs	used7			; yes
	movi	chan5pri,a5		; ok, now 5 is the smallest
	movk	4,a14			; channel = 5

used7	add	a14,a3			; a3 = proper channel

;************ ejbnew
	move	a5,a2
	addk	16,a2			; a2 = proper duration pointer
;************ ejbnew

	move	*a5,a0,w		; a0 = smallest priority
	cmp	a0,a1			; who is more important ?
	jrhs	tsnd1			; me ---> do it

tsndno	mmfm	sp,a0,a1,a2,a3,a4,a5
	clrc
	rets

tsnd5	inc	a3			; channel 5 sound call
tsnd4	inc	a3			; channel 4 sound call
tsnd3	inc	a3			; channel 3 sound call
tsnd2	inc	a3			; channel 2 sound call
tsnd1	move	a1,*a5,w		; stuff new priority
	move	a4,*a2,w		; stuff new duration
	callr	send_code_a3

tsnd9	mmfm	sp,a0,a1,a2,a3,a4,a5
	setc	 			; carry set = success
	rets


send_code_longs
	.long	tsnd1
	.long	tsnd2
	.long	tsnd3
	.long	tsnd4
	.long	tsnd5

**************************************************************************
*											     *
*   tune script decoding									     *
*; not working										     *
**************************************************************************
;triple_tune
;	addk	16,a0
;	move	*a0,a1,l		; a1 = tune table
;	move	*a1+,a2,w 		; a2 = priority
;
;	movb	*a1(8),a0 		; grab player 1 channel
;	move	*a13(procid),a3,w
;	cmpi	pid_p1,a3		; player 1 ?
;	jreq	tune4			; yes
;	movb	*a1,a0			; grab player 1 channel
;tune4	addk	16,a1			; a1 ---> next command
;
;	dec	a0	     		; a0 = channel = (0-2)
;	sll	6,a0	     		; 64 bits / channel ram storage area
;	addi	chan1ram,a0  		; a0 = our channel's ram         
;	move	*a0(sndpri),a3,w 	; a3 = current priority		
;	cmp	a3,a2		 	; who is more important ?
;	jrlo	tune9		 	; not me...
;
;	move	a2,*a0(sndpri),w 	; i am the new priority !!
;	callr	do_tune_commands
;
;tune9	mmfm	sp,a0,a1,a2,a3,a4,a5
;	rets

**************************************************************************
*											     *
*  psound_for_him - lets a player make a sound call for another player   *
*                   by pretending he is him for an instant		     *
* 											     *
*  input: a0 = sound call 2 make								     *
*											     *
**************************************************************************
psound_for_him
	mmtm	sp,a8,a13
	move	*a13(p_otherguy),a8,l
	move	*a13(p_otherproc),a13,l
	calla	triple_sound
	mmfm	sp,a8,a13
	rets

**************************************************************************
*												*
*  nosounds											*
*												*
*  cancells all sound calls. zeros all priorities and stops all		*
*  currently running tunes.									*
*												*
**************************************************************************
nosounds
	mmtm	sp,a0,a1
	clr	a3
	callr	send_code_a3		; silence the music board
	callr	clear_sound_ram
	mmfm	sp,a0,a1
	rets

clear_sound_ram
	clr	a0
	movi	chan1ram,a1
nos2	move	a0,*a1+,w		; zero u out !!!
	cmpi	chan5scp+32,a1		; everyone cleared ??
	jrne	nos2			; nope, do more
	rets

**************************************************************************
*												*
*  do_tune_commands										*
*												*
*  run and execute a list of tune commands until a "sleep" or "endtune"	*
*  is reached											*
*												*
*  input:											*
*	a0 = top of current channel's ram storage                       *
*	a1 = current script position 							*
*												*
**************************************************************************
do_tune_commands
	move	*a1+,a3,w			; get [parameter,command]
	sll	16,a3
	srl	16,a3				; mask out the "ffff" scum

	move	a3,a2				; save [command,parameter]
	sll	24,a2
	srl	24,a2
	dec	a2   				; a2 = command offset
	sll	5,a2

	addi	tune_commands,a2
	move	*a2,a2,l			; grab address
	jump	a2				; execute

tune_commands		
	.long	tc_send		; 1
	.long	tc_setpri	; 2
	.long	tc_endtune	; 3
	.long	tc_sleep	; 4
	.long	tc_send2	; 5


tc_send
	srl	8,a3		    	; yes --> a3 = code to send
	calla	send_code_a3	    	; send it and return
	jruc	do_tune_commands

tc_setpri
	srl	8,a3		    	; yes --> a3 = priority to set to
	move	a3,*a1(sndpri),w    	; set it
	jruc	do_tune_commands

tc_endtune
	clr	a1
	move	a1,*a0(sndpri),w
	move	a1,*a0(snddur),w
	move	a1,*a0(sndscp),l  	; clear this channel		
	rets

tc_sleep
	srl	8,a3		  	; yes --> a3 = sleep time
	move	a3,*a0(snddur),w  	; store into duration area
	move	a1,*a0(sndscp),l  	; save current script pointer
	clr	a1		  	; signal --> we are done
	rets

tc_send2
	push	a1			; save script position
tcs1	subk	8,a1
	movb	*a1,a2
	cmpi	endtune,a2		; search backwards for "endtune"
	jrne	tcs1
	addk	24,a1			; a1 ---> channel
	movb	*a1,a2			; a2 = current channel
	pull	a1			; restore script position

	cmpi	1,a2
	jreq	tcs2
	cmpi	2,a2
	jreq	tcs2		  	; channel 1 or 2 = player 1

	movb	*a1,a3		  	; grab it player 2 sound call
	sll	8,a3			; adjust for next line of code

tcs2	addk	8,a1		  	; a1 ---> next command
	srl	8,a3		  	; yes --> a3 = code to send
	calla	send_code_a3	  	; send it and return
	jruc	do_tune_commands


tc_setpri2
	srl	8,a3		    	; yes --> a3 = priority to set to
	move	a3,*a1(sndpri),w    	; set it
	jruc	do_tune_commands

**************************************************************************
*												*
*  sound updater 										*
*												*
*  routine to hanle all the timing of sound calls and sound tune		*
*  scripts. this routine must be called every tick (16 milliseconds)	*
*												*
**************************************************************************
soundup
	move	@chan1dur,a0,w			; channel #1 timing down ?
	jreq	sup2				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan1dur,w			; update duration ram
	jrne	sup2

	move	@chan1scp,a1,l			; we doing a tune script ?
	jreq	sup1				; no
	movi	chan1pri,a0			; a0 = input = chan 1 ram pointer
	callr	do_tune_commands
	jruc	sup2
sup1	move	a1,@chan1pri,w			; no script --> priority = 0

sup2	move	@chan2dur,a0,w			; channel #2 timing down ?
	jreq	sup3				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan2dur,w			; update duration ram
	jrne	sup3
	move	@chan2scp,a1,l			; a1 = input = chan 2 script point
	jreq	sup25				; we are not processing a tune !!
	movi	chan2pri,a0			; a0 = input = chan 2 ram pointer
	callr	do_tune_commands
	jruc	sup3
sup25	move	a1,@chan2pri,w			; no script --> priority = 0

sup3	move	@chan3dur,a0,w			; channel #3 timing down ?
	jreq	sup4				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan3dur,w			; update duration ram
	jrne	sup4
	move	@chan3scp,a1,l			; a1 = input = chan 3 script point
	jreq	sup35				; we are not processing a tune !!
	movi	chan3pri,a0			; a0 = input = chan 3 ram pointer
	callr	do_tune_commands
	jruc	sup4
sup35	move	a1,@chan3pri,w			; no script --> priority = 0

sup4	move	@chan4dur,a0,w			; channel #4 timing down ?
	jreq	sup5				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan4dur,w			; update duration ram
	jrne	supexit
	move	@chan4scp,a1,l			; a1 = input = chan 4 script point
	jreq	sup45				; we are not processing a tune !!
	movi	chan4pri,a0			; a0 = input = chan 4 ram pointer
	callr	do_tune_commands
	rets
sup45	move	a1,@chan4pri,w			; no script --> priority = 0

sup5	move	@chan5dur,a0,w			; channel #5 timing down ?
	jreq	supexit				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan5dur,w			; update duration ram
	jrne	supexit
	move	@chan5scp,a1,l			; a1 = input = chan 5 script point
	jreq	sup55				; we are not processing a tune !!
	movi	chan5pri,a0			; a0 = input = chan 5 ram pointer
	callr	do_tune_commands
	rets
sup55	move	a1,@chan5pri,w			; no script --> priority = 0

supexit	rets

**************************************************************************
*												*
*  send code a3											*
*												*
*  this does the actual sending of the sound code (in a3) to the port	*
*  at location @sound.										*
*												*
**************************************************************************
send_code_a3
	mmtm	sp,a0,a1,a2,a3,a4
	move	@f_nosound,a0,w		; are we allowed ??
	jrne	sendx			; no
*
* send high byte
*
	move	a3,a0
	sll	32-16,a3
	srl	32-8,a3			; a3 = high byte
 	callr	poll_sirq
	jrnn	sendx
	move	a3,@sound		; hit sound (low)
*
* send low byte
*
	sll	32-8,a0
	srl	32-8,a0			; a3 = low byte
	callr	poll_sirq
	move	a0,@sound		; hit sound (low)

sendx	mmfm	sp,a0,a1,a2,a3,a4
	rets

send_rets
	rets	

poll_sirq
 	movi	108000000/(machine_cycle*10),a4 ;108 milliseconds til time out
poll3	movb	@soundirq+b_sirq-7,a1
	jrn	poll9						; done?
	dsj	a4,poll3
	sra	1,a4			;time out -> clear n flag
poll9	rets

**************************************************************************
*												*
*  reset sound board										*
*												*
*  this is a full reset, checksum dings and all. this is the same routin *
*  that was in the old (gspsnd) processor. (ed boon) 				*
*												*
**************************************************************************
sndres:
	mmtm	sp,a0

; MJL - This IS a bug - coin counters are WRITE ONLY
;	move	@coin_counters,a0,w
;	ori	030H,a0			; set bit 5 (i/o sub system reset)
	movi	030H,a0
; MJL END
;	andni	010H,a0			; reset sound board is here
	move	a0,@coin_counters,w

;	movi	resetbit,a0	;hit reset bit
;	move	a0,@sound

	movi	6000,a0			; wait for it to catch
sndrl:	dsjs	a0,sndrl

;	movi	0ffffh,a0		; let it go
;	move	a0,@sound

; MJL - This IS a bug - coin counters are WRITE ONLY
;	move	@coin_counters,a0,w
;	ori	020H,a0			; set both bits ---> let it go
;	andni	010H,a0
	movi	020H,a0
; MJL End
	move	a0,@coin_counters,w

	mmfm	sp,a0
	rets

**************************************************************************
*												*
*  partial sound board reset									*
*												*
*  same as above but with no checksum dings.						*
*			 --									*
**************************************************************************
sndresp:
	callr	sndres
	clr	a3
	jruc	send_code_a3

;***************************************************************************

hob_ochar_sound
	movi	ochar_sound,a14
	jruc	hob0

hit_or_blocked_sound
	movi	triple_sound,a14
hob0	move	b2,b2
	jrne	hob4
	srl	16,a0 		; a0 = [hit sound , blocked sound]
hob4	zext	a0,w
	jump	a14

;***************************************************************************

full_volume
	movi	055aaH,a3
	callr	send_code_a3
	movi	0ff00H,a3
	jruc	send_code_a3

;************************************************************************

ochar_sound
	move	*a8(ochar),a1,w
	sll	5,a1
	addi	ochar_sound_tables,a1
	move	*a1,a1,l
	sll	5,a0
	add	a1,a0
	mmtm	sp,a0,a1,a2,a3,a4,a5
	jruc	tsnd0

his_ochar_sound
	move	*a8(ochar),a1,w
	push	a1
	move	*a13(p_otherguy),a1,l
	move	*a1(ochar),*a8(ochar),w	; borrow his ochar
	callr	ochar_sound

restore_ochar
	pull	a1
	move	a1,*a8(ochar),w		; restore my ochar
	rets


rsnd_ochar_sound
	move	a0,a1
	zext	a0,w
	srl	16,a1
	calla	randu
	dec	a0
	add	a1,a0
	jruc	ochar_sound



*
* a0 = sound
* a1 = ochar to borrow from
*
borrow_ochar_sound
	move	*a8(ochar),a2,w
	push	a2
	move	a1,*a8(ochar),w
	callr	ochar_sound
	jruc	restore_ochar

ochar_sound_tables
	.long	st_kano
	.long	st_sonya
	.long	st_jax
	.long	st_indian
	.long	st_subzero

	.long	st_swat
	.long	st_lia
	.long	st_robo1
	.long	st_robo2
	.long	st_lao

	.long	st_tusk
	.long	st_sg
	.long	st_shang
	.long	st_lk
	.long	st_robo2
	.long	st_motaro
	.long	st_sk

	.long	st_kano
	.long	st_subzero


st_kano
	.word	sp_effect|52,01feH 	; 0 - Kano ax
	.word	sp_effect|70,0203H 	; 1 - Kano spinning knife
	.word	sp_hit1|24,0163H		; 2 - Kano knife hit
	.word	sp_block1|20,024eH	; 3 - Kano knife blocked
	.word	sp_effect|61,0208H   	; 4 - Kano ball trajectory
	.word	sp_effect|56,0352H  	; 5 - kano laser (borrow)
	.word	sp_effect|76,0276aH  	; 6 - kano laser burn
	.word	sp_effect|25,02c1H 	; 7 - skeleton rip (borrow)
	.word	sp_ground|35,0c8H  	; 8 - skin falling to ground



st_sonya
	.word	sp_effect|59,0230H  	; 0 - sonya rings
	.word	sp_hit1|49,025dH 	; 1 - sonya rings hit
	.word	sp_block1|20,0262H 	; 2 - sonya rings blocked
	.word	sp_effect|45,02d0H 	; 3 - sonya bike kick
	.word	sp_effect|50,0212H	; 4 - Sonya Fly
	.word	sp_voice1|74,0898H	; 5 - Sonya bike kick voice (nwtowtdutb)
	.word	sp_effect|69,02d5H 	; 6 - Sonya blow kiss borrow
	.word	sp_hit2|69,02805H 	; 7 - death quake loop borrow


st_jax
	.word	sp_effect|78,01f4H	; 0 - Jax Cannon fire
	.word	sp_hit1|46,0267H 	; 1 - jax zap hit
	.word	sp_block1|20,026cH 	; 2 - jax zap blocked
	.word	sp_effect|63,02bcH 	; 3 - jax blurr
	.word	sp_effect|72,031bH 	; 4 - jax ground smash
	.word	sp_effect|55,0104H 	; 5 - jax slamming you on ground
	.word	sp_voice1|35,01464H 	; 6 - jax: Gotcha !!
	.word	sp_effect|20,02814H 	; 7 - jax arm morph sound
	.word	sp_effect|25,02c1H 	; 8 - crunch !
	.word	sp_effect|32,0d2H 	; 9 - crunch #1
	.word	sp_effect|69,02805H 	; a - death quake loop borrow
	.word	sp_effect|25,02c1H 	; b - bax break




st_subzero
	.word	sp_effect|72,0217H   	; 0 - ice up
	.word	sp_effect|50,021cH   	; 1 - ice down
	.word	sp_effect|38,0280H   	; 2 - ice hit
	.word	sp_block1|16,0285H   	; 3 - ice blocked
	.word	sp_effect|40,020dH   	; 4 - ice hit
	.word	sp_effect|62,032aH   	; 5 - hit by decoy
	.word	sp_effect|40,0343H 	; 6 - slide
	.word	sp_effect|69,02d5H 	; 7 - Sonya blow kiss borrow
	.word	sp_effect|30,02792H	; 8 - froze dude


st_swat
	.word	sp_effect|20,02f3H  	; 0 - swat bomb explode (borrow)
	.word	sp_effect|44,035cH   	; 1 - swat bomb throw (borrow)
	.word	sp_effect|43,0361H 	; 2 - swat zoom (borrow)
	.word	sp_effect|45,02d0H 	; 3 - swat stick sweep kick (borrow)
	.word	sp_effect|28,036bH 	; 4 - swat zoom throw
	.word	sp_effect|15,073H 	; 5 - swat gun bang
	.word	sp_effect|37,0276fH 	; 6 - taser shock sound
	.word	sp_effect|31,02f8H  	; 7 - swat taser gun FIRE !
	.word	sp_effect|49,02873H  	; 8 - whistle

st_indian
	.word	sp_effect|41,0226H   	; 0 - arrow appear
	.word	sp_effect|82,01f9H   	; 1 - arrow fire
	.word	sp_effect|100,0221H  	; 2 - burning axe
	.word	sp_effect|28,0244H  	; 3 - arrow hit
	.word	sp_block1|20,0249H  	; 4 - arrow blocked
	.word	sp_effect|52,01feH 	; 5 - indian axe up
	.word	sp_effect|25,02c1H 	; 6 - knee break
	.word	sp_effect|44,02c6H 	; 7 - reflector
	.word	sp_effect|40,02cbH 	; 8 - shadow shoulder
	.word	sp_effect|61,0348H 	; 9 - axe hit

	.word	sp_effect|36,027ceH 	; a - ind light start
	.word	sp_effect|72,027d3H 	; b - ind light loop
	.word	sp_effect|46,027d8H 	; c - ind light end
	.word	sp_effect|102,0140H	; d - lightning hit axe
	.word	sp_effect|99,0145H	; e - lightning hit him!


st_lia
	.word	sp_effect|69,022bH  	; 0 - hair throw sound
	.word	sp_effect|98,0276H  	; 1 - scream trap !!
	.word	sp_effect|69,02d5H 	; 2 - lia fireball
	.word	sp_effect|28,02daH 	; 3 - lia fireball hit
	.word	sp_effect|25,02dfH 	; 4 - lia fireball blocked
	.word	sp_effect|50,0307H  	; 5 - lia fly up
	.word	sp_effect|82,030cH  	; 6 - lia fly across
	.word	sp_effect|87,027a1H  	; 7 - lia hair tornado
	.word	sp_effect|69,02805H 	; 8 - death quake loop borrow
	.word	sp_voice1|86,089dH	; 9 - that was fun


st_robo1
st_robo2
	.word	sp_effect|23,0235H  	; 0 - robo arm OUT
	.word	sp_effect|38,023fH  	; 1 - robo arm THROW
	.word	sp_effect|17,023aH  	; 2 - robo arm IN
	.word	sp_effect|74,0253H  	; 3 - robo fast rocket
	.word	sp_effect|246,0258H  	; 4 - robo criuse rocket
	.word	sp_effect|57,027bH  	; 5 - robo net throw
	.word	sp_hit1|46,0267H 	; 6 - jax zap hit
	.word	sp_effect|61,0302H  	; 7 - robo drop through ground tele
	.word	sp_effect|20,02e9H  	; 8 - robo metal ball clang 1
	.word	sp_effect|20,02eeH  	; 9 - robo metal ball clang 2
	.word	sp_effect|20,02f3H  	; a - robo metal ball BOOM
	.word	sp_effect|25,02b7H  	; b - robo chest open
	.word	sp_effect|45,02a3H  	; c - robo target sound
	.word	sp_effect|31,02f8H  	; d - robo explode himself
	.word	sp_effect|28,02fdH  	; e - robo implode himself
	.word	sp_effect|29,0294H  	; f - robo spark #1
	.word	sp_effect|28,0299H  	; 10 - robo spark #2
	.word	sp_effect|40,029eH 	; 11 - robo spark #3
	.word	sp_effect|62,01b58H 	; 12 - robo speech 1
	.word	sp_effect|36,01b5dH 	; 13 - robo speech 2
	.word	sp_effect|43,01b62H 	; 14 - robo speech 3
	.word	sp_effect|36,0311H 	; 15 - robo speech 3
	.word	sp_effect|63,0181H 	; 16 - crusher comes out
	.word	sp_effect|59,02797H 	; 17 - crusher down !
	.word	sp_effect|56,02779H 	; 18 - crusher smoosh
	.word	sp_effect|95,027f6H 	; 19 - crusher smoosh
	.word	sp_effect|12,02729H 	; 1a - beep
	.word	sp_effect|72,02738H 	; 1b - self destruct sounds !!
	.word	sp_effect|33,02747H 	; 1c - self destruct laugh !!
	.word	sp_effect|87,027a1H 	; 1d - 
	.word	sp_effect|69,02805H 	; 1e - death quake loop borrow
	.word	sp_effect|46,0e6H 	; 1f - spear stab
	.word	sp_effect|67,04e3eH 	; 20 - bat sound
	.word	sp_effect|31,02869H 	; 21 - slide whistle
	.word	sp_effect|61,0286eH 	; 22 - horn


st_lao
	.word	sp_effect|32,02e4H  	; 0 - kung lao angle kick
	.word	sp_effect|74,02a8H  	; 1 - lao hat throw
	.word	sp_effect|72,02adH  	; 2 - lao hat hit
	.word	sp_effect|33,02b2H  	; 3 - lao hat bloked
	.word	sp_effect|61,0302H  	; 4 - lao tele (ejbpatch-borrowed from robo)
	.word	sp_effect|56,010aeH  	; 5 - lao throw
	.word	sp_effect|87,027a1H  	; 6 - lao tornado
	.word	sp_effect|69,02805H 	; 7 - death quake loop borrow
	.word	sp_effect|29,0274cH  	; 8 - lao tornado


st_tusk
	.word	sp_effect|28,02daH 	; 0 - lia fireball hit
	.word	sp_effect|50,0334H	; 1 - fire (photon fire)
	.word	sp_effect|59,0370H 	; 2 - blurr (borrwed)
	.word	sp_effect|11,0195H 	; 3 - kabal flip whoosh #1
	.word	sp_effect|16,019aH 	; 4 - kabal flip whoosh #2
	.word	sp_effect|72,02adH  	; 5 - tusk saw
	.word	sp_effect|44,02c6H 	; 6 - reflector
	.word	sp_effect|19,02783H  	; 7 - 
	.word	sp_effect|19,027c9H  	; 8 - 
	.word	sp_effect|19,0287dH  	; 9 - scary head scream 
	.word	sp_effect|100,0221H  	; a - burning axe
 
st_sg
	.word	sp_effect|40,0375H  	; 0 - sg tele
	.word	sp_effect|55,0104H 	; 1 - she pounce / jax slamming you on ground
	.word	sp_hit1|49,025dH 	; 2 - sg zap hit (borrow)
	.word	sp_effect|55,037aH	; 3 - sg zap
	.word	sp_effect|61,0302H  	; 4 - sg start zap (borrow)
	.word	sp_hit1|26,0190H		; 5 - klang 2 (the sequel) !!
	.word	sp_effect|87,0285fH  	; 6 - spin plate


st_shang
	.word	sp_effect|78,01f4H	; 0 - Jax Cannon fire
	.word	sp_effect|60,033eH 	; 1 - summon
	.word	sp_hit1|32,02daH 	; 2 - fireball hit
	.word	sp_effect|59,0230H  	; 3 - sonya rings (skull fire)
	.word	sp_effect|43,0357H 	; 4 - morph
	.word	sp_ground|35,0c8H  	; 5 - shang tsung flip tumble sound
	.word	sp_hit1|25,02dfH 	; 6 - fireball block
	.word	sp_effect|59,027ecH 	; 7 - sword rise
	.word	sp_effect|172,02841H 	; 8 - energy cloud
	.word	sp_effect|29,0277eH 	; 9 - bonz


st_lk
	.word	sp_effect|53,0339H 	; 0 - lk fireball
	.word	sp_effect|46,032fH 	; 1 - lk fireball hit
	.word	sp_effect|50,0212H	; 2 - super kick
	.word	sp_effect|29,034dH	; 3 - lk fireball blocked
	.word	sp_voice1|84,015ccH 	; 4 - bike kick jibberish
	.word	sp_voice1|93,015dbH 	; 5 - flying kick yell
	.word	sp_effect|56,027abH	; 6 - flame morph
	.word	sp_runrun|80,01595H 	; 7 - kang: run (borrow)
	.word	sp_effect|55,0104H 	; 8 - jax slamming you on ground


st_motaro
	.word	sp_voice1|81,0251cH 	; 0 -
	.word	sp_voice1|97,02521H 	; 1 -
	.word	sp_voice1|62,02526H 	; 2 -
	.word	sp_voice1|35,0252bH 	; 3 - motaro hit 1
	.word	sp_voice1|64,02530H 	; 4 - motaro hit 2
	.word	sp_effect|50,0334H	; 5 - fire (photon fire)

st_sk
	.word	sp_effect|40,02cbH 	; 0 - shadow shoulder (borrow)
	.word	sp_effect|50,0334H	; 1 - fire photon (borrow from kabal)
	.word	sp_hit1|23,018bH		; 2 - klang 1 !!
	.word	sp_hit1|26,0190H		; 3 - klang 2 (the sequel) !!
	.word	sp_voice1|151,023beH	; 4 - Shao Kahn: Laugh #1
	.word	sp_voice1|126,023c3H	; 5 - Shao Kahn: Laugh #2
	.word	sp_voice1|149,023c8H	; 6 - Shao Kahn: Laugh #3
	.word	sp_voice1|122,024efH	; 7 - Shao Kahn: That was Pathetic
	.word	sp_voice1|110,024e0H	; 8 - Shao Kahn: You will never win
	.word	sp_voice1|118,024f4H	; 9 - Shao Kahn: You're still trying to win?
	.word	sp_voice1|86,02503H	; a - Shao Kahn: Don't make me laugh

;************************************************************************

	.end
