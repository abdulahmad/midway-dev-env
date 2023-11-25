**************************************************************************
*											     *
*  mk3 - Kung Lao										*
*											     *
**************************************************************************
	.FILE	'mklao.asm'
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo
	.include mklao.tbl
	.include mklao2.tbl
	.include mklao3.tbl
	.include mklao4.tbl
	.text


lao_anitab1
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
	.long	a_fb_swat	; 2b - flipped by swat
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



lao_anitab2
	.long	a_tele_blur		; 0 -
	.long	a_hat_rings		; 1
	.long	a_spin			; 2
	.long	a_lao_top		; 3
	.long	a_hat_slice_throw	; 4
	.long	a_dummy			; 5
	.long	a_dummy			; 6

a_projectile
a_dummy


;***************************************************************

a_stance
	.long	KLSTANCE1
	.long	KLSTANCE2
	.long	KLSTANCE3
	.long	KLSTANCE4
	.long	KLSTANCE5
	.long	KLSTANCE6
	.long	KLSTANCE7
	.long	KLSTANCE8
	.long	KLSTANCE9
	.long	ani_jump,a_stance

KLSTANCE1
	.long	KLSTANCE1A,KLSTANCE1B,0
KLSTANCE2
	.long	KLSTANCE2A,KLSTANCE2B,0
KLSTANCE3
	.long	KLSTANCE3A,KLSTANCE3B,0
KLSTANCE4
	.long	KLSTANCE4A,KLSTANCE4B,0
KLSTANCE5
	.long	KLSTANCE5A,KLSTANCE5B,0
KLSTANCE6
	.long	KLSTANCE6A,KLSTANCE6B,0
KLSTANCE7
	.long	KLSTANCE7A,KLSTANCE7B,0
KLSTANCE8
	.long	KLSTANCE8A,KLSTANCE8B,0
KLSTANCE9
	.long	KLSTANCE9A,KLSTANCE9B,0

;***************************************************************

a_turn
	.long	KLTURN1
	.long	KLTURN2
	.long	ani_flip
	.long	KLTURN1
	.long	0

KLTURN1	.long	KLTURN1A,KLTURN1B,0
KLTURN2	.long	KLTURN2A,KLTURN2B,0

;**********
;ejbpatch - not used
;KLTURN3	.long	KLTURN3A,KLTURN3B,0
;**********

;***************************************************************

a_walkf
	.long	KLWALK1
	.long	KLWALK2
	.long	KLWALK3
	.long	KLWALK4
	.long	KLWALK5
	.long	KLWALK6
	.long	KLWALK7
	.long	KLWALK8
	.long	KLWALK9
	.long	ani_jump,a_walkf

a_walkb	.long	KLWALK9
	.long	KLWALK8
	.long	KLWALK7
	.long	KLWALK6
	.long	KLWALK5
	.long	KLWALK4
	.long	KLWALK3
	.long	KLWALK2
	.long	KLWALK1
	.long	ani_jump,a_walkb

KLWALK1	.long	KLWALKTORSO1,KLWALK1A,KLWALK1B,0
KLWALK2	.long	KLWALKTORSO2,KLWALK2A,KLWALK2B,0
KLWALK3	.long	KLWALKTORSO3,KLWALK3A,0
KLWALK4	.long	KLWALKTORSO4,KLWALK4A,KLWALK4B,0
KLWALK5	.long	KLWALKTORSO5,KLWALK5A,KLWALK5B,0
KLWALK6	.long	KLWALKTORSO6,KLWALK6A,KLWALK6B,0
KLWALK7	.long	KLWALKTORSO7,KLWALK7A,0
KLWALK8	.long	KLWALKTORSO8,KLWALK8A,KLWALK8B,0
KLWALK9	.long	KLWALKTORSO9,KLWALK9A,KLWALK9B,0

;***************************************************************

a_duck	.long	KLDUCK1
	.long	KLDUCK2
	.long	KLDUCK3
	.long	0

KLDUCK1	.long	KLDUCK1A,KLDUCK1B,0
KLDUCK2	.long	KLDUCK2A,KLDUCK2B,0
KLDUCK3	.long	KLDUCK3A,KLDUCK3B,0

;***************************************************************

a_duck_turn
	.long	KLDUCKTURN1
	.long	KLDUCKTURN2
	.long	ani_flip
	.long	KLDUCKTURN2
	.long	KLDUCK3
	.long	0

KLDUCKTURN1
	.long	KLDUCKTURN1A,KLDUCKTURN1B,0
KLDUCKTURN2
	.long	KLDUCKTURN2A,KLDUCKTURN2B,0

;***************************************************************

a_duck_block
	.long	KLDUCKBLOCK1
	.long	KLDUCKBLOCK2
	.long	KLDUCKBLOCK3
	.long	0

KLDUCKBLOCK1
	.long	KLDUCKBLOCK1A,KLDUCKBLOCK1B,0
KLDUCKBLOCK2
	.long	KLDUCKBLOCK2A,KLDUCKBLOCK2B,0
KLDUCKBLOCK3
	.long	KLDUCKBLOCK3A,KLDUCKBLOCK3B,0

;***************************************************************

a_duck_hit
	.long	KLDUCKHIT2
	.long	KLDUCKHIT3
	.long	KLDUCKHIT2
	.long	KLDUCKHIT1
	.long	0

KLDUCKHIT1
	.long	KLDUCKHIT1A,KLDUCKHIT1B,0
KLDUCKHIT2
	.long	KLDUCKHIT2A,KLDUCKHIT2B,0
KLDUCKHIT3
	.long	KLDUCKHIT3A,KLDUCKHIT3B,0

;***************************************************************

a_duck_punch
	.long	KLDUCKPUNCH1
	.long	KLDUCKPUNCH2
	.long	KLDUCKPUNCH3
	.long	0
	.long	KLDUCKPUNCH2
	.long	KLDUCKPUNCH1
	.long	KLDUCK3
	.long	0

KLDUCKPUNCH1
	.long	KLDUCKPUNCH1A,KLDUCKPUNCH1B,0
KLDUCKPUNCH2
	.long	KLDUCKPUNCH2A,KLDUCKPUNCH2B,0
KLDUCKPUNCH3
	.long	KLDUCKPUNCH3A,0

;***************************************************************

a_duck_kick_lo
	.long	KLDUCKLOKICK1
	.long	KLDUCKLOKICK2
	.long	KLDUCKLOKICK3
	.long	0
	.long	KLDUCKLOKICK2
	.long	KLDUCKLOKICK1
	.long	KLDUCK3
	.long	0

KLDUCKLOKICK1
	.long	KLDUCKLOKICK1A,KLDUCKLOKICK1B,0
KLDUCKLOKICK2
	.long	KLDUCKLOKICK2A,KLDUCKLOKICK2B,KLDUCKLOKICK2C,0
KLDUCKLOKICK3
	.long	KLDUCKLOKICK3A,KLDUCKLOKICK3B,KLDUCKLOKICK3C,0

;***************************************************************

