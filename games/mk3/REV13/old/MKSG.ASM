**************************************************************************
*											     *
*  mk3 - She Goro										*
*											     *
**************************************************************************
	.FILE	'mksg.asm'
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo
	.include mksg.tbl
	.include mksg2.tbl
	.include mksg3.tbl
	.text

sg_anitab1
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
  	.long	a_fb_sg		; 31	- flipped by she goro
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


sg_anitab2
	.long	a_pounce	; 0
	.long	ochar_pounded	; 1
	.long	a_pound		; 2 - 
	.long	a_rip_flesh	; 3
	.long	a_dummy
	.long	a_dummy

a_projectile
a_dummy
a_stance
	.long	SHSTANCE1
	.long	SHSTANCE2
	.long	SHSTANCE3
	.long	SHSTANCE4
	.long	SHSTANCE5
	.long	SHSTANCE6
	.long	SHSTANCE5
	.long	SHSTANCE4
	.long	SHSTANCE3
	.long	SHSTANCE2
	.long	ani_jump,a_stance

SHSTANCE1
	.long	SHSTANCE1A,SHSTANCE1B,0
SHSTANCE2
	.long	SHSTANCE2A,SHSTANCE2B,0
SHSTANCE3
	.long	SHSTANCE3A,SHSTANCE3B,0
SHSTANCE4
	.long	SHSTANCE4A,SHSTANCE4B,0
SHSTANCE5
	.long	SHSTANCE5A,SHSTANCE5B,0
SHSTANCE6
	.long	SHSTANCE6A,SHSTANCE6B,0


a_turn	.long	SHTURN1
	.long	ani_flip
	.long	SHTURN2
	.long	SHTURN1
	.long	0

SHTURN1	.long	SHTURN1A,SHTURN1B,0
SHTURN2	.long	SHTURN2A,SHTURN2B,0


a_walkf
	.long	SHWALK1
	.long	SHWALK2
	.long	SHWALK3
	.long	SHWALK4
	.long	SHWALK5
	.long	SHWALK6
	.long	SHWALK7
	.long	SHWALK8
	.long	SHWALK9
	.long	ani_jump,a_walkf

a_walkb
	.long	SHWALK9
	.long	SHWALK8
	.long	SHWALK7
	.long	SHWALK6
	.long	SHWALK5
	.long	SHWALK4
	.long	SHWALK3
	.long	SHWALK2
	.long	SHWALK1
	.long	ani_jump,a_walkb


SHWALK1	.long	SHWALKTORSO1A,SHWALKLEG1A,SHWALKLEG1B,0
SHWALK2	.long	SHWALKTORSO2A,SHWALKLEG2A,0
SHWALK3	.long	SHWALKTORSO3A,SHWALKLEG3A,0
SHWALK4	.long	SHWALKTORSO4A,SHWALKLEG4A,SHWALKLEG4B,0
SHWALK5	.long	SHWALKTORSO5A,SHWALKLEG5A,SHWALKLEG5B,0
SHWALK6	.long	SHWALKTORSO6A,SHWALKLEG6A,SHWALKLEG6B,0
SHWALK7	.long	SHWALKTORSO7A,SHWALKLEG7A,0
SHWALK8	.long	SHWALKTORSO8A,SHWALKLEG8A,0
SHWALK9	.long	SHWALKTORSO9A,SHWALKLEG9A,SHWALKLEG9B,0

;******************************

a_duck
	.long	SHDUCK1
	.long	SHDUCK2
	.long	SHDUCK3
	.long	0

SHDUCK1	.long	SHDUCK1A,SHDUCK1B,0
SHDUCK2	.long	SHDUCK2A,SHDUCK2B,0
SHDUCK3	.long	SHDUCK3A,SHDUCK3B,0

;******************************

a_duck_block
	.long	SHDUCKBLOCK1
	.long	SHDUCKBLOCK2
	.long	SHDUCKBLOCK3
	.long	0

SHDUCKBLOCK1
	.long	SHDUCKBLOCK1A,0
SHDUCKBLOCK2
	.long	SHDUCKBLOCK2A,0
SHDUCKBLOCK3
	.long	SHDUCKBLOCK3A,0

;******************************

a_duck_hit
	.long	SHDUCKHIT2
	.long	SHDUCKHIT3
	.long	SHDUCKHIT2
	.long	SHDUCKHIT1
	.long	0

SHDUCKHIT1
	.long	SHDUCKHIT1A,SHDUCKHIT1B,0
SHDUCKHIT2
	.long	SHDUCKHIT2A,SHDUCKHIT2B,0
SHDUCKHIT3
	.long	SHDUCKHIT3A,SHDUCKHIT3B,0

;******************************

a_duck_punch
	.long	SHDUCKPUNCH1
	.long	SHDUCKPUNCH2
	.long	SHDUCKPUNCH3
	.long	0
	.long	SHDUCKPUNCH2
	.long	SHDUCKPUNCH1
	.long	SHDUCK3
	.long	0

SHDUCKPUNCH1
	.long	SHDUCKPUNCH1A,0
SHDUCKPUNCH2
	.long	SHDUCKPUNCH2A,0
SHDUCKPUNCH3
	.long	SHDUCKPUNCH3A,0

;******************************

a_duck_turn
	.long	SHDUCKTURN1
	.long	SHDUCKTURN2
	.long	ani_flip
	.long	SHDUCKTURN2
	.long	SHDUCK3
	.long	0

SHDUCKTURN1
	.long	SHDUCKTURN1A,SHDUCKTURN1B,0
SHDUCKTURN2
	.long	SHDUCKTURN2A,SHDUCKTURN2B,0

a_duck_kick_lo
	.long	SHDUCKLOKICK1
	.long	SHDUCKLOKICK2
	.long	SHDUCKLOKICK3
	.long	0
	.long	SHDUCKLOKICK2
	.long	SHDUCKLOKICK1
	.long	SHDUCK3
	.long	0

SHDUCKLOKICK1
	.long	SHDUCKLOKICK1A,SHDUCKLOKICK1B,0
SHDUCKLOKICK2
	.long	SHDUCKLOKICK2A,SHDUCKLOKICK2B,SHDUCKLOKICK2C,0
SHDUCKLOKICK3
	.long	SHDUCKLOKICK3A,SHDUCKLOKICK3B,SHDUCKLOKICK3C,0

a_uppercut
;	.long	SHUPPERCUT1
	.long	SHUPPERCUT2
	.long	SHUPPERCUT3
	.long	SHUPPERCUT4
	.long	SHUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
