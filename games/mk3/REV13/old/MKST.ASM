**************************************************************************
*											     *
*  mk3 - Shang Tsung										*
*											     *
**************************************************************************
	.FILE	'mkst.asm'
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo
	.include sysequ.asm
	.include mkst.tbl
	.include mkst2.tbl
	.include mkst3.tbl
	.include mkstfix.tbl
	.text

st_anitab1
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



st_anitab2
	.long	a_st_2_kano	; 0
	.long	a_st_2_sonya	; 1
	.long	a_st_2_jax	; 2
	.long	a_st_2_ind	; 3
	.long	a_st_2_sz	; 4
	.long	a_st_2_swat	; 5
	.long	a_st_2_lia	; 6
	.long	a_st_2_robo1	; 7
	.long	a_st_2_robo2	; 8
	.long	a_st_2_lao	; 9
	.long	a_st_2_tusk	; a
	.long	a_st_2_sg	; b
	.long	a_st_2_sg	; c
	.long	a_st_2_lk	; d
	.long	a_st_2_sz	; e
	.long	0		; f
	.long	0		; 10
	.long	a_soul_suck	; 11
	.long	a_floor_summon	; 12
	.long	a_floor_fire	; 13
	.long	a_spike_slammer	; 14


a_dummy
a_stance
	.long	TSSTANCE1
	.long	TSSTANCE2
	.long	TSSTANCE3
	.long	TSSTANCE4
	.long	TSSTANCE5
	.long	TSSTANCE6
	.long	TSSTANCE7
	.long	TSSTANCE8
	.long	TSSTANCE9
	.long	ani_jump,a_stance

TSSTANCE1
	.long	TSSTANCE1A,TSSTANCE1B,0
TSSTANCE2
	.long	TSSTANCE2A,TSSTANCE2B,0
TSSTANCE3
	.long	TSSTANCE3A,TSSTANCE3B,0
TSSTANCE4
	.long	TSSTANCE4A,TSSTANCE4B,0
TSSTANCE5
	.long	TSSTANCE5A,TSSTANCE5B,0
TSSTANCE6
	.long	TSSTANCE6A,TSSTANCE6B,0
TSSTANCE7
	.long	TSSTANCE7A,TSSTANCE7B,0
TSSTANCE8
	.long	TSSTANCE8A,TSSTANCE8B,0
TSSTANCE9
	.long	TSSTANCE9A,TSSTANCE9B,0


a_turn	.long	TSTURN1
	.long	TSTURN2
	.long	ani_flip
	.long	TSTURN2
	.long	TSTURN1
	.long	0

TSTURN1	.long	TSTURN1A,TSTURN1B,0
TSTURN2	.long	TSTURN2A,TSTURN2B,0


a_walkf
	.long	TSWALK1
	.long	TSWALK2
	.long	TSWALK3
	.long	TSWALK4
	.long	TSWALK5
	.long	TSWALK6
	.long	TSWALK7
	.long	TSWALK8
	.long	TSWALK9
	.long	ani_jump,a_walkf

a_walkb
	.long	TSWALK9
	.long	TSWALK8
	.long	TSWALK7
	.long	TSWALK6
	.long	TSWALK5
	.long	TSWALK4
	.long	TSWALK3
	.long	TSWALK2
	.long	TSWALK1
	.long	ani_jump,a_walkb

TSWALK1	.long	TSWALKTORSO1A,TSWALKLEG1A,TSWALKLEG1B,0
TSWALK2	.long	TSWALKTORSO2A,TSWALKLEG2A,TSWALKLEG2B,0
TSWALK3	.long	TSWALKTORSO3A,TSWALKLEG3A,0
TSWALK4	.long	TSWALKTORSO4A,TSWALKLEG4A,0
TSWALK5	.long	TSWALKTORSO5A,TSWALKLEG5A,0
TSWALK6	.long	TSWALKTORSO6A,TSWALKLEG6A,0
TSWALK7	.long	TSWALKTORSO7A,TSWALKLEG7A,0
TSWALK8	.long	TSWALKTORSO8A,TSWALKLEG8A,TSWALKLEG8B,0
TSWALK9	.long	TSWALKTORSO9A,TSWALKLEG9A,TSWALKLEG9B,0


a_duck
	.long	TSDUCK1
	.long	TSDUCK2
	.long	TSDUCK3
	.long	0

TSDUCK1	.long	TSDUCK1A,TSDUCK1B,0
TSDUCK2	.long	TSDUCK2A,TSDUCK2B,0
TSDUCK3	.long	TSDUCK3A,TSDUCK3B,0


a_duck_block
	.long	TSDUCKBLOCK1
	.long	TSDUCKBLOCK2
	.long	TSDUCKBLOCK3
	.long	0

TSDUCKBLOCK1
	.long	TSDUCKBLOCK1A,TSDUCKBLOCK1B,0
TSDUCKBLOCK2
	.long	TSDUCKBLOCK2A,TSDUCKBLOCK2B,0
TSDUCKBLOCK3
	.long	TSDUCKBLOCK3A,TSDUCKBLOCK3B,0


a_duck_hit
	.long	TSDUCKHIT2
	.long	TSDUCKHIT3
	.long	TSDUCKHIT2
	.long	TSDUCKHIT1
	.long	0


TSDUCKHIT1
	.long	TSDUCKHIT1A,TSDUCKHIT1B,0
TSDUCKHIT2
	.long	TSDUCKHIT2A,TSDUCKHIT2B,0
TSDUCKHIT3
	.long	TSDUCKHIT3A,TSDUCKHIT3B,0

a_duck_turn
	.long	TSDUCKTURN1
	.long	TSDUCKTURN2
	.long	ani_flip
	.long	TSDUCKTURN2
	.long	TSDUCKTURN1
	.long	TSDUCK3
	.long	0

TSDUCKTURN1
	.long	TSDUCKTURN1A,TSDUCKTURN1B,0
TSDUCKTURN2
	.long	TSDUCKTURN2A,TSDUCKTURN2B,0


a_duck_kick_lo
	.long	TSDUCKLOKICK1
	.long	TSDUCKLOKICK2
	.long	TSDUCKLOKICK3
	.long	0
	.long	TSDUCKLOKICK2
	.long	TSDUCKLOKICK1
	.long	TSDUCK3
	.long	0


TSDUCKLOKICK1
	.long	TSDUCKLOKICK1A,TSDUCKLOKICK1B,0
TSDUCKLOKICK2
	.long	TSDUCKLOKICK2A,TSDUCKLOKICK2B,0
TSDUCKLOKICK3
	.long	TSDUCKLOKICK3A,TSDUCKLOKICK3B,0


a_duck_kick_hi
	.long	TSDUCKHIKICK1
	.long	TSDUCKHIKICK2
	.long	TSDUCKHIKICK3
	.long	0
	.long	TSDUCKHIKICK2
	.long	TSDUCKHIKICK1
	.long	TSDUCK3
	.long	0


TSDUCKHIKICK1
	.long	TSDUCKHIKICK1A,TSDUCKHIKICK1B,0
TSDUCKHIKICK2
	.long	TSDUCKHIKICK2A,TSDUCKHIKICK2B,0
