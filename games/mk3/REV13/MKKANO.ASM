**************************************************************************
*											     *
*  mk3 - kano.asm										*
*											     *
**************************************************************************
	.FILE	"mkkano.ASM"
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include kano.tbl
	.include mkkano2.tbl
	.include mainequ.asm
	.include imgtbl.glo

	.text

kano_anitab1
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
	.long	a_sweepup	; 22
	.long	a_throw		; 23
	.long	a_zap		; 24 - 
	.long	a_dizzy		; 25

	.long	a_fb_kano	; 26 - flipped by kano
	.long	a_fb_sonya	; 27 - flipped by sonya
	.long	a_fb_jax	; 28 - flipped by jax
	.long	a_fb_ind	; 29 - flipped by indian
	.long	a_fb_sz		; 2a	- flipped by subzero
	.long	a_fb_swat	; 2b	- flipped by swat guy
	.long	a_fb_lia	; 2c	- flipped by lia
	.long	a_fb_robo	; 2d	- flipped by robot ninja
	.long	a_fb_robo2	; 2e	- flipped by robot ninja 2
	.long	a_fb_lao	; 2f	- flipped by kung lao
	.long	a_fb_tusk	; 30	- flipped by tusk
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

kano_anitab2
	.long	a_air_slam	; 0 - body slam in the air
	.long	a_swipe_knife	; 1 - knife swipe ani
	.long	a_shake		; 2 - shake em up
	.long	a_shoot_lazer	; 3 - shoot laser !!

***************************************************************************

a_dummy
a_stance
	.long	KNSTANCE1
	.long	KNSTANCE2
	.long	KNSTANCE3
	.long	KNSTANCE4
	.long	KNSTANCE5
	.long	KNSTANCE6
	.long	KNSTANCE7
	.long	KNSTANCE8
	.long	KNSTANCE9
	.long	ani_jump,a_stance

KNSTANCE1
	.long	KNSTANCE1A,KNSTANCE1B,0
KNSTANCE2
	.long	KNSTANCE2A,KNSTANCE2B,0
KNSTANCE3
	.long	KNSTANCE3A,KNSTANCE3B,0
KNSTANCE4
	.long	KNSTANCE4A,KNSTANCE4B,0
KNSTANCE5
	.long	KNSTANCE5A,KNSTANCE5B,0
KNSTANCE6
	.long	KNSTANCE6A,KNSTANCE6B,0
KNSTANCE7
	.long	KNSTANCE7A,KNSTANCE7B,0
KNSTANCE8
	.long	KNSTANCE8A,KNSTANCE8B,0
KNSTANCE9
	.long	KNSTANCE9A,KNSTANCE9B,0

***************************************************************************

a_walkf
	.long	KNWALK1
	.long	KNWALK2
	.long	KNWALK3
	.long	KNWALK4
	.long	KNWALK5
	.long	KNWALK6
	.long	KNWALK7
	.long	KNWALK8
	.long	KNWALK9
	.long	ani_jump,a_walkf

a_walkb
	.long	KNWALK9
	.long	KNWALK8
	.long	KNWALK7
	.long	KNWALK6
	.long	KNWALK5
	.long	KNWALK4
	.long	KNWALK3
	.long	KNWALK2
	.long	KNWALK1
	.long	ani_jump,a_walkb


KNWALK1	.long	KNWALKBOD1A
	.long	KNWALKLEG1A,KNWALKLEG1B,0

KNWALK2	.long	KNWALKBOD2A
	.long	KNWALKLEG2A,KNWALKLEG2B,0

KNWALK3	.long	KNWALKBOD3A
	.long	KNWALKLEG3A,0

KNWALK4	.long	KNWALKBOD4A
	.long	KNWALKLEG4A,0

KNWALK5	.long	KNWALKBOD5A
	.long	KNWALKLEG5A,0

KNWALK6	.long	KNWALKBOD6A
	.long	KNWALKLEG6A,0

KNWALK7	.long	KNWALKBOD7A
	.long	KNWALKLEG7A,0

KNWALK8	.long	KNWALKBOD8A
	.long	KNWALKLEG8A,KNWALKLEG8B,0

KNWALK9	.long	KNWALKBOD9A
	.long	KNWALKLEG9A,KNWALKLEG9B,0

***************************************************************************

a_turn
	.long	KNTURN1
	.long	KNTURN2
	.long	ani_flip
	.long	KNTURN1
	.long	0

KNTURN1	.long	KNTURN1A,KNTURN1B,0

KNTURN2	.long	KNTURN2A,KNTURN2B,0

;**************************************************************************

a_duck
	.long	KNDUCK1
	.long	KNDUCK2
	.long	KNDUCK3
	.long	0

KNDUCK1	.long	KNDUCK1A,KNDUCK1B,0
KNDUCK2	.long	KNDUCK2A,KNDUCK2B,0
KNDUCK3	.long	KNDUCK3A,KNDUCK3B,0

;**************************************************************************

a_duck_turn
	.long	KNDUCKTURN1
	.long	KNDUCKTURN2
	.long	ani_flip
	.long	KNDUCKTURN2
	.long	KNDUCKTURN1
	.long	KNDUCK3
	.long	0

KNDUCKTURN1
	.long	KNDUCKTURN1A,KNDUCKTURN1B,0
KNDUCKTURN2
	.long	KNDUCKTURN2A,KNDUCKTURN2B,0

;**************************************************************************

a_duck_block
	.long	KNDUCKBLOCK1
	.long	KNDUCKBLOCK2
	.long	KNDUCKBLOCK3
	.long	0

KNDUCKBLOCK1
	.long	KNDUCKBLOCK1A,KNDUCKBLOCK1B,0
KNDUCKBLOCK2
	.long	KNDUCKBLOCK2A,KNDUCKBLOCK2B,0
KNDUCKBLOCK3
	.long	KNDUCKBLOCK3A,KNDUCKBLOCK3B,0

;**************************************************************************

a_duck_punch
	.long	KNDUCKPUNCH1
	.long	KNDUCKPUNCH2
	.long	KNDUCKPUNCH3
	.long	0
	.long	KNDUCKPUNCH2
	.long	KNDUCKPUNCH1
	.long	KNDUCK3
	.long	0

KNDUCKPUNCH1
	.long	KNDUCKPUNCH1A,KNDUCKPUNCH1B,0
KNDUCKPUNCH2
	.long	KNDUCKPUNCH2A,0
KNDUCKPUNCH3
	.long	KNDUCKPUNCH3A,0

;**************************************************************************

a_duck_hit
	.long	KNDUCKHIT2
	.long	KNDUCKHIT3
	.long	KNDUCKHIT2
	.long	KNDUCKHIT1
	.long	0

