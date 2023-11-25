**************************************************************************
*											     *
*  mk3 - Swat Guy										*
*											     *
**************************************************************************
	.FILE	"mkswat.asm"
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mkswat.tbl
	.include mkswat2.tbl
	.include mkswat3.tbl
	.include mainequ.asm
	.include imgtbl.glo

	.text

swat_anitab1
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


swat_anitab2
	.long	a_throw_bomb	; 0
	.long	a_zoom		; 1
	.long	a_stick_sweep	; 2
	.long	a_taser		; 3
	.long	a_set_bomb	; 4

a_projectile
a_dummy

;*************************************************************************

a_stance
	.long	OBSTANCE1
	.long	OBSTANCE2
	.long	OBSTANCE3
	.long	OBSTANCE4
	.long	OBSTANCE5
	.long	OBSTANCE6
	.long	OBSTANCE7
	.long	ani_jump,a_stance

OBSTANCE1
	.long	OBSTANCE1A,OBSTANCE1B,0
OBSTANCE2
	.long	OBSTANCE2A,OBSTANCE2B,0
OBSTANCE3
	.long	OBSTANCE3A,OBSTANCE3B,0
OBSTANCE4
	.long	OBSTANCE4A,OBSTANCE4B,0
OBSTANCE5
	.long	OBSTANCE5A,OBSTANCE5B,0
OBSTANCE6
	.long	OBSTANCE6A,OBSTANCE6B,0
OBSTANCE7
	.long	OBSTANCE7A,OBSTANCE7B,0

a_run	.long	OBRUN1
	.long	OBRUN2
	.long	OBRUN3
	.long	OBRUN4
	.long	ani_calla,rsnd_footstep
	.long	OBRUN5
	.long	OBRUN6
	.long	OBRUN7
	.long	OBRUN8
	.long	OBRUN9
	.long	OBRUN10
	.long	ani_calla,rsnd_footstep
	.long	OBRUN11
	.long	OBRUN12
	.long	ani_jump,a_run
	.long	0			; we need this zero !!

OBRUN1	.long	OBRUN1A,0
OBRUN2	.long	OBRUN2A,OBRUN2B,0
OBRUN3	.long	OBRUN3A,OBRUN3B,0
OBRUN4	.long	OBRUN4A,OBRUN4B,0
OBRUN5	.long	OBRUN5A,0
OBRUN6	.long	OBRUN6A,0
OBRUN7	.long	OBRUN7A,0
OBRUN8	.long	OBRUN8A,OBRUN8B,0
OBRUN9	.long	OBRUN9A,OBRUN9B,0
OBRUN10	.long	OBRUN10A,OBRUN10B,0
OBRUN11	.long	OBRUN11A,0
OBRUN12	.long	OBRUN12A,0

;*************************************************************************

a_walkf
	.long	OBWALK1
	.long	OBWALK2
	.long	OBWALK3
	.long	OBWALK4
	.long	OBWALK5
	.long	OBWALK6
	.long	OBWALK7
	.long	OBWALK8
	.long	OBWALK9
	.long	ani_jump,a_walkf

a_walkb
	.long	OBWALK9
	.long	OBWALK8
	.long	OBWALK7
	.long	OBWALK6
	.long	OBWALK5
	.long	OBWALK4
	.long	OBWALK3
	.long	OBWALK2
	.long	OBWALK1
	.long	ani_jump,a_walkb

OBWALK1	.long	OBWALKLEG1A,OBWALKLEG1B,OBWALKTORSO1A,0
OBWALK2	.long	OBWALKLEG2A,OBWALKTORSO2A,0
OBWALK3	.long	OBWALKLEG3A,OBWALKTORSO3A,0
OBWALK4	.long	OBWALKLEG4A,OBWALKLEG4B,OBWALKTORSO4A,0
OBWALK5	.long	OBWALKLEG5A,OBWALKLEG5B,OBWALKTORSO5A,0
OBWALK6	.long	OBWALKLEG6A,OBWALKTORSO6A,0
OBWALK7	.long	OBWALKLEG7A,OBWALKTORSO7A,0
OBWALK8	.long	OBWALKLEG8A,OBWALKLEG8B,OBWALKTORSO8A,0
OBWALK9	.long	OBWALKLEG9A,OBWALKLEG9B,OBWALKTORSO9A,0

;*************************************************************************

a_turn
	.long	OBTURN1
	.long	OBTURN2
	.long	ani_flip
	.long	OBTURN1
	.long	0

OBTURN1	.long	OBTURN1A,OBTURN1B,0
OBTURN2	.long	OBTURN2A,OBTURN2B,0

;*************************************************************************

a_duck
	.long	OBDUCK1
	.long	OBDUCK2
	.long	OBDUCK3
	.long	0

OBDUCK1	.long	OBDUCK1A,OBDUCK1B,0
OBDUCK2	.long	OBDUCK2A,OBDUCK2B,0
OBDUCK3	.long	OBDUCK3A,OBDUCK3B,0

;*************************************************************************

a_duck_turn
	.long	OBDUCKTURN1
	.long	OBDUCKTURN2
	.long	ani_flip
	.long	OBDUCKTURN2
	.long	OBDUCKTURN1
	.long	OBDUCK3
	.long	0

OBDUCKTURN1
	.long	OBDUCKTURN1A,OBDUCKTURN1B,0
OBDUCKTURN2
	.long	OBDUCKTURN2A,OBDUCKTURN2B,0

;*************************************************************************

a_duck_block
	.long	OBDUCKBLOCK1
	.long	OBDUCKBLOCK2
	.long	OBDUCKBLOCK3
	.long	0

OBDUCKBLOCK1
	.long	OBDUCKBLOCK1A,OBDUCKBLOCK1B,0
OBDUCKBLOCK2
	.long	OBDUCKBLOCK2A,OBDUCKBLOCK2B,0
OBDUCKBLOCK3
	.long	OBDUCKBLOCK3A,OBDUCKBLOCK3B,0

;*************************************************************************

a_duck_hit
	.long	OBDUCKHIT2
	.long	OBDUCKHIT3
	.long	OBDUCKHIT2
	.long	OBDUCKHIT1
	.long	0

OBDUCKHIT1
	.long	OBDUCKHIT1A,OBDUCKHIT1B,0
OBDUCKHIT2
	.long	OBDUCKHIT2A,OBDUCKHIT2B,0
OBDUCKHIT3
	.long	OBDUCKHIT3A,OBDUCKHIT3B,0

;*************************************************************************

a_duck_punch
	.long	OBDUCKPUNCH1
	.long	OBDUCKPUNCH2
	.long	OBDUCKPUNCH3
	.long	0
	.long	OBDUCKPUNCH2
	.long	OBDUCKPUNCH1
	.long	OBDUCK3
	.long	0

OBDUCKPUNCH1
	.long	OBDUCKPUNCH1A,OBDUCKPUNCH1B,0
OBDUCKPUNCH2
	.long	OBDUCKPUNCH2A,OBDUCKPUNCH2B,0
OBDUCKPUNCH3
	.long	OBDUCKPUNCH3A,OBDUCKPUNCH3B,0

;*************************************************************************

a_duck_kick_lo
	.long	OBDUCKLOKICK1
	.long	OBDUCKLOKICK2
	.long	OBDUCKLOKICK3
	.long	0
	.long	OBDUCKLOKICK2
	.long	OBDUCKLOKICK1
	.long	OBDUCK3
	.long	0