;	.long	SHUPPERCUT6
	.long	SHUPPERCUT7
	.long	0

	.long	SHHIPUNCH2
	.long	SHHIPUNCH1
	.long	0

SHUPPERCUT1
	.long	SHUPPERCUT1A,0
SHUPPERCUT2
	.long	SHUPPERCUT2A,0
SHUPPERCUT3
	.long	SHUPPERCUT3A,0
SHUPPERCUT4
	.long	SHUPPERCUT4A,SHUPPERCUT4B,0
SHUPPERCUT5
	.long	SHUPPERCUT5A,SHUPPERCUT5B,0
SHUPPERCUT6
	.long	SHUPPERCUT6A,SHUPPERCUT6B,0
SHUPPERCUT7
	.long	SHUPPERCUT7A,SHUPPERCUT7B,0


a_duck_kick_hi
	.long	SHDUCKHIKICK1
	.long	SHDUCKHIKICK2
	.long	SHDUCKHIKICK3
	.long	0
	.long	SHDUCKHIKICK2
	.long	SHDUCKHIKICK1
	.long	SHDUCK3
	.long	0

SHDUCKHIKICK1
	.long	SHDUCKHIKICK1A,SHDUCKHIKICK1B,0
SHDUCKHIKICK2
	.long	SHDUCKHIKICK2A,SHDUCKHIKICK2B,0
SHDUCKHIKICK3
	.long	SHDUCKHIKICK3A,SHDUCKHIKICK3B,0


a_lopunch
	.long	SHLOPUNCH1
	.long	SHLOPUNCH2
	.long	SHLOPUNCH3
	.long	0
	.long	SHLOPUNCH4
	.long	SHLOPUNCH5
	.long	SHLOPUNCH6
	.long	0

	.long	SHLOPUNCH5
	.long	SHLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	SHLOPUNCH2
	.long	SHLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	SHHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	SHLOPUNCH4
	.long	SHLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	SHLOPUNCH4
	.long	SHHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)

SHLOPUNCH1
	.long	SHLOPUNCH1A,SHLOPUNCH1B,0
SHLOPUNCH2
	.long	SHLOPUNCH2A,SHLOPUNCH2B,0
SHLOPUNCH3
	.long	SHLOPUNCH3A,SHLOPUNCH3B,0
SHLOPUNCH4
	.long	SHLOPUNCH4A,SHLOPUNCH4B,0
SHLOPUNCH5
	.long	SHLOPUNCH5A,SHLOPUNCH5B,0
SHLOPUNCH6
	.long	SHLOPUNCH6A,SHLOPUNCH6B,0
SHLOPUNCH7
	.long	SHLOPUNCH7A,SHLOPUNCH7B,0

a_elbow
	.long	SHCOMBO1
	.long	SHCOMBO2
	.long	SHCOMBO3
	.long	0
	.long	SHCOMBO2
	.long	SHCOMBO1
	.long	0

	.long	SHCOMBO4
	.long	SHCOMBO5
	.long	SHCOMBO6	; ani 3 = hit 2
	.long	0

	.long	SHCOMBO7
	.long	ani_adjustx
	.word	12
	.long	SHCOMBO8
	.long	ani_adjustx
	.word	12
	.long	SHCOMBO9
	.long	SHCOMBO10	; ani 4 = hit 3
	.long	ani_nosleep	
	.long	SHCOMBO11
	.long	0

	.long	ani_adjustx
	.word	12
	.long	SHCOMBO10
	.long	ani_adjustx
	.word	12
	.long	SHCOMBO9
	.long	SHCOMBO8
	.long	ani_nosleep	
	.long	SHCOMBO7	; ani 5 = hit 4
	.long	0

	.long	SHCOMBO12	; ani 5 = get out ani
	.long	0

SHCOMBO1
	.long	SHCOMBO1A,SHCOMBO1B,0
SHCOMBO2
	.long	SHCOMBO2A,SHCOMBO2B,0
SHCOMBO3
	.long	SHCOMBO3A,SHCOMBO3B,0
SHCOMBO4
	.long	SHCOMBO4A,SHCOMBO4B,0
SHCOMBO5
	.long	SHCOMBO5A,SHCOMBO5B,0
SHCOMBO6
	.long	SHCOMBO6A,SHCOMBO6B,0
SHCOMBO7
	.long	SHCOMBO7A,SHCOMBO7B,0
SHCOMBO8
	.long	SHCOMBO8A,SHCOMBO8B,0
SHCOMBO9
	.long	SHCOMBO9A,SHCOMBO9B,0
SHCOMBO10
	.long	SHCOMBO10A,SHCOMBO10B,0
SHCOMBO11
	.long	SHCOMBO11A,SHCOMBO11B,0
SHCOMBO12
	.long	SHCOMBO12A,SHCOMBO12B,0

a_block
	.long	SHBLOCKS1
	.long	SHBLOCKS2
	.long	SHBLOCKS3
	.long	0

SHBLOCKS1
	.long	SHBLOCKS1A,SHBLOCKS1B,0
SHBLOCKS2
	.long	SHBLOCKS2A,SHBLOCKS2B,0
SHBLOCKS3
	.long	SHBLOCKS3A,SHBLOCKS3B,0


a_hipunch
	.long	SHHIPUNCH1
	.long	SHHIPUNCH2
	.long	SHHIPUNCH3
	.long	0
	.long	SHHIPUNCH4
	.long	SHHIPUNCH5
	.long	SHHIPUNCH6
	.long	0

	.long	SHHIPUNCH5
	.long	SHHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	SHHIPUNCH2
	.long	SHHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	SHHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	SHHIPUNCH4
	.long	SHLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	SHHIPUNCH5
	.long	SHLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0


SHHIPUNCH1
	.long	SHHIPUNCH1A,SHHIPUNCH1B,0
SHHIPUNCH2
	.long	SHHIPUNCH2A,SHHIPUNCH2B,0
SHHIPUNCH3
	.long	SHHIPUNCH3A,SHHIPUNCH3B,0
SHHIPUNCH4
	.long	SHHIPUNCH4A,SHHIPUNCH4B,0
SHHIPUNCH5
	.long	SHHIPUNCH5A,SHHIPUNCH5B,0
SHHIPUNCH6
	.long	SHHIPUNCH6A,SHHIPUNCH6B,0
SHHIPUNCH7
	.long	SHHIPUNCH7A,SHHIPUNCH7B,0