TSDUCKHIKICK3
	.long	TSDUCKHIKICK3A,TSDUCKHIKICK3B,0


a_uppercut
;	.long	TSUPPERCUT1
	.long	TSUPPERCUT2
	.long	TSUPPERCUT3
	.long	TSUPPERCUT4
	.long	TSUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
	.long	TSUPPERCUT6
	.long	0

	.long	TSUPPERCUT7
	.long	0

TSUPPERCUT1
	.long	TSUPPERCUT1A,TSUPPERCUT1B,0
TSUPPERCUT2
	.long	TSUPPERCUT2A,TSUPPERCUT2B,0
TSUPPERCUT3
	.long	TSUPPERCUT3A,TSUPPERCUT3B,0
TSUPPERCUT4
	.long	TSUPPERCUT4A,TSUPPERCUT4B,0
TSUPPERCUT5
	.long	TSUPPERCUT5A,TSUPPERCUT5B,0
TSUPPERCUT6
	.long	TSUPPERCUT6A,TSUPPERCUT6B,0
TSUPPERCUT7
	.long	TSUPPERCUT7A,TSUPPERCUT7B,0


a_duck_punch
	.long	TSDUCKPUNCH1
	.long	TSDUCKPUNCH2
	.long	TSDUCKPUNCH3
	.long	0
	.long	TSDUCKPUNCH2
	.long	TSDUCKPUNCH1
	.long	TSDUCK3
	.long	0


TSDUCKPUNCH1
	.long	TSDUCKPUNCH1A,TSDUCKPUNCH1B,0
TSDUCKPUNCH2
	.long	TSDUCKPUNCH2A,TSDUCKPUNCH2B,0
TSDUCKPUNCH3
	.long	TSDUCKPUNCH3A,TSDUCKPUNCH3B,0


a_block
	.long	TSHIBLOCK1
	.long	TSHIBLOCK2
	.long	TSHIBLOCK3
	.long	0

TSHIBLOCK1
	.long	TSHIBLOCK1AF,TSHIBLOCK1B,0
TSHIBLOCK2
	.long	TSHIBLOCK2A,TSHIBLOCK2B,0
TSHIBLOCK3
	.long	TSHIBLOCK3A,TSHIBLOCK3B,0

a_hipunch
	.long	TSHIPUNCH1
	.long	TSHIPUNCH2
	.long	TSHIPUNCH3
	.long	0

	.long	TSHIPUNCH4
	.long	TSHIPUNCH5
	.long	TSHIPUNCH6
	.long	0

	.long	TSHIPUNCH5
	.long	TSHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	TSHIPUNCH2
	.long	TSHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	TSHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	TSHIPUNCH4
	.long	TSLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	TSHIPUNCH5
	.long	TSLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0


a_lopunch
	.long	TSLOPUNCH1
	.long	TSLOPUNCH2
	.long	TSLOPUNCH3
	.long	0

	.long	TSLOPUNCH4
	.long	TSLOPUNCH5
	.long	TSLOPUNCH6
	.long	0

	.long	TSLOPUNCH5
	.long	TSLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	TSLOPUNCH2
	.long	TSLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	TSHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	TSLOPUNCH4
	.long	TSLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	TSLOPUNCH4
	.long	TSHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)


TSHIPUNCH1
	.long	TSHIPUNCH1A,TSHIPUNCH1B,0
TSHIPUNCH2
	.long	TSHIPUNCH2A,TSHIPUNCH2B,0
TSHIPUNCH3
	.long	TSHIPUNCH3A,TSHIPUNCH3B,0
TSHIPUNCH4
	.long	TSHIPUNCH4A,TSHIPUNCH4B,0
TSHIPUNCH5
	.long	TSHIPUNCH5A,TSHIPUNCH5B,0
TSHIPUNCH6
	.long	TSHIPUNCH6A,TSHIPUNCH6B,0
TSHIPUNCH7
	.long	TSHIPUNCH7A,TSHIPUNCH7B,0

TSLOPUNCH1
	.long	TSLOPUNCH1A,TSLOPUNCH1B,0
TSLOPUNCH2
	.long	TSLOPUNCH2A,TSLOPUNCH2B,0
TSLOPUNCH3
	.long	TSLOPUNCH3A,TSLOPUNCH3B,0
TSLOPUNCH4
	.long	TSLOPUNCH4A,TSLOPUNCH4B,0
TSLOPUNCH5
	.long	TSLOPUNCH5A,TSLOPUNCH5B,0
TSLOPUNCH6
	.long	TSLOPUNCH6A,TSLOPUNCH6B,0



a_elbow
	.long	TSCOMBO1
	.long	TSCOMBO2
	.long	TSCOMBO3
	.long	0

	.long	TSCOMBO2
	.long	TSCOMBO1
	.long	0

	.long	ani_adjustx
	.word	8
	.long	TSCOMBO4
	.long	ani_adjustx
	.word	8
	.long	TSCOMBO5
	.long	TSCOMBO6
	.long	TSCOMBO7		; ani: part 3
	.long	0

	.long	ani_adjustx
	.word	8
	.long	TSCOMBO8
	.long	ani_adjustx
	.word	8
	.long	TSCOMBO9
	.long	TSCOMBO10
	.long	TSCOMBO11		; ani: part 4
	.long	ani_nosleep
	.long	TSCOMBO12
	.long	0

	.long	TSCOMBO11
	.long	TSCOMBO10
	.long	TSCOMBO9
	.long	TSCOMBO8
	.long	0


TSCOMBO1
	.long	TSCOMBO1A,TSCOMBO1B,0
TSCOMBO2
	.long	TSCOMBO2A,TSCOMBO2B,0
TSCOMBO3
	.long	TSCOMBO3A,TSCOMBO3B,0
TSCOMBO4
	.long	TSCOMBO4A,TSCOMBO4B,0
TSCOMBO5
	.long	TSCOMBO5A,TSCOMBO5B,0
TSCOMBO6
	.long	TSCOMBO6A,TSCOMBO6B,0
TSCOMBO7
	.long	TSCOMBO7A,TSCOMBO7B,0
TSCOMBO8
	.long	TSCOMBO8A,TSCOMBO8B,0
TSCOMBO9
	.long	TSCOMBO9A,TSCOMBO9B,0
TSCOMBO10
	.long	TSCOMBO10A,TSCOMBO10B,0
TSCOMBO11
	.long	TSCOMBO11A,TSCOMBO11B,0
TSCOMBO12
	.long	TSCOMBO12A,TSCOMBO12B,0

a_hikick
	.long	TSLOKICK1
	.long	TSLOKICK2
	.long	TSLOKICK3
	.long	TSHIKICK1
	.long	TSHIKICK2
	.long	TSHIKICK3
	.long	0
	.long	TSHIKICK2
	.long	TSHIKICK1
	.long	TSLOKICK3
	.long	TSLOKICK2
	.long	TSLOKICK1
	.long	0


a_lokick
	.long	TSLOKICK1
	.long	TSLOKICK2
	.long	TSLOKICK3
	.long	TSLOKICK4
	.long	TSLOKICK5
	.long	TSLOKICK6
	.long	0
	.long	TSLOKICK5
	.long	TSLOKICK4
	.long	TSLOKICK3
	.long	TSLOKICK2
	.long	TSLOKICK1
	.long	0

