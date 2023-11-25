**************************************************************************
*											     *
*  mk3 - jax.asm											*
*											     *
**************************************************************************
	.FILE	"mkjax.ASM"
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mkjax.tbl
	.include mkjax2.tbl
	.include mkjax3.tbl
	.include mkjaxfix.tbl

	.include mainequ.asm
	.include imgtbl.glo
	.text

**************************************************************************

jax_anitab1
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
	.long	a_fb_lia	; 2c	- flipped by swat
	.long	a_fb_robo	; 2d	- flipped by robot ninja
	.long	a_fb_robo2	; 2e	- flipped by robot ninja 2
	.long	a_fb_lao	; 2f	- flipped by lao
	.long	a_fb_tusk	; 30 - flipped by tusk
	.long	a_fb_sg         ; 31 - flipped by she goro
	.long	a_fb_st		; 32 - flipped by shang tsung
	.long   a_fb_lk		; 33 - flipped by liu kang
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


jax_anitab2
	.long	a_quake		; 0 - quake
	.long	a_noogy		; 1 - noogy
	.long	a_dash_punch	; 2 - dashing punch
	.long	a_jax_slicer	; 3 - slicer
	.long	a_jax_grow	; 4
	.long	a_back_breaker	; 5
	.long	ochar_broken_bax_by_jax	; 6

a_dummy
a_stance
	.long	JXSTANCE1
	.long	JXSTANCE2
	.long	JXSTANCE3
	.long	JXSTANCE4
	.long	JXSTANCE5
	.long	JXSTANCE6
	.long	JXSTANCE7
	.long	JXSTANCE8
	.long	ani_jump,a_stance

JXSTANCE1
	.long	JXSTANCE1A,JXSTANCE1B,0
JXSTANCE2
	.long	JXSTANCE2A,JXSTANCE2B,0
JXSTANCE3
	.long	JXSTANCE3A,JXSTANCE3B,0
JXSTANCE4
	.long	JXSTANCE4A,JXSTANCE4B,0
JXSTANCE5
	.long	JXSTANCE5A,JXSTANCE5B,0
JXSTANCE6
	.long	JXSTANCE6A,JXSTANCE6B,0
JXSTANCE7
	.long	JXSTANCE7A,JXSTANCE7B,0
JXSTANCE8
	.long	JXSTANCE8A,JXSTANCE8B,0

;*************************************************************************

a_walkf	.long	JXWALK1
	.long	JXWALK2
	.long	JXWALK3
	.long	JXWALK4
	.long	JXWALK5
	.long	JXWALK6
	.long	JXWALK7
	.long	JXWALK8
	.long	JXWALK9
	.long	ani_jump,a_walkf

a_walkb	.long	JXWALK9
	.long	JXWALK8
	.long	JXWALK7
	.long	JXWALK6
	.long	JXWALK5
	.long	JXWALK4
	.long	JXWALK3
	.long	JXWALK2
	.long	JXWALK1
	.long	ani_jump,a_walkb

JXWALK1	.long	JXWALKLEG1A,JXWALKLEG1B,JXWALKTORSO1A,0
JXWALK2	.long	JXWALKLEG2A,JXWALKLEG2B,JXWALKTORSO2A,0
JXWALK3	.long	JXWALKLEG3A,JXWALKTORSO3A,0
JXWALK4	.long	JXWALKLEG4A,JXWALKTORSO4A,0
JXWALK5	.long	JXWALKLEG5A,JXWALKTORSO5A,0
JXWALK6	.long	JXWALKLEG6A,JXWALKTORSO6A,0
JXWALK7	.long	JXWALKLEG7A,JXWALKTORSO7A,0
JXWALK8	.long	JXWALKLEG8A,JXWALKLEG8B,JXWALKTORSO8A,0
JXWALK9	.long	JXWALKLEG9A,JXWALKLEG9B,JXWALKTORSO9A,0

;*************************************************************************

a_turn
	.long	JXTURN1
	.long	JXTURN2
	.long	ani_flip
	.long	JXTURN1
	.long	0

; even these out (ejbpatch)
a_duck_turn
	.long	JXDUCKTURN1
	.long	JXDUCKTURN2
	.long	ani_flip
	.long	JXDUCKTURN2
	.long	JXDUCKTURN1
	.long	JXDUCK3
	.long	0

JXTURN1	.long	JXTURN1A,JXTURN1B,0
JXTURN2	.long	JXTURN2A,JXTURN2B,0

JXDUCKTURN1
	.long	JXDUCKTURN1A,JXDUCKTURN1B,0
JXDUCKTURN2
	.long	JXDUCKTURN2A,JXDUCKTURN2B,0

;*************************************************************************


a_duck
	.long	JXDUCK1
	.long	JXDUCK2
	.long	JXDUCK3
	.long	0

JXDUCK1	.long	JXDUCK1A,JXDUCK1B,0
JXDUCK2	.long	JXDUCK2A,0
JXDUCK3	.long	JXDUCK3A,0

;*************************************************************************

a_duck_block
	.long	JXDUCKBLOCK1
	.long	JXDUCKBLOCK2
	.long	JXDUCKBLOCK3
	.long	0

JXDUCKBLOCK1
	.long	JXDUCKBLOCK1A,JXDUCKBLOCK1B,0
JXDUCKBLOCK2
	.long	JXDUCKBLOCK2A,JXDUCKBLOCK2B,0
JXDUCKBLOCK3
	.long	JXDUCKBLOCK3A,JXDUCKBLOCK3B,0

;*************************************************************************

a_duck_punch
	.long	JXDUCKPUNCH1
	.long	JXDUCKPUNCH2
	.long	JXDUCKPUNCH3
	.long	0
	.long	JXDUCKPUNCH2
	.long	JXDUCKPUNCH1
	.long	JXDUCK3
	.long	0

JXDUCKPUNCH1
	.long	JXDUCKPUNCH1A,JXDUCKPUNCH1B,0
JXDUCKPUNCH2
	.long	JXDUCKPUNCH2A,JXDUCKPUNCH2B,0
JXDUCKPUNCH3
	.long	JXDUCKPUNCH3A,0
	.long	0

;*************************************************************************

a_duck_hit
	.long	JXDUCKHIT2
	.long	JXDUCKHIT3
	.long	JXDUCKHIT2
	.long	JXDUCKHIT1
	.long	0

JXDUCKHIT1
	.long	JXDUCKHIT1A,JXDUCKHIT1B,0
JXDUCKHIT2
	.long	JXDUCKHIT2A,JXDUCKHIT2B,0
JXDUCKHIT3
	.long	JXDUCKHIT3A,JXDUCKHIT3B,0

;*************************************************************************

a_duck_kick_hi
	.long	JXDUCKHIKICK1
	.long	JXDUCKHIKICK2
;	.long	JXDUCKHIKICK3
	.long	JXDUCKHIKICK4
	.long	0
	.long	JXDUCKHIKICK3
	.long	JXDUCKHIKICK2
	.long	JXDUCKHIKICK1
	.long	JXDUCK3
	.long	0

JXDUCKHIKICK1
	.long	JXDUCKHIKIK1A,JXDUCKHIKIK1B,0