a_duck_kick_hi
	.long	KLDUCKLOKICK1
	.long	KLDUCKLOKICK2
	.long	KLDUCKHIKICK1
	.long	KLDUCKHIKICK2
	.long	0
	.long	KLDUCKHIKICK1
	.long	KLDUCKLOKICK2
	.long	KLDUCKLOKICK1
	.long	KLDUCK3
	.long	0

KLDUCKHIKICK1
	.long	KLDUCKHIKICK1A,KLDUCKHIKICK1B,0
KLDUCKHIKICK2
	.long	KLDUCKHIKICK2A,KLDUCKHIKICK2B,0

;***************************************************************

a_uppercut

;ejbpatch
;	.long	KLUPPERCUT1

	.long	KLUPPERCUT2
	.long	KLUPPERCUT3
	.long	KLUPPERCUT4
	.long	KLUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame

;ejbpatch
;	.long	KLUPPERCUT6
	.long	KLUPPERCUT7
	.long	0
	.long	KLUPPERCUT5
	.long	0

KLUPPERCUT1
	.long	KLUPPERCUT1A,KLUPPERCUT1B,0
KLUPPERCUT2
	.long	KLUPPERCUT2A,KLUPPERCUT2B,0
KLUPPERCUT3
	.long	KLUPPERCUT3A,KLUPPERCUT3B,0
KLUPPERCUT4
	.long	KLUPPERCUT4A,KLUPPERCUT4B,0
KLUPPERCUT5
	.long	KLUPPERCUT5A,KLUPPERCUT5B,KLUPPERCUT5C,0
KLUPPERCUT6
	.long	KLUPPERCUT6A,KLUPPERCUT6B,0
KLUPPERCUT7
	.long	KLUPPERCUT7A,KLUPPERCUT7B,0

;***************************************************************

a_lopunch
	.long	KLLOPUNCH1
	.long	KLLOPUNCH2
	.long	KLLOPUNCH3
	.long	0

	.long	KLLOPUNCH4
	.long	KLLOPUNCH5
	.long	KLLOPUNCH6
	.long	0

	.long	KLLOPUNCH5
	.long	KLLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	KLLOPUNCH2
	.long	KLLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	KLHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	KLLOPUNCH4
	.long	KLLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	KLLOPUNCH4
	.long	KLHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)


a_hipunch
	.long	KLHIPUNCH1
	.long	KLHIPUNCH2
	.long	KLHIPUNCH3
	.long	0

	.long	KLHIPUNCH4
	.long	KLHIPUNCH5
	.long	KLHIPUNCH6
	.long	0

	.long	KLHIPUNCH5
	.long	KLHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	KLHIPUNCH2
	.long	KLHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	KLHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	KLHIPUNCH4
;	.long	KLLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	KLHIPUNCH5
;	.long	KLLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0



KLLOPUNCH1
	.long	KLLOPUNCH1A,KLLOPUNCH1B,0
KLLOPUNCH2
	.long	KLLOPUNCH2A,KLLOPUNCH2B,0
KLLOPUNCH3
	.long	KLLOPUNCH3A,KLLOPUNCH3B,0
KLLOPUNCH4
	.long	KLLOPUNCH4A,KLLOPUNCH4B,0
KLLOPUNCH5
	.long	KLLOPUNCH5A,KLLOPUNCH5B,0
KLLOPUNCH6
	.long	KLLOPUNCH6A,KLLOPUNCH6B,0

KLHIPUNCH1
	.long	KLHIPUNCH1A,KLHIPUNCH1B,0
KLHIPUNCH2
	.long	KLHIPUNCH2A,KLHIPUNCH2B,0
KLHIPUNCH3
	.long	KLHIPUNCH3A,KLHIPUNCH3B,0
KLHIPUNCH4
	.long	KLHIPUNCH4A,KLHIPUNCH4B,0
KLHIPUNCH5
	.long	KLHIPUNCH5A,KLHIPUNCH5B,0
KLHIPUNCH6
	.long	KLHIPUNCH6A,KLHIPUNCH6B,0
KLHIPUNCH7
	.long	KLHIPUNCH7A,KLHIPUNCH7B,0

;***************************************************************

a_elbow
	.long	KLCOMBO1
	.long	KLCOMBO2
	.long	KLCOMBO3
	.long	0
*
* part 2
*
j_unelbow
	.long	KLCOMBO2
	.long	KLCOMBO1
	.long	0
*
* part 3
*
	.long	ani_adjustx
	.word	>10
	.long	KLCOMBO4
	.long	ani_adjustx
	.word	>10
	.long	KLCOMBO5
	.long	0
*
* part 4
*
j_chop	.long	ani_adjustx
	.word	>14
	.long	KLCOMBO6
	.long	ani_adjustx
	.word	>14
	.long	KLCOMBO7
	.long	ani_adjustxy
	.word	>14,>00
	.long	KLCOMBO8
	.long	0
*
* part 5
*
	.long	KLCOMBO9
	.long	ani_adjustx
	.word	>14
	.long	KLCOMBO10
	.long	ani_adjustx
	.word	>14
	.long	0
	.long	ani_jump,j_unelbow



KLCOMBO1
	.long	KLCOMBO1A,KLCOMBO1B,0
KLCOMBO2
	.long	KLCOMBO2A,KLCOMBO2B,0
KLCOMBO3
	.long	KLCOMBO3A,KLCOMBO3B,0
KLCOMBO4
	.long	KLCOMBO4A,KLCOMBO4B,0
KLCOMBO5
	.long	KLCOMBO5A,KLCOMBO5B,0
KLCOMBO6
	.long	KLCOMBO6A,KLCOMBO6B,0
KLCOMBO7
	.long	KLCOMBO7A,KLCOMBO7B,0
KLCOMBO8
	.long	KLCOMBO8A,KLCOMBO8B,0
KLCOMBO9
	.long	KLCOMBO9A,KLCOMBO9B,0
KLCOMBO10
	.long	KLCOMBO10A,KLCOMBO10B,0

;***************************************************************

a_block
	.long	KLHIBLOCK1
	.long	KLHIBLOCK2
	.long	KLHIBLOCK3
	.long	0

KLHIBLOCK1
	.long	KLHIBLOCK1A,KLHIBLOCK1B,0
KLHIBLOCK2
	.long	KLHIBLOCK2A,KLHIBLOCK2B,0
KLHIBLOCK3
	.long	KLHIBLOCK3A,KLHIBLOCK3B,0

;********************************************************

a_knee	.long	KLKNEECOMBO1
	.long	KLKNEECOMBO2
	.long	KLKNEECOMBO3
	.long	0
	.long	KLKNEECOMBO2
	.long	KLKNEECOMBO1
	.long	0

	.long	KLKNEECOMBO4
	.long	KLKNEECOMBO5
	.long	0

	.long	KLKNEECOMBO6
	.long	KLKNEECOMBO7
	.long	KLKNEECOMBO8
	.long	KLKNEECOMBO9
	.long	KLKNEECOMBO10
	.long	0

	.long	ani_jump,j_roundend

