**************************************************************************
*											     *
*  mk3 - sonya.asm										*
*											     *
**************************************************************************

	.FILE	"mksonya.ASM"
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo

	.include mksonya.tbl
	.include mksonya2.tbl

	.text

sonya_anitab1
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
	.long	a_fb_tusk	; 30	- flipped by tusk
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
	.long	a_scared	; 40

;**************************************************************************

sonya_anitab2
	.long	a_leg_grab		; 0 - leg grab
	.long	a_bike			; 1 - bike kick
	.long	a_death_kiss		; 2
	.long	a_square		; 3
	.long	a_sonya_energy_ball	; 4
	.long	a_gutz			; 5

;**************************************************************************

a_dummy
a_stance
	.long	SBSTANCE1
	.long	SBSTANCE2
	.long	SBSTANCE3
	.long	SBSTANCE4
	.long	SBSTANCE5
	.long	SBSTANCE6
	.long	SBSTANCE7
	.long	SBSTANCE8
	.long	ani_jump,a_stance

SBSTANCE1
	.long	SBSTANCE1A,SBSTANCE1B,0
SBSTANCE2
	.long	SBSTANCE2A,SBSTANCE2B,0
SBSTANCE3
	.long	SBSTANCE3A,SBSTANCE3B,0
SBSTANCE4
	.long	SBSTANCE4A,SBSTANCE4B,0
SBSTANCE5
	.long	SBSTANCE5A,SBSTANCE5B,0
SBSTANCE6
	.long	SBSTANCE6A,SBSTANCE6B,0
SBSTANCE7
	.long	SBSTANCE7A,SBSTANCE7B,0
SBSTANCE8
	.long	SBSTANCE8A,SBSTANCE8B,0

;*************************************************************************

a_walkf
	.long	SBWALK1
	.long	SBWALK2
	.long	SBWALK3
	.long	SBWALK4
	.long	SBWALK5
	.long	SBWALK6
	.long	SBWALK7
	.long	SBWALK8
	.long	SBWALK9
	.long	ani_jump,a_walkf

a_walkb
	.long	SBWALK9
	.long	SBWALK8
	.long	SBWALK7
	.long	SBWALK6
	.long	SBWALK5
	.long	SBWALK4
	.long	SBWALK3
	.long	SBWALK2
	.long	SBWALK1
	.long	ani_jump,a_walkb

SBWALK1	.long	SBWALKTORSO1A
	.long	SBWALKLEG1A,SBWALKLEG1B,0
SBWALK2	.long	SBWALKTORSO2A
	.long	SBWALKLEG2A,0
SBWALK3	.long	SBWALKTORSO3A
	.long	SBWALKLEG3A,0
SBWALK4	.long	SBWALKTORSO4A
	.long	SBWALKLEG4A,SBWALKLEG4B,0
SBWALK5	.long	SBWALKTORSO5A
	.long	SBWALKLEG5A,SBWALKLEG5B,0
SBWALK6	.long	SBWALKTORSO6A
	.long	SBWALKLEG6A,SBWALKLEG6B,0
SBWALK7	.long	SBWALKTORSO7A
	.long	SBWALKLEG7A,0
SBWALK8	.long	SBWALKTORSO8A
	.long	SBWALKLEG8A,0
SBWALK9	.long	SBWALKTORSO9A
	.long	SBWALKLEG9A,SBWALKLEG9B,0

;*************************************************************************

a_duck_turn
	.long	SBDUCKTURN1
	.long	SBDUCKTURN2
	.long	ani_flip
	.long	SBDUCKTURN1
	.long	SBDUCK3
	.long	0

SBDUCKTURN1
	.long	SBDUCKTURN1A,SBDUCKTURN1B,0
SBDUCKTURN2
	.long	SBDUCKTURN2A,SBDUCKTURN2B,0



a_turn
	.long	SBTURN1
	.long	SBTURN2
	.long	ani_flip
	.long	SBTURN1
	.long	0

SBTURN1	.long	SBTURN1A,SBTURN1B,0
SBTURN2	.long	SBTURN2A,SBTURN2B,0

;**************************************************************************

a_duck
	.long	SBDUCK1
	.long	SBDUCK2
	.long	SBDUCK3
	.long	0

SBDUCK1	.long	SBDUCK1A,SBDUCK1B,0
SBDUCK2	.long	SBDUCK2A,SBDUCK2B,0
SBDUCK3	.long	SBDUCK3A,SBDUCK3B,0

;*************************************************************************

a_duck_block
	.long	SBDUCKBLOCK1
	.long	SBDUCKBLOCK2
	.long	SBDUCKBLOCK3
	.long	0

SBDUCKBLOCK1
	.long	SBDUCKBLOCK1A,SBDUCKBLOCK1B,0
SBDUCKBLOCK2
	.long	SBDUCKBLOCK2A,SBDUCKBLOCK2B,0
SBDUCKBLOCK3
	.long	SBDUCKBLOCK3A,SBDUCKBLOCK3B,0

;*************************************************************************

a_duck_punch
	.long	SBDUCKPUNCH1
	.long	SBDUCKPUNCH2
	.long	SBDUCKPUNCH3
	.long	0
	.long	SBDUCKPUNCH2
	.long	SBDUCKPUNCH1
	.long	SBDUCK3
	.long	0

SBDUCKPUNCH1
	.long	SBDUCKPUNCH1A,SBDUCKPUNCH1B,0
SBDUCKPUNCH2
	.long	SBDUCKPUNCH2A,SBDUCKPUNCH2B,0
SBDUCKPUNCH3
	.long	SBDUCKPUNCH3A,SBDUCKPUNCH3B,0

;*************************************************************************

a_duck_hit
	.long	SBDUCKHIT2
	.long	SBDUCKHIT3
	.long	SBDUCKHIT2
	.long	SBDUCKHIT1
	.long	0

SBDUCKHIT1
	.long	SBDUCKHIT1A,SBDUCKHIT1B,0
SBDUCKHIT2
	.long	SBDUCKHIT2A,SBDUCKHIT2B,0
SBDUCKHIT3
	.long	SBDUCKHIT3A,SBDUCKHIT3B,0

;*************************************************************************

a_duck_kick_hi
	.long	SBDUCKHIKICK1
	.long	SBDUCKHIKICK2
;	.long	SBDUCKHIKICK3
	.long	SBDUCKHIKICK4
	.long	0
	.long	SBDUCKHIKICK3
	.long	SBDUCKHIKICK2
	.long	SBDUCKHIKICK1
	.long	SBDUCK3
	.long	0

SBDUCKHIKICK1
	.long	SBDUCKHIKICK1A,SBDUCKHIKICK1B,0
SBDUCKHIKICK2
	.long	SBDUCKHIKICK2A,SBDUCKHIKICK2B,0
SBDUCKHIKICK3
	.long	SBDUCKHIKICK3A,SBDUCKHIKICK3B,0
	.long	0
