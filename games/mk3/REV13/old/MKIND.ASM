**************************************************************************
*											     *
*  mk3 - indian											*
*											     *
**************************************************************************

	.FILE	'mkind.ASM'
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo
	.include mkind.tbl
	.include mkind2.tbl
	.include mkind3.tbl

	.text

**************************************************************************

ind_anitab1
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
	.long	a_fb_st		; 32	- flipped by shang tsung
	.long	a_fb_lk		; 33	- flipped by liu kang
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

ind_anitab2
	.long	a_horz_swipe	 ;  0
	.long	a_axe_chop	 ;  1
	.long	a_axe_up	 ;  2
	.long	a_reflect	 ;  3
	.long	a_indy_charge	 ;  4
	.long	a_sky_light	 ;  5
	.long	a_sky_zap 	 ;  6
	.long	a_overhead_chop	 ;  7
	.long	a_dummy


**************************************************************************

a_dummy
a_stance
	.long	INSTANCE1
	.long	INSTANCE2
	.long	INSTANCE3
	.long	INSTANCE4
	.long	INSTANCE5
	.long	INSTANCE6
	.long	INSTANCE7
	.long	INSTANCE8
	.long	INSTANCE9
	.long	ani_jump,a_stance

INSTANCE1
	.long	INSTANCE1A,INSTANCE1B,0
INSTANCE2
	.long	INSTANCE2A,INSTANCE2B,0
INSTANCE3
	.long	INSTANCE3A,INSTANCE3B,0
INSTANCE4
	.long	INSTANCE4A,INSTANCE4B,0
INSTANCE5
	.long	INSTANCE5A,INSTANCE5B,0
INSTANCE6
	.long	INSTANCE6A,INSTANCE6B,0
INSTANCE7
	.long	INSTANCE7A,INSTANCE7B,0
INSTANCE8
	.long	INSTANCE8A,INSTANCE8B,0
INSTANCE9
	.long	INSTANCE9A,INSTANCE9B,0

**************************************************************************

a_walkf
	.long	INWALK1
	.long	INWALK2
	.long	INWALK3
	.long	INWALK4
	.long	INWALK5
	.long	INWALK6
	.long	INWALK7
	.long	INWALK8
	.long	INWALK9
	.long	ani_jump,a_walkf

a_walkb
	.long	INWALK9
	.long	INWALK8
	.long	INWALK7
	.long	INWALK6
	.long	INWALK5
	.long	INWALK4
	.long	INWALK3
	.long	INWALK2
	.long	INWALK1
	.long	ani_jump,a_walkb

INWALK1	.long	INWALKTORSO1A,INWALKTORSO1B,INWALK1A,INWALK1B,0
INWALK2	.long	INWALKTORSO2A,INWALKTORSO2B,INWALK2A,INWALK2B,0
INWALK3	.long	INWALKTORSO3A,INWALKTORSO3B,INWALK3A,0
INWALK4	.long	INWALKTORSO4A,INWALKTORSO4B,INWALK4A,INWALK4B,0
INWALK5	.long	INWALKTORSO5A,INWALKTORSO5B,INWALK5A,INWALK5B,0
INWALK6	.long	INWALKTORSO6A,INWALKTORSO6B,INWALK6A,INWALK6B,0
INWALK7	.long	INWALKTORSO7A,INWALKTORSO7B,INWALK7A,INWALK7B,0
INWALK8	.long	INWALKTORSO8A,INWALKTORSO8B,INWALK8A,INWALK8B,0
INWALK9	.long	INWALKTORSO9A,INWALKTORSO9B,INWALK9A,INWALK9B,0

**************************************************************************

a_turn
	.long	INTURN1
	.long	INTURN2
	.long	ani_flip
	.long	INTURN1
	.long	0

INTURN1	.long	INTURN1A,INTURN1B,INTURN1C,INTURN1D,0
INTURN2	.long	INTURN2A,INTURN2B,INTURN2C,0

*************************************************************************

a_duck_turn
	.long	INDUCKTURN1
	.long	INDUCKTURN2
	.long	ani_flip
	.long	INDUCKTURN2
	.long	INDUCKTURN1
	.long	INDUCK3
	.long	0

INDUCKTURN1
	.long	INDUCKTURN1A,INDUCKTURN1B,INDUCKTURN1C,0
INDUCKTURN2
	.long	INDUCKTURN2A,INDUCKTURN2B,INDUCKTURN2C,0

**************************************************************************

a_duck	.long	INDUCK1
	.long	INDUCK2
	.long	INDUCK3
	.long	0

INDUCK1	.long	INDUCK1A,INDUCK1B,INDUCK1C,INDUCK1D,0
INDUCK2	.long	INDUCK2A,INDUCK2B,INDUCK2C,0
INDUCK3	.long	INDUCK3A,INDUCK3B,INDUCK3C,0

**************************************************************************

a_duck_block
	.long	INDUCKBLOCK1
	.long	INDUCKBLOCK2
	.long	INDUCKBLOCK3
	.long	0

INDUCKBLOCK1
	.long	INDUCKBLOCK1A,INDUCKBLOCK1B,INDUCKBLOCK1C,0
INDUCKBLOCK2
	.long	INDUCKBLOCK2A,INDUCKBLOCK2B,INDUCKBLOCK2C,0
INDUCKBLOCK3
	.long	INDUCKBLOCK3A,INDUCKBLOCK3B,INDUCKBLOCK3C,0

**************************************************************************

a_duck_punch
	.long	INDUCKPUNCH1
	.long	INDUCKPUNCH2
	.long	INDUCKPUNCH3
	.long	0
	.long	INDUCKPUNCH2
	.long	INDUCKPUNCH1
	.long	INDUCK3
	.long	0

INDUCKPUNCH1
	.long	INDUCKPUNCH1A,INDUCKPUNCH1B,INDUCKPUNCH1C,0
INDUCKPUNCH2
	.long	INDUCKPUNCH2A,INDUCKPUNCH2B,INDUCKPUNCH2C,INDUCKPUNCH2D
	.long	0
INDUCKPUNCH3
	.long	INDUCKPUNCH3A,INDUCKPUNCH3B,INDUCKPUNCH3C,INDUCKPUNCH3D
	.long	0

**************************************************************************

a_duck_hit
	.long	INDUCKHIT2
	.long	INDUCKHIT3
	.long	INDUCKHIT2
	.long	INDUCKHIT1
	.long	0

INDUCKHIT1
	.long	INDUCKHIT1A,INDUCKHIT1B,INDUCKHIT1C,0
INDUCKHIT2
	.long	INDUCKHIT2A,INDUCKHIT2B,INDUCKHIT2C,INDUCKHIT2D
	.long	0
INDUCKHIT3
	.long	INDUCKHIT3A,INDUCKHIT3B,INDUCKHIT3C,INDUCKHIT3D
	.long	0

**************************************************************************

a_duck_kick_hi
	.long	INDUCKHIKICK1
	.long	INDUCKHIKICK2
	.long	INDUCKHIKICK3
	.long	INDUCKHIKICK4
	.long	0
	.long	INDUCKHIKICK3
	.long	INDUCKHIKICK2
	.long	INDUCKHIKICK1
	.long	INDUCK3
	.long	0

INDUCKHIKICK1
	.long	INDUCKHIKICK1A,INDUCKHIKICK1B,INDUCKHIKICK1C,0
INDUCKHIKICK2
	.long	INDUCKHIKICK2A,INDUCKHIKICK2B,INDUCKHIKICK2C,0
INDUCKHIKICK3
	.long	INDUCKHIKICK3A,INDUCKHIKICK3B,INDUCKHIKICK3C,INDUCKHIKICK3D,0
INDUCKHIKICK4
	.long	INDUCKHIKICK4A,INDUCKHIKICK4B,INDUCKHIKICK4C,0

**************************************************************************

a_duck_kick_lo
	.long	INDUCKLOKICK1
	.long	INDUCKLOKICK2
	.long	INDUCKLOKICK3
	.long	INDUCKLOKICK4
	.long	0
	.long	INDUCKLOKICK3
	.long	INDUCKLOKICK2
	.long	INDUCKLOKICK1
	.long	INDUCK3
	.long	0

INDUCKLOKICK1
	.long	INDUCKLOKICK1A,INDUCKLOKICK1B,0
INDUCKLOKICK2
	.long	INDUCKLOKICK2A,INDUCKLOKICK2B,INDUCKLOKICK2C,INDUCKLOKICK2D,0
INDUCKLOKICK3
	.long	INDUCKLOKICK3A,INDUCKLOKICK3B,INDUCKLOKICK3C,0
