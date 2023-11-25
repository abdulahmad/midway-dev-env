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

send	.set	>0001			; script command --> send sound code
setpri	.set	>0002			; script command --> set priority
endtune	.set	>0003			; script command --> end of tune script
sleep	.set	>0004			; script command --> sleep next byte
send2	.set	>0005

sndpri	.set	0			; priority offset
snddur	.set	10h			; duration offset
sndscp	.set	20h			; script pointer offset

ex	.set	>8000			; flag: extended sound call !!

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

sp_woosh1	.set	>10*>100
sp_ground	.set	>18*>100
sp_block1	.set	>1f*>100

sp_dontin	.set	>30*>100		; 30's = dont interupt myself
sp_runrun	.set	>31*>100

sp_only1		.set	>40*>100		; 40's = special (dont overlap)
sp_voice1	.set	>41*>100		; player 1 voice 
sp_voice2	.set	>42*>100		; player 2 voice
sp_windy1	.set	>43*>100

sp_effect	.set	>50*>100
sp_animal	.set	>53*>100
sp_hit1		.set	>55*>100
sp_hit2		.set	>61*>100
sp_kahnvc	.set	>62*>100
;sp_bonusv	.set	>63*>100

sp_train		.set	>65*>100

sp_coin		.set	>7f*>100