SBDUCKHIKICK4
	.long	SBDUCKHIKICK4A,SBDUCKHIKICK4B,0

;*************************************************************************

; we should make these all have the same # of frames (ejbpatch)
a_duck_kick_lo
	.long	SBDUCKLOKICK1
	.long	SBDUCKLOKICK2
	.long	SBDUCKLOKICK3
	.long	0
	.long	SBDUCKLOKICK2
	.long	SBDUCKLOKICK1
	.long	SBDUCK3
	.long	0

SBDUCKLOKICK1
	.long	SBDUCKLOKICK1A,SBDUCKLOKICK1B,0
SBDUCKLOKICK2
	.long	SBDUCKLOKICK2A,SBDUCKLOKICK2B,SBDUCKLOKICK2C,0
SBDUCKLOKICK3
	.long	SBDUCKLOKICK3A,SBDUCKLOKICK3B,0

;*************************************************************************

a_uppercut
	.long	SBUPPERCUT1
	.long	SBUPPERCUT2
	.long	SBUPPERCUT3
	.long	SBUPPERCUT4
	.long	ani_nosleep	; dont sleep after next frame
	.long	SBUPPERCUT5
	.long	0
	.long	SBUPPERCUT6
	.long	0

SBUPPERCUT1
	.long	SBUPPERCUT1A,SBUPPERCUT1B,0
	.long	0
SBUPPERCUT2
	.long	SBUPPERCUT2A,SBUPPERCUT2B,0
SBUPPERCUT3
	.long	SBUPPERCUT3A,SBUPPERCUT3B,0
	.long	0
SBUPPERCUT4
	.long	SBUPPERCUT4A,SBUPPERCUT4B,0
	.long	0
SBUPPERCUT5
	.long	SBUPPERCUT5A,SBUPPERCUT5B,0
	.long	0
SBUPPERCUT6
	.long	SBUPPERCUT6A,SBUPPERCUT6B,0

;*************************************************************************

a_block
	.long	SBHIBLOCK1
	.long	SBHIBLOCK2
	.long	SBHIBLOCK3
	.long	0

SBHIBLOCK1
	.long	SBHIBLOCK1A,SBHIBLOCK1B,0
SBHIBLOCK2
	.long	SBHIBLOCK2A,SBHIBLOCK2B,0
SBHIBLOCK3
	.long	SBHIBLOCK3A,SBHIBLOCK3B,0

;*************************************************************************

a_elbow
	.long	SBBELBO1
	.long	SBBELBO2
	.long	SBBELBO3
	.long	0
	.long	SBBELBO2
	.long	SBBELBO1
	.long	0

	.long	ani_adjustx
	.word	8
	.long	SBCOMBO1
	.long	ani_adjustx
	.word	8
	.long	SBCOMBO2
	.long	SBCOMBO3
	.long	ani_nosleep
	.long	SBCOMBO4	; part 3 = hit 2
	.long	0

	.long	ani_adjustx
	.word	8
	.long	SBCOMBO5
	.long	ani_adjustx
	.word	8
	.long	SBCOMBO6
	.long	SBCOMBO7	; part 4 = hit 3
	.long	0

	.long	ani_adjustx
	.word	8
	.long	SBCOMBO8
	.long	ani_adjustx
	.word	8
	.long	SBCOMBO9
	.long	SBCOMBO10
	.long	SBCOMBO11
	.long	SBCOMBO12	; part 5 = hit 4
	.long	0

	.long	SBCOMBO11
	.long	SBCOMBO10
	.long	SBCOMBO9
	.long	SBCOMBO8
	.long	SBCOMBO2
	.long	SBCOMBO1
	.long	0

	.long	ani_adjustx
	.word	10
	.long	SBBELBO1
	.long	ani_adjustx
	.word	10
	.long	SBBELBO2
	.long	SBBELBO3	; part 7 = elbow 1 that moves forward
	.long	0


SBCOMBO1
	.long	SBCOMBO1A,SBCOMBO1B,0
SBCOMBO2
	.long	SBCOMBO2A,SBCOMBO2B,0
SBCOMBO3
	.long	SBCOMBO3A,SBCOMBO3B,0
SBCOMBO4
	.long	SBCOMBO4A,SBCOMBO4B,0
SBCOMBO5
	.long	SBCOMBO5A,SBCOMBO5B,0
SBCOMBO6
	.long	SBCOMBO6A,SBCOMBO6B,0
SBCOMBO7
	.long	SBCOMBO7A,SBCOMBO7B,0
SBCOMBO8
	.long	SBCOMBO8A,SBCOMBO8B,0
SBCOMBO9
	.long	SBCOMBO9A,SBCOMBO9B,0
SBCOMBO10
	.long	SBCOMBO10A,0
SBCOMBO11
	.long	SBCOMBO11A,SBCOMBO11B,0
SBCOMBO12
	.long	SBCOMBO12A,SBCOMBO12B,0


SBBELBO1	.long	SBELBOW1A,SBELBOW1B,0
SBBELBO2	.long	SBELBOW2A,SBELBOW2B,0
SBBELBO3	.long	SBELBOW3A,SBELBOW3B,0

;**************************************************************************

a_hipunch
	.long	SBHIPUNCH1
	.long	SBHIPUNCH2
	.long	SBHIPUNCH3
	.long	0

	.long	SBHIPUNCH4
	.long	SBHIPUNCH5
	.long	SBHIPUNCH6
	.long	0

	.long	SBHIPUNCH5
	.long	SBHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	SBHIPUNCH2
	.long	SBHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	SBHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	SBHIPUNCH4
	.long	SBLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	SBHIPUNCH5
	.long	SBLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0

SBHIPUNCH1
	.long	SBHIPUNCH1A,SBHIPUNCH1B,0
SBHIPUNCH2
	.long	SBHIPUNCH2A,SBHIPUNCH2B,0
SBHIPUNCH3
	.long	SBHIPUNCH3A,SBHIPUNCH3B,0
SBHIPUNCH4
	.long	SBHIPUNCH4A,SBHIPUNCH4B,0
SBHIPUNCH5
	.long	SBHIPUNCH5A,SBHIPUNCH5B,0
SBHIPUNCH6
	.long	SBHIPUNCH6A,SBHIPUNCH6B,0
SBHIPUNCH7
	.long	SBHIPUNCH7A,SBHIPUNCH7B,0
	.long	0


;*************************************************************************

a_lopunch
	.long	SBLOPUNCH1
	.long	SBLOPUNCH2
	.long	SBLOPUNCH3
	.long	0

	.long	SBLOPUNCH4
	.long	SBLOPUNCH5
	.long	SBLOPUNCH6
	.long	0

	.long	SBLOPUNCH5
	.long	SBLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	SBLOPUNCH2
	.long	SBLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	SBHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	SBLOPUNCH4
	.long	SBLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	SBLOPUNCH4
	.long	SBHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)