TSLOKICK1
	.long	TSLOKICK1A,TSLOKICK1B,0
TSLOKICK2
	.long	TSLOKICK2A,TSLOKICK2B,0
TSLOKICK3
	.long	TSLOKICK3A,TSLOKICK3B,0
TSLOKICK4
	.long	TSLOKICK4A,TSLOKICK4B,0
TSLOKICK5
	.long	TSLOKICK5A,0
TSLOKICK6
	.long	TSLOKICK6A,0
TSHIKICK1
	.long	TSHIKICK1A,0
TSHIKICK2
	.long	TSHIKICK2A,0
TSHIKICK3
	.long	TSHIKICK3A,TSHIKICK3B,0



a_knee
	.long	TSKNEEBASH1
	.long	TSKNEEBASH2
	.long	TSKNEEBASH3
	.long	0
	.long	TSKNEEBASH2
	.long	TSKNEEBASH1
	.long	0

	.long	TSKNEEBASH4
	.long	TSKNEEBASH5
	.long	TSKNEEBASH6
	.long	TSKNEEBASH7
	.long	TSKNEEBASH8
	.long	TSKNEEBASH9

TSKNEEBASH1
	.long	TSKNEEBASH1A,TSKNEEBASH1B,0
TSKNEEBASH2
	.long	TSKNEEBASH2A,0
TSKNEEBASH3
	.long	TSKNEEBASH3A,TSKNEEBASH3B,0
TSKNEEBASH4
	.long	TSKNEEBASH4A,0
TSKNEEBASH5
	.long	TSKNEEBASH5A,0
TSKNEEBASH6
	.long	TSKNEEBASH6A,0
TSKNEEBASH7
	.long	TSKNEEBASH7A,0
TSKNEEBASH8
	.long	TSKNEEBASH8A,0
TSKNEEBASH9
	.long	TSKNEEBASH9A,0

a_sweep_kick
	.long	TSSWEEPKICK1
	.long	TSSWEEPKICK2
	.long	TSSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	TSSWEEPKICK4
	.long	TSSWEEPKICK5
	.long	0
	.long	TSSWEEPKICK6
	.long	TSSWEEPKICK7
	.long	TSSWEEPKICK8
	.long	0


TSSWEEPKICK1
	.long	TSSWEEPKICK1A,TSSWEEPKICK1B,0
TSSWEEPKICK2
	.long	TSSWEEPKICK2A,0
TSSWEEPKICK3
	.long	TSSWEEPKICK3A,0
TSSWEEPKICK4
	.long	TSSWEEPKICK4A,0
TSSWEEPKICK5
	.long	TSSWEEPKICK5A,TSSWEEPKICK5B,0
TSSWEEPKICK6
	.long	TSSWEEPKICK6A,0
TSSWEEPKICK7
	.long	TSSWEEPKICK7A,0
TSSWEEPKICK8
	.long	TSSWEEPKICK8A,TSSWEEPKICK8B,0


a_roundhouse
	.long	TSSPINHOOK1
	.long	TSSPINHOOK2
	.long	TSSPINHOOK3
	.long	TSSPINHOOK4
	.long	ani_nosleep
	.long	TSSPINHOOK5
	.long	0
	.long	TSSPINHOOK6
	.long	TSSPINHOOK7
	.long	TSSPINHOOK8
	.long	0

TSSPINHOOK1
	.long	TSSPINHOOK1A,TSSPINHOOK1B,0
TSSPINHOOK2
	.long	TSSPINHOOK2A,TSSPINHOOK2B,0
TSSPINHOOK3
	.long	TSSPINHOOK3A,0
TSSPINHOOK4
	.long	TSSPINHOOK4A,0
TSSPINHOOK5
	.long	TSSPINHOOK5A,TSSPINHOOK5B,0
TSSPINHOOK6
	.long	TSSPINHOOK6A,TSSPINHOOK6B,0
TSSPINHOOK7
	.long	TSSPINHOOK7A,0
TSSPINHOOK8
	.long	TSSPINHOOK8A,TSSPINHOOK8B,0

a_jump
	.long	TSJUMP1
	.long	TSJUMP2
	.long	TSJUMP3
	.long	0


TSJUMP1	.long	TSJUMP1A,TSJUMP1B,0
TSJUMP2	.long	TSJUMP2A,TSJUMP2B,0
TSJUMP3	.long	TSJUMP3A,TSJUMP3B,0

a_jump_kick
	.long	TSJUMPKICK1
	.long	TSJUMPKICK2
	.long	TSJUMPKICK3
	.long	0
	.long	TSJUMPKICK2
	.long	TSJUMPKICK1
	.long	0


TSJUMPKICK1
	.long	TSJUMPKICK1A,TSJUMPKICK1B,0
TSJUMPKICK2
	.long	TSJUMPKICK2A,TSJUMPKICK2B,0
TSJUMPKICK3
	.long	TSJUMPKICK3A,0


a_fflip
	.long	TSJUMPFLIP1
	.long	TSJUMPFLIP2
	.long	TSJUMPFLIP3
	.long	TSJUMPFLIP4
	.long	TSJUMPFLIP5
	.long	TSJUMPFLIP6
	.long	TSJUMPFLIP7
	.long	TSJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip
	.long	TSJUMPFLIP1
	.long	TSJUMPFLIP8
	.long	TSJUMPFLIP7
	.long	TSJUMPFLIP6
	.long	TSJUMPFLIP5
	.long	TSJUMPFLIP4
	.long	TSJUMPFLIP3
	.long	TSJUMPFLIP2
	.long	ani_jump,a_bflip+32


TSJUMPFLIP1
	.long	TSJUMPFLIP1A,0
TSJUMPFLIP2
	.long	TSJUMPFLIP2A,0
TSJUMPFLIP3
	.long	TSJUMPFLIP3A,0
TSJUMPFLIP4
	.long	TSJUMPFLIP4A,0
TSJUMPFLIP5
	.long	TSJUMPFLIP5A,0
TSJUMPFLIP6
	.long	TSJUMPFLIP6A,0
TSJUMPFLIP7
	.long	TSJUMPFLIP7A,0
TSJUMPFLIP8
	.long	TSJUMPFLIP8A,0

a_flip_kick
	.long	TSFLIPKICK1
	.long	TSFLIPKICK2
	.long	TSFLIPKICK3
	.long	0
	.long	TSFLIPKICK2
	.long	TSFLIPKICK1
	.long	0


TSFLIPKICK1
	.long	TSFLIPKICK1A,0
TSFLIPKICK2
	.long	TSFLIPKICK2A,TSFLIPKICK2B,0
TSFLIPKICK3
	.long	TSFLIPKICK3A,0

a_flip_punch
	.long	TSFLIPUNCH1
	.long	TSFLIPUNCH2
	.long	TSFLIPUNCH3
	.long	0
	.long	TSFLIPUNCH2
	.long	TSFLIPUNCH1
	.long	0


TSFLIPUNCH1
	.long	TSFLIPUNCH1A,TSFLIPUNCH1B,0