INDUCKLOKICK4
	.long	INDUCKLOKICK4A,INDUCKLOKICK4B,INDUCKLOKICK4C,0

**************************************************************************

a_uppercut
	.long	INUPPERCUT2
	.long	INUPPERCUT3
	.long	INUPPERCUT4
	.long	INUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
	.long	INUPPERCUT7
	.long	0
	.long	INHIPUNCH1
	.long	0

INUPPERCUT1
	.long	INUPPERCUT1A,INUPPERCUT1B,INUPPERCUT1C,INUPPERCUT1D
	.long	0
INUPPERCUT2
	.long	INUPPERCUT2A,INUPPERCUT2B,INUPPERCUT2C,0
INUPPERCUT3
	.long	INUPPERCUT3A,INUPPERCUT3B,INUPPERCUT3C,0
INUPPERCUT4
	.long	INUPPERCUT4A,INUPPERCUT4B,INUPPERCUT4C,INUPPERCUT4D
	.long	INUPPERCUT4E,0
INUPPERCUT5
	.long	INUPPERCUT5A,INUPPERCUT5B,INUPPERCUT5C,INUPPERCUT5D
	.long	0
INUPPERCUT6
	.long	INUPPERCUT6A,INUPPERCUT6B,INUPPERCUT6C,INUPPERCUT6D
	.long	0
INUPPERCUT7
	.long	INUPPERCUT7A,INUPPERCUT7B,INUPPERCUT7C,INUPPERCUT7D
	.long	0

**************************************************************************

a_block
	.long	INHIBLOCK1
	.long	INHIBLOCK2
	.long	INHIBLOCK3
	.long	0

INHIBLOCK1
	.long	INHIBLOCK1A,INHIBLOCK1B,0
INHIBLOCK2
	.long	INHIBLOCK2A,INHIBLOCK2B,INHIBLOCK2C,0
INHIBLOCK3
	.long	INHIBLOCK3A,INHIBLOCK3B,INHIBLOCK3C,0

**************************************************************************

a_elbow
	.long	INCHOPS1
	.long	INCHOPS2
	.long	ani_nosleep	; dont sleep after next frame
	.long	INCHOPS3
	.long	0
j_unelb	.long	INCHOPS2
	.long	INCHOPS1
	.long	0
*
* part 3 - combo hit #2
*
	.long	INCHOPS4
	.long	INCHOPS5
	.long	0
*
* part 4 - combo hit #3
*
	.long	INCHOPS6
	.long	ani_adjustx
	.word	>08
	.long	INCHOPS7
	.long	ani_adjustx
	.word	>08
	.long	INCHOPS8
	.long	ani_adjustx
	.word	>08
	.long	INCHOPS9
	.long	ani_adjustx
	.word	>08
	.long	0
*
* part 5 - un elbow
*
	.long	ani_jump,j_unelb
	.long	0
*
* part 6 - axe up
*
	.long	ani_jump,a_axe_up
	.long	0


INCHOPS1
	.long	INCHOPS1A,INCHOPS1B,0
INCHOPS2
	.long	INCHOPS2A,INCHOPS2B,0
INCHOPS3
	.long	INCHOPS3A,INCHOPS3B,INCHOPS3C,0
INCHOPS4
	.long	INCHOPS4A,INCHOPS4B,INCHOPS4C,0
INCHOPS5
	.long	INCHOPS5A,INCHOPS5B,INCHOPS5C,INCHOPS5D,0
INCHOPS6
	.long	INCHOPS6A,INCHOPS6B,INCHOPS6C,INCHOPS6D,0
INCHOPS7
	.long	INCHOPS7A,INCHOPS7B,INCHOPS7C,INCHOPS7D,0
INCHOPS8
	.long	INCHOPS8A,INCHOPS8B,INCHOPS8C,0
INCHOPS9
	.long	INCHOPS9A,INCHOPS9B,INCHOPS9C,0

**************************************************************************

a_hipunch
	.long	INHIPUNCH1
	.long	INHIPUNCH2
	.long	INHIPUNCH3
	.long	0

	.long	INHIPUNCH4
	.long	INHIPUNCH5
	.long	INHIPUNCH6
	.long	0

	.long	INHIPUNCH5
	.long	INHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	INHIPUNCH2
	.long	INHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	INHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	INHIPUNCH4
	.long	INLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	INHIPUNCH5
	.long	INLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0


a_lopunch
	.long	INLOPUNCH1
	.long	INLOPUNCH2
	.long	INLOPUNCH3
	.long	0

	.long	INLOPUNCH4
	.long	INLOPUNCH5
	.long	INLOPUNCH6
	.long	0

	.long	INLOPUNCH5
	.long	INLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	INLOPUNCH2
	.long	INLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	INHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	INLOPUNCH4
	.long	INLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	INLOPUNCH4
	.long	INHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)

INHIPUNCH1
	.long	INHIPUNCH1A,INHIPUNCH1B,0
INHIPUNCH2
	.long	INHIPUNCH2A,INHIPUNCH2B,INHIPUNCH2C,0
INHIPUNCH3
	.long	INHIPUNCH3A,INHIPUNCH3B,INHIPUNCH3C,0
INHIPUNCH4
	.long	INHIPUNCH4A,INHIPUNCH4B,INHIPUNCH4C,0
INHIPUNCH5
	.long	INHIPUNCH5A,INHIPUNCH5B,INHIPUNCH5C,0
INHIPUNCH6
	.long	INHIPUNCH6A,INHIPUNCH6B,INHIPUNCH6C,0
INHIPUNCH7
	.long	INHIPUNCH7A,INHIPUNCH7B,INHIPUNCH7C,0

INLOPUNCH1
	.long	INLOPUNCH1A,INLOPUNCH1B,INLOPUNCH1C,0
INLOPUNCH2
	.long	INLOPUNCH2A,INLOPUNCH2B,INLOPUNCH2C,0
INLOPUNCH3
	.long	INLOPUNCH3A,INLOPUNCH3B,INLOPUNCH3C,INLOPUNCH3D,0
INLOPUNCH4
	.long	INLOPUNCH4A,INLOPUNCH4B,INLOPUNCH4C,0
INLOPUNCH5
	.long	INLOPUNCH5A,INLOPUNCH5B,0
INLOPUNCH6
	.long	INLOPUNCH6A,INLOPUNCH6B,INLOPUNCH6C,0

**************************************************************************

a_jump	.long	INJUMP1
	.long	INJUMP2
	.long	INJUMP3
	.long	0

INJUMP1	.long	INJUMP1A,INJUMP1B,INJUMP1C,INJUMP1D
	.long	0
INJUMP2	.long	INJUMP2A,INJUMP2B,INJUMP2C,INJUMP2D
	.long	0
INJUMP3	.long	INJUMP3A,INJUMP3B,INJUMP3C,INJUMP3D
	.long	0

**************************************************************************

a_jump_kick
	.long	INJUMPKICK1
	.long	INJUMPKICK2
	.long	INJUMPKICK3
	.long	0
	.long	INJUMPKICK2
	.long	INJUMPKICK1
	.long	0

INJUMPKICK1
	.long	INJUMPKICK1A,INJUMPKICK1B,0
INJUMPKICK2
	.long	INJUMPKICK2A,INJUMPKICK2B,INJUMPKICK2C,0
INJUMPKICK3
	.long	INJUMPKICK3A,INJUMPKICK3B,INJUMPKICK3C,INJUMPKICK3D
	.long	0

**************************************************************************

a_flip_kick
	.long	INFLIPKICK1
	.long	INFLIPKICK2
	.long	INFLIPKICK3
	.long	0
	.long	INFLIPKICK2
	.long	INFLIPKICK1
	.long	0

INFLIPKICK1
	.long	INFLIPKICK1A,INFLIPKICK1B,0
INFLIPKICK2
	.long	INFLIPKICK2A,INFLIPKICK2B,INFLIPKICK2C,0
INFLIPKICK3
	.long	INFLIPKICK3A,INFLIPKICK3B,0

**************************************************************************

a_flip_punch
	.long	INFLIPUNCH1
	.long	INFLIPUNCH2
	.long	INFLIPUNCH3
	.long	0
	.long	INFLIPUNCH2
	.long	INFLIPUNCH1
	.long	0

INFLIPUNCH1
	.long	INFLIPUNCH1A,INFLIPUNCH1B,0
INFLIPUNCH2
	.long	INFLIPUNCH2A,INFLIPUNCH2B,INFLIPUNCH2C,0
