**************************************************************************
*											     *
*  mk3 - Subzero											*
*											     *
**************************************************************************
	.FILE	'mkind.ASM'
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo
	.include mksz.tbl
	.include mksz2.tbl
	.include mksz3.tbl
	.text

**************************************************************************

sz_anitab1
	.long	a_stance	;  0 - stance
	.long	a_walkf		;  1 - walk forward
	.long	a_walkb		;  2 - walk backward
	.long	a_turn		;  3 - turn around (standing)
	.long	a_duck		;  4 - duck
	.long	a_duck_turn	;  5 - duck turnaround
	.long	a_duck_block	;  6 - duck block
	.long	a_duck_hit	;  7 - duck hit
	.long	a_duck_punch	;  8 - duck punch
	.long	a_duck_kick_hi	;  9 - duck high kick
	.long	a_duck_kick_lo	;  a - duck low kick
	.long	a_uppercut	;  b - uppercut
	.long	a_block		;  c - block (standing)
	.long	a_victory	;  d - victory
	.long	a_hipunch	;  e - punch high
	.long	a_lopunch	;  f - punch low
	.long	a_elbow		; 10
	.long	a_hikick 	; 11
	.long	a_lokick 	; 12
	.long	a_knee		; 13
	.long	a_sweep_kick	; 14
	.long	a_roundhouse	; 15
	.long	a_jump		; 16
	.long	a_jump_kick	; 17
	.long	a_flip_punch	; 18
	.long	a_flip_kick	; 19
	.long	a_fflip		; 1a
	.long	a_bflip		; 1b
	.long	a_hit_hi	; 1c
	.long	a_hit_lo	; 1d
	.long	a_knockdown	; 1e
	.long	a_sweep_fall	; 1f
	.long	a_stumble	; 20
	.long	a_getup		; 21
	.long	a_sweepup	; 22 -
	.long	a_throw		; 23 -
	.long	a_zap		; 24 - 
	.long	a_dizzy		; 25 -

	.long	a_fb_kano	; 26 - flipped by kano
	.long	a_fb_sonya	; 27 - flipped by sonya
	.long	a_fb_jax	; 28 - flipped by jax
	.long	a_fb_ind	; 29 - flipped by indian
	.long	a_fb_sz		; 2a	- flipped by subzero
	.long	a_fb_swat	; 2b	- flipped by swat
	.long	a_fb_lia	; 2c	- flipped by lia
	.long	a_fb_robo	; 2d	- flipped by robot ninja
	.long	a_fb_robo2	; 2e	- flipped by robot ninja 2
	.long	a_fb_lao	; 2f	- flipped by kung lao
	.long	a_fb_tusk	; 30 - flipped by tusk
	.long	a_fb_sg         ; 31 - flipped by she goro
	.long	a_fb_st		; 32 - flipped by shang tsung
        	.long	a_fb_lk		; 33 - flipped by liu kang
	.long	a_fb_smoke	; 34	- flipped by smoke
	.long	a_afb_kano	; 35 - air flipped by kano
	.long	a_legged	; 36 - legged by sonya
	.long	a_projectile	; 37 - projectile animation
	.long	a_shook		; 38 - shook by kano
	.long	a_afb_robo2	; 39 - air flipped by robo2
	.long	a_zoomed	; 3a - zoomed
	.long	0		; 3b
	.long	0		; 3c
	.long	0		; 3d
	.long	a_run		; 3e - run
	.long	a_thudd		; 3f	-
	.long	a_scared	; 40 -

sz_anitab2
	.long	a_sky_zap	; 0 - throw ice into the air
	.long	a_freeze_blast	; 1 - freeze explosion a la Dave M.
	.long	a_slide		; 2
	.long	a_blow_ice	; 3
	.long	a_ice_thudd	; 4
	.long	a_lift_n_freeze	; 5
	.long	a_boomer	; 6 - yea right, sure thing guys

;***************************************************************************

a_projectile

a_dummy
a_stance
	.long	SZSTANCE1
	.long	SZSTANCE2
	.long	SZSTANCE3
	.long	SZSTANCE4
	.long	SZSTANCE5
	.long	SZSTANCE6
	.long	SZSTANCE7
	.long	SZSTANCE8
	.long	SZSTANCE9
	.long	SZSTANCE10
	.long	ani_jump,a_stance

SZSTANCE1
	.long	SZSTANCE1A,SZSTANCE1B,0
SZSTANCE2
	.long	SZSTANCE2A,SZSTANCE2B,0
SZSTANCE3
	.long	SZSTANCE3A,SZSTANCE3B,0
SZSTANCE4
	.long	SZSTANCE4A,SZSTANCE4B,0
SZSTANCE5
	.long	SZSTANCE5A,SZSTANCE5B,0
SZSTANCE6
	.long	SZSTANCE6A,SZSTANCE6B,0
SZSTANCE7
	.long	SZSTANCE7A,SZSTANCE7B,0
SZSTANCE8
	.long	SZSTANCE8A,SZSTANCE8B,0
SZSTANCE9
	.long	SZSTANCE9A,SZSTANCE9B,0
SZSTANCE10
	.long	SZSTANCE10A,SZSTANCE10B,0

;*******************************************************************

a_walkf
	.long	SZWALKLEGS1
	.long	SZWALKLEGS2
	.long	SZWALKLEGS3
	.long	SZWALKLEGS4
	.long	SZWALKLEGS5
	.long	SZWALKLEGS6
	.long	SZWALKLEGS7
	.long	SZWALKLEGS8
	.long	SZWALKLEGS9
	.long	ani_jump,a_walkf

a_walkb
	.long	SZWALKLEGS9
	.long	SZWALKLEGS8
	.long	SZWALKLEGS7
	.long	SZWALKLEGS6
	.long	SZWALKLEGS5
	.long	SZWALKLEGS4
	.long	SZWALKLEGS9
	.long	SZWALKLEGS2
	.long	SZWALKLEGS1
	.long	ani_jump,a_walkb

SZWALKLEGS1
	.long	SZWALKTORSO1,SZWALKLEGS1A,SZWALKLEGS1B,0
SZWALKLEGS2
	.long	SZWALKTORSO2,SZWALKLEGS2A,SZWALKLEGS2B,0
SZWALKLEGS3
	.long	SZWALKTORSO3,SZWALKLEGS3A,0
SZWALKLEGS4
	.long	SZWALKTORSO4,SZWALKLEGS4A,SZWALKLEGS4B,0
SZWALKLEGS5
	.long	SZWALKTORSO5,SZWALKLEGS5A,SZWALKLEGS5B,0
SZWALKLEGS6
	.long	SZWALKTORSO6,SZWALKLEGS6A,0
SZWALKLEGS7
	.long	SZWALKTORSO7,SZWALKLEGS7A,SZWALKLEGS7B,0
SZWALKLEGS8
	.long	SZWALKTORSO8,SZWALKLEGS8A,SZWALKLEGS8B,0
SZWALKLEGS9
	.long	SZWALKTORSO9,SZWALKLEGS9A,SZWALKLEGS9B,0

;*************************************************************

a_turn	.long	SZTURN1
	.long	SZTURN2
	.long	ani_flip
	.long	SZTURN1
	.long	0

SZTURN1	.long	SZTURN1A,SZTURN1B,0
SZTURN2	.long	SZTURN2A,SZTURN2B,0