TSFLIPUNCH2
	.long	TSFLIPUNCH2A,TSFLIPUNCH2B,0
TSFLIPUNCH3
	.long	TSFLIPUNCH3A,TSFLIPUNCH3B,TSFLIPUNCH3C,0

a_hit_hi
	.long	TSHIHIT2
	.long	TSHIHIT3
	.long	TSHIHIT2
	.long	TSHIHIT1
	.long	0

TSHIHIT1	.long	TSHIHIT1A,TSHIHIT1B,0
TSHIHIT2	.long	TSHIHIT2A,TSHIHIT2B,0
TSHIHIT3	.long	TSHIHIT3A,TSHIHIT3B,0


a_hit_lo
	.long	TSLOHIT2
	.long	TSLOHIT3
	.long	TSLOHIT2
	.long	TSLOHIT1
	.long	0

TSLOHIT1	.long	TSLOHIT1A,TSLOHIT1B,0
TSLOHIT2	.long	TSLOHIT2A,TSLOHIT2B,0
TSLOHIT3	.long	TSLOHIT3A,TSLOHIT3B,0


a_stumble
	.long	TSSTUMBLE1
	.long	TSSTUMBLE2
	.long	TSSTUMBLE3
	.long	TSSTUMBLE4
	.long	TSSTUMBLE5
	.long	TSSTUMBLE6
	.long	TSSTUMBLE7
	.long	TSSTUMBLE8
	.long	TSSTUMBLE9
	.long	0
j_stumble
	.long	TSSTUMBLE1
	.long	TSSTUMBLE2
	.long	TSSTUMBLE3
	.long	TSSTUMBLE4
	.long	TSSTUMBLE5
	.long	TSSTUMBLE6
	.long	TSSTUMBLE7
	.long	TSSTUMBLE8
	.long	TSSTUMBLE9
	.long	ani_jump,j_stumble


TSSTUMBLE1
	.long	TSSTUMBLE1A,0
TSSTUMBLE2
	.long	TSSTUMBLE2A,0
TSSTUMBLE3
	.long	TSSTUMBLE3A,0
TSSTUMBLE4
	.long	TSSTUMBLE4A,0
TSSTUMBLE5
	.long	TSSTUMBLE5A,TSSTUMBLE5B,0
TSSTUMBLE6
	.long	TSSTUMBLE6A,TSSTUMBLE6B,0
TSSTUMBLE7
	.long	TSSTUMBLE7A,0
TSSTUMBLE8
	.long	TSSTUMBLE8A,0
TSSTUMBLE9
	.long	TSSTUMBLE9A,TSSTUMBLE9B,0


a_dizzy
	.long	TSSTUNNED1
	.long	TSSTUNNED2
	.long	TSSTUNNED3
	.long	TSSTUNNED4
	.long	TSSTUNNED5
	.long	TSSTUNNED6
	.long	TSSTUNNED7
	.long	TSSTUNNED8
	.long	TSSTUNNED9
	.long	ani_jump,a_dizzy

TSSTUNNED1
	.long	TSSTUNNED1A,TSSTUNNED1B,0
TSSTUNNED2
	.long	TSSTUNNED2A,TSSTUNNED2B,0
TSSTUNNED3
	.long	TSSTUNNED3A,TSSTUNNED3B,0
TSSTUNNED4
	.long	TSSTUNNED4A,TSSTUNNED4B,0
TSSTUNNED5
	.long	TSSTUNNED5A,TSSTUNNED5B,0
TSSTUNNED6
	.long	TSSTUNNED6A,TSSTUNNED6B,0
TSSTUNNED7
	.long	TSSTUNNED7A,TSSTUNNED7B,0
TSSTUNNED8
	.long	TSSTUNNED8A,TSSTUNNED8B,0
TSSTUNNED9
	.long	TSSTUNNED9A,TSSTUNNED9B,0

a_knockdown
	.long	TSKNOCKDOWN1
	.long	TSKNOCKDOWN2
	.long	TSKNOCKDOWN3
	.long	TSKNOCKDOWN4
	.long	TSKNOCKDOWN5
	.long	0
	.long	TSKNOCKDOWN6
	.long	TSKNOCKDOWN7
	.long	0

TSKNOCKDOWN1
	.long	TSKNOCKDOWN1A,TSKNOCKDOWN1B,0
TSKNOCKDOWN2
	.long	TSKNOCKDOWN2A,0
TSKNOCKDOWN3
	.long	TSKNOCKDOWN3A,0
TSKNOCKDOWN4
	.long	TSKNOCKDOWN4A,0
TSKNOCKDOWN5
	.long	TSKNOCKDOWN5A,0
TSKNOCKDOWN6
	.long	TSKNOCKDOWN6A,0
TSKNOCKDOWN7
	.long	TSKNOCKDOWN7A,0

a_getup
	.long	TSGETUP1
	.long	TSGETUP2
	.long	TSGETUP3
	.long	TSGETUP4
	.long	TSGETUP5
	.long	TSGETUP6
	.long	0

TSGETUP1
	.long	TSGETUP1A,0
TSGETUP2
	.long	TSGETUP2A,0
TSGETUP3
	.long	TSGETUP3A,0
TSGETUP4
	.long	TSGETUP4A,TSGETUP4B,0
TSGETUP5
	.long	TSGETUP5A,0
TSGETUP6
	.long	TSGETUP6A,TSGETUP6B,0


a_sweep_fall
	.long	TSSWEEPFALL1
	.long	TSSWEEPFALL2
	.long	TSSWEEPFALL3
	.long	TSSWEEPFALL4
	.long	TSSWEEPFALL5
	.long	0
	.long	TSSWEEPFALL6
	.long	TSSWEEPFALL7
	.long	0

TSSWEEPFALL1
	.long	TSSWEEPFALL1A,TSSWEEPFALL1B,0
TSSWEEPFALL2
	.long	TSSWEEPFALL2A,TSSWEEPFALL2B,0
TSSWEEPFALL3
	.long	TSSWEEPFALL3A,TSSWEEPFALL3B,0
TSSWEEPFALL4
	.long	TSSWEEPFALL4A,TSSWEEPFALL4B,0
TSSWEEPFALL5
	.long	TSSWEEPFALL5A,TSSWEEPFALL5B,0
TSSWEEPFALL6
	.long	TSSWEEPFALL6A,0
TSSWEEPFALL7
	.long	TSSWEEPFALL7A,TSSWEEPFALL7B,0


a_sweepup
	.long	TSSWEEPUP1
	.long	TSSWEEPUP2
	.long	TSSWEEPUP3
	.long	TSSWEEPUP4
	.long	TSSWEEPUP5
	.long	TSSWEEPUP6
	.long	0

TSSWEEPUP1
	.long	TSSWEEPUP1A,0
TSSWEEPUP2
	.long	TSSWEEPUP2A,0
TSSWEEPUP3
	.long	TSSWEEPUP3A,TSSWEEPUP3B,0
TSSWEEPUP4
	.long	TSSWEEPUP4A,0
TSSWEEPUP5
	.long	TSSWEEPUP5A,TSSWEEPUP5B,0
TSSWEEPUP6
	.long	TSSWEEPUP6A,TSSWEEPUP6B,0