INFLIPUNCH3
	.long	INFLIPUNCH3A,INFLIPUNCH3B,INFLIPUNCH3C,0

**************************************************************************

a_fflip	.long	INJUMPFLIP1
	.long	INJUMPFLIP2
	.long	INJUMPFLIP3
	.long	INJUMPFLIP4
	.long	INJUMPFLIP5
	.long	INJUMPFLIP6
	.long	INJUMPFLIP7
	.long	INJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip	.long	INJUMPFLIP1
	.long	INJUMPFLIP8
	.long	INJUMPFLIP7
	.long	INJUMPFLIP6
	.long	INJUMPFLIP5
	.long	INJUMPFLIP4
	.long	INJUMPFLIP3
	.long	INJUMPFLIP2
	.long	ani_jump,a_bflip+32

INJUMPFLIP1
	.long	INJUMPFLIP1A,INJUMPFLIP1B,INJUMPFLIP1C,0
INJUMPFLIP2
	.long	INJUMPFLIP2A,INJUMPFLIP2B,0
INJUMPFLIP3
	.long	INJUMPFLIP3A,INJUMPFLIP3B,INJUMPFLIP3C,0
INJUMPFLIP4
	.long	INJUMPFLIP4A,INJUMPFLIP4B,0
INJUMPFLIP5
	.long	INJUMPFLIP5A,INJUMPFLIP5B,0
INJUMPFLIP6
	.long	INJUMPFLIP6A,INJUMPFLIP6B,0
INJUMPFLIP7
	.long	INJUMPFLIP7A,INJUMPFLIP7B,INJUMPFLIP7C,0
INJUMPFLIP8
	.long	INJUMPFLIP8A,INJUMPFLIP8B,0

**************************************************************************

a_stumble
	.long	INSTUMBLE1
	.long	INSTUMBLE2
	.long	INSTUMBLE3
	.long	INSTUMBLE4
	.long	INSTUMBLE5
	.long	INSTUMBLE6
	.long	INSTUMBLE7
	.long	0

j_stumble
	.long	INSTUMBLE1
	.long	INSTUMBLE2
	.long	INSTUMBLE3
	.long	INSTUMBLE4
	.long	INSTUMBLE5
	.long	INSTUMBLE6
	.long	INSTUMBLE7
	.long	ani_jump,j_stumble

INSTUMBLE1
	.long	INSTUMBLE1A,INSTUMBLE1B,INSTUMBLE1C,0
INSTUMBLE2
	.long	INSTUMBLE2A,INSTUMBLE2B,INSTUMBLE2C,0
INSTUMBLE3
	.long	INSTUMBLE3A,INSTUMBLE3B,INSTUMBLE3C,INSTUMBLE3D
	.long	0
INSTUMBLE4
	.long	INSTUMBLE4A,INSTUMBLE4B,INSTUMBLE4C,0
INSTUMBLE5
	.long	INSTUMBLE5A,INSTUMBLE5B,INSTUMBLE5C,INSTUMBLE5D
	.long	0
INSTUMBLE6
	.long	INSTUMBLE6A,INSTUMBLE6B,INSTUMBLE6C,0
INSTUMBLE7
	.long	INSTUMBLE7A,INSTUMBLE7B,0

**************************************************************************

a_dizzy
	.long	INSTUNNED1
	.long	INSTUNNED2
	.long	INSTUNNED3
	.long	INSTUNNED4
	.long	INSTUNNED5
	.long	INSTUNNED6
	.long	INSTUNNED7
	.long	INSTUNNED8
	.long	INSTUNNED9
	.long	ani_jump,a_dizzy

INSTUNNED1
	.long	INSTUNNED1A,INSTUNNED1B,INSTUNNED1C,0
INSTUNNED2
	.long	INSTUNNED2A,INSTUNNED2B,0
INSTUNNED3
	.long	INSTUNNED3A,INSTUNNED3B,INSTUNNED3C,0
INSTUNNED4
	.long	INSTUNNED4A,INSTUNNED4B,0
INSTUNNED5
	.long	INSTUNNED5A,INSTUNNED5B,0
INSTUNNED6
	.long	INSTUNNED6A,INSTUNNED6B,0
INSTUNNED7
	.long	INSTUNNED7A,INSTUNNED7B,0
INSTUNNED8
	.long	INSTUNNED8A,INSTUNNED8B,0
INSTUNNED9
	.long	INSTUNNED9A,INSTUNNED9B,INSTUNNED9C,0

**************************************************************************

a_hit_hi
	.long	INHIHIT2
	.long	INHIHIT3
	.long	INHIHIT2
	.long	INHIHIT1
	.long	0

INHIHIT1	.long	INHIHIT1A,INHIHIT1B,INHIHIT1C,INHIHIT1D,0
INHIHIT2	.long	INHIHIT2A,INHIHIT2B,INHIHIT2C,INHIHIT2D,0
INHIHIT3	.long	INHIHIT3A,INHIHIT3B,INHIHIT3C,INHIHIT3D,0

**************************************************************************

a_hit_lo
	.long	INLOHIT2
	.long	INLOHIT3
	.long	INLOHIT2
	.long	INLOHIT1
	.long	0

INLOHIT1	.long	INLOHIT1A,INLOHIT1B,INLOHIT1C,0
INLOHIT2	.long	INLOHIT2A,INLOHIT2B,0
INLOHIT3	.long	INLOHIT3A,INLOHIT3B,INLOHIT3C,0

**************************************************************************

a_knockdown
	.long	INKNOCKDOWN1
	.long	INKNOCKDOWN2
	.long	INKNOCKDOWN3
	.long	INKNOCKDOWN4
	.long	INKNOCKDOWN5
	.long	0

	.long	INKNOCKDOWN6
	.long	INKNOCKDOWN7
	.long	0

INKNOCKDOWN1
	.long	INKNOCKDOWN1A,INKNOCKDOWN1B,0
INKNOCKDOWN2
	.long	INKNOCKDOWN2A,INKNOCKDOWN2B,INKNOCKDOWN2C,0
INKNOCKDOWN3
	.long	INKNOCKDOWN3A,INKNOCKDOWN3B,INKNOCKDOWN3C,INKNOCKDOWN3D
	.long	INKNOCKDOWN3E,0
INKNOCKDOWN4
	.long	INKNOCKDOWN4A,INKNOCKDOWN4B,INKNOCKDOWN4C,0
INKNOCKDOWN5
	.long	INKNOCKDOWN5A,INKNOCKDOWN5B,INKNOCKDOWN5C,0
INKNOCKDOWN6
	.long	INKNOCKDOWN6A,INKNOCKDOWN6B,INKNOCKDOWN6C,0
INKNOCKDOWN7
	.long	INKNOCKDOWN7A,INKNOCKDOWN7B,0

**************************************************************************

a_getup
	.long	INGETUP1
	.long	INGETUP2
	.long	INGETUP3
	.long	INGETUP4
	.long	INGETUP5
	.long	INGETUP6
	.long	INGETUP7
	.long	0

INGETUP1
	.long	INGETUP1A,INGETUP1B,INGETUP1C,INGETUP1D
	.long	0
INGETUP2
	.long	INGETUP2A,INGETUP2B,0
INGETUP3
	.long	INGETUP3A,INGETUP3B,0
INGETUP4
	.long	INGETUP4A,INGETUP4B,0
INGETUP5
	.long	INGETUP5A,INGETUP5B,INGETUP5C,INGETUP5D
	.long	0
INGETUP6
	.long	INGETUP6A,INGETUP6B,0
INGETUP7
	.long	INGETUP7A,INGETUP7B,INGETUP7C,0

**************************************************************************

a_throw
	.long	INFLIP1
	.long	INFLIP2		; grab
	.long	0

	.long	INFLIP3
	.long	INFLIP4
	.long	INFLIP5
	.long	INFLIP6
	.long	INFLIP7
	.long	INFLIP8		; animate 2-gether
	.long	0

	.long	INFLIP9
	.long	0

INFLIP1	.long	INFLIP1A,INFLIP1B,INFLIP1C,INFLIP1D,0
INFLIP2	.long	INFLIP2A,INFLIP2B,INFLIP2C,INFLIP2D,0
INFLIP3	.long	INFLIP3A,INFLIP3B,INFLIP3C,INFLIP3D,0
INFLIP4	.long	INFLIP4A,INFLIP4B,0
INFLIP5	.long	INFLIP5A,INFLIP5B,0
INFLIP6	.long	INFLIP6A,INFLIP6B,INFLIP6C,0
INFLIP7	.long	INFLIP7A,INFLIP7B,INFLIP7C,0
INFLIP8	.long	INFLIP8A,INFLIP8B,INFLIP8C,0
INFLIP9	.long	INFLIP9A,INFLIP9B,INFLIP9C,0