;*************************************************************

a_duck	.long	SZDUCK1
	.long	SZDUCK2
	.long	SZDUCK3
	.long	0

SZDUCK1	.long	SZDUCK1A,SZDUCK1B,0
SZDUCK2	.long	SZDUCK2A,SZDUCK2B,0
SZDUCK3	.long	SZDUCK3A,SZDUCK3B,0

;**************************************************************

a_duck_turn
	.long	SZDUCKTURN1
	.long	SZDUCKTURN2
	.long	ani_flip
	.long	SZDUCKTURN2
	.long	SZDUCKTURN1
	.long	SZDUCK3
	.long	0

SZDUCKTURN1
	.long	SZDUCKTURN1A,SZDUCKTURN1B,0
SZDUCKTURN2
	.long	SZDUCKTURN2A,SZDUCKTURN2B,0


;**************************************************************

a_duck_block
	.long	SZDUCKBLOCK1
	.long	SZDUCKBLOCK2
	.long	SZDUCKBLOCK3
	.long	0

SZDUCKBLOCK1
	.long	SZDUCKBLOCK1A,SZDUCKBLOCK1B,0
SZDUCKBLOCK2
	.long	SZDUCKBLOCK2A,SZDUCKBLOCK2B,0
SZDUCKBLOCK3
	.long	SZDUCKBLOCK3A,SZDUCKBLOCK3B,0

;**************************************************************

a_duck_hit
	.long	SZDUCKHIT2
	.long	SZDUCKHIT3
	.long	SZDUCKHIT2
	.long	SZDUCKHIT1
	.long	0

SZDUCKHIT1
	.long	SZDUCKHIT1A,SZDUCKHIT1B,0
SZDUCKHIT2
	.long	SZDUCKHIT2A,SZDUCKHIT2B,0
SZDUCKHIT3
	.long	SZDUCKHIT3A,SZDUCKHIT3B,0

;**************************************************************

a_duck_punch
	.long	SZDUCKPUNCH1
	.long	SZDUCKPUNCH2
	.long	SZDUCKPUNCH3
	.long	0
	.long	SZDUCKPUNCH2
	.long	SZDUCKPUNCH1
	.long	SZDUCK3
	.long	0

SZDUCKPUNCH1
	.long	SZDUCKPUNCH1A,SZDUCKPUNCH1B,0
SZDUCKPUNCH2
	.long	SZDUCKPUNCH2A,SZDUCKPUNCH2B,0
SZDUCKPUNCH3
	.long	SZDUCKPUNCH3A,SZDUCKPUNCH3B,0

;**************************************************************

a_uppercut
	.long	SZUPPERCUT2
	.long	SZUPPERCUT3
	.long	SZUPPERCUT4
	.long	SZUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
	.long	SZUPPERCUT6
	.long	0
	.long	SZHIPUNCH1
	.long	0

; unused (ejbpatch)
;SZUPPERCUT1
;	.long	SZUPPERCUT1A,SZUPPERCUT1B,0

SZUPPERCUT2
	.long	SZUPPERCUT2A,SZUPPERCUT2B,0
SZUPPERCUT3
	.long	SZUPPERCUT3A,SZUPPERCUT3B,0
SZUPPERCUT4
	.long	SZUPPERCUT4A,SZUPPERCUT4B,0
SZUPPERCUT5
	.long	SZUPPERCUT5A,SZUPPERCUT5B,SZUPPERCUT5C,0
SZUPPERCUT6
	.long	SZUPPERCUT6A,SZUPPERCUT6B,0

;**************************************************************

a_duck_kick_lo
	.long	SZDUCKLOKICK1
	.long	SZDUCKLOKICK2
	.long	SZDUCKLOKICK3
	.long	0
	.long	SZDUCKLOKICK2
	.long	SZDUCKLOKICK1
	.long	SZDUCK3
	.long	0

SZDUCKLOKICK1
	.long	SZDUCKLOKICK1A,SZDUCKLOKICK1B,0
SZDUCKLOKICK2
	.long	SZDUCKLOKICK2A,SZDUCKLOKICK2B,SZDUCKLOKICK2C,0
SZDUCKLOKICK3
	.long	SZDUCKLOKICK3A,SZDUCKLOKICK3B,SZDUCKLOKICK3C,0

;**************************************************************

a_duck_kick_hi
	.long	SZDUCKHIKICK1
	.long	SZDUCKHIKICK2
	.long	SZDUCKHIKICK3
	.long	SZDUCKHIKICK4
	.long	0
	.long	SZDUCKHIKICK3
	.long	SZDUCKHIKICK2
	.long	SZDUCKHIKICK1
	.long	0

SZDUCKHIKICK1
	.long	SZDUCKHIKICK1A,SZDUCKHIKICK1B,0
SZDUCKHIKICK2
	.long	SZDUCKHIKICK2A,SZDUCKHIKICK2B,0
SZDUCKHIKICK3
	.long	SZDUCKHIKICK3A,SZDUCKHIKICK3B,0
SZDUCKHIKICK4
	.long	SZDUCKHIKICK4A,SZDUCKHIKICK4B,0

;**************************************************************

a_hipunch
	.long	SZHIPUNCH1
	.long	SZHIPUNCH2
	.long	SZHIPUNCH3
	.long	0

	.long	SZHIPUNCH4
	.long	SZHIPUNCH5
	.long	SZHIPUNCH6
	.long	0

	.long	SZHIPUNCH5
	.long	SZHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	SZHIPUNCH2
	.long	SZHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	SZHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	SZHIPUNCH4
	.long	SZLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	SZHIPUNCH5
	.long	SZLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0


a_lopunch
	.long	SZLOPUNCH1
	.long	SZLOPUNCH2
	.long	SZLOPUNCH3
	.long	0

	.long	SZLOPUNCH4
	.long	SZLOPUNCH5
	.long	SZLOPUNCH6
	.long	0

	.long	SZLOPUNCH5
	.long	SZLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	SZLOPUNCH2
	.long	SZLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	SZHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	SZLOPUNCH4
	.long	SZLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	SZLOPUNCH4
	.long	SZHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)


SZLOPUNCH1
	.long	SZLOPUNCH1A,SZLOPUNCH1B,0
SZLOPUNCH2
	.long	SZLOPUNCH2A,SZLOPUNCH2B,0
SZLOPUNCH3
	.long	SZLOPUNCH3A,SZLOPUNCH3B,0
SZLOPUNCH4
	.long	SZLOPUNCH4A,SZLOPUNCH4B,0
SZLOPUNCH5
	.long	SZLOPUNCH5A,SZLOPUNCH5B,0
SZLOPUNCH6
	.long	SZLOPUNCH6A,SZLOPUNCH6B,0

SZHIPUNCH1
	.long	SZHIPUNCH1A,SZHIPUNCH1B,0
SZHIPUNCH2
	.long	SZHIPUNCH2A,SZHIPUNCH2B,0
SZHIPUNCH3
	.long	SZHIPUNCH3A,SZHIPUNCH3B,0
SZHIPUNCH4
	.long	SZHIPUNCH4A,SZHIPUNCH4B,0
SZHIPUNCH5
	.long	SZHIPUNCH5A,SZHIPUNCH5B,0
SZHIPUNCH6
	.long	SZHIPUNCH6A,SZHIPUNCH6B,0
SZHIPUNCH7
	.long	SZHIPUNCH7A,SZHIPUNCH7B,0