JXDUCKHIKICK2
	.long	JXDUCKHIKIK2A,JXDUCKHIKIK2B,0
JXDUCKHIKICK3
	.long	JXDUCKHIKIK3A,JXDUCKHIKIK3B,0
JXDUCKHIKICK4
	.long	JXDUCKHIKIK4A,JXDUCKHIKIK4B,0

;*************************************************************************

; we should make these all have the same # of frames (ejbpatch)
a_duck_kick_lo
	.long	JXDUCKLOKICK1
	.long	JXDUCKLOKICK2
	.long	JXDUCKLOKICK3
	.long	JXDUCKLOKICK4
	.long	0
	.long	JXDUCKLOKICK3
	.long	JXDUCKLOKICK2
	.long	JXDUCKLOKICK1
	.long	JXDUCK3
	.long	0

JXDUCKLOKICK1
	.long	JXDUCKLOKIK1A,JXDUCKLOKIK1B,0
JXDUCKLOKICK2
	.long	JXDUCKLOKIK2A,JXDUCKLOKIK2B,0
JXDUCKLOKICK3
	.long	JXDUCKLOKIK3A,JXDUCKLOKIK3B,0
JXDUCKLOKICK4
	.long	JXDUCKLOKIK4A,JXDUCKLOKIK4B,JXDUCKLOKIK4C,0

;*************************************************************************

a_uppercut
	.long	JXUPPERCUT2
	.long	JXUPPERCUT3
	.long	JXUPPERCUT4
	.long	JXUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
	.long	JXUPPERCUT6
	.long	0
	.long	JXHIPUNCH1
	.long	0

JXUPPERCUT2
	.long	JXUPPERCUT2A,JXUPPERCUT2B,0
JXUPPERCUT3
	.long	JXUPPERCUT3A,JXUPPERCUT3B,0
JXUPPERCUT4
	.long	JXUPPERCUT4A,JXUPPERCUT4B,0
JXUPPERCUT5
	.long	JXUPPERCUT5A,JXUPPERCUT5B,0
JXUPPERCUT6
	.long	JXUPPERCUT6A,JXUPPERCUT6B,0

;*************************************************************************

a_block
	.long	JXHIBLOCK1
	.long	JXHIBLOCK2
	.long	JXHIBLOCK3
	.long	0

; lows are not used (ejbpatch)

JXHIBLOCK1
	.long	JXHIBLOCK1A,JXHIBLOCK1B,0
JXHIBLOCK2
	.long	JXHIBLOCK2A,JXHIBLOCK2B,0
JXHIBLOCK3
	.long	JXHIBLOCK3A,JXHIBLOCK3B,0

;*************************************************************************

a_elbow
	.long	JXHEADBOP1
	.long	JXHEADBOP2
	.long	JXHEADBOP3
	.long	JXHEADBOP4
	.long	0
	.long	JXHEADBOP3
	.long	JXHEADBOP2
	.long	JXHEADBOP1
	.long	0

	.long	JXCOMBO1
	.long	JXCOMBO2
	.long	JXCOMBO3
	.long	JXCOMBO4	; part 3 = hit 2
	.long	0

	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO5
	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO6
	.long	JXCOMBO7
	.long	JXHEADBOP4	; part 4 = hit 3
	.long	0

	.long	JXCOMBO8
	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO9
	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO10
	.long	JXCOMBO11	; part 5 = hit 4
	.long	0

;	.long	JXCOMBO11
;	.long	JXCOMBO11
	.long	JXCOMBO11	; hold this frame

	.long	JXCOMBO12
	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO13
	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO14
	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO15
	.long	ani_adjustx
	.word	008H
	.long	JXCOMBO16	; part 6 = hit 5
	.long	0

	.long	JXCOMBO17
	.long	0


JXHEADBOP1
	.long	JXHEADBOP1A,JXHEADBOP1B,0
	.long	0
JXHEADBOP2
	.long	JXHEADBOP2A,JXHEADBOP2B,0
JXHEADBOP3
	.long	JXHEADBOP3A,JXHEADBOP3B,0
JXHEADBOP4
	.long	JXHEADBOP4A,JXHEADBOP4B,0


JXCOMBO1
	.long	JXCOMBO1A,JXCOMBO1B,0
JXCOMBO2
	.long	JXCOMBO2A,JXCOMBO2B,0
JXCOMBO3
	.long	JXCOMBO3A,JXCOMBO3B,0
JXCOMBO4
	.long	JXCOMBO4A,JXCOMBO4B,0
JXCOMBO5
	.long	JXCOMBO5A,JXCOMBO5B,0
JXCOMBO6
	.long	JXCOMBO6A,JXCOMBO6B,0
JXCOMBO7
	.long	JXCOMBO7A,JXCOMBO7B,0
JXCOMBO8
	.long	JXCOMBO8A,JXCOMBO8B,0
JXCOMBO9
	.long	JXCOMBO9A,JXCOMBO9B,0
JXCOMBO10
	.long	JXCOMBO10A,JXCOMBO10B,0
JXCOMBO11
	.long	JXCOMBO11A,JXCOMBO11B,0
JXCOMBO12
	.long	JXCOMBO12A,JXCOMBO12B,0
JXCOMBO13
	.long	JXCOMBO13A,JXCOMBO13B,0
JXCOMBO14
	.long	JXCOMBO14A,JXCOMBO14B,0
JXCOMBO15
	.long	JXCOMBO15A,JXCOMBO15B,0
JXCOMBO16
	.long	JXCOMBO16A,JXCOMBO16B,0
JXCOMBO17
	.long	JXCOMBO17A,JXCOMBO17B,0

;*************************************************************************

a_hipunch
	.long	JXHIPUNCH1
	.long	JXHIPUNCH2
	.long	JXHIPUNCH3
	.long	0

	.long	JXHIPUNCH4
	.long	JXHIPUNCH5
	.long	JXHIPUNCH6
	.long	0

	.long	JXHIPUNCH5
	.long	JXHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	JXHIPUNCH2
	.long	JXHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	JXHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	JXHIPUNCH4
	.long	JXLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	JXHIPUNCH5
	.long	JXLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0


a_lopunch
	.long	JXLOPUNCH1
	.long	JXLOPUNCH2
	.long	JXLOPUNCH3
	.long	0

	.long	JXLOPUNCH4
	.long	JXLOPUNCH5
	.long	JXLOPUNCH6
	.long	0

	.long	JXLOPUNCH5
	.long	JXLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	JXLOPUNCH2
	.long	JXLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	JXHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	JXLOPUNCH4
	.long	JXLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	JXLOPUNCH4
	.long	JXHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)



JXHIPUNCH1
	.long	JXHIPUNCH1A,JXHIPUNCH1B,0
JXHIPUNCH2
	.long	JXHIPUNCH2A,JXHIPUNCH2B,0
JXHIPUNCH3
	.long	JXHIPUNCH3A,JXHIPUNCH3B,0
JXHIPUNCH4
	.long	JXHIPUNCH4A,JXHIPUNCH4B,0
JXHIPUNCH5
	.long	JXHIPUNCH5A,JXHIPUNCH5B,0
JXHIPUNCH6
	.long	JXHIPUNCH6A,JXHIPUNCH6B,0
	.long	0