KNDUCKHIT1
	.long	KNDUCKHIT1A,KNDUCKHIT1B,0
KNDUCKHIT2
	.long	KNDUCKHIT2A,KNDUCKHIT2B,0
KNDUCKHIT3
	.long	KNDUCKHIT3A,KNDUCKHIT3B,0

;**************************************************************************

a_duck_kick_hi
	.long	KNDUCKHIKICK1
	.long	KNDUCKHIKICK2
	.long	KNDUCKHIKICK3
	.long	KNDUCKHIKICK4
	.long	0
	.long	KNDUCKHIKICK3
	.long	KNDUCKHIKICK2
	.long	KNDUCKHIKICK1
	.long	KNDUCK3
	.long	0

KNDUCKHIKICK1
	.long	KNDUCKHIKICK1A,KNDUCKHIKICK1B,0
KNDUCKHIKICK2
	.long	KNDUCKHIKICK2A,KNDUCKHIKICK2B,0
KNDUCKHIKICK3
	.long	KNDUCKHIKICK3A,KNDUCKHIKICK3B,0
KNDUCKHIKICK4
	.long	KNDUCKHIKICK4A,KNDUCKHIKICK4B,0

;**************************************************************************

a_duck_kick_lo
	.long	KNDUCKLOKICK1
	.long	KNDUCKLOKICK2
	.long	KNDUCKLOKICK3
	.long	KNDUCKLOKICK4
	.long	0
	.long	KNDUCKLOKICK3
	.long	KNDUCKLOKICK2
	.long	KNDUCKLOKICK1
	.long	KNDUCK3
	.long	0

KNDUCKLOKICK1
	.long	KNDUCKLOKICK1A,0
KNDUCKLOKICK2
	.long	KNDUCKLOKICK2A,KNDUCKLOKICK2B,0
KNDUCKLOKICK3
	.long	KNDUCKLOKICK3A,KNDUCKLOKICK3B,0
KNDUCKLOKICK4
	.long	KNDUCKLOKICK4A,KNDUCKLOKICK4B,0

;**************************************************************************

a_uppercut
	.long	KNUPPERCUT1
	.long	KNUPPERCUT2
	.long	KNUPPERCUT3
	.long	KNUPPERCUT4
	.long	ani_nosleep	; dont sleep after next frame
	.long	KNUPPERCUT5
	.long	0
	.long	KNUPPERCUT6
	.long	0

KNUPPERCUT1
	.long	KNUPPERCUT1A,0
KNUPPERCUT2
	.long	KNUPPERCUT2A,KNUPPERCUT2B,0
KNUPPERCUT3
	.long	KNUPPERCUT3A,KNUPPERCUT3B,0
KNUPPERCUT4
	.long	KNUPPERCUT4A,KNUPPERCUT4B,0
KNUPPERCUT5
	.long	KNUPPERCUT5A,0
KNUPPERCUT6
	.long	KNUPPERCUT6A,KNUPPERCUT6B,0

;**************************************************************************

a_block
	.long	KNHIBLOCK1
	.long	KNHIBLOCK2
	.long	KNHIBLOCK3
	.long	0

KNHIBLOCK1
	.long	KNHIBLOCK1A,KNHIBLOCK1B,0
KNHIBLOCK2
	.long	KNHIBLOCK2A,KNHIBLOCK2B,0
KNHIBLOCK3
	.long	KNHIBLOCK3A,KNHIBLOCK3B,0

;**************************************************************************

a_hipunch
	.long	KNHIPUNCH1
	.long	KNHIPUNCH2
	.long	KNHIPUNCH3
	.long	0

	.long	KNHIPUNCH4
	.long	KNHIPUNCH5
	.long	KNHIPUNCH6
	.long	0

	.long	KNHIPUNCH5
	.long	KNHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	KNHIPUNCH2
	.long	KNHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	KNHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	KNHIPUNCH4
	.long	KNLOPUNCH4
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	KNHIPUNCH5
	.long	KNHIPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0

KNHIPUNCH1
	.long	KNHIPUNCH1A,KNHIPUNCH1B,0
KNHIPUNCH2
	.long	KNHIPUNCH2A,KNHIPUNCH2B,0
KNHIPUNCH3
	.long	KNHIPUNCH3A,KNHIPUNCH3B,0
KNHIPUNCH4
	.long	KNHIPUNCH4A,KNHIPUNCH4B,0
KNHIPUNCH5
	.long	KNHIPUNCH5A,KNHIPUNCH5B,0
KNHIPUNCH6
	.long	KNHIPUNCH6A,KNHIPUNCH6B,0
KNHIPUNCH7
	.long	KNHIPUNCH7A,KNHIPUNCH7B,0

;**************************************************************************

a_lopunch
	.long	KNHIPUNCH1
	.long	KNLOPUNCH1
	.long	KNLOPUNCH2
	.long	0

	.long	KNLOPUNCH3
	.long	KNLOPUNCH4
	.long	KNLOPUNCH5
	.long	0

	.long	KNLOPUNCH4
	.long	KNLOPUNCH3
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	KNLOPUNCH1
	.long	KNHIPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	KNLOPUNCH4
	.long	0
*
* Med to High #1
*
	.long	KNLOPUNCH4
	.long	KNLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	KNLOPUNCH4
	.long	KNHIPUNCH2
	.long	ani_jump,a_hipunch+(32*2)

KNLOPUNCH1
	.long	KNLOPUNCH1A,KNLOPUNCH1B,0
KNLOPUNCH2
	.long	KNLOPUNCH2A,KNLOPUNCH2B,0
KNLOPUNCH3
	.long	KNLOPUNCH3A,KNLOPUNCH3B,0
KNLOPUNCH4
	.long	KNLOPUNCH4A,KNLOPUNCH4B,0
KNLOPUNCH5
	.long	KNLOPUNCH5A,KNLOPUNCH5B,0

;**************************************************************************

a_elbow
	.long	KNBACKFIST1
	.long	KNBACKFIST2
	.long	KNBACKFIST3
	.long	0
	.long	KNBACKFIST2
	.long	KNBACKFIST1
	.long	0
*
* part 3 = elbow 2
*
	.long	KNLASER1
	.long	ani_adjustx
	.word	12
	.long	KNLASER2
	.long	ani_adjustx
	.word	12
	.long	KNLASER3
	.long	0
*
* part 4 = unelbow 2
*
	.long	KNLASER2
	.long	KNLASER1
	.long	0

KNBACKFIST1
	.long	KNBACKFIST1A,KNBACKFIST1B,0
KNBACKFIST2
	.long	KNBACKFIST2A,KNBACKFIST2B,0
KNBACKFIST3
	.long	KNBACKFIST3A,KNBACKFIST3B,0

;**************************************************************************