a_lokick
	.long	SHLOKICK1
	.long	SHLOKICK2
	.long	SHLOKICK3
	.long	SHLOKICK4
	.long	SHLOKICK5
	.long	SHLOKICK6
	.long	0
	.long	SHLOKICK5
	.long	SHLOKICK4
	.long	SHLOKICK3
	.long	SHLOKICK2
	.long	SHLOKICK1
	.long	0

SHLOKICK1
	.long	SHLOKICK1A,SHLOKICK1B,0
SHLOKICK2
	.long	SHLOKICK2A,SHLOKICK2B,0
SHLOKICK3
	.long	SHLOKICK3A,0
SHLOKICK4
	.long	SHLOKICK4A,SHLOKICK4B,0
SHLOKICK5
	.long	SHLOKICK5A,SHLOKICK5B,0
SHLOKICK6
	.long	SHLOKICK6A,0

a_hikick
	.long	SHLOKICK1
	.long	SHLOKICK2
	.long	SHLOKICK3
	.long	SHLOKICK4
	.long	SHHIKICK1
	.long	SHHIKICK2
	.long	0
	.long	SHHIKICK1
	.long	SHLOKICK4
	.long	SHLOKICK3
	.long	SHLOKICK2
	.long	SHLOKICK1
	.long	0

SHHIKICK1
	.long	SHHIKICK1A,SHHIKICK1B,0
SHHIKICK2
	.long	SHHIKICK2A,SHHIKICK2B,0

a_knee
	.long	SHKNEECOMBO1
	.long	SHKNEECOMBO2
	.long	SHKNEECOMBO3
	.long	0

	.long	SHKNEECOMBO3
	.long	SHKNEECOMBO2
	.long	SHKNEECOMBO1
	.long	0

	.long	ani_adjustx
	.word	12
	.long	SHKNEECOMBO4
	.long	ani_adjustx
	.word	8
	.long	SHKNEECOMBO5
	.long	0

	.long	ani_adjustx
	.word	8
	.long	SHKNEECOMBO4
	.long	ani_adjustx
	.word	8
	.long	SHKNEECOMBO3
	.long	SHKNEECOMBO4
	.long	SHKNEECOMBO5
	.long	0

	.long	ani_adjustx
	.word	8
	.long	SHKNEECOMBO4
	.long	ani_adjustx
	.word	8
	.long	SHKNEECOMBO3
	.long	SHKNEECOMBO2
	.long	SHKNEECOMBO1
	.long	0


SHKNEECOMBO1
	.long	SHKNEECOMBO1A,SHKNEECOMBO1B,0
SHKNEECOMBO2
	.long	SHKNEECOMBO2A,0
SHKNEECOMBO3
	.long	SHKNEECOMBO3A,SHKNEECOMBO3B,0
SHKNEECOMBO4
	.long	SHKNEECOMBO4A,SHKNEECOMBO4B,0
SHKNEECOMBO5
	.long	SHKNEECOMBO5A,SHKNEECOMBO5B,0

a_sweep_kick
	.long	SHSWEEPKICK1
	.long	SHSWEEPKICK2
	.long	SHSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	SHSWEEPKICK4
	.long	SHSWEEPKICK5
	.long	0
	.long	SHSWEEPKICK6
	.long	SHSWEEPKICK7
	.long	SHSWEEPKICK8
	.long	0

SHSWEEPKICK1
	.long	SHSWEEPKICK1A,SHSWEEPKICK1B,0
SHSWEEPKICK2
	.long	SHSWEEPKICK2A,SHSWEEPKICK2B,0
SHSWEEPKICK3
	.long	SHSWEEPKICK3A,0
SHSWEEPKICK4
	.long	SHSWEEPKICK4A,0
SHSWEEPKICK5
	.long	SHSWEEPKICK5A,SHSWEEPKICK5B,0
SHSWEEPKICK6
	.long	SHSWEEPKICK6A,SHSWEEPKICK6B,0
SHSWEEPKICK7
	.long	SHSWEEPKICK7A,SHSWEEPKICK7B,0
SHSWEEPKICK8
	.long	SHSWEEPKICK8A,SHSWEEPKICK8B,0


a_roundhouse
	.long	SHSPINHOOK1
	.long	SHSPINHOOK2
	.long	SHSPINHOOK3
	.long	SHSPINHOOK4
	.long	SHSPINHOOK5
	.long	0
	.long	SHSPINHOOK6
	.long	SHSPINHOOK7
	.long	SHSPINHOOK8
	.long	0

SHSPINHOOK1
	.long	SHSPINHOOK1A,SHSPINHOOK1B,0
SHSPINHOOK2
	.long	SHSPINHOOK2A,SHSPINHOOK2B,0
SHSPINHOOK3
	.long	SHSPINHOOK3A,0
SHSPINHOOK4
	.long	SHSPINHOOK4A,0
SHSPINHOOK5
	.long	SHSPINHOOK5A,SHSPINHOOK5B,0
SHSPINHOOK6
	.long	SHSPINHOOK6A,0
SHSPINHOOK7
	.long	SHSPINHOOK7A,0
SHSPINHOOK8
	.long	SHSPINHOOK8A,SHSPINHOOK8B,0


a_fflip
	.long	SHJUMPFLIP1
	.long	SHJUMPFLIP2
	.long	SHJUMPFLIP3
	.long	SHJUMPFLIP4
	.long	SHJUMPFLIP5
	.long	SHJUMPFLIP6
	.long	SHJUMPFLIP7
	.long	SHJUMPFLIP8
	.long	ani_jump,a_fflip+32


a_bflip
	.long	SHJUMPFLIP1
	.long	SHJUMPFLIP8
	.long	SHJUMPFLIP7
	.long	SHJUMPFLIP6
	.long	SHJUMPFLIP5
	.long	SHJUMPFLIP4
	.long	SHJUMPFLIP3
	.long	SHJUMPFLIP2
	.long	ani_jump,a_bflip+32


SHJUMPFLIP1
	.long	SHJUMPFLIP1A,SHJUMPFLIP1B,0
SHJUMPFLIP2
	.long	SHJUMPFLIP2A,0
SHJUMPFLIP3
	.long	SHJUMPFLIP3A,0
SHJUMPFLIP4
	.long	SHJUMPFLIP4A,0
SHJUMPFLIP5
	.long	SHJUMPFLIP5A,0
SHJUMPFLIP6
	.long	SHJUMPFLIP6A,0
SHJUMPFLIP7
	.long	SHJUMPFLIP7A,0