KLKNEECOMBO1
	.long	KLKNEECOMBO1A,KLKNEECOMBO1B,0
KLKNEECOMBO2
	.long	KLKNEECOMBO2A,KLKNEECOMBO2B,0
KLKNEECOMBO3
	.long	KLKNEECOMBO3A,KLKNEECOMBO3B,0
KLKNEECOMBO4
	.long	KLKNEECOMBO4A,0
KLKNEECOMBO5
	.long	KLKNEECOMBO5A,KLKNEECOMBO5B,0
KLKNEECOMBO6
	.long	KLKNEECOMBO6A,KLKNEECOMBO6B,0
KLKNEECOMBO7
	.long	KLKNEECOMBO7A,KLKNEECOMBO7B,0
KLKNEECOMBO8
	.long	KLKNEECOMBO8A,0
KLKNEECOMBO9
	.long	KLKNEECOMBO9A,KLKNEECOMBO9B,0
KLKNEECOMBO10
	.long	KLKNEECOMBO10A,KLKNEECOMBO10B,0

;********************************************************

a_roundhouse
	.long	KLROUNDKICK1
	.long	KLROUNDKICK2
	.long	KLROUNDKICK3
	.long	KLROUNDKICK4
	.long	ani_nosleep
	.long	KLROUNDKICK5
	.long	0
j_roundend
	.long	KLROUNDKICK6
	.long	KLROUNDKICK7
	.long	KLROUNDKICK8
	.long	0

KLROUNDKICK1
	.long	KLROUNDKICK1A,KLROUNDKICK1B,0
KLROUNDKICK2
	.long	KLROUNDKICK2A,0
KLROUNDKICK3
	.long	KLROUNDKICK3A,0
KLROUNDKICK4
	.long	KLROUNDKICK4A,0
KLROUNDKICK5
	.long	KLROUNDKICK5A,KLROUNDKICK5B,0
KLROUNDKICK6
	.long	KLROUNDKICK6A,KLROUNDKICK6B,0
KLROUNDKICK7
	.long	KLROUNDKICK7A,0
KLROUNDKICK8
	.long	KLROUNDKICK8A,KLROUNDKICK8B,0

;********************************************************

a_sweep_kick
	.long	KLSWEEPKICK1
	.long	KLSWEEPKICK2
	.long	KLSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	KLSWEEPKICK4
	.long	KLSWEEPKICK5
	.long	0

	.long	KLSWEEPKICK6
	.long	KLSWEEPKICK7
	.long	KLSWEEPKICK8
	.long	0

KLSWEEPKICK1
	.long	KLSWEEPKICK1A,KLSWEEPKICK1B,0
KLSWEEPKICK2
	.long	KLSWEEPKICK2A,KLSWEEPKICK2B,0
KLSWEEPKICK3
	.long	KLSWEEPKICK3A,KLSWEEPKICK3B,0
KLSWEEPKICK4
	.long	KLSWEEPKICK4A,KLSWEEPKICK4B,0
KLSWEEPKICK5
	.long	KLSWEEPKICK5A,KLSWEEPKICK5B,0
KLSWEEPKICK6
	.long	KLSWEEPKICK6A,KLSWEEPKICK6B,0
KLSWEEPKICK7
	.long	KLSWEEPKICK7A,KLSWEEPKICK7B,0
KLSWEEPKICK8
	.long	KLSWEEPKICK8A,KLSWEEPKICK8B,0

;***************************************************************

a_hikick
	.long	KLLOKICK1
	.long	KLLOKICK2
	.long	KLLOKICK3
	.long	KLHIKICK1
	.long	KLHIKICK2
	.long	KLHIKICK3
	.long	0
	.long	KLHIKICK2
	.long	KLHIKICK1
	.long	KLLOKICK3
	.long	KLLOKICK2
	.long	KLLOKICK1
	.long	0

KLHIKICK1
	.long	KLHIKICK1A,KLHIKICK1B,0
KLHIKICK2
	.long	KLHIKICK2A,0
KLHIKICK3
	.long	KLHIKICK3A,KLHIKICK3B,0


a_lokick
	.long	KLLOKICK1
	.long	KLLOKICK2
	.long	KLLOKICK3
	.long	KLLOKICK4
	.long	KLLOKICK5
	.long	KLLOKICK6
	.long	0
	.long	KLLOKICK5
	.long	KLLOKICK4
	.long	KLLOKICK3
	.long	KLLOKICK2
	.long	KLLOKICK1
	.long	0

KLLOKICK1
	.long	KLLOKICK1A,KLLOKICK1B,0
KLLOKICK2
	.long	KLLOKICK2A,KLLOKICK2B,0
KLLOKICK3
	.long	KLLOKICK3A,KLLOKICK3B,0
KLLOKICK4
	.long	KLLOKICK4A,KLLOKICK4B,0
KLLOKICK5
	.long	KLLOKICK5A,KLLOKICK5B,0
KLLOKICK6
	.long	KLLOKICK6A,0

;********************************************************

a_jump	.long	KLJUMP1
	.long	KLJUMP2
	.long	KLJUMP3
	.long	0

KLJUMP1	.long	KLJUMP1A,KLJUMP1B,0
KLJUMP2	.long	KLJUMP2A,KLJUMP2B,0
KLJUMP3	.long	KLJUMP3A,KLJUMP3B,0

;********************************************************

a_jump_kick
	.long	KLJUMPKICK1
	.long	KLJUMPKICK2
	.long	KLJUMPKICK3
	.long	0
	.long	KLJUMPKICK2
	.long	KLJUMPKICK1
	.long	0

KLJUMPKICK1
	.long	KLJUMPKICK1A,KLJUMPKICK1B,0
KLJUMPKICK2
	.long	KLJUMPKICK2A,KLJUMPKICK2B,KLJUMPKICK2C,0
KLJUMPKICK3
	.long	KLJUMPKICK3A,KLJUMPKICK3B,0

;********************************************************

a_fflip	.long	KLJUMPFLIP1
	.long	KLJUMPFLIP2
	.long	KLJUMPFLIP3
	.long	KLJUMPFLIP4
	.long	KLJUMPFLIP5
	.long	KLJUMPFLIP6
	.long	KLJUMPFLIP7
	.long	KLJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip	.long	KLJUMPFLIP1
	.long	KLJUMPFLIP8
	.long	KLJUMPFLIP7
	.long	KLJUMPFLIP6
	.long	KLJUMPFLIP5
	.long	KLJUMPFLIP4
	.long	KLJUMPFLIP3
	.long	KLJUMPFLIP2
	.long	ani_jump,a_bflip+32

KLJUMPFLIP1
	.long	KLJUMPFLIP1A,0
KLJUMPFLIP2
	.long	KLJUMPFLIP2A,0
KLJUMPFLIP3
	.long	KLJUMPFLIP3A,0
KLJUMPFLIP4
	.long	KLJUMPFLIP4A,0