**************************************************************************
*											     *
*    TRIPLE SOUND TABLE format:								     *
* 											     *
*              .word   >aaaa,>bbbb							     *
* 											     *
*       where:  aaaa = priority / duration						     *
*               bbbb = channel 1 sound call					     *
*											     *
**************************************************************************
triple_sndtab
	.word	sp_effect|102,>140	; 0 - Explode thru street
	.word	sp_effect|99,>145	; 1 - Explode thru street
	.word	sp_woosh1|28,>16d	; 2 - roundhouse whoosh
	.word	sp_effect|62,>40b	; 3 - big door closing
	.word	sp_effect|102,>410	; 4 - big door slam shut
	.word	sp_windy1|217,>3e8	; 5 - wind
	.word	sp_woosh1|16,>a5 	; 6 - whoosh #1
	.word	sp_woosh1|20,>af 	; 7 - whoosh #3
	.word	sp_effect|54,>3ed  	; 8 - subway approaching
	.word	sp_effect|17,>3f2   	; 9 - subway steady state
	.word	sp_effect|62,>3f7   	; a - subway going away
	.word	sp_effect|87,>42e   	; b - crowd: "Ooooo"
	.word	sp_effect|14,>43d   	; c - p1 cursor
	.word	sp_effect|17,>442   	; d - p2 cursor
	.word	sp_effect|50,>447   	; e - p1 picked
	.word	sp_effect|48,>44c   	; f - p2 picked
	.word	sp_kahnvc|49,>233c	; 10 - Shao Kahn: Fight! #3
	.word	sp_kahnvc|84,>2341	; 11 - Shao Kahn: Round One
	.word	sp_kahnvc|77,>2346	; 12 - Shao Kahn: Round Two
	.word	sp_kahnvc|72,>234b	; 13 - Shao Kahn: Round Three
	.word	sp_kahnvc|69,>2350	; 14 - Shao Kahn: Round Four
	.word	sp_kahnvc|54,>2328	; 15 - Shao Kahn: Finish Him!
	.word	sp_kahnvc|62,>232d	; 16 - Shao Kahn: Finish Her!
	.word	sp_effect|10,>424  	; 17 - clock time down tik !!
	.word	sp_effect|10,>186  	; 18 - players feet landing on ground
	.word	sp_effect|58,>460	; 19 - 1 player map zoom sound
	.word	sp_coin|90,>24cc	; 1a - COIN = Shao Kahn: Outstanding

	.word	sp_effect|38,>1095	; 1b - DF: toasty
	.word	sp_effect|43,>1090	; 1c - DF: frosty
	.word	sp_effect|47,>1077	; 1d - DF: crispy
	.word	sp_effect|37,>276f 	; 1e - shock sound !!

	.word	sp_effect|69,>2d5 	; 1f - flame throw
	.word	sp_effect|144,>27b5 	; 20 - burning flames!!
	.word	sp_effect|29,>277e 	; 21 - bones fall
	.word	sp_effect|40,>2823 	; 22 - pit machine sound
	.word	sp_effect|56,>2779 	; 23 - pit machine sound
	.word	sp_effect|32,>d2 	; 24 - crunch #1
	.word	sp_effect|33,>d7 	; 25 - crunch #2
	.word	sp_effect|47,>288c 	; 26 - animality sizzle
	.word	sp_effect|43,>357 	; 27 - animality morph

	.word	sp_kahnvc|54,>236e	; 28 - Shao Kahn: Kano
	.word	sp_kahnvc|58,>2391	; 29 - Shao Kahn: Sonya
	.word	sp_kahnvc|59,>2369	; 2a - Shao Kahn: Jax
	.word	sp_kahnvc|79,>2490	; 2b - Shao Kahn: Night Wolf
	.word	sp_kahnvc|65,>239b	; 2c - Shao Kahn: Sub-Zero
	.word	sp_kahnvc|53,>2396	; 2d - Shao Kahn: Stryker
	.word	sp_kahnvc|64,>249a	; 2e - Shao Kahn: Sindel
	.word	sp_kahnvc|66,>2495	; 2f - Shao Kahn: Sektor
	.word	sp_kahnvc|68,>248b	; 30 - Shao Kahn: Cyrax
	.word	sp_kahnvc|57,>23a0	; 31 - Shao Kahn: Kung Lao
	.word	sp_kahnvc|42,>2364	; 32 - Shao Kahn: Kabal
	.word	sp_kahnvc|52,>2387	; 33 - Shao Kahn: Sheeva
	.word	sp_kahnvc|74,>2382	; 34 - Shao Kahn: Shang Tsung
	.word	sp_kahnvc|65,>2378	; 35 - Shao Kahn: Liu Kang
	.word	sp_kahnvc|50,>238c	; 38 - Shao Kahn: Smoke
	.word	sp_kahnvc|56,>237d	; 37 - Shao Kahn: Motaro
	.word	0,0			; 38 -
	.word	sp_kahnvc|109,>24fe	; 39 - Shao Kahn: Choose your destiny
	.word	sp_animal|78,>4e34	; 3a - Huge animal ROAR!
	.word	sp_effect|10,>46f 	; 3b - player buys in !!
	.word	sp_effect|47,>4e39 	; 3c - animality sizzle

	.word	sp_bonusv|111,>2413	; 3d - Shao Kahn: Kano wins
	.word	sp_bonusv|115,>2436	; 3e - Shao Kahn: Sonya wins
	.word	sp_bonusv|108,>240e	; 3f - Shao Kahn: Jax wins
	.word	sp_bonusv|137,>24a4	; 3f - Shao Kahn: Nightwolf wins
	.word	sp_bonusv|121,>2440	; 41 - Shao Kahn: Sub-Zero wins
	.word	sp_bonusv|111,>243b	; 42 - Shao Kahn: Stryker wins
	.word	sp_bonusv|113,>24ae	; 43 - Shao Kahn: Sindel wins
	.word	sp_bonusv|112,>24a9	; 44 - Shao Kahn: Sector wins
	.word	sp_bonusv|113,>249f	; 45 - Shao Kahn: Cyrax wins
	.word	sp_bonusv|116,>2445	; 46 - Shao Kahn: Kung Lao wins
	.word	sp_bonusv|100,>2409	; 47 - Shao Kahn: Cabal wins
	.word	sp_bonusv|110,>242c	; 48 - Shao Kahn: Sheeva wins
	.word	sp_bonusv|131,>2427	; 49 - Shao Kahn: Shang Tsung wins
	.word	sp_bonusv|121,>241d	; 4a - Shao Kahn: Liu Kang wins
	.word	sp_bonusv|108,>2431	; 4b - Shao Kahn: Smoke wins
	.word	sp_bonusv|113,>2422	; 4c - Shao Kahn: Motaro wins
	.word	sp_bonusv|53,>23a5	; 4d - Shao Kahn: I win

	.word	sp_kahnvc|142,>2454	; 4e - Shao Kahn: Kano shows mercy
	.word	sp_kahnvc|146,>2477	; 4f - Shao Kahn: Sonya shows mercy
	.word	sp_kahnvc|138,>244f	; 50 - Shao Kahn: Jax shows mercy
	.word	sp_kahnvc|132,>24b8	; 51 - Shao Kahn: Nightwolf shows mercy
	.word	sp_kahnvc|153,>2481	; 52 - Shao Kahn: Sub-Zero shows mercy
	.word	sp_kahnvc|141,>247c	; 53 - Shao Kahn: Stryker shows mercy
	.word	sp_kahnvc|125,>24c2	; 54 - Shao Kahn: Sindel shows mercy
	.word	sp_kahnvc|144,>24bd	; 55 - Shao Kahn: Sektor shows mercy
	.word	sp_kahnvc|144,>24b3	; 56 - Shao Kahn: Cyrax shows mercy
	.word	sp_kahnvc|145,>2486	; 57 - Shao Kahn: Kung Lao shows mercy
	.word	sp_kahnvc|130,>244a	; 58 - Shao Kahn: Cabal shows mercy
	.word	sp_kahnvc|140,>246d	; 59 - Shao Kahn: Sheeva shows mercy
	.word	sp_kahnvc|162,>2468	; 5a - Shao Kahn: Shang Tsung shows mercy
	.word	sp_kahnvc|153,>245e	; 5b - Shao Kahn: Liu Kang shows mercy
	.word	sp_kahnvc|124,>2472	; 5c - Shao Kahn: Smoke shows mercy
	.word	sp_effect|117,>045b	; 5d - mercy music hit
	.word	0,0			; 5e
	.word	0,0			; 5f
	.word	sp_bonusv|60,>4e39	; 60 - animality bonus count roar !!

	.word	sp_bonusv|90,>2337	; 61 - Shao Kahn: Flawless Victory
	.word	sp_bonusv|79,>2332	; 62 - Shao Kahn: Fatality!
	.word	sp_bonusv|54,>23d2	; 63 - Shao Kahn: Mercy
	.word	sp_bonusv|62,>23d7	; 64 - Shao Kahn: Animality
	.word	sp_bonusv|63,>23dc	; 65 - Shao Kahn: Babality

	.word	sp_kahnvc|63,>23e1	; 66 - Shao Kahn: Crispy
	.word	sp_kahnvc|66,>23e6	; 67 - Shao Kahn: Frosty
	.word	sp_bonusv|56,>23eb	; 68 - Shao Kahn: Friendship
	.word	sp_bonusv|49,>23f0	; 69 - Shao Kahn: Friendship!?!
	.word	sp_bonusv|51,>23f5	; 6a - Shao Kahn: Again?
	.word	0,0			; 6b - 
	.word	sp_kahnvc|66,>23ff	; 6c - Shao Kahn: Toasty Low
	.word	sp_kahnvc|66,>2404	; 6d - Shao Kahn: Oh maw

	.word	0,0			; 6e
	.word	0,0			; 6f
	.word	sp_effect|61,>279c  	; 70 - nasty goo
	.word	sp_effect|53,>406  	; 71 - danger !!
	.word	sp_effect|120,>47e  	; 72 - flawless tone
	.word	0,0			; 73
	.word	sp_kahnvc|64,>23aa	; 74 - Shao Kahn: Superb
	.word	sp_kahnvc|66,>23af	; 75 - Shao Kahn: Well Done
	.word	sp_kahnvc|46,>23b4	; 76 - Shao Kahn: ... versus ...
	.word	sp_kahnvc|68,>23b9	; 77 - Shao Kahn: ... wins
	.word	sp_kahnvc|88,>23cd	; 78 - Shao Kahn: ... shows mercy
	.word	sp_kahnvc|151,>23be	; 79 - Shao Kahn: Laugh #1
	.word	sp_kahnvc|126,>23c3	; 7a - Shao Kahn: Laugh #2
	.word	sp_kahnvc|149,>23c8	; 7b - Shao Kahn: Laugh #3

	.word	sp_kahnvc|67,>24c7	; 7c - Shao Kahn: Excellent
	.word	sp_kahnvc|110,>24e0	; 7d - Shao Kahn: You will never win
	.word	sp_kahnvc|90,>24cc	; 7e - Shao Kahn: Outstanding
	.word	sp_hit2|45,>f0		; 7f - Shao Kahn last hit

	.word	sp_effect|50,>334	; 80 - hidden game fire sound
	.word	sp_effect|20,>2f3  	; 81 - player ship explodes
	.word	sp_kahnvc|122,>24ef	; 82 - Shao Kahn: That was Pathetic
	.word	sp_coin|23,>18b		; 83 - klang 1 !!

	.word	sp_train|50,>3ed	; 84 - subway approaching
	.word	sp_train|117,>3f2	; 85 - subway steady state
	.word	sp_train|62,>3f7	; 86 - subway going away

	.word	sp_train|69,>2805	; 87 - Final Death Quake Loop
	.word	sp_train|228,>280a	; 88 - Shao Kahn Death Scream
	.word	sp_train|209,>280f	; 89 - Final Death Quake Loop Crescendo (3x)
	.word	sp_effect|21,>27e2	; 8a - dog
	.word	sp_effect|21,>27e7	; 8b - dog ouch
	.word	sp_effect|20,>2f3  	; 8c - babality poof
	.word	sp_train|160,>27fb  	; 8d - baby cry
	.word	sp_effect|130,>429  	; 8e - bell

	.word	sp_kahnvc|149,>24e5	; 8f - Shao Kahn: Its official
	.word	sp_kahnvc|64,>237d	; 90 - Shao Kahn: Motaro
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
	.word	sp_voice1|203,>81b 	; girl = eb
	.word	sp_voice1|269,>c03 	; vp = hey
	.word	sp_voice1|121,>feb 	; df = df
	.word	sp_voice1|193,>17bb 	; eb
	.word	sp_voice1|193,>13d3 	; 4 = eb
	.word	sp_voice1|193,>17bb 	; 5 = hey
	.word	sp_voice1|229,>15c7 	; kang
	.word	sp_voice1|90,>627	; Sheeva death
	.word	sp_voice1|61,>2607	; Shao Kahn: Wast #2