;**************************************************************

a_elbow
	.long	SZELBOCOMBO1
	.long	SZELBOCOMBO2
	.long	SZELBOCOMBO3
	.long	0
	.long	SZELBOCOMBO2
	.long	SZELBOCOMBO1
	.long	0

	.long	SZELBOCOMBO4
	.long	SZELBOCOMBO5
	.long	SZELBOCOMBO6
	.long	SZELBOCOMBO7		; ani: part 3
	.long	0

	.long	SZELBOCOMBO7
	.long	SZELBOCOMBO8
	.long	SZELBOCOMBO9 		; ani: part 4
	.long	SZELBOCOMBO10
	.long	0

	.long	SZELBOCOMBO10
	.long	SZELBOCOMBO10
	.long	SZELBOCOMBO10
	.long	SZELBOCOMBO10
	.long	SZELBOCOMBO11
	.long	0

SZELBOCOMBO1
	.long	SZELBOCOMBO1A,SZELBOCOMBO1B,0
SZELBOCOMBO2
	.long	SZELBOCOMBO2A,SZELBOCOMBO2B,0
SZELBOCOMBO3
	.long	SZELBOCOMBO3A,SZELBOCOMBO3B,0
SZELBOCOMBO4
	.long	SZELBOCOMBO4A,SZELBOCOMBO4B,0
SZELBOCOMBO5
	.long	SZELBOCOMBO5A,SZELBOCOMBO5B,0
SZELBOCOMBO6
	.long	SZELBOCOMBO6A,SZELBOCOMBO6B,0
SZELBOCOMBO7
	.long	SZELBOCOMBO7A,SZELBOCOMBO7B,0
SZELBOCOMBO8
	.long	SZELBOCOMBO8A,SZELBOCOMBO8B,0
SZELBOCOMBO9
	.long	SZELBOCOMBO9A,SZELBOCOMBO9B,0
SZELBOCOMBO10
	.long	SZELBOCOMBO10A,SZELBOCOMBO10B,0
SZELBOCOMBO11
	.long	SZELBOCOMBO11A,SZELBOCOMBO11B,0

;**************************************************************

a_block
	.long	SZHIBLOCK1
	.long	SZHIBLOCK2
	.long	SZHIBLOCK3
	.long	0

SZHIBLOCK1
	.long	SZHIBLOCK1A,SZHIBLOCK1B,0
SZHIBLOCK2
	.long	SZHIBLOCK2A,SZHIBLOCK2B,0
SZHIBLOCK3
	.long	SZHIBLOCK3A,SZHIBLOCK3B,0

ICEBLOW1
	.long	ICEBLOW1A,0
ICEBLOW2
	.long	ICEBLOW2A,0
ICEBLOW3
	.long	ICEBLOW3A,0
ICEBLOW4
	.long	ICEBLOW4A,0
ICEBLOW5
	.long	ICEBLOW5A,0
ICEBLOW6
	.long	ICEBLOW6A,0
ICEBLOW7
	.long	ICEBLOW7A,ICEBLOW7B,0
ICEBLOW8
	.long	ICEBLOW8A,ICEBLOW8B,ICEBLOW8C,0
ICEBLOW9
	.long	ICEBLOW9A,ICEBLOW9B,ICEBLOW9C,0
ICEBLOW10
	.long	ICEBLOW10A,ICEBLOW10B,ICEBLOW10C,0
ICEBLOW11
	.long	ICEBLOW11A,ICEBLOW11B,ICEBLOW11C,ICEBLOW11D,0


a_ice_thudd
	.long	ICETHUD1
	.long	ICETHUD2
	.long	ICETHUD3
	.long	ICETHUD4
	.long	ICETHUD5
	.long	ICETHUD6
	.long	ICETHUD7
	.long	ICETHUD8
	.long	ICETHUD9
	.long	0

ICETHUD1
	.long	ICETHUD1A,0
ICETHUD2
	.long	ICETHUD2A,ICETHUD2B,0
ICETHUD3
	.long	ICETHUD3A,ICETHUD3B,0
ICETHUD4
	.long	ICETHUD4A,ICETHUD4B,0
ICETHUD5
	.long	ICETHUD5A,ICETHUD5B,0
ICETHUD6
	.long	ICETHUD6A,ICETHUD6B,0
ICETHUD7
	.long	ICETHUD7A,ICETHUD7B,ICETHUD7C,ICETHUD7D,0
ICETHUD8
	.long	ICETHUD8A,ICETHUD8B,ICETHUD8C,ICETHUD8D,0
ICETHUD9
	.long	ICETHUD9A,ICETHUD9B,ICETHUD9C,ICETHUD9D,0

;**************************************************************

a_lokick
	.long	SZLOKICK1
	.long	SZLOKICK2
	.long	SZLOKICK3
	.long	SZLOKICK4
	.long	SZLOKICK5
	.long	SZLOKICK6
	.long	0
	.long	SZLOKICK5
	.long	SZLOKICK4
	.long	SZLOKICK3
	.long	SZLOKICK2
	.long	SZLOKICK1
	.long	0

SZLOKICK1
	.long	SZLOKICK1A,SZLOKICK1B,0
SZLOKICK2
	.long	SZLOKICK2A,SZLOKICK2B,0
SZLOKICK3
	.long	SZLOKICK3A,0
SZLOKICK4
	.long	SZLOKICK4A,SZLOKICK4B,0
SZLOKICK5
	.long	SZLOKICK5A,SZLOKICK5B,0
SZLOKICK6
	.long	SZLOKICK6A,0

;**************************************************************

a_hikick
	.long	SZLOKICK1
	.long	SZLOKICK2
	.long	SZLOKICK3
	.long	SZHIKICK1
	.long	SZHIKICK2
	.long	SZHIKICK3
	.long	0
	.long	SZHIKICK2
	.long	SZHIKICK1
	.long	SZLOKICK3
	.long	SZLOKICK2
	.long	SZLOKICK1
	.long	0

SZHIKICK1
	.long	SZHIKICK1A,SZHIKICK1B,0
SZHIKICK2
	.long	SZHIKICK2A,0
SZHIKICK3
	.long	SZHIKICK3A,SZHIKICK3B,0

;**************************************************************

a_knee
	.long	SZKNEE1
	.long	SZKNEE2
	.long	SZKNEE3
	.long	0
j_unknee	.long	SZKNEE2
	.long	SZKNEE1
	.long	0

	.long	ani_adjustx
	.word	12
	.long	SZKNEE4
	.long	ani_adjustx
	.word	12
	.long	SZKNEE5		; part 3: 2nd knee hit
	.long	0

	.long	SZKNEE4		; part 4: un knee
	.long	SZKNEE3
	.long	ani_jump,j_unknee
	.long	0

	.long	ani_adjustx
	.word	12
	.long	SZKNEE1
	.long	ani_adjustx
	.word	12
	.long	SZKNEE2
	.long	SZKNEE3		; part 5: knee that moves forward
	.long	0



SZKNEE1	.long	SZKNEE1A,SZKNEE1B,0
SZKNEE2	.long	SZKNEE2A,0
SZKNEE3	.long	SZKNEE3A,SZKNEE3B,0
SZKNEE4	.long	SZKNEE4A,SZKNEE4B,0
SZKNEE5	.long	SZKNEE5A,SZKNEE5B,0