SBJUMPFLIP1
	.long	SBJUMPFLIP1A,0
SBLOPUNCH1
	.long	SBLOPUNCH1A,SBLOPUNCH1B,0
SBLOPUNCH2
	.long	SBLOPUNCH2A,SBLOPUNCH2B,0
SBLOPUNCH3
	.long	SBLOPUNCH3A,SBLOPUNCH3B,0
SBLOPUNCH4
	.long	SBLOPUNCH4A,SBLOPUNCH4B,0
SBLOPUNCH5
	.long	SBLOPUNCH5A,SBLOPUNCH5B,0
SBLOPUNCH6
	.long	SBLOPUNCH6A,SBLOPUNCH6B,0

;**************************************************************************

a_jump	.long	SBJUMP1
	.long	SBJUMP2
	.long	SBJUMP3
	.long	0

SBJUMP1	.long	SBJUMP1A,SBJUMP1B,0
SBJUMP2	.long	SBJUMP2A,SBJUMP2B,0
SBJUMP3	.long	SBJUMP3A,SBJUMP3B,0

;**************************************************************************

a_jump_kick
	.long	SBJUMPKICK1
	.long	SBJUMPKICK2
	.long	SBJUMPKICK3
	.long	0
	.long	SBJUMPKICK2
	.long	SBJUMPKICK1
	.long	0

SBJUMPKICK1
	.long	SBJUMPKICK1A,0
SBJUMPKICK2
	.long	SBJUMPKICK2A,SBJUMPKICK2B,0
SBJUMPKICK3
	.long	SBJUMPKICK3A,SBJUMPKICK3B,0

;**************************************************************************

a_flip_kick
	.long	SBFLIPKICK1
	.long	SBFLIPKICK2
	.long	SBFLIPKICK3
	.long	0
	.long	SBFLIPKICK2
	.long	SBFLIPKICK1
	.long	0

SBFLIPKICK1
	.long	SBFLIPKICK1A,0
SBFLIPKICK2
	.long	SBFLIPKICK2A,0
SBFLIPKICK3
	.long	SBFLIPKICK3A,SBFLIPKICK3B,0

;**************************************************************************

a_flip_punch
	.long	SBFLIPUNCH1
	.long	SBFLIPUNCH2
	.long	SBFLIPUNCH3
	.long	0
	.long	SBFLIPUNCH2
	.long	SBFLIPUNCH1
	.long	0

SBFLIPUNCH1
	.long	SBFLIPUNCH1A,0
SBFLIPUNCH2
	.long	SBFLIPUNCH2A,0
SBFLIPUNCH3
	.long	SBFLIPUNCH3A,SBFLIPUNCH3B,0

;**************************************************************************

a_fflip	.long	SBJUMPFLIP1
	.long	SBJUMPFLIP2
	.long	SBJUMPFLIP3
	.long	SBJUMPFLIP4
	.long	SBJUMPFLIP5
	.long	SBJUMPFLIP6
	.long	SBJUMPFLIP7
	.long	SBJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip	.long	SBJUMPFLIP1
	.long	SBJUMPFLIP8
	.long	SBJUMPFLIP7
	.long	SBJUMPFLIP6
	.long	SBJUMPFLIP5
	.long	SBJUMPFLIP4
	.long	SBJUMPFLIP3
	.long	SBJUMPFLIP2
	.long	ani_jump,a_bflip+32


SBJUMPFLIP2
	.long	SBJUMPFLIP2A,0
SBJUMPFLIP3
	.long	SBJUMPFLIP3A,0
SBJUMPFLIP4
	.long	SBJUMPFLIP4A,0
SBJUMPFLIP5
	.long	SBJUMPFLIP5A,0
SBJUMPFLIP6
	.long	SBJUMPFLIP6A,0
SBJUMPFLIP7
	.long	SBJUMPFLIP7A,0
SBJUMPFLIP8
	.long	SBJUMPFLIP8A,0

;**************************************************************************

a_stumble
	.long	SBSTUMBLE1
	.long	SBSTUMBLE2
	.long	SBSTUMBLE3
	.long	SBSTUMBLE4
	.long	SBSTUMBLE5
	.long	SBSTUMBLE6
	.long	0

*
* part 2 = repeating version
*
j_stumble
	.long	SBSTUMBLE1
	.long	SBSTUMBLE2
	.long	SBSTUMBLE3
	.long	SBSTUMBLE4
	.long	SBSTUMBLE5
	.long	SBSTUMBLE6
	.long	ani_jump,j_stumble



SBSTUMBLE1
	.long	SBSTUMBLE1A,SBSTUMBLE1B,0
SBSTUMBLE2
	.long	SBSTUMBLE2A,SBSTUMBLE2B,0
SBSTUMBLE3
	.long	SBSTUMBLE3A,0
SBSTUMBLE4
	.long	SBSTUMBLE4A,SBSTUMBLE4B,0
SBSTUMBLE5
	.long	SBSTUMBLE5A,0
SBSTUMBLE6
	.long	SBSTUMBLE6A,SBSTUMBLE6B,0

;**************************************************************************

a_hit_hi
	.long	SBHIHIT2
	.long	SBHIHIT3
	.long	SBHIHIT2
	.long	SBHIHIT1
	.long	0

SBHIHIT1	.long	SBHIHIT1A,SBHIHIT1B,0
SBHIHIT2	.long	SBHIHIT2A,SBHIHIT2B,0
SBHIHIT3	.long	SBHIHIT3A,SBHIHIT3B,0

;**************************************************************************

a_hit_lo
	.long	SBLOHIT2
	.long	SBLOHIT3
	.long	SBLOHIT2
	.long	SBLOHIT1
	.long	0

SBLOHIT1	.long	SBLOHIT1A,SBLOHIT1B,0
SBLOHIT2	.long	SBLOHIT2A,SBLOHIT2B,0
SBLOHIT3	.long	SBLOHIT3A,SBLOHIT3B,0

;**************************************************************************

a_knockdown
	.long	SBKNOCKDOWN1
	.long	SBKNOCKDOWN2
	.long	SBKNOCKDOWN3
	.long	SBKNOCKDOWN4
	.long	SBKNOCKDOWN5
	.long	0

	.long	SBKNOCKDOWN6
	.long	SBKNOCKDOWN7
	.long	0

SBKNOCKDOWN1
	.long	SBKNOCKDOWN1A,0
SBKNOCKDOWN2
	.long	SBKNOCKDOWN2A,0
	.long	0
SBKNOCKDOWN3
	.long	SBKNOCKDOWN3A,SBKNOCKDOWN3B,0
SBKNOCKDOWN4
	.long	SBKNOCKDOWN4A,SBKNOCKDOWN4B,0
SBKNOCKDOWN5
	.long	SBKNOCKDOWN5A,SBKNOCKDOWN5B,0