gs_shook
	.word	1
	.word	sp_voice1|63,>816   	; Girl #1: Wast #2
	.word	sp_voice1|95,>c80	; VP: shook
	.word	sp_voice1|95,>c80	; DF: shook
	.word	sp_voice1|151,>1455	; EB: shook
	.word	sp_voice1|151,>1455	; EB: shook
	.word	sp_voice1|61,>1b6c 	; robo: shook
	.word	sp_runrun|80,>1595 	; kang: run (borrow)
	.word	sp_voice1|74,>61d	; Sheeva wasted #1
	.word	sp_voice1|55,>2602	; Shao Kahn: Wast #1



gs_run
	.word	1
	.word	sp_runrun|107,>7e9  	; Girl #1: run
	.word	sp_runrun|70,>bd1	; VP: run
	.word	sp_runrun|89,>fb9	; DF: run
	.word	sp_runrun|69,>13a1	; EB: run
	.word	sp_runrun|71,>1789	; JH: run
	.word	sp_runrun|61,>1b6c 	; robo: run
	.word	sp_runrun|80,>1595 	; kang: run
	.word	sp_voice1|73,>5f5	; Sheeva running attack
	.word	sp_voice1|73,>5f5	; Sheeva running attack
	.word	0,0


gs_tripped_voice
	.word	1
	.word	sp_voice1|21,>807   	; Girl #1: tripped voice
	.word	sp_voice1|30,>bc7	; VP: attack #1
	.word	sp_voice1|18,>fd7	; DF: tripped
	.word	sp_voice1|21,>13bf	; EB: tripped
	.word	sp_voice1|26,>17a7	; JH: tripped
	.word	0,0			; robo
	.word	sp_voice1|26,>15b3	; JH: tripped
	.word	sp_voice1|21,>613	; Sheeva tripped
	.word	sp_voice1|26,>25ee	; Shao Kahn: React #1