KLJUMPFLIP5
	.long	KLJUMPFLIP5A,0
KLJUMPFLIP6
	.long	KLJUMPFLIP6A,0
KLJUMPFLIP7
	.long	KLJUMPFLIP7A,0
KLJUMPFLIP8
	.long	KLJUMPFLIP8A,0

;********************************************************

a_flip_punch
	.long	KLFLIPUNCH1
	.long	KLFLIPUNCH2
	.long	KLFLIPUNCH3
	.long	0
	.long	KLFLIPUNCH2
	.long	KLFLIPUNCH1
	.long	0

KLFLIPUNCH1
	.long	KLFLIPUNCH1A,0
KLFLIPUNCH2
	.long	KLFLIPUNCH2A,KLFLIPUNCH2B,0
KLFLIPUNCH3
	.long	KLFLIPUNCH3A,KLFLIPUNCH3B,0

;********************************************************

a_flip_kick
	.long	KLFLIPKICK1
	.long	KLFLIPKICK2
	.long	KLFLIPKICK3
	.long	0
	.long	KLFLIPKICK2
	.long	KLFLIPKICK1
	.long	0

KLFLIPKICK1
	.long	KLFLIPKICK1A,0
KLFLIPKICK2
	.long	KLFLIPKICK2A,0
KLFLIPKICK3
	.long	KLFLIPKICK3A,0

;********************************************************

a_stumble
	.long	KLSTUMBLE1
	.long	KLSTUMBLE2
	.long	KLSTUMBLE3
	.long	KLSTUMBLE4
	.long	KLSTUMBLE5
	.long	KLSTUMBLE6
	.long	KLSTUMBLE7
	.long	KLSTUMBLE8
	.long	0

j_stumble
	.long	KLSTUMBLE1
	.long	KLSTUMBLE2
	.long	KLSTUMBLE3
	.long	KLSTUMBLE4
	.long	KLSTUMBLE5
	.long	KLSTUMBLE6
	.long	KLSTUMBLE7
	.long	KLSTUMBLE8
	.long	ani_jump,j_stumble


KLSTUMBLE1
	.long	KLSTUMBLE1A,KLSTUMBLE1B,0
KLSTUMBLE2
	.long	KLSTUMBLE2A,KLSTUMBLE2B,0
KLSTUMBLE3
	.long	KLSTUMBLE3A,KLSTUMBLE3B,0
KLSTUMBLE4
	.long	KLSTUMBLE4A,KLSTUMBLE4B,0
KLSTUMBLE5
	.long	KLSTUMBLE5A,KLSTUMBLE5B,0
KLSTUMBLE6
	.long	KLSTUMBLE6A,KLSTUMBLE6B,0
KLSTUMBLE7
	.long	KLSTUMBLE7A,KLSTUMBLE7B,0
KLSTUMBLE8
	.long	KLSTUMBLE8A,KLSTUMBLE8B,0

;********************************************************

a_hit_hi
	.long	KLHIHIT2
	.long	KLHIHIT3
	.long	KLHIHIT2
	.long	KLHIHIT1
	.long	0

KLHIHIT1	.long	KLHIHIT1A,KLHIHIT1B,0
KLHIHIT2	.long	KLHIHIT2A,KLHIHIT2B,0
KLHIHIT3	.long	KLHIHIT3A,KLHIHIT3B,0

;********************************************************

a_hit_lo
	.long	KLLOHIT2
	.long	KLLOHIT3
	.long	KLLOHIT2
	.long	KLLOHIT1
	.long	0

KLLOHIT1	.long	KLLOHIT1A,KLLOHIT1B,0
KLLOHIT2	.long	KLLOHIT2A,KLLOHIT2B,0
KLLOHIT3	.long	KLLOHIT3A,KLLOHIT3B,0

;********************************************************

a_dizzy
	.long	KLSTUNNED1
	.long	KLSTUNNED2
	.long	KLSTUNNED3
	.long	KLSTUNNED4
	.long	KLSTUNNED5
	.long	KLSTUNNED6
	.long	KLSTUNNED7
	.long	KLSTUNNED8
	.long	KLSTUNNED9
	.long	ani_jump,a_dizzy

KLSTUNNED1
	.long	KLSTUNNED1A,KLSTUNNED1B,0
KLSTUNNED2
	.long	KLSTUNNED2A,KLSTUNNED2B,0
KLSTUNNED3
	.long	KLSTUNNED3A,KLSTUNNED3B,0
KLSTUNNED4
	.long	KLSTUNNED4A,KLSTUNNED4B,0
KLSTUNNED5
	.long	KLSTUNNED5A,KLSTUNNED5B,0
KLSTUNNED6
	.long	KLSTUNNED6A,KLSTUNNED6B,0
KLSTUNNED7
	.long	KLSTUNNED7A,KLSTUNNED7B,0
KLSTUNNED8
	.long	KLSTUNNED8A,KLSTUNNED8B,0
KLSTUNNED9
	.long	KLSTUNNED9A,KLSTUNNED9B,0

;********************************************************

a_knockdown
	.long	KLKNOCKDOWN1
	.long	KLKNOCKDOWN2
	.long	KLKNOCKDOWN3
	.long	KLKNOCKDOWN4
	.long	KLKNOCKDOWN5
	.long	KLKNOCKDOWN6
	.long	0
	.long	KLKNOCKDOWN7
	.long	KLKNOCKDOWN8
	.long	0

KLKNOCKDOWN1
	.long	KLKNOCKDOWN1A,0
KLKNOCKDOWN2
	.long	KLKNOCKDOWN2A,0
KLKNOCKDOWN3
	.long	KLKNOCKDOWN3A,KLKNOCKDOWN3B,0
KLKNOCKDOWN4
	.long	KLKNOCKDOWN4A,KLKNOCKDOWN4B,0
KLKNOCKDOWN5
	.long	KLKNOCKDOWN5A,KLKNOCKDOWN5B,0
KLKNOCKDOWN6
	.long	KLKNOCKDOWN6A,0
KLKNOCKDOWN7
	.long	KLKNOCKDOWN7A,KLKNOCKDOWN7B,0
KLKNOCKDOWN8
	.long	KLKNOCKDOWN8A,0

;********************************************************

a_getup
	.long	KLGETUP1
	.long	KLGETUP2
	.long	KLGETUP3
	.long	KLGETUP4
	.long	KLGETUP5
	.long	KLGETUP6
	.long	0

KLGETUP1
	.long	KLGETUP1A,0
KLGETUP2
	.long	KLGETUP2A,0
KLGETUP3
	.long	KLGETUP3A,0
KLGETUP4
	.long	KLGETUP4A,0
KLGETUP5
	.long	KLGETUP5A,0
KLGETUP6
	.long	KLGETUP6A,KLGETUP6B,0

;********************************************************

a_sweep_fall
	.long	KLSWEEPFALL1
	.long	KLSWEEPFALL2
	.long	KLSWEEPFALL3
	.long	KLSWEEPFALL4
	.long	KLSWEEPFALL5
	.long	0
	.long	KLSWEEPFALL6
	.long	KLSWEEPFALL7
	.long	0