SBKNOCKDOWN6
	.long	SBKNOCKDOWN6A,0
SBKNOCKDOWN7
	.long	SBKNOCKDOWN7A,0

;**************************************************************************

a_getup
	.long	SBGETUP1
	.long	SBGETUP2
	.long	SBGETUP3
	.long	SBGETUP4
	.long	SBGETUP5
	.long	SBGETUP6
	.long	0

SBGETUP1	.long	SBGETUP1A,0
SBGETUP2	.long	SBGETUP2A,0
SBGETUP3	.long	SBGETUP3A,0
SBGETUP4	.long	SBGETUP4A,SBGETUP4B,0
SBGETUP5	.long	SBGETUP5A,0
SBGETUP6	.long	SBGETUP6A,SBGETUP6B,0

;**************************************************************************

a_throw
	.long	SBFLIP1
	.long	0

	.long	SBFLIP2
	.long	SBFLIP3		; both animate together
	.long	SBFLIP4
	.long	SBFLIP5
	.long	SBFLIP6
	.long	0

	.long	SBFLIP5
	.long	SBFLIP4
	.long	0

SBFLIP1	.long	SBFLIP1A,SBFLIP1B,0
SBFLIP2	.long	SBFLIP2A,SBFLIP2B,0
SBFLIP3	.long	SBFLIP3A,SBFLIP3B,0
SBFLIP4	.long	SBFLIP4A,SBFLIP4B,0
SBFLIP5	.long	SBFLIP5A,0
SBFLIP6	.long	SBFLIP6A,0

;**************************************************************************

a_afb_kano
	.long	ani_offset_xy
	.word	-029H,-003H
	.long	SBKNOCKDOWN1

	.long	ani_offset_xy
	.word	-02dH,005H
	.long	SBKNOCKDOWN3

	.long	ani_offset_xy
 	.word	-036H,014H
	.long	SBKNOCKDOWN4

	.long	0
*
* fall down solo
*
	.long	SBKNOCKDOWN4
	.long	SBKNOCKDOWN5
	.long	SBKNOCKDOWN6
	.long	SBKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	-019H,-03bH
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	016H,-052H
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	037H,-040H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	04fH,-026H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	066H,-017H
	.long	SBKNOCKDOWN6
	.long	ani_offset_xy
	.word	078H,00fH
	.long	SBKNOCKDOWN6
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	-01dH,01aH
	.long	SBSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	000H,033H
	.long	SBSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	-022H,01dH
	.long	SBFLIPPED1		; 3
	.long	ani_offset_xy
	.word	-046H,-00fH
	.long	SBFLIPPED2		; 4
	.long	ani_offset_xy
	.word	-02cH,-057H
	.long	SBFLIPPED3		; 5
	.long	ani_offset_xy
	.word	014H,-06dH
	.long	SBFLIPPED4		; 6
	.long	ani_offset_xy
	.word	04fH,-070H
	.long	SBFLIPPED5		; 7
	.long	ani_offset_xy
	.word	05aH,-056H
	.long	SBFLIPPED5		; 8
	.long	ani_offset_xy
	.word	077H,002H
	.long	SBFLIPPED5		; 9
	.long	ani_offset_xy
	.word	077H,052H
	.long	SBFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	-06eH,000H
	.long	SBFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-05dH,-04aH
	.long	SBFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-00cH,-081H
	.long	SBFLIPPED3		; 3
	.long	ani_offset_xy
	.word	040H,-057H
	.long	SBFLIPPED4		; 4
	.long	ani_offset_xy
	.word	04cH,-020H
	.long	SBFLIPPED5		; 5

	.long	ani_offset_xy
	.word	016H,019H
	.long	SBFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-01fH,-014H
  	.long	SBKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	-06cH,-005H
	.long	SBFLIPPED1		; 8
	.long	ani_offset_xy
	.word	-051H,-05fH
	.long	SBFLIPPED2		; 9
	.long	ani_offset_xy
	.word	026H,-072H
	.long	SBFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	072H,-00fH
	.long	SBFLIPPED5		; 11
	.long	ani_offset_xy
	.word	06bH,-001H
  	.long	SBKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	-03dH,-030H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-008H,-052H
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	-001H,-05eH
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	018H,-04fH
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	01aH,-035H
	.long	SBFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	-015H,-009H
  	.long	SBKNOCKDOWN7
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	-04cH,000H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-041H,007H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-02aH,001H
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	-007H,003H
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	00eH,025H
	.long	SBFLIPPED4

	.long	ani_offset_xy
	.word	-00fH,-004H
	.long	SBKNOCKDOWN6
	.long	ani_offset_xy
	.word	-023H,-004H
	.long	SBKNOCKDOWN6
	.long	ani_offset_xy
	.word	-038H,-004H
	.long	SBKNOCKDOWN6

	.long	ani_offset_xy
	.word	-060H,019H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-067H,-00bH
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-03cH,-04cH
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	02bH,-041H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	04cH,-018H
	.long	SBFLIPPED5
	.long	ani_offset_xy
	.word	05bH,-008H
	.long	SBKNOCKDOWN6
	.long	0



a_fb_lk
	.long	ani_offset_xy
	.word	-03dH,-001H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-03bH,007H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-013H,002H
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	01dH,000H
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	03eH,003H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	088H,-01fH
	.long	SBFLIPPED4
	.long	0

	.long	SBFLIPPED5
	.long	SBKNOCKDOWN5
	.long	SBKNOCKDOWN6
	.long	SBKNOCKDOWN7
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	-031H,-015H			; we need even # of words here !
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-00cH,-037H
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	051H,-037H
	.long	SBFLIPPED3
	.long	0

	.long	SBFLIPPED4
	.long	SBFLIPPED5
	.long	SBKNOCKDOWN4
	.long	SBKNOCKDOWN5
	.long	0

a_fb_sonya
	.long	ani_offset_xy
	.word	-01eH-8,000H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	003H-8,-003H
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	034H-8,-01aH
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	076H-8,-021H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	0c0H-8,-026H
	.long	SBFLIPPED4
	.long	0

	.long	SBFLIPPED5
	.long	SBKNOCKDOWN4
	.long	SBKNOCKDOWN5
	.long	0

a_fb_jax
	.long	ani_offset_xy
	.word	-039H,-020H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-01aH,-043H
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	01dH,-051H
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	04eH,-026H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	05aH,010H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	054H,009H
	.long	SBKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	-053H,-022H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-03cH,-044H
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	-009H,-05aH
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	032H,-049H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	054H,-033H
	.long	SBKNOCKDOWN6
	.long	ani_offset_xy
	.word	060H,000H
	.long	SBKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	-043H,-040H
	.long	SBFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	052H,-02eH
	.long	SBFLIPPED5

	.long	ani_offset_xy
	.word	040H,-003H
	.long	SBFLIPPED5

	.long	ani_offset_xy
	.word	002H,-004H
	.long	SBKNOCKDOWN5

	.long	ani_offset_xy
	.word	-03aH,-036H
	.long	SBKNOCKDOWN5

	.long	ani_offset_xy
	.word	-060H,-05bH
	.long	SBKNOCKDOWN5
	.long	0