gs_face_hit_voice
	.word	3
	.word	sp_voice1|34,>7f3   	; Girl: hit in face voice
	.word	sp_voice1|33,>7f8   	; Girl: hit in face voice
	.word	sp_voice1|33,>7f8   	; Girl: hit in face voice

	.word	sp_voice1|28,>bdb	; VP: hit in face voice
	.word	sp_voice1|28,>bdb	; VP: hit in face voice
	.word	sp_voice1|31,>be0	; VP: hit in face voice

	.word	sp_voice1|26,>fc3  	; DF: hit in face voice
	.word	sp_voice1|26,>fc3  	; DF: hit in face voice
	.word	sp_voice1|30,>fc8  	; DF: hit in face voice

	.word	sp_voice1|20,>13ab  	; EB: hit in face voice
	.word	sp_voice1|29,>13b0  	; EB: hit in face voice
	.word	sp_voice1|29,>13b0  	; EB: hit in face voice

	.word	sp_voice1|30,>1793  	; JH: hit in face voice
	.word	sp_voice1|27,>1798  	; JH: hit in face voice
	.word	sp_voice1|22,>185b  	; JH: hit in face voice

	.word	sp_effect|28,>299  	; robo: hit in face
	.word	sp_effect|28,>299  	; robo: hit in face
	.word	sp_effect|40,>29e 	; robo: hit in face

	.word	sp_voice1|28,>159f  	; kang: hit in face voice
	.word	sp_voice1|28,>159f  	; kang: hit in face voice
	.word	sp_voice1|19,>15a4  	; kang: hit in face voice

	.word	sp_voice1|25,>5ff	; Sheeva face hit #1
	.word	sp_voice1|17,>60e	; Sheeva body hit #2
	.word	sp_voice1|33,>604	; Sheeva face hit #2

	.word	sp_voice1|26,>25ee	; Shao Kahn: React #1
	.word	sp_voice1|31,>25f3	; Shao Kahn: React #2
	.word	sp_voice1|38,>25f8	; Shao Kahn: React #3


gs_attack
	.word	2			; 2 entries per group
	.word	sp_voice1|28,>7d0   	; Girl #1: attack #1
	.word	sp_voice1|22,>7d5   	; Girl #1: attack #2
	.word	sp_voice1|26,>bb8	; VP: attack #1
	.word	sp_voice1|26,>bbd	; VP: attack #2
	.word	sp_voice1|19,>fa0  	; DF: attack #1
	.word	sp_voice1|18,>fa5  	; DF: attack #2
	.word	sp_voice1|19,>1388  	; EB: attack #1
	.word	sp_voice1|21,>138d  	; EB: attack #2
	.word	sp_voice1|23,>1770  	; JH: attack #1
	.word	sp_voice1|31,>1775  	; JH: attack #2
	.word	0,0			; robo attack #1
	.word	0,0			; robo attack #2
	.word	sp_voice1|16,>157c  	; kang: attack #1
	.word	sp_voice1|23,>1581  	; kang: attack #2
	.word	sp_voice1|20,>5dc	; Sheeva attack #1
	.word	sp_voice1|22,>5e1	; Sheeva attack #2
	.word	sp_voice1|35,>25e4	; Shao Kahn: Attack #1
	.word	sp_voice1|37,>25e9	; Shao Kahn: Attack #2



gs_jump
	.word	1
	.word	sp_voice1|21,>7ee   	; Girl #1: jump
	.word	sp_voice1|19,>bd6	; VP: jump
	.word	sp_voice1|12,>fbe	; DF: jump
	.word	sp_voice1|15,>13a6	; EB: jump
	.word	sp_voice1|15,>178e	; JH: jump
	.word	0,0			; robo = sans
	.word	sp_voice1|20,>159a 	; kang: jump
	.word	sp_voice1|20,>5fa	; Sheeva jump
	.word	sp_voice1|37,>25e9	; Shao Kahn: Attack #2

gs_grab
	.word	1
	.word	sp_voice1|20,>7df	; girl grab
	.word	sp_voice1|17,>bc7	; VP: grab ??
	.word	sp_voice1|17,>faf	; DF: grab ??
	.word	sp_voice1|21,>1397	; EB: grab ??
	.word	sp_voice1|18,>177f	; JH: grab ??
	.word	sp_voice1|36,>1b5d 	; robo: grab
	.word	sp_voice1|11,>158b 	; kang: grab
	.word	sp_voice1|22,>5eb	; Sheeva grab
	.word	sp_voice1|35,>25e4	; Shao Kahn: Attack #1