JXHIPUNCH7
	.long	JXHIPUNCH7A,JXHIPUNCH7B,0
JXLOPUNCH1
	.long	JXLOPUNCH1A,JXLOPUNCH1B,0
JXLOPUNCH2
	.long	JXLOPUNCH2A,JXLOPUNCH2B,0
JXLOPUNCH3
	.long	JXLOPUNCH3A,JXLOPUNCH3B,0
JXLOPUNCH4
	.long	JXLOPUNCH4A,JXLOPUNCH4B,0
JXLOPUNCH5
	.long	JXLOPUNCH5A,JXLOPUNCH5B,0
JXLOPUNCH6
	.long	JXLOPUNCH6A,JXLOPUNCH6B,0
JXLOPUNCH7
	.long	JXLOPUNCH7A,JXLOPUNCH7B,0
	.long	0

;*************************************************************************

a_jump	.long	JXJUMP1
	.long	JXJUMP2
	.long	JXJUMP3
	.long	0

JXJUMP1	.long	JXJUMP1A,JXJUMP1B,0
JXJUMP2	.long	JXJUMP2A,JXJUMP2B,0
JXJUMP3	.long	JXJUMP3A,JXJUMP3B,0

;*************************************************************************

a_jump_kick
	.long	JXJUMPKICK1
	.long	JXJUMPKICK2
	.long	JXJUMPKICK3
	.long	0
	.long	JXJUMPKICK2
	.long	JXJUMPKICK1
	.long	0

JXJUMPKICK1
	.long	JXJUMPKICK1A,JXJUMPKICK1B,0
JXJUMPKICK2
	.long	JXJUMPKICK2A,JXJUMPKICK2B,0
JXJUMPKICK3
	.long	JXJUMPKICK3A,JXJUMPKICK3B,0

;*************************************************************************

a_flip_kick
	.long	JXFLIPKICK1
	.long	JXFLIPKICK2
	.long	JXFLIPKICK3
	.long	0
	.long	JXFLIPKICK2
	.long	JXFLIPKICK1
	.long	0

JXFLIPKICK1
	.long	JXFLIPKICK1A,JXFLIPKICK1B,0
JXFLIPKICK2
	.long	JXFLIPKICK2A,JXFLIPKICK2B,0
JXFLIPKICK3
	.long	JXFLIPKICK3A,0

;*************************************************************************

a_flip_punch
	.long	JXFLIPUNCH1
	.long	JXFLIPUNCH2
	.long	JXFLIPUNCH3
	.long	0
	.long	JXFLIPUNCH2
	.long	JXFLIPUNCH1
	.long	0

JXFLIPUNCH1
	.long	JXFLIPUNCH1A,JXFLIPUNCH1B,0
JXFLIPUNCH2
	.long	JXFLIPUNCH2A,JXFLIPUNCH2B,0
JXFLIPUNCH3
	.long	JXFLIPUNCH3A,JXFLIPUNCH3B,0

;*************************************************************************

a_fflip	.long	JXJUMPFLIP1
	.long	JXJUMPFLIP2
	.long	JXJUMPFLIP3
	.long	JXJUMPFLIP4
	.long	JXJUMPFLIP5
	.long	JXJUMPFLIP6
	.long	JXJUMPFLIP7
	.long	JXJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip	.long	JXJUMPFLIP1
	.long	JXJUMPFLIP8
	.long	JXJUMPFLIP7
	.long	JXJUMPFLIP6
	.long	JXJUMPFLIP5
	.long	JXJUMPFLIP4
	.long	JXJUMPFLIP3
	.long	JXJUMPFLIP2
	.long	ani_jump,a_bflip+32

JXJUMPFLIP1
	.long	JXJUMPFLIP1A,0
JXJUMPFLIP2
	.long	JXJUMPFLIP2A,0
JXJUMPFLIP3
	.long	JXJUMPFLIP3A,0
JXJUMPFLIP4
	.long	JXJUMPFLIP4A,0
JXJUMPFLIP5
	.long	JXJUMPFLIP5A,0
JXJUMPFLIP6
	.long	JXJUMPFLIP6A,0
JXJUMPFLIP7
	.long	JXJUMPFLIP7A,0
JXJUMPFLIP8
	.long	JXJUMPFLIP8A,0

;*************************************************************************

a_stumble
	.long	JXSTUMBLE1
	.long	JXSTUMBLE2
	.long	JXSTUMBLE3
	.long	JXSTUMBLE4
	.long	JXSTUMBLE5
	.long	JXSTUMBLE6
	.long	JXSTUMBLE7
	.long	0

j_stumble
	.long	JXSTUMBLE1
	.long	JXSTUMBLE2
	.long	JXSTUMBLE3
	.long	JXSTUMBLE4
	.long	JXSTUMBLE5
	.long	JXSTUMBLE6
	.long	JXSTUMBLE7
	.long	ani_jump,j_stumble

JXSTUMBLE1
	.long	JXSTUMBLE1A,JXSTUMBLE1B,0
JXSTUMBLE2
	.long	JXSTUMBLE2A,JXSTUMBLE2B,0
JXSTUMBLE3
	.long	JXSTUMBLE3A,JXSTUMBLE3B,0
JXSTUMBLE4
	.long	JXSTUMBLE4A,JXSTUMBLE4B,0
JXSTUMBLE5
	.long	JXSTUMBLE5A,JXSTUMBLE5B,0
JXSTUMBLE6
	.long	JXSTUMBLE6A,0
JXSTUMBLE7
	.long	JXSTUMBLE7A,JXSTUMBLE7B,0

;*************************************************************************

a_dizzy
	.long	JXSTUNNED1
	.long	JXSTUNNED2
	.long	JXSTUNNED3
	.long	JXSTUNNED4
	.long	JXSTUNNED5
	.long	JXSTUNNED6
	.long	JXSTUNNED7
	.long	JXSTUNNED8
	.long	JXSTUNNED9
	.long	JXSTUNNED10
	.long	JXSTUNNED11
	.long	ani_jump,a_dizzy

JXSTUNNED1
	.long	JXSTUNNED1A,JXSTUNNED1B,0
JXSTUNNED2
	.long	JXSTUNNED2A,JXSTUNNED2B,0
JXSTUNNED3
	.long	JXSTUNNED3A,JXSTUNNED3B,0
JXSTUNNED4
	.long	JXSTUNNED4A,JXSTUNNED4B,0
JXSTUNNED5
	.long	JXSTUNNED5A,JXSTUNNED5B,0
JXSTUNNED6
	.long	JXSTUNNED6A,JXSTUNNED6B,0
JXSTUNNED7
	.long	JXSTUNNED7A,JXSTUNNED7B,0
JXSTUNNED8
	.long	JXSTUNNED8A,JXSTUNNED8B,0
JXSTUNNED9
	.long	JXSTUNNED9A,JXSTUNNED9B,0
JXSTUNNED10
	.long	JXSTUNNED10A,JXSTUNNED10B,0
JXSTUNNED11
	.long	JXSTUNNED11A,JXSTUNNED11B,0

;*************************************************************************

a_hit_hi
	.long	JXHIHIT2
	.long	JXHIHIT3
	.long	JXHIHIT2
	.long	JXHIHIT1
	.long	0