OBDUCKLOKICK1
	.long	OBDUCKLOKICK1A,OBDUCKLOKICK1B,0
OBDUCKLOKICK2
	.long	OBDUCKLOKICK2A,OBDUCKLOKICK2B,0
OBDUCKLOKICK3
	.long	OBDUCKLOKICK3A,OBDUCKLOKICK3B,0

;*************************************************************************

a_duck_kick_hi
	.long	OBDUCKLOKICK1
	.long	OBDUCKLOKICK2
	.long	OBDUCKHIKICK1
	.long	OBDUCKHIKICK2
	.long	0
	.long	OBDUCKHIKICK1
	.long	OBDUCKLOKICK2
	.long	OBDUCKLOKICK1
	.long	OBDUCK3
	.long	0

OBDUCKHIKICK1
	.long	OBDUCKHIKICK1A,OBDUCKHIKICK1B,0
OBDUCKHIKICK2
	.long	OBDUCKHIKICK2A,OBDUCKHIKICK2B,0

;*************************************************************************

a_uppercut
	.long	OBUPPERCUT1
	.long	OBUPPERCUT2
	.long	OBUPPERCUT4
	.long	OBUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
	.long	OBUPPERCUT7
	.long	0
	.long	OBUPPERCUT5
	.long	0

OBUPPERCUT1
	.long	OBUPPERCUT1A,OBUPPERCUT1B,0
OBUPPERCUT2
	.long	OBUPPERCUT2A,OBUPPERCUT2B,0
OBUPPERCUT4
	.long	OBUPPERCUT4A,OBUPPERCUT4B,0
OBUPPERCUT5
	.long	OBUPPERCUT5A,OBUPPERCUT5B,0
OBUPPERCUT7
	.long	OBUPPERCUT7A,OBUPPERCUT7B,0

;*************************************************************************

a_hipunch
	.long	OBHIPUNCH1
	.long	OBHIPUNCH2
	.long	OBHIPUNCH3
	.long	0

	.long	OBHIPUNCH4
	.long	OBHIPUNCH5
	.long	OBHIPUNCH6
	.long	0

	.long	OBHIPUNCH5
	.long	OBHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	OBHIPUNCH2
	.long	OBHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	OBHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	OBHIPUNCH4
	.long	OBLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	OBHIPUNCH5
	.long	OBLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0


a_lopunch
	.long	OBLOPUNCH1
	.long	OBLOPUNCH2
	.long	OBLOPUNCH3
	.long	0

	.long	OBLOPUNCH4
	.long	OBLOPUNCH5
	.long	OBLOPUNCH6
	.long	0

	.long	OBLOPUNCH5
	.long	OBLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	OBLOPUNCH2
	.long	OBLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	OBHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	OBLOPUNCH4
	.long	OBLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	OBLOPUNCH4
	.long	OBHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)

OBHIPUNCH1
	.long	OBHIPUNCH1A,OBHIPUNCH1B,0
OBHIPUNCH2
	.long	OBHIPUNCH2A,OBHIPUNCH2B,0
OBHIPUNCH3
	.long	OBHIPUNCH3A,OBHIPUNCH3B,0
OBHIPUNCH4
	.long	OBHIPUNCH4A,OBHIPUNCH4B,0
OBHIPUNCH5
	.long	OBHIPUNCH5A,OBHIPUNCH5B,0
OBHIPUNCH6
	.long	OBHIPUNCH6A,OBHIPUNCH6B,0
OBHIPUNCH7
	.long	OBHIPUNCH7A,OBHIPUNCH7B,0

OBLOPUNCH1
	.long	OBLOPUNCH1A,OBLOPUNCH1B,0
OBLOPUNCH2
	.long	OBLOPUNCH2A,OBLOPUNCH2B,0
OBLOPUNCH3
	.long	OBLOPUNCH3A,OBLOPUNCH3B,0
OBLOPUNCH4
	.long	OBLOPUNCH4A,OBLOPUNCH4B,0
OBLOPUNCH5
	.long	OBLOPUNCH5A,OBLOPUNCH5B,0
OBLOPUNCH6
	.long	OBLOPUNCH6A,OBLOPUNCH6B,0

;*************************************************************************

a_block
	.long	OBHIBLOCK1
	.long	OBHIBLOCK2
	.long	OBHIBLOCK3
	.long	0

OBHIBLOCK1
	.long	OBHIBLOCK1A,OBHIBLOCK1B,0
OBHIBLOCK2
	.long	OBHIBLOCK2A,OBHIBLOCK2B,0
OBHIBLOCK3
	.long	OBHIBLOCK3A,OBHIBLOCK3B,0

;*************************************************************************

;ejbpatch

	.long	OBHLOLOCK1
	.long	OBLOBLOCK2

OBHLOLOCK1
	.long	OBHLOLOCK1A,OBHLOLOCK1B,0
OBLOBLOCK2
	.long	OBLOBLOCK2A,OBLOBLOCK2B,0

;*************************************************************************

a_elbow
	.long	OBELBOCOMBO1
	.long	OBELBOCOMBO2
	.long	OBELBOCOMBO3
	.long	0
	.long	OBELBOCOMBO2
	.long	OBELBOCOMBO1
	.long	0

	.long	OBELBOCOMBO4
	.long	OBELBOCOMBO5
	.long	OBELBOCOMBO6
	.long	OBELBOCOMBO7	; ani3 = hit 2
	.long	0

	.long	OBELBOCOMBO8
	.long	OBELBOCOMBO9
;	.long	ani_adjustx
;	.word	8
	.long	OBELBOCOMBO10
;	.long	ani_adjustx
;	.word	8
	.long	OBWHACK1
;	.long	ani_adjustx
;	.word	8
	.long	OBWHACK2
;	.long	ani_adjustx
;	.word	8
	.long	OBWHACK3
	.long	OBWHACK4	; ani4 = hit 3
	.long	0

	.long	OBWHACK5
	.long	OBWHACK6
	.long	OBWHACK7
	.long	OBWHACK8	; ani 5 = hit 4
	.long	0


OBELBOCOMBO1
	.long	OBELBOCOMBO1A,OBELBOCOMBO1B,0
OBELBOCOMBO2
	.long	OBELBOCOMBO2A,OBELBOCOMBO2B,0
OBELBOCOMBO3
	.long	OBELBOCOMBO3A,OBELBOCOMBO3B,0
OBELBOCOMBO4
	.long	OBELBOCOMBO4A,OBELBOCOMBO4B,0
OBELBOCOMBO5
	.long	OBELBOCOMBO5A,OBELBOCOMBO5B,0
OBELBOCOMBO6
	.long	OBELBOCOMBO6A,OBELBOCOMBO6B,0
OBELBOCOMBO7
	.long	OBELBOCOMBO7A,OBELBOCOMBO7B,0
OBELBOCOMBO8
	.long	OBELBOCOMBO8A,OBELBOCOMBO8B,0
OBELBOCOMBO9
	.long	OBELBOCOMBO9A,OBELBOCOMBO9B,0
OBELBOCOMBO10
	.long	OBELBOCOMBO10A,OBELBOCOMBO10B,0

OBWHACK1
	.long	OBWHACK1A,OBWHACK1B,0
OBWHACK2
	.long	OBWHACK2A,OBWHACK2B,0
