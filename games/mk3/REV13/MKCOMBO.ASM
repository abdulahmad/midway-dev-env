**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: special moves										*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	"mkcombo.asm"
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
	.text

;*************************************************************************

do_knee
	calla	init_special

	movk	1,a0
	movk	1,a10
	movi	act_knee,a1
	movi	013H,a9
	movi	00eH,a11
	jsrp	striker
	jrnc	jkne5

	pushst
	movi	ochar_knee_combos,a0
	calla	get_char_long
	jreq	knee4

	popst
	move	a0,a11
	jruc	process_combo_table

knee4	popst
	movi	act_knee_sd,a0
	move	a0,*a13(p_action),w	; action: knee sitting duck
	jrnc	jkne5
	sleep	15
jkne5	movk	6,a0
	jauc	retract_strike


knee_elbow_blocked
	sleep	010H
	jauc	retract_strike

;***********************************************************************

do_elbow
	calla	init_special

;	movk	2,a0
	movk	1,a0			; ani speed = fast !!!
	movi	act_elbow,a1
	movi	010H,a9
	movk	5,a10
	movi	00fH,a11
	jsrp	striker
	jrnc	elbow5			; miss

	movi	ochar_elbow_combos,a0
	calla	get_char_long
	jreq	elbow4
	move	a0,a11
	jruc	process_combo_table

elbow4	movi	act_elbow_sd,a0
	move	a0,*a13(p_action),w	; action: elbow sitting duck
	sleep	10

elbow5	movk	3,a0
	movi	act_elbow_sd,a1
	jauc	retract_strike_act	; and retp

ochar_elbow_combos
	.long	ct_kano_elbow2
	.long	ct_sonya_elbow2
	.long	ct_jax_elbow2
	.long	ct_ind_elbow2
	.long	ct_sz_elbow2

	.long	ct_swat_elbow2
	.long	ct_lia_elbow2
	.long	ct_sektor_elbow2
	.long	ct_cyrax_elbow2
	.long	ct_lao_elbow2

	.long	ct_tusk_elbow2
	.long	ct_sg_elbow2
	.long	ct_st_elbow2
	.long	ct_lk_elbow2
	.long	ct_smoke_elbow2

	.long	0
	.long	0

	.long	ct_kano_elbow2
	.long	ct_sz_elbow2


ochar_knee_combos
	.long	ct_kano_knee2	; 0
	.long	ct_sonya_knee2	; 1
	.long	ct_jax_knee2	; 3
	.long	ct_ind_knee2	; 2
	.long	ct_sz_knee2	; 4

	.long	ct_swat_knee2	; 5
	.long	ct_lia_knee	; 6
	.long	ct_sektor_knee2	; 7
	.long	ct_cyrax_knee2
	.long	ct_lao_knee2	; 9

	.long	ct_tusk_knee2	; 10
	.long	ct_sg_knee2
	.long	ct_st_knee2
	.long	ct_lk_knee2
	.long	ct_smoke_knee2	; 14

	.long	0
	.long	0

	.long	ct_kano_knee2	; 17
	.long	ct_sz_knee2	; 18

**************************************************************************
*											     *
*  combo table format:									     *
* 											     *
*     .word   0aaH         where aa = time allowed					*
*     .word   0bbccH       where bb = attack ani    cc = attack ani part  *
*     .word   0ddeeH       where dd = attack speed  ee = button number    *
*     .word   0ffHgg       where ff = retract ani   gg = retract ani part *
*     .word   >hhii       where hh = stk offset	   ii = requirement      *
*     .long   >jjjjjjjj   where jj = success pointer				     *
*											     *
**************************************************************************
cb_hipunch	.set	000H
cb_lopunch	.set	001H
cb_block		.set	002H
cb_hikick	.set	003H
cb_lokick	.set	004H

cb_jump_address	.set	01111H