**************************************************************************


INFLIPPED1
	.long	INGETFLIPPED1A,INGETFLIPPED1B,0
INFLIPPED2
	.long	INGETFLIPPED2A,INGETFLIPPED2B,0
INFLIPPED3
	.long	INGETFLIPPED3A,INGETFLIPPED3B,0
INFLIPPED4
	.long	INGETFLIPPED4A,INGETFLIPPED4B,0
INFLIPPED5
	.long	INGETFLIPPED5A,INGETFLIPPED5B,0

a_afb_kano
	.long	ani_offset_xy
	.word	->40,->1b
	.long	INFLIPPED1

	.long	ani_offset_xy
	.word	->3c,->0b
	.long	INKNOCKDOWN4

	.long	ani_offset_xy
 	.word	->59,>22
	.long	INKNOCKDOWN5
	.long	0
*
* fall down solo
*
	.long	INKNOCKDOWN5
	.long	INKNOCKDOWN6
	.long	INKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	->1e,->38
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	>01,->48
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>30,->38
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>49,->1e
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>58,->15
	.long	INKNOCKDOWN6
	.long	ani_offset_xy
	.word	>62,>1a
	.long	INKNOCKDOWN6
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	->3f,->1b
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->28,->2e
	.long	INFLIPPED2
	.long	ani_offset_xy
 	.word	>35,->37
	.long	INFLIPPED3
	.long	0

	.long	INFLIPPED4
	.long	INFLIPPED5
	.long	INKNOCKDOWN5
	.long	INKNOCKDOWN6
	.long	INKNOCKDOWN7
	.long	0


a_fb_sonya
	.long	ani_offset_xy
	.word	->39,->05
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->1f,>01
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	>0e,->09
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>4f,->15
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>8c,->21
	.long	INFLIPPED4
	.long	0

	.long	INFLIPPED5
	.long	INKNOCKDOWN5
	.long	INKNOCKDOWN6
	.long	INKNOCKDOWN7
	.long	0


a_fb_jax
	.long	ani_offset_xy
	.word	->43,->1f
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->23,->3e
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	>10,->4b
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>42,->1d
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>5c,>05
	.long	INKNOCKDOWN6
	.long	ani_offset_xy
	.word	>49,>0a
	.long	INKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	->5c,->18
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->48,->3e
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	->13,->58
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>2d,->3e
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>4e,->0b
	.long	INFLIPPED5
	.long	ani_offset_xy
	.word	>58,->02
	.long	INKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	->49,->32
	.long	INFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	>51,->1f
	.long	INFLIPPED5

	.long	ani_offset_xy
	.word	>40,>05
	.long	INFLIPPED5

	.long	ani_offset_xy
	.word	->04,->08
	.long	INKNOCKDOWN5

	.long	ani_offset_xy
	.word	->47,->33
	.long	INKNOCKDOWN5

	.long	ani_offset_xy
	.word	->72,->60
	.long	INKNOCKDOWN5
	.long	0


a_fb_swat
	.long	ani_offset_xy
	.word	->50,->0d
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->3c,->41
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	>23,->50
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>56,->13
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>4a,>06
	.long	INKNOCKDOWN6
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	->64,>00
	.long	INSTUMBLE1
	.long	ani_offset_xy
	.word	->73,>03
	.long	INSTUMBLE1

	.long	ani_offset_xy
	.word	->75,->1e
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->57,->3d
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->23,->46
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	>1e,->4e
	.long	INFLIPPED1

	.long	ani_offset_xy
	.word	>a8,>12
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>8d,>00
	.long	INKNOCKDOWN7
	.long	0


a_fb_robo
	.long	ani_offset_xy
	.word	->52,->0b
	.long	INFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->4f,->32
	.long	INFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->38,->48
	.long	INFLIPPED2		; 3

	.long	ani_offset_xy
	.word	->0a,->6c
	.long	INFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>38,->62
	.long	INFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>5c,->50
	.long	INFLIPPED4		; 6

	.long	ani_offset_xy
	.word	>7b,->13
	.long	INFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5a,->11
	.long	INKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	->30,->07
	.long	INSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->2c,->1d
	.long	INFLIPPED1		; 2
	.long	ani_offset_xy
	.word	->0e,->2a
	.long	INFLIPPED2		; 3
	.long	ani_offset_xy
	.word	>16,->21
	.long	INFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>25,>03
	.long	INFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>18,>16
	.long	INFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->1e,->11
	.long	INKNOCKDOWN7		; 7
	.long	0



a_fb_lao
	.long	ani_offset_xy
	.word	->1d,>1a
	.long	INSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->06,>2a
	.long	INSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	->29,>22
	.long	INFLIPPED1		; 3
	.long	ani_offset_xy
	.word	->4a,->0f
	.long	INFLIPPED2		; 4
	.long	ani_offset_xy
	.word	->32,->4f
	.long	INFLIPPED3		; 5
	.long	ani_offset_xy
	.word	>10,->67
	.long	INFLIPPED4		; 6
	.long	ani_offset_xy
	.word	>53,->6a
	.long	INFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5e,->51
	.long	INFLIPPED5		; 8
	.long	ani_offset_xy
	.word	>77,>02
	.long	INFLIPPED5		; 9
	.long	ani_offset_xy
	.word	>77,>52
	.long	INFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	->72,>00
	.long	INFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->5d,->4a
	.long	INFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->1b,->78
	.long	INFLIPPED3		; 3
	.long	ani_offset_xy
	.word	>39,->50
	.long	INFLIPPED4		; 4
	.long	ani_offset_xy
	.word	>44,->0c
	.long	INFLIPPED5		; 5

	.long	ani_offset_xy
	.word	>0f,>1e
	.long	INFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->31,->14
  	.long	INKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	->68,>01
	.long	INFLIPPED1		; 8
	.long	ani_offset_xy
	.word	->4e,->54
	.long	INFLIPPED2		; 9
	.long	ani_offset_xy
	.word	>1b,->66
	.long	INFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	>65,->05
	.long	INFLIPPED5		; 11
	.long	ani_offset_xy
	.word	>64,>09
  	.long	INKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	->3d,->30
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->08,->52
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	->01,->5e
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>18,->4f
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>1a,->35
	.long	INFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	->26,->09
  	.long	INKNOCKDOWN7
	.long	0

a_fb_st
	.long	ani_offset_xy
	.word	->4c,>00
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->41,>07
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->2a,>01
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	->07,>03
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>0e,>25
	.long	INFLIPPED4

	.long	ani_offset_xy
	.word	->0f,->04
	.long	INKNOCKDOWN6
	.long	ani_offset_xy
	.word	->23,->04
	.long	INKNOCKDOWN6
	.long	ani_offset_xy
	.word	->38,->04
	.long	INKNOCKDOWN6

	.long	ani_offset_xy
	.word	->60,>19
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->67,->0b
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->3c,->4c
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	>2b,->41
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>4c,->18
	.long	INFLIPPED5
	.long	ani_offset_xy
	.word	>5b,->08
	.long	INKNOCKDOWN6
	.long	0


a_fb_lk
	.long	ani_offset_xy
	.word	->44,->01
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->3b,>07
	.long	INFLIPPED1
	.long	ani_offset_xy
	.word	->13,>02
	.long	INFLIPPED2
	.long	ani_offset_xy
	.word	>10,>00
	.long	INFLIPPED3
	.long	ani_offset_xy
	.word	>37,>09
	.long	INFLIPPED4
	.long	ani_offset_xy
	.word	>88,->1f
	.long	INFLIPPED4
	.long	0

	.long	INFLIPPED5
	.long	INKNOCKDOWN5
	.long	INKNOCKDOWN6
	.long	INKNOCKDOWN7
	.long	0


a_legged
	.long	ani_offset_xy
	.word	->5d,->07
	.long	INKNOCKDOWN1

	.long	ani_offset_xy
	.word	->51,->30
	.long	INFLIPPED1

	.long	ani_offset_xy
	.word	->0c,->4a
	.long	INFLIPPED3

	.long	ani_offset_xy
	.word	>37,->2d
	.long	INFLIPPED4

	.long	ani_offset_xy
	.word	>5e,>00
	.long	INFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	>55,->1c
	.long	INKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	>57,>01
	.long	INKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	>27,>09
	.long	INKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	->30,>12
	.long	INKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	->8f,->0a
	.long	INFLIPPED1	; 5

	.long	ani_offset_xy
	.word	->41,->55
	.long	INFLIPPED3	; 6
	.long	0

	.long	INFLIPPED3
	.long	INFLIPPED4
	.long	INFLIPPED5
	.long	INKNOCKDOWN5
	.long	INKNOCKDOWN6
	.long	INKNOCKDOWN7
	.long	0