OBWHACK3
	.long	OBWHACK3A,OBWHACK3B,0
OBWHACK4
	.long	OBWHACK4A,OBWHACK4B,0
OBWHACK5
	.long	OBWHACK5A,OBWHACK5B,0
OBWHACK6
	.long	OBWHACK6A,OBWHACK6B,0

; ejbpatch - can lose these frames
OBWHACK7
	.long	OBWHACK7A,OBWHACK7B,0
OBWHACK8
	.long	OBWHACK8A,OBWHACK8B,0

;*************************************************************************

a_lokick
	.long	OBLOKICK1
	.long	OBLOKICK2
	.long	OBLOKICK3
	.long	OBLOKICK4
	.long	OBLOKICK5
	.long	OBLOKICK6
	.long	0
	.long	OBLOKICK5
	.long	OBLOKICK4
	.long	OBLOKICK3
	.long	OBLOKICK2
	.long	OBLOKICK1
	.long	0

OBLOKICK1
	.long	OBLOKICK1A,OBLOKICK1B,0
OBLOKICK2
	.long	OBLOKICK2A,0
OBLOKICK3
	.long	OBLOKICK3A,0
OBLOKICK4
	.long	OBLOKICK4A,OBLOKICK4B,0
OBLOKICK5
	.long	OBLOKICK5A,OBLOKICK5B,0
OBLOKICK6
	.long	OBLOKICK6A,0

;*************************************************************************

a_hikick
	.long	OBLOKICK1
	.long	OBLOKICK2
	.long	OBLOKICK3
	.long	OBLOKICK4
	.long	OBHIKICK1
	.long	OBHIKICK2
	.long	0
	.long	OBHIKICK1
	.long	OBLOKICK4
	.long	OBLOKICK3
	.long	OBLOKICK2
	.long	OBLOKICK1
	.long	0

OBHIKICK1
	.long	OBHIKICK1A,0
OBHIKICK2
	.long	OBHIKICK2A,OBHIKICK2B,0

;*************************************************************************

a_knee
	.long	OBKNEEKICK1
	.long	OBKNEEKICK2
	.long	OBKNEEKICK3
	.long	0
	.long	OBKNEEKICK2
	.long	OBKNEEKICK1
	.long	0

OBKNEEKICK1
	.long	OBKNEEKICK1A,OBKNEEKICK1B,0
OBKNEEKICK2
	.long	OBKNEEKICK2A,0
OBKNEEKICK3
	.long	OBKNEEKICK3A,OBKNEEKICK3B,0

;*************************************************************************

a_sweep_kick
	.long	OBSWEEPKICK1
	.long	OBSWEEPKICK2
	.long	OBSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	OBSWEEPKICK4
	.long	OBSWEEPKICK5
	.long	0
	.long	OBSWEEPKICK6
	.long	OBSWEEPKICK7
	.long	OBSWEEPKICK8
	.long	0

OBSWEEPKICK1
	.long	OBSWEEPKICK1A,OBSWEEPKICK1B,0
OBSWEEPKICK2
	.long	OBSWEEPKICK2A,0
OBSWEEPKICK3
	.long	OBSWEEPKICK3A,0
OBSWEEPKICK4
	.long	OBSWEEPKICK4A,0
OBSWEEPKICK5
	.long	OBSWEEPKICK5A,OBSWEEPKICK5B,0
OBSWEEPKICK6
	.long	OBSWEEPKICK6A,0
OBSWEEPKICK7
	.long	OBSWEEPKICK7A,0
OBSWEEPKICK8
	.long	OBSWEEPKICK8A,OBSWEEPKICK8B,0

;*************************************************************************

a_roundhouse
	.long	OBROUNDHOUSE1
	.long	OBROUNDHOUSE2
	.long	OBROUNDHOUSE3
	.long	OBROUNDHOUSE4
	.long	OBROUNDHOUSE5
	.long	0
	.long	OBROUNDHOUSE6
	.long	OBROUNDHOUSE7
	.long	OBROUNDHOUSE8
	.long	OBROUNDHOUSE9
	.long	0


OBROUNDHOUSE1
	.long	OBROUNDHOUSE1A,OBROUNDHOUSE1B,0
OBROUNDHOUSE2
	.long	OBROUNDHOUSE2A,OBROUNDHOUSE2B,0
OBROUNDHOUSE3
	.long	OBROUNDHOUSE3A,0
OBROUNDHOUSE4
	.long	OBROUNDHOUSE4A,OBROUNDHOUSE4B,0
OBROUNDHOUSE5
	.long	OBROUNDHOUSE5A,OBROUNDHOUSE5B,0
OBROUNDHOUSE6
	.long	OBROUNDHOUSE6A,0
OBROUNDHOUSE7
	.long	OBROUNDHOUSE7A,0
OBROUNDHOUSE8
	.long	OBROUNDHOUSE8A,0
OBROUNDHOUSE9
	.long	OBROUNDHOUSE9A,OBROUNDHOUSE9B,0

;*************************************************************************

a_jump
	.long	OBJUMP1
	.long	OBJUMP2
	.long	OBJUMP3
	.long	0

OBJUMP1	.long	OBJUMP1A,OBJUMP1B,0
OBJUMP2	.long	OBJUMP2A,OBJUMP2B,0
OBJUMP3	.long	OBJUMP3A,OBJUMP3B,0

;*************************************************************************

a_jump_kick
	.long	OBJUMPKICK1
	.long	OBJUMPKICK2
	.long	OBJUMPKICK3
	.long	0
	.long	OBJUMPKICK2
	.long	OBJUMPKICK1
	.long	0

OBJUMPKICK1
	.long	OBJUMPKICK1A,0
OBJUMPKICK2
	.long	OBJUMPKICK2A,0
OBJUMPKICK3
	.long	OBJUMPKICK3A,OBJUMPKICK3B,0

;*************************************************************************

a_fflip
	.long	OBJUMPFLIP1
	.long	OBJUMPFLIP2
	.long	OBJUMPFLIP3
	.long	OBJUMPFLIP4
	.long	OBJUMPFLIP5
	.long	OBJUMPFLIP6
	.long	OBJUMPFLIP7
	.long	OBJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip
	.long	OBJUMPFLIP1
	.long	OBJUMPFLIP8
	.long	OBJUMPFLIP7
	.long	OBJUMPFLIP6
	.long	OBJUMPFLIP5
	.long	OBJUMPFLIP4
	.long	OBJUMPFLIP3
	.long	OBJUMPFLIP2
	.long	ani_jump,a_bflip+32

OBJUMPFLIP1
	.long	OBJUMPFLIP1A,0
OBJUMPFLIP2
	.long	OBJUMPFLIP2A,0
OBJUMPFLIP3
	.long	OBJUMPFLIP3A,0
OBJUMPFLIP4
	.long	OBJUMPFLIP4A,0
OBJUMPFLIP5
	.long	OBJUMPFLIP5A,0
OBJUMPFLIP6
	.long	OBJUMPFLIP6A,0
OBJUMPFLIP7
	.long	OBJUMPFLIP7A,0
OBJUMPFLIP8
	.long	OBJUMPFLIP8A,0

;*************************************************************************

a_flip_kick
	.long	OBFLIPKICK1
	.long	OBFLIPKICK2
	.long	OBFLIPKICK3
	.long	0
	.long	OBFLIPKICK2
	.long	OBFLIPKICK1
	.long	0