gs_slam
	.word	1
	.word	sp_voice1|60,>7e4	; girl throw voice
	.word	sp_voice1|52,>bcc	; VP: throw voice
	.word	sp_voice1|44,>fb4	; DF: throw voice
	.word	sp_voice1|54,>139c	; EB: throw voice
	.word	sp_voice1|41,>1784	; JH: throw voice
	.word	sp_voice1|43,>1b62 	; robo: throw voice
	.word	sp_voice1|40,>1590 	; kang: throw voice
	.word	sp_voice1|53,>5f0	; Sheeva throw
	.word	sp_voice1|35,>25e4	; Shao Kahn: Attack #1

gs_wasted
	.word	2
	.word	sp_voice1|58,>811   	; Girl #1: Wast #1
	.word	sp_voice1|63,>816   	; Girl #1: Wast #2
	.word	sp_voice1|46,>bf9	; VP: Wast #1
	.word	sp_voice1|59,>bfe	; VP: Wast #2
	.word	sp_voice1|57,>fe1	; DF: Wast
	.word	sp_voice1|54,>fe6	; DF: Wast
	.word	sp_voice1|63,>13c9  	; EB: Wast #1
	.word	sp_voice1|57,>13ce  	; EB: Wast #2
	.word	sp_voice1|82,>17b1  	; JH: Wast #1
	.word	sp_voice1|72,>17b6  	; JH: Wast #2
	.word	sp_effect|62,>1b58 	; robo: wasted
	.word	sp_effect|54,>1b67 	; robo: wasted
	.word	sp_voice1|126,>15bd 	; kang: Wast #1
	.word	sp_voice1|105,>15c2 	; kang: Wast #2
	.word	sp_voice1|74,>61d	; Sheeva wasted #1
	.word	sp_voice1|72,>622	; Sheeva wasted #2
	.word	sp_voice1|55,>2602	; Shao Kahn: Wast #1
	.word	sp_voice1|61,>2607	; Shao Kahn: Wast #2


; free sheeva speech call (ejbpatch)
	.word	sp_voice1|42,>618	; Sheeva medium wasted



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
	.word	sp_effect|28,>2da 	; 3 - lia fireball hit
	.word	sp_effect|20,>2f3  	; 0 - swat bomb explode (borrow)
	.word	sp_effect|78,>1f4	; 0 - Jax Cannon fire



rsnd_sk_bonus_win
	movk	5,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_voice1|122,>24ef	; 1 - Shao Kahn: That was Pathetic
	.word	sp_voice1|110,>24e0	; 2 - Shao Kahn: You will never win
	.word	sp_voice1|118,>24f4	; 3 - Shao Kahn: You're still trying to win?
	.word	sp_voice1|86,>2503	; 4 - Shao Kahn: Don't make me laugh
	.word	sp_kahnvc|63,>23a5	; 5 - Shao Kahn: I win

rsnd_splish
	movk	3,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_effect|18,>415 	; 22 - splish 1
	.word	sp_effect|14,>41a 	; 23 - splish 2
	.word	sp_effect|39,>41f 	; 24 - splish 3

rsnd_stab
	movk	4,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_effect|25,>dc 	;
	.word	sp_effect|25,>e1 	;
	.word	sp_effect|46,>e6 	;
	.word	sp_effect|30,>eb 	;
	
rsnd_footstep
	movk	4,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_effect|11,>14a	; 5 - foot step #1
	.word	sp_effect|13,>14f	; 6 - foot step #2
	.word	sp_effect|12,>154	; 7 - foot step #3
	.word	sp_effect|7,>159	; 8 - foot step #4


rsnd_big_block
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_block1|33,>6e	; block a Major hit
	.word	sp_block1|33,>6e	; block a Major hit

rsnd_small_block
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_block1|15,>73	; block
	.word	sp_block1|15,>73	; block

rsnd_smack
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_hit1|17,>82		; 13 - face hit #1
	.word	sp_hit1|18,>87		; 14 - face hit #2

rsnd_med_smack
	movk	3,a0
	callr	next_table_sound
	.word	sp_hit1|45,>10e
	.word	sp_hit1|35,>118
	.word	sp_hit1|43,>11d

rsnd_klang
	movk	2,a0
	callr	next_table_sound
	.word	sp_hit1|23,>18b		; 2 - klang 1 !!
	.word	sp_hit1|26,>190		; 3 - klang 2 (the sequel) !!


rsnd_big_smack
	movk	2,a0			; a0 = # of possible choices
	callr	next_table_sound
	.word	sp_hit2|45,>f0		; 2 - Old big hit #1
	.word	sp_hit2|45,>f5		; 3 - Old big hit #2

rsnd_rocks
	movk	5,a0
	callr	next_table_sound
	.word	sp_effect|18,>127		;      Rock #1
	.word	sp_effect|13,>12c		;      Rock #2
	.word	sp_effect|30,>131		;      Rocks #1
	.word	sp_effect|18,>136		;      Rocks #2
	.word	sp_effect|21,>13b		;      Rocks #3