a_hikick
	.long	KNHIKICK1
	.long	KNHIKICK2
	.long	KNHIKICK3
	.long	KNHIKICK4
	.long	KNHIKICK5
	.long	KNHIKICK6
	.long	0
	.long	KNHIKICK5
	.long	KNHIKICK4
	.long	KNHIKICK3
	.long	KNHIKICK2
	.long	KNHIKICK1
	.long	0

KNHIKICK1
	.long	KNHIKICK1A,KNHIKICK1B,0
KNHIKICK2
	.long	KNHIKICK2A,0
KNHIKICK3
	.long	KNHIKICK3A,0
KNHIKICK4
	.long	KNHIKICK4A,0
KNHIKICK5
	.long	KNHIKICK5A,0
KNHIKICK6
	.long	KNHIKICK6A,KNHIKICK6B,0

;**************************************************************************

a_lokick
	.long	KNHIKICK1
	.long	KNHIKICK2
	.long	KNHIKICK3
	.long	KNLOKICK1
	.long	KNLOKICK2
	.long	KNLOKICK3
	.long	0

	.long	KNLOKICK3
	.long	KNLOKICK2
	.long	KNLOKICK1
	.long	KNHIKICK3
	.long	KNHIKICK2
	.long	KNHIKICK1
	.long	0

KNLOKICK1
	.long	KNLOKICK1A,0
KNLOKICK2
	.long	KNLOKICK2A,0
KNLOKICK3
	.long	KNLOKICK3A,KNLOKICK3B,0

;**************************************************************************

a_knee	.long	KNKNEE1
	.long	KNKNEE2
	.long	KNKNEE3
	.long	0
	.long	KNKNEE2
	.long	KNKNEE1
	.long	0

KNKNEE1	.long	KNKNEE1A,0
KNKNEE2	.long	KNKNEE2A,0
KNKNEE3	.long	KNKNEE3A,0

;**************************************************************************

a_sweep_kick
	.long	KNSWEEPKICK1
	.long	KNSWEEPKICK2
	.long	KNSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	KNSWEEPKICK4
	.long	KNSWEEPKICK5
	.long	0

	.long	KNSWEEPKICK6
	.long	KNSWEEPKICK7
	.long	0

KNSWEEPKICK1
	.long	KNSWEEPKICK1A,KNSWEEPKICK1B,0
KNSWEEPKICK2
	.long	KNSWEEPKICK2A,KNSWEEPKICK2B,0
KNSWEEPKICK3
	.long	KNSWEEPKICK3A,0
KNSWEEPKICK4
	.long	KNSWEEPKICK4A,0
KNSWEEPKICK5
	.long	KNSWEEPKICK5A,KNSWEEPKICK5B,0
KNSWEEPKICK6
	.long	KNSWEEPKICK6A,0
KNSWEEPKICK7
	.long	KNSWEEPKICK7A,KNSWEEPKICK7B,0

;**************************************************************************

a_roundhouse
	.long	KNSPINHOOK1
	.long	KNSPINHOOK2
	.long	KNSPINHOOK3
	.long	KNSPINHOOK4
	.long	0

	.long	KNSPINHOOK5
	.long	KNSPINHOOK6
	.long	KNSPINHOOK7
	.long	KNSPINHOOK8
	.long	0

KNSPINHOOK1
	.long	KNSPINHOOK1A,0
KNSPINHOOK2
	.long	KNSPINHOOK2A,0
KNSPINHOOK3
	.long	KNSPINHOOK3A,0
KNSPINHOOK4
	.long	KNSPINHOOK4A,KNSPINHOOK4B,0
KNSPINHOOK5
	.long	KNSPINHOOK5A,KNSPINHOOK5B,0
KNSPINHOOK6
	.long	KNSPINHOOK6A,0
KNSPINHOOK7
	.long	KNSPINHOOK7A,KNSPINHOOK7B,0
KNSPINHOOK8
	.long	KNSPINHOOK8A,KNSPINHOOK8B,0

;**************************************************************************

a_jump	.long	KNJUMP1
	.long	KNJUMP2
	.long	KNJUMP3
	.long	0

KNJUMP1	.long	KNJUMP1A,KNJUMP1B,0
KNJUMP2	.long	KNJUMP2A,KNJUMP2B,0
KNJUMP3	.long	KNJUMP3A,KNJUMP3B,0

;**************************************************************************

a_jump_kick
	.long	KNJUMPKICK1
	.long	KNJUMPKICK2
	.long	KNJUMPKICK3
	.long	0
	.long	KNJUMPKICK2
	.long	KNJUMPKICK1
	.long	0

KNJUMPKICK1
	.long	KNJUMPKICK1A,0
KNJUMPKICK2
	.long	KNJUMPKICK2A,KNJUMPKICK2B,0
KNJUMPKICK3
	.long	KNJUMPKICK3A,KNJUMPKICK3B,0

;**************************************************************************

a_flip_punch
	.long	KNFLIPUNCH1
	.long	KNFLIPUNCH2
	.long	KNFLIPUNCH3
	.long	0
	.long	KNFLIPUNCH2
	.long	KNFLIPUNCH1
	.long	0

KNFLIPUNCH1
	.long	KNFLIPUNCH1A,KNFLIPUNCH1B,0
KNFLIPUNCH2
	.long	KNFLIPUNCH2A,KNFLIPUNCH2B,0
KNFLIPUNCH3
	.long	KNFLIPUNCH3A,KNFLIPUNCH3B,0

;**************************************************************************

a_flip_kick
	.long	KNFLIPKICK1
	.long	KNFLIPKICK2
	.long	KNFLIPKICK3
	.long	0
	.long	KNFLIPKICK2
	.long	KNFLIPKICK1
	.long	0

KNFLIPKICK1
	.long	KNFLIPKICK1A,0
KNFLIPKICK2
	.long	KNFLIPKICK2A,0
KNFLIPKICK3
	.long	KNFLIPKICK3A,0

;**************************************************************************

a_fflip
	.long	KNJUMPFLIP1
	.long	KNJUMPFLIP2
	.long	KNJUMPFLIP3
	.long	KNJUMPFLIP4
	.long	KNJUMPFLIP5
	.long	KNJUMPFLIP6
	.long	KNJUMPFLIP7
	.long	KNJUMPFLIP8
	.long	ani_jump,a_fflip+32


a_bflip
	.long	KNJUMPFLIP1
	.long	KNJUMPFLIP8
	.long	KNJUMPFLIP7
	.long	KNJUMPFLIP6
	.long	KNJUMPFLIP5
	.long	KNJUMPFLIP4
	.long	KNJUMPFLIP3
	.long	KNJUMPFLIP2
	.long	ani_jump,a_bflip+32