OBFLIPKICK1
	.long	OBFLIPKICK1A,0
OBFLIPKICK2
	.long	OBFLIPKICK2A,OBFLIPKICK2B,0
OBFLIPKICK3
	.long	OBFLIPKICK3A,0

;*************************************************************************

a_flip_punch
	.long	OBFLIPUNCH1
	.long	OBFLIPUNCH2
	.long	OBFLIPUNCH3
	.long	0
	.long	OBFLIPUNCH2
	.long	OBFLIPUNCH1
	.long	0

OBFLIPUNCH1
	.long	OBFLIPUNCH1A,0
OBFLIPUNCH2
	.long	OBFLIPUNCH2A,OBFLIPUNCH2B,0
OBFLIPUNCH3
	.long	OBFLIPUNCH3A,OBFLIPUNCH3B,OBFLIPUNCH3C,0

;*************************************************************************

a_hit_hi
	.long	OBHIHIT2
	.long	OBHIHIT3
	.long	OBHIHIT2
	.long	OBHIHIT1
	.long	0

OBHIHIT1	.long	OBHIHIT1A,OBHIHIT1B,0
OBHIHIT2	.long	OBHIHIT2A,OBHIHIT2B,0
OBHIHIT3	.long	OBHIHIT3A,OBHIHIT3B,0

;*************************************************************************

a_hit_lo
	.long	OBLOHIT2
	.long	OBLOHIT3
	.long	OBLOHIT2
	.long	OBLOHIT1
	.long	0

OBLOHIT1	.long	OBLOHIT1A,OBLOHIT1B,0
OBLOHIT2	.long	OBLOHIT2A,OBLOHIT2B,0
OBLOHIT3	.long	OBLOHIT3A,OBLOHIT3B,0

;*************************************************************************

a_stumble
	.long	OBSTUMBLE1
	.long	OBSTUMBLE2
	.long	OBSTUMBLE3
	.long	OBSTUMBLE4
	.long	OBSTUMBLE5
	.long	OBSTUMBLE6
	.long	OBSTUMBLE7
	.long	0

j_stumble
	.long	OBSTUMBLE1
	.long	OBSTUMBLE2
	.long	OBSTUMBLE3
	.long	OBSTUMBLE4
	.long	OBSTUMBLE5
	.long	OBSTUMBLE6
	.long	OBSTUMBLE7
	.long	ani_jump,j_stumble


OBSTUMBLE1
	.long	OBSTUMBLE1A,OBSTUMBLE1B,0
OBSTUMBLE2
	.long	OBSTUMBLE2A,OBSTUMBLE2B,0
OBSTUMBLE3
	.long	OBSTUMBLE3A,0
OBSTUMBLE4
	.long	OBSTUMBLE4A,0
OBSTUMBLE5
	.long	OBSTUMBLE5A,OBSTUMBLE5B,0
OBSTUMBLE6
	.long	OBSTUMBLE6A,0
OBSTUMBLE7
	.long	OBSTUMBLE7A,0

;*************************************************************************

a_dizzy	.long	OBSTUNNED1
	.long	OBSTUNNED2
	.long	OBSTUNNED3
	.long	OBSTUNNED4
	.long	OBSTUNNED5
	.long	OBSTUNNED6
	.long	OBSTUNNED7
	.long	OBSTUNNED8
	.long	ani_jump,a_dizzy

OBSTUNNED1
	.long	OBSTUNNED1A,OBSTUNNED1B,0
OBSTUNNED2
	.long	OBSTUNNED2A,OBSTUNNED2B,0
OBSTUNNED3
	.long	OBSTUNNED3A,OBSTUNNED3B,0
OBSTUNNED4
	.long	OBSTUNNED4A,OBSTUNNED4B,0
OBSTUNNED5
	.long	OBSTUNNED5A,OBSTUNNED5B,0
OBSTUNNED6
	.long	OBSTUNNED6A,OBSTUNNED6B,0
OBSTUNNED7
	.long	OBSTUNNED7A,OBSTUNNED7B,0
OBSTUNNED8
	.long	OBSTUNNED8A,OBSTUNNED8B,0

;*************************************************************************



a_knockdown
	.long	OBKNOCKDOWN1
	.long	OBKNOCKDOWN2
	.long	OBKNOCKDOWN3
	.long	OBKNOCKDOWN4
	.long	OBKNOCKDOWN5
	.long	0
	.long	OBKNOCKDOWN6
	.long	OBKNOCKDOWN7
	.long	0

OBKNOCKDOWN1
	.long	OBKNOCKDOWN1A,OBKNOCKDOWN1B,0
OBKNOCKDOWN2
	.long	OBKNOCKDOWN2A,OBKNOCKDOWN2B,0
OBKNOCKDOWN3
	.long	OBKNOCKDOWN3A,OBKNOCKDOWN3B,0
OBKNOCKDOWN4
	.long	OBKNOCKDOWN4A,0
OBKNOCKDOWN5
	.long	OBKNOCKDOWN5A,OBKNOCKDOWN5B,0
OBKNOCKDOWN6
	.long	OBKNOCKDOWN6A,0
OBKNOCKDOWN7
	.long	OBKNOCKDOWN7A,0

;*************************************************************************

a_getup	.long	OBGETUP1
	.long	OBGETUP2
	.long	OBGETUP3
	.long	OBGETUP4
	.long	OBGETUP5
	.long	OBGETUP6
	.long	0

OBGETUP1	.long	OBGETUP1A,0
OBGETUP2	.long	OBGETUP2A,0
OBGETUP3	.long	OBGETUP3A,0
OBGETUP4	.long	OBGETUP4A,0
OBGETUP5	.long	OBGETUP5A,0
OBGETUP6	.long	OBGETUP6A,OBGETUP6B,0

;*************************************************************************

a_sweep_fall
	.long	OBSWEEPFALL1
	.long	OBSWEEPFALL2
	.long	OBSWEEPFALL3
	.long	OBSWEEPFALL4
	.long	0
	.long	OBSWEEPFALL5
	.long	OBSWEEPFALL6
	.long	0

OBSWEEPFALL1
	.long	OBSWEEPFALL1A,OBSWEEPFALL1B,0
OBSWEEPFALL2
	.long	OBSWEEPFALL2A,OBSWEEPFALL2B,0
OBSWEEPFALL3
	.long	OBSWEEPFALL3A,OBSWEEPFALL3B,0
OBSWEEPFALL4
	.long	OBSWEEPFALL4A,OBSWEEPFALL4B,0
OBSWEEPFALL5
	.long	OBSWEEPFALL5A,OBSWEEPFALL5B,0
OBSWEEPFALL6
	.long	OBSWEEPFALL6A,OBSWEEPFALL6B,0

;*************************************************************************

a_sweepup
	.long	OBSWEEPUP1
	.long	OBSWEEPUP2
	.long	OBSWEEPUP3
	.long	OBSWEEPUP4
	.long	OBSWEEPUP5
	.long	OBSWEEPUP6
	.long	0

OBSWEEPUP1
	.long	OBSWEEPUP1A,OBSWEEPUP1B,0
OBSWEEPUP2
	.long	OBSWEEPUP2A,OBSWEEPUP2B,0
OBSWEEPUP3
	.long	OBSWEEPUP3A,0
OBSWEEPUP4
	.long	OBSWEEPUP4A,0