KLSWEEPFALL1
	.long	KLSWEEPFALL1A,KLSWEEPFALL1B,0
KLSWEEPFALL2
	.long	KLSWEEPFALL2A,KLSWEEPFALL2B,0
KLSWEEPFALL3
	.long	KLSWEEPFALL3A,0
KLSWEEPFALL4
	.long	KLSWEEPFALL4A,KLSWEEPFALL4B,0
KLSWEEPFALL5
	.long	KLSWEEPFALL5A,KLSWEEPFALL5B,KLSWEEPFALL5C,0
KLSWEEPFALL6
	.long	KLSWEEPFALL6A,0
KLSWEEPFALL7
	.long	KLSWEEPFALL7A,KLSWEEPFALL7B,0

;********************************************************

a_sweepup
	.long	KLSWEEPUP1
	.long	KLSWEEPUP2
	.long	KLSWEEPUP3
	.long	KLSWEEPUP4
	.long	KLSWEEPUP5
	.long	KLSWEEPUP6
	.long	0

KLSWEEPUP1
	.long	KLSWEEPUP1A,KLSWEEPUP1B,KLSWEEPUP1C,0
KLSWEEPUP2
	.long	KLSWEEPUP2A,KLSWEEPUP2B,0
KLSWEEPUP3
	.long	KLSWEEPUP3A,0
KLSWEEPUP4
	.long	KLSWEEPUP4A,0
KLSWEEPUP5
	.long	KLSWEEPUP5A,0
KLSWEEPUP6
	.long	KLSWEEPUP6A,KLSWEEPUP6B,0


a_fb_kano
	.long	ani_offset_xy
	.word	->34,->0c
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->1b,->1e
	.long	KLFLIPPED2
	.long	ani_offset_xy
 	.word	>31,->1d
	.long	KLFLIPPED4
	.long	0

	.long	KLFLIPPED4
	.long	KLFLIPPED5
	.long	KLKNOCKDOWN5
	.long	KLKNOCKDOWN6
	.long	KLKNOCKDOWN7
	.long	0


a_fb_sonya
	.long	ani_offset_xy
	.word	->27,>08
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->1f,>14
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	>0e,>19
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>4f,->15
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>8c,->21
	.long	KLFLIPPED4
	.long	0

	.long	KLFLIPPED5
	.long	KLKNOCKDOWN5
	.long	KLKNOCKDOWN6
	.long	KLKNOCKDOWN7
	.long	0


a_fb_jax
	.long	ani_offset_xy
	.word	->3d,->15
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->23,->32
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	>04,->45
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>34,->2f
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>56,->1a
	.long	KLKNOCKDOWN6
	.long	ani_offset_xy
	.word	>49,>0a
	.long	KLKNOCKDOWN7
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	->54,->0b
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->4d,->27
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	->1e,->4f
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>20,->3e
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>49,->13
	.long	KLFLIPPED5
	.long	ani_offset_xy
	.word	>4e,>05
	.long	KLKNOCKDOWN7
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	->3f,->3b
	.long	KLFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	>41,->25
	.long	KLFLIPPED5

	.long	ani_offset_xy
	.word	>2c,>05
	.long	KLFLIPPED5

	.long	ani_offset_xy
	.word	->04,>09
	.long	KLKNOCKDOWN5

	.long	ani_offset_xy
	.word	->47,->19
	.long	KLKNOCKDOWN5

	.long	ani_offset_xy
	.word	->7d,->47
	.long	KLKNOCKDOWN5
	.long	0


a_fb_swat
	.long	ani_offset_xy
	.word	->42,->0d
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->39,->2f
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	>23,->42
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>56,->13
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>5a,>08
	.long	KLKNOCKDOWN7
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	->64,>07
	.long	KLSTUMBLE1
	.long	ani_offset_xy
	.word	->73,>03
	.long	KLSTUMBLE1

	.long	ani_offset_xy
	.word	->6f,->1e
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->49,->3d
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->19,->46
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	>26,->4e
	.long	KLFLIPPED1

	.long	ani_offset_xy
	.word	>97,>1b
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>aa,>03
	.long	KLKNOCKDOWN7
	.long	0


a_fb_robo
	.long	ani_offset_xy
	.word	->3d,->0b
	.long	KLFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->4f,->20
	.long	KLFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->38,->38
	.long	KLFLIPPED2		; 3

	.long	ani_offset_xy
	.word	->05,->5c
	.long	KLFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>32,->63
	.long	KLFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>56,->4d
	.long	KLFLIPPED4		; 6

	.long	ani_offset_xy
	.word	>7b,->18
	.long	KLFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5e,->11
	.long	KLKNOCKDOWN7		; 8
	.long	0

a_fb_robo2
	.long	ani_offset_xy
	.word	->28,>00
	.long	KLSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->21,->15
	.long	KLFLIPPED1		; 2
	.long	ani_offset_xy
	.word	->11,->0c
	.long	KLFLIPPED2		; 3
	.long	ani_offset_xy
	.word	>12,->08
	.long	KLFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>09,>0f
	.long	KLFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>0e,>0e
	.long	KLFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->13,->0a
	.long	KLKNOCKDOWN7		; 7
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	->1d,>1a
	.long	KLSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	>00,>33
	.long	KLSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	->22,>1d
	.long	KLFLIPPED1		; 3
	.long	ani_offset_xy
	.word	->46,->01
	.long	KLFLIPPED2		; 4
	.long	ani_offset_xy
	.word	->2c,->42
	.long	KLFLIPPED3		; 5
	.long	ani_offset_xy
	.word	>07,->62
	.long	KLFLIPPED4		; 6
	.long	ani_offset_xy
	.word	>4f,->70
	.long	KLFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5a,->56
	.long	KLFLIPPED5		; 8
	.long	ani_offset_xy
	.word	>77,>02
	.long	KLFLIPPED5		; 9
	.long	ani_offset_xy
	.word	>77,>52
	.long	KLFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	->64,>04
	.long	KLFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->6a,->35
	.long	KLFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->16,->6a
	.long	KLFLIPPED3		; 3
	.long	ani_offset_xy
	.word	>32,->4c
	.long	KLFLIPPED4		; 4
	.long	ani_offset_xy
	.word	>44,->15
	.long	KLFLIPPED5		; 5

	.long	ani_offset_xy
	.word	>0f,>1e
	.long	KLFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->26,->09
  	.long	KLKNOCKDOWN7		; 7
	.long	ani_offset_xy
	.word	->68,>01
	.long	KLFLIPPED1		; 8
	.long	ani_offset_xy
	.word	->54,->45
	.long	KLFLIPPED2		; 9
	.long	ani_offset_xy
	.word	>1c,->5f
	.long	KLFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	>65,->05
	.long	KLFLIPPED5		; 11
	.long	ani_offset_xy
	.word	>64,>09
  	.long	KLKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	->3d,->30
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->08,->46
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	->0f,->4b
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>05,->3d
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>06,->26
	.long	KLFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	->22,->04
  	.long	KLKNOCKDOWN7
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	->41,>00
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->2e,>07
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->24,>10
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	->11,>1c
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>07,>2d
	.long	KLFLIPPED4

	.long	ani_offset_xy
	.word	>04,>02
	.long	KLKNOCKDOWN6
	.long	ani_offset_xy
	.word	->18,>04
	.long	KLKNOCKDOWN6
	.long	ani_offset_xy
	.word	->2d,->02
	.long	KLKNOCKDOWN6

	.long	ani_offset_xy
	.word	->4e,>19
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->55,->0b
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->3e,->37
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	>24,->42
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>4c,->18
	.long	KLFLIPPED5
	.long	ani_offset_xy
	.word	>4d,->08
	.long	KLKNOCKDOWN6
	.long	0