a_afb_kano
	.long	ani_offset_xy
	.word	->49,->09
	.long	TSFLIPPED1

	.long	ani_offset_xy
	.word	->27,>00
	.long	TSKNOCKDOWN4

	.long	ani_offset_xy
 	.word	->59,>22
	.long	TSKNOCKDOWN5
	.long	0
*
* fall down solo
*
	.long	TSKNOCKDOWN5
	.long	TSKNOCKDOWN6
	.long	TSKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	->25,->23
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	>01,->39
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>30,->38
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>49,->1e
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>58,->15
	.long	TSKNOCKDOWN6
	.long	ani_offset_xy
	.word	>62,>1a
	.long	TSKNOCKDOWN6
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	->24,>21
	.long	TSSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->06,>32
	.long	TSSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	->3a,>22
	.long	TSFLIPPED1		; 3
	.long	ani_offset_xy
	.word	->4a,->02
	.long	TSFLIPPED2		; 4
	.long	ani_offset_xy
	.word	->32,->3f
	.long	TSFLIPPED3		; 5
	.long	ani_offset_xy
	.word	>10,->63
	.long	TSFLIPPED4		; 6
	.long	ani_offset_xy
	.word	>61,->6a
	.long	TSFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>65,->51
	.long	TSFLIPPED5		; 8
	.long	ani_offset_xy
	.word	>77,>02
	.long	TSFLIPPED5		; 9
	.long	ani_offset_xy
	.word	>77,>52
	.long	TSFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	->7b,>09
	.long	TSFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->62,->39
	.long	TSFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->16,->69
	.long	TSFLIPPED3		; 3
	.long	ani_offset_xy
	.word	>40,->57
	.long	TSFLIPPED4		; 4
	.long	ani_offset_xy
	.word	>60,->15
	.long	TSFLIPPED5		; 5

	.long	ani_offset_xy
	.word	>24,>1e
	.long	TSFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->12,->08
  	.long	TSKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	->76,>07
	.long	TSFLIPPED1		; 8
	.long	ani_offset_xy
	.word	->5b,->41
	.long	TSFLIPPED2		; 9
	.long	ani_offset_xy
	.word	>13,->5b
	.long	TSFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	>7b,->08
	.long	TSFLIPPED5		; 11
	.long	ani_offset_xy
	.word	>64,>09
  	.long	TSKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	->4a,->23
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->0e,->4c
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	->07,->4b
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>0d,->42
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>11,->26
	.long	TSFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	->0b,->03
  	.long	TSKNOCKDOWN7
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	->4c,>07
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->41,>16
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->2a,>0e
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	->12,>0f
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>14,>22
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>05,->04
	.long	TSKNOCKDOWN6
	.long	ani_offset_xy
	.word	->16,>00
	.long	TSKNOCKDOWN6

	.long	ani_offset_xy
	.word	->27,->04
	.long	TSKNOCKDOWN6

	.long	ani_offset_xy
	.word	->60,>24
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->6d,->01
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->3c,->3e
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	>2b,->39
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>54,->1d
	.long	TSFLIPPED5
	.long	ani_offset_xy
	.word	>55,->08
	.long	TSKNOCKDOWN6
	.long	0




a_fb_lk
	.long	ani_offset_xy
	.word	->44,>0a
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->46,>13
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->13,>10
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	>0c,>11
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>37,>09
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>88,->1f
	.long	TSFLIPPED4
	.long	0

	.long	TSFLIPPED5
	.long	TSKNOCKDOWN5
	.long	TSKNOCKDOWN6
	.long	TSKNOCKDOWN7
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	->40,->0a
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->23,->1e
	.long	TSFLIPPED2
	.long	ani_offset_xy
 	.word	>35,->25
	.long	TSFLIPPED3
	.long	0

	.long	TSFLIPPED4
	.long	TSFLIPPED5
	.long	TSKNOCKDOWN5
	.long	TSKNOCKDOWN6
	.long	TSKNOCKDOWN7
	.long	0


a_fb_sonya
	.long	ani_offset_xy
	.word	->39,>09
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->1f,>16
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	>0e,>12
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>4f,->15
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>8c,->21
	.long	TSFLIPPED4
	.long	0

	.long	TSFLIPPED5
	.long	TSKNOCKDOWN5
	.long	TSKNOCKDOWN6
	.long	TSKNOCKDOWN7
	.long	0


a_fb_jax
	.long	ani_offset_xy
	.word	->55,->08
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->36,->21
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	->02,->41
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>35,->2e
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>5c,->24
	.long	TSKNOCKDOWN6
	.long	ani_offset_xy
	.word	>5a,>0a
	.long	TSKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	->6b,->03
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->51,->31
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	->1e,->4f
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>27,->49
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>5f,->12
	.long	TSFLIPPED5
	.long	ani_offset_xy
	.word	>5c,>02
	.long	TSKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	->57,->25
	.long	TSFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	>5a,->27
	.long	TSFLIPPED5

	.long	ani_offset_xy
	.word	>40,>05
	.long	TSFLIPPED5

	.long	ani_offset_xy
	.word	>0d,>08
	.long	TSKNOCKDOWN5

	.long	ani_offset_xy
	.word	->29,->17
	.long	TSKNOCKDOWN5

	.long	ani_offset_xy
	.word	->60,->49
	.long	TSKNOCKDOWN5
	.long	0


a_fb_swat
	.long	ani_offset_xy
	.word	->5c,->02
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->3c,->2f
	.long	TSFLIPPED2
	.long	ani_offset_xy
	.word	>23,->41
	.long	TSFLIPPED3
	.long	ani_offset_xy
	.word	>56,->13
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>64,>06
	.long	TSKNOCKDOWN6
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	->64,>00
	.long	TSSTUMBLE1
	.long	ani_offset_xy
	.word	->73,>03
	.long	TSSTUMBLE1

	.long	ani_offset_xy
	.word	->75,->1e
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->57,->3d
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	->23,->46
	.long	TSFLIPPED1
	.long	ani_offset_xy
	.word	>1e,->4e
	.long	TSFLIPPED1

	.long	ani_offset_xy
	.word	>a8,>12
	.long	TSFLIPPED4
	.long	ani_offset_xy
	.word	>b1,>06
	.long	TSKNOCKDOWN7
	.long	0


a_fb_robo
	.long	ani_offset_xy
	.word	->52,->0b
	.long	TSFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->4f,->32
	.long	TSFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->38,->48
	.long	TSFLIPPED2		; 3

	.long	ani_offset_xy
	.word	->0a,->6c
	.long	TSFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>38,->62
	.long	TSFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>5c,->50
	.long	TSFLIPPED4		; 6

	.long	ani_offset_xy
	.word	>7b,->13
	.long	TSFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5a,->11
	.long	TSKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	->30,->07
	.long	TSSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->31,->0f
	.long	TSFLIPPED1		; 2
	.long	ani_offset_xy
	.word	->0e,->1b
	.long	TSFLIPPED2		; 3
	.long	ani_offset_xy
	.word	>11,->12
	.long	TSFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>25,>03
	.long	TSFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>18,>06
	.long	TSFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->01,->11
	.long	TSKNOCKDOWN7		; 7
	.long	0