;**************************************************************

a_roundhouse
	.long	SZHOOKKICK1
	.long	SZHOOKKICK2
	.long	SZHOOKKICK3
	.long	SZHOOKKICK4
	.long	SZHOOKKICK5
	.long	0
	.long	SZHOOKKICK6
	.long	SZHOOKKICK7
	.long	SZHOOKKICK8
	.long	0

SZHOOKKICK1
	.long	SZHOOKKICK1A,SZHOOKKICK1B,0
SZHOOKKICK2
	.long	SZHOOKKICK2A,SZHOOKKICK2B,0
SZHOOKKICK3
	.long	SZHOOKKICK3A,0
SZHOOKKICK4
	.long	SZHOOKKICK4A,0
SZHOOKKICK5
	.long	SZHOOKKICK5A,SZHOOKKICK5B,0
SZHOOKKICK6
	.long	SZHOOKKICK6A,SZHOOKKICK6B,0
SZHOOKKICK7
	.long	SZHOOKKICK7A,0
SZHOOKKICK8
	.long	SZHOOKKICK8A,SZHOOKKICK8B,0

;**************************************************************

a_sweep_kick
	.long	SZSWEEPKICK1
	.long	SZSWEEPKICK2
	.long	SZSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	SZSWEEPKICK4
	.long	SZSWEEPKICK5
	.long	0
	.long	SZSWEEPKICK6
	.long	SZSWEEPKICK7
	.long	SZSWEEPKICK8
	.long	0

SZSWEEPKICK1
	.long	SZSWEEPKICK1A,SZSWEEPKICK1B,0
SZSWEEPKICK2
	.long	SZSWEEPKICK2A,SZSWEEPKICK2B,0
SZSWEEPKICK3
	.long	SZSWEEPKICK3A,0
SZSWEEPKICK4
	.long	SZSWEEPKICK4A,SZSWEEPKICK4B,0
SZSWEEPKICK5
	.long	SZSWEEPKICK5A,SZSWEEPKICK5B,0
SZSWEEPKICK6
	.long	SZSWEEPKICK6A,SZSWEEPKICK6B,0
SZSWEEPKICK7
	.long	SZSWEEPKICK7A,0
SZSWEEPKICK8
	.long	SZSWEEPKICK8A,SZSWEEPKICK8B,0

;**************************************************************

a_jump
	.long	SZJUMP1
	.long	SZJUMP2
	.long	SZJUMP3
	.long	0

SZJUMP1	.long	SZJUMP1A,SZJUMP1B,0
SZJUMP2	.long	SZJUMP2A,SZJUMP2B,0
SZJUMP3	.long	SZJUMP3A,SZJUMP3B,0

;**************************************************************

a_jump_kick
	.long	SZJUMPKICK1
	.long	SZJUMPKICK2
	.long	SZJUMPKICK3
	.long	0
	.long	SZJUMPKICK2
	.long	SZJUMPKICK1
	.long	0

SZJUMPKICK1
	.long	SZJUMPKICK1A,0
SZJUMPKICK2
	.long	SZJUMPKICK2A,SZJUMPKICK2B,0
SZJUMPKICK3
	.long	SZJUMPKICK3A,SZJUMPKICK3B,0

;**************************************************************

a_flip_kick
	.long	SZFLIPKICK1
	.long	SZFLIPKICK2
	.long	SZFLIPKICK3
	.long	0
	.long	SZFLIPKICK2
	.long	SZFLIPKICK1
	.long	0

SZFLIPKICK1
	.long	SZFLIPKICK1A,0
SZFLIPKICK2
	.long	SZFLIPKICK2A,0
SZFLIPKICK3
	.long	SZFLIPKICK3A,0

;**************************************************************

a_flip_punch
	.long	SZFLIPUNCH1
	.long	SZFLIPUNCH2
	.long	SZFLIPUNCH3
	.long	0
	.long	SZFLIPKICK2
	.long	SZFLIPKICK1
	.long	0

SZFLIPUNCH1
	.long	SZFLIPUNCH1A,SZFLIPUNCH1B,0
SZFLIPUNCH2
	.long	SZFLIPUNCH2A,SZFLIPUNCH2B,0
SZFLIPUNCH3
	.long	SZFLIPUNCH3A,SZFLIPUNCH3B,0

;**************************************************************

a_fflip
	.long	SZJUMPFLIP1
	.long	SZJUMPFLIP2
	.long	SZJUMPFLIP3
	.long	SZJUMPFLIP4
	.long	SZJUMPFLIP5
	.long	SZJUMPFLIP6
	.long	SZJUMPFLIP7
	.long	SZJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip
	.long	SZJUMPFLIP1
	.long	SZJUMPFLIP8
	.long	SZJUMPFLIP7
	.long	SZJUMPFLIP6
	.long	SZJUMPFLIP5
	.long	SZJUMPFLIP4
	.long	SZJUMPFLIP3
	.long	SZJUMPFLIP2
	.long	ani_jump,a_bflip+32

SZJUMPFLIP1
	.long	SZJUMPFLIP1A,SZJUMPFLIP1B,0
SZJUMPFLIP2
	.long	SZJUMPFLIP2A,0
SZJUMPFLIP3
	.long	SZJUMPFLIP3A,0
SZJUMPFLIP4
	.long	SZJUMPFLIP4A,0
SZJUMPFLIP5
	.long	SZJUMPFLIP5A,0
SZJUMPFLIP6
	.long	SZJUMPFLIP6A,0
SZJUMPFLIP7
	.long	SZJUMPFLIP7A,0
SZJUMPFLIP8
	.long	SZJUMPFLIP8A,0

;**************************************************************

a_hit_hi
	.long	SZHIHIT2
	.long	SZHIHIT3
	.long	SZHIHIT2
	.long	SZHIHIT1
	.long	0

SZHIHIT1	.long	SZHIHIT1A,SZHIHIT1B,0
SZHIHIT2	.long	SZHIHIT2A,SZHIHIT2B,0
SZHIHIT3	.long	SZHIHIT3A,SZHIHIT3B,0

;**************************************************************

a_hit_lo
	.long	SZLOHIT2
	.long	SZLOHIT3
	.long	SZLOHIT2
	.long	SZLOHIT1
	.long	0

SZLOHIT1	.long	SZLOHIT1A,SZLOHIT1B,0
SZLOHIT2	.long	SZLOHIT2A,SZLOHIT2B,0
SZLOHIT3	.long	SZLOHIT3A,SZLOHIT3B,0

;**************************************************************

a_stumble
	.long	SZSTUMBLE1
	.long	SZSTUMBLE2
	.long	SZSTUMBLE3
	.long	SZSTUMBLE4
	.long	SZSTUMBLE5
	.long	SZSTUMBLE6
	.long	SZSTUMBLE7
	.long	0

j_stumble
	.long	SZSTUMBLE1
	.long	SZSTUMBLE2
	.long	SZSTUMBLE3
	.long	SZSTUMBLE4
	.long	SZSTUMBLE5
	.long	SZSTUMBLE6
	.long	SZSTUMBLE7
	.long	ani_jump,j_stumble

SZSTUMBLE1
	.long	SZSTUMBLE1A,SZSTUMBLE1B,0
SZSTUMBLE2
	.long	SZSTUMBLE2A,SZSTUMBLE2B,0
SZSTUMBLE3
	.long	SZSTUMBLE3A,0