a_fb_swat
	.long	ani_offset_xy
	.word	-046H,-016H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-036H,-04fH
	.long	SBFLIPPED2
	.long	ani_offset_xy
	.word	034H,-056H
	.long	SBFLIPPED3
	.long	ani_offset_xy
	.word	066H,-01dH
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	056H,004H
	.long	SBKNOCKDOWN6
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	-064H,000H
	.long	SBSTUMBLE1
	.long	ani_offset_xy
	.word	-073H,003H
	.long	SBSTUMBLE1

	.long	ani_offset_xy
	.word	-075H,-01eH
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-057H,-03dH
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	-023H,-046H
	.long	SBFLIPPED1
	.long	ani_offset_xy
	.word	01eH,-04eH
	.long	SBFLIPPED1

	.long	ani_offset_xy
	.word	0a8H,012H
	.long	SBFLIPPED4
	.long	ani_offset_xy
	.word	08dH,000H
	.long	SBKNOCKDOWN7
	.long	0

a_fb_robo
	.long	ani_offset_xy
	.word	-048H,-011H
	.long	SBFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-04aH,-03cH
	.long	SBFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-035H,-055H
	.long	SBFLIPPED2		; 3

	.long	ani_offset_xy
	.word	005H,-070H
	.long	SBFLIPPED3		; 4
	.long	ani_offset_xy
	.word	03cH,-068H
	.long	SBFLIPPED4		; 5
	.long	ani_offset_xy
	.word	065H,-054H
	.long	SBFLIPPED4		; 6

	.long	ani_offset_xy
	.word	080H,-020H
	.long	SBFLIPPED5		; 7
	.long	ani_offset_xy
	.word	068H,-010H
	.long	SBKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	-023H,-007H
	.long	SBSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	-024H,-022H
	.long	SBFLIPPED1		; 2
	.long	ani_offset_xy
	.word	-009H,-02fH
	.long	SBFLIPPED2		; 3
	.long	ani_offset_xy
	.word	020H,-027H
	.long	SBFLIPPED3		; 4
	.long	ani_offset_xy
	.word	030H,-005H
	.long	SBFLIPPED4		; 5
	.long	ani_offset_xy
	.word	01eH,000H
	.long	SBFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-00eH,-010H
	.long	SBKNOCKDOWN7		; 7
	.long	0



a_legged
	.long	ani_offset_xy
	.word	-050H-8,003H
	.long	SBKNOCKDOWN1

	.long	ani_offset_xy
	.word	-03bH-8,-029H
	.long	SBFLIPPED1

	.long	ani_offset_xy
	.word	001H-8,-04aH
	.long	SBFLIPPED3

	.long	ani_offset_xy
	.word	03fH-8,-026H
	.long	SBFLIPPED4

	.long	ani_offset_xy
	.word	077H-8,000H
	.long	SBFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	061H,-022H
	.long	SBKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	057H,001H
	.long	SBKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	027H,009H
	.long	SBKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	-030H,012H
	.long	SBKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	-085H,-00dH
	.long	SBFLIPPED1	; 5

	.long	ani_offset_xy
	.word	-029H,-05cH
	.long	SBFLIPPED3	; 6
	.long	0

	.long	SBFLIPPED3
	.long	SBFLIPPED4
	.long	SBFLIPPED5
	.long	SBKNOCKDOWN5
	.long	SBKNOCKDOWN6
	.long	SBKNOCKDOWN7
	.long	0

a_shook
	.long	ani_offset_xy
	.word	-04dH,-013H
	.long	SBSTUMBLE1	; 3

	.long	ani_offset_xy
	.word	-034H,-02bH
	.long	SBSTUMBLE1	; 4

	.long	ani_offset_xy
	.word	-01aH,-024H
	.long	SBSTUMBLE1	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	-01dH,-024H
	.long	SBSTUMBLE1	; 6

	.long	ani_offset_xy
	.word	-036H,-032H
	.long	SBSTUMBLE1	; 7

	.long	ani_offset_xy
	.word	-040H,-032H	
	.long	SBSTUMBLE1	; 8

	.long	ani_offset_xy
	.word	-036H,-032H
	.long	SBSTUMBLE1	; 7
	.long	0


SBFLIPPED1
	.long	SBFLIPPED1A,0
SBFLIPPED2
	.long	SBFLIPPED2A,SBFLIPPED2B,0
SBFLIPPED3
	.long	SBFLIPPED3A,SBFLIPPED3B,0
SBFLIPPED4
	.long	SBFLIPPED4A,SBFLIPPED4B,0
SBFLIPPED5
	.long	SBFLIPPED5A,0

;**************************************************************************

a_sweepup
	.long	SBSWEEPUP1
	.long	SBSWEEPUP2
	.long	SBSWEEPUP3
	.long	SBSWEEPUP4
	.long	SBSWEEPUP5
	.long	0

SBSWEEPUP1
	.long	SBSWEEPUP1A,SBSWEEPUP1B,0
SBSWEEPUP2
	.long	SBSWEEPUP2A,SBSWEEPUP2B,0
SBSWEEPUP3
	.long	SBSWEEPUP3A,0
SBSWEEPUP4
	.long	SBSWEEPUP4A,SBSWEEPUP4B,0
SBSWEEPUP5
	.long	SBSWEEPUP5A,SBSWEEPUP5B,0

;**************************************************************************

a_sweep_fall
	.long	SBSWEEPFALL1
	.long	SBSWEEPFALL2
	.long	SBSWEEPFALL3
	.long	SBSWEEPFALL4
	.long	SBSWEEPFALL5
	.long	0
	.long	SBSWEEPFALL6
	.long	0

SBSWEEPFALL1
	.long	SBSWEEPFALL1A,SBSWEEPFALL1B,0
	.long	0
SBSWEEPFALL2
	.long	SBSWEEPFALL2A,SBSWEEPFALL2B,0
SBSWEEPFALL3
	.long	SBSWEEPFALL3A,SBSWEEPFALL3B,0
SBSWEEPFALL4
	.long	SBSWEEPFALL4A,SBSWEEPFALL4B,0
SBSWEEPFALL5
	.long	SBSWEEPFALL5A,0
	.long	0
SBSWEEPFALL6
	.long	SBSWEEPFALL6A,SBSWEEPFALL6B,0
	.long	0

;**************************************************************************

a_dizzy
	.long	SBSTUNNED1
	.long	SBSTUNNED2
	.long	SBSTUNNED3
	.long	SBSTUNNED4
	.long	SBSTUNNED5
	.long	SBSTUNNED6
	.long	SBSTUNNED7
	.long	ani_jump,a_dizzy