OBSWEEPUP5
	.long	OBSWEEPUP5A,0
OBSWEEPUP6
	.long	OBSWEEPUP6A,OBSWEEPUP6B,0

;*************************************************************************

a_legged
	.long	ani_offset_xy
	.word	-05dH,002H
	.long	OBKNOCKDOWN1

	.long	ani_offset_xy
	.word	-056H,-02dH
	.long	OBFLIPPED1

	.long	ani_offset_xy
	.word	-01cH,-042H
	.long	OBFLIPPED3

	.long	ani_offset_xy
	.word	029H,-038H
	.long	OBFLIPPED4

	.long	ani_offset_xy
	.word	056H,-016H
	.long	OBFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	055H,-01cH
	.long	OBKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	057H,001H
	.long	OBKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	027H,009H
	.long	OBKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	-030H,012H
	.long	OBKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	-0a4H,-013H
	.long	OBFLIPPED1	; 5

	.long	ani_offset_xy
	.word	-041H,-055H
	.long	OBFLIPPED3	; 6
	.long	0

	.long	OBFLIPPED3
	.long	OBFLIPPED4
	.long	OBFLIPPED5
	.long	OBKNOCKDOWN5
	.long	OBKNOCKDOWN6
	.long	OBKNOCKDOWN7
	.long	0




a_shook
	.long	ani_offset_xy
	.word	-051H,-008H
	.long	OBSTUMBLE2	; 3

	.long	ani_offset_xy
	.word	-030H,-01fH
	.long	OBSTUMBLE2	; 4

	.long	ani_offset_xy
	.word	-017H,-016H
	.long	OBSTUMBLE2	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	-017H,-016H
	.long	OBSTUMBLE2	; 6

	.long	ani_offset_xy
	.word	-019H,-017H
	.long	OBSTUMBLE2	; 7

	.long	ani_offset_xy
	.word	-02dH,-020H
	.long	OBSTUMBLE2	; 8

	.long	ani_offset_xy
	.word	-039H,-022H
	.long	OBSTUMBLE2	; 7
	.long	0


a_afb_kano
	.long	ani_offset_xy
	.word	-03eH,000H
	.long	OBKNOCKDOWN1

	.long	ani_offset_xy
	.word	-040H,-00cH
	.long	OBKNOCKDOWN5

	.long	ani_offset_xy
 	.word	-069H,026H
	.long	OBKNOCKDOWN5
	.long	0
*
* fall down solo
*
	.long	OBKNOCKDOWN5
	.long	OBKNOCKDOWN6
	.long	OBKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	-026H,-032H
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	-003H,-03fH
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	026H,-04eH
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	048H,-02dH
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	05dH,-00fH
	.long	OBKNOCKDOWN6
	.long	ani_offset_xy
	.word	06cH,01cH
	.long	OBKNOCKDOWN6
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	-01dH,01aH
	.long	OBSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	000H,033H
	.long	OBSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	-038H,014H
	.long	OBFLIPPED1		; 3
	.long	ani_offset_xy
	.word	-058H,-016H
	.long	OBFLIPPED2		; 4
	.long	ani_offset_xy
	.word	-03bH,-04cH
	.long	OBFLIPPED3		; 5
	.long	ani_offset_xy
	.word	014H,-079H
	.long	OBFLIPPED4		; 6
	.long	ani_offset_xy
	.word	053H,-07aH
	.long	OBFLIPPED5		; 7
	.long	ani_offset_xy
	.word	061H,-065H
	.long	OBFLIPPED5		; 8
	.long	ani_offset_xy
	.word	077H,002H
	.long	OBFLIPPED5		; 9
	.long	ani_offset_xy
	.word	077H,052H
	.long	OBFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	-08dH,-006H
	.long	OBFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-06cH,-04aH
	.long	OBFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-01eH,-077H
	.long	OBFLIPPED3		; 3
	.long	ani_offset_xy
	.word	039H,-06dH
	.long	OBFLIPPED4		; 4
	.long	ani_offset_xy
	.word	044H,-02aH
	.long	OBFLIPPED5		; 5

	.long	ani_offset_xy
	.word	00fH,009H
	.long	OBFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-031H,-014H
  	.long	OBKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	-078H,-007H
	.long	OBFLIPPED1		; 8
	.long	ani_offset_xy
	.word	-061H,-044H
	.long	OBFLIPPED2		; 9
	.long	ani_offset_xy
	.word	010H,-066H
	.long	OBFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	065H,-018H
	.long	OBFLIPPED5		; 11
	.long	ani_offset_xy
	.word	060H,002H
  	.long	OBKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	-03dH,-030H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-008H,-052H
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	-002H,-052H
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	013H,-04aH
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	015H,-02fH
	.long	OBFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	-025H,-00fH
  	.long	OBKNOCKDOWN7
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	-04cH,-012H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-041H,-003H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-02aH,001H
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	-016H,009H
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	00eH,014H
	.long	OBFLIPPED4

	.long	ani_offset_xy
	.word	-00fH,-004H
	.long	OBKNOCKDOWN6
	.long	ani_offset_xy
	.word	-023H,-004H
	.long	OBKNOCKDOWN6
	.long	ani_offset_xy
	.word	-038H,-004H
	.long	OBKNOCKDOWN6

	.long	ani_offset_xy
	.word	-060H,019H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-076H,-01aH
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-041H,-04cH
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	02bH,-056H
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	046H,-030H
	.long	OBFLIPPED5
	.long	ani_offset_xy
	.word	05bH,-008H
	.long	OBKNOCKDOWN6
	.long	0



a_fb_lk
	.long	ani_offset_xy
	.word	-044H,-009H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-03bH,-004H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-021H,002H
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	010H,005H
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	03bH,-008H
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	088H,-026H
	.long	OBFLIPPED4
	.long	0

	.long	OBFLIPPED5
	.long	OBKNOCKDOWN5
	.long	OBKNOCKDOWN6
	.long	OBKNOCKDOWN7
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	-03aH,-022H		; we need even # of words here !
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-026H,-02fH
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	038H,-02fH
	.long	OBFLIPPED3
	.long	0
	.long	OBFLIPPED4
	.long	OBFLIPPED5
	.long	OBKNOCKDOWN4
	.long	OBKNOCKDOWN5
	.long	0

a_fb_sonya
	.long	ani_offset_xy
	.word	-031H,-008H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-01eH,001H
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	017H,-005H
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	061H,-02eH
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	094H,-031H
	.long	OBFLIPPED4
	.long	0

	.long	OBFLIPPED5
	.long	OBKNOCKDOWN4
	.long	OBKNOCKDOWN5
	.long	0

a_fb_jax
	.long	ani_offset_xy
	.word	-04dH,-024H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-030H,-037H
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	004H,-049H
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	03aH,-043H
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	045H,-00dH
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	047H,009H
	.long	OBKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	-067H,-01dH
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-050H,-03cH
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	-021H,-057H
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	02cH,-057H
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	053H,-034H
	.long	OBKNOCKDOWN6
	.long	ani_offset_xy
	.word	042H,-003H
	.long	OBKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	-04cH,-03cH
	.long	OBFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	04cH,-034H
	.long	OBFLIPPED5

	.long	ani_offset_xy
	.word	036H,-010H
	.long	OBFLIPPED5

	.long	ani_offset_xy
	.word	-008H,-00dH
	.long	OBKNOCKDOWN5

	.long	ani_offset_xy
	.word	-04aH,-037H
	.long	OBKNOCKDOWN5

	.long	ani_offset_xy
	.word	-081H,-064H
	.long	OBKNOCKDOWN5
	.long	0