KNJUMPFLIP1
	.long	KNJUMPFLIP1A,KNJUMPFLIP1B,0
KNJUMPFLIP2
	.long	KNJUMPFLIP2A,0
KNJUMPFLIP3
	.long	KNJUMPFLIP3A,0
KNJUMPFLIP4
	.long	KNJUMPFLIP4A,0
KNJUMPFLIP5
	.long	KNJUMPFLIP5A,0
KNJUMPFLIP6
	.long	KNJUMPFLIP6A,0
KNJUMPFLIP7
	.long	KNJUMPFLIP7A,0
KNJUMPFLIP8
	.long	KNJUMPFLIP8A,0

;**************************************************************************

a_air_slam
	.long	KNTHRUST1
	.long	KNTHRUST2
	.long	KNTHRUST3
	.long	0

KNTHRUST1
	.long	KNTHRUST1A,0
KNTHRUST2
	.long	KNTHRUST2A,0
KNTHRUST3
	.long	KNTHRUST3A,0

;**************************************************************************

;a_air_throw
;	.long	KNAIRTHROW1
;	.long	KNAIRTHROW2
;	.long	KNAIRTHROW3
;	.long	0
;
;KNAIRTHROW1
;	.long	KNAIRTHROW1A,0
;KNAIRTHROW2
;	.long	KNAIRTHROW2A,0
;KNAIRTHROW3
;	.long	KNAIRTHROW3A,0

;**************************************************************************

a_hit_hi
	.long	KNHIHIT2
	.long	KNHIHIT3
	.long	KNHIHIT2
	.long	KNHIHIT1
	.long	0

KNHIHIT1	.long	KNHIHIT1A,KNHIHIT1B,0
KNHIHIT2	.long	KNHIHIT2A,KNHIHIT2B,0
KNHIHIT3	.long	KNHIHIT3A,KNHIHIT3B,0

;**************************************************************************

a_hit_lo
	.long	KNLOHIT2
	.long	KNLOHIT3
	.long	KNLOHIT2
	.long	KNLOHIT1
	.long	0

KNLOHIT1	.long	KNLOHIT1A,KNLOHIT1B,0
KNLOHIT2	.long	KNLOHIT2A,KNLOHIT2B,0
KNLOHIT3	.long	KNLOHIT3A,KNLOHIT3B,0

;**************************************************************************

a_stumble
	.long	KNSTUMBLE1
	.long	KNSTUMBLE2
	.long	KNSTUMBLE3
	.long	KNSTUMBLE4
	.long	KNSTUMBLE5
	.long	KNSTUMBLE6
	.long	0

j_stumble
	.long	KNSTUMBLE1
	.long	KNSTUMBLE2
	.long	KNSTUMBLE3
	.long	KNSTUMBLE4
	.long	KNSTUMBLE5
	.long	KNSTUMBLE6
	.long	ani_jump,j_stumble


KNSTUMBLE1
	.long	KNSTUMBLE1A,KNSTUMBLE1B,0
KNSTUMBLE2
	.long	KNSTUMBLE2A,KNSTUMBLE2B,0
KNSTUMBLE3
	.long	KNSTUMBLE3A,0
KNSTUMBLE4
	.long	KNSTUMBLE4A,KNSTUMBLE4B,0
	.long	0
KNSTUMBLE5
	.long	KNSTUMBLE5A,KNSTUMBLE5B,0
KNSTUMBLE6
	.long	KNSTUMBLE6A,KNSTUMBLE6B,0

;**************************************************************************

a_knockdown
	.long	KNKNOCKDOWN1
	.long	KNKNOCKDOWN2
	.long	KNKNOCKDOWN3
	.long	KNKNOCKDOWN4
	.long	KNKNOCKDOWN5
	.long	0

	.long	KNKNOCKDOWN6
	.long	KNKNOCKDOWN7
	.long	0

KNKNOCKDOWN1
	.long	KNKNOCKDOWN1A,0
KNKNOCKDOWN2
	.long	KNKNOCKDOWN2A,0
KNKNOCKDOWN3
	.long	KNKNOCKDOWN3A,KNKNOCKDOWN3B,0
KNKNOCKDOWN4
	.long	KNKNOCKDOWN4A,KNKNOCKDOWN4B,0
KNKNOCKDOWN5
	.long	KNKNOCKDOWN5A,KNKNOCKDOWN5B,0

KNBROKEN1
KNKNOCKDOWN6
	.long	KNKNOCKDOWN6A,0
KNKNOCKDOWN7
	.long	KNKNOCKDOWN7A,0

;**************************************************************************

a_sweep_fall
	.long	KNSWEEPFALL1
	.long	KNSWEEPFALL2
	.long	KNSWEEPFALL3
	.long	KNSWEEPFALL4
	.long	KNSWEEPFALL5
	.long	0
	.long	KNSWEEPFALL6
	.long	KNSWEEPFAL7
	.long	0

KNSWEEPFALL1
	.long	KNSWEEPFALL1A,KNSWEEPFALL1B,0
KNSWEEPFALL2
	.long	KNSWEEPFALL2A,0
KNSWEEPFALL3
	.long	KNSWEEPFALL3A,KNSWEEPFALL3B,0
KNSWEEPFALL4
	.long	KNSWEEPFALL4A,KNSWEEPFALL4B,0
KNSWEEPFALL5
	.long	KNSWEEPFALL5A,0
KNSWEEPFALL6
	.long	KNSWEEPFALL6A,0
KNSWEEPFAL7
	.long	KNSWEEPFALL7,0

;**************************************************************************

a_getup
	.long	KNGETUP1
	.long	KNGETUP2
	.long	KNGETUP3
	.long	KNGETUP4
	.long	KNGETUP5
	.long	KNGETUP6
	.long	0

KNGETUP1
	.long	KNGETUP1A,0
KNGETUP2
	.long	KNGETUP2A,0
KNGETUP3
	.long	KNGETUP3A,0
KNGETUP4
	.long	KNGETUP4A,KNGETUP4B,0
KNGETUP5
	.long	KNGETUP5A,0
KNGETUP6
	.long	KNGETUP6A,0

;**************************************************************************

a_sweepup
	.long	KNSWEEPUP1
	.long	KNSWEEPUP2
	.long	KNSWEEPUP3
	.long	KNSWEEPUP4
	.long	KNSWEEPUP5
	.long	KNSWEEPUP6
	.long	0

KNSWEEPUP1
	.long	KNSWEEPUP1A,0
KNSWEEPUP2
	.long	KNSWEEPUP2A,0
KNSWEEPUP3
	.long	KNSWEEPUP3A,0
KNSWEEPUP4
	.long	KNSWEEPUP4A,0
KNSWEEPUP5
	.long	KNSWEEPUP5A,0