a_legged
	.long	ani_offset_xy
	.word	->68,>08
	.long	TSKNOCKDOWN1

	.long	ani_offset_xy
	.word	->62,->1f
	.long	TSFLIPPED1

	.long	ani_offset_xy
	.word	->22,->3c
	.long	TSFLIPPED3

	.long	ani_offset_xy
	.word	>37,->2d
	.long	TSFLIPPED4

	.long	ani_offset_xy
	.word	>5e,>00
	.long	TSFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	>62,->09
	.long	TSKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	>64,>0c
	.long	TSKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	>39,>1d
	.long	TSKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	->24,>24
	.long	TSKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	->95,->01
	.long	TSFLIPPED1	; 5

	.long	ani_offset_xy
	.word	->3b,->47
	.long	TSFLIPPED3	; 6
	.long	0

	.long	TSFLIPPED3
	.long	TSFLIPPED4
	.long	TSFLIPPED5
	.long	TSKNOCKDOWN5
	.long	TSKNOCKDOWN6
	.long	TSKNOCKDOWN7
	.long	0


a_shook
	.long	ani_offset_xy
	.word	->51,>06
	.long	TSSTUMBLE6	; 3

	.long	ani_offset_xy
	.word	->38,->12
	.long	TSSTUMBLE6	; 4

	.long	ani_offset_xy
	.word	->20,->0a
	.long	TSSTUMBLE6	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	->22,->0d
	.long	TSSTUMBLE6	; 6

	.long	ani_offset_xy
	.word	->37,->19
	.long	TSSTUMBLE6	; 7

	.long	ani_offset_xy
	.word	->42,->1b	
	.long	TSSTUMBLE6	; 8

	.long	ani_offset_xy
	.word	->3a,->16
	.long	TSSTUMBLE6	; 7
	.long	0


TSFLIPPED1
	.long	TSFLIPPED1A,0
TSFLIPPED2
	.long	TSFLIPPED2A,0
TSFLIPPED3
	.long	TSFLIPPED3A,TSFLIPPED3B,0
TSFLIPPED4
	.long	TSFLIPPED4A,0
TSFLIPPED5
	.long	TSFLIPPED5A,0


a_run	.long	TSRUN1
	.long	TSRUN2
	.long	TSRUN3
	.long	TSRUN4
	.long	ani_calla,rsnd_footstep
	.long	TSRUN5
	.long	TSRUN6
	.long	TSRUN7
	.long	TSRUN8
	.long	TSRUN9
	.long	ani_calla,rsnd_footstep
	.long	TSRUN10
	.long	TSRUN11
	.long	TSRUN12
	.long	ani_jump,a_run
	.long	0			; we need this zero !!


TSRUN1	.long	TSRUN1A,TSRUN1B,0
TSRUN2	.long	TSRUN2A,TSRUN2B,0
TSRUN3	.long	TSRUN3A,TSRUN3B,0
TSRUN4	.long	TSRUN4A,0
TSRUN5	.long	TSRUN5A,0
TSRUN6	.long	TSRUN6A,0
TSRUN7	.long	TSRUN7A,TSRUN7B,0
TSRUN8	.long	TSRUN8A,TSRUN8B,0
TSRUN9	.long	TSRUN9A,0
TSRUN10	.long	TSRUN10A,0
TSRUN11	.long	TSRUN11A,0
TSRUN12	.long	TSRUN12A,0


a_victory
	.long	TSVICTORY1
	.long	TSVICTORY2
	.long	TSVICTORY3
	.long	TSVICTORY4
	.long	ani_sladd,GLOW01
	.long	ani_slani_sleep,GLOW01
	.long	ani_slani_sleep,GLOW02
	.long	ani_slani_sleep,GLOW03
j_st_vic	.long	ani_slani_sleep,LOOP01
	.long	ani_slani_sleep,LOOP02
	.long	ani_slani_sleep,LOOP03
	.long	ani_slani_sleep,LOOP04
	.long	ani_slani_sleep,LOOP05
	.long	ani_slani_sleep,LOOP06
	.long	ani_slani_sleep,LOOP07
	.long	ani_slani_sleep,LOOP08
	.long	ani_slani_sleep,LOOP09
	.long	ani_slani_sleep,LOOP10
	.long	ani_jump,j_st_vic

TSVICTORY1
	.long	TSVICTORY1A,TSVICTORY1B,0
TSVICTORY2
	.long	TSVICTORY2A,TSVICTORY2B,0
TSVICTORY3
	.long	TSVICTORY3A,TSVICTORY3B,0
TSVICTORY4
	.long	TSVICTORY4A,TSVICTORY4B,0

GLOW01	.long	HANDGLOW01,0
GLOW02	.long	HANDGLOW02,0
GLOW03	.long	HANDGLOW03,0
LOOP01	.long	HANDLOOP01,0
LOOP02	.long	HANDLOOP02,0
LOOP03	.long	HANDLOOP03,0
LOOP04	.long	HANDLOOP04,0
LOOP05	.long	HANDLOOP05,0
LOOP06	.long	HANDLOOP06,0
LOOP07	.long	HANDLOOP07,0
LOOP08	.long	HANDLOOP08,0
LOOP09	.long	HANDLOOP09,0
LOOP10	.long	HANDLOOP10,0


a_zap
	.long	TSTHROWPRO1
	.long	TSTHROWPRO2
	.long	TSTHROWPRO3
	.long	ani_sladd,STSKUL1
	.long	ani_slani_sleep,STSKUL1
	.long	ani_slani_sleep,STSKUL2
	.long	ani_slani_sleep,STSKUL4
	.long	ani_slani_sleep,STSKUL5
	.long	0


a_projectile
	.long	STAIR1
	.long	STAIR2
	.long	STAIR3
	.long	ani_jump,a_projectile

STSKUL1	.long	FSKULFORM1,0
STSKUL2	.long	FSKULFORM2,0
STSKUL4	.long	FSKULFORM4,0
STSKUL5	.long	FSKULFORM5,0
STAIR1	.long	FSKULAIR01,0
STAIR2	.long	FSKULAIR02,0
STAIR3	.long	FSKULAIR03,0

TSTHROWPRO1
	.long	TSTHROWPRO1A,TSTHROWPRO1B,0
TSTHROWPRO2
	.long	TSTHROWPRO2A,TSTHROWPRO2B,0
TSTHROWPRO3
	.long	TSTHROWPRO3A,TSTHROWPRO3B,0


a_floor_summon
	.long	TSGROUNDPRO1
	.long	TSGROUNDPRO2
	.long	TSGROUNDPRO3
	.long	TSGROUNDPRO4
	.long	0
	.long	TSGROUNDPRO5
	.long	TSGROUNDPRO6
	.long	TSGROUNDPRO7
	.long	0

;	.long	TSGROUNDPRO8
	.long	TSGROUNDPRO7
	.long	TSGROUNDPRO6
	.long	TSGROUNDPRO5
	.long	TSGROUNDPRO4
	.long	TSGROUNDPRO3
	.long	TSGROUNDPRO2
	.long	TSGROUNDPRO1
	.long	0

TSGROUNDPRO1
	.long	TSGROUNDPRO1A,TSGROUNDPRO1B,0