sweep_sounds
	callr	rsnd_big_whoosh
	clr	a0
	jruc	group_sound

; *********************************************************** end of voices

rsnd_body_hit
	movk	2,a0
	callr	next_table_sound
	.word	sp_hit1|22,>78 		; 10 - body hit #1
	.word	sp_hit1|21,>7d		; 11 - body hit #2

rsnd_ground
	movk	4,a0
	callr	next_table_sound
	.word	sp_ground|32,>b9  	; 2c - fall #1
	.word	sp_ground|22,>be  	; 2d - fall #2
	.word	sp_ground|40,>c3  	; 2e - fall #3
	.word	sp_ground|35,>c8  	; 2f - fall #4

rsnd_whoosh
	movk	4,a0
	callr	next_table_sound
	.word	sp_woosh1|16,>a5 	; 24 - whoosh #1
	.word	sp_woosh1|23,>aa 	; 25 - whoosh #2
	.word	sp_woosh1|20,>af 	; 26 - whoosh #3
	.word	sp_woosh1|18,>96 	; 21 - big whoosh #2

rsnd_big_whoosh
	movk	2,a0
	callr	next_table_sound
	.word	sp_woosh1|26,>91 	; 20 - big whoosh #1
	.word	sp_woosh1|20,>9b 	; 22 - big whoosh #3


; weapon whoosh
	.word	sp_woosh1|20,>a0 	; 23 - big whoosh #4

; medium wasted
	.word	sp_voice1|23,>177a  	; JH

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
	movi	sp_voice2/>100,a1  	; no, look for voice 2 priority.

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
;	ori	>30,a0			; set bit 5 (i/o sub system reset)
	movi	>30,a0
; MJL END
;	andni	>10,a0			; reset sound board is here
	move	a0,@coin_counters,w

;	movi	resetbit,a0	;hit reset bit
;	move	a0,@sound

	movi	6000,a0			; wait for it to catch
sndrl:	dsjs	a0,sndrl

;	movi	0ffffh,a0		; let it go
;	move	a0,@sound

; MJL - This IS a bug - coin counters are WRITE ONLY
;	move	@coin_counters,a0,w
;	ori	>20,a0			; set both bits ---> let it go
;	andni	>10,a0
	movi	>20,a0
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
	movi	>55aa,a3
	callr	send_code_a3
	movi	>ff00,a3
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
	.word	sp_effect|52,>1fe 	; 0 - Kano ax
	.word	sp_effect|70,>203 	; 1 - Kano spinning knife
	.word	sp_hit1|24,>163		; 2 - Kano knife hit
	.word	sp_block1|20,>24e	; 3 - Kano knife blocked
	.word	sp_effect|61,>208   	; 4 - Kano ball trajectory
	.word	sp_effect|56,>352  	; 5 - kano laser (borrow)
	.word	sp_effect|76,>276a  	; 6 - kano laser burn
	.word	sp_effect|25,>2c1 	; 7 - skeleton rip (borrow)
	.word	sp_ground|35,>c8  	; 8 - skin falling to ground



st_sonya
	.word	sp_effect|59,>230  	; 0 - sonya rings
	.word	sp_hit1|49,>25d 	; 1 - sonya rings hit
	.word	sp_block1|20,>262 	; 2 - sonya rings blocked
	.word	sp_effect|45,>2d0 	; 3 - sonya bike kick
	.word	sp_effect|50,>212	; 4 - Sonya Fly
	.word	sp_voice1|74,>898	; 5 - Sonya bike kick voice (nwtowtdutb)
	.word	sp_effect|69,>2d5 	; 6 - Sonya blow kiss borrow
	.word	sp_hit2|69,>2805 	; 7 - death quake loop borrow


st_jax
	.word	sp_effect|78,>1f4	; 0 - Jax Cannon fire
	.word	sp_hit1|46,>267 	; 1 - jax zap hit
	.word	sp_block1|20,>26c 	; 2 - jax zap blocked
	.word	sp_effect|63,>2bc 	; 3 - jax blurr
	.word	sp_effect|72,>31b 	; 4 - jax ground smash
	.word	sp_effect|55,>104 	; 5 - jax slamming you on ground
	.word	sp_voice1|35,>1464 	; 6 - jax: Gotcha !!
	.word	sp_effect|20,>2814 	; 7 - jax arm morph sound
	.word	sp_effect|25,>2c1 	; 8 - crunch !
	.word	sp_effect|32,>d2 	; 9 - crunch #1
	.word	sp_effect|69,>2805 	; a - death quake loop borrow
	.word	sp_effect|25,>2c1 	; b - bax break




st_subzero
	.word	sp_effect|72,>217   	; 0 - ice up
	.word	sp_effect|50,>21c   	; 1 - ice down
	.word	sp_effect|38,>280   	; 2 - ice hit
	.word	sp_block1|16,>285   	; 3 - ice blocked
	.word	sp_effect|40,>20d   	; 4 - ice hit
	.word	sp_effect|62,>32a   	; 5 - hit by decoy
	.word	sp_effect|40,>343 	; 6 - slide
	.word	sp_effect|69,>2d5 	; 7 - Sonya blow kiss borrow
	.word	sp_effect|30,>2792	; 8 - froze dude