a_fb_swat
	.long	ani_offset_xy
	.word	-05fH,-017H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-045H,-045H
	.long	OBFLIPPED2
	.long	ani_offset_xy
	.word	01dH,-04fH
	.long	OBFLIPPED3
	.long	ani_offset_xy
	.word	05aH,-025H
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	04bH,006H
	.long	OBKNOCKDOWN6
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	-064H,000H
	.long	OBSTUMBLE1
	.long	ani_offset_xy
	.word	-073H,003H
	.long	OBSTUMBLE1

	.long	ani_offset_xy
	.word	-07fH,-028H
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-062H,-04aH
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	-02fH,-04eH
	.long	OBFLIPPED1
	.long	ani_offset_xy
	.word	018H,-053H
	.long	OBFLIPPED1

	.long	ani_offset_xy
	.word	09aH,006H
	.long	OBFLIPPED4
	.long	ani_offset_xy
	.word	08dH,000H
	.long	OBKNOCKDOWN7
	.long	0

a_fb_robo
	.long	ani_offset_xy
	.word	-062H,-014H
	.long	OBFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-05bH,-031H
	.long	OBFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-043H,-048H
	.long	OBFLIPPED2		; 3

	.long	ani_offset_xy
	.word	-015H,-065H
	.long	OBFLIPPED3		; 4
	.long	ani_offset_xy
	.word	036H,-079H
	.long	OBFLIPPED4		; 5
	.long	ani_offset_xy
	.word	05aH,-064H
	.long	OBFLIPPED4		; 6

	.long	ani_offset_xy
	.word	076H,-02aH
	.long	OBFLIPPED5		; 7
	.long	ani_offset_xy
	.word	057H,-00dH
	.long	OBKNOCKDOWN7		; 8
	.long	0

a_fb_robo2
	.long	ani_offset_xy
	.word	-02eH,-00aH
	.long	OBSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	-035H,-027H
	.long	OBFLIPPED1		; 2
	.long	ani_offset_xy
	.word	-01fH,-025H
	.long	OBFLIPPED2		; 3
	.long	ani_offset_xy
	.word	005H,-016H
	.long	OBFLIPPED3		; 4
	.long	ani_offset_xy
	.word	01bH,-00cH
	.long	OBFLIPPED4		; 5
	.long	ani_offset_xy
	.word	009H,-007H
	.long	OBFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-01aH,-011H
	.long	OBKNOCKDOWN7		; 7
	.long	0

OBFLIPPED1
	.long	OBFLIPPED1A,OBFLIPPED1B,0
OBFLIPPED2
	.long	OBFLIPPED2A,0
OBFLIPPED3
	.long	OBFLIPPED3A,OBFLIPPED3B,0
OBFLIPPED4
	.long	OBFLIPPED4A,0
OBFLIPPED5
	.long	OBFLIPPED5A,0

;*************************************************************************

a_zap	.long	OBSHOOT1
	.long	OBSHOOT2
	.long	OBSHOOT3

;	.long	OBSHOOT4
;	.long	OBSHOOT5
	.long	ani_sladd,BANG1
	.long	ani_slani_sleep,BANG1
	.long	0
*
* part 2 = bullets projectile ani
*
	.long	BANG2
	.long	BANG3
	.long	BANG4		; prezap animation

j_bang	.long	BANG5
	.long	BANG6
	.long	BANG7
	.long	BANG8
	.long	ani_jump,j_bang
	.long	0
*
* part 3 = bullets projectile hit ani
*
	.long	BANGHIT1
	.long	BANGHIT2
	.long	BANGHIT3
	.long	BANGHIT4
	.long	BANGHIT5
	.long	BANGHIT6
	.long	BANGHIT7
	.long	BANGHIT8
	.long	BANGHIT9
	.long	0

OBSHOOT1	.long	OBSHOOT1A,OBSHOOT1B,0
OBSHOOT2	.long	OBSHOOT2A,OBSHOOT2B,0
OBSHOOT3	.long	OBSHOOT3A,OBSHOOT3B,0
OBSHOOT4	.long	OBSHOOT4A,OBSHOOT4B,0
OBSHOOT5	.long	OBSHOOT5A,OBSHOOT5B,0

BANG1	.long	PROJSTRT1,0
BANG2	.long	PROJSTRT2,0
BANG3	.long	PROJSTRT3,0
BANG4	.long	PROJSTRT4,0
BANG5	.long	PROJSTRT5,0
BANG6	.long	PROJSTRT6,0
BANG7	.long	PROJSTRT7,0
BANG8	.long	PROJSTRT8,0

BANGHIT1	.long	STRTHIT1,0
BANGHIT2	.long	STRTHIT2,0
BANGHIT3	.long	STRTHIT3,0
BANGHIT4	.long	STRTHIT4,0
BANGHIT5	.long	STRTHIT5,0
BANGHIT6	.long	STRTHIT6,0
BANGHIT7	.long	STRTHIT7,0
BANGHIT8	.long	STRTHIT8,0
BANGHIT9	.long	STRTHIT9,0

;*************************************************************************

;a_fire_diag
;	.long	OBSHOOT1
;	.long	OBSHOOT2
;	.long	OBSHOOT3
;	.long	OBSHOOTDIAG1
;	.long	OBSHOOTDIAG2
;	.long	OBSHOOTDIAG3
;	.long	ani_sladd,DIAG1
;	.long	ani_slani_sleep,DIAG1
;	.long	0
;*
;* part 2 - diagonal bullets
;*
;	.long	DIAG1
;	.long	DIAG2
;	.long	DIAG3
;	.long	DIAG4
;	.long	DIAG5
;	.long	DIAG6
;	.long	DIAG7
;	.long	0
;*
;* part 3 - diagonal hits
;*
;	.long	DIAGH1
;	.long	DIAGH2
;	.long	DIAGH3
;	.long	DIAGH4
;	.long	DIAGH5
;	.long	DIAGH6
;	.long	DIAGH7
;	.long	0
;*
;* part 4 = undiag shoot ani
;*
;	.long	OBSHOOTDIAG3
;	.long	OBSHOOTDIAG2
;	.long	OBSHOOTDIAG1
;	.long	OBSHOOT3
;	.long	OBSHOOT2
;	.long	OBSHOOT1
;	.long	0
;
;
;OBSHOOTDIAG1
;	.long	OBSHOOTDIAG1A,OBSHOOTDIAG1B,0
;OBSHOOTDIAG2
;	.long	OBSHOOTDIAG2A,OBSHOOTDIAG2B,0
;OBSHOOTDIAG3
;	.long	OBSHOOTDIAG3A,OBSHOOTDIAG3B,0
;
;DIAG1	.long	PROJDIAG1,0
;DIAG2	.long	PROJDIAG2,0
;DIAG3	.long	PROJDIAG3,0
;DIAG4	.long	PROJDIAG4,0
;DIAG5	.long	PROJDIAG5,0
;DIAG6	.long	PROJDIAG6,0
;DIAG7	.long	PROJDIAG7,0
;
;DIAGH1	.long	DIAGHIT1,0
;DIAGH2	.long	DIAGHIT2,0
;DIAGH3	.long	DIAGHIT3,0
;DIAGH4	.long	DIAGHIT4,0
;DIAGH5	.long	DIAGHIT5,0
;DIAGH6	.long	DIAGHIT6,0
;DIAGH7	.long	DIAGHIT7,0
;DIAGH8	.long	DIAGHIT8,0
;DIAGH9	.long	DIAGHIT9,0