JXHIHIT1	.long	JXHIHIT1A,JXHIHIT1B,0
JXHIHIT2	.long	JXHIHIT2A,JXHIHIT2B,0
JXHIHIT3	.long	JXHIHIT3A,JXHIHIT3B,0


;*************************************************************************

a_hit_lo
	.long	JXLOHIT2
	.long	JXLOHIT3
	.long	JXLOHIT2
	.long	JXLOHIT1
	.long	0

JXLOHIT1	.long	JXLOHIT1A,JXLOHIT1B,0
JXLOHIT2	.long	JXLOHIT2A,JXLOHIT2B,0
JXLOHIT3	.long	JXLOHIT3A,JXLOHIT3B,0


;*************************************************************************

a_knockdown
	.long	JXKNOCKDOWN1
	.long	JXKNOCKDOWN2
	.long	JXKNOCKDOWN3
	.long	JXKNOCKDOWN4
	.long	JXKNOCKDOWN5
	.long	JXKNOCKDOWN6
	.long	0

	.long	JXKNOCKDOWN7
	.long	JXKNOCKDOWN8
	.long	0

JXKNOCKDOWN1
	.long	JXKNOCKDOWN1A,0
JXKNOCKDOWN2
	.long	JXKNOCKDOWN2A,0
JXKNOCKDOWN3
	.long	JXKNOCKDOWN3A,0
JXKNOCKDOWN4
	.long	JXKNOCKDOWN4A,JXKNOCKDOWN4B,0
JXKNOCKDOWN5
	.long	JXKNOCKDOWN5A,JXKNOCKDOWN5B,0
JXKNOCKDOWN6
	.long	JXKNOCKDOWN6A,JXKNOCKDOWN6B,0
JXKNOCKDOWN7
	.long	JXKNOCKDOWN7A,0
JXKNOCKDOWN8
	.long	JXKNOCKDOWN8A,0

;*************************************************************************

a_getup
	.long	JXGETUP1
	.long	JXGETUP2
	.long	JXGETUP3
	.long	JXGETUP4
	.long	JXGETUP5
	.long	JXGETUP6
	.long	0

JXGETUP1	.long	JXGETUP1A,JXGETUP1B,0
JXGETUP2	.long	JXGETUP2A,0
JXGETUP3	.long	JXGETUP3A,0
JXGETUP4	.long	JXGETUP4A,JXGETUP4B,0
JXGETUP5	.long	JXGETUP5A,0
JXGETUP6	.long	JXGETUP6A,JXGETUP6B,0

;*************************************************************************

a_throw
	.long	JXFLIP1
	.long	JXFLIP2
	.long	0

	.long	JXFLIP3		; both animate together
	.long	JXFLIP4
	.long	JXFLIP5
	.long	JXFLIP6
	.long	JXFLIP7
	.long	JXFLIP8
	.long	0
*
* get out of slam ani
*
	.long	JXFLIP7
	.long	JXFLIP6
	.long	0

JXFLIP1	.long	JXFLIP1A,JXFLIP1B,0
JXFLIP2	.long	JXFLIP2A,JXFLIP2B,0
JXFLIP3	.long	JXFLIP3A,JXFLIP3B,0
JXFLIP4	.long	JXFLIP4A,JXFLIP4B,0
JXFLIP5	.long	JXFLIP5A,JXFLIP5B,0
JXFLIP6	.long	JXFLIP6A,JXFLIP6B,0
JXFLIP7	.long	JXFLIP7A,JXFLIP7B,0
JXFLIP8	.long	JXFLIP8A,JXFLIP8B,0

;*************************************************************************

a_afb_kano
	.long	ani_offset_xy
	.word	-040H,-01bH
	.long	JXFLIPPED1

	.long	ani_offset_xy
	.word	-03cH,-00bH
	.long	JXKNOCKDOWN4

	.long	ani_offset_xy
 	.word	-059H,022H
	.long	JXKNOCKDOWN5
	.long	0
*
* fall down solo
*
	.long	JXKNOCKDOWN5
	.long	JXKNOCKDOWN6
	.long	JXKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	-01eH,-038H
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	008H,-048H
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	02fH,-041H
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	04aH,-026H
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	057H,002H
	.long	JXKNOCKDOWN6
	.long	ani_offset_xy
	.word	06bH,030H
	.long	JXKNOCKDOWN6
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	-034H,013H
	.long	JXSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	-01eH,02eH
	.long	JXSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	-02bH,020H
	.long	JXFLIPPED1		; 3
	.long	ani_offset_xy
	.word	-054H,-012H
	.long	JXFLIPPED2		; 4
	.long	ani_offset_xy
	.word	-02cH,-057H
	.long	JXFLIPPED3		; 5
	.long	ani_offset_xy
	.word	014H,-06dH
	.long	JXFLIPPED4		; 6
	.long	ani_offset_xy
	.word	019H,-074H
	.long	JXFLIPPED5		; 7
	.long	ani_offset_xy
	.word	054H,-070H
	.long	JXFLIPPED5		; 8
	.long	ani_offset_xy
	.word	060H,-056H
	.long	JXFLIPPED5		; 9
	.long	ani_offset_xy
	.word	077H,002H
	.long	JXFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	-06eH,-007H
	.long	JXFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-05dH,-04aH
	.long	JXFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-00cH,-081H
	.long	JXFLIPPED3		; 3
	.long	ani_offset_xy
	.word	040H,-057H
	.long	JXFLIPPED4		; 4
	.long	ani_offset_xy
	.word	044H,-015H
	.long	JXFLIPPED5		; 5

	.long	ani_offset_xy
	.word	00fH,01eH
	.long	JXFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-031H,001H
  	.long	JXKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	-075H,-00cH
	.long	JXFLIPPED1		; 8
	.long	ani_offset_xy
	.word	-054H,-04fH
	.long	JXFLIPPED2		; 9
	.long	ani_offset_xy
	.word	026H,-072H
	.long	JXFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	065H,-005H
	.long	JXFLIPPED5		; 11
	.long	ani_offset_xy
	.word	064H,009H
  	.long	JXKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	-03dH,-030H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-008H,-052H
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	001H,-059H
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	018H,-04fH
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	01aH,-028H
	.long	JXFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	-01bH,-011H
  	.long	JXKNOCKDOWN7
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	-04cH,000H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-041H,007H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-02aH,001H
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	-007H,003H
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	00eH,025H
	.long	JXFLIPPED4

	.long	ani_offset_xy
	.word	-00fH,-004H
	.long	JXKNOCKDOWN6
	.long	ani_offset_xy
	.word	-023H,-004H
	.long	JXKNOCKDOWN6
	.long	ani_offset_xy
	.word	-038H,-004H
	.long	JXKNOCKDOWN6

	.long	ani_offset_xy
	.word	-060H,019H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-067H,-00bH
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-03cH,-04cH
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	02bH,-041H
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	04cH,-018H
	.long	JXFLIPPED5
	.long	ani_offset_xy
	.word	05bH,-008H
	.long	JXKNOCKDOWN6
	.long	0