SZSTUMBLE4
	.long	SZSTUMBLE4A,0
SZSTUMBLE5
	.long	SZSTUMBLE5A,SZSTUMBLE5B,0
SZSTUMBLE6
	.long	SZSTUMBLE6A,SZSTUMBLE6B,0
SZSTUMBLE7
	.long	SZSTUMBLE7A,SZSTUMBLE7B,0

;**************************************************************

a_dizzy
	.long	SZSTUNNED1
	.long	SZSTUNNED2
	.long	SZSTUNNED3
	.long	SZSTUNNED4
	.long	SZSTUNNED5
	.long	SZSTUNNED6
	.long	SZSTUNNED7
	.long	SZSTUNNED8
	.long	ani_jump,a_dizzy

SZSTUNNED1
	.long	SZSTUNNED1A,SZSTUNNED1B,0
SZSTUNNED2
	.long	SZSTUNNED2A,SZSTUNNED2B,0
SZSTUNNED3
	.long	SZSTUNNED3A,SZSTUNNED3B,0
SZSTUNNED4
	.long	SZSTUNNED4A,SZSTUNNED4B,0
SZSTUNNED5
	.long	SZSTUNNED5A,SZSTUNNED5B,0
SZSTUNNED6
	.long	SZSTUNNED6A,SZSTUNNED6B,0
SZSTUNNED7
	.long	SZSTUNNED7A,SZSTUNNED7B,0
SZSTUNNED8
	.long	SZSTUNNED8A,SZSTUNNED8B,0


;**************************************************************

a_knockdown
	.long	SZKNOCKDOWN1
	.long	SZKNOCKDOWN2
	.long	SZKNOCKDOWN3
	.long	SZKNOCKDOWN4
	.long	SZKNOCKDOWN5
	.long	0
	.long	SZKNOCKDOWN6
	.long	SZKNOCKDOWN7
	.long	0

SZKNOCKDOWN1
	.long	SZKNOCKDOWN1A,SZKNOCKDOWN1B,0
SZKNOCKDOWN2
	.long	SZKNOCKDOWN2A,0
SZKNOCKDOWN3
	.long	SZKNOCKDOWN3A,0
SZKNOCKDOWN4
	.long	SZKNOCKDOWN4A,SZKNOCKDOWN4B,SZKNOCKDOWN4C,0
SZKNOCKDOWN5
	.long	SZKNOCKDOWN5A,SZKNOCKDOWN5B,0
SZKNOCKDOWN6
	.long	SZKNOCKDOWN6A,0
SZKNOCKDOWN7
	.long	SZKNOCKDOWN7A,0

;**************************************************************

a_getup
	.long	SZGETUP1
	.long	SZGETUP2
	.long	SZGETUP3
	.long	SZGETUP4
	.long	SZGETUP5
	.long	SZGETUP6
	.long	0

SZGETUP1
	.long	SZGETUP1A,SZGETUP1B,0
SZGETUP2
	.long	SZGETUP2A,0
SZGETUP3
	.long	SZGETUP3A,0
SZGETUP4
	.long	SZGETUP4A,SZGETUP4B,0
SZGETUP5
	.long	SZGETUP5A,0
SZGETUP6
	.long	SZGETUP6A,0


;**************************************************************

a_sweep_fall
	.long	SZSWEEPFALL1
	.long	SZSWEEPFALL2
	.long	SZSWEEPFALL3
	.long	SZSWEEPFALL4
	.long	SZSWEEPFALL5
	.long	0
	.long	SZSWEEPFALL5
	.long	SZSWEEPUP1
	.long	0

SZSWEEPFALL1
	.long	SZSWEEPFALL1A,SZSWEEPFALL1B,0
SZSWEEPFALL2
	.long	SZSWEEPFALL2A,SZSWEEPFALL2B,0
SZSWEEPFALL3
	.long	SZSWEEPFALL3A,0
SZSWEEPFALL4
	.long	SZSWEEPFALL4A,SZSWEEPFALL4B,0
SZSWEEPFALL5
	.long	SZSWEEPFALL5A,0

;**************************************************************

a_sweepup
	.long	SZSWEEPUP1
	.long	SZSWEEPUP2
	.long	SZSWEEPUP3
	.long	SZSWEEPUP4
	.long	SZSWEEPUP5
	.long	SZSWEEPUP6
	.long	SZSWEEPUP7
	.long	0

SZSWEEPUP1
	.long	SZSWEEPUP1A,SZSWEEPUP1B,0
SZSWEEPUP2
	.long	SZSWEEPUP2A,0
SZSWEEPUP3
	.long	SZSWEEPUP3A,SZSWEEPUP3B,0
SZSWEEPUP4
	.long	SZSWEEPUP4A,SZSWEEPUP4B,0
SZSWEEPUP5
	.long	SZSWEEPUP5A,0
SZSWEEPUP6
	.long	SZSWEEPUP6A,SZSWEEPUP6B,0
SZSWEEPUP7
	.long	SZSWEEPUP7A,SZSWEEPUP7B,0


;*************************************************************************

a_throw
	.long	SZFLIP1
	.long	SZFLIP2		; grab
	.long	0

	.long	SZFLIP3
	.long	SZFLIP4
	.long	SZFLIP5
	.long	SZFLIP6		; animate 2-gether
	.long	SZFLIP7
	.long	SZFLIP8
	.long	0

	.long	SZFLIP9
	.long	0

SZFLIP1	.long	SZFLIP1A,SZFLIP1B,0
SZFLIP2	.long	SZFLIP2A,SZFLIP2B,0
SZFLIP3	.long	SZFLIP3A,SZFLIP3B,0
SZFLIP4	.long	SZFLIP4A,SZFLIP4B,0
SZFLIP5	.long	SZFLIP5A,SZFLIP5B,0
SZFLIP6	.long	SZFLIP6A,SZFLIP6B,0
SZFLIP7	.long	SZFLIP7A,SZFLIP7B,0
SZFLIP8	.long	SZFLIP8A,SZFLIP8B,0
SZFLIP9	.long	SZFLIP9A,SZFLIP9B,0

;**************************************************************

a_afb_kano
 	.long	ani_offset_xy
	.word	->3e,>0a
	.long	SZKNOCKDOWN1

	.long	ani_offset_xy
	.word	->47,>28
	.long	SZKNOCKDOWN3

	.long	ani_offset_xy
 	.word	->47,>2a
	.long	SZKNOCKDOWN4

	.long	0