a_shook
	.long	ani_offset_xy
	.word	->4a,->0d
	.long	INSTUMBLE2	; 3

	.long	ani_offset_xy
	.word	->31,->26
	.long	INSTUMBLE2	; 4

	.long	ani_offset_xy
	.word	->1b,->24
	.long	INSTUMBLE2	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	->1d,->26
	.long	INSTUMBLE2	; 6

	.long	ani_offset_xy
	.word	->2d,->30
	.long	INSTUMBLE2	; 7

	.long	ani_offset_xy
	.word	->3d,->34	
	.long	INSTUMBLE2	; 8

	.long	ani_offset_xy
	.word	->2d,->30
	.long	INSTUMBLE2	; 7
	.long	0


**************************************************************************

a_sweepup
;	.long	INSWEEPUP1		; this is now part of sweepfall !

	.long	INSWEEPUP2
	.long	INSWEEPUP3
	.long	INSWEEPUP4
	.long	INSWEEPUP5
	.long	INSWEEPUP6
	.long	0

INSWEEPUP1
	.long	INSWEEPUP1A,INSWEEPUP1B,INSWEEPUP1C,0
INSWEEPUP2
	.long	INSWEEPUP2A,INSWEEPUP2B,INSWEEPUP2C,0
INSWEEPUP3
	.long	INSWEEPUP3A,INSWEEPUP3B,0
INSWEEPUP4
	.long	INSWEEPUP4A,INSWEEPUP4B,0
INSWEEPUP5
	.long	INSWEEPUP5A,INSWEEPUP5B,0
INSWEEPUP6
	.long	INSWEEPUP6A,INSWEEPUP6B,INSWEEPUP6C,INSWEEPUP6D
	.long	0

**************************************************************************

a_sweep_fall
	.long	INSWEEPFALL1
	.long	INSWEEPFALL2
	.long	INSWEEPFALL3
	.long	INSWEEPFALL4
	.long	0
	.long	INSWEEPFALL5
	.long	INSWEEPFALL6
	.long	INSWEEPUP1
	.long	0

INSWEEPFALL1
	.long	INSWEEPFALL1A,INSWEEPFALL1B,INSWEEPFALL1C,INSWEEPFALL1D
	.long	0
INSWEEPFALL2
	.long	INSWEEPFALL2A,INSWEEPFALL2B,INSWEEPFALL2C,INSWEEPFALL2D
	.long	0
INSWEEPFALL3
	.long	INSWEEPFALL3A,INSWEEPFALL3B,0
INSWEEPFALL4
	.long	INSWEEPFALL4A,INSWEEPFALL4B,INSWEEPFALL4C,0
INSWEEPFALL5
	.long	INSWEEPFALL5A,INSWEEPFALL5B,0
INSWEEPFALL6
	.long	INSWEEPFALL6A,INSWEEPFALL6B,INSWEEPFALL6C,0

**************************************************************************

a_hikick
	.long	INLOKICK1
	.long	INLOKICK2
	.long	INLOKICK3
	.long	INLOKICK4
	.long	INLOKICK5
	.long	INHIKICK1
	.long	0
	.long	INLOKICK5
	.long	INLOKICK4
	.long	INLOKICK3
	.long	INLOKICK2
	.long	INLOKICK1
	.long	0

a_lokick
	.long	INLOKICK1 
	.long	INLOKICK2
	.long	INLOKICK3
	.long	INLOKICK4
	.long	INLOKICK5
	.long	INLOKICK6
	.long	0
	.long	INLOKICK5
	.long	INLOKICK4
	.long	INLOKICK3
	.long	INLOKICK2
	.long	INLOKICK1
	.long	0

INLOKICK1
	.long	INLOKICK1A,INLOKICK1B,INLOKICK1C,INLOKICK1D,0
INLOKICK2
	.long	INLOKICK2A,INLOKICK2B,INLOKICK2C,0
INLOKICK3
	.long	INLOKICK3A,INLOKICK3B,INLOKICK3C,0
INLOKICK4
	.long	INLOKICK4A,INLOKICK4B,INLOKICK4C,0
INLOKICK5
	.long	INLOKICK5A,INLOKICK5B,INLOKICK5C,0
INLOKICK6
	.long	INLOKICK6A,INLOKICK6B,INLOKICK6C,0

INHIKICK1
	.long	INHIKICK1A,INHIKICK1B,INHIKICK1C,INHIKICK1D,0

**************************************************************************

a_knee
	.long	INKNEEBREAK1
	.long	INKNEEBREAK2
	.long	INKNEEBREAK3
	.long	INKNEEBREAK4
	.long	0
	.long	INKNEEBREAK3
	.long	INKNEEBREAK2
	.long	INKNEEBREAK1
	.long	0

INKNEEBREAK1
	.long	INKNEEBREAK1A,INKNEEBREAK1B,INKNEEBREAK1C,0
INKNEEBREAK2
	.long	INKNEEBREAK2A,INKNEEBREAK2B,INKNEEBREAK2C,0
INKNEEBREAK3
	.long	INKNEEBREAK3A,INKNEEBREAK3B,INKNEEBREAK3C,0
INKNEEBREAK4
	.long	INKNEEBREAK4A,INKNEEBREAK4B,0

**************************************************************************

a_sweep_kick
	.long	INSWEEPKICK1
	.long	INSWEEPKICK2
	.long	INSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	INSWEEPKICK4
	.long	INSWEEPKICK5
	.long	0

	.long	INSWEEPKICK6
	.long	INSWEEPKICK7
	.long	INSWEEPKICK8
	.long	0

INSWEEPKICK1
	.long	INSWEEPKICK1A,INSWEEPKICK1B,INSWEEPKICK1C,0
INSWEEPKICK2
	.long	INSWEEPKICK2A,INSWEEPKICK2B,INSWEEPKICK2C,0
INSWEEPKICK3
	.long	INSWEEPKICK3A,INSWEEPKICK3B,INSWEEPKICK3C,0
INSWEEPKICK4
	.long	INSWEEPKICK4A,INSWEEPKICK4B,INSWEEPKICK4C,INSWEEPKICK4D
	.long	INSWEEPKICK4E,0
INSWEEPKICK5
	.long	INSWEEPKICK5A,INSWEEPKICK5B,INSWEEPKICK5C,INSWEEPKICK5D
	.long	INSWEEPKICK5E,0
INSWEEPKICK6
	.long	INSWEEPKICK6A,INSWEEPKICK6B,INSWEEPKICK6C,0
INSWEEPKICK7
	.long	INSWEEPKICK7A,INSWEEPKICK7B,0
INSWEEPKICK8
	.long	INSWEEPKICK8A,INSWEEPKICK8B,0

**************************************************************************

a_roundhouse
	.long	INROUNDKICK1
	.long	INROUNDKICK2
	.long	INROUNDKICK3
	.long	INROUNDKICK4
	.long	ani_nosleep
	.long	INROUNDKICK5
	.long	0
	.long	INROUNDKICK6
	.long	INROUNDKICK7
	.long	INROUNDKICK8
	.long	0

INROUNDKICK1
	.long	INROUNDKICK1A,INROUNDKICK1B,INROUNDKICK1C,0
INROUNDKICK2
	.long	INROUNDKICK2A,INROUNDKICK2B,0
INROUNDKICK3
	.long	INROUNDKICK3A,INROUNDKICK3B,INROUNDKICK3C,0
INROUNDKICK4
	.long	INROUNDKICK4A,INROUNDKICK4B,INROUNDKICK4C,INROUNDKICK4D,0
INROUNDKICK5
	.long	INROUNDKICK5A,INROUNDKICK5B,INROUNDKICK5C,0
INROUNDKICK6
	.long	INROUNDKICK6A,INROUNDKICK6B,INROUNDKICK6C,0
INROUNDKICK7
	.long	INROUNDKICK7A,INROUNDKICK7B,0
INROUNDKICK8
	.long	INROUNDKICK8A,INROUNDKICK8B,INROUNDKICK8C,0

**************************************************************************

a_victory
	.long	INVICTORY1
	.long	INVICTORY2
	.long	INVICTORY3
	.long	INVICTORY4
	.long	INVICTORY5
	.long	INVICTORY6
	.long	INVICTORY7
	.long	0

	.long	ani_sladd,FLAME1
	.long	INVICTORY7

	.long	ani_slani,FLAME2
	.long	INVICTORY7