KNSWEEPUP6
	.long	KNSWEEPUP6A,KNSWEEPUP6B,0

;**************************************************************************

a_dizzy
	.long	KNSTUNNED1
	.long	KNSTUNNED2
	.long	KNSTUNNED3
	.long	KNSTUNNED4
	.long	KNSTUNNED5
	.long	KNSTUNNED6
	.long	KNSTUNNED7
	.long	ani_jump,a_dizzy

KNSTUNNED1
	.long	KNSTUNNED1A,KNSTUNNED1B,0
KNSTUNNED2
	.long	KNSTUNNED2A,KNSTUNNED2B,0
KNSTUNNED3
	.long	KNSTUNNED3A,KNSTUNNED3B,0
	.long	0
KNSTUNNED4
	.long	KNSTUNNED4A,KNSTUNNED4B,0
	.long	0
KNSTUNNED5
	.long	KNSTUNNED5A,KNSTUNNED5B,0
KNSTUNNED6
	.long	KNSTUNNED6A,KNSTUNNED6B,0
KNSTUNNED7
	.long	KNSTUNNED7A,KNSTUNNED7B,0


a_throw
	.long	KNFLIP1
	.long	KNFLIP2
	.long	0

	.long	KNFLIP3		; both animate together
	.long	KNFLIP4
	.long	KNFLIP5
	.long	0

	.long	KNFLIP6		; hold this !!

	.long	KNFLIP7
	.long	ani_flip
	.long	0

KNFLIP1	.long	KNFLIP1A,KNFLIP1B,0
KNFLIP2	.long	KNFLIP2A,KNFLIP2B,0
KNFLIP3	.long	KNFLIP3A,KNFLIP3B,0
KNFLIP4	.long	KNFLIP4A,KNFLIP4B,0
KNFLIP5	.long	KNFLIP5A,KNFLIP5B,0
KNFLIP6	.long	KNFLIP6A,KNFLIP6B,0
KNFLIP7	.long	KNFLIP7A,KNFLIP7B,0


;**************************************************************************

KNFLIPPED1
	.long	KNFLIPPED1A,0
KNFLIPPED2
	.long	KNFLIPPED2A,0
KNFLIPPED3
	.long	KNFLIPPED3A,KNFLIPPED3B,0
KNFLIPPED4
	.long	KNFLIPPED4A,0
KNFLIPPED5
	.long	KNFLIPPED5A,0


a_afb_kano
	.long	ani_offset_xy
	.word	-034H,-008H
	.long	KNKNOCKDOWN1

	.long	ani_offset_xy
	.word	-03dH,014H
	.long	KNKNOCKDOWN2

	.long	ani_offset_xy
	.word	-04fH,029H
	.long	KNKNOCKDOWN3

	.long	0
*
* fall down solo
*
	.long	KNKNOCKDOWN4
	.long	KNKNOCKDOWN5
	.long	KNKNOCKDOWN6
	.long	KNKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	-01eH,-038H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	007H,-052H
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	037H,-049H
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	055H,-026H
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	057H,-015H
	.long	KNKNOCKDOWN6
	.long	ani_offset_xy
	.word	06cH,016H
	.long	KNKNOCKDOWN6
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	-039H,-010H		; we need even # of words here !
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-023H,-036H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	042H,-047H
	.long	KNFLIPPED3
	.long	0

	.long	KNFLIPPED4
	.long	KNFLIPPED5
	.long	KNKNOCKDOWN4
	.long	KNKNOCKDOWN5
	.long	0

a_fb_sonya
	.long	ani_offset_xy
	.word	-024H,000H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-016H,001H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	01eH,-01aH
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	05dH,-01fH
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	081H,-023H
	.long	KNFLIPPED4
	.long	0

	.long	KNFLIPPED5
	.long	KNKNOCKDOWN4
	.long	KNKNOCKDOWN5
	.long	0

a_fb_jax
	.long	ani_offset_xy
	.word	-039H,-018H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-024H,-03dH
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	016H,-055H
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	050H,-02eH
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	05fH,008H
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	040H,010H
	.long	KNKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	-057H,-01aH
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-03dH,-042H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	-007H,-05dH
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	028H,-04cH
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	044H,-032H
	.long	KNKNOCKDOWN6
	.long	ani_offset_xy
	.word	058H,-003H
	.long	KNKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	-049H,-032H
	.long	KNFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	057H,-025H
	.long	KNFLIPPED5

	.long	ani_offset_xy
	.word	040H,-003H
	.long	KNFLIPPED5

	.long	ani_offset_xy
	.word	-011H,-00dH
	.long	KNKNOCKDOWN5

	.long	ani_offset_xy
	.word	-051H,-031H
	.long	KNKNOCKDOWN5

	.long	ani_offset_xy
	.word	-081H,-064H
	.long	KNKNOCKDOWN5
	.long	0

a_fb_swat
	.long	ani_offset_xy
	.word	-043H,-00dH
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-030H,-042H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	028H,-060H
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	065H,-027H
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	03fH,004H
	.long	KNKNOCKDOWN6
	.long	0

a_fb_lia
	.long	ani_offset_xy
	.word	-064H,000H
	.long	KNSTUMBLE1
	.long	ani_offset_xy
	.word	-073H,003H
	.long	KNSTUMBLE1

	.long	ani_offset_xy
	.word	-075H,-01eH
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-057H,-03dH
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-023H,-046H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	01eH,-04eH
	.long	KNFLIPPED1

	.long	ani_offset_xy
	.word	0a8H,012H
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	08dH,000H
	.long	KNKNOCKDOWN7
	.long	0