SBSTUNNED1
	.long	SBSTUNNED1A,SBSTUNNED1B,0
SBSTUNNED2
	.long	SBSTUNNED2A,SBSTUNNED2B,0
SBSTUNNED3
	.long	SBSTUNNED3A,SBSTUNNED3B,0
SBSTUNNED4
	.long	SBSTUNNED4A,SBSTUNNED4B,0
SBSTUNNED5
	.long	SBSTUNNED5A,SBSTUNNED5B,0
SBSTUNNED6
	.long	SBSTUNNED6A,SBSTUNNED6B,0
SBSTUNNED7
	.long	SBSTUNNED7A,SBSTUNNED7B,0

;**************************************************************************

a_leg_grab
	.long	ani_adjustx
	.word	12
	.long	SBLEGTHRO1

	.long	ani_adjustx
	.word	12
	.long	SBLEGTHRO2

	.long	ani_adjustxy
	.word	12,0		; this zero is so we have even longwords
	.long	SBLEGTHRO3
	.long	SBLEGTHRO4
	.long	SBLEGTHRO5
	.long	SBLEGTHRO6
	.long	SBLEGTHRO7
	.long	0

	.long	SBLEGTHRO7
	.long	SBLEGTHRO6
	.long	SBLEGTHRO5
	.long	SBLEGTHRO4
	.long	SBLEGTHRO3
	.long	0

	.long	SBLEGTHRO2
	.long	SBLEGTHRO1
	.long	0


SBLEGTHRO1
	.long	SBLEGTHRO1A,SBLEGTHRO1B,SBLEGTHRO1C,0
SBLEGTHRO2
	.long	SBLEGTHRO2A,SBLEGTHRO2B,SBLEGTHRO2C,0
SBLEGTHRO3
	.long	SBLEGTHRO3A,SBLEGTHRO3B,0
SBLEGTHRO4
	.long	SBLEGTHRO4A,SBLEGTHRO4B,0
SBLEGTHRO5
	.long	SBLEGTHRO5A,SBLEGTHRO5B,0
SBLEGTHRO6
	.long	SBLEGTHRO6A,SBLEGTHRO6B,0
SBLEGTHRO7
	.long	SBLEGTHRO7A,SBLEGTHRO7B,0

;**********************************************************************

a_run	.long	SBRUN1
	.long	SBRUN2

run_loop
	.long	SBRUN3
	.long	SBRUN4
	.long	SBRUN5
	.long	ani_calla,rsnd_footstep
	.long	SBRUN6
	.long	SBRUN7
	.long	SBRUN8
	.long	SBRUN9
	.long	SBRUN10
	.long	ani_calla,rsnd_footstep
	.long	SBRUN11
	.long	ani_jump,run_loop

SBRUN1	.long	SBRUN1A,0
SBRUN2	.long	SBRUN2A,0
SBRUN3	.long	SBRUN3A,SBRUN3B,0
SBRUN4	.long	SBRUN4A,SBRUN4B,0
SBRUN5	.long	SBRUN5A,0
SBRUN6	.long	SBRUN6A,0
SBRUN7	.long	SBRUN7A,SBRUN7B,0
SBRUN8	.long	SBRUN8A,SBRUN8B,0
SBRUN9	.long	SBRUN9A,0
SBRUN10	.long	SBRUN10A,0
SBRUN11	.long	SBRUN11A,0

;**********************************************************************

a_hikick
	.long	SBLOKICK2
	.long	SBLOKICK3
	.long	SBHIKICK1
	.long	SBHIKICK2
	.long	SBHIKICK3
	.long	SBHIKICK4
	.long	0
	.long	SBHIKICK3
	.long	SBHIKICK2
	.long	SBHIKICK1
	.long	SBLOKICK3
	.long	SBLOKICK2
	.long	0

a_lokick
	.long	SBLOKICK1 
	.long	SBLOKICK2
	.long	SBLOKICK3
	.long	SBLOKICK4
	.long	SBLOKICK5
	.long	SBLOKICK6
	.long	0
	.long	SBLOKICK5
	.long	SBLOKICK4
	.long	SBLOKICK3
	.long	SBLOKICK2
	.long	SBLOKICK1
	.long	0

SBLOKICK1
	.long	SBLOKICK1A,SBLOKICK1B,0
SBLOKICK2
	.long	SBLOKICK2A,0
SBLOKICK3
	.long	SBLOKICK3A,SBLOKICK3B,0
SBLOKICK4
	.long	SBLOKICK4A,SBLOKICK4B,0
SBLOKICK5
	.long	SBLOKICK5A,0
SBLOKICK6
	.long	SBLOKICK6A,0
SBHIKICK1
	.long	SBHIKICK1A,SBHIKICK1B,0
SBHIKICK2
	.long	SBHIKICK2A,0
SBHIKICK3
	.long	SBHIKICK3A,0
SBHIKICK4
	.long	SBHIKICK4A,SBHIKICK4B,0

;**************************************************************************

a_knee
	.long	SBKNEEKICK1
	.long	SBKNEEKICK2
	.long	SBKNEEKICK3
	.long	0
	.long	SBKNEEKICK2
	.long	SBKNEEKICK1
	.long	0

SBKNEEKICK1
	.long	SBKNEEKICK1A,SBKNEEKICK1B,0
SBKNEEKICK2
	.long	SBKNEEKICK2A,0
SBKNEEKICK3
	.long	SBKNEEKICK3A,0

;**************************************************************************

a_sweep_kick
	.long	SBSWEEPKICK1
	.long	SBSWEEPKICK2
	.long	SBSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	SBSWEEPKICK4
	.long	SBSWEEPKICK5
	.long	0

	.long	SBSWEEPKICK6
	.long	SBSWEEPKICK7
	.long	0

SBSWEEPKICK1
	.long	SBSWEEPKICK1A,SBSWEEPKICK1B,0
SBSWEEPKICK2
	.long	SBSWEEPKICK2A,SBSWEEPKICK2B,0
SBSWEEPKICK3
	.long	SBSWEEPKICK3A,0
SBSWEEPKICK4
	.long	SBSWEEPKICK4A,0
SBSWEEPKICK5
	.long	SBSWEEPKICK5A,SBSWEEPKICK5B,0
SBSWEEPKICK6
	.long	SBSWEEPKICK6A,0
SBSWEEPKICK7
	.long	SBSWEEPKICK7A,SBSWEEPKICK7B,0

;**************************************************************************

a_roundhouse
	.long	SBSPINKICK1
	.long	SBSPINKICK2
	.long	SBSPINKICK3
	.long	0

	.long	SBSPINKICK4
	.long	SBSPINKICK5
	.long	SBSPINKICK6
	.long	SBSPINKICK7
	.long	SBSPINKICK8
	.long	0