*
* fall down solo
*
	.long	SZKNOCKDOWN4
	.long	SZKNOCKDOWN5
	.long	SZKNOCKDOWN6
	.long	SZKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	->16,->38
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>04,->3e
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>37,->56
	.long	SZFLIPPED4
	.long	ani_offset_xy
	.word	>55,->2a
	.long	SZFLIPPED4
	.long	ani_offset_xy
	.word	>5c,->0c
	.long	SZKNOCKDOWN6
	.long	ani_offset_xy
	.word	>64,>23
	.long	SZKNOCKDOWN6
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	->1d,>1a
	.long	SZSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	>00,>33
	.long	SZSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	->22,>1d
	.long	SZFLIPPED1		; 3
	.long	ani_offset_xy
	.word	->46,->0f
	.long	SZFLIPPED2		; 4
	.long	ani_offset_xy
	.word	->2c,->57
	.long	SZFLIPPED3		; 5
	.long	ani_offset_xy
	.word	>14,->6d
	.long	SZFLIPPED4		; 6
	.long	ani_offset_xy
	.word	>4f,->70
	.long	SZFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5a,->56
	.long	SZFLIPPED5		; 8
	.long	ani_offset_xy
	.word	>77,>02
	.long	SZFLIPPED5		; 9
	.long	ani_offset_xy
	.word	>77,>52
	.long	SZFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	->6e,>00
	.long	SZFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->5d,->4a
	.long	SZFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->04,->79
	.long	SZFLIPPED3		; 3
	.long	ani_offset_xy
	.word	>40,->57
	.long	SZFLIPPED4		; 4
	.long	ani_offset_xy
	.word	>44,->1f
	.long	SZFLIPPED5		; 5

	.long	ani_offset_xy
	.word	>0f,>15
	.long	SZFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->31,->14
  	.long	SZKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	->68,>01
	.long	SZFLIPPED1		; 8
	.long	ani_offset_xy
	.word	->4e,->54
	.long	SZFLIPPED2		; 9
	.long	ani_offset_xy
	.word	>2e,->68
	.long	SZFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	>65,->05
	.long	SZFLIPPED5		; 11
	.long	ani_offset_xy
	.word	>64,>09
  	.long	SZKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	->3d,->30
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->08,->52
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	->01,->5e
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>18,->4f
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>1a,->35
	.long	SZFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	->2c,->09
  	.long	SZKNOCKDOWN7
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	->4c,>00
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->32,>07
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->14,>07
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>03,>0f
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>0e,>1c
	.long	SZFLIPPED4

	.long	ani_offset_xy
	.word	->0f,->04
	.long	SZKNOCKDOWN6
	.long	ani_offset_xy
	.word	->23,->04
	.long	SZKNOCKDOWN6
	.long	ani_offset_xy
	.word	->38,->04
	.long	SZKNOCKDOWN6

	.long	ani_offset_xy
	.word	->50,>1a
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->67,->0b
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->2d,->4c
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>3a,->51
	.long	SZFLIPPED4
	.long	ani_offset_xy
	.word	>4c,->18
	.long	SZFLIPPED5
	.long	ani_offset_xy
	.word	>5b,->08
	.long	SZKNOCKDOWN6
	.long	0


a_fb_lk
	.long	ani_offset_xy
	.word	->3f,>00
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->36,>01
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->10,>0b
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>08,>10
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>4b,->0b
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>88,->34
	.long	SZFLIPPED4
	.long	0

	.long	SZFLIPPED5
	.long	SZKNOCKDOWN5
	.long	SZKNOCKDOWN6
	.long	SZKNOCKDOWN7
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	->36,->09
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->19,->29
	.long	SZFLIPPED2
	.long	ani_offset_xy
 	.word	>2f,->25
	.long	SZFLIPPED3
	.long	0

	.long	SZFLIPPED4
	.long	SZFLIPPED5
	.long	SZKNOCKDOWN5
	.long	SZKNOCKDOWN6
	.long	SZKNOCKDOWN7
	.long	0

a_fb_sonya
	.long	ani_offset_xy
	.word	->2d,>0c
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->11,>00
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>23,->0d
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>5a,->23
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>8a,->3d
	.long	SZFLIPPED4
	.long	0

	.long	SZFLIPPED5
	.long	SZKNOCKDOWN5
	.long	SZKNOCKDOWN6
	.long	SZKNOCKDOWN7
	.long	0


a_fb_jax
	.long	ani_offset_xy
	.word	->43,->1f
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->23,->3e
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>10,->4b
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>42,->1d
	.long	SZFLIPPED4
	.long	ani_offset_xy
	.word	>5c,>05
	.long	SZKNOCKDOWN6
	.long	ani_offset_xy
	.word	>49,>0a
	.long	SZKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	->5c,->18
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->48,->3e
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	->13,->58
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>2d,->3e
	.long	SZFLIPPED4
	.long	ani_offset_xy
	.word	>4e,->0b
	.long	SZFLIPPED5
	.long	ani_offset_xy
	.word	>58,->02
	.long	SZKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	->43,->2c
	.long	SZFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	>52,->17
	.long	SZFLIPPED3

	.long	ani_offset_xy
	.word	>2a,->07
	.long	SZFLIPPED5

	.long	ani_offset_xy
	.word	->0a,>04
	.long	SZKNOCKDOWN5

	.long	ani_offset_xy
	.word	->43,->26
	.long	SZKNOCKDOWN5

	.long	ani_offset_xy
	.word	->69,->4f
	.long	SZKNOCKDOWN5

	.long	0

a_fb_swat
	.long	ani_offset_xy
	.word	->51,->04
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->2e,->46
	.long	SZFLIPPED2
	.long	ani_offset_xy
	.word	>3f,->50
	.long	SZFLIPPED3
	.long	ani_offset_xy
	.word	>65,->1b
	.long	SZFLIPPED4
	.long	ani_offset_xy
	.word	>4c,>04
	.long	SZKNOCKDOWN6
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	->64,>00
	.long	SZSTUMBLE1
	.long	ani_offset_xy
	.word	->73,>03
	.long	SZSTUMBLE1

	.long	ani_offset_xy
	.word	->75,->1e
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->57,->3d
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	->23,->46
	.long	SZFLIPPED1
	.long	ani_offset_xy
	.word	>1e,->4e
	.long	SZFLIPPED1

	.long	ani_offset_xy
	.word	>a8,>12
	.long	SZFLIPPED4
	.long	ani_offset_xy
	.word	>8d,>00
	.long	SZKNOCKDOWN7
	.long	0


a_fb_robo
	.long	ani_offset_xy
	.word	->4e,->04
	.long	SZFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->43,->2f
	.long	SZFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->31,->48
	.long	SZFLIPPED2		; 3

	.long	ani_offset_xy
	.word	>0b,->64
	.long	SZFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>41,->72
	.long	SZFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>6b,->5b
	.long	SZFLIPPED4		; 6

	.long	ani_offset_xy
	.word	>80,->1e
	.long	SZFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5b,->08
	.long	SZKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	->29,>00
	.long	SZSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->2a,->0e
	.long	SZFLIPPED1		; 2
	.long	ani_offset_xy
	.word	->0a,->1f
	.long	SZFLIPPED2		; 3
	.long	ani_offset_xy
	.word	>1e,->1a
	.long	SZFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>13,->01
	.long	SZFLIPPED4		; 5
	.long	ani_offset_xy
	.word	->02,>01
	.long	SZFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->18,->11
	.long	SZKNOCKDOWN7		; 7
	.long	0


a_legged
	.long	ani_offset_xy
	.word	->66,>0b
	.long	SZKNOCKDOWN1

	.long	ani_offset_xy
	.word	->54,->1a
	.long	SZFLIPPED1

	.long	ani_offset_xy
	.word	->17,->45
	.long	SZFLIPPED3

	.long	ani_offset_xy
	.word	>30,->3a
	.long	SZFLIPPED4

	.long	ani_offset_xy
	.word	>55,->0b
	.long	SZFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	>55,->1c
	.long	SZKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	>57,>01
	.long	SZKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	>27,>16
	.long	SZKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	->30,>12
	.long	SZKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	->8b,->03
	.long	SZFLIPPED1	; 5

	.long	ani_offset_xy
	.word	->1f,->55
	.long	SZFLIPPED3	; 6
	.long	0

	.long	SZFLIPPED3
	.long	SZFLIPPED4
	.long	SZFLIPPED5
	.long	SZKNOCKDOWN5
	.long	SZKNOCKDOWN6
	.long	SZKNOCKDOWN7
	.long	0