SHJUMPFLIP8
	.long	SHJUMPFLIP8A,0

a_jump_kick
	.long	SHJUMPKICK1
	.long	SHJUMPKICK2
	.long	SHJUMPKICK3
	.long	0
	.long	SHJUMPKICK2
	.long	SHJUMPKICK1
	.long	0

SHJUMPKICK1
	.long	SHJUMPKICK1A,0
SHJUMPKICK2
	.long	SHJUMPKICK2A,SHJUMPKICK2B,0
SHJUMPKICK3
	.long	SHJUMPKICK3A,SHJUMPKICK3B,0


a_jump	.long	SHJUMP1
	.long	SHJUMP2
	.long	SHJUMP3
	.long	0

SHJUMP1
	.long	SHJUMP1A,SHJUMP1B,0
SHJUMP2
	.long	SHJUMP2A,SHJUMP2B,0
SHJUMP3
	.long	SHJUMP3A,SHJUMP3B,0


a_flip_kick
	.long	SHFLIPKICK1
	.long	SHFLIPKICK2
	.long	SHFLIPKICK3
	.long	0
	.long	SHFLIPKICK2
	.long	SHFLIPKICK1
	.long	0


SHFLIPKICK1
	.long	SHFLIPKICK1A,SHFLIPKICK1B,0
SHFLIPKICK2
	.long	SHFLIPKICK2A,SHFLIPKICK2B,0
SHFLIPKICK3
	.long	SHFLIPKICK3A,0

a_flip_punch
	.long	SHFLIPUNCH1
	.long	SHFLIPUNCH2
	.long	SHFLIPUNCH3
	.long	0
	.long	SHFLIPUNCH2
	.long	SHFLIPUNCH1
	.long	0

SHFLIPUNCH1
	.long	SHFLIPUNCH1A,0
SHFLIPUNCH2
	.long	SHFLIPUNCH2A,0
SHFLIPUNCH3
	.long	SHFLIPUNCH3A,SHFLIPUNCH3B,0

a_hit_hi
	.long	SHHIHIT2
	.long	SHHIHIT3
	.long	SHHIHIT2
	.long	SHHIHIT1
	.long	0

SHHIHIT1	.long	SHHIHIT1A,SHHIHIT1B,0
SHHIHIT2	.long	SHHIHIT2A,SHHIHIT2B,0
SHHIHIT3	.long	SHHIHIT3A,SHHIHIT3B,0


a_hit_lo
	.long	SHLOHIT2
	.long	SHLOHIT3
	.long	SHLOHIT2
	.long	SHLOHIT1
	.long	0

SHLOHIT1	.long	SHLOHIT1A,SHLOHIT1B,0
SHLOHIT2	.long	SHLOHIT2A,SHLOHIT2B,0
SHLOHIT3	.long	SHLOHIT3A,SHLOHIT3B,0


a_dizzy
	.long	SHSTUNNED1
	.long	SHSTUNNED2
	.long	SHSTUNNED3
	.long	SHSTUNNED4
	.long	SHSTUNNED5
	.long	SHSTUNNED6
	.long	SHSTUNNED7
	.long	SHSTUNNED8
	.long	ani_jump,a_dizzy

SHSTUNNED1
	.long	SHSTUNNED1A,SHSTUNNED1B,0
SHSTUNNED2
	.long	SHSTUNNED2A,SHSTUNNED2B,0
SHSTUNNED3
	.long	SHSTUNNED3A,SHSTUNNED3B,0
SHSTUNNED4
	.long	SHSTUNNED4A,SHSTUNNED4B,0
SHSTUNNED5
	.long	SHSTUNNED5A,SHSTUNNED5B,0
SHSTUNNED6
	.long	SHSTUNNED6A,SHSTUNNED6B,0
SHSTUNNED7
	.long	SHSTUNNED7A,SHSTUNNED7B,0
SHSTUNNED8
	.long	SHSTUNNED8A,SHSTUNNED8B,0

a_knockdown
	.long	SHKNOCKDOWN1
	.long	SHKNOCKDOWN2
	.long	SHKNOCKDOWN3
	.long	SHKNOCKDOWN4
	.long	SHKNOCKDOWN5
	.long	0
	.long	SHKNOCKDOWN6
	.long	SHKNOCKDOWN7
	.long	0

SHKNOCKDOWN1
	.long	SHKNOCKDOWN1A,0
SHKNOCKDOWN2
	.long	SHKNOCKDOWN2A,0
SHKNOCKDOWN3
	.long	SHKNOCKDOWN3A,SHKNOCKDOWN3B,0
SHKNOCKDOWN4
	.long	SHKNOCKDOWN4A,SHKNOCKDOWN4B,0
SHKNOCKDOWN5
	.long	SHKNOCKDOWN5A,0
SHKNOCKDOWN6
	.long	SHKNOCKDOWN6A,SHKNOCKDOWN6B,0
SHKNOCKDOWN7
	.long	SHKNOCKDOWN7A,0

a_getup
	.long	SHGETUP1
	.long	SHGETUP2
	.long	SHGETUP3
	.long	SHGETUP4
	.long	SHGETUP5
	.long	0

SHGETUP1
	.long	SHGETUP1A,0
SHGETUP2
	.long	SHGETUP2A,0
SHGETUP3
	.long	SHGETUP3A,SHGETUP3B,0
SHGETUP4
	.long	SHGETUP4A,0
SHGETUP5
	.long	SHGETUP5A,SHGETUP5B,0

a_sweep_fall
	.long	SHSWEEPFALL1
	.long	SHSWEEPFALL2
	.long	SHSWEEPFALL3
	.long	SHSWEEPFALL4
	.long	SHSWEEPFALL5
	.long	0
	.long	SHSWEEPFALL6
	.long	SHSWEEPFALL7
	.long	0


SHSWEEPFALL1
	.long	SHSWEEPFALL1A,SHSWEEPFALL1B,0
SHSWEEPFALL2
	.long	SHSWEEPFALL2A,SHSWEEPFALL2B,0
SHSWEEPFALL3
	.long	SHSWEEPFALL3A,SHSWEEPFALL3B,0
SHSWEEPFALL4
	.long	SHSWEEPFALL4A,SHSWEEPFALL4B,0
SHSWEEPFALL5
	.long	SHSWEEPFALL5A,SHSWEEPFALL5B,0
SHSWEEPFALL6
	.long	SHSWEEPFALL6A,SHSWEEPFALL6B,0