TSGROUNDPRO2
	.long	TSGROUNDPRO2A,TSGROUNDPRO2B,0
TSGROUNDPRO3
	.long	TSGROUNDPRO3A,0
TSGROUNDPRO4
	.long	TSGROUNDPRO4A,0
TSGROUNDPRO5
	.long	TSGROUNDPRO5A,TSGROUNDPRO5B,0
TSGROUNDPRO6
	.long	TSGROUNDPRO6A,TSGROUNDPRO6B,0
TSGROUNDPRO7
	.long	TSGROUNDPRO7A,TSGROUNDPRO7B,0


a_throw
	.long	TSBACKFLIP1
	.long	TSBACKFLIP2	; grab
	.long	0

	.long	TSBACKFLIP3
	.long	ani_adjustx
	.word	->0a
	.long	TSBACKFLIP4
	.long	ani_adjustx
	.word	->0a
	.long	TSBACKFLIP5
	.long	ani_adjustx
	.word	->0a
	.long	ani_calla,st_tumble_sound
	.long	TSBACKFLIP6
	.long	ani_adjustx
	.word	->11
	.long	TSBACKFLIP7
	.long	ani_adjustx
	.word	->11
	.long	TSBACKFLIP8
	.long	ani_adjustx
	.word	->30
	.long	TSBACKFLIP9
	.long	ani_adjustx
	.word	->30

	.long	TSBACKFLIP10
	.long	TSBACKFLIP11

a_spike_slam
	.long	TSBACKFLIP12
	.long	TSBACKFLIP13
	.long	TSBACKFLIP14
	.long	TSBACKFLIP15	; animate 2-gether
	.long	TSBACKFLIP16
	.long	0

	.long	TSBACKFLIP17
	.long	0

st_tumble_sound
	movk	5,a0
	jauc	ochar_sound


TSBACKFLIP1
	.long	TSBACKFLIP1A,TSBACKFLIP1B,0
TSBACKFLIP2
	.long	TSBACKFLIP2A,TSBACKFLIP2B,0
TSBACKFLIP3
	.long	TSBACKFLIP3A,0
TSBACKFLIP4
	.long	TSBACKFLIP4A,0
TSBACKFLIP5
	.long	TSBACKFLIP5A,0
TSBACKFLIP6
	.long	TSBACKFLIP6A,0
TSBACKFLIP7
	.long	TSBACKFLIP7A,0
TSBACKFLIP8
	.long	TSBACKFLIP8A,0
TSBACKFLIP9
	.long	TSBACKFLIP9A,TSBACKFLIP9B,0
TSBACKFLIP10
	.long	TSBACKFLIP10A,TSBACKFLIP10B,0
TSBACKFLIP11
	.long	TSBACKFLIP11A,TSBACKFLIP11B,0
TSBACKFLIP12
	.long	TSBACKFLIP12A,TSBACKFLIP12B,0
TSBACKFLIP13
	.long	TSBACKFLIP13A,TSBACKFLIP13B,0
TSBACKFLIP14
	.long	TSBACKFLIP14A,0
TSBACKFLIP15
	.long	TSBACKFLIP15A,0
TSBACKFLIP16
	.long	TSBACKFLIP16A,0
TSBACKFLIP17
	.long	TSBACKFLIP17A,TSBACKFLIP17B,0

;***************************************

a_st_2_sz
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	ZEROMRF1
	.long	ZEROMRF2
	.long	ZEROMRF3
	.long	0

a_st_2_lia
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	LEIAMRF1
	.long	LEIAMRF2
	.long	LEIAMRF3
	.long	0

a_st_2_robo2
a_st_2_robo1
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	KECHMRF1
	.long	KECHMRF2
	.long	KECHMRF3
	.long	0

a_st_2_swat
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	SWATMRF1
	.long	SWATMRF2
	.long	SWATMRF3
	.long	0
a_st_2_lao
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	LAOMRF1
	.long	LAOMRF2
	.long	LAOMRF3
	.long	0
a_st_2_kano
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	KANOMRF1
	.long	KANOMRF2
	.long	KANOMRF3
	.long	0
a_st_2_jax
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	JAXMRF1
	.long	JAXMRF2
	.long	JAXMRF3
	.long	0

a_st_2_ind
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	INDMRF1
	.long	INDMRF2
	.long	INDMRF3
	.long	0
a_st_2_sonya
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	SONYMRF1
	.long	SONYMRF2
	.long	SONYMRF3
	.long	0
a_st_2_tusk
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	KABLMRF1
	.long	KABLMRF2
	.long	KABLMRF3
	.long	0
a_st_2_sg
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	SHEGMRF1
	.long	SHEGMRF2
	.long	SHEGMRF3
	.long	0
a_st_2_lk
	.long	TSSTANCE1
	.long	ani_calla,morph_swpal
	.long	LIUMRF1
	.long	LIUMRF2
	.long	LIUMRF3
	.long	0

;morph_swpal2
;	jauc	player_normpal

morph_swpal
	move	*a9,a0,l
	move	*a0,a0,l
	move	*a0(icmap),a0,l
	jauc	player_swpal


ZEROMRF1
	.long	ZEROMRF1A,ZEROMRF1B,0
ZEROMRF2
	.long	ZEROMRF2A,ZEROMRF2B,0
ZEROMRF3
	.long	ZEROMRF3A,ZEROMRF3B,0
LEIAMRF1
	.long	LEIAMRF1A,LEIAMRF1B,0
LEIAMRF2
	.long	LEIAMRF2A,LEIAMRF2B,0
LEIAMRF3
	.long	LEIAMRF3A,LEIAMRF3B,0
KECHMRF1
	.long	KECHMRF1A,KECHMRF1B,0
KECHMRF2
	.long	KECHMRF2A,KECHMRF2B,0
KECHMRF3
	.long	KECHMRF3A,KECHMRF3B,0
SWATMRF1
	.long	SWATMRF1A,SWATMRF1B,0
SWATMRF2
	.long	SWATMRF2A,SWATMRF2B,0
SWATMRF3
	.long	SWATMRF3A,SWATMRF3B,0
LAOMRF1
	.long	LAOMRF1A,LAOMRF1B,0
LAOMRF2
	.long	LAOMRF2A,LAOMRF2B,0
LAOMRF3
	.long	LAOMRF3A,LAOMRF3B,0
KANOMRF1
	.long	KANOMRF1A,KANOMRF1B,0
KANOMRF2
	.long	KANOMRF2A,KANOMRF2B,0
KANOMRF3
	.long	KANOMRF3A,KANOMRF3B,0
JAXMRF1
	.long	JAXMRF1A,JAXMRF1B,0
JAXMRF2
	.long	JAXMRF2A,JAXMRF2B,0
JAXMRF3
	.long	JAXMRF3A,JAXMRF3B,0
INDMRF1
	.long	INDMRF1A,INDMRF1B,0
INDMRF2
	.long	INDMRF2A,INDMRF2B,0
INDMRF3
	.long	INDMRF3A,INDMRF3B,0
SONYMRF1
	.long	SONYMRF1A,SONYMRF1B,0
SONYMRF2
	.long	SONYMRF2A,SONYMRF2B,0