j_flame	.long	ani_slani,FLAME3
	.long	INVICTORY7

	.long	ani_slani,FLAME4
	.long	INVICTORY7

	.long	ani_slani,FLAME5
	.long	INVICTORY7

	.long	ani_slani,FLAME6
	.long	INVICTORY7

	.long	ani_jump,j_flame

INVICTORY1
	.long	INVICTORY1A,INVICTORY1B,INVICTORY1C,0
INVICTORY2
	.long	INVICTORY2A,INVICTORY2B,INVICTORY2C,INVICTORY2D,0
INVICTORY3
	.long	INVICTORY3A,INVICTORY3B,INVICTORY3C,INVICTORY3D,0
INVICTORY4
	.long	INVICTORY4A,INVICTORY4B,INVICTORY4C,0
INVICTORY5
	.long	INVICTORY5A,INVICTORY5B,INVICTORY5C,0
INVICTORY6
	.long	INVICTORY6A,INVICTORY6B,INVICTORY6C,INVICTORY6D,0
INVICTORY7
	.long	INVICTORY7A,INVICTORY7B,INVICTORY7C,INVICTORY7D,INVICTORY7E,0

FLAME1	.long	INVICFLAME1A,INVICFLAME1B,0
FLAME2	.long	INVICFLAME2A,INVICFLAME2B,0
FLAME3	.long	INVICFLAME3A,INVICFLAME3B,0
FLAME4	.long	INVICFLAME4A,INVICFLAME4B,INVICFLAME4C,0
FLAME5	.long	INVICFLAME5A,INVICFLAME5B,INVICFLAME5C,0
FLAME6	.long	INVICFLAME6A,INVICFLAME6B,INVICFLAME6C,0


**************************************************************************

a_run
	.long	ININTORUN1
	.long	ININTORUN2
	.long	ININTORUN3
j_run	.long	INRUN1
	.long	INRUN2
	.long	INRUN3
	.long	INRUN4
	.long	ani_calla,rsnd_footstep
	.long	INRUN5
	.long	INRUN6
	.long	INRUN7
	.long	INRUN8
	.long	INRUN9
	.long	ani_calla,rsnd_footstep
	.long	INRUN10
	.long	INRUN11
	.long	INRUN12
	.long	INRUN13
	.long	ani_jump,j_run
	.long	0			; we need this zero !!

ININTORUN1
	.long	ININTORUN1A,ININTORUN1B,ININTORUN1C,ININTORUN1D,0
ININTORUN2
	.long	ININTORUN2A,ININTORUN2B,ININTORUN2C,ININTORUN2D,0
ININTORUN3
	.long	ININTORUN3A,ININTORUN3B,ININTORUN3C,0
INRUN1
	.long	INRUN1A,INRUN1B,0
INRUN2
	.long	INRUN2A,INRUN2B,0
INRUN3
	.long	INRUN3A,INRUN3B,0
INRUN4
	.long	INRUN4A,INRUN4B,INRUN4C,0
INRUN5
	.long	INRUN5A,INRUN5B,INRUN5C,INRUN5D,0
INRUN6
	.long	INRUN6A,INRUN6B,INRUN6C,0
INRUN7
	.long	INRUN7A,INRUN7B,INRUN7C,INRUN7D,0
INRUN8
	.long	INRUN8A,INRUN8B,INRUN8C,0
INRUN9
	.long	INRUN9A,INRUN9B,INRUN9C,INRUN9D,0
INRUN10
	.long	INRUN10A,INRUN10B,INRUN10C,0
INRUN11
	.long	INRUN11A,INRUN11B,INRUN11C,INRUN11D,0
INRUN12
	.long	INRUN12A,INRUN12B,INRUN12C,0
INRUN13
	.long	INRUN13A,INRUN13B,0

;***********************************************************************

a_zap	.long	ani_sladd,INBOWNARROW1,INARROW1 ; introduce ---> arrow obj
	.long	ani_slani,INBOWNARROW2,INARROW2
	.long	ani_slani,INBOWNARROW3,INARROW3
	.long	ani_slani,INBOWNARROW4,INARROW4
	.long	ani_slani,INBOWNARROW5,INARROW5
	.long	ani_slani,INBOWNARROW6,INARROW6
	.long	0

	.long	ani_slani,INBOWNARROW7,INARROW7
	.long	ani_slani,INBOWNARROW8,INARROW7
	.long	ani_slani,INBOWNARROW9,INARROW7
	.long	ani_slani,INBOWNARROW10,INARROW7
	.long	ani_slani,INBOWNARROW11,INARROW7
	.long	ani_slani,INBOWNARROW12,INARROW7
	.long	ani_slani,INBOWNARROW13,INARROW7
	.long	ani_calla,delete_slave
	.long	INARROW7
	.long	INARROW4
	.long	INARROW3
	.long	INARROW2
	.long	INARROW1
	.long	0
*
* part 3 = flying arrow
*
j_arrow	.long	INBOWNARROW14
	.long	INBOWNARROW15
	.long	ani_jump,j_arrow
	.long	0
*
* part 4 = arrow hit
*
	.long	INBOWNARROW15
	.long	INBOWNARROW16
	.long	INBOWNARROW17
	.long	INBOWNARROW18
	.long	INBOWNARROW19
	.long	INBOWNARROW20
	.long	0


a_projectile
	.long	INBOWNARROW1		; we need this


INARROW1	.long	INARROW1A,INARROW1B,INARROW1C,0
INARROW2	.long	INARROW2A,INARROW2B,INARROW2C,0
INARROW3	.long	INARROW3A,INARROW3B,INARROW3C,0
INARROW4	.long	INARROW4A,INARROW4B,INARROW4C,0
INARROW5	.long	INARROW5A,INARROW5B,0
INARROW6	.long	INARROW6A,INARROW6B,INARROW6C,0
INARROW7	.long	INARROW7A,INARROW7B,0

INBOWNARROW20
	.long	INBOWNARROW20A,INBOWNARROW20B,0
INBOWNARROW19
	.long	INBOWNARROW19A,INBOWNARROW19B,0
INBOWNARROW18
	.long	INBOWNARROW18A,0
INBOWNARROW17
	.long	INBOWNARROW17A,0
INBOWNARROW16
	.long	INBOWNARROW16A,0
INBOWNARROW15
	.long	INBOWNARROW15A,0
INBOWNARROW14
	.long	INBOWNARROW14A,0
INBOWNARROW13
	.long	INBOWNARROW13A,INBOWNARROW13B,0
INBOWNARROW12
	.long	INBOWNARROW12A,INBOWNARROW12B,0
INBOWNARROW11
	.long	INBOWNARROW11A,INBOWNARROW11B,0
INBOWNARROW10
	.long	INBOWNARROW10A,INBOWNARROW10B,0
INBOWNARROW9
	.long	INBOWNARROW9A,INBOWNARROW9B,0
INBOWNARROW8
	.long	INBOWNARROW8A,INBOWNARROW8B,0
INBOWNARROW7
	.long	INBOWNARROW7A,INBOWNARROW7B,0
INBOWNARROW6
	.long	INBOWNARROW6A,INBOWNARROW6B,0
INBOWNARROW5
	.long	INBOWNARROW5A,INBOWNARROW5B,0
INBOWNARROW4
	.long	INBOWNARROW4A,INBOWNARROW4B,0
INBOWNARROW3
	.long	INBOWNARROW3A,INBOWNARROW3B,0
INBOWNARROW2
	.long	INBOWNARROW2A,INBOWNARROW2B,0
INBOWNARROW1
	.long	INBOWNARROW1A,0

;***********************************************************************

a_horz_swipe
	.long	ani_sladd,HAXE1,INAXESWIPE1
	.long	ani_slani,HAXE2,INAXESWIPE2
	.long	ani_slani,HAXE3,INAXESWIPE3
	.long	0
	.long	ani_slani,HAXE4,INAXESWIPE4
	.long	ani_slani,HAXE5,INAXESWIPE5
	.long	ani_slani,HAXE6,INAXESWIPE6
	.long	ani_slani,HAXE7,INAXESWIPE6
	.long	ani_slani,HAXE8,INAXESWIPE6
	.long	0

	.long	INAXESWIPE5
	.long	INAXESWIPE4
	.long	INAXESWIPE3
	.long	INAXESWIPE2
	.long	INAXESWIPE1
	.long	0