a_fb_lk
	.long	ani_offset_xy
	.word	-044H,-00eH
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-03bH,-00cH
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-013H,002H
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	010H,000H
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	037H,001H
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	088H,-01fH
	.long	JXFLIPPED4
	.long	0

	.long	JXFLIPPED5
	.long	JXKNOCKDOWN5
	.long	JXKNOCKDOWN6
	.long	JXKNOCKDOWN7
	.long	0



a_fb_kano
	.long	ani_offset_xy
	.word	-03fH,-01bH
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-01bH,-031H
	.long	JXFLIPPED2
	.long	ani_offset_xy
 	.word	04cH,-037H
	.long	JXFLIPPED3
	.long	0

	.long	JXFLIPPED4
	.long	JXFLIPPED5
	.long	JXKNOCKDOWN5
	.long	JXKNOCKDOWN6
	.long	JXKNOCKDOWN7
	.long	0


a_fb_sonya
	.long	ani_offset_xy
	.word	-031H,-00eH
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-01bH,001H
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	026H,-00aH
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	068H,-01bH
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	0a7H,-01fH
	.long	JXFLIPPED4
	.long	0

	.long	JXFLIPPED5
	.long	JXKNOCKDOWN5
	.long	JXKNOCKDOWN6
	.long	JXKNOCKDOWN7
	.long	0

a_fb_jax
	.long	ani_offset_xy
	.word	-04bH,-027H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-030H,-03eH
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	018H,-04cH
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	040H,-03aH
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	053H,-003H
	.long	JXFLIPPED5
	.long	ani_offset_xy
	.word	048H,000H
	.long	JXKNOCKDOWN7
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	-058H,-01dH
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-042H,-03cH
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	-009H,-05cH
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	038H,-054H
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	055H,-018H
	.long	JXFLIPPED5
	.long	ani_offset_xy
	.word	054H,00cH
	.long	JXKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	-04fH,-044H
	.long	JXFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	04dH,-01fH
	.long	JXFLIPPED4

	.long	ani_offset_xy
	.word	031H,002H
	.long	JXFLIPPED4

	.long	ani_offset_xy
	.word	-016H,-005H
	.long	JXKNOCKDOWN5

	.long	ani_offset_xy
	.word	-03fH,-02bH
	.long	JXKNOCKDOWN5

	.long	ani_offset_xy
	.word	-075H,-055H
	.long	JXKNOCKDOWN5
	.long	0

a_fb_swat
	.long	ani_offset_xy
	.word	-04fH,-016H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-043H,-044H
	.long	JXFLIPPED2
	.long	ani_offset_xy
	.word	030H,-05bH
	.long	JXFLIPPED3
	.long	ani_offset_xy
	.word	063H,-023H
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	048H,-002H
	.long	JXKNOCKDOWN7
	.long	0



a_fb_lia
	.long	ani_offset_xy
	.word	-064H,-00dH
	.long	JXSTUMBLE1
	.long	ani_offset_xy
	.word	-081H,-00dH
	.long	JXSTUMBLE1

	.long	ani_offset_xy
	.word	-07fH,-029H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-05dH,-048H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	-02eH,-054H
	.long	JXFLIPPED1
	.long	ani_offset_xy
	.word	016H,-05aH
	.long	JXFLIPPED1

	.long	ani_offset_xy
	.word	0a8H,012H
	.long	JXFLIPPED4
	.long	ani_offset_xy
	.word	08dH,000H
	.long	JXKNOCKDOWN7
	.long	0

a_fb_robo
	.long	ani_offset_xy
	.word	-04eH,-016H
	.long	JXFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-051H,-036H
	.long	JXFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-042H,-048H
	.long	JXFLIPPED2		; 3

	.long	ani_offset_xy
	.word	000H,-06eH
	.long	JXFLIPPED3		; 4
	.long	ani_offset_xy
	.word	03bH,-073H
	.long	JXFLIPPED4		; 5
	.long	ani_offset_xy
	.word	064H,-061H
	.long	JXFLIPPED4		; 6

	.long	ani_offset_xy
	.word	07fH,-01eH
	.long	JXFLIPPED5		; 7
	.long	ani_offset_xy
	.word	059H,-011H
	.long	JXKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	-036H,-00eH
	.long	JXSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	-032H,-028H
	.long	JXFLIPPED1		; 2
	.long	ani_offset_xy
	.word	-015H,-029H
	.long	JXFLIPPED2		; 3
	.long	ani_offset_xy
	.word	01cH,-024H
	.long	JXFLIPPED3		; 4
	.long	ani_offset_xy
	.word	022H,-00bH
	.long	JXFLIPPED4		; 5
	.long	ani_offset_xy
	.word	009H,005H
	.long	JXFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-018H,-012H
	.long	JXKNOCKDOWN8		; 7
	.long	0


JXFLIPPED1
	.long	JXFLIPPED1A,0
JXFLIPPED2
	.long	JXFLIPPED2A,0
JXFLIPPED3
	.long	JXFLIPPED3A,JXFLIPPED3B,0
JXFLIPPED4
	.long	JXFLIPPED4A,0
JXFLIPPED5
	.long	JXFLIPPED5A,JXFLIPPED5B,0

;*************************************************************************

a_sweepup
	.long	JXSWEEPUP1
	.long	JXSWEEPUP2
	.long	JXSWEEPUP3
	.long	JXSWEEPUP4
	.long	JXSWEEPUP5
	.long	JXSWEEPUP6
	.long	JXSWEEPUP7
	.long	0

JXSWEEPUP1
	.long	JXSWEEPUP1A,0
JXSWEEPUP2
	.long	JXSWEEPUP2A,JXSWEEPUP2B,0
JXSWEEPUP3
	.long	JXSWEEPUP3A,JXSWEEPUP3B,0
JXSWEEPUP4
	.long	JXSWEEPUP4A,0
JXSWEEPUP5
	.long	JXSWEEPUP5A,JXSWEEPUP5B,0
JXSWEEPUP6
	.long	JXSWEEPUP6A,JXSWEEPUP6B,0
JXSWEEPUP7
	.long	JXSWEEPUP7A,JXSWEEPUP7B,0

;*************************************************************************

a_sweep_fall
	.long	JXSWEEPFALL1
	.long	JXSWEEPFALL2
	.long	JXSWEEPFALL3
	.long	JXSWEEPFALL4
	.long	JXSWEEPFALL5
	.long	0
	.long	JXSWEEPFALL6
	.long	JXSWEEPFALL7
	.long	0

JXSWEEPFALL1
	.long	JXSWEEPFALL1A,JXSWEEPFALL1B,0
JXSWEEPFALL2
	.long	JXSWEEPFALL2A,JXSWEEPFALL2B,0
JXSWEEPFALL3
	.long	JXSWEEPFALL3A,JXSWEEPFALL3B,0
JXSWEEPFALL4
	.long	JXSWEEPFALL4A,0
JXSWEEPFALL5
	.long	JXSWEEPFALL5A,JXSWEEPFALL5B,0
JXSWEEPFALL6
	.long	JXSWEEPUP6A,JXSWEEPUP6B,0
JXSWEEPFALL7
	.long	JXSWEEPFALL7A,JXSWEEPFALL7B,0

;*************************************************************************

