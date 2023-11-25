**************************************************************************
*											     *
*  video game project:	  mortal kombat 3							*
* 											     *
*  programmer:		  edward boon						     *
* 											     *
*  module: textutil.asm -- text utilities						     *
* 											     *
*  copyright (c) 1995 williams electronics games, inc.			     *
*											     *
**************************************************************************
	.file	'mktext.asm'
	.title	" <<< fontz >>> "

	.width	132
	.option	b,d,l
	.mnolist
*
* get the system stuff
*

;	.include	dispequ.asm		; display processor equates
;	.include	sysequ.asm 		; sys.inc and gsp.inc
;	.include	macros.hdr		; macros

	.include	imgtbl.glo
	.include	mainequ.asm
	.include	mktext.tbl
	.include	mktext2.tbl
	.include	stringh.asm


	.even
	.text


p15_centered
	mmtm	sp,a8,a9
	movi	pf_15point,a8
	calla	lm_setup
	mmfm	sp,a8,a9
	jauc	printf

p7_centered
	mmtm	sp,a8,a9
	movi	pf_7point,a8
	calla	lm_setup
	mmfm	sp,a8,a9
	jauc	printf

pds_centered
	mmtm	sp,a8,a9
	movi	pf_dave_smallc,a8
	jruc	pds3

pds_right
	mmtm	sp,a8,a9
	movi	pf_dave_smallr,a8
	jruc	pds3

pds_left
	mmtm	sp,a8,a9
	movi	pf_dave_smalll,a8
pds3	calla	lm_setup
	mmfm	sp,a8,a9
	jauc	printf


pf_15point
	mess_mac rd15font,>0000ffff,0,0,0,strcnrmo_scr,0
	.byte	0
	.even

pf_7point
	mess_mac rd7font,>00000001,0,0,bpal_white*>10000,strcnrmo_scr,0
	.byte	0
	.even

pf_dave_smallc
	mess_mac dave_small_font,>0000ffff,0,0,0,strcnrmo_scr,0
	.byte	0
	.even

pf_dave_smallr
	mess_mac dave_small_font,>0000ffff,0,0,0,strrnrmo_scr,0
	.byte	0
	.even

pf_dave_smalll
	mess_mac dave_small_font,>0000ffff,0,0,0,strlnrmo_scr,0
	.byte	0
	.even

**************************************************************************
*												*
*			  7 POINT FONT							*
*												*
**************************************************************************
rd7font
	.LONG  FONT7excla,FONT7quote,FONT7pound,FONT7doll,FONT7percen
	.LONG  FONT7and
	.LONG  FONT7apost,FONT7parenl,FONT7parenr,FONT7ast,FONT7plus
	.LONG  FONT7comma,FONT7dash,FONT7period,FONT7forsp
FONT7_NUMS
	.LONG  FONT70,FONT71
	.LONG  FONT72,FONT73,FONT74,FONT75,FONT76,FONT77,FONT78,FONT79

	.LONG  FONT7colon,FONT7semicol,FONT7less,FONT7equal,FONT7more
	.LONG  FONT7quest,FONT7line
	.LONG  FONT7A,FONT7B,FONT7C,FONT7D,FONT7E,FONT7F,FONT7G,FONT7H
	.LONG  FONT7I,FONT7J,FONT7K,FONT7L,FONT7M,FONT7N,FONT7O,FONT7P
	.LONG  FONT7Q,FONT7R,FONT7S,FONT7T,FONT7U,FONT7V,FONT7W,FONT7X
	.LONG  FONT7Y,FONT7Z
	.LONG  FONT7excla,FONT7excla,FONT7excla,FONT7excla,FONT7line
	.LONG  FONT7apost	
	.LONG  FONT7A,FONT7B,FONT7C,FONT7D,FONT7E,FONT7F,FONT7G,FONT7H
	.LONG  FONT7I,FONT7J,FONT7K,FONT7L,FONT7M,FONT7N,FONT7O,FONT7P
	.LONG  FONT7Q,FONT7R,FONT7S,FONT7T,FONT7U,FONT7V,FONT7W,FONT7X
	.LONG  FONT7Y,FONT7Z
	.LONG  FONT7excla,FONT7excla,FONT7excla

**************************************************************************
*												*
*			  15 POINT FONT							*
*												*
**************************************************************************

BSCHAR	.SET	BIGFONT_MIN


rd11font
rd15font
     	.long	BIGFONT_EXC,BSCHAR,BSCHAR,BSCHAR,BIGFONT_PERC,BSCHAR
	.long	BIGFONT_APOS,BIGFONT_PR1,BIGFONT_PR2,BSCHAR,BSCHAR
	.long	BIGFONT_COM,BIGFONT_MIN,BIGFONT_PER,BIGFONT_SLA