a_shook
	.long	ani_offset_xy
	.word	->46,>00
	.long	SZSTUMBLE1	; 3

	.long	ani_offset_xy
	.word	->2f,->1a
	.long	SZSTUMBLE1	; 4

	.long	ani_offset_xy
	.word	->13,->10
	.long	SZSTUMBLE1	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	->18,->13
	.long	SZSTUMBLE1	; 6

	.long	ani_offset_xy
	.word	->2d,->1e
	.long	SZSTUMBLE1	; 7

	.long	ani_offset_xy
	.word	->3b,->1f
	.long	SZSTUMBLE1	; 8

	.long	ani_offset_xy
	.word	->30,->21
	.long	SZSTUMBLE1	; 7
	.long	0

SZFLIPPED1
	.long	SZGETFLIPPED1A,0
SZFLIPPED2
	.long	SZGETFLIPPED2A,SZGETFLIPPED2B,0
SZFLIPPED3
	.long	SZGETFLIPPED3A,SZGETFLIPPED3B,0
SZFLIPPED4
	.long	SZGETFLIPPED4A,SZGETFLIPPED4B,0
SZFLIPPED5
	.long	SZGETFLIPPED5A,SZGETFLIPPED5B,0

;**************************************************************

a_victory
	.long	SZVICTORY1
	.long	SZVICTORY2
	.long	SZVICTORY3
	.long	SZVICTORY4
	.long	0

SZVICTORY1
	.long	SZVICTORY1A,SZVICTORY1B,0
SZVICTORY2
	.long	SZVICTORY2A,SZVICTORY2B,0
SZVICTORY3
	.long	SZVICTORY3A,0
SZVICTORY4
	.long	SZVICTORY4A,0

;**************************************************************

a_zap	.long	SZTHROWPRO1
	.long	SZTHROWPRO2
	.long	SZTHROWPRO3
	.long	ani_sladd,ICEBS1
	.long	0

	.long	ICEBS1
	.long	ICEBS2
	.long	ICEBS3
	.long	ICEBS4
	.long	ICEBS5
	.long	ICEBS6
	.long	ICEBS7
	.long	0
*
* part 3 = ice hit !!
*
	.long	ICEBS8
	.long	ICEBS9
	.long	ICEBS10
	.long	ICEBS11
	.long	ICEBS12
	.long	ICEBS13
	.long	ICEBS14
	.long	ICEBS15
	.long	ICEBS16
	.long	ICEBS17
	.long	0
*
* part 4 = get out of zap ani
*
	.long	SZTHROWPRO3
	.long	SZTHROWPRO2
	.long	SZTHROWPRO1
	.long	0


SZTHROWPRO1
	.long	SZTHROWPRO1A,SZTHROWPRO1B,0
SZTHROWPRO2
	.long	SZTHROWPRO2A,SZTHROWPRO2B,0
SZTHROWPRO3
	.long	SZTHROWPRO3A,SZTHROWPRO3B,0

ICEBS1	.long	NJICEBALLS1,0
ICEBS2	.long	NJICEBALLS2,0
ICEBS3	.long	NJICEBALLS3,0
ICEBS4	.long	NJICEBALLS4,0
ICEBS5	.long	NJICEBALLS5,0
ICEBS6	.long	NJICEBALLS6,0
ICEBS7	.long	NJICEBALLS7,0
ICEBS8	.long	NJICEBALLS8,0
ICEBS9	.long	NJICEBALLS9,0
ICEBS10	.long	NJICEBALLS10,0
ICEBS11	.long	NJICEBALLS11,0
ICEBS12	.long	NJICEBALLS12,0
ICEBS13	.long	NJICEBALLS13,0
ICEBS14	.long	NJICEBALLS14,0
ICEBS15	.long	NJICEBALLS15,0
ICEBS16	.long	NJICEBALLS16,0
ICEBS17	.long	NJICEBALLS17,0

;************************************************************************

a_blow_ice
	.long	SZBLOWICE1
	.long	SZBLOWICE2
	.long	ani_sladd,ICEBLOW1
	.long	ani_slani_sleep,ICEBLOW1
	.long	ani_slani_sleep,ICEBLOW2
	.long	ani_slani_sleep,ICEBLOW3
	.long	ani_slani_sleep,ICEBLOW4
	.long	ani_slani_sleep,ICEBLOW5
	.long	0
	.long	ani_slani_sleep,ICEBLOW6
	.long	ani_slani_sleep,ICEBLOW7
	.long	ani_slani_sleep,ICEBLOW8
	.long	ani_slani_sleep,ICEBLOW9
	.long	ani_slani_sleep,ICEBLOW10
	.long	ani_slani_sleep,ICEBLOW11
	.long	0

SZBLOWICE1
	.long	SZBLOWICE1A,SZBLOWICE1B,0
SZBLOWICE2
	.long	SZBLOWICE2A,SZBLOWICE2B,0

;************************************************************************

a_sky_zap
	.long	SZSKYICE1
	.long	SZSKYICE2
	.long	SZSKYICE3
	.long	0

	.long	ani_sladd,SZICEUP1
	.long	ani_slani_sleep,SZICEUP1
	.long	ani_slani_sleep,SZICEUP2
	.long	ani_slani_sleep,SZICEUP3
	.long	ani_slani_sleep,SZICEUP4
	.long	ani_slani_sleep,SZICEUP5
	.long	ani_slani_sleep,SZICEUP6	; part 2 ---> ani with ice
	.long	0

	.long	ani_sladd,SZICEUP1		; new piece to finish "up" ice ani
	.long	ani_slani_sleep,SZICEUP7
	.long	ani_slani_sleep,SZICEUP8
	.long	ani_slani_sleep,SZICEUP9
	.long	ani_slani_sleep,SZICEUP10
	.long	ani_slani_sleep,SZICEUP11
	.long	ani_slani_sleep,SZICEUP12
	.long	0

	.long	SZICEFALL1
	.long	SZICEFALL2
	.long	SZICEFALL3
	.long	SZICEFALL4
	.long	SZICEFALL5
	.long	SZICEFALL6
	.long	SZICEFALL7
	.long	SZICEFALL8
	.long	SZICEFALL9
	.long	SZICEFALL10	; part 4 ---> ice fall
	.long	0

SZSKYICE1
	.long	SZSKYICE1A,SZSKYICE1B,0
SZSKYICE2
	.long	SZSKYICE2A,SZSKYICE2B,0
SZSKYICE3
	.long	SZSKYICE3A,SZSKYICE3B,0

SZICEUP1
	.long	SZICEUP1A,SZICEUP1B,0
SZICEUP2
	.long	SZICEUP2A,SZICEUP2B,0
SZICEUP3
	.long	SZICEUP3A,SZICEUP3B,0
SZICEUP4
	.long	SZICEUP4A,SZICEUP4B,0
SZICEUP5
	.long	SZICEUP5A,0
SZICEUP6
	.long	SZICEUP6A,0
SZICEUP7
	.long	SZICEUP7A,0