a_fb_robo
	.long	ani_offset_xy
	.word	-047H,-00bH
	.long	KNFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-043H,-02fH
	.long	KNFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-031H,-048H
	.long	KNFLIPPED2		; 3

	.long	ani_offset_xy
	.word	000H,-074H
	.long	KNFLIPPED3		; 4
	.long	ani_offset_xy
	.word	03cH,-072H
	.long	KNFLIPPED4		; 5
	.long	ani_offset_xy
	.word	060H,-05bH
	.long	KNFLIPPED4		; 6

	.long	ani_offset_xy
	.word	07bH,-017H
	.long	KNFLIPPED5		; 7
	.long	ani_offset_xy
	.word	057H,-008H
	.long	KNKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	-026H,-008H
	.long	KNSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	-025H,-01eH
	.long	KNFLIPPED1		; 2
	.long	ani_offset_xy
	.word	-011H,-028H
	.long	KNFLIPPED2		; 3
	.long	ani_offset_xy
	.word	019H,-033H
	.long	KNFLIPPED3		; 4
	.long	ani_offset_xy
	.word	029H,-013H
	.long	KNFLIPPED4		; 5
	.long	ani_offset_xy
	.word	017H,-008H
	.long	KNFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-024H,-011H
	.long	KNKNOCKDOWN7		; 7
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	-01dH,01aH
	.long	KNSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	000H,033H
	.long	KNSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	-022H,01dH
	.long	KNFLIPPED1		; 3
	.long	ani_offset_xy
	.word	-046H,-00fH
	.long	KNFLIPPED2		; 4
	.long	ani_offset_xy
	.word	-02cH,-057H
	.long	KNFLIPPED3		; 5
	.long	ani_offset_xy
	.word	014H,-06dH
	.long	KNFLIPPED4		; 6
	.long	ani_offset_xy
	.word	04fH,-070H
	.long	KNFLIPPED5		; 7
	.long	ani_offset_xy
	.word	05aH,-056H
	.long	KNFLIPPED5		; 8
	.long	ani_offset_xy
	.word	077H,002H
	.long	KNFLIPPED5		; 9
	.long	ani_offset_xy
	.word	077H,052H
	.long	KNFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	-06eH,000H
	.long	KNFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-05dH,-04aH
	.long	KNFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-00cH,-081H
	.long	KNFLIPPED3		; 3
	.long	ani_offset_xy
	.word	040H,-057H
	.long	KNFLIPPED4		; 4
	.long	ani_offset_xy
	.word	044H,-015H
	.long	KNFLIPPED5		; 5

	.long	ani_offset_xy
	.word	00fH,01eH
	.long	KNFLIPPED5		; 6
	.long	ani_offset_xy
	.word	-031H,-014H
  	.long	KNKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	-068H,001H
	.long	KNFLIPPED1		; 8
	.long	ani_offset_xy
	.word	-04eH,-054H
	.long	KNFLIPPED2		; 9
	.long	ani_offset_xy
	.word	026H,-072H
	.long	KNFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	065H,-005H
	.long	KNFLIPPED5		; 11
	.long	ani_offset_xy
	.word	064H,009H
  	.long	KNKNOCKDOWN6		; 12
	.long	0


a_fb_sg
	.long	ani_offset_xy
	.word	-03dH,-030H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-008H,-052H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	-001H,-05eH
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	018H,-04fH
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	01aH,-035H
	.long	KNFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	-035H,-009H
  	.long	KNKNOCKDOWN7
	.long	0

a_fb_st
	.long	ani_offset_xy
	.word	-04cH,000H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-041H,007H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-02aH,001H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	-007H,003H
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	00eH,025H
	.long	KNFLIPPED4

	.long	ani_offset_xy
	.word	-00fH,-004H
	.long	KNKNOCKDOWN6
	.long	ani_offset_xy
	.word	-023H,-004H
	.long	KNKNOCKDOWN6
	.long	ani_offset_xy
	.word	-038H,-004H
	.long	KNKNOCKDOWN6

	.long	ani_offset_xy
	.word	-060H,019H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-067H,-00bH
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-03cH,-04cH
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	02bH,-041H
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	04cH,-018H
	.long	KNFLIPPED5
	.long	ani_offset_xy
	.word	05bH,-008H
	.long	KNKNOCKDOWN6
	.long	0

a_fb_lk
	.long	ani_offset_xy
	.word	-03aH,-001H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-037H,007H
	.long	KNFLIPPED1
	.long	ani_offset_xy
	.word	-013H,002H
	.long	KNFLIPPED2
	.long	ani_offset_xy
	.word	010H,000H
	.long	KNFLIPPED3
	.long	ani_offset_xy
	.word	03cH,-003H
	.long	KNFLIPPED4
	.long	ani_offset_xy
	.word	088H,-025H
	.long	KNFLIPPED4
	.long	0

	.long	KNFLIPPED5
	.long	KNKNOCKDOWN5
	.long	KNKNOCKDOWN6
	.long	KNKNOCKDOWN7
	.long	0




a_legged
	.long	ani_offset_xy
	.word	-055H,000H
	.long	KNKNOCKDOWN1

	.long	ani_offset_xy
	.word	-044H,-029H
	.long	KNFLIPPED1

	.long	ani_offset_xy
	.word	-00aH,-050H
	.long	KNFLIPPED3

	.long	ani_offset_xy
	.word	038H,-037H
	.long	KNFLIPPED4

	.long	ani_offset_xy
	.word	064H,000H
	.long	KNFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	048H,-00eH
	.long	KNKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	04eH,00fH
	.long	KNKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	01fH,00eH
	.long	KNKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	-03cH,011H
	.long	KNKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	-083H,-004H
	.long	KNFLIPPED1	; 5

	.long	ani_offset_xy
	.word	-027H,-066H
	.long	KNFLIPPED3	; 6
	.long	0

	.long	KNFLIPPED3
	.long	KNFLIPPED4
	.long	KNFLIPPED5
	.long	KNKNOCKDOWN5
	.long	KNKNOCKDOWN6
	.long	KNKNOCKDOWN7
	.long	0


a_shook
	.long	ani_offset_xy
	.word	-04fH,-008H
	.long	KNSTUMBLE2

	.long	ani_offset_xy
	.word	-038H,-01fH
	.long	KNSTUMBLE2

	.long	ani_offset_xy
	.word	-01bH,-01cH
	.long	KNSTUMBLE2
	.long	0

; loop
	.long	ani_offset_xy
	.word	-01dH,-01aH
	.long	KNSTUMBLE2	; 6

	.long	ani_offset_xy
	.word	-033H,-02bH
	.long	KNSTUMBLE2	; 7

	.long	ani_offset_xy
	.word	-044H,-02dH	
	.long	KNSTUMBLE2	; 8

	.long	ani_offset_xy
	.word	-033H,-02bH
	.long	KNSTUMBLE1	; 7
	.long	0

;*************************************************************************

a_victory
	.long	KNVICTORY1
	.long	KNVICTORY2
	.long	KNVICTORY3
	.long	KNVICTORY4
	.long	KNVICTORY5
	.long	KNVICTORY6
	.long	KNVICTORY7
	.long	KNVICTORY8
	.long	KNVICTORY9
	.long	KNVICTORY10
	.long	0

KNVICTORY1
	.long	KNVICTORY1A,KNVICTORY1B,0
KNVICTORY2
	.long	KNVICTORY2A,KNVICTORY2B,0
KNVICTORY3
	.long	KNVICTORY3A,KNVICTORY3B,0
KNVICTORY4
	.long	KNVICTORY4A,KNVICTORY4B,0
KNVICTORY5
	.long	KNVICTORY5A,KNVICTORY5B,KNVICTORYLEGS1A,KNVICTORYLEGS1B,0
KNVICTORY6
	.long	KNVICTORY6A,KNVICTORYLEGS1A,KNVICTORYLEGS1B,0