SHSWEEPFALL7
	.long	SHSWEEPFALL7A,SHSWEEPFALL7B,0

a_sweepup
	.long	SHSWEEPUP1
	.long	SHSWEEPUP2
	.long	SHSWEEPUP3
	.long	SHSWEEPUP4
	.long	SHSWEEPUP5
	.long	0

SHSWEEPUP1
	.long	SHSWEEPUP1A,SHSWEEPUP1B,0
SHSWEEPUP2
	.long	SHSWEEPUP2A,0
SHSWEEPUP3
	.long	SHSWEEPUP3A,SHSWEEPUP3B,0
SHSWEEPUP4
	.long	SHSWEEPUP4A,SHSWEEPUP4B,0
SHSWEEPUP5
	.long	SHSWEEPUP5A,SHSWEEPUP5B,0

;*****************************************************

a_afb_kano
 	.long	ani_offset_xy
	.word	->3e,>0a
	.long	SHKNOCKDOWN1

	.long	ani_offset_xy
	.word	->47,>28
	.long	SHKNOCKDOWN3

	.long	ani_offset_xy
 	.word	->47,>2a
	.long	SHKNOCKDOWN4

	.long	0
*
* fall down solo
*
	.long	SHKNOCKDOWN4
	.long	SHKNOCKDOWN5
	.long	SHKNOCKDOWN6
	.long	SHKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	->16,->38
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>04,->3e
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>37,->56
	.long	SHFLIPPED4
	.long	ani_offset_xy
	.word	>55,->2a
	.long	SHFLIPPED4
	.long	ani_offset_xy
	.word	>5c,->0c
	.long	SHKNOCKDOWN6
	.long	ani_offset_xy
	.word	>64,>23
	.long	SHKNOCKDOWN6
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	->1d,>1a
	.long	SHSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	>00,>33
	.long	SHSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	->22,>1d
	.long	SHFLIPPED1		; 3
	.long	ani_offset_xy
	.word	->46,->0f
	.long	SHFLIPPED2		; 4
	.long	ani_offset_xy
	.word	->2c,->57
	.long	SHFLIPPED3		; 5
	.long	ani_offset_xy
	.word	>14,->6d
	.long	SHFLIPPED4		; 6
	.long	ani_offset_xy
	.word	>4f,->70
	.long	SHFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5a,->56
	.long	SHFLIPPED5		; 8
	.long	ani_offset_xy
	.word	>77,>02
	.long	SHFLIPPED5		; 9
	.long	ani_offset_xy
	.word	>77,>52
	.long	SHFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	->6e,>00
	.long	SHFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->6b,->4a
	.long	SHFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->1a,->7c
	.long	SHFLIPPED3		; 3
	.long	ani_offset_xy
	.word	>40,->60
	.long	SHFLIPPED4		; 4
	.long	ani_offset_xy
	.word	>52,->1f
	.long	SHFLIPPED5		; 5

	.long	ani_offset_xy
	.word	>1a,>16
	.long	SHFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->16,->12
  	.long	SHKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	->68,>01
	.long	SHFLIPPED1		; 8
	.long	ani_offset_xy
	.word	->4e,->54
	.long	SHFLIPPED2		; 9
	.long	ani_offset_xy
	.word	>1c,->72
	.long	SHFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	>74,->06
	.long	SHFLIPPED5		; 11
	.long	ani_offset_xy
	.word	>6c,->03
  	.long	SHKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	->3d,->30
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->0d,->4e
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	->09,->47
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>05,->3d
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>0e,->19
	.long	SHFLIPPED2
	.long	ani_flip
	.long	ani_offset_xy
	.word	->22,->04
  	.long	SHKNOCKDOWN7
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	->40,->06
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->35,>07
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->21,>08
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	->0b,>0d
	.long	SHFLIPPED3
	.long	ani_offset_xy
	.word	>0e,>16
	.long	SHFLIPPED4

	.long	ani_offset_xy
	.word	>06,->0a
	.long	SHKNOCKDOWN6
	.long	ani_offset_xy
	.word	->16,->0e
	.long	SHKNOCKDOWN6
	.long	ani_offset_xy
	.word	->31,->10
	.long	SHKNOCKDOWN6

	.long	ani_offset_xy
	.word	->53,>19
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->59,->0b
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->3c,->4c
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>2b,->54
	.long	SHFLIPPED4
	.long	ani_offset_xy
	.word	>4c,->28
	.long	SHFLIPPED5
	.long	ani_offset_xy
	.word	>55,->0e
	.long	SHKNOCKDOWN6
	.long	0



a_fb_lk
	.long	ani_offset_xy
	.word	->38,->01
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->32,>00
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->11,>0c
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>01,>0f
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>2c,>09
	.long	SHFLIPPED3
	.long	ani_offset_xy
	.word	>88,->1f
	.long	SHFLIPPED4
	.long	0

	.long	SHFLIPPED5
	.long	SHKNOCKDOWN5
	.long	SHKNOCKDOWN6
	.long	SHKNOCKDOWN7
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	->36,->15
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->19,->29
	.long	SHFLIPPED2
	.long	ani_offset_xy
 	.word	>2f,->25
	.long	SHFLIPPED3
	.long	0

	.long	SHFLIPPED4
	.long	SHFLIPPED5
	.long	SHKNOCKDOWN5
	.long	SHKNOCKDOWN6
	.long	SHKNOCKDOWN7
	.long	0

a_fb_sonya
	.long	ani_offset_xy
	.word	->28,>02
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->16,>09
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>14,>11
	.long	SHFLIPPED3
	.long	ani_offset_xy
	.word	>46,->02
	.long	SHFLIPPED3
	.long	ani_offset_xy
	.word	>81,->20
	.long	SHFLIPPED4
	.long	0

	.long	SHFLIPPED5
	.long	SHKNOCKDOWN5
	.long	SHKNOCKDOWN6
	.long	SHKNOCKDOWN7
	.long	0