SBSPINKICK1
	.long	SBSPINKICK1A,SBSPINKICK1B,0
SBSPINKICK2
	.long	SBSPINKICK2A,0
SBSPINKICK3
	.long	SBSPINKICK3A,0
SBSPINKICK4
	.long	SBSPINKICK4A,SBSPINKICK4B,0
SBSPINKICK5
	.long	SBSPINKICK5A,0
SBSPINKICK6
	.long	SBSPINKICK6A,SBSPINKICK6B,0
SBSPINKICK7
	.long	SBSPINKICK7A,SBSPINKICK7B,0
SBSPINKICK8
	.long	SBSPINKICK8A,SBSPINKICK8B,0

;**********************************************************************

a_victory
	.long	SBVICTORY1
	.long	SBVICTORY2
	.long	SBVICTORY3
	.long	0

	.long	SBVICTORY4
	.long	SBVICTORY5
	.long	SBVICTORY6
	.long	SBVICTORY7
	.long	SBVICTORY8
	.long	0

SBVICTORY1
	.long	SBVICTORY1A,SBVICTORY1B,0
SBVICTORY2
	.long	SBVICTORY2A,0
SBVICTORY3
	.long	SBVICTORY3A,SBVICTORYLEG1A,0
SBVICTORY4
	.long	SBVICTORY4A,SBVICTORYLEG1A,0
SBVICTORY5
	.long	SBVICTORY5A,0
SBVICTORY6
	.long	SBVICTORY6A,SBVICTORY6B,0
SBVICTORY7
	.long	SBVICTORY7A,SBVICTORY7B,0
SBVICTORY8
	.long	SBVICTORY8A,SBVICTORY8B,0

;*************************************************************************

a_zap
	.long	ani_calla,sonya_zap_pal
	.long	SBENG1
	.long	SBENG2
	.long	SBENG3
	.long	SBENG4
	.long	ani_sladd,SBENG5  	; introducing ---> SBENG5 obj
	.long	ani_calla,player_normpal
	.long	SBTHROWPRO4
	.long	0

	.long	SBENG1
	.long	SBENG2
	.long	SBENG3
	.long	SBENG4
	.long	0

a_sonya_drop
	.long	SBDROP01
	.long	SBDROP02
	.long	SBDROP03
	.long	SBDROP04
	.long	SBDROP05
	.long	SBDROP5B
	.long	0
	.long	SBDROP06
	.long	SBDROP07
	.long	SBDROP08
	.long	SBDROP09
	.long	SBDROP10
	.long	SBDROP11
	.long	SBDROP12
	.long	SBDROP13
	.long	0

SBENG1	.long	SBENG1A,SBENG1B,0
SBENG2	.long	SBENG2A,SBENG2B,0
SBENG3	.long	SBENG3A,SBENG3B,0
SBENG4	.long	SBENG4A,SBENG4B,0
SBENG5	.long	SBENG5A,0

SBTHROWPRO1
	.long	SBTHROWPRO1A,SBTHROWPRO1B,0
SBTHROWPRO2
	.long	SBTHROWPRO2A,SBTHROWPRO2B,0
SBTHROWPRO3
	.long	SBTHROWPRO3A,SBTHROWPRO3B,0
SBTHROWPRO4
	.long	SBTHROWPRO4A,SBTHROWPRO4B,0

;*************************************************************************

a_projectile

a_proj_loop
	.long	SBZAP6
	.long	SBZAP7
	.long	SBZAP8
	.long	SBZAP9
	.long	ani_jump,a_proj_loop
	.long	0

	.long	SBZAP10
	.long	SBZAP11
	.long	SBZAP12
	.long	SBZAP13
	.long	SBZAP14
	.long	SBZAP15
	.long	SBZAP16
	.long	0

SBZAP6
	.long	SBZAP6A,0
SBZAP7
	.long	SBZAP7A,0
SBZAP8
	.long	SBZAP8A,0
SBZAP9
	.long	SBZAP9A,0
SBZAP10
	.long	SBZAP10A,0
SBZAP11
	.long	SBZAP11A,0
SBZAP12
	.long	SBZAP12A,SBZAP12B,SBZAP12C,SBZAP12D
	.long	SBZAP12E,0
SBZAP13
	.long	SBZAP13A,SBZAP13B,SBZAP13C,SBZAP13D
	.long	SBZAP13E,SBZAP13F,SBZAP13G,0
SBZAP14
	.long	SBZAP14A,SBZAP14B,SBZAP14C,SBZAP14D
	.long	SBZAP14E,SBZAP14F,0
SBZAP15
	.long	SBZAP15A,SBZAP15B,SBZAP15C,SBZAP15D,0
SBZAP16
	.long	SBZAP16A,SBZAP16B,0

;************************************************************************

a_bike
	.long	ani_calla,sans_repell_3
	.long	ani_adjustxy
	.word	005H,00aH
	.long	SBBIKE1

	.long	ani_calla,sans_repell_3
	.long	ani_adjustxy
	.word	005H,00aH
	.long	SBBIKE2

	.long	ani_calla,sans_repell_3
	.long	ani_adjustxy
	.word	005H,00aH
	.long	SBBIKE3
	.long	0

j_bike	.long	SBBIKE4
	.long	SBBIKE5
	.long	SBBIKE6
	.long	SBBIKE7
	.long	SBBIKE8
	.long	SBBIKE9
	.long	SBBIKE8
	.long	SBBIKE7
	.long	SBBIKE6
	.long	SBBIKE5
	.long	ani_jump,j_bike
	.long	0

	.long	SBBIKE3
	.long	SBBIKE2
	.long	SBBIKE1
	.long	0

SBBIKE1	.long	SBBIKE1A,0
SBBIKE2	.long	SBBIKE2A,SBBIKE2B,0
SBBIKE3	.long	SBBIKE3A,SBBIKE3B,0
SBBIKE4	.long	SBBIKE4A,0
SBBIKE5	.long	SBBIKE5A,0
SBBIKE6	.long	SBBIKE6A,0
SBBIKE7	.long	SBBIKE7A,0
SBBIKE8	.long	SBBIKE8A,0
SBBIKE9	.long	SBBIKE9A,0

;************************************************************************

a_scared
	.long	SBSCARED2
	.long	0

SBSCARED2
	.long	SBSCARED2A,0

;************************************************************************

a_thudd
	.long	SBTHUD1
	.long	SBTHUD2
	.long	SBTHUD3
	.long	SBTHUD4
	.long	SBTHUD5
	.long	SBTHUD6
	.long	0

SBTHUD1	.long	SBTHUD1A,0
SBTHUD2	.long	SBTHUD2A,0
SBTHUD3	.long	SBTHUD3A,0
SBTHUD4	.long	SBTHUD4A,0
SBTHUD5	.long	SBTHUD5A,0
SBTHUD6	.long	SBTHUD6A,0

;************************************************************************