a_hikick
	.long	JXLOKICK1
	.long	JXLOKICK2
	.long	JXLOKICK3
	.long	JXLOKICK4
	.long	JXLOKICK5
	.long	JXHIKICK1
	.long	0
	.long	JXLOKICK5
	.long	JXLOKICK4
	.long	JXLOKICK3
	.long	JXLOKICK2
	.long	JXLOKICK1
	.long	0

a_lokick
	.long	JXLOKICK1 
	.long	JXLOKICK2
	.long	JXLOKICK3
	.long	JXLOKICK4
	.long	JXLOKICK5
	.long	JXLOKICK6
	.long	0
	.long	JXLOKICK5
	.long	JXLOKICK4
	.long	JXLOKICK3
	.long	JXLOKICK2
	.long	JXLOKICK1
	.long	0

JXLOKICK1
	.long	JXLOKICK1A,JXLOKICK1B,0
	.long	0
JXLOKICK2
	.long	JXLOKICK2A,JXLOKICK2B,0
	.long	0
JXLOKICK3
	.long	JXLOKICK3A,JXLOKICK3B,0
	.long	0
JXLOKICK4
	.long	JXLOKICK4A,JXLOKICK4B,0
JXLOKICK5
	.long	JXLOKICK5A,0
JXLOKICK6
	.long	JXLOKICK6A,0
JXHIKICK1
	.long	JXHIKICK1A,JXHIKICK1B,0

;*************************************************************************

a_knee
	.long	JXKNEE1
	.long	JXKNEE2
	.long	JXKNEE3
	.long	0
	.long	JXKNEE2
	.long	JXKNEE1
	.long	0

JXKNEE1	.long	JXKNEE1A,JXKNEE1B,0
JXKNEE2	.long	JXKNEE2A,0
JXKNEE3	.long	JXKNEE3A,JXKNEE3B,0

;*************************************************************************

a_sweep_kick
	.long	JXSWEEPKICK1
	.long	JXSWEEPKICK2
	.long	JXSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	JXSWEEPKICK4
	.long	JXSWEEPKICK5
	.long	0

	.long	JXSWEEPKICK6
	.long	JXSWEEPKICK7
	.long	0

JXSWEEPKICK1
	.long	JXSWEEPKICK1A,JXSWEEPKICK1B,0
JXSWEEPKICK2
	.long	JXSWEEPKICK2A,JXSWEEPKICK2B,0
JXSWEEPKICK3
	.long	JXSWEEPKICK3A,0
JXSWEEPKICK4
	.long	JXSWEEPKICK4A,JXSWEEPKICK4B,0
JXSWEEPKICK5
	.long	JXSWEEPKICK5A,JXSWEEPKICK5B,0
JXSWEEPKICK6
	.long	JXSWEEPKICK6A,JXSWEEPKICK6B,0
JXSWEEPKICK7
	.long	JXSWEEPKICK7A,0
JXSWEEPKICK8
	.long	0

;*************************************************************************

a_roundhouse
	.long	JXROUNDKICK1
	.long	JXROUNDKICK2
	.long	JXROUNDKICK3
	.long	JXROUNDKICK4
	.long	ani_nosleep
	.long	JXROUNDKICK5
	.long	0

	.long	JXROUNDKICK6
	.long	JXROUNDKICK7
	.long	JXROUNDKICK8
	.long	0

JXROUNDKICK1
	.long	JXNEWROUND1A,JXNEWROUND1B,0
;	.long	JXROUNDKICK1A,JXROUNDKICK1B,0

JXROUNDKICK2
	.long	JXROUNDKICK2A,JXROUNDKICK2B,0
JXROUNDKICK3
	.long	JXROUNDKICK3A,0
JXROUNDKICK4
	.long	JXROUNDKICK4A,0
JXROUNDKICK5
	.long	JXROUNDKICK5A,JXROUNDKICK5B,0
JXROUNDKICK6
	.long	JXROUNDKICK6A,0
JXROUNDKICK7
	.long	JXROUNDKICK7A,0
JXROUNDKICK8
	.long	JXROUNDKICK8A,JXROUNDKICK8B,0

;*************************************************************************

a_victory
	.long	JXVICTORY1
	.long	JXVICTORY2
	.long	JXVICTORY3
	.long	JXVICTORY4
	.long	JXVICTORY5
	.long	0

	.long	JXVICTORY6
	.long	JXVICTORY7
	.long	JXVICTORY8
	.long	JXVICTORY9
	.long	JXVICTORY10
	.long	0

JXVICTORY1
	.long	JXVICTORY1A,JXVICTORY1B,0
JXVICTORY2
	.long	JXVICTORY2A
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY3
	.long	JXVICTORY3A
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY4
	.long	JXVICTORY4A
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY5
	.long	JXVICTORY5A
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY6
	.long	JXVICTORY6A
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY7
	.long	JXVICTORY7A
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY8
	.long	JXVICTORY8A,JXVICTORY8B
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY9
	.long	JXVICTORY9A,JXVICTORY9B
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0
JXVICTORY10
	.long	JXVICTORY10A,JXVICTORY10B
	.long	JXVICTORYLEG1A,JXVICTORYLEG1B,0

;**************************************************************************

a_legged
	.long	ani_offset_xy
	.word	-05dH,-007H
	.long	JXKNOCKDOWN1

	.long	ani_offset_xy
	.word	-051H,-030H
	.long	JXFLIPPED1

	.long	ani_offset_xy
	.word	-00cH,-04aH
	.long	JXFLIPPED3

	.long	ani_offset_xy
	.word	037H,-02dH
	.long	JXFLIPPED4

	.long	ani_offset_xy
	.word	05eH,000H
	.long	JXFLIPPED5
	.long	0

;**************************************************************************

a_zap
	.long	JXCANNON1
	.long	ani_sladd,JAXZAP1	; introduce projectile obj
	.long	JXCANNON1

	.long	JXCANNON2
	.long	JXCANNON3
	.long	JXCANNON4
	.long	0

	.long	ani_sladd,JAXZAP1	; introduce projectile obj
	.long	ani_calla,lineup_number_2
	.long	JXCANNON5
	.long	JXCANNON6
	.long	JXCANNON7
	.long	0

lineup_number_2
	movi	-01aH,a0
	movi	-025H,a1
	move	a10,a5
	calla	adjust_xy_a5		; lineup jax's 2nd missle
	rets

JXCANNON1
	.long	JXCANNON1A,JXCANNON1B,0
JXCANNON2
	.long	JXCANNON2A,JXCANNON2B,0
JXCANNON3
	.long	JXCANNON3A,JXCANNON3B,0
JXCANNON4
	.long	JXCANNON4A,JXCANNON4B,0
JXCANNON5
	.long	JXCANNON5A,0
JXCANNON6
	.long	JXCANNON6A,JXCANNON6B,0
JXCANNON7
	.long	JXCANNON7A,0


a_projectile
	.long	JAXZAP2
	.long	JAXZAP3
	.long	JAXZAP4

j_jaxzap	.long	JAXZAP5
	.long	JAXZAP6
	.long	JAXZAP7
	.long	ani_jump,j_jaxzap
	.long	0

	.long	ani_swpal
	.long	JAXZAP8
	.long	JAXZAP9
	.long	JAXZAP10
	.long	JAXZAP11
	.long	JAXZAP12
	.long	JAXZAP13
	.long	0