a_fb_jax
	.long	ani_offset_xy
	.word	->43,->12
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->2a,->36
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	->06,->45
	.long	SHFLIPPED3
	.long	ani_offset_xy
	.word	>34,->40
	.long	SHFLIPPED4
	.long	ani_offset_xy
	.word	>64,->2d
	.long	SHKNOCKDOWN6
	.long	ani_offset_xy
	.word	>5d,>02
	.long	SHKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	->5c,->18
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->48,->3e
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	->13,->58
	.long	SHFLIPPED3
	.long	ani_offset_xy
	.word	>2d,->50
	.long	SHFLIPPED4
	.long	ani_offset_xy
	.word	>5e,->18
	.long	SHFLIPPED5
	.long	ani_offset_xy
	.word	>4d,->02
	.long	SHKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	->43,->2c
	.long	SHFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	>33,->17
	.long	SHFLIPPED3

	.long	ani_offset_xy
	.word	>2a,->0e
	.long	SHFLIPPED5

	.long	ani_offset_xy
	.word	>13,>04
	.long	SHKNOCKDOWN5

	.long	ani_offset_xy
	.word	->2d,->1d
	.long	SHKNOCKDOWN5

	.long	ani_offset_xy
	.word	->69,->4f
	.long	SHKNOCKDOWN5

	.long	0

a_fb_swat
	.long	ani_offset_xy
	.word	->51,->04
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->2e,->46
	.long	SHFLIPPED2
	.long	ani_offset_xy
	.word	>24,->50
	.long	SHFLIPPED3
	.long	ani_offset_xy
	.word	>65,->29
	.long	SHFLIPPED4
	.long	ani_offset_xy
	.word	>5f,>04
	.long	SHKNOCKDOWN6
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	->64,>00
	.long	SHSTUMBLE1
	.long	ani_offset_xy
	.word	->73,>03
	.long	SHSTUMBLE1

	.long	ani_offset_xy
	.word	->75,->1e
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->57,->3d
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	->23,->46
	.long	SHFLIPPED1
	.long	ani_offset_xy
	.word	>1e,->4e
	.long	SHFLIPPED1

	.long	ani_offset_xy
	.word	>a8,>12
	.long	SHFLIPPED4
	.long	ani_offset_xy
	.word	>8d,>00
	.long	SHKNOCKDOWN7
	.long	0


a_fb_robo
	.long	ani_offset_xy
	.word	->4e,->04
	.long	SHFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->43,->2f
	.long	SHFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->31,->48
	.long	SHFLIPPED2		; 3

	.long	ani_offset_xy
	.word	>0b,->64
	.long	SHFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>41,->72
	.long	SHFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>6b,->5b
	.long	SHFLIPPED4		; 6

	.long	ani_offset_xy
	.word	>80,->1e
	.long	SHFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5b,->08
	.long	SHKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	->29,>00
	.long	SHSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->2a,->0e
	.long	SHFLIPPED1		; 2
	.long	ani_offset_xy
	.word	->0a,->1f
	.long	SHFLIPPED2		; 3
	.long	ani_offset_xy
	.word	>1e,->1a
	.long	SHFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>13,->01
	.long	SHFLIPPED4		; 5
	.long	ani_offset_xy
	.word	->02,>01
	.long	SHFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->18,->11
	.long	SHKNOCKDOWN7		; 7
	.long	0



a_legged
	.long	ani_offset_xy
	.word	->66,>0b
	.long	SHKNOCKDOWN1

	.long	ani_offset_xy
	.word	->54,->1a
	.long	SHFLIPPED1

	.long	ani_offset_xy
	.word	->17,->45
	.long	SHFLIPPED3

	.long	ani_offset_xy
	.word	>30,->3a
	.long	SHFLIPPED4

	.long	ani_offset_xy
	.word	>55,->0b
	.long	SHFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	>69,->1c
	.long	SHKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	>57,>01
	.long	SHKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	>3c,->05
	.long	SHKNOCKDOWN7	; 3

	.long	ani_offset_xy
	.word	->1c,->05
	.long	SHKNOCKDOWN7	; 4

	.long	ani_offset_xy
	.word	->83,->0a
	.long	SHFLIPPED1	; 5

	.long	ani_offset_xy
	.word	->41,->55
	.long	SHFLIPPED3	; 6
	.long	0

	.long	SHFLIPPED3
	.long	SHFLIPPED4
	.long	SHFLIPPED5
	.long	SHKNOCKDOWN5
	.long	SHKNOCKDOWN6
	.long	SHKNOCKDOWN7
	.long	0

a_shook
	.long	ani_offset_xy
	.word	->46,>00
	.long	SHSTUMBLE1	; 3

	.long	ani_offset_xy
	.word	->2f,->1a
	.long	SHSTUMBLE1	; 4

	.long	ani_offset_xy
	.word	->13,->10
	.long	SHSTUMBLE1	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	->18,->13
	.long	SHSTUMBLE1	; 6

	.long	ani_offset_xy
	.word	->2d,->1e
	.long	SHSTUMBLE1	; 7

	.long	ani_offset_xy
	.word	->3b,->1f
	.long	SHSTUMBLE1	; 8

	.long	ani_offset_xy
	.word	->30,->21
	.long	SHSTUMBLE1	; 7
	.long	0

SHFLIPPED1
	.long	SHFLIPPED1A,0
SHFLIPPED2
	.long	SHFLIPPED2A,0
SHFLIPPED3
	.long	SHFLIPPED3A,0
SHFLIPPED4
	.long	SHFLIPPED4A,0
SHFLIPPED5
	.long	SHFLIPPED5A,SHFLIPPED5B,0

a_stumble
	.long	SHSTUMBLE1
	.long	SHSTUMBLE2
	.long	SHSTUMBLE3
	.long	SHSTUMBLE4
	.long	SHSTUMBLE5
	.long	SHSTUMBLE6
	.long	0

j_stumble
	.long	SHSTUMBLE1
	.long	SHSTUMBLE2
	.long	SHSTUMBLE3
	.long	SHSTUMBLE4
	.long	SHSTUMBLE5
	.long	SHSTUMBLE6
	.long	ani_jump,j_stumble


SHSTUMBLE1
	.long	SHSTUMBLE1A,SHSTUMBLE1B,0
SHSTUMBLE2
	.long	SHSTUMBLE2A,0
SHSTUMBLE3
	.long	SHSTUMBLE3A,0
SHSTUMBLE4
	.long	SHSTUMBLE4A,0
SHSTUMBLE5
	.long	SHSTUMBLE5A,0
SHSTUMBLE6
	.long	SHSTUMBLE6A,SHSTUMBLE6B,0

;********************************************

a_zap
	.long	ani_sladd,SHEP1
	.long	SHTHROWPRO1
	.long	ani_slani,SHEP2
	.long	SHTHROWPRO2
	.long	ani_slani,SHEP3
	.long	SHTHROWPRO3
	.long	ani_slani,SHEP4
	.long	SHTHROWPRO4
	.long	ani_slani,SHEP5
	.long	SHTHROWPRO5
	.long	0
	.long	SHTHROWPRO6
	.long	0