SZICEUP8
	.long	SZICEUP8A,SZICEUP8B,0
SZICEUP9
	.long	SZICEUP9A,0
SZICEUP10
	.long	SZICEUP10A,0
SZICEUP11
	.long	SZICEUP11A,0
SZICEUP12
	.long	SZICEUP12A,0
SZICEFALL1
	.long	SZICEFALL1A,0
SZICEFALL2
	.long	SZICEFALL2A,0
SZICEFALL3
	.long	SZICEFALL3A,0
SZICEFALL4
	.long	SZICEFALL4A,0
SZICEFALL5
	.long	SZICEFALL5A,SZICEFALL5B,SZICEFALL5C,0
SZICEFALL6
	.long	SZICEFALL6A,SZICEFALL6B,0
SZICEFALL7
	.long	SZICEFALL7A,SZICEFALL7B,0
SZICEFALL8
	.long	SZICEFALL8A,SZICEFALL8B,0
SZICEFALL9
	.long	SZICEFALL9A,SZICEFALL9B,0
SZICEFALL10
	.long	SZICEFALL10A,SZICEFALL10B,0

;************************************************************************

a_freeze_blast
	.long	FREZBLST1
	.long	FREZBLST2
	.long	FREZBLST3
	.long	FREZBLST4
	.long	FREZBLST5
	.long	FREZBLST6
	.long	FREZBLST7
	.long	FREZBLST8
	.long	FREZBLST9
	.long	FREZBLST10
	.long	FREZBLST11
	.long	FREZBLST12
	.long	0

FREZBLST1
	.long	FREZBLST1A,0
FREZBLST2
	.long	FREZBLST2A,FREZBLST2B,0
FREZBLST3
	.long	FREZBLST3A,0
FREZBLST4
	.long	FREZBLST4A,FREZBLST4B,0
FREZBLST5
	.long	FREZBLST5A,FREZBLST5B,FREZBLST5C,0
FREZBLST6
	.long	FREZBLST6A,FREZBLST6B,FREZBLST6C,0
FREZBLST7
	.long	FREZBLST7A,0
FREZBLST8
	.long	FREZBLST8A,FREZBLST8B,FREZBLST8C,0
FREZBLST9
	.long	FREZBLST9A,FREZBLST9B,FREZBLST9C,0
FREZBLST10
	.long	FREZBLST10A,FREZBLST10B,0
FREZBLST11
	.long	FREZBLST11A,FREZBLST11B,0
FREZBLST12
	.long	FREZBLST12A,FREZBLST12B,0

;*******************************

a_slide
	.long	SZDUCK1
	.long	SZSLIDE1
	.long	SZSLIDE2
	.long	0

SZSLIDE1
	.long	SZSLIDE1A,SZSLIDE1B,0
SZSLIDE2
	.long	SZSLIDE2A,SZSLIDE2B,0

;***********************************************************************

a_run
	.long	SZRUN1
	.long	SZRUN2
	.long	SZRUN3
	.long	SZRUN4
	.long	SZRUN5
	.long	SZRUN6
	.long	SZRUN7
	.long	SZRUN8
	.long	SZRUN9
	.long	SZRUN10
	.long	ani_jump,a_run

SZRUN1	.long	SZRUN1A,SZRUN1B,0
SZRUN2	.long	SZRUN2A,SZRUN2B,0
SZRUN3	.long	SZRUN3A,0
SZRUN4	.long	SZRUN4A,0
SZRUN5	.long	SZRUN5A,0
SZRUN6	.long	SZRUN6A,SZRUN6B,0
SZRUN7	.long	SZRUN7A,SZRUN7B,0
SZRUN8	.long	SZRUN8A,SZRUN8B,0
SZRUN9	.long	SZRUN9A,0
SZRUN10	.long	SZRUN10A,0

;**************************************************

a_scared
	.long	SZSCARED2
	.long	0

SZSCARED2
	.long	SZSCARED2A,0


a_thudd
	.long	SZTHUD1
	.long	SZTHUD2
	.long	SZTHUD3
	.long	SZTHUD4
	.long	SZTHUD5
	.long	SZTHUD6
	.long	SZTHUD7
	.long	0

SZTHUD1
	.long	SZTHUD1A,0
SZTHUD2
	.long	SZTHUD2A,0
SZTHUD3
	.long	SZTHUD3A,0
SZTHUD4
	.long	SZTHUD4A,0
SZTHUD5
	.long	SZTHUD5A,0
SZTHUD6
	.long	SZTHUD6A,0
SZTHUD7
	.long	SZTHUD7A,0

;**************************************************

a_lift_n_freeze
	.long	SZICEBREAK1
	.long	SZICEBREAK2
	.long	SZICEBREAK3
	.long	SZICEBREAK4
	.long	SZICEBREAK5
	.long	0

	.long	ani_sladd,ICEMAN1
	.long	SZICEBREAK6
	.long	ani_slani,ICEMAN2
	.long	SZICEBREAK7
	.long	ani_slani,ICEMAN3
	.long	SZICEBREAK8
	.long	ani_slani_sleep,ICEMAN4
	.long	0

	.long	ani_slani_sleep,ICEMANHIT1
	.long	ani_slani_sleep,ICEMANHIT2
	.long	ani_slani_sleep,ICEMANHIT3
	.long	ani_slani_sleep,ICEMANHIT4
	.long	0
*
* part 4 = single half of frozen dude
*
	.long	ICEMANHIT1
	.long	ICEMANHIT2
	.long	ICEMANHIT3
	.long	ICEMANHIT4
	.long	0

SZICEBREAK1
	.long	SZICEBREAK1A,SZICEBREAK1B,0
SZICEBREAK2
	.long	SZICEBREAK2A,SZICEBREAK2B,0
SZICEBREAK3
	.long	SZICEBREAK3A,SZICEBREAK3B,0
SZICEBREAK4
	.long	SZICEBREAK4A,SZICEBREAK4B,0
SZICEBREAK5
	.long	SZICEBREAK5A,SZICEBREAK5B,0
SZICEBREAK6
	.long	SZICEBREAK6A,SZICEBREAK6B,0
SZICEBREAK7
	.long	SZICEBREAK7A,SZICEBREAK7B,0
SZICEBREAK8
	.long	SZICEBREAK8A,SZICEBREAK8B,0

;*********************************************************************

ICEMAN1	.long	ICEMAN1A,0
ICEMAN2	.long	ICEMAN2A,0
ICEMAN3	.long	ICEMAN3A,ICEMAN3B,0
ICEMAN4	.long	ICEMAN4A,ICEMAN4B,0

ICEMANHIT1
	.long	ICEMANHIT1A,0
ICEMANHIT2
	.long	ICEMANHIT2A,0
ICEMANHIT3
	.long	ICEMANHIT3A,0
ICEMANHIT4
	.long	ICEMANHIT4A,0

;*********************************************************************

a_boomer
	.long	ICEMAN1
	.long	BOOM1
	.long	BOOM2
	.long	BOOM3
	.long	BOOM4
	.long	BOOM3
	.long	BOOM2
	.long	BOOM3
	.long	BOOM4
	.long	0

BOOM1	.long	FREEZEBODY1A,0
BOOM2	.long	FREEZEBODY2B,0
BOOM3	.long	FREEZEBODY3C,0
BOOM4	.long	FREEZEBODY4D,0

;*********************************************************************

	.end