JAXZAP1	.long	ARMSHOOT1,0
JAXZAP2	.long	ARMSHOOT2,0
JAXZAP3	.long	ARMSHOOT3,0
JAXZAP4	.long	ARMSHOOT4,0
JAXZAP5	.long	ARMPROJ1,0
JAXZAP6	.long	ARMPROJ2,0
JAXZAP7	.long	ARMPROJ3,0

JAXZAP8	.long	JXIMPACT3A,JXIMPACT3B,0
JAXZAP9	.long	JXIMPACT4A,JXIMPACT4B,0
JAXZAP10	.long	JXIMPACT5A,JXIMPACT5B,0
JAXZAP11	.long	JXIMPACT6A,JXIMPACT6B,JXIMPACT6C,JXIMPACT6D,0
JAXZAP12	.long	JXIMPACT7A,JXIMPACT7B,JXIMPACT7C,JXIMPACT7D,0
JAXZAP13	.long	JXIMPACT8A,JXIMPACT8B,JXIMPACT8C,JXIMPACT8D,0

;**************************************************************************

a_quake
	.long	ani_sladd,JXQAKPRO1	; introducing ---> QUAKE PROJECTILE obj
	.long	JXSTANCE6
	.long	ani_slani,JXQAKPRO2
	.long	JXQUAKEPUNCH1
	.long	0

	.long	ani_slani,JXQAKPRO3
	.long	JXQUAKEPUNCH2
	.long	ani_slani,JXQAKPRO4
	.long	JXQUAKEPUNCH3
	.long	ani_slani,JXQAKPRO5
	.long	JXQUAKEPUNCH4
	.long	ani_slani,JXQAKPRO6
	.long	JXQUAKEPUNCH5
	.long	0

	.long	ani_slani,JXQAKPRO7
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO8
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO9
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO10
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO11
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO12
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO13
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO14
	.long	JXQUAKEPUNCH5
	.long	ani_slani,JXQAKPRO15
	.long	JXQUAKEPUNCH5
	.long	0


JXQUAKEPUNCH1
	.long	JXQUAKEPUNCH1A,JXQUAKEPUNCH1B,0
JXQUAKEPUNCH2
	.long	JXQUAKEPUNCH2A,JXQUAKEPUNCH2B,0
JXQUAKEPUNCH3
	.long	JXQUAKEPUNCH3A,JXQUAKEPUNCH3B,0
JXQUAKEPUNCH4
	.long	JXQUAKEPUNCH4A,0
JXQUAKEPUNCH5
	.long	JXQUAKEPUNCH5A,0

JXQAKPRO1
	.long	JXQAKPRO1A,0
JXQAKPRO2
	.long	JXQAKPRO2A,JXQAKPRO2B,0
JXQAKPRO3
	.long	JXQAKPRO3A,0
JXQAKPRO4
	.long	JXQAKPRO4A,JXQAKPRO4B,0
JXQAKPRO5
	.long	JXQAKPRO5A,JXQAKPRO5B,0
JXQAKPRO6
	.long	JXQAKPRO6A,0
JXQAKPRO7
	.long	JXQAKPRO7A,JXQAKPRO7B,0
JXQAKPRO8
	.long	JXQAKPRO8A,JXQAKPRO8B,0
JXQAKPRO9
	.long	JXQAKPRO9A,JXQAKPRO9B,JXQAKPRO9C,0
JXQAKPRO10
	.long	JXQAKPRO10A,JXQAKPRO10B,JXQAKPRO10C,JXQAKPRO10D,0
JXQAKPRO11
	.long	JXQAKPRO11A,JXQAKPRO11B,JXQAKPRO11C,JXQAKPRO11D,0
JXQAKPRO12
	.long	JXQAKPRO12A,JXQAKPRO12B,JXQAKPRO12C,JXQAKPRO12D,JXQAKPRO12E,0
JXQAKPRO13
	.long	JXQAKPRO13A,JXQAKPRO13B,JXQAKPRO13C,JXQAKPRO13D,JXQAKPRO13E,0
JXQAKPRO14
	.long	JXQAKPRO14A,JXQAKPRO14B,JXQAKPRO14C,JXQAKPRO14D,0
JXQAKPRO15
	.long	JXQAKPRO15A,JXQAKPRO15B,JXQAKPRO15C,JXQAKPRO15D,0

;*************************************************************************

a_noogy
	.long	JXGOTCHA1
	.long	JXGOTCHA2
	.long	0
	.long	JXGOTCHA3
	.long	JXGOTCHA4

j_noog	.long	JXGOTCHA5
	.long	JXGOTCHA5
	.long	JXGOTCHA6
	.long	JXGOTCHA7
	.long	0

	.long	JXGOTCHA6
	.long	ani_jump,j_noog


JXGOTCHA1
	.long	JXGOTCHA1A,JXGOTCHA1B,0
	.long	0
JXGOTCHA2
	.long	JXGOTCHA2A,JXGOTCHA2B,0
	.long	0
JXGOTCHA3
	.long	JXGOTCHA3A,JXGOTCHA3B,0
JXGOTCHA4
	.long	JXGOTCHA4A,JXGOTCHA4B,0
	.long	0
JXGOTCHA5
	.long	JXGOTCHA5A,JXGOTCHA5B,0
	.long	0
JXGOTCHA6
	.long	JXGOTCHA6A,JXGOTCHA6B,0
	.long	0
JXGOTCHA7
	.long	JXGOTCHA7A,JXGOTCHA7B,0



a_zoomed
	.long	ani_offset_xy
	.word	055H,-01cH
	.long	JXKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	057H,001H
	.long	JXKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	020H,016H
	.long	JXKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	-037H,017H
	.long	JXKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	-08cH,-013H
	.long	JXFLIPPED1	; 5

	.long	ani_offset_xy
	.word	-02eH,-05eH
	.long	JXFLIPPED3	; 6
	.long	0

	.long	JXFLIPPED3
	.long	JXFLIPPED4
	.long	JXFLIPPED5
	.long	JXKNOCKDOWN5
	.long	JXKNOCKDOWN6
	.long	JXKNOCKDOWN7
	.long	0
;**********************************************************************

a_shook
	.long	ani_offset_xy
	.word	-04aH,-00dH
	.long	JXSTUMBLE2	; 3

	.long	ani_offset_xy
	.word	-031H,-026H
	.long	JXSTUMBLE2	; 4

	.long	ani_offset_xy
	.word	-01bH,-024H
	.long	JXSTUMBLE2	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	-01dH,-026H
	.long	JXSTUMBLE2	; 6

	.long	ani_offset_xy
	.word	-02dH,-030H
	.long	JXSTUMBLE2	; 7

	.long	ani_offset_xy
	.word	-03dH,-034H	
	.long	JXSTUMBLE2	; 8

	.long	ani_offset_xy
	.word	-02dH,-030H
	.long	JXSTUMBLE2	; 7
	.long	0

;**********************************************************************

a_dash_punch
	.long	JXSUPERPOW1
	.long	JXSUPERPOW2
	.long	JXSUPERPOW3			; blurr
	.long	0
	.long	JXSUPERPOW4
	.long	JXSUPERPOW5
	.long	JXSUPERPOW6			; unblurr

	.long	JXHIPUNCH2
	.long	JXHIPUNCH1
	.long	0