;*************************************************************************

a_throw
	.long	OBSTICKFLIP1
	.long	OBSTICKFLIP2	; grab
	.long	OBSTICKFLIP3
	.long	0

	.long	OBSTICKFLIP4
	.long	OBSTICKFLIP5
	.long	OBSTICKFLIP6
	.long	OBSTICKFLIP7
	.long	OBSTICKFLIP8	; animate together
	.long	0

	.long	OBSTICKFLIP7
	.long	0

OBSTICKFLIP1
	.long	OBSTICKFLIP1A,OBSTICKFLIP1B,0
OBSTICKFLIP2
	.long	OBSTICKFLIP2A,OBSTICKFLIP2B,0
OBSTICKFLIP3
	.long	OBSTICKFLIP3A,OBSTICKFLIP3B,0
OBSTICKFLIP4
	.long	OBSTICKFLIP4A,OBSTICKFLIP4B,0
OBSTICKFLIP5
	.long	OBSTICKFLIP5A,OBSTICKFLIP5B,0
OBSTICKFLIP6
	.long	OBSTICKFLIP6A,OBSTICKFLIP6B,0
OBSTICKFLIP7
	.long	OBSTICKFLIP7A,OBSTICKFLIP7B,OBSTICKFLIP7C,0
OBSTICKFLIP8
	.long	OBSTICKFLIP8A,OBSTICKFLIP8B,0

;*************************************************************************

a_throw_bomb
	.long	OBTHROWBOMB1
	.long	OBTHROWBOMB2
	.long	OBTHROWBOMB3
	.long	OBTHROWBOMB4
	.long	OBTHROWBOMB5
	.long	OBTHROWBOMB6
	.long	0
*
* part 2 = bomb
*
j_bomb	.long	MBOMB1
	.long	MBOMB2
	.long	MBOMB3
	.long	MBOMB4
	.long	MBOMB5
	.long	MBOMB6
	.long	MBOMB7
	.long	MBOMB8
	.long	MBOMB9
	.long	MBOMB10
	.long	MBOMB11
	.long	MBOMB12
	.long	ani_jump,j_bomb

OBTHROWBOMB1
	.long	OBTHROWBOMB1A,OBTHROWBOMB1B,0
OBTHROWBOMB2
	.long	OBTHROWBOMB2A,OBTHROWBOMB2B,0
OBTHROWBOMB3
	.long	OBTHROWBOMB3A,OBTHROWBOMB3B,0
OBTHROWBOMB4
	.long	OBTHROWBOMB4A,OBTHROWBOMB4B,0
OBTHROWBOMB5
	.long	OBTHROWBOMB5A,OBTHROWBOMB5B,0
OBTHROWBOMB6
	.long	OBTHROWBOMB6A,OBTHROWBOMB6B,0

MBOMB1	.long	BOMB1,0
MBOMB2	.long	BOMB2,0
MBOMB3	.long	BOMB3,0
MBOMB4	.long	BOMB4,0
MBOMB5	.long	BOMB5,0
MBOMB6	.long	BOMB6,0
MBOMB7	.long	BOMB7,0
MBOMB8	.long	BOMB8,0
MBOMB9	.long	BOMB9,0
MBOMB10	.long	BOMB10,0
MBOMB11	.long	BOMB11,0
MBOMB12	.long	BOMB12,0

;***********************************************

a_zoom	.long	OBAIRSTICK1
	.long	0			; debug
	.long	OBAIRSTICK2
	.long	OBAIRSTICK3
	.long	OBAIRSTICK4
	.long	OBAIRSTICK5
	.long	OBAIRSTICK6
	.long	OBAIRSTICK7
	.long	0

	.long	OBAIRSTICK8
	.long	OBAIRSTICK7
	.long	OBAIRSTICK6
	.long	OBAIRSTICK5
	.long	OBAIRSTICK4
	.long	OBAIRSTICK3
	.long	0

OBAIRSTICK1
	.long	OBAIRSTICK1A,OBAIRSTICK1B,0
OBAIRSTICK2
	.long	OBAIRSTICK2A,OBAIRSTICK2B,OBAIRSTICK2C,0
OBAIRSTICK3
	.long	OBAIRSTICK3A,OBAIRSTICK3B,OBAIRSTICK3C,0
OBAIRSTICK4
	.long	OBAIRSTICK4A,OBAIRSTICK4B,0
OBAIRSTICK5
	.long	OBAIRSTICK5A,OBAIRSTICK5B,0
OBAIRSTICK6
	.long	OBAIRSTICK6A,OBAIRSTICK6B,OBAIRSTICK6C,0
OBAIRSTICK7
	.long	OBAIRSTICK7A,OBAIRSTICK7B,0
OBAIRSTICK8
	.long	OBAIRSTICK8A,OBAIRSTICK8B,0


a_stick_sweep
	.long	OBSTIKSWEEP1
	.long	OBSTIKSWEEP2
	.long	ani_calla,stsw_sound
	.long	OBSTIKSWEEP3
	.long	OBSTIKSWEEP4
	.long	0
	.long	OBSTIKSWEEP5
	.long	OBSTIKSWEEP4
	.long	OBSTIKSWEEP3
	.long	OBSTIKSWEEP2
	.long	OBSTIKSWEEP1
	.long	0

stsw_sound
	movk	2,a0
	jauc	triple_sound

OBSTIKSWEEP1
	.long	OBSTIKSWEEP1A,0
OBSTIKSWEEP2
	.long	OBSTIKSWEEP2A,OBSTIKSWEEP2B,OBSTIKSWEEP2C,0
OBSTIKSWEEP3
	.long	OBSTIKSWEEP3A,OBSTIKSWEEP3B,0
OBSTIKSWEEP4
	.long	OBSTIKSWEEP4A,OBSTIKSWEEP4B,OBSTIKSWEEP4C,0
OBSTIKSWEEP5
	.long	OBSTIKSWEEP5A,OBSTIKSWEEP5B,0

;*************************************************************************

a_victory
	.long	OBVICTORY1
	.long	OBVICTORY2
	.long	OBVICTORY3
	.long	OBVICTORY4
	.long	OBVICTORY5
	.long	ani_nosleep
	.long	OBVICTORY6
	.long	ani_sladd,BLASTVIC1
	.long	0
*
* part 2 = ratatatatat !!!
*
	.long	ani_slani_sleep,BLASTVIC1
	.long	ani_ochar_sound
	.word	5
	.long	ani_slani_sleep,BLASTVIC2
	.long	ani_ochar_sound
	.word	5
	.long	ani_slani_sleep,BLASTVIC3
	.long	ani_ochar_sound
	.word	5
	.long	ani_slani_sleep,BLASTVIC4
	.long	ani_ochar_sound
	.word	5
	.long	0

	.long	OBVICTORY7
	.long	OBVICTORY8
	.long	OBVICTORY91
	.long	OBVICTORY92
	.long	OBVICTORY93
	.long	OBVICTORY94
	.long	OBVICTORY95
	.long	OBVICTORY96
	.long	OBVICTORY10
	.long	OBVICTORY11
	.long	OBVICTORY12
	.long	OBVICTORY13
	.long	OBVICTORY14
	.long	0