st_swat
	.word	sp_effect|20,>2f3  	; 0 - swat bomb explode (borrow)
	.word	sp_effect|44,>35c   	; 1 - swat bomb throw (borrow)
	.word	sp_effect|43,>361 	; 2 - swat zoom (borrow)
	.word	sp_effect|45,>2d0 	; 3 - swat stick sweep kick (borrow)
	.word	sp_effect|28,>36b 	; 4 - swat zoom throw
	.word	sp_effect|15,>73 	; 5 - swat gun bang
	.word	sp_effect|37,>276f 	; 6 - taser shock sound
	.word	sp_effect|31,>2f8  	; 7 - swat taser gun FIRE !
	.word	sp_effect|49,>2873  	; 8 - whistle

st_indian
	.word	sp_effect|41,>226   	; 0 - arrow appear
	.word	sp_effect|82,>1f9   	; 1 - arrow fire
	.word	sp_effect|100,>221  	; 2 - burning axe
	.word	sp_effect|28,>244  	; 3 - arrow hit
	.word	sp_block1|20,>249  	; 4 - arrow blocked
	.word	sp_effect|52,>1fe 	; 5 - indian axe up
	.word	sp_effect|25,>2c1 	; 6 - knee break
	.word	sp_effect|44,>2c6 	; 7 - reflector
	.word	sp_effect|40,>2cb 	; 8 - shadow shoulder
	.word	sp_effect|61,>348 	; 9 - axe hit

	.word	sp_effect|36,>27ce 	; a - ind light start
	.word	sp_effect|72,>27d3 	; b - ind light loop
	.word	sp_effect|46,>27d8 	; c - ind light end
	.word	sp_effect|102,>140	; d - lightning hit axe
	.word	sp_effect|99,>145	; e - lightning hit him!


st_lia
	.word	sp_effect|69,>22b  	; 0 - hair throw sound
	.word	sp_effect|98,>276  	; 1 - scream trap !!
	.word	sp_effect|69,>2d5 	; 2 - lia fireball
	.word	sp_effect|28,>2da 	; 3 - lia fireball hit
	.word	sp_effect|25,>2df 	; 4 - lia fireball blocked
	.word	sp_effect|50,>307  	; 5 - lia fly up
	.word	sp_effect|82,>30c  	; 6 - lia fly across
	.word	sp_effect|87,>27a1  	; 7 - lia hair tornado
	.word	sp_effect|69,>2805 	; 8 - death quake loop borrow
	.word	sp_voice1|86,>89d	; 9 - that was fun


st_robo1
st_robo2
	.word	sp_effect|23,>235  	; 0 - robo arm OUT
	.word	sp_effect|38,>23f  	; 1 - robo arm THROW
	.word	sp_effect|17,>23a  	; 2 - robo arm IN
	.word	sp_effect|74,>253  	; 3 - robo fast rocket
	.word	sp_effect|246,>258  	; 4 - robo criuse rocket
	.word	sp_effect|57,>27b  	; 5 - robo net throw
	.word	sp_hit1|46,>267 	; 6 - jax zap hit
	.word	sp_effect|61,>302  	; 7 - robo drop through ground tele
	.word	sp_effect|20,>2e9  	; 8 - robo metal ball clang 1
	.word	sp_effect|20,>2ee  	; 9 - robo metal ball clang 2
	.word	sp_effect|20,>2f3  	; a - robo metal ball BOOM
	.word	sp_effect|25,>2b7  	; b - robo chest open
	.word	sp_effect|45,>2a3  	; c - robo target sound
	.word	sp_effect|31,>2f8  	; d - robo explode himself
	.word	sp_effect|28,>2fd  	; e - robo implode himself
	.word	sp_effect|29,>294  	; f - robo spark #1
	.word	sp_effect|28,>299  	; 10 - robo spark #2
	.word	sp_effect|40,>29e 	; 11 - robo spark #3
	.word	sp_effect|62,>1b58 	; 12 - robo speech 1
	.word	sp_effect|36,>1b5d 	; 13 - robo speech 2
	.word	sp_effect|43,>1b62 	; 14 - robo speech 3
	.word	sp_effect|36,>311 	; 15 - robo speech 3
	.word	sp_effect|63,>181 	; 16 - crusher comes out
	.word	sp_effect|59,>2797 	; 17 - crusher down !
	.word	sp_effect|56,>2779 	; 18 - crusher smoosh
	.word	sp_effect|95,>27f6 	; 19 - crusher smoosh
	.word	sp_effect|12,>2729 	; 1a - beep
	.word	sp_effect|72,>2738 	; 1b - self destruct sounds !!
	.word	sp_effect|33,>2747 	; 1c - self destruct laugh !!
	.word	sp_effect|87,>27a1 	; 1d - 
	.word	sp_effect|69,>2805 	; 1e - death quake loop borrow
	.word	sp_effect|46,>e6 	; 1f - spear stab
	.word	sp_effect|67,>4e3e 	; 20 - bat sound
	.word	sp_effect|31,>2869 	; 21 - slide whistle
	.word	sp_effect|61,>286e 	; 22 - horn