a_fb_lk
	.long	ani_offset_xy
	.word	->35,>06
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->2c,>0c
	.long	KLFLIPPED1
	.long	ani_offset_xy
	.word	->19,>16
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	>10,>17
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>37,>03
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>88,->1f
	.long	KLFLIPPED4
	.long	0

	.long	KLFLIPPED5
	.long	KLKNOCKDOWN5
	.long	KLKNOCKDOWN6
	.long	KLKNOCKDOWN7
	.long	0



a_afb_kano
	.long	ani_offset_xy
	.word	->35,->0f
	.long	KLFLIPPED1

	.long	ani_offset_xy
	.word	->35,->06
	.long	KLKNOCKDOWN4

	.long	ani_offset_xy
 	.word	->54,>2d
	.long	KLKNOCKDOWN5
	.long	0
*
* fall down solo
*
	.long	KLKNOCKDOWN5
	.long	KLKNOCKDOWN6
	.long	KLKNOCKDOWN7
	.long	0



a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	->24,->22
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	->0e,->2b
	.long	KLFLIPPED2
	.long	ani_offset_xy
	.word	>24,->30
	.long	KLFLIPPED3
	.long	ani_offset_xy
	.word	>42,->12
	.long	KLFLIPPED4
	.long	ani_offset_xy
	.word	>57,->11
	.long	KLKNOCKDOWN6
	.long	ani_offset_xy
	.word	>67,>21
	.long	KLKNOCKDOWN6
	.long	0



a_legged
	.long	ani_offset_xy
	.word	->60,->0b
	.long	KLKNOCKDOWN1

	.long	ani_offset_xy
	.word	->4b,->1f
	.long	KLFLIPPED1

	.long	ani_offset_xy
	.word	->25,->2c
	.long	KLFLIPPED3

	.long	ani_offset_xy
	.word	>1a,->24
	.long	KLFLIPPED4

	.long	ani_offset_xy
	.word	>51,>0b
	.long	KLFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	>55,->1c
	.long	KLKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	>57,>01
	.long	KLKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	>27,>09
	.long	KLKNOCKDOWN7	; 3

	.long	ani_offset_xy
	.word	->30,>0d
	.long	KLKNOCKDOWN7	; 4

	.long	ani_offset_xy
	.word	->7f,->06
	.long	KLFLIPPED1	; 5

	.long	ani_offset_xy
	.word	->32,->50
	.long	KLFLIPPED3	; 6
	.long	0

	.long	KLFLIPPED3
	.long	KLFLIPPED4
	.long	KLFLIPPED5
	.long	KLKNOCKDOWN5
	.long	KLKNOCKDOWN6
	.long	KLKNOCKDOWN7
	.long	0


a_shook
	.long	ani_offset_xy
	.word	->4a,>07
	.long	KLSTUMBLE2	; 3

	.long	ani_offset_xy
	.word	->31,->12
	.long	KLSTUMBLE2	; 4

	.long	ani_offset_xy
	.word	->16,->06
	.long	KLSTUMBLE2	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	->16,->0d
	.long	KLSTUMBLE2	; 6

	.long	ani_offset_xy
	.word	->2d,->15
	.long	KLSTUMBLE2	; 7

	.long	ani_offset_xy
	.word	->3d,->19	
	.long	KLSTUMBLE2	; 8

	.long	ani_offset_xy
	.word	->2d,->15
	.long	KLSTUMBLE2	; 7
	.long	0


KLFLIPPED1
	.long	KLFLIPPED1A,0
KLFLIPPED2
	.long	KLFLIPPED2A,KLFLIPPED2B,0
KLFLIPPED3
	.long	KLFLIPPED3A,KLFLIPPED3B,0
KLFLIPPED4
	.long	KLFLIPPED4A,0
KLFLIPPED5
	.long	KLFLIPPED5A,0


a_run	.long	KLRUN1
	.long	KLRUN2
	.long	KLRUN3
	.long	ani_calla,rsnd_footstep
	.long	KLRUN4
	.long	KLRUN5
	.long	KLRUN6
	.long	KLRUN7
	.long	KLRUN8
	.long	ani_calla,rsnd_footstep
	.long	KLRUN9
	.long	KLRUN10
	.long	KLRUN11
	.long	ani_jump,a_run
	.long	0			; we need this zero !!

KLRUN1	.long	KLRUN1A,KLRUN1B,0
KLRUN2	.long	KLRUN2A,KLRUN2B,0
KLRUN3	.long	KLRUN3A,KLRUN3B,0
KLRUN4	.long	KLRUN4A,KLRUN4B,0
KLRUN5	.long	KLRUN5A,0
KLRUN6	.long	KLRUN6A,0
KLRUN7	.long	KLRUN7A,KLRUN7B,0
KLRUN8	.long	KLRUN8A,KLRUN8B,0
KLRUN9	.long	KLRUN9A,KLRUN9B,0
KLRUN10	.long	KLRUN10A,0
KLRUN11	.long	KLRUN11A,0



a_victory
	.long	KLVICTORY1
	.long	KLVICTORY2
	.long	KLVICTORY3
	.long	KLVICTORY4
	.long	KLVICTORY5
	.long	KLVICTORY6
	.long	KLVICTORY7
	.long	KLVICTORY8
	.long	KLVICTORY9
	.long	KLVICTORY10
	.long	KLVICTORY11

	.long	KLVICTORY12
	.long	KLVICTORY13
	.long	KLVICTORY14
	.long	KLVICTORY15
	.long	KLVICTORY17
	.long	KLVICTORY18
	.long	0

KLVICTORY1
	.long	KLVICTORY1A,KLVICTORY1B,0
KLVICTORY2
	.long	KLVICTORY2A,KLVICTORY2B,0
KLVICTORY3
	.long	KLVICTORY3A,0
KLVICTORY4
	.long	KLVICTORY4A,0
KLVICTORY5
	.long	KLVICTORY5A,0
KLVICTORY6
	.long	KLVICTORY6A,0
KLVICTORY7
	.long	KLVICTORY7A,0
KLVICTORY8
	.long	KLVICTORY8A,0