BLASTVIC1
	.long	OBBLASTVIC1,0
BLASTVIC2
	.long	OBBLASTVIC2,0
BLASTVIC3
	.long	OBBLASTVIC3,0
BLASTVIC4
	.long	OBBLASTVIC4,0

;---> OBBLAST1,OBBLAST2,OBBLAST3,OBBLAST4,OBBLAST5,OBBLAST6
;---> RICOCHETTE1A,RICOCHETTE2A

a_victory_bolts
	.long	0
	.long	0



OBVICTORY1
	.long	OBVICTORY1A,OBVICTORY1B,0
OBVICTORY2
	.long	OBVICTORY2A,OBVICTORY2B,0
OBVICTORY3
	.long	OBVICTORY3A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY4
	.long	OBVICTORY4A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY5
	.long	OBVICTORY5A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY6
	.long	OBVICTORY6A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY7
	.long	OBVICTORY7A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY8
	.long	OBVICTORY8A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY91
	.long	OBVICTORY9ROT1A,OBVICTORY9A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY92
	.long	OBVICTORY9ROT2A,OBVICTORY9A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY93
	.long	OBVICTORY9ROT3A,OBVICTORY9A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY94
	.long	OBVICTORY9ROT4A,OBVICTORY9A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY95
	.long	OBVICTORY9ROT5A,OBVICTORY9A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY96
	.long	OBVICTORY9ROT6A,OBVICTORY9A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY10
	.long	OBVICTORY10A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY11
	.long	OBVICTORY11A,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY12
	.long	OBVICTORY12A,OBVICTORY12B,0	;OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY13
	.long	OBVICTORY13A,OBVICTORY13B,0 	;,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0
OBVICTORY14
	.long	OBVICTORY14A,OBVICTORY14B,0	;,OBVICTORYLEGS1A,OBVICTORYLEGS1B,0

;**********************************************************************

a_scared
	.long	OBSCARED3
	.long	0

OBSCARED3
	.long	OBSCARED3A,0

a_thudd
	.long	OBTHUD1
	.long	OBTHUD2
	.long	OBTHUD3
	.long	OBTHUD4
	.long	OBTHUD5
	.long	OBTHUD6
	.long	OBTHUD7
	.long	0

OBTHUD1
	.long	OBTHUD1A,0
OBTHUD2
	.long	OBTHUD2A,0
OBTHUD3
	.long	OBTHUD3A,0
OBTHUD4
	.long	OBTHUD4A,0
OBTHUD5
	.long	OBTHUD5A,0
OBTHUD6
	.long	OBTHUD6A,0
OBTHUD7
	.long	OBTHUD7A,0

;**********************************************************************

a_taser
	.long	OBTAZAR1
	.long	OBTAZAR2
	.long	OBTAZAR3
	.long	OBTAZAR4
	.long	OBTAZAR5
	.long	OBTAZAR6
	.long	0

	.long	ani_sladd,TAZBANG
	.long	OBTAZAR7
	.long	ani_calla,delete_slave	; rid of bang obj
	.long	OBTAZAR8
	.long	OBTAZAR10
	.long	OBTAZAR11
	.long	0

	.long	OBTAZAR10
	.long	OBTAZAR11
	.long	0

OBTAZAR1
	.long	OBTAZAR1A,OBTAZAR1B,0
OBTAZAR2
	.long	OBTAZAR2A,OBTAZAR2B,0
OBTAZAR3
	.long	OBTAZAR3A,OBTAZAR3B,0
OBTAZAR4
	.long	OBTAZAR4A,OBTAZAR4B,0
OBTAZAR5
	.long	OBTAZAR5A,OBTAZAR5B,0
OBTAZAR6
	.long	OBTAZAR6A,OBTAZAR6B,0
OBTAZAR7
	.long	OBTAZAR7A,OBTAZAR7B,OBTAZAR7C,0
OBTAZAR8
	.long	OBTAZAR8A,OBTAZAR8B,0
OBTAZAR10
	.long	OBTAZAR10A,OBTAZAR10B,OBTAZAR10C,0
OBTAZAR11
	.long	OBTAZAR11A,OBTAZAR11B,OBTAZAR11C,0

TAZBANG	.long	TAZBLAST,0


a_set_bomb
	.long	OBSETBOMB1
	.long	ani_adjustx
	.word	00aH
	.long	OBSETBOMB2
	.long	ani_adjustx
	.word	00aH
	.long	OBSETBOMB3
	.long	ani_adjustx
	.word	00aH
	.long	OBSETBOMB4
	.long	ani_adjustx
	.word	00aH

	.long	OBSETBOMB5
	.long	OBSETBOMB6
	.long	OBSETBOMB5
	.long	OBSETBOMB4
	.long	OBSETBOMB5
	.long	OBSETBOMB6
	.long	0

	.long	OBCOVEREAR1
	.long	OBCOVEREAR2
	.long	OBCOVEREAR3
	.long	OBCOVEREAR4
	.long	0

	.long	EXPLO1
	.long	MWICK1
	.long	MWICK2
	.long	MWICK3
	.long	MWICK4
	.long	MWICK5
	.long	MWICK6
	.long	MWICK7
	.long	MWICK8
	.long	MWICK9
	.long	MWICK10
	.long	MWICK11
	.long	0
*
* part 4 = boom !!
*
	.long	ani_swpal
	.long	SWBOOM
	.long	0

	.long	EXPLOSIVES1


SWBOOM	.long	HUGEXPD01,a0
EXPLO1	.long	EXPLOSIVES1,0
MWICK1	.long	WICK1,0
MWICK2	.long	WICK2,0
MWICK3	.long	WICK3,0
MWICK4	.long	WICK4,0
MWICK5	.long	WICK5,0
MWICK6	.long	WICK6,0
MWICK7	.long	WICK7,0
MWICK8	.long	WICK8,0
MWICK9	.long	WICK9,0
MWICK10	.long	WICK10,0
MWICK11	.long	WICK11,0

OBSETBOMB1
	.long	OBSETBOMB1A,OBSETBOMB1B,0
OBSETBOMB2
	.long	OBSETBOMB2A,OBSETBOMB2B,0
OBSETBOMB3
	.long	OBSETBOMB3A,OBSETBOMB3B,0
OBSETBOMB4
	.long	OBSETBOMB4A,OBSETBOMBLEG1A,OBSETBOMBLEG1B,0
OBSETBOMB5
	.long	OBSETBOMB5A,OBSETBOMBLEG1A,OBSETBOMBLEG1B,0
OBSETBOMB6
	.long	OBSETBOMB6A,OBSETBOMBLEG1A,OBSETBOMBLEG1B,0
OBCOVEREAR1
	.long	OBCOVEREAR1A,OBCOVEREAR1B,0
OBCOVEREAR2
	.long	OBCOVEREAR2A,OBCOVEREAR2B,0
OBCOVEREAR3
	.long	OBCOVEREAR3A,OBCOVEREAR3B,0
OBCOVEREAR4
	.long	OBCOVEREAR4A,OBCOVEREAR4B,0

;***********************************************

	.end