stk_0		.set	00000H	; hit in face
stk_1		.set	00100H	; stumble away
stk_2		.set	00200H	; knocked on back
stk_3		.set	00300H	; knocked high on back
stk_4		.set	00400H	; NAILED !
stk_5		.set	00500H	; uppercutted
stk_klang	.set	00600H	; hit but with a klang sound !!

stk_1_stab	.set	00700H	; stumble away
stk_2_stab	.set	00800H	; knocked on back
stk_6		.set	00900H	; knocked almost vertical on your back

stk_h0		.set	01000H	; hit in face
stk_h1		.set	01100H	; stumble away
stk_h2		.set	01200H	; knocked on back


c_speed1		.set	00100H
c_speed2		.set	00200H
c_speed3		.set	00300H

last_option	.set	08000H
b_last_option	.set	15

c_time		.set	0
c_attack		.set	16*1	; attack animation
c_speed		.set	16*2	; animation speed , button #
c_retr		.set	16*3	; retract ani: [offset, part #]
c_stk		.set	16*4	; stk offset
c_req		.set	c_stk	; requirement routine
c_next		.set	16*5	; success pointer to next combo table entry
csize		.set	16*7

req_none		.set	0	; requirement: none
req_stkaway	.set	1	; requirement: joystick away
req_stktow	.set	3	; requirement: joystick towards
req_stkdown	.set	4
req_halfdamage	.set	5

retract_elbow	.set	01002H
retract_knee	.set	01302H
retract_lokick	.set	01202H

atk_upcut	.set	00b01H

atk_elbow1	.set	01001H
atk_elbow2	.set	01003H
atk_elbow3	.set	01004H
atk_elbow4	.set	01005H
atk_knee1	.set	01301H
atk_knee2	.set	01303H
atk_knee3	.set	01304H
atk_knee4	.set	01305H
atk_hikick	.set	01101H
atk_lokick	.set	01201H
atk_roundh	.set	01501H

;***********************

ct_tusk_elbow2
	.word	9|last_option		; time allowed
	.word	atk_elbow2		; attack
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow			; retract = elbow
	.word	stk_1_stab|req_halfdamage	; strike check / requirements
	.long	ct_tusk_elbow3



ct_tusk_elbow3
	.word	9			; time allowed
	.word	atk_hikick		; attack
	.word	c_speed2|cb_hikick	; speed,button
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_tusk_knee4

	.word	9			; time allowed
	.word	atk_upcut		; attack = uppercut
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_5|req_stkdown	; strike check / requirements
	.long	010H

	.word	9|last_option			; time allowed
	.word	atk_elbow3			; attack
	.word	c_speed3|cb_lopunch		; speed,button = hi kick
	.word	retract_elbow			; retract = elbow
	.word	stk_1_stab|req_stkdown	; strike check / requirements
	.long	ct_tusk_elbow4

ct_tusk_elbow4
	.word	9|last_option		; time allowed
	.word	atk_elbow4		; attack
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2_stab|req_stkdown	; strike check / requirements
	.long	01aH

ct_tusk_knee2
	.word	9|last_option		; time allowed
	.word	atk_knee2		; attack
	.word	c_speed2|cb_lokick	; speed,button
	.word	retract_knee		; retract = knee
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_tusk_knee3

ct_tusk_knee3
	.word	9			; time allowed
	.word	atk_roundh		; attack = knee #1
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	01304H			; retract = knee 2
	.word	stk_h2|req_stkaway	; strike check / requirements
	.long	010H

	.word	9			; time allowed
	.word	atk_elbow1		; attack
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	01304H			; retract = knee 2
	.word	stk_1_stab|req_none 	; strike check / requirements
	.long	ct_tusk_elbow2

	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack
	.word	c_speed2|cb_hikick	; speed,button
	.word	01304H			; retract = knee 2
	.word	stk_h1|req_none		; strike check / requirements
	.long	ct_tusk_knee4

ct_tusk_knee4
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = knee #1
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	01102H			; retract = hi kick
	.word	stk_h2|req_stkaway	; strike check / requirements
	.long	010H
 
;***********************

ct_sg_knee2
	.word	9|last_option		; time allowed
	.word	atk_knee2		; attack
	.word	c_speed3|cb_hikick	; speed,button
	.word	retract_knee		; retract = knee
	.word	stk_h1|req_none		; strike check / requirements
	.long	ct_sg_knee3

ct_sg_knee3
	.word	9|last_option		; time allowed
	.word	atk_knee3		; attack
	.word	c_speed2|cb_lokick	; speed,button
	.word	retract_knee		; retract = knee
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_sg_knee4

ct_sg_knee4
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack
	.word	c_speed2|cb_hikick	; speed,button
	.word	retract_knee		; retract = knee
	.word	stk_h2|req_stkaway	; strike check / requirements
	.long	012H


ct_sg_elbow2
	.word	9|last_option		; time allowed
	.word	atk_elbow2		; attack
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_h1|req_none		; strike check / requirements
	.long	ct_sg_elbow3

ct_sg_elbow3
	.word	9|last_option		; time allowed
	.word	atk_elbow3		; attack
	.word	c_speed3|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_h1|req_none		; strike check / requirements
	.long	ct_sg_elbow4

ct_sg_elbow4
	.word	9			; time allowed
	.word	atk_knee1		; attack
	.word	c_speed2|cb_hikick	; speed,button
	.word	retract_elbow		; retract = knee
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_sg_knee2

	.word	9|last_option		; time allowed
	.word	atk_elbow4		; attack
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
;	.word	stk_2|req_stktow	; strike check / requirements
	.word	stk_6|req_stktow	; strike check / requirements
	.long	01aH

;***********************

ct_sonya_knee2
	.word	6			; time allowed
	.word	atk_hikick		; attack
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_sonya_roundh

	.word	9|last_option		; time allowed
	.word	atk_elbow1
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_sonya_elbow2

ct_sonya_roundh
	.word	9			; time allowed
	.word	atk_roundh
	.word	c_speed3|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	00eH

ct_sonya_elbow1
	.word	9|last_option		; time allowed

;***********
	.word	01007H
;	.word	atk_elbow1		; attack
;***********

	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_sonya_elbow2

;***********************

ct_ind_knee2
	.word	9			; time allowed
	.word	atk_elbow1		; attack
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_ind_elbow2

	.word	6|last_option		; time allowed
	.word	atk_hikick		; attack
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_ind_roundh

ct_ind_roundh
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = knee #1
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

;***********************

ct_swat_knee2
	.word	9			; time allowed
	.word	atk_elbow1		; attack
	.word	c_speed1|cb_hipunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_swat_elbow2

ct_swat_hikick
	.word	6|last_option		; time allowed
	.word	atk_hikick		; attack
	.word	c_speed2|cb_lokick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_swat_baton

ct_swat_baton
	.word	9			; time allowed
	.word	atk_elbow3		; attack = knee #1
	.word	c_speed1|cb_lopunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_stkaway	; strike check / requirements
	.long	ct_swat_roundh

ct_swat_roundh
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = knee #1
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

;***********************

ct_swat_elbow2
	.word	6|last_option		; time allowed
	.word	atk_elbow2		; attack
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_swat_elbow3

ct_swat_elbow3
	.word	4|last_option		; time allowed
	.word	atk_elbow3		; attack
	.word	c_speed1|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_5|req_none		; strike check / requirements
	.long	008H

;***********************

ct_lk_elbow2
	.word	9			; time allowed
	.word	atk_elbow2		; attack
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_lk_elbow3

ct_lk_knee1
	.word	9|last_option		; time allowed
	.word	atk_knee1		; attack
	.word	c_speed3|cb_lokick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_lk_knee2

ct_lk_elbow3
	.word	9|last_option		; time allowed
	.word	atk_elbow3		; attack
	.word	c_speed3|cb_block	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_lk_knee1

ct_lk_knee2
	.word	9|last_option		; time allowed
	.word	atk_knee2		; attack
	.word	c_speed3|cb_lokick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_h1|req_none		; strike check / requirements
	.long	ct_lk_knee3

ct_lk_knee3
	.word	9|last_option		; time allowed
	.word	atk_knee3		; attack
	.word	c_speed3|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_lk_knee4

ct_lk_knee4
	.word	9|last_option		; time allowed
	.word	atk_knee4		; attack
	.word	c_speed3|cb_lokick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_4|req_none		; strike check / requirements
	.long	014H

;***********************

ct_st_knee2
	.word	9			; time allowed
	.word	atk_elbow1		; attack = elbow 3rd hit
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_st_elbow2

	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack = elbow 3rd hit
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_st_roundh

ct_st_elbow2
	.word	9|last_option		; time allowed
	.word	atk_elbow2		; attack = elbow 3rd hit
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_st_elbow3

ct_st_elbow3
	.word	9|last_option		; time allowed
	.word	atk_elbow3		; attack = elbow 3rd hit
	.word	c_speed3|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_st_roundh

ct_st_roundh
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = knee #1
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

;***********************

ct_kano_elbow2
	.word	9|last_option		; time allowed
	.word	01001H			; attack = elbow #1 AGAIN
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_kano_post_elbow2

ct_kano_knee2
ct_kano_post_elbow2
	.word	9			; time allowed
	.word	atk_knee1		; attack = knee #1
	.word	c_speed3|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_kano_hikick

	.word	9				; time allowed
	.word	atk_elbow2			; attack = elbow #2 (head butt)
	.word	c_speed3|cb_lopunch		; speed,button = hi kick
	.word	retract_elbow			; retract = elbow
	.word	stk_klang|req_stkdown	; strike check / requirements
	.long	ct_kano_diff_upcut

	.word	9|last_option		; time allowed
	.word	atk_upcut		; attack = uppercut
	.word	c_speed2|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_5|req_none		; strike check / requirements
	.long	010H

ct_kano_diff_upcut
	.word	9|last_option		; time allowed
	.word	atk_upcut		; attack = uppercut
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	01004H			; retract = head butt
	.word	stk_5|req_stkdown	; strike check / requirements
	.long	010H

ct_kano_hikick
	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack = knee #1
	.word	c_speed2|cb_lokick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_kano_roundh

ct_kano_roundh
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = knee #1
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

;************************

ct_jax_knee2
	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack = elbow #2
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_jax_roundh

ct_jax_roundh
	.word	9			; time allowed
	.word	atk_roundh		; attack = roundhouse
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_knee
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

ct_jax_elbow1
	.word	9|last_option		; time allowed
	.word	atk_elbow1		; attack
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_1|req_stkdown	; strike check / requirements
	.long	ct_jax_elbow2


ct_jax_elbow2
	.word	9|last_option		; time allowed
	.word	01003H			; attack = elbow #2
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_jax_elbow3

ct_jax_elbow3
	.word	9|last_option		; time allowed
	.word	01004H			; attack = elbow #3
	.word	c_speed2|cb_block	; speed,button = hi kick
	.word	00e05H			; retract = unhipunch 2
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_jax_elbow4

ct_jax_elbow4
	.word	9|last_option		; time allowed
	.word	01005H			; attack = elbow #4
	.word	c_speed2|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_3|req_none		; strike check / requirements
	.long	ct_jax_elbow5

ct_jax_elbow5
	.word	9|last_option		; time allowed
	.word	01006H			; attack = elbow #5
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	00e04H			; retract = elbow
	.word	stk_4|req_stkaway	; strike check / requirements
	.long	00fH

;********************************************************************

ct_sonya_elbow2
	.word	9|last_option		; time allowed
	.word	01003H			; attack = elbow #2
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_sonya_elbow3

ct_sonya_elbow3
	.word	9|last_option		; time allowed
	.word	01004H			; attack = elbow #3
	.word	c_speed3|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_sonya_elbow4

ct_sonya_elbow4
	.word	9|last_option		; time allowed
	.word	01005H			; attack = elbow #3
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	00fH

;**************************************

ct_lia_elbow2
	.word	9|last_option		; time allowed
	.word	01003H			; attack = elbow #2
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1_stab|req_none 	; strike check / requirements
	.long	ct_lia_elbow3_up

ct_lia_elbow3_up
	.word	9			; time allowed
	.word	01004H			; attack = elbow #3
	.word	c_speed2|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1_stab|req_none	; strike check / requirements
	.long	ct_lia_hikick

	.word	9|last_option		; time allowed
	.word	atk_upcut		; attack = uppercut
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_5|req_stkdown	; strike check / requirements
	.long	010H

ct_lia_hikick
	.word	9|last_option		; time allowed
	.word	01101H			; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_none		; strike check / requirements
	.long	008H

ct_lia_knee
	.word	9			; time allowed
	.word	01001H			; attack = elbow #1
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_knee
	.word	stk_1_stab|req_none	; strike check / requirements
	.long	ct_lia_elbow2

	.word	9|last_option		; time allowed
	.word	01101H			; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_lia_roundh

ct_lia_roundh
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = roundhouse
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_knee
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

;**********************************

ct_sektor_elbow2
	.word	9|last_option		; time allowed
	.word	atk_elbow2		; attack = elbow #2
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_sektor_knee1

ct_sektor_knee1
	.word	9			; time allowed
	.word	atk_knee1 		; attack = elbow #2
	.word	c_speed3|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_sektor_roundh1

	.word	9|last_option		; time allowed
	.word	atk_upcut		; attack = uppercut
	.word	c_speed2|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_5|req_stkdown	; strike check / requirements
	.long	010H

ct_sektor_roundh1
	.word	9			; time allowed
	.word	atk_knee2 		; attack = elbow #2 (backwards roundh)
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

ct_wimpy_hikick
	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_sektor_roundh2

ct_sektor_roundh2
	.word	9|last_option		; time allowed
	.word	atk_knee2 		; attack = elbow #2 (backwards roundh)
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

;**************************************************

ct_cyrax_elbow2
	.word	9|last_option		; time allowed
	.word	atk_elbow2		; attack = elbow #2
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_cyrax_eknee1

ct_cyrax_eknee1
	.word	9			; time allowed
	.word	01004H			; attack = elbow #3
	.word	c_speed3|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_none		; strike check / requirements
	.long	00eH

	.word	9|last_option		; time allowed
	.word	atk_knee1 		; attack = elbow #2
	.word	c_speed3|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_cyrax_elbow3

ct_cyrax_elbow3
	.word	9|last_option		; time allowed
	.word	atk_elbow1		; attack = elbow #2
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_cyrax_eknee2

ct_cyrax_eknee2
	.word	9|last_option		; time allowed
	.word	atk_knee1 		; attack = elbow #2
	.word	c_speed3|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_cyrax_hikick

ct_cyrax_hikick
	.word	9|last_option		; time allowed
	.word	atk_hikick 		; attack
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

ct_cyrax_knee2
	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word  	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_cyrax_roundh2

ct_cyrax_roundh2
	.word	9|last_option		; time allowed
	.word	atk_roundh 		; attack = elbow #2 (backwards roundh)
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	010H

;**************************************************

ct_sektor_knee2
	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_none		; strike check / requirements
	.long	00eH

;***************************************************

ct_smoke_elbow2
	.word	9|last_option		; time allowed
	.word	01003H			; attack = elbow #2
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_smoke_elbow3

ct_smoke_elbow3
	.word	9			; time allowed
	.word	01301H			; attack = knee #1
	.word	c_speed3|cb_lokick	; speed,button
	.word	retract_elbow		; retract = knee
	.word	stk_0|req_none		; strike check / requirements
	.long	ct_smoke_knee2

	.word	9			; time allowed
	.word	01101H			; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_none		; strike check / requirements
	.long	00eH

	.word	9|last_option		; time allowed
	.word	01004H			; attack = elbow #3
	.word	c_speed3|cb_lopunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_2|req_none		; strike check / requirements
	.long	00eH

ct_smoke_knee2
	.word	9|last_option		; time allowed
	.word	atk_hikick		; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_smoke_turnaround

ct_smoke_turnaround
	.word	9|last_option		; time allowed
	.word	01004H			; attack = elbow #3
	.word	c_speed3|cb_lopunch	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_2|req_none		; strike check / requirements
	.long	00eH

;***************************************************

ct_sz_elbow2
	.word	9|last_option		; time allowed
	.word	01003H			; attack = elbow 2nd hit
	.word	c_speed2|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	00000H			; strike check / requirements
	.long	ct_sz_elbow3

ct_sz_elbow3
	.word	9			; time allowed
	.word	atk_elbow3		; attack = elbow 2nd hit
	.word	c_speed2|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	00000H			; strike check / requirements
	.long	ct_sz_knee1

ct_sz_knee1
	.word	9			; time allowed
	.word	01305H			; move closer !!!
	.word	c_speed3|cb_lokick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow

;	.word	00100H			; strike check / requirements
	.word	00100H|req_halfdamage	; strike check / requirements
	.long	ct_sz_knee2

	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = elbow 2nd hit
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	00100H|req_stkaway	; strike check / requirements
	.long	00eH

ct_sz_knee2
	.word	12|last_option		; time allowed
	.word	01303H			; attack = 2nd knee
	.word	c_speed3|cb_hikick	; speed,button
	.word	retract_knee		; retract = knee
	.word	00100H			; strike check / requirements
	.long	ct_sz_roundh

ct_sz_roundh
	.word	9|last_option		; time allowed
	.word	atk_roundh		; attack = elbow 2nd hit
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	retract_knee		; retract = elbow
	.word	stk_4|req_stkaway	; strike check / requirements
	.long	00eH

;**********************************

ct_ind_elbow2
	.word	9|last_option		; time allowed
	.word	01003H			; attack = chop
	.word	c_speed3|cb_hipunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	00000H			; strike check / requirements
	.long	ct_ind_elbow3

ct_ind_elbow3
	.word	9|last_option		; time allowed
	.word	01004H			; attack = chop
	.word	c_speed2|cb_lopunch	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	00000H			; strike check
	.long	ct_ind_hikick

ct_ind_hikick
	.word	9			; time allowed
	.word	cb_jump_address
	.word	cb_hipunch		; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	00002H			; strike check / requirements
	.long	do_fast_axe_up

	.word	9|last_option		; time allowed
	.word	01101H			; attack = hi kick
	.word	c_speed1|cb_hikick	; speed,button = hi kick
	.word	retract_elbow		; retract = elbow
	.word	stk_2|req_none		; strike check / requirements
	.long	020H

**************************************************************************
*											     *
*  Kung Lao Combos									     *
*											     *
**************************************************************************
ct_lao_elbow2
	.word	9			; time
	.word	atk_hikick		; attack = hi kick
	.word	c_speed1|cb_lokick	; speed,button = hi kick
	.word	01002H			; retract = elbow
	.word	00000H			; strike check
	.long	ct_lao_roundh

	.word	9|last_option		; time allowed
	.word	atk_elbow2		; ani ---> [offset , part #]
	.word	c_speed3|cb_lopunch	; speed,button = hi kick
	.word	01002H			; retract [ani,part #]
	.word	00000H			; strike check
	.long	ct_lao_elbow3		; success pointer

ct_lao_elbow3
	.word	9|last_option		; 9 ticks
	.word	01004H  			; ani ---> [offset , part #]
	.word	00300H  			; ani ---> [ speed , button #]
	.word	01002H			; retract [ani,part #]
	.word	00000H			; strike check
	.long	ct_lao_elbow4		; success pointer

ct_lao_elbow4
	.word	9|last_option		; 9 ticks
	.word	01005H  			; ani ---> [offset , part #]
	.word	00301H  			; ani ---> [ speed , button #]
	.word	01002H			; retract [ani,part #]
	.word	00000H			; strike check
	.long	ct_lao_e2k		; success = "elbow to knee"

;***********

ct_lao_e2k
	.word	9|last_option		; time
	.word	atk_knee1		; attack = roundhouse
	.word	c_speed2|cb_lokick	; speed,button = hi kick
	.word	retract_elbow
	.word	stk_1|req_none		; strike check / requirements
	.long	ct_lao_knee2		; success

ct_lao_roundh
	.word	9|last_option		; time
	.word	atk_roundh		; attack = roundhouse
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	01102H			; retract = hi kick
	.word	stk_2|req_stkaway	; strike check / requirements
	.long	00eH			; success

ct_lao_knee2
	.word	9|last_option		; time allowed
	.word	atk_knee2		; attack = knee #2
	.word	c_speed3|cb_lokick	; speed,button = hi kick
	.word	retract_knee		; retract = knee
	.word	00000H			; strike check
	.long	ct_lao_knee3		; success pointer

ct_lao_knee3
	.word	9|last_option		; time allowed
	.word	atk_knee3		; attack = knee #3
	.word	c_speed2|cb_hikick	; speed,button = hi kick
	.word	01102H			; retract = hi kick
	.word	stk_4|req_none		; strike check / requirements
	.long	00eH	 		; final sleep time

***************************************************************************

process_combo_table
	clr	a10			; a10 = previous button offset !!
	movi	act_combo,a1
	move	a1,*a13(p_action),w	; define my action = COMBO mode
	callr	clear_combo_butn

comb0	move	*a11(c_time),a0,w	; time to do button / animation speed
	andi	0ffH,a0			; mask off "last_option" bits

	calla	am_i_joy
	jrc	combj			; joy = must hit buttons !!
	sleep	4

;**************
	move	@diff,a0,w
	cmpi	3,a0
	jrlo	combo_exit		; easy = no cpu combo's
;**************

	jruc	comb8

combj	move	a0,*a13(p_anicount),w
	sleep	3
	move	*a13(p_anicount),a0,w
	subk	3,a0
comb1	move	a0,*a13(p_anicount),w
	sleep	1
	callr	combo_scan_a11
	jrc	comb8			; success !!
	move	*a13(p_anicount),a0,w
	dsjs	a0,comb1
	jruc	combo_2_late
*
* success ---> do next animation
*
comb8  	calla	is_he_airborn
	jrc	comb2  			; he is airborn --> dont stop him
	calla	stop_him

comb2
;	movi	combo_sitting_duck,a7
;	calla	xfer_otherguy

	callr	clear_combo_butn   	; clear for next button !!!
	move	a14,a10			; we have a new "LAST" button
	move	*a11(c_attack),a9,w 	; a9 = animation [part # , offset]
	cmpi	cb_jump_address,a9	; special case jump to address ?
	jrne	comba			; no
	move	*a11(c_next),a0,l	; yes ---> get address 2 jump 2
	jump	a0

comba	callr	a9_combo_ani

	move	*a11(c_speed),a0,w
	srl	8,a0   			; animation speed
	jsrp	mframew

;	callr	clear_combo_butn		; clear for next button !!!

	move	*a11(c_stk),a0,w
	srl	8,a0
	sll	5,a0
	addi	combo_strike_table,a0
	move	*a0,a0,l
	calla	strike_check		; strike check for this hit
	jrnc	combo_miss		; no hit ---> combo is ovah !!

	calla	zero_turbo_bar		; avoid sprint abusers !

	move	a11,a7
	move	*a11(c_next),a11,l	; grab success pointer
	jrn	comb0			; negative = process it

;	move	b2,b2			; blocked ?
;	jrne	comb9			; yes, dont punish offensive guys !!

	move	a11,a0			; positive = final sleep time !!
	calla	prcslp
	jruc	comb9			; finish animation

combo_miss
	sleep	010H

combo_2_late
	sleep	5

combo_exit
	move	*a11(c_retr),a9,w
	callr	a9_combo_ani
comb9	movk	4,a0
	jauc	mframew			; get out of ani / retp

;**********************************************

combo_scan_a11
	push	a11

cscan1	move	*a11(c_speed),a0,w 	; ani speed | button #
	sll	32-8,a0
	srl	32-8,a0
	move	a0,a14			; this will be our new "LAST" button
	sll	6,a0
	addi	last_switch_ram,a0
	move	*a0(32),a0,l		; a0 = combo ram
	move	@p1_obj,a1,l
	cmp	a1,a8
	jreq	comb5
	addk	16,a0			; player 2 ram
comb5	move	*a0,a1,w		; button pressed since we slept ?
	jreq	combof			; no = combo failure, look 4 more options
*
* make sure no other buttons pressed
*
	movi	c_hp,a1
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	comb4
	addk	16,a1			; a1 ---> player 2 half of longword
comb4	clr	a2			; count how many buttons have been press
	clr	a0			; check all 5 buttons
comb6	move	*a1+,a4,w		; read in...
	jreq	comb7			; zero ---> dont count it
	cmp	a0,a10			; is this the last button ??
	jreq	comb7			; yes ----> allow extra button presses
	inc	a2			; no ---> count it
comb7	addk	16,a1
	inc	a0
	cmpi	5,a0			; all 5 buttons checked ??
	jrne	comb6			; no, loop

	cmpi	1,a2			; me and only me ??
	jrhi	combof			; no = failure

	move	*a11(c_req),a0,w
	andi	0ffH,a0
	jreq	cscan8			; zero requirement = success
	dec	a0
	sll	5,a0
	addi	requirement_table,a0
	move	*a0,a0,l
	push	a11
	call	a0    			; test the requirement
	pull	a11
	jrc	cscan8			; carry = success
*
* failure ----> look for more options
*
combof	move	*a11(c_time),a0,w
	btst	b_last_option,a0	; last option ??
	jrne	cscan9			; yes ---> exit
	addi	csize,a11		; a11 = next entry
	jruc	cscan1			; give this one a chance

cscan8	pull	a0			; success = dont preserve a11
	setc
	rets

cscan9	clrc
	pull	a11
	rets



a9_combo_ani
	move	a9,a14
	sll	32-8,a14
	srl	32-8,a14		; a14 = animation part #
	srl	8,a9			; a9 = animation offset ONLY
	jauc	find_ani_part_a14

clear_combo_butn
	movk	16,a3			; need 4 speed
	movi	c_hp,a1
	move	@p1_obj,a0,l
	cmp	a0,a8
	jreq	ccr1
	add	a3,a1			; a1 ---> player 2 half of longword
ccr1	clr	a2
	move	a2,*a1+,w
	add	a3,a1
	move	a2,*a1+,w
	add	a3,a1
	move	a2,*a1+,w
	add	a3,a1
	move	a2,*a1+,w
	add	a3,a1
	move	a2,*a1+,w
	add	a3,a1
	move	a2,*a1,w		; clear out all combo ram for player ??
	rets

requirement_table
	.long	is_stick_away		; 1
	.long	check_axe_up_combo	; 2
	.long	is_stick_toward		; 3
	.long	is_stick_down		; 4
	.long	set_his_half_damage	; 5


set_his_half_damage
	move	*a13(p_otherproc),a0,l
	move	*a0(p_hit),a0,w
	cmpi	3,a0			; too many hits ?
	jrlo	shhd4			; no

	movi	set_half_damage,a0
	calla	calla_for_him		; yes, easy chief !

shhd4	setc				; always return "yes"
	rets

check_axe_up_combo
	move	a13,*a13(p_store4),l	; this is assumed
	movi	p1b0,a0			; player 1 legal buttons
	movi	p2b0,a1			; player 2 legal buttons
	movi	scom_axe_up,a11		; switch combo table
	jauc	stick_look_lr

;***************************

retract_strike_act
	jsrp	act_mframew		; un hi kick
	calla	back_to_normal
	retp

;***************************

	.end