JXSUPERPOW1
	.long	JXSUPERPOW1A,JXSUPERPOW1B,0
JXSUPERPOW2
	.long	JXSUPERPOW2A,JXSUPERPOW2B,0
JXSUPERPOW3
	.long	JXSUPERPOW3A,JXSUPERPOW3B,0
JXSUPERPOW4
	.long	JXSUPERPOW4A,JXSUPERPOW4B,0
JXSUPERPOW5
	.long	JXSUPERPOW5A,JXSUPERPOW5B,0
JXSUPERPOW6
	.long	JXSUPERPOW6A,JXSUPERPOW6B,0

;**********************************************************************

a_run
	.long	JXRUN1
	.long	JXRUN2
	.long	JXRUN3
	.long	JXRUN4
	.long	JXRUN5
	.long	JXRUN6
	.long	JXRUN7
	.long	JXRUN8
	.long	JXRUN9
	.long	JXRUN10
	.long	JXRUN11
	.long	JXRUN12
	.long	ani_jump,a_run

JXRUN1
	.long	JXRUN1A,0
JXRUN2
	.long	JXRUN2A,JXRUN2B,0
JXRUN3
	.long	JXRUN3A,JXRUN3B,0
JXRUN4
	.long	JXRUN4A,JXRUN4B,0
JXRUN5
	.long	JXRUN5A,0
JXRUN6
	.long	JXRUN6A,0
JXRUN7
	.long	JXRUN7A,0
JXRUN8
	.long	JXRUN8A,0
JXRUN9
	.long	JXRUN9A,JXRUN9B,0
JXRUN10
	.long	JXRUN10A,JXRUN10B,0
JXRUN11
	.long	JXRUN11A,0
JXRUN12
	.long	JXRUN12A,0

;**********************************************************************

a_scared
	.long	JXSCARED1
	.long	0

JXSCARED1
	.long	JXSCARED1A,0



a_thudd
	.long	JXTHUD1
	.long	JXTHUD2
	.long	JXTHUD3
	.long	JXTHUD4
	.long	JXTHUD5
	.long	JXTHUD6
	.long	JXTHUD7
	.long	0

JXTHUD1
	.long	JXTHUD1A,0
JXTHUD2
	.long	JXTHUD2A,0
JXTHUD3
	.long	JXTHUD3A,0
JXTHUD4
	.long	JXTHUD4A,0
JXTHUD5
	.long	JXTHUD5A,0
JXTHUD6
	.long	JXTHUD6A,0
JXTHUD7
	.long	JXTHUD7A,0

;**********************************************************************

a_jax_slicer
	.long	JXSLICER1
	.long	JXSLICER3
	.long	JXSLICER4
	.long	JXSLICER5
	.long	0

	.long	JXSLICER6
j_slice	.long	JXSLICER7
	.long	JXSLICER8
	.long	JXSLICER9
	.long	JXSLICER10
	.long	JXSLICER11
	.long	JXSLICER12
	.long	JXSLICER13
	.long	JXSLICER14	
	.long	ani_jump,j_slice
	.long	0

	.long	JXSLICER5
	.long	JXSLICER4
	.long	JXSLICER3
	.long	JXSLICER1
	.long	0


JXSLICER1
	.long	JXSLICER1A,JXSLICER1B,0
JXSLICER3
	.long	JXSLICER3A,JXSLICER3B,JXSLICER2A,JXSLICER2B,0
JXSLICER4
	.long	JXSLICER4A,JXSLICER4B,JXSLICER2A,JXSLICER2B,0
JXSLICER5
	.long	JXSLICER5A,JXSLICER5B,JXSLICER2A,JXSLICER2B,0
JXSLICER6
	.long	JXSLICER6A,JXSLICER6B,0
JXSLICER7
	.long	JXSLICER7A,JXSLICER7B,0
JXSLICER8
	.long	JXSLICER8A,JXSLICER8B,0
JXSLICER9
	.long	JXSLICER9A,JXSLICER9B,0
JXSLICER10
	.long	JXSLICER10A,JXSLICER10B,0
JXSLICER11
	.long	JXSLICER11A,JXSLICER11B,0
JXSLICER12
	.long	JXSLICER12A,JXSLICER12B,JXSLICER12C,0
JXSLICER13
	.long	JXSLICER13A,JXSLICER13B,JXSLICER13C,0
JXSLICER14
	.long	JXSLICER14A,JXSLICER14B,0

a_jax_grow
	.long	JAXGROWFINA,JAXGROWFINB,0

;************************************************************************

a_back_breaker
	.long	JAXBAX1
	.long	JAXBAX2
	.long	0

JAXBAX1	.long	JXBREAKER2A,JXBREAKER2B,JXBREAKER2ARM,0
JAXBAX2	.long	JXBREAKER4A,JXBREAKER4ARM,0

;**************
;---> JXBREAKER1ARM,JXBREAKER2ARM,JXBREAKER3ARM
;JXBREAKER4ARM
;---> JXBREAKER4A
;JXBREAKER1A1
;	.long	JXBREAKER1ARM,JXBREAKER2ARM,JXBREAKER3ARM,JXBREAKER4ARM,0
;**************

ochar_broken_bax_by_jax
	.long	KNBROKEN1
	.long	SBBROKEN1
	.long	JXBROKEN1
	.long	INBROKEN1
	.long	SZBROKEN1
	.long	OBBACKBROKEN1
	.long	LIBACKBROKEN1
	.long	RBBACKBREAK1
	.long	RBBACKBREAK1
	.long	KLBACKBROKEN1
	.long	TRBACKBREAK1
	.long	SGBACKBREAK1
	.long	TSBACKBROKEN1
	.long	LUBACKBREAK1
	.long	RBBACKBREAK1

;KNBROKEN1
;	.long	KNBROKEN3A,KNBROKEN3B,0
SBBROKEN1
	.long	SBBROKEN3B,SBBROKEN3C,0
JXBROKEN1
	.long	JXBROKEN3A,JXBROKEN3B,JXBROKEN3C,0
JXBREAKER1
	.long	JXBREAKER2A,JXBREAKER2B,JXBREAKER4A,0
INBROKEN1
	.long	INBROKEN3A,INBROKEN3B,0
SZBROKEN1
	.long	SZBROKEN3B,SZBROKEN3C,0
OBBACKBROKEN1
	.long	OBBACKBROKEN3B,0
LIBACKBROKEN1
	.long	LIBACKBROKEN3A,LIBACKBROKEN3B,0
RBBACKBREAK1
	.long	RBBACKBREAK3A,RBBACKBREAK3B,0
KLBACKBROKEN1
	.long	KLBACKBROKEN3B,KLBACKBROKEN3C,0
TRBACKBREAK1
	.long	TRBACKBREAK3B,0
SGBACKBREAK1
	.long	SGBACKBREAK3B,SGBACKBREAK3C,0
TSBACKBROKEN1
	.long	TSBACKBROKEN3B,0
LUBACKBREAK1
	.long	LUBACKBREAK3B,LUBACKBREAK3C,0

;**************************************************************************

	.end