KNVICTORY7
	.long	KNVICTORY7A,KNVICTORYLEGS1A,KNVICTORYLEGS1B,0
KNVICTORY8
	.long	KNVICTORY8A,KNVICTORY8B,KNVICTORYLEGS1A,KNVICTORYLEGS1B,0
KNVICTORY9
	.long	KNVICTORY9A,KNVICTORY9B,KNVICTORYLEGS1A,KNVICTORYLEGS1B,0
KNVICTORY10
	.long	KNVICTORY10A,KNVICTORY10B,KNVICTORYLEGS1A,KNVICTORYLEGS1B,0

;*************************************************************************

a_projectile
	.long	KNSABER1
	.long	KNSABER2
	.long	KNSABER3
	.long	KNSABER4
	.long	KNSABER5
	.long	KNSABER6
	.long	0

	.long	ani_adjustxy
	.word	050H,020H

a_proj_loop
	.long	KNSABER7
	.long	KNSABER8
	.long	KNSABER9
	.long	KNSABER10
	.long	KNSABER11
	.long	KNSABER12
	.long	KNSABER13
	.long	KNSABER14
	.long	KNSABER15
	.long	KNSABER16
	.long	ani_jump,a_proj_loop
	.long	0

	.long	KNSABER17
	.long	KNSABER18
	.long	KNSABER19
	.long	KNSABER20
	.long	KNSABER21
	.long	KNSABER22
	.long	0

KNSABER1
	.long	KNSABER1A,KNSABER1B,0
KNSABER2
	.long	KNSABER2A,0
KNSABER3
	.long	KNSABER3A,KNSABER3B,0
KNSABER4
	.long	KNSABER4A,KNSABER4B,KNSABER4C,0
KNSABER5
	.long	KNSABER5A,KNSABER5B,0
KNSABER6
	.long	KNSABER6A,KNSABER6C,0
KNSABER7
	.long	KNSABER7A,0
KNSABER8
	.long	KNSABER8A,0
KNSABER9
	.long	KNSABER9A,0
KNSABER10
	.long	KNSABER10A,0
KNSABER11
	.long	KNSABER11A,0
KNSABER12
	.long	KNSABER12A,0
KNSABER13
	.long	KNSABER13A,0
KNSABER14
	.long	KNSABER14A,0
KNSABER15
	.long	KNSABER15A,0
KNSABER16
	.long	KNSABER16A,0
KNSABER17
	.long	KNSABER17A,0
KNSABER18
	.long	KNSABER18A,0
KNSABER19
	.long	KNSABER19A,0
KNSABER20
	.long	KNSABER20A,0
KNSABER21
	.long	KNSABER21A,KNSABER21B,0
KNSABER22
	.long	KNSABER22A,KNSABER22B,0

;***********************************************************************

a_zap
	.long	KNTHROWPRO1
	.long	KNTHROWPRO2
	.long	KNTHROWPRO3
	.long	KNTHROWPRO4
	.long	KNTHROWPRO5
	.long	KNTHROWPRO6
	.long	KNTHROWPRO7
	.long	0

	.long	KNTHROWPRO8
	.long	0

KNTHROWPRO1
	.long	KNTHROWPRO1A,KNTHROWPRO1B,0
KNTHROWPRO2
	.long	KNTHROWPRO2A,KNTHROWPRO2B,0
KNTHROWPRO3
	.long	KNTHROWPRO3A,KNTHROWPRO3B,0
KNTHROWPRO4
	.long	KNTHROWPRO4A,KNTHROWPRO4B,0
KNTHROWPRO5
	.long	KNTHROWPRO5A,KNTHROWPRO5B,0
KNTHROWPRO6
	.long	KNTHROWPRO6A,KNTHROWPRO6B,0
KNTHROWPRO7
	.long	KNTHROWPRO7A,KNTHROWPRO7B,0
KNTHROWPRO8
	.long	KNTHROWPRO8A,KNTHROWPRO8B,0

;***********************************************************************

a_swipe_knife
	.long	ani_sladd,BLADE1  	; introducing ---> BLADE obj
	.long	KNSWIPE1

	.long	ani_adjustx
	.word	8
	.long	ani_slani,BLADE2
	.long	KNSWIPE2

	.long	ani_adjustx
	.word	8
	.long	ani_slani,BLADE3
	.long	KNSWIPE3

	.long	ani_adjustx
	.word	8
	.long	ani_slani,BLADE4
	.long	KNSWIPE4

	.long	ani_adjustx
	.word	11
	.long	ani_slani,BLADE5
	.long	KNSWIPE5
	.long	0

	.long	ani_adjustx
	.word	11
	.long	ani_slani,BLADE6
	.long	KNSWIPE6

	.long	ani_adjustx
	.word	11
	.long	ani_slani,BLADE7
	.long	KNSWIPE7
	.long	ani_slani,BLADE8
	.long	KNSWIPE8
	.long	0

	.long	ani_slani,BLADE9
	.long	KNSWIPE9

	.long	ani_slani,BLADE10
	.long	KNSWIPE10
	.long	0


KNSWIPE1
	.long	KNSWIPE1A,KNSWIPE1B,0
KNSWIPE2
	.long	KNSWIPE2A,KNSWIPE2B,0
KNSWIPE3
	.long	KNSWIPE3A,KNSWIPE3B,0
KNSWIPE4
	.long	KNSWIPE4A,KNSWIPE4B,0
KNSWIPE5
	.long	KNSWIPE5A,KNSWIPE5B,0
KNSWIPE6
	.long	KNSWIPE6A,KNSWIPE6B,0
KNSWIPE7
	.long	KNSWIPE7A,KNSWIPE7B,0
KNSWIPE8
	.long	KNSWIPE8A,KNSWIPE8B,0
KNSWIPE9
	.long	KNSWIPE9A,KNSWIPE9B,0
KNSWIPE10
	.long	KNSWIPE10A,KNSWIPE10B,0

BLADE1	.long	KNBLADESWIPE1A,0
BLADE2	.long	KNBLADESWIPE2A,0
BLADE3	.long	KNBLADESWIPE3A,0
BLADE4	.long	KNBLADESWIPE4A,0
BLADE5	.long	KNBLADESWIPE5A,0
BLADE6	.long	KNBLADESWIPE6A,0
BLADE7	.long	KNBLADESWIPE7A,0
BLADE8	.long	KNBLADESWIPE8A,0
BLADE9	.long	KNBLADESWIPE9A,0
BLADE10	.long	KNBLADESWIPE10A,0

;**************************************************************************