SONYMRF3
	.long	SONYMRF3A,SONYMRF3B,0
KABLMRF1
	.long	KABLMRF1A,KABLMRF1B,0
KABLMRF2
	.long	KABLMRF2A,KABLMRF2B,0
KABLMRF3
	.long	KABLMRF3A,KABLMRF3B,0
SHEGMRF1
	.long	SHEGMRF1A,SHEGMRF1B,0
SHEGMRF2
	.long	SHEGMRF2A,SHEGMRF2B,0
SHEGMRF3
	.long	SHEGMRF3A,SHEGMRF3B,0
LIUMRF1
	.long	LIUMRF1A,LIUMRF1B,0
LIUMRF2
	.long	LIUMRF2A,LIUMRF2B,0
LIUMRF3
	.long	LIUMRF3A,LIUMRF3B,0


a_floor_fire
	.long	FSKFLOOR01
	.long	FSKFLOOR02
	.long	FSKFLOOR03
	.long	FSKFLOOR04
	.long	FSKFLOOR05
	.long	0

	.long	FSKFLOOR06
	.long	FSKFLOOR07
	.long	FSKFLOOR08
	.long	FSKFLOOR09
	.long	FSKFLOOR10
	.long	0

loop_skull
	.long	FSKFLOOR11
	.long	FSKFLOOR12
	.long	FSKFLOOR13
	.long	ani_jump,loop_skull


FSKFLOOR01
	.long	FSKFLOOR01A,0
FSKFLOOR02
	.long	FSKFLOOR02A,0
FSKFLOOR03
	.long	FSKFLOOR03A,0
FSKFLOOR04
	.long	FSKFLOOR04A,0
FSKFLOOR05
	.long	FSKFLOOR05A,0
FSKFLOOR06
	.long	FSKFLOOR06A,0
FSKFLOOR07
	.long	FSKFLOOR07A,0
FSKFLOOR08
	.long	FSKFLOOR08A,0
FSKFLOOR09
	.long	FSKFLOOR09A,FSKFLOOR09B,FSKFLOOR09C,0
FSKFLOOR10
	.long	FSKFLOOR10A,0
FSKFLOOR11
	.long	FSKFLOOR11A,0
FSKFLOOR12
	.long	FSKFLOOR12A,0
FSKFLOOR13
	.long	FSKFLOOR13A,0

;***************************************************

a_scared
	.long	TSSCARED3
	.long	0

TSSCARED3
	.long	TSSCARED3A,0


a_thudd
	.long	TSTHUD1
	.long	TSTHUD2
	.long	TSTHUD3
	.long	TSTHUD4
	.long	TSTHUD5
	.long	TSTHUD6
	.long	TSTHUD7
	.long	TSTHUD8
	.long	0

TSTHUD1
	.long	TSTHUD1A,0
TSTHUD2
	.long	TSTHUD2A,0
TSTHUD3
	.long	TSTHUD3A,0
TSTHUD4
	.long	TSTHUD4A,0
TSTHUD5
	.long	TSTHUD5A,0
TSTHUD6
	.long	TSTHUD6A,0
TSTHUD7
	.long	TSTHUD7A,0
TSTHUD8
	.long	TSTHUD8A,0

;***************************************************

a_spike_slammer
	.long	TSSLAMSPIKE5
	.long	TSSLAMSPIKE6
	.long	TSSLAMSPIKE7
	.long	TSSLAMSPIKE8
	.long	TSSLAMSPIKE9
	.long	0
	.long	TSSLAMSPIKE10
	.long	TSSLAMSPIKE12
	.long	0

	.long	ani_jump,a_spike_slam

TSSLAMSPIKE5
	.long	TSSLAMSPIKE5A,TSSLAMSPIKE5B,0
TSSLAMSPIKE6
	.long	TSSLAMSPIKE6A,TSSLAMSPIKE6B,0
TSSLAMSPIKE7
	.long	TSSLAMSPIKE7A,TSSLAMSPIKE7B,0
TSSLAMSPIKE8
	.long	TSSLAMSPIKE8A,TSSLAMSPIKE8B,0
TSSLAMSPIKE9
	.long	TSSLAMSPIKE9A,TSSLAMSPIKE9B,0
TSSLAMSPIKE10
	.long	TSSLAMSPIKE10A,TSSLAMSPIKE10B,0
TSSLAMSPIKE12
	.long	TSSLAMSPIKE12A,TSSLAMSPIKE12B,0

;************************************

a_soul_suck
	.long	SKELSUK3
	.long	SKELSUK4
	.long	SKELSUK5
	.long	SKELSUK6
	.long	SKELSUK7
	.long	SKELSUK8
	.long	SKELSUK9
	.long	SKELSUK10
	.long	SKELSUK12
	.long	0

	.long	SKELSUK13
	.long	SKELSUK14
	.long	SKELSUK15
	.long	SKELSUK16
	.long	SKELSUK17
	.long	SKELSUK18
	.long	SKELSUK19
	.long	0

	.long	ani_swpal
	.long	SKELFALL1
	.long	SKELFALL2
	.long	SKELFALL3
	.long	SKELFALL4
	.long	SKELFALL5
	.long	SKELFALL6
	.long	SKELFALL7
	.long	SKELFALL8
	.long	SKELFALL9
	.long	SKELFALL10
	.long	0

;*****************************

SKELSUK3
	.long	SKELSUK3A,SKELSUK3B,SKELSUK3C,0
SKELSUK4
	.long	SKELSUK4A,SKELSUK4B,SKELSUK4C,SKELSUK4D,0
SKELSUK5
	.long	SKELSUK5A,SKELSUK5B,0
SKELSUK6
	.long	SKELSUK6A,SKELSUK6B,0
SKELSUK7
	.long	SKELSUK7A,SKELSUK7B,0
SKELSUK8
	.long	SKELSUK8A,SKELSUK8B,0
SKELSUK9
	.long	SKELSUK9A,SKELSUK9B,0
SKELSUK10
	.long	SKELSUK10A,SKELSUK10B,0
SKELSUK12
	.long	SKELSUK12A,0
SKELSUK13
	.long	SKELSUK13A,0
SKELSUK14
	.long	SKELSUK14A,0
SKELSUK15
	.long	SKELSUK15A,0
SKELSUK16
	.long	SKELSUK16A,0
SKELSUK17
	.long	SKELSUK17A,0
SKELSUK18
	.long	SKELSUK18A,0
SKELSUK19
	.long	SKELSUK19A,0
SKELFALL1
	.long	SKELFALL1A,SKELFALL1B,0
SKELFALL2
	.long	SKELFALL2A,SKELFALL2B,0
SKELFALL3
	.long	SKELFALL3A,SKELFALL3B,0
SKELFALL4
	.long	SKELFALL4A,SKELFALL4B,0
SKELFALL5
	.long	SKELFALL5A,0
SKELFALL6
	.long	SKELFALL6A,0
SKELFALL7
	.long	SKELFALL7A,0
SKELFALL8
	.long	SKELFALL8A,0
SKELFALL9
	.long	SKELFALL9A,0
SKELFALL10
	.long	SKELFALL10A,0

;************************************

	.end