font15_nums
	.long	BIGFONT_0,BIGFONT_1,BIGFONT_2,BIGFONT_3,BIGFONT_4
	.long	BIGFONT_5,BIGFONT_6,BIGFONT_7,BIGFONT_8,BIGFONT_9

	.long	BIGFONT_COL,BIGFONT_COL,BSCHAR,BSCHAR,BSCHAR
	.long	BIGFONT_QUE,BIGFONT_MIN

	.long	BIGFONT_A,BIGFONT_B,BIGFONT_C,BIGFONT_D,BIGFONT_E,BIGFONT_F,BIGFONT_G
	.long	BIGFONT_H,BIGFONT_I,BIGFONT_J,BIGFONT_K,BIGFONT_L,BIGFONT_M,BIGFONT_N
	.long	BIGFONT_O,BIGFONT_P,BIGFONT_Q,BIGFONT_R,BIGFONT_S,BIGFONT_T,BIGFONT_U
	.long	BIGFONT_V,BIGFONT_W,BIGFONT_X,BIGFONT_Y,BIGFONT_Z

	.long	BSCHAR,BSCHAR,BSCHAR,BSCHAR,BSCHAR,BSCHAR

	.long	BIGFONT_A,BIGFONT_B,BIGFONT_C,BIGFONT_D,BIGFONT_E,BIGFONT_F,BIGFONT_G
	.long	BIGFONT_H,BIGFONT_I,BIGFONT_J,BIGFONT_K,BIGFONT_L,BIGFONT_M,BIGFONT_N
	.long	BIGFONT_O,BIGFONT_P,BIGFONT_Q,BIGFONT_R,BIGFONT_S,BIGFONT_T,BIGFONT_U
	.long	BIGFONT_V,BIGFONT_W,BIGFONT_X,BIGFONT_Y,BIGFONT_Z

	.long	BSCHAR,BSCHAR,BSCHAR

**************************************************************************
*											     *
*  Dave M. Small Font									     *
*											     *
**************************************************************************

SMALLBS	.set	SMALLFONT_MIN

;---> SMALLFONT_PER,SMALLFONT_COL,SMALLFONT_COM,SMALLFONT_EXC,SMALLFONT_MIN
;---> SMALLFONT_PERC,SMALLFONT_PR1,SMALLFONT_PR2,SMALLFONT_QUE,SMALLFONT_SLA

dave_small_font
	.long  SMALLFONT_EXC,FONT7quote,FONT7pound,FONT7doll,SMALLFONT_PER,FONT7and
	.long  SMALLFONT_APOS,SMALLFONT_PR1,SMALLFONT_PR2,FONT7ast,FONT7plus
	.long  SMALLFONT_COM,SMALLFONT_MIN,SMALLFONT_PER,SMALLFONT_SLA

;---> SMALLFONT_OPNQ
;---> SMALLFONT_CLOQ,SMALLFONT_SEMI,BIGFONT_OPNQ,BIGFONT_CLOQ
;---> BIGFONT_SEMI


dave_small_numbers
	.long	SMALLFONT_0,SMALLFONT_1,SMALLFONT_2,SMALLFONT_3,SMALLFONT_4
	.long	SMALLFONT_5,SMALLFONT_6,SMALLFONT_7,SMALLFONT_8,SMALLFONT_9

	.long	SMALLFONT_COL,SMALLFONT_COL,SMALLBS,MK2FONTequ,MK2FONTgrt
	.long	SMALLFONT_QUE,SMALLFONT_MIN

	.long	SMALLFONT_A,SMALLFONT_B,SMALLFONT_C,SMALLFONT_D,SMALLFONT_E
	.long	SMALLFONT_F,SMALLFONT_G,SMALLFONT_H,SMALLFONT_I,SMALLFONT_J
	.long	SMALLFONT_K,SMALLFONT_L,SMALLFONT_M,SMALLFONT_N,SMALLFONT_O
	.long	SMALLFONT_P,SMALLFONT_Q,SMALLFONT_R,SMALLFONT_S,SMALLFONT_T
	.long	SMALLFONT_U,SMALLFONT_V,SMALLFONT_W,SMALLFONT_X,SMALLFONT_Y
	.long	SMALLFONT_Z

	.long	BSCHAR,BSCHAR,BSCHAR,BSCHAR,BSCHAR,BSCHAR

	.long	SMALLFONT_A,SMALLFONT_B,SMALLFONT_C,SMALLFONT_D,SMALLFONT_E
	.long	SMALLFONT_F,SMALLFONT_G,SMALLFONT_H,SMALLFONT_I,SMALLFONT_J
	.long	SMALLFONT_K,SMALLFONT_L,SMALLFONT_M,SMALLFONT_N,SMALLFONT_O
	.long	SMALLFONT_P,SMALLFONT_Q,SMALLFONT_R,SMALLFONT_S,SMALLFONT_T
	.long	SMALLFONT_U,SMALLFONT_V,SMALLFONT_W,SMALLFONT_X,SMALLFONT_Y
	.long	SMALLFONT_Z

	.long	BSCHAR,BSCHAR,BSCHAR

;*********************************************************

	.end