a_death_kiss
	.long	SBDEATHKISS1
	.long	SBDEATHKISS2
	.long	SBDEATHKISS3
	.long	SBDEATHKISS4
	.long	SBDEATHKISS5
	.long	SBDEATHKISS6
	.long	SBDEATHKISS7
	.long	SBDEATHKISS8
	.long	SBDEATHKISS9
	.long	SBDEATHKISS10
	.long	SBDEATHKISS11
	.long	0
*
* part 2 = orb
*
	.long	SPARKISS1
	.long	SPARKISS2
	.long	KISSORB1
	.long	KISSORB2
	.long	KISSORB3
	.long	KISSORB4
	.long	KISSORB5
	.long	KISSORB6
	.long	KISSORB7
	.long	KISSORB8
	.long	KISSORB9

j_orb	.long	KISSORB10
	.long	KISSORB11
	.long	KISSORB12
	.long	KISSORB13
	.long	KISSORB14
	.long	KISSORB15
	.long	KISSORB16
	.long	ani_jump,j_orb
	.long	0


a_sonya_energy_ball
	.long	SBALL1
	.long	SBALL2
	.long	SBALL3
	.long	SBALL4
	.long	SBALL5
	.long	SBALL6
	.long	SBALL7
	.long	0

j_sball	.long	SBALL8
	.long	SBALL9
	.long	SBALL10
	.long	SBALL11
	.long	ani_jump,j_sball
	.long	0

	.long	SBALL12
	.long	SBALL13
	.long	SBALL14		; crush
	.long	0

	.long	SBALL15
	.long	0

;	.long	SBALL16
;	.long	SBALL17
;	.long	SBALL18
;	.long	0

;*******************************************************************
; Cuz we dont wanna regenerate a LOD file and change masked roms !
;*******************************************************************

FAKE_ENGBALL1:
	.word   31,27,-71,-47
	.long   064427c6H
	.word   04080H
	.long	ENGPINK_P
ENGPINK_P:
   .word   32 
   .word   00000h,07effh,07e9eh,07e3dh,07ddch,07d9bh,07d59h,07d17h
   .word   07cd5h,078b4h,07494h,07073h,07073h,06c52h,06832h,06432h
   .word   06012h,05c12h,05813h,05413h,05413h,05013h,04c13h,04813h
   .word   04412h,03c11h,03811h,03410h,0300fh,02c0eh,0280eh,0240dh


FAKE_GUTS:
	.word   88,36,-128,-113
	.long   064ce4a9H
	.word   06680H
	.long	GUTS_P

GUTS_P:
   .word   64 
   .word   0001fh,07378h,072b3h,06e92h,05ab7h,06671h,06251h,06250h
   .word   05e30h,069cdh,05a30h,05a0fh,0560fh,055efh,051eeh,04dceh
   .word   04dcdh,049cdh,04a12h,049adh,045adh,045ach,039afh,0458ch
   .word   0418ch,0358eh,03d6ch,03d6bh,0396bh,0316dh,0394bh,0354ah
   .word   02d4ch,0352ah,03908h,0312ah,03129h,02d29h,0292bh,02d09h
   .word   02909h,028e8h,024e8h,024c8h,020c7h,01cc7h,01ca7h,01ca6h
   .word   018a6h,01886h,01486h,01485h,01087h,01065h,00c65h,01803h
   .word   07000h,06400h,05000h,04800h,03800h,03842h,05c00h,03000h

;*******************************************************************
; Cuz we dont wanna regenerate a LOD file and change masked roms !
;*******************************************************************


SBALL1	.long	FAKE_ENGBALL1,0
SBALL2	.long	ENGBALL2,0
SBALL3	.long	ENGBALL3,0
SBALL4	.long	ENGBALL4,0
SBALL5	.long	ENGBALL5,0
SBALL6	.long	ENGBALL6,0
SBALL7	.long	ENGBALL7,0
SBALL8	.long	ENGBALL8,0
SBALL9	.long	ENGBALL9,0
SBALL10	.long	ENGBALL10,0
SBALL11	.long	ENGBALL11,0
SBALL12	.long	ENGBALL12,0
SBALL13	.long	ENGBALL13,0
SBALL14	.long	ENGBALL14,0
;SBALL15A	.long	ENGBALL15A,0
SBALL15	.long	ENGBALL15B,0
SBALL16	.long	ENGBALL16,0
SBALL17	.long	ENGBALL17,0
SBALL18	.long	ENGBALL18,0


a_gutz
	.long	ani_swpal
	.long	SGUTZ
	.long	0

SGUTZ	.long	FAKE_GUTS,0


SBDEATHKISS1
	.long	SBDEATHKISS1A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS2
	.long	SBDEATHKISS2A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS3
	.long	SBDEATHKISS3A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS4
	.long	SBDEATHKISS4A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS5
	.long	SBDEATHKISS5A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS6
	.long	SBDEATHKISS6A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS7
	.long	SBDEATHKISS7A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS8
	.long	SBDEATHKISS8A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS9
	.long	SBDEATHKISS9A,SBDEATHLEG1A,SBDEATHLEG1B,0
SBDEATHKISS10
	.long	SBDEATHKISS10A,SBDEATHKISS10B,0
SBDEATHKISS11
	.long	SBDEATHKISS11A,SBDEATHKISS11B,0


;SBFRIENDSHIP1
;	.long	SBFRIENDSHIP1A,SBFRIENDSHIP1B,0
;SBFRIENDSHIP2
;	.long	SBFRIENDSHIP2A,SBFRIENDSHIP2B,SBFRIENDSHIP2C,0
;SBFRIENDLEG1
;	.long	SBFRIENDLEG1A,SBFRIENDLEG1B,0
;SBFRIENDSHIP3
;	.long	SBFRIENDSHIP3A,SBFRIENDSHIP3B,0
;SBFRIENDSHIP4
;	.long	SBFRIENDSHIP4A,SBFRIENDSHIP4B,0
;SBFRIENDSHIP5
;	.long	SBFRIENDSHIP5A,SBFRIENDSHIP5B,0
;SBFRIENDSHIP6
;	.long	SBFRIENDSHIP6A,SBFRIENDSHIP6B,0
;SBFRIENDSHIP7
;	.long	SBFRIENDSHIP7A,0
;SBFRIENDSHIP8
;	.long	SBFRIENDSHIP8A,0
;SBFRIENDSHIP9
;	.long	SBFRIENDSHIP9A,0
;SBFRIENDSHIP10
;	.long	SBFRIENDSHIP10A,0
;SBFRIENDSHIP11
;	.long	SBFRIENDSHIP11A,0


a_square
	.long	SBFLIPUNCH1
	.long	SBFLIPUNCH2
	.long	SBAIRPUNCH1
	.long	0

SBAIRPUNCH1
	.long	SBAIRPUNCH1A,a0

;***************************************************************

	.end