INAXESWIPE1
	.long	INAXESWIPE1A,INAXESWIPE1B,INAXESWIPE1C,0
INAXESWIPE2
	.long	INAXESWIPE2A,INAXESWIPE2B,INAXESWIPE2C,0
INAXESWIPE3
	.long	INAXESWIPE3A,INAXESWIPE3B,INAXESWIPE3C,INAXESWIPE3D,0
INAXESWIPE4
	.long	INAXESWIPE4A,INAXESWIPE4B,INAXESWIPE4C,0
INAXESWIPE5
	.long	INAXESWIPE5A,INAXESWIPE5B,INAXESWIPE5C,0
INAXESWIPE6
	.long	INAXESWIPE6A,INAXESWIPE6B,INAXESWIPE6C,INAXESWIPE6D,INAXESWIPE6E,0

; homeasm
HAXE8
;	.long	HAXE8A,HAXE8B,0
HAXE7
;	.long	HAXE7A,HAXE7B,0
HAXE6
;	.long	HAXE6A,HAXE6B,HAXE6C,HAXE6D,0
HAXE5
;	.long	HAXE5A,HAXE5B,HAXE5C,HAXE5D,0
HAXE4
;	.long	HAXE4A,HAXE4B,HAXE4C,0
HAXE3
;	.long	HAXE3A,HAXE3B,HAXE3C,0
HAXE2
;	.long	HAXE2A,HAXE2B,0
HAXE1
;	.long	HAXE1A,0

;***********************************************************************

a_axe_chop
	.long	INAXECHOP1
	.long	INAXECHOP2
	.long	INAXECHOP3
	.long	INAXECHOP4
	.long	INAXECHOP5
	.long	INAXECHOP6
	.long	INAXECHOP7
	.long	0

INAXECHOP1
	.long	INAXECHOP1A,INAXECHOP1B,INAXECHOP1C,0
INAXECHOP2
	.long	INAXECHOP2A,INAXECHOP2B,0
INAXECHOP3
	.long	INAXECHOP3A,INAXECHOP3B,0
INAXECHOP4
	.long	INAXECHOP4A,INAXECHOP4B,0
INAXECHOP5
	.long	INAXECHOP5A,INAXECHOP5B,INAXECHOP5C,0
INAXECHOP6
	.long	INAXECHOP6A,INAXECHOP6B,INAXECHOP6C,0
INAXECHOP7
	.long	INAXECHOP7A,INAXECHOP7B,INAXECHOP7C,0

;***********************************************************************

a_axe_up
	.long	ani_sladd,UPRCUTAXE1,INUPSWING1
	.long	ani_slani,UPRCUTAXE2,INUPSWING2
	.long	ani_slani,UPRCUTAXE3,INUPSWING3
	.long	ani_slani,UPRCUTAXE4,INUPSWING4
	.long	0

	.long	ani_slani,UPRCUTAXE5,INUPSWING5
	.long	ani_slani,UPRCUTAXE6,INUPSWING6
	.long	ani_slani,UPRCUTAXE7,INUPSWING6
	.long	0

	.long	INUPSWING6
	.long	INUPSWING5
	.long	INUPSWING4
	.long	INUPSWING3
	.long	INUPSWING2
	.long	0

INUPSWING1
	.long	INUPSWING1A,INUPSWING1B,INUPSWING1C,0
INUPSWING2
	.long	INUPSWING2A,INUPSWING2B,0
INUPSWING3
	.long	INUPSWING3A,INUPSWING3B,INUPSWING3C,INUPSWING3D,0
INUPSWING4
	.long	INUPSWING4A,INUPSWING4B,INUPSWING4C,INUPSWING4D,0
INUPSWING5
	.long	INUPSWING5A,INUPSWING5B,INUPSWING5C,0
INUPSWING6
	.long	INUPSWING6A,INUPSWING6B,0

UPRCUTAXE7
	.long	UPRCUTAXE7A,0
UPRCUTAXE6
	.long	UPRCUTAXE6A,UPRCUTAXE6B,0
UPRCUTAXE5
	.long	UPRCUTAXE5A,UPRCUTAXE5B,0
UPRCUTAXE4
	.long	UPRCUTAXE4A,UPRCUTAXE4B,0
UPRCUTAXE3
	.long	UPRCUTAXE3A,UPRCUTAXE3B,UPRCUTAXE3C,0
UPRCUTAXE2
	.long	UPRCUTAXE2A,UPRCUTAXE2B,0
UPRCUTAXE1
	.long	UPRCUTAXE1A,0

;***********************************************************************

a_reflect
	.long	INREFLECT1
	.long	ani_sladd,IREFGLOW1,INREFLECT2
	.long	ani_slani,IREFGLOW2,INREFLECT3
	.long	ani_slani,IREFGLOW3,INREFLECT3
	.long	ani_slani,IREFGLOW4,INREFLECT3
	.long	ani_slani,IREFGLOW5,INREFLECT3
	.long	0

	.long	ani_slani,IREFGLOW4,INREFLECT3
	.long	ani_slani,IREFGLOW3,INREFLECT3
	.long	ani_slani,IREFGLOW2,INREFLECT3
	.long	ani_slani,IREFGLOW3,INREFLECT3
	.long	ani_slani,IREFGLOW4,INREFLECT3
	.long	ani_slani,IREFGLOW5,INREFLECT3
	.long	0

	.long	INREFLECT2
	.long	INREFLECT1
	.long	0

IREFPRO6	.long	IREFPRO6A,0
IREFPRO5	.long	IREFPRO5A,0
IREFPRO4	.long	IREFPRO4A,0
IREFPRO3	.long	IREFPRO3A,0
IREFPRO2	.long	IREFPRO2A,0
IREFPRO1	.long	IREFPRO1A,0


IREFGLOW5
	.long	IREFGLOW5A,IREFGLOW5B,IREFGLOW5C,IREFGLOW5D,0
IREFGLOW4
	.long	IREFGLOW4A,IREFGLOW4B,IREFGLOW4C,IREFGLOW4D,0
IREFGLOW3
	.long	IREFGLOW3A,IREFGLOW3B,IREFGLOW3C,IREFGLOW3D,0
IREFGLOW2
	.long	IREFGLOW2A,IREFGLOW2B,IREFGLOW2C,IREFGLOW2D,0
IREFGLOW1
	.long	IREFGLOW1A,IREFGLOW1B,IREFGLOW1C,0

INREFLECT1
	.long	INREFLECT1A,INREFLECT1B,INREFLECT1C,0
INREFLECT2
	.long	INREFLECT2A,INREFLECT2B,INREFLECT2C,0
INREFLECT3
	.long	INREFLECT3A,INREFLECT3B,INREFLECT3C,0

;***********************************************************************

a_indy_charge
	.long	INCHARGE1
	.long	INCHARGE2
	.long	INCHARGE3
	.long	0
	.long	INCHARGE2
	.long	INCHARGE1
	.long	0

INCHARGE1
	.long	INCHARGE1A,INCHARGE1B,INCHARGE1C,0
INCHARGE2
	.long	INCHARGE2A,INCHARGE2B,INCHARGE2C,0
INCHARGE3
	.long	INCHARGE3A,INCHARGE3B,INCHARGE3C,0

;***********************************************************************

VAXE6
	.long	VAXE6A,VAXE6B,0
VAXE5
	.long	VAXE5A,VAXE5B,0
VAXE4
	.long	VAXE4A,VAXE4B,0
VAXE3
	.long	VAXE3A,VAXE3B,VAXE3C,0
VAXE2
	.long	VAXE2A,VAXE2B,0
VAXE1
	.long	VAXE1A,0

;***********************************************************************

a_scared
	.long	INSCARED2
	.long	0

INSCARED2
	.long	INSCARED2A,0


a_thudd
	.long	INTHUD1
	.long	INTHUD2
	.long	INTHUD3
	.long	INTHUD4
	.long	INTHUD5
	.long	INTHUD6
	.long	INTHUD7
	.long	0

INTHUD1
	.long	INTHUD1A,0
INTHUD2
	.long	INTHUD2A,0
INTHUD3
	.long	INTHUD3A,0
INTHUD4
	.long	INTHUD4A,0
INTHUD5
	.long	INTHUD5A,0
INTHUD6
	.long	INTHUD6A,0
INTHUD7
	.long	INTHUD7A,0

;******************************************************

a_sky_light
	.long	INSKYLIGHT2
	.long	INSKYLIGHT4
	.long	0
	.long	INSKYLIGHT5
	.long	INSKYLIGHT6
	.long	INSKYLIGHT7
	.long	INSKYLIGHT8
	.long	INSKYLIGHT9
	.long	0