st_lao
	.word	sp_effect|32,>2e4  	; 0 - kung lao angle kick
	.word	sp_effect|74,>2a8  	; 1 - lao hat throw
	.word	sp_effect|72,>2ad  	; 2 - lao hat hit
	.word	sp_effect|33,>2b2  	; 3 - lao hat bloked
	.word	sp_effect|61,>302  	; 4 - lao tele (ejbpatch-borrowed from robo)
	.word	sp_effect|56,>10ae  	; 5 - lao throw
	.word	sp_effect|87,>27a1  	; 6 - lao tornado
	.word	sp_effect|69,>2805 	; 7 - death quake loop borrow
	.word	sp_effect|29,>274c  	; 8 - lao tornado


st_tusk
	.word	sp_effect|28,>2da 	; 0 - lia fireball hit
	.word	sp_effect|50,>334	; 1 - fire (photon fire)
	.word	sp_effect|59,>370 	; 2 - blurr (borrwed)
	.word	sp_effect|11,>195 	; 3 - kabal flip whoosh #1
	.word	sp_effect|16,>19a 	; 4 - kabal flip whoosh #2
	.word	sp_effect|72,>2ad  	; 5 - tusk saw
	.word	sp_effect|44,>2c6 	; 6 - reflector
	.word	sp_effect|19,>2783  	; 7 - 
	.word	sp_effect|19,>27c9  	; 8 - 
	.word	sp_effect|19,>287d  	; 9 - scary head scream 
	.word	sp_effect|100,>221  	; a - burning axe
 
st_sg
	.word	sp_effect|40,>375  	; 0 - sg tele
	.word	sp_effect|55,>104 	; 1 - she pounce / jax slamming you on ground
	.word	sp_hit1|49,>25d 	; 2 - sg zap hit (borrow)
	.word	sp_effect|55,>37a	; 3 - sg zap
	.word	sp_effect|61,>302  	; 4 - sg start zap (borrow)
	.word	sp_hit1|26,>190		; 5 - klang 2 (the sequel) !!
	.word	sp_effect|87,>285f  	; 6 - spin plate


st_shang
	.word	sp_effect|78,>1f4	; 0 - Jax Cannon fire
	.word	sp_effect|60,>33e 	; 1 - summon
	.word	sp_hit1|32,>2da 	; 2 - fireball hit
	.word	sp_effect|59,>230  	; 3 - sonya rings (skull fire)
	.word	sp_effect|43,>357 	; 4 - morph
	.word	sp_ground|35,>c8  	; 5 - shang tsung flip tumble sound
	.word	sp_hit1|25,>2df 	; 6 - fireball block
	.word	sp_effect|59,>27ec 	; 7 - sword rise
	.word	sp_effect|172,>2841 	; 8 - energy cloud
	.word	sp_effect|29,>277e 	; 9 - bonz


st_lk
	.word	sp_effect|53,>339 	; 0 - lk fireball
	.word	sp_effect|46,>32f 	; 1 - lk fireball hit
	.word	sp_effect|50,>212	; 2 - super kick
	.word	sp_effect|29,>34d	; 3 - lk fireball blocked
	.word	sp_voice1|84,>15cc 	; 4 - bike kick jibberish
	.word	sp_voice1|93,>15db 	; 5 - flying kick yell
	.word	sp_effect|56,>27ab	; 6 - flame morph
	.word	sp_runrun|80,>1595 	; 7 - kang: run (borrow)
	.word	sp_effect|55,>104 	; 8 - jax slamming you on ground


st_motaro
	.word	sp_voice1|81,>251c 	; 0 -
	.word	sp_voice1|97,>2521 	; 1 -
	.word	sp_voice1|62,>2526 	; 2 -
	.word	sp_voice1|35,>252b 	; 3 - motaro hit 1
	.word	sp_voice1|64,>2530 	; 4 - motaro hit 2
	.word	sp_effect|50,>334	; 5 - fire (photon fire)

st_sk
	.word	sp_effect|40,>2cb 	; 0 - shadow shoulder (borrow)
	.word	sp_effect|50,>334	; 1 - fire photon (borrow from kabal)
	.word	sp_hit1|23,>18b		; 2 - klang 1 !!
	.word	sp_hit1|26,>190		; 3 - klang 2 (the sequel) !!
	.word	sp_voice1|151,>23be	; 4 - Shao Kahn: Laugh #1
	.word	sp_voice1|126,>23c3	; 5 - Shao Kahn: Laugh #2
	.word	sp_voice1|149,>23c8	; 6 - Shao Kahn: Laugh #3
	.word	sp_voice1|122,>24ef	; 7 - Shao Kahn: That was Pathetic
	.word	sp_voice1|110,>24e0	; 8 - Shao Kahn: You will never win
	.word	sp_voice1|118,>24f4	; 9 - Shao Kahn: You're still trying to win?
	.word	sp_voice1|86,>2503	; a - Shao Kahn: Don't make me laugh

;************************************************************************

	.end