SHEP1	.long	SHEPRO1A,SHEPRO1B,0
SHEP2	.long	SHEPRO2A,SHEPRO2B,0
SHEP3	.long	SHEPRO3A,SHEPRO3B,0
SHEP4	.long	SHEPRO4,0
SHEP5	.long	SHEPRO5,0
SHEP6	.long	SHEPRO6,0
SHEP7	.long	SHEPRO7,0
SHEP8	.long	SHEPRO8,0

SHTHROWPRO1
	.long	SHTHROWPRO1A,SHTHROWPRO1B,0
SHTHROWPRO2
	.long	SHTHROWPRO2A,SHTHROWPRO2B,0
SHTHROWPRO3
	.long	SHTHROWPRO3A,SHTHROWPRO3B,0
SHTHROWPRO4
	.long	SHTHROWPRO4A,SHTHROWPRO4B,0
SHTHROWPRO5
	.long	SHTHROWPRO5A,SHTHROWPRO5B,0
SHTHROWPRO6
	.long	SHTHROWPRO6A,SHTHROWPRO6B,0


;********************************************


a_throw
	.long	SHBODYSLAM1
	.long	SHBODYSLAM2
	.long	SHBODYSLAM3	; grab
	.long	0

	.long	SHBODYSLAM4
	.long	SHBODYSLAM5
	.long	SHBODYSLAM6
	.long	SHBODYSLAM7
	.long	SHBODYSLAM8	; animate 2-gether
	.long	SHBODYSLAM9
	.long	0

	.long	SHBODYSLAM10	; finish off animation
	.long	SHBODYSLAM9
	.long	0


SHBODYSLAM1
	.long	SHBODYSLAM1A,SHBODYSLAM1B,0
SHBODYSLAM2
	.long	SHBODYSLAM2A,SHBODYSLAM2B,0
SHBODYSLAM3
	.long	SHBODYSLAM3A,SHBODYSLAM3B,0
SHBODYSLAM4
	.long	SHBODYSLAM4A,SHBODYSLAM4B,0
SHBODYSLAM5
	.long	SHBODYSLAM5A,SHBODYSLAM5B,0
SHBODYSLAM6
	.long	SHBODYSLAM6A,SHBODYSLAM6B,0
SHBODYSLAM7
	.long	SHBODYSLAM7A,SHBODYSLAM7B,0
SHBODYSLAM8
	.long	SHBODYSLAM8A,SHBODYSLAM8B,0
SHBODYSLAM9
	.long	SHBODYSLAM9A,SHBODYSLAM9B,0
SHBODYSLAM10
	.long	SHBODYSLAM10A,SHBODYSLAM10B,0

a_run
	.long	SHRUN1
	.long	SHRUN2
	.long	SHRUN3
	.long	SHRUN4
	.long	ani_calla,rsnd_footstep
	.long	SHRUN5
	.long	SHRUN6
	.long	SHRUN7
	.long	SHRUN8
	.long	SHRUN9
	.long	ani_calla,rsnd_footstep
	.long	SHRUN10
	.long	SHRUN11
	.long	SHRUN12
	.long	ani_jump,a_run
	.long	0			; we need this zero !!

SHRUN1
	.long	SHRUN1A,0
SHRUN2
	.long	SHRUN2A,0
SHRUN3
	.long	SHRUN3A,0
SHRUN4
	.long	SHRUN4A,SHRUN4B,0
SHRUN5
	.long	SHRUN5A,SHRUN5B,0
SHRUN6
	.long	SHRUN6A,SHRUN6B,0
SHRUN7
	.long	SHRUN7A,0
SHRUN8
	.long	SHRUN8A,0
SHRUN9
	.long	SHRUN9A,0
SHRUN10
	.long	SHRUN10A,SHRUN10B,0
SHRUN11
	.long	SHRUN11A,SHRUN11B,0
SHRUN12
	.long	SHRUN12A,SHRUN12B,0

a_victory
	.long	SHVICTORY1
	.long	SHVICTORY2
	.long	SHVICTORY3
	.long	SHVICTORY4
	.long	SHVICTORY5
	.long	SHVICTORY6
	.long	SHVICTORY7
	.long	SHVICTORY8
	.long	SHVICTORY9
	.long	SHVICTORY10
	.long	SHVICTORY11
	.long	SHVICTORY12
	.long	SHVICTORY13
	.long	SHVICTORY14
	.long	0

SHVICTORY1
	.long	SHVICTORY1A,SHVICTORY1B,0
SHVICTORY2
	.long	SHVICTORY2A,SHVICTORY2B,0
SHVICTORY3
	.long	SHVICTORY3A,SHVICTORY3B,0
SHVICTORY4
	.long	SHVICTORYLEG,SHVICTORY4A,0
SHVICTORY5
	.long	SHVICTORYLEG,SHVICTORY5A,0
SHVICTORY6
	.long	SHVICTORYLEG,SHVICTORY6A,0
SHVICTORY7
	.long	SHVICTORYLEG,SHVICTORY7A,SHVICTORY7B,0
SHVICTORY8
	.long	SHVICTORYLEG,SHVICTORY8A,SHVICTORY8B,0
SHVICTORY9
	.long	SHVICTORYLEG,SHVICTORY9A,SHVICTORY9B,0
SHVICTORY10
	.long	SHVICTORYLEG,SHVICTORY10A,SHVICTORY10B,0
SHVICTORY11
	.long	SHVICTORYLEG,SHVICTORY11A,SHVICTORY11B,0
SHVICTORY12
	.long	SHVICTORYLEG,SHVICTORY12A,0
SHVICTORY13
	.long	SHVICTORYLEG,SHVICTORY13A,0
SHVICTORY14
	.long	SHVICTORYLEG,SHVICTORY14A,0

;*********************************

a_pounce
	.long	SHSTOMP1
j_pounce	.long	SHSTOMP2
	.long	SHSTOMP3
	.long	SHSTOMP3MB1
	.long	SHSTOMP3MB2
	.long	SHSTOMP3MB3
	.long	SHSTOMP3MB4
	.long	0

	.long	SHSTOMP4MB1
	.long	SHSTOMP4MB3
	.long	SHSTOMP4MB5
	.long	SHSTOMP4
	.long	0

	.long	SHSTOMP5
	.long	SHSTOMP1
	.long	SHSTOMP1
	.long	SHSTOMP1
	.long	SHSTOMP2
	.long	SHSTOMP2
	.long	ani_jump,j_pounce