a_shake
	.long	KNSHAKE1
	.long	KNSHAKE2
	.long	KNSHAKE3
	.long	0

	.long	KNSHAKE3
	.long	KNSHAKE4
	.long	KNSHAKE5	; animate together !!
	.long	0

	.long	KNSHAKE6
	.long	KNSHAKE7
	.long	KNSHAKE8
	.long	KNSHAKE7
	.long	0

KNSHAKE1	.long	KNSHAKE1A,KNSHAKE1B,0
KNSHAKE2	.long	KNSHAKE2A,KNSHAKE2B,0
KNSHAKE3	.long	KNSHAKE3A,KNSHAKE3B,0
KNSHAKE4	.long	KNSHAKE4A,KNSHAKE4B,0
KNSHAKE5	.long	KNSHAKE5A,KNSHAKE5B,0
KNSHAKE6	.long	KNSHAKE6A,KNSHAKE6B,0
KNSHAKE7	.long	KNSHAKE7A,KNSHAKE7B,0
KNSHAKE8	.long	KNSHAKE8A,KNSHAKE8B,0


a_run	.long	KNRUN1
	.long	KNRUN2
	.long	KNRUN3
	.long	KNRUN4
	.long	ani_calla,rsnd_footstep
	.long	KNRUN5
	.long	KNRUN6
	.long	KNRUN7
	.long	KNRUN8
	.long	KNRUN9
	.long	ani_calla,rsnd_footstep
	.long	KNRUN10
	.long	KNRUN11
	.long	ani_jump,a_run

KNRUN1	.long	KNRUN1A,0
KNRUN2	.long	KNRUN2A,0
KNRUN3	.long	KNRUN3A,KNRUN3B,0
KNRUN4	.long	KNRUN4A,KNRUN4B,0
KNRUN5	.long	KNRUN5A,KNRUN5B,0
KNRUN6	.long	KNRUN6A,0
KNRUN7	.long	KNRUN7A,0
KNRUN8	.long	KNRUN8A,0
KNRUN9	.long	KNRUN9A,KNRUN9B,0
KNRUN10	.long	KNRUN10A,KNRUN10B,0
KNRUN11	.long	KNRUN11A,0

;***********************************************************************

a_thudd
	.long	KNTHUD1
	.long	KNTHUD2
	.long	KNTHUD3
	.long	KNTHUD4
	.long	KNTHUD5
	.long	KNTHUD6
	.long	0

KNTHUD1	.long	KNTHUD1A,0
KNTHUD2	.long	KNTHUD2A,0
KNTHUD3	.long	KNTHUD3A,0
KNTHUD4	.long	KNTHUD4A,0
KNTHUD5	.long	KNTHUD5A,0
KNTHUD6	.long	KNTHUD6A,0

;***********************************************************************

a_shoot_lazer
	.long	KNLASER1
	.long	KNLASER1
	.long	KNLASER1
	.long	ani_sladd,LASEREYE1
	.long	ani_slani_sleep,LASEREYE2
	.long	ani_slani_sleep,LASEREYE3
	.long	ani_slani_sleep,LASEREYE4
	.long	ani_slani_sleep,LASEREYE5

	.long	ani_slani,LASEREYE6
	.long	KNLASER2

	.long	ani_slani,LASEREYE7
	.long	KNLASER3

	.long	ani_slani_sleep,LASEREYE8
	.long	ani_slani_sleep,LASEREYE9
	.long	ani_slani_sleep,LASEREYE10
	.long	0

	.long	ani_slani_sleep,LASEREYE11
	.long	ani_slani_sleep,LASEREYE12
	.long	ani_slani_sleep,LASEREYE13
	.long	ani_slani_sleep,LASEREYE14
	.long	0

	.long	ani_slani_sleep,LASEREYE15
	.long	ani_slani_sleep,LASEREYE16
	.long	ani_slani_sleep,LASEREYE17
	.long	ani_slani_sleep,LASEREYE18
	.long	ani_slani_sleep,LASEREYE19
	.long	KNLASER3
	.long	KNLASER2
	.long	KNLASER1
	.long	0

KNLASER1	.long	KNLASER1A,KNLASER1B,0
KNLASER2	.long	KNLASER2A,KNLASER2B,0
KNLASER3	.long	KNLASER3A,KNLASER3B,0


LASEREYE1
	.long	LASEREYE1A,0
LASEREYE2
	.long	LASEREYE2A,0
LASEREYE3
	.long	LASEREYE3A,0
LASEREYE4
	.long	LASEREYE4A,0
LASEREYE5
	.long	LASEREYE5A,0
LASEREYE6
	.long	LASEREYE6A,0
LASEREYE7
	.long	LASEREYE7A,0
LASEREYE8
	.long	LASEREYE8A,0
LASEREYE9
	.long	LASEREYE9A,0
LASEREYE10
	.long	LASEREYE10A,0
LASEREYE11
	.long	LASEREYE11A,0
LASEREYE12
	.long	LASEREYE12A,0
LASEREYE13
	.long	LASEREYE13A,0
LASEREYE14
	.long	LASEREYE14A,0
LASEREYE15
	.long	LASEREYE15A,0
LASEREYE16
	.long	LASEREYE16A,0
LASEREYE17
	.long	LASEREYE17A,0
LASEREYE18
	.long	LASEREYE18A,0
LASEREYE19
	.long	LASEREYE19A,0



a_scared
	.long	KNSCARED2
	.long	0

KNSCARED2
	.long	KNSCARED2A,0


;KNRIPSKEL3
;	.long	KNRIPSKEL3A,KNRIPSKEL3B,0
;KNRIPSKEL4
;	.long	KNRIPSKEL4A,KNRIPSKEL4B,0
;KNRIPSKEL5
;	.long	KNRIPSKEL5A,KNRIPSKEL5B,0
;KNRIPSKEL6
;	.long	KNRIPSKEL6A,KNRIPSKEL6B,0
;KNRIPSKEL7
;	.long	KNRIPSKEL7A,KNRIPSKEL7B,0
;KNRIPSKEL8
;	.long	KNRIPSKEL8A,KNRIPSKEL8B,0
;KNRIPSKEL9
;	.long	KNRIPSKEL9A,KNRIPSKEL9B,0
;KNRIPSKEL10
;	.long	KNRIPSKEL10A,KNRIPSKEL10B,0
;KNRIPSKEL11
;	.long	KNRIPSKEL11A,KNRIPSKEL11B,0
;KNRIPSKEL12
;	.long	KNRIPSKEL12A,KNRIPSKEL12B,0
;KNRIPSKEL13
;	.long	KNRIPSKEL13A,KNRIPSKEL13B,0
;KNRIPSKEL14
;	.long	KNRIPSKEL14A,KNRIPSKEL14B,0
;KNRIPSKEL15
;	.long	KNRIPSKEL15A,KNRIPSKEL15B,0

;**************************************************************************




	.end