KLVICTORY9
	.long	KLVICTORY9A,KLVICTORY9B,0
KLVICTORY10
	.long	KLVICTORY10A,KLVICTORY10B,0
KLVICTORY11
	.long	KLVICTORY11A,KLVICTORY11B,KLVICTORYTOP1,0
KLVICTORY12
	.long	KLVICTORY11A,KLVICTORY11B,KLVICTORYTOP2,0
KLVICTORY13
	.long	KLVICTORY11A,KLVICTORY11B,KLVICTORYTOP3,0
KLVICTORY14
	.long	KLVICTORY11A,KLVICTORY11B,KLVICTORYTOP4,0
KLVICTORY15
	.long	KLVICTORY11A,KLVICTORY11B,KLVICTORYTOP5,0
KLVICTORY17
	.long	KLVICTORY17A,KLVICTORY17B,0
KLVICTORY18
	.long	KLVICTORY18A,KLVICTORY18B,0


a_tele_blur
	.long	KLBLURJUMP1
	.long	KLBLURJUMP2
	.long	KLBLURJUMP3
	.long	KLBLURJUMP4
	.long	0
	.long	KLBLURJUMP3
	.long	KLBLURJUMP3
	.long	KLBLURJUMP3
	.long	KLBLURJUMP2
	.long	KLBLURJUMP1
	.long	KLJUMP1		; last frame = normal jump
	.long	0

KLBLURJUMP1
	.long	KLBLURJUMP1A,KLBLURJUMP1B,0
KLBLURJUMP2
	.long	KLBLURJUMP2A,KLBLURJUMP2B,0
KLBLURJUMP3
	.long	KLBLURJUMP3A,KLBLURJUMP3B,0
KLBLURJUMP4
	.long	KLBLURJUMP4A,KLBLURJUMP4B,0

;*************************************************************************

a_zap
	.long	KLTHROHAT1
	.long	KLTHROHAT2

	.long	ani_sladd,KLHAT1
	.long	KLTHROHAT3
	.long	ani_slani,KLHAT2
	.long	KLTHROHAT4
	.long	ani_slani,KLHAT3
	.long	KLTHROHAT5
	.long	0
*
* part 2 = finish throw
*
	.long	KLTHROHAT6
	.long	KLTHROHAT7
	.long	KLTHROHAT8
	.long	0
*
* part 3 = get out of throw ani
*
	.long	ani_sladd,HATON1
	.long	KLTHROHAT8
	.long	ani_slani_sleep,HATON2
	.long	ani_slani_sleep,HATON3
	.long	ani_slani_sleep,HATON4
	.long	ani_slani_sleep,HATON5
	.long	ani_calla,delete_slave    ; rid of fake hat
	.long	KLHIPUNCH2
	.long	KLHIPUNCH1
	.long	0
*
* part 4 = hat fly
*
	.long	ani_swpal
	.long	KLHAT4
j_hatfly	.long	KLHAT5
	.long	KLHAT6
	.long	ani_jump,j_hatfly
	.long	HATANGLE1
	.long	0
*
* part 5 = angle fly
*
j_afly	.long	HATANGLE1
	.long	HATANGLE2
	.long	ani_jump,j_afly
	.long	0

KLTHROHAT1
	.long	KLTHROHAT1A,KLTHROHAT1B,0
KLTHROHAT2
	.long	KLTHROHAT2A,KLTHROHAT2B,0
KLTHROHAT3
	.long	KLTHROHAT3A,KLTHROHAT3B,KLTHROHAT3C,0
KLTHROHAT4
	.long	KLTHROHAT4A,KLTHROHAT4B,0
KLTHROHAT5
	.long	KLTHROHAT5A,KLTHROHAT5B,0
KLTHROHAT6
	.long	KLTHROHAT6A,KLTHROHAT6B,0
KLTHROHAT7
	.long	KLTHROHAT7A,KLTHROHAT7B,0
KLTHROHAT8
	.long	KLTHROHAT8A,KLTHROHAT8B,0


HATON1	.long	KLHATON1,0
HATON2	.long	KLHATON2,0
HATON3	.long	KLHATON3,0
HATON4	.long	KLHATON4,0
HATON5	.long	KLHATON5,0


a_hat_rings
	.long	KLHATRINGS1
	.long	KLHATRINGS2
	.long	KLHATRINGS3
	.long	KLHATRINGS4
	.long	KLHATRINGS5
	.long	KLHATRINGS6
	.long	0

HATANGLE1
	.long	ANGLEHAT1,0
HATANGLE2
	.long	ANGLEHAT2,0


KLHAT1	.LONG	KLGLOWHAT1,0
KLHAT2	.LONG	KLGLOWHAT2,0
KLHAT3	.LONG	KLGLOWHAT3,0
KLHAT4	.LONG	KLGLOWHAT4,0
KLHAT5	.LONG	KLGLOWHAT5,0
KLHAT6	.LONG	KLGLOWHAT6,0

;*************************************************************************

a_throw
	.long	KLTHROW1
	.long	KLTHROW2		; grab
	.long	0

	.long	ani_adjustxy
	.word	>00,->20
	.long	KLTHROW3
	.long	ani_adjustxy
	.word	>00,->20
	.long	KLTHROW4
	.long	KLTHROW5
	.long	KLTHROW6
	.long	KLTHROW7
	.long	KLTHROW8
	.long	KLTHROW9
	.long	KLTHROW10
	.long	KLTHROW11		; animate 2-gether
	.long	KLTHROW12
	.long	0

	.long	KLTHROW12
	.long	KLTHROW13
	.long	KLTHROW14
	.long	KLTHROW15
	.long	KLTHROW16
	.long	KLTHROW17		; get out of flip animation
	.long	0

KLTHROW1
	.long	KLTHROW1A,KLTHROW1B,0
KLTHROW2
	.long	KLTHROW2A,0
KLTHROW3
	.long	KLTHROW3A,KLTHROW3B,0
KLTHROW4
	.long	KLTHROW4A,KLTHROW4B,0
KLTHROW5
	.long	KLTHROW5A,0
KLTHROW6
	.long	KLTHROW6A,KLTHROW6B,0
KLTHROW7
	.long	KLTHROW7A,KLTHROW7B,0
KLTHROW8
	.long	KLTHROW8A,0
KLTHROW9
	.long	KLTHROW9A,KLTHROW9B,0
KLTHROW10
	.long	KLTHROW10A,KLTHROW10B,0
KLTHROW11
	.long	KLTHROW11A,0
KLTHROW12
	.long	KLTHROW12A,0
KLTHROW13
	.long	KLTHROW13A,0
KLTHROW14
	.long	KLTHROW14A,0
KLTHROW15
	.long	KLTHROW15A,KLTHROW15B,0
KLTHROW16
	.long	KLTHROW16A,KLTHROW16B,0
KLTHROW17
	.long	KLTHROW17A,KLTHROW17B,0

;**************************************************************************

a_scared
	.long	KLSCARED3
	.long	0

KLSCARED3
	.long	KLSCARED3A,0