SHSTOMP1
	.long	SHSTOMP1A,SHSTOMP1B,0
SHSTOMP2
	.long	SHSTOMP2A,SHSTOMP2B,0
SHSTOMP3
	.long	SHSTOMP3A,SHSTOMP3B,0
SHSTOMP3MB1
	.long	SHSTOMP3MB1A,SHSTOMP3MB1B,0
SHSTOMP3MB2
	.long	SHSTOMP3MB2A,SHSTOMP3MB2B,0
SHSTOMP3MB3
	.long	SHSTOMP3MB3A,SHSTOMP3MB3B,0
SHSTOMP3MB4
	.long	SHSTOMP3MB4A,SHSTOMP3MB4B,0
SHSTOMP3MB5
	.long	SHSTOMP3MB5A,SHSTOMP3MB5B,0
SHSTOMP4
	.long	SHSTOMP4A,SHSTOMP4B,0
SHSTOMP4MB1
	.long	SHSTOMP4MB1A,SHSTOMP4MB1B,0
SHSTOMP4MB3
	.long	SHSTOMP4MB3A,SHSTOMP4MB3B,0
SHSTOMP4MB5
	.long	SHSTOMP4MB5A,SHSTOMP4MB5B,0
SHSTOMP5
	.long	SHSTOMP5A,SHSTOMP5B,0

;****************************

a_scared
	.long	SGSCARED2
	.long	0

SGSCARED2
	.long	SGSCARED2A,0

a_thudd
	.long	SGTHUD1
	.long	SGTHUD2
	.long	SGTHUD3
	.long	SGTHUD4
	.long	SGTHUD5
	.long	SGTHUD6
	.long	SGTHUD7
	.long	0

SGTHUD1
	.long	SGTHUD1A,0
SGTHUD2
	.long	SGTHUD2A,0
SGTHUD3
	.long	SGTHUD3A,0
SGTHUD4
	.long	SGTHUD4A,0
SGTHUD5
	.long	SGTHUD5A,0
SGTHUD6
	.long	SGTHUD6A,0
SGTHUD7
	.long	SGTHUD7A,0

;****************************

ochar_pounded
	.long	KNNAIL1
	.long	SBNAIL1
	.long	JXNAIL1
	.long	INNAIL1
	.long	SZNAIL1
	.long	OBNAIL1
	.long	LINAIL1
	.long	RBNAIL1
	.long	RBNAIL1
	.long	KLNAIL1
	.long	TRNAIL1
	.long	SGNAIL1
	.long	TSNAIL1
	.long	LUNAIL1
	.long	RBNAIL1

KNPOUND	.long	KNNAIL1,0
SBPOUND	.long	SBNAIL1,0
JXPOUND	.long	JXNAIL1,0
INPOUND	.long	INNAIL1,0
SZPOUND	.long	SZNAIL1,0
OBPOUND	.long	OBNAIL1,0
LIPOUND	.long	LINAIL1,0
RBPOUND	.long	RBNAIL1,0
KLPOUND	.long	KLNAIL1,0
TRPOUND	.long	TRNAIL1,0
SGPOUND	.long	SGNAIL1,0
TSPOUND	.long	TSNAIL1,0
LUPOUND	.long	LUNAIL1,0

;****************************

a_pound
	.long	SGBIGPOUND5
	.long	SGBIGPOUND6
	.long	SGBIGPOUND7
	.long	SGBIGPOUND8
	.long	0
	.long	SGBIGPOUND9
	.long	SGBIGPOUND10
	.long	SGBIGPOUND11
	.long	SGBIGPOUND12
	.long	SGBIGPOUND13
	.long	0
	.long	SGBIGPOUND14
	.long	SGBIGPOUND15
	.long	SGBIGPOUND16
	.long	SGBIGPOUND17
	.long	0

	.long	SHBODYSLAM3
	.long	SHBODYSLAM2
	.long	SHBODYSLAM1	; grab
	.long	0


SGBIGPOUND5
	.long	SGBIGPOUND5A,SGBIGPOUND5B,0
SGBIGPOUND6
	.long	SGBIGPOUND6A,SGBIGPOUND6B,0
SGBIGPOUND7
	.long	SGBIGPOUND7A,SGBIGPOUND7B,0
SGBIGPOUND8
	.long	SGBIGPOUND8A,SGBIGPOUND8B,0
SGBIGPOUND9
	.long	SGBIGPOUND9A,SGBIGPOUND9B,0
SGBIGPOUND10
	.long	SGBIGPOUND10A,SGBIGPOUND10B,0
SGBIGPOUND11
	.long	SGBIGPOUND11A,SGBIGPOUND11B,0
SGBIGPOUND12
	.long	SGBIGPOUND12A,SGBIGPOUND12B,0
SGBIGPOUND13
	.long	SGBIGPOUND13A,SGBIGPOUND13B,0
SGBIGPOUND14
	.long	SGBIGPOUND14A,SGBIGPOUND14B,0
SGBIGPOUND15
	.long	SGBIGPOUND15A,SGBIGPOUND15B,0
SGBIGPOUND16
	.long	SGBIGPOUND16A,SGBIGPOUND16B,0
SGBIGPOUND17
	.long	SGBIGPOUND17A,SGBIGPOUND17B,0



a_rip_flesh
	.long	SGRIPFLESH1
	.long	SGRIPFLESH2
	.long	SGRIPFLESH3
	.long	SGRIPFLESH4
	.long	SGRIPFLESH5	; gwab !!
	.long	0

	.long	SGRIPFLESH6
	.long	SGRIPFLESH7
	.long	SGRIPFLESH8
	.long	0

SGRIPFLESH1
	.long	SGRIPFLESH1A,SGRIPFLESH1B,0
SGRIPFLESH2
	.long	SGRIPFLESH2A,SGRIPFLESH2B,0
SGRIPFLESH3
	.long	SGRIPFLESH3A,SGRIPFLESH3B,0
SGRIPFLESH4
	.long	SGRIPFLESH4A,SGRIPFLESH4B,0
SGRIPFLESH5
	.long	SGRIPFLESH5A,SGRIPFLESH5B,0
SGRIPFLESH6
	.long	SGRIPFLESH6A,SGRIPFLESH6B,0
SGRIPFLESH7
	.long	SGRIPFLESH7A,SGRIPFLESH7B,0
SGRIPFLESH8
	.long	SGRIPFLESH8A,SGRIPFLESH8B,0


	.end