a_sky_zap
	.long	ZAP2
	.long	ZAP3
	.long	ZAP4
	.long	ZAP5	
	.long	ZAP6

	.long	ZAP7
	.long	ZAP8
	.long	ZAP9
	.long	ZAP8
	.long	ZAP7
	.long	ZAP8
	.long	ZAP9
	.long	ZAP8
	.long	ZAP7
	.long	ZAP8
	.long	ZAP9
	.long	ZAP8
	.long	ZAP7
	.long	ZAP8
	.long	ZAP9

	.long	ZAP10
	.long	ZAP11
	.long	ZAP12
	.long	ZAP13
	.long	ZAP14
	.long	ZAP15
	.long	0


ZAP2
	.long	ZAP2A,ZAP2B,ZAP2C,ZAP2D
	.long	ZAP2E,ZAP2F,ZAP2G,0
ZAP3
	.long	ZAP3A,ZAP3B,ZAP3C,ZAP3D
	.long	ZAP3E,ZAP3F,ZAP3G,ZAP3H
	.long	ZAP3I,ZAP3J,0
ZAP4
	.long	ZAP4A,ZAP4B,ZAP4C,ZAP4D
	.long	ZAP4E,ZAP4F,ZAP4G,ZAP4H
	.long	ZAP4I,ZAP4J,ZAPSKEL1A,ZAPSKEL1B,0
ZAP5
	.long	ZAP5A,ZAP5B,ZAP5C,ZAP5D
	.long	ZAP5E,ZAP5F,ZAP5G,ZAP5H
	.long	ZAP5I,ZAPSKEL2A,ZAPSKEL2B,0
ZAP6
	.long	ZAP6A,ZAP6B,ZAP6C,ZAP6D
	.long	ZAP6E,ZAP6F,ZAP6G,ZAP6H
	.long	ZAP6I,ZAPSKEL3A,ZAPSKEL3B,0
ZAP7
	.long	ZAP7A,ZAP7B,ZAP7C,ZAP7D
	.long	ZAP7E,ZAP7F,ZAP7G,ZAP7H
	.long	ZAP7I,ZAPSKEL4A,ZAPSKEL4B,ZAPSKEL4C,ZAPSKEL4D,0
ZAP8
	.long	ZAP8A,ZAP8B,ZAP8C,ZAP8D
	.long	ZAP8E,ZAP8F,ZAP8G,ZAP8H
	.long	ZAP8I,ZAPSKEL5A,ZAPSKEL5B,ZAPSKEL5C,ZAPSKEL5D,0
ZAP9
	.long	ZAP9A,ZAP9B,ZAP9C,ZAP9D
	.long	ZAP9E,ZAP9F,ZAP9G,ZAP9H
	.long	ZAP9I,ZAPSKEL6A,ZAPSKEL6B,ZAPSKEL6C,ZAPSKEL6D,0
ZAP10
	.long	ZAP10A,ZAP10B,ZAP10C,ZAP10D
	.long	ZAP10E,ZAP10F,ZAP10G,ZAP10H
	.long	ZAP10I,ZAPSKEL7A,ZAPSKEL7B,ZAPSKEL7C,ZAPSKEL7D,0
ZAP11
	.long	ZAP11A,ZAP11B,ZAP11C,ZAP11D
	.long	ZAP11E,ZAP11F,ZAP11G,ZAP11H
	.long	ZAP11I,ZAPSKEL8A,ZAPSKEL8B,ZAPSKEL8C,ZAPSKEL8D,0
ZAP12
	.long	ZAP12A,ZAP12B,ZAP12C,ZAP12D
	.long	ZAP12E,ZAP12F,ZAP12G,ZAP12H
	.long	ZAP12I,ZAPSKEL9A,ZAPSKEL9B,ZAPSKEL9C,0
ZAP13
	.long	ZAP13A,ZAP13B,ZAP13C,ZAP13D
	.long	ZAP13E,ZAP13F,ZAP13G,ZAP13H
	.long	ZAP13I,ZAP13J,ZAPSKEL10A,ZAPSKEL10B,0
ZAP14
	.long	ZAP14A,ZAP14B,ZAP14C,ZAP14D
	.long	ZAP14E,ZAP14F,ZAP14G,ZAP14H
	.long	ZAP14I,0
ZAP15
	.long	ZAP15A,ZAP15B,ZAP15C,ZAP15D
	.long	ZAP15E,ZAP15F,ZAP15G,0



INSKYLIGHT2
	.long	INSKYLIGHT2A,INSKYLIGHT2B,0
INSKYLIGHT4
	.long	INSKYLIGHT4A,INSKYLIGHT4B,0
INSKYLIGHT5
	.long	INSKYLIGHT5A,INSKYLIGHT5B,0
INSKYLIGHT6
	.long	INSKYLIGHT6A,INSKYLIGHT6B,0
INSKYLIGHT7
	.long	INSKYLIGHT7A,INSKYLIGHT7B,0
INSKYLIGHT8
	.long	INSKYLIGHT8A,INSKYLIGHT8B,0
INSKYLIGHT9
	.long	INSKYLIGHT9A,INSKYLIGHT9B,0

;******************************************************

INLIGHTNG1
	.long	INLIGHTNG1A,INLIGHTNG1B,INLIGHTNG1C,0
INLIGHTNG2
	.long	INLIGHTNG2A,INLIGHTNG2B,INLIGHTNG2C,INLIGHTNG2D
	.long	0
INLIGHTNG3
	.long	INLIGHTNG3A,INLIGHTNG3B,0
INLIGHTNG4
	.long	INLIGHTNG4A,INLIGHTNG4B,0
INLIGHTNG5
	.long	INLIGHTNG5A,INLIGHTNG5B,INLIGHTNG5C,0
INLIGHTNG6
	.long	INLIGHTNG6A,INLIGHTNG6B,INLIGHTNG6C,0
INLIGHTNG7
	.long	INLIGHTNG7A,INLIGHTNG7B,INLIGHTNG7C,INLIGHTNG7D
	.long	0
INLIGHTNG8
	.long	INLIGHTNG8A,INLIGHTNG8B,INLIGHTNG8C,INLIGHTNG8D
	.long	0
INLIGHTNG9
	.long	INLIGHTNG9A,0
INLIGHTNG10
	.long	INLIGHTNG10A,0
INLIGHTNG11
	.long	INLIGHTNG11A,0
INLIGHTNG12
	.long	INLIGHTNG12A,INLIGHTNG12B,INLIGHTNG12C,INLIGHTNG12D
	.long	0
INLIGHTNG13
	.long	INLIGHTNG13A,0
INLIGHTNG14
	.long	INLIGHTNG14A,0

a_overhead_chop
	.long	INAXEFATAL1
	.long	INAXEFATAL2
	.long	INAXEFATAL3
	.long	INAXEFATAL4
	.long	ani_ochar_sound
	.word	>0d
	.long	ani_sladd,INLIGHTNG1
	.long	ani_slani_sleep,INLIGHTNG1
	.long	ani_slani_sleep,INLIGHTNG2
	.long	ani_slani_sleep,INLIGHTNG3
	.long	ani_slani_sleep,INLIGHTNG4
	.long	ani_slani_sleep,INLIGHTNG5
	.long	ani_slani_sleep,INLIGHTNG6
	.long	ani_slani_sleep,INLIGHTNG7
	.long	ani_slani_sleep,INLIGHTNG8
	.long	0

	.long	ani_ochar_sound
	.word	>0d
	.long	ani_slani,INLIGHTNG9
	.long	INAXEFATAL5
	.long	ani_slani,INLIGHTNG10
	.long	INAXEFATAL6
	.long	ani_slani_sleep,INLIGHTNG11
	.long	ani_slani_sleep,INLIGHTNG12
	.long	ani_slani_sleep,INLIGHTNG13
	.long	ani_slani_sleep,INLIGHTNG14
	.long	0

INAXEFATAL1
	.long	INAXEFATAL1A,INAXEFATAL1B,0
INAXEFATAL2
	.long	INAXEFATAL2A,INAXEFATAL2B,0
INAXEFATAL3
	.long	INAXEFATAL3A,INAXEFATAL3B,0
INAXEFATAL4
	.long	INAXEFATAL4A,INAXEFATAL4B,0
INAXEFATAL5
	.long	INAXEFATAL5A,INAXEFATAL5B,0
INAXEFATAL6
	.long	INAXEFATAL6A,INAXEFATAL6B,INAXEFATAL6C,0

;***********************************************************************

	.end