a_thudd
	.long	KLTHUD1
	.long	KLTHUD2
	.long	KLTHUD3
	.long	KLTHUD4
	.long	KLTHUD5
	.long	KLTHUD6
	.long	KLTHUD7
	.long	0

KLTHUD1
	.long	KLTHUD1A,0
KLTHUD2
	.long	KLTHUD2A,0
KLTHUD3
	.long	KLTHUD3A,0
KLTHUD4
	.long	KLTHUD4A,0
KLTHUD5
	.long	KLTHUD5A,0
KLTHUD6
	.long	KLTHUD6A,0
KLTHUD7
	.long	KLTHUD7A,0

;**************************************************************************

ochar_cutups
	.long	KNCUTUP1
	.long	SBCUT1
	.long	JXCUTUP1
	.long	INCUTUP1
	.long	SZCUTUP1
	.long	OBCUTUP1
	.long	LICUTUP1
	.long	RBCUTUP1
	.long	RBCUTUP1
	.long	KLCUTUP1
	.long	TRCUTUP1
	.long	SHCUTUP1
	.long	TSCUTUP1
	.long	LUCUTUP1
	.long	RBCUTUP1

KNCUTUP1
	.long	KNCUTUP1A,KNCUTUP1B,KNCUTUP1C,KNCUTUP1D,0
SBCUT1
	.long	SBCUT1A,SBCUT1B,SBCUT1C,SBCUT1D,0
JXCUTUP1
	.long	JXCUTUP1A,JXCUTUP1B,JXCUTUP1C,JXCUTUP1D,0
INCUTUP1
	.long	INCUTUP1A,INCUTUP1B,INCUTUP1C,INCUTUP1D,0
SZCUTUP1
	.long	SZCUTUP1A,SZCUTUP1B,SZCUTUP1C,SZCUTUP1D,0
OBCUTUP1
	.long	OBCUTUP1A,OBCUTUP1B,OBCUTUP1C,OBCUTUP1D,0
LICUTUP1
	.long	LICUTUP1A,LICUTUP1B,LICUTUP1C,LICUTUP1D,0
RBCUTUP1
	.long	RBCUTUP1A,RBCUTUP1B,RBCUTUP1C,RBCUTUP1D,0
KLCUTUP1
	.long	KLCUTUP1A,KLCUTUP1B,KLCUTUP1C,KLCUTUP1D,0
TRCUTUP1
	.long	TRCUTUP1A,TRCUTUP1B,TRCUTUP1C,TRCUTUP1D,0
SHCUTUP1
	.long	SHCUTUP1A,SHCUTUP1B,SHCUTUP1C,SHCUTUP1D,0
TSCUTUP1
	.long	TSCUTUP1A,TSCUTUP1B,TSCUTUP1C,TSCUTUP1D,0
LUCUTUP1
	.long	LUCUTUP1A,LUCUTUP1B,LUCUTUP1C,LUCUTUP1D,0



ochar_half_bodies
	.long	HALF_KNCUTUP1
	.long	HALF_SBCUT1
	.long	HALF_JXCUTUP1
	.long	HALF_INCUTUP1
	.long	HALF_SZCUTUP1
	.long	HALF_OBCUTUP1
	.long	HALF_LICUTUP1
	.long	HALF_RBCUTUP1
	.long	HALF_RBCUTUP1
	.long	HALF_KLCUTUP1
	.long	HALF_TRCUTUP1
	.long	HALF_SHCUTUP1
	.long	HALF_TSCUTUP1
	.long	HALF_LUCUTUP1
	.long	HALF_RBCUTUP1

HALF_KNCUTUP1
	.long	KNCUTUP1D,KNCUTUP1C,0
HALF_SBCUT1
	.long	SBCUT1D,SBCUT1C,0
HALF_JXCUTUP1
	.long	JXCUTUP1D,JXCUTUP1C,0
HALF_INCUTUP1
	.long	INCUTUP1D,INCUTUP1C,0
HALF_SZCUTUP1
	.long	SZCUTUP1D,SZCUTUP1C,0
HALF_OBCUTUP1
	.long	OBCUTUP1D,OBCUTUP1C,0
HALF_LICUTUP1
	.long	LICUTUP1D,LICUTUP1C,0
HALF_RBCUTUP1
	.long	RBCUTUP1D,RBCUTUP1C,0
HALF_KLCUTUP1
	.long	KLCUTUP1D,KLCUTUP1C,0
HALF_TRCUTUP1
	.long	TRCUTUP1D,TRCUTUP1C,0
HALF_SHCUTUP1
	.long	SHCUTUP1D,SHCUTUP1C,0
HALF_TSCUTUP1
	.long	TSCUTUP1D,TSCUTUP1C,0
HALF_LUCUTUP1
	.long	LUCUTUP1D,LUCUTUP1C,0

;*************************************************************************

a_spin
	.long	KLSPIN1
	.long	KLSPIN2
	.long	KLSPIN3
	.long	KLSPIN4
	.long	KLSPIN5
	.long	KLSPIN6
	.long	KLSPIN7
	.long	KLSPIN8
	.long	ani_jump,a_spin

KLSPIN1	.long	KLSPIN1A,0
KLSPIN2	.long	KLSPIN2A,0
KLSPIN3	.long	KLSPIN3A,0
KLSPIN4	.long	KLSPIN4A,0
KLSPIN5	.long	KLSPIN5A,0
KLSPIN6	.long	KLSPIN6A,0
KLSPIN7	.long	KLSPIN7A,0
KLSPIN8	.long	KLSPIN8A,0


;************************************************************************

a_lao_top
	.long	ani_swpal

j_top	.long	LAOTOP1
	.long	LAOTOP2
	.long	LAOTOP3
	.long	LAOTOP4
	.long	LAOTOP5
	.long	LAOTOP6
	.long	ani_jump,j_top

LAOTOP1	.long	LAOTOP1A,0
LAOTOP2	.long	LAOTOP2B,0
LAOTOP3	.long	LAOTOP3C,0
LAOTOP4	.long	LAOTOP4D,0
LAOTOP5	.long	LAOTOP5E,0
LAOTOP6	.long	LAOTOP6F,0

;************************************************************************

a_hat_slice_throw
	.long	KLHATSLICE1
	.long	KLHATSLICE2
	.long	KLHATSLICE3
	.long	KLHATSLICE4
	.long	KLHATSLICE6
	.long	0
	.long	SLICEHAT
	.long	0

KLHATSLICE1
	.long	KLHATSLICE1A,KLHATSLICE1B,0
KLHATSLICE2
	.long	KLHATSLICE2A,KLHATSLICE2B,0
KLHATSLICE3
	.long	KLHATSLICE3A,KLHATSLICE3B,0
KLHATSLICE4
	.long	KLHATSLICE4A,KLHATSLICE4B,0
KLHATSLICE6
	.long	KLHATSLICE6A,KLHATSLICE6B,0

SLICEHAT	.long	SLICEHAT1,A0


	.end

