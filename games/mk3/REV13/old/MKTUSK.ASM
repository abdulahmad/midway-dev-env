**************************************************************************
*											     *
*  mk3 - Tusk Guy										*
*											     *
**************************************************************************
	.FILE	'mktusk.asm'
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo
	.include mktusk.tbl
	.include mktusk2.tbl
	.text

tusk_anitab1
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



tusk_anitab2
	.long	a_air_zap		; 0
	.long	a_tusk_blur		; 1
	.long	a_floor_blade		; 2
	.long	a_glow			; 3
	.long	ochar_floaters		; 4
	.long	a_tube			; 5
	.long	a_sho_yo_ugly_face	; 6 
	.long	a_ugly_head		; 7

a_dummy
a_stance
	.long	TRSTANCE1
	.long	TRSTANCE2
	.long	TRSTANCE3
	.long	TRSTANCE4
	.long	TRSTANCE5
	.long	TRSTANCE6
	.long	TRSTANCE7
	.long	TRSTANCE8
	.long	TRSTANCE9
	.long	TRSTANCE10
	.long	ani_jump,a_stance

TRSTANCE1
	.long	TRSTANCE1A,TRSTANCE1B,0
TRSTANCE2
	.long	TRSTANCE2A,TRSTANCE2B,0
TRSTANCE3
	.long	TRSTANCE3A,TRSTANCE3B,0
TRSTANCE4
	.long	TRSTANCE4A,TRSTANCE4B,0
TRSTANCE5
	.long	TRSTANCE5A,TRSTANCE5B,0
TRSTANCE6
	.long	TRSTANCE6A,TRSTANCE6B,0
TRSTANCE7
	.long	TRSTANCE7A,TRSTANCE7B,0
TRSTANCE8
	.long	TRSTANCE8A,TRSTANCE8B,0
TRSTANCE9
	.long	TRSTANCE9A,TRSTANCE9B,0
TRSTANCE10
	.long	TRSTANCE10A,TRSTANCE10B,0

a_turn
	.long	TRTURN1
	.long	ani_flip
	.long	TRTURN2
	.long	TRTURN1
	.long	0

TRTURN1
	.long	TRTURN1A,TRTURN1B,0
TRTURN2
	.long	TRTURN2A,TRTURN2B,0

a_walkb
	.long	TRWALK9
	.long	TRWALK8
	.long	TRWALK7
	.long	TRWALK6
	.long	TRWALK5
	.long	TRWALK4
	.long	TRWALK3
	.long	TRWALK2
	.long	TRWALK1
	.long	ani_jump,a_walkb

a_walkf
	.long	TRWALK1
	.long	TRWALK2
	.long	TRWALK3
	.long	TRWALK4
	.long	TRWALK5
	.long	TRWALK6
	.long	TRWALK7
	.long	TRWALK8
	.long	TRWALK9
	.long	ani_jump,a_walkf



TRWALK1	.long	TRWALKTORSO1A
	.long	TRWALKLEGS1A,TRWALKLEGS1B,0
TRWALK2	.long	TRWALKTORSO2A
	.long	TRWALKLEGS2A,TRWALKLEGS2B,0
TRWALK3	.long	TRWALKTORSO3A
	.long	TRWALKLEGS3A,0
TRWALK4	.long	TRWALKTORSO4A
	.long	TRWALKLEGS4A,TRWALKLEGS4B,0
TRWALK5	.long	TRWALKTORSO5A
	.long	TRWALKLEGS5A,TRWALKLEGS5B,0
TRWALK6	.long	TRWALKTORSO6A
	.long	TRWALKLEGS6A,TRWALKLEGS6B,0
TRWALK7	.long	TRWALKTORSO7A
	.long	TRWALKLEGS7A,TRWALKLEGS7B,0
TRWALK8	.long	TRWALKTORSO8A
	.long	TRWALKLEGS8A,TRWALKLEGS8B,0
TRWALK9	.long	TRWALKTORSO9A
	.long	TRWALKLEGS9A,TRWALKLEGS9B,0

a_duck
	.long	TRDUCK1
	.long	TRDUCK2
	.long	TRDUCK3
	.long	0


TRDUCK1
	.long	TRDUCK1A,TRDUCK1B,0
TRDUCK2
	.long	TRDUCK2A,TRDUCK2B,0
TRDUCK3
	.long	TRDUCK3A,TRDUCK3B,0

a_duck_block
	.long	TRDUCKBLOCK1
	.long	TRDUCKBLOCK2
	.long	TRDUCKBLOCK3
	.long	0


TRDUCKBLOCK1
	.long	TRDUCKBLOCK1A,TRDUCKBLOCK1B,0
TRDUCKBLOCK2
	.long	TRDUCKBLOCK2A,TRDUCKBLOCK2B,0
TRDUCKBLOCK3
	.long	TRDUCKBLOCK3A,TRDUCKBLOCK3B,0

a_duck_punch
	.long	TRDUCKPUNCH1
	.long	TRDUCKPUNCH2
	.long	TRDUCKPUNCH3
	.long	0
	.long	TRDUCKPUNCH2
	.long	TRDUCKPUNCH1
	.long	TRDUCK3
	.long	0

TRDUCKPUNCH1
	.long	TRDUCKPUNCH1A,TRDUCKPUNCH1B,0
TRDUCKPUNCH2
	.long	TRDUCKPUNCH2A,TRDUCKPUNCH2B,0
TRDUCKPUNCH3
	.long	TRDUCKPUNCH3A,TRDUCKPUNCH3B,0

a_duck_turn
	.long	TRDUCKTURN1
	.long	TRDUCKTURN2
	.long	ani_flip
	.long	TRDUCKTURN2
	.long	TRDUCK3
	.long	0

TRDUCKTURN1
	.long	TRDUCKTURN1A,TRDUCKTURN1B,0
TRDUCKTURN2
	.long	TRDUCKTURN2A,TRDUCKTURN2B,0


a_duck_kick_lo
	.long	TRDUCKLOKICK1
	.long	TRDUCKLOKICK2
	.long	TRDUCKLOKICK3
	.long	0
	.long	TRDUCKLOKICK2
	.long	TRDUCKLOKICK1
	.long	TRDUCK3
	.long	0

TRDUCKLOKICK1
	.long	TRDUCKLOKICK1A,TRDUCKLOKICK1B,0
TRDUCKLOKICK2
	.long	TRDUCKLOKICK2A,TRDUCKLOKICK2B,TRDUCKLOKICK2C,0
TRDUCKLOKICK3
	.long	TRDUCKLOKICK3A,TRDUCKLOKICK3B,TRDUCKLOKICK3C,0

a_duck_kick_hi
	.long	TRDUCKHIKICK1
	.long	TRDUCKHIKICK2
	.long	TRDUCKHIKICK3
	.long	TRDUCKHIKICK4
	.long	0
	.long	TRDUCKHIKICK3
	.long	TRDUCKHIKICK2
	.long	TRDUCKHIKICK1
	.long	TRDUCK3
	.long	0


TRDUCKHIKICK1
	.long	TRDUCKHIKICK1A,TRDUCKHIKICK1B,0
TRDUCKHIKICK2
	.long	TRDUCKHIKICK2A,TRDUCKHIKICK2B,0
TRDUCKHIKICK3
	.long	TRDUCKHIKICK3A,TRDUCKHIKICK3B,0
TRDUCKHIKICK4
	.long	TRDUCKHIKICK4A,TRDUCKHIKICK4B,TRDUCKHIKICK4C,0

a_uppercut
;	.long	TRUPPERCUT1
	.long	TRUPPERCUT2
	.long	TRUPPERCUT3
	.long	TRUPPERCUT4
	.long	TRUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
	.long	TRUPPERCUT7
	.long	0

	.long	TRHIPUNCH2
	.long	TRHIPUNCH1
	.long	0

	.long	TRUPPERCUT6


TRUPPERCUT1
	.long	TRUPPERCUT1A,TRUPPERCUT1B,0
TRUPPERCUT2
	.long	TRUPPERCUT2A,TRUPPERCUT2B,0
TRUPPERCUT3
	.long	TRUPPERCUT3A,TRUPPERCUT3B,0
TRUPPERCUT4
	.long	TRUPPERCUT4A,TRUPPERCUT4B,0
TRUPPERCUT5
	.long	TRUPPERCUT5A,TRUPPERCUT5B,0
TRUPPERCUT6
	.long	TRUPPERCUT6A,TRUPPERCUT6B,0
TRUPPERCUT7
	.long	TRUPPERCUT7A,TRUPPERCUT7B,0


a_duck_hit
	.long	TRDUCKHIT2
	.long	TRDUCKHIT3
	.long	TRDUCKHIT2
	.long	TRDUCKHIT1
	.long	0

TRDUCKHIT1
	.long	TRDUCKHIT1A,TRDUCKHIT1B,0
TRDUCKHIT2
	.long	TRDUCKHIT2A,TRDUCKHIT2B,0
TRDUCKHIT3
	.long	TRDUCKHIT3A,TRDUCKHIT3B,0

a_block
	.long	TRHIBLOCK1
	.long	TRHIBLOCK2
	.long	TRHIBLOCK3
	.long	0

TRHIBLOCK1
	.long	TRHIBLOCK1A,TRHIBLOCK1B,0
TRHIBLOCK2
	.long	TRHIBLOCK2A,TRHIBLOCK2B,0
TRHIBLOCK3
	.long	TRHIBLOCK3A,TRHIBLOCK3B,0

a_hipunch
	.long	TRHIPUNCH1
	.long	TRHIPUNCH2
	.long	TRHIPUNCH3
	.long	0

	.long	TRHIPUNCH4
	.long	TRHIPUNCH5
	.long	TRHIPUNCH6
	.long	0

	.long	TRHIPUNCH5
	.long	TRHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	TRHIPUNCH2
	.long	TRHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	TRHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	TRHIPUNCH4
	.long	TRLOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	TRHIPUNCH5
	.long	TRLOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0

TRHIPUNCH1
	.long	TRHIPUNCH1A,TRHIPUNCH1B,0
TRHIPUNCH2
	.long	TRHIPUNCH2A,TRHIPUNCH2B,0
TRHIPUNCH3
	.long	TRHIPUNCH3A,TRHIPUNCH3B,0
TRHIPUNCH4
	.long	TRHIPUNCH4A,TRHIPUNCH4B,0
TRHIPUNCH5
	.long	TRHIPUNCH5A,TRHIPUNCH5B,0
TRHIPUNCH6
	.long	TRHIPUNCH6A,TRHIPUNCH6B,0
TRHIPUNCH7
	.long	TRHIPUNCH7A,TRHIPUNCH7B,0

a_lopunch
	.long	TRLOPUNCH1
	.long	TRLOPUNCH2
	.long	TRLOPUNCH3
	.long	0

	.long	TRLOPUNCH4
	.long	TRLOPUNCH5
	.long	TRLOPUNCH6
	.long	0

	.long	TRLOPUNCH5
	.long	TRLOPUNCH4
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	TRLOPUNCH2
	.long	TRLOPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	TRHIPUNCH7
	.long	0
*
* Med to High #1
*
	.long	TRLOPUNCH4
	.long	TRLOPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	TRLOPUNCH4
	.long	TRHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)


TRLOPUNCH1
	.long	TRLOPUNCH1A,TRLOPUNCH1B,0
TRLOPUNCH2
	.long	TRLOPUNCH2A,TRLOPUNCH2B,0
TRLOPUNCH3
	.long	TRLOPUNCH3A,TRLOPUNCH3B,0
TRLOPUNCH4
	.long	TRLOPUNCH4A,TRLOPUNCH4B,0
TRLOPUNCH5
	.long	TRLOPUNCH5A,TRLOPUNCH5B,0
TRLOPUNCH6
	.long	TRLOPUNCH6A,TRLOPUNCH6B,0

a_elbow
	.long	TRSWIPE1
	.long	TRSWIPE2
	.long	TRSWIPE3
	.long	TRSWIPE4
	.long	TRSWIPE5
	.long	0
	.long	TRSWIPE4
	.long	TRSWIPE3
	.long	TRSWIPE2
	.long	TRSWIPE1
	.long	0

	.long	TRSWIPE6
	.long	TRSWIPE7
	.long	TRSWIPE8	; ani3 = hit 2
	.long	0

	.long	TRSWIPE9
	.long	TRSWIPE10
	.long	TRSWIPE11
	.long	TRSWIPE12
	.long	TRSWIPE13	; ani4 = hit 3
	.long	0

	.long	TRSWIPE14
	.long	TRSWIPE15
	.long	TRSWIPE16
	.long	TRSWIPE17	; ani5 = hit 4
	.long	0

	.long	TRSWIPE18
	.long	TRSWIPE19
	.long	TRSWIPE20	; ani6 = un elbow
	.long	0


TRSWIPE1
	.long	TRSWIPE1A,TRSWIPE1B,0
TRSWIPE2
	.long	TRSWIPE2A,TRSWIPE2B,0
TRSWIPE3
	.long	TRSWIPE3A,TRSWIPE3B,0
TRSWIPE4
	.long	TRSWIPE4A,TRSWIPE4B,TRSWIPE4C,0
TRSWIPE5
	.long	TRSWIPE5A,TRSWIPE5B,TRSWIPE5C,0
TRSWIPE6
	.long	TRSWIPE6A,TRSWIPE6B,TRSWIPE6C,0
TRSWIPE7
	.long	TRSWIPE7A,TRSWIPE7B,TRSWIPE7C,0
TRSWIPE8
	.long	TRSWIPE8A,TRSWIPE8B,TRSWIPE8C,0
TRSWIPE9
	.long	TRSWIPE9A,TRSWIPE9B,TRSWIPE9C,0
TRSWIPE10
	.long	TRSWIPE10A,TRSWIPE10B,0
TRSWIPE11
	.long	TRSWIPE11A,TRSWIPE11B,TRSWIPE11C,TRSWIPE11D,0
TRSWIPE12
	.long	TRSWIPE12A,TRSWIPE12B,TRSWIPE12C,0
TRSWIPE13
	.long	TRSWIPE13A,TRSWIPE13B,TRSWIPE13C,0
TRSWIPE14
	.long	TRSWIPE14A,TRSWIPE14B,TRSWIPE14C,0
TRSWIPE15
	.long	TRSWIPE15A,TRSWIPE15B,TRSWIPE15C,0
TRSWIPE16
	.long	TRSWIPE16A,TRSWIPE16B,TRSWIPE16C,TRSWIPE16D,TRSWIPE16E,0
TRSWIPE17
	.long	TRSWIPE17A,TRSWIPE17B,TRSWIPE17C,TRSWIPE17D,0
TRSWIPE18
	.long	TRSWIPE18A,TRSWIPE18B,TRSWIPE18C,0
TRSWIPE19
	.long	TRSWIPE19A,TRSWIPE19B,TRSWIPE19C,0
TRSWIPE20
	.long	TRSWIPE20A,TRSWIPE20B,0

a_lokick
	.long	TRLOKICK1
	.long	TRLOKICK2
	.long	TRLOKICK3
	.long	TRLOKICK4
	.long	TRLOKICK5
	.long	TRLOKICK6
	.long	0
	.long	TRLOKICK5
	.long	TRLOKICK4
	.long	TRLOKICK3
	.long	TRLOKICK2
	.long	TRLOKICK1
	.long	0

TRLOKICK1
	.long	TRLOKICK1A,TRLOKICK1B,0
TRLOKICK2
	.long	TRLOKICK2A,0
TRLOKICK3
	.long	TRLOKICK3A,TRLOKICK3B,0
TRLOKICK4
	.long	TRLOKICK4A,0
TRLOKICK5
	.long	TRLOKICK5A,TRLOKICK5B,0
TRLOKICK6
	.long	TRLOKICK6A,TRLOKICK6B,0

a_hikick
	.long	TRLOKICK1
	.long	TRLOKICK2
	.long	TRLOKICK3
	.long	TRHIKICK1
	.long	TRHIKICK2
	.long	TRHIKICK3
	.long	0
	.long	TRHIKICK2
	.long	TRHIKICK1
	.long	TRLOKICK3
	.long	TRLOKICK2
	.long	TRLOKICK1
	.long	0

TRHIKICK1
	.long	TRHIKICK1A,TRHIKICK1B,0
TRHIKICK2
	.long	TRHIKICK2A,0
TRHIKICK3
	.long	TRHIKICK3A,TRHIKICK3B,TRHIKICK3C,0

a_knee
	.long	TRKNEEKICK1
	.long	TRKNEEKICK2
	.long	TRKNEEKICK3
	.long	0

	.long	TRKNEEKICK2
	.long	TRKNEEKICK1	; part 2
	.long	0

	.long	TRKNEEKICK4
	.long	ani_adjustx
	.word	8
	.long	TRKNEEKICK5
	.long	ani_adjustx
	.word	8
	.long	TRKNEEKICK6
	.long	TRKNEEKICK7	; part 3 = knee 2
	.long	0

	.long	TRKNEEKICK6
	.long	TRKNEEKICK5
	.long	TRKNEEKICK4	; part 4 = un knee 2
	.long	0

TRKNEEKICK1
	.long	TRKNEEKICK1A,TRKNEEKICK1B,0
TRKNEEKICK2
	.long	TRKNEEKICK2A,0
TRKNEEKICK3
	.long	TRKNEEKICK3A,0
TRKNEEKICK4
	.long	TRKNEEKICK4A,0
TRKNEEKICK5
	.long	TRKNEEKICK5A,0
TRKNEEKICK6
	.long	TRKNEEKICK6A,0
TRKNEEKICK7
	.long	TRKNEEKICK7A,TRKNEEKICK7B,0

a_sweep_kick
	.long	TRSWEEPKICK1
	.long	TRSWEEPKICK2
	.long	TRSWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	TRSWEEPKICK4
	.long	TRSWEEPKICK5
	.long	0

	.long	TRSWEEPKICK6
	.long	TRSWEEPKICK7
	.long	TRSWEEPKICK8
	.long	0

TRSWEEPKICK1
	.long	TRSWEEPKICK1A,TRSWEEPKICK1B,0
TRSWEEPKICK2
	.long	TRSWEEPKICK2A,TRSWEEPKICK2B,0
TRSWEEPKICK3
	.long	TRSWEEPKICK3A,TRSWEEPKICK3B,0
TRSWEEPKICK4
	.long	TRSWEEPKICK4A,TRSWEEPKICK4B,0
TRSWEEPKICK5
	.long	TRSWEEPKICK5A,TRSWEEPKICK5B,0
TRSWEEPKICK6
	.long	TRSWEEPKICK6A,TRSWEEPKICK6B,0
TRSWEEPKICK7
	.long	TRSWEEPKICK7A,TRSWEEPKICK7B,0
TRSWEEPKICK8
	.long	TRSWEEPKICK8A,TRSWEEPKICK8B,0

a_roundhouse
	.long	TRROUNDKICK1
	.long	TRROUNDKICK2
	.long	TRROUNDKICK3
	.long	TRROUNDKICK4
	.long	ani_nosleep
	.long	TRROUNDKICK5
	.long	0
	.long	TRROUNDKICK6
	.long	TRROUNDKICK7
	.long	TRROUNDKICK8
	.long	0

TRROUNDKICK1
	.long	TRROUNDKICK1A,TRROUNDKICK1B,0
TRROUNDKICK2
	.long	TRROUNDKICK2A,0
TRROUNDKICK3
	.long	TRROUNDKICK3A,TRROUNDKICK3B,0
TRROUNDKICK4
	.long	TRROUNDKICK4A,TRROUNDKICK4B,0
TRROUNDKICK5
	.long	TRROUNDKICK5A,TRROUNDKICK5B,0
TRROUNDKICK6
	.long	TRROUNDKICK6A,0
TRROUNDKICK7
	.long	TRROUNDKICK7A,0
TRROUNDKICK8
	.long	TRROUNDKICK8A,TRROUNDKICK8B,0

a_jump
	.long	TRJUMP1
	.long	TRJUMP2
	.long	TRJUMP3
	.long	0

TRJUMP1	.long	TRJUMP1A,TRJUMP1B,0
TRJUMP2	.long	TRJUMP2A,TRJUMP2B,0
TRJUMP3	.long	TRJUMP3A,TRJUMP3B,0



a_jump_kick
	.long	TRJUMPKICK1
	.long	TRJUMPKICK2
	.long	TRJUMPKICK3
	.long	0
	.long	TRJUMPKICK2
	.long	TRJUMPKICK1
	.long	0


TRJUMPKICK1
	.long	TRJUMPKICK1A,0
TRJUMPKICK2
	.long	TRJUMPKICK2A,TRJUMPKICK2B,0
TRJUMPKICK3
	.long	TRJUMPKICK3A,TRJUMPKICK3B,0

a_flip_kick
	.long	TRFLIPKICK1
	.long	TRFLIPKICK2
	.long	TRFLIPKICK3
	.long	0
	.long	TRFLIPKICK2
	.long	TRFLIPKICK1
	.long	0

TRFLIPKICK1
	.long	TRFLIPKICK1A,TRFLIPKICK1B,0
TRFLIPKICK2
	.long	TRFLIPKICK2A,TRFLIPKICK2B,0
TRFLIPKICK3
	.long	TRFLIPKICK3A,0

a_flip_punch
	.long	TRFLIPUNCH1
	.long	TRFLIPUNCH2
	.long	TRFLIPUNCH3
	.long	0
	.long	TRFLIPUNCH2
	.long	TRFLIPUNCH1
	.long	0

TRFLIPUNCH1
	.long	TRFLIPUNCH1A,TRFLIPUNCH1B,0
TRFLIPUNCH2
	.long	TRFLIPUNCH2A,TRFLIPUNCH2B,TRFLIPUNCH2C,0
TRFLIPUNCH3
	.long	TRFLIPUNCH3A,TRFLIPUNCH3B,TRFLIPUNCH3C,0

a_fflip
	.long	TRJUMPFLIP1
	.long	TRJUMPFLIP2
	.long	TRJUMPFLIP3
	.long	TRJUMPFLIP4
	.long	TRJUMPFLIP5
	.long	TRJUMPFLIP6
	.long	TRJUMPFLIP7
	.long	TRJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip
	.long	TRJUMPFLIP1
	.long	TRJUMPFLIP8
	.long	TRJUMPFLIP7
	.long	TRJUMPFLIP6
	.long	TRJUMPFLIP5
	.long	TRJUMPFLIP4
	.long	TRJUMPFLIP3
	.long	TRJUMPFLIP2
	.long	ani_jump,a_bflip+32


TRJUMPFLIP1
	.long	TRJUMPFLIP1A,TRJUMPFLIP1B,0
TRJUMPFLIP2
	.long	TRJUMPFLIP2A,0
TRJUMPFLIP3
	.long	TRJUMPFLIP3A,0
TRJUMPFLIP4
	.long	TRJUMPFLIP4A,0
TRJUMPFLIP5
	.long	TRJUMPFLIP5A,0
TRJUMPFLIP6
	.long	TRJUMPFLIP6A,0
TRJUMPFLIP7
	.long	TRJUMPFLIP7A,0
TRJUMPFLIP8
	.long	TRJUMPFLIP8A,0


a_air_zap
	.long	TRAIRPROJ1
	.long	TRAIRPROJ2
	.long	0
	.long	TRAIRPROJ1
	.long	0

TRAIRPROJ1
	.long	TRAIRPROJ1A,TRAIRPROJ1B,0
TRAIRPROJ2
	.long	TRAIRPROJ2A,TRAIRPROJ2B,0

a_hit_hi
	.long	TRHIHIT2
	.long	TRHIHIT3
	.long	TRHIHIT2
	.long	TRHIHIT1
	.long	0

TRHIHIT1	.long	TRHIHIT1A,TRHIHIT1B,0
TRHIHIT2	.long	TRHIHIT2A,TRHIHIT2B,0
TRHIHIT3	.long	TRHIHIT3A,TRHIHIT3B,0


a_hit_lo
	.long	TRLOHIT2
	.long	TRLOHIT3
	.long	TRLOHIT2
	.long	TRLOHIT1
	.long	0

TRLOHIT1
	.long	TRLOHIT1A,TRLOHIT1B,0
TRLOHIT2
	.long	TRLOHIT2A,TRLOHIT2B,0
TRLOHIT3
	.long	TRLOHIT3A,TRLOHIT3B,0

a_stumble
	.long	TRSTUMBLE1
	.long	TRSTUMBLE2
	.long	TRSTUMBLE3
	.long	TRSTUMBLE4
	.long	TRSTUMBLE5
	.long	TRSTUMBLE6
	.long	TRSTUMBLE7
	.long	0

j_stumble
	.long	TRSTUMBLE1
	.long	TRSTUMBLE2
	.long	TRSTUMBLE3
	.long	TRSTUMBLE4
	.long	TRSTUMBLE5
	.long	TRSTUMBLE6
	.long	TRSTUMBLE7
	.long	ani_jump,j_stumble

TRSTUMBLE1
	.long	TRSTUMBLE1A,TRSTUMBLE1B,0
TRSTUMBLE2
	.long	TRSTUMBLE2A,0
TRSTUMBLE3
	.long	TRSTUMBLE3A,0
TRSTUMBLE4
	.long	TRSTUMBLE4A,0
TRSTUMBLE5
	.long	TRSTUMBLE5A,TRSTUMBLE5B,0
TRSTUMBLE6
	.long	TRSTUMBLE6A,TRSTUMBLE6B,0
TRSTUMBLE7
	.long	TRSTUMBLE7A,TRSTUMBLE7B,0


a_dizzy
	.long	TRSTUNNED1
	.long	TRSTUNNED2
	.long	TRSTUNNED3
	.long	TRSTUNNED4
	.long	TRSTUNNED5
	.long	TRSTUNNED6
	.long	TRSTUNNED7
	.long	TRSTUNNED8
	.long	ani_jump,a_dizzy


TRSTUNNED1
	.long	TRSTUNNED1A,TRSTUNNED1B,0
TRSTUNNED2
	.long	TRSTUNNED2A,TRSTUNNED2B,0
TRSTUNNED3
	.long	TRSTUNNED3A,TRSTUNNED3B,0
TRSTUNNED4
	.long	TRSTUNNED4A,TRSTUNNED4B,0
TRSTUNNED5
	.long	TRSTUNNED5A,TRSTUNNED5B,0
TRSTUNNED6
	.long	TRSTUNNED6A,TRSTUNNED6B,0
TRSTUNNED7
	.long	TRSTUNNED7A,TRSTUNNED7B,0
TRSTUNNED8
	.long	TRSTUNNED8A,TRSTUNNED8B,0


a_sweepup
	.long	TRSWEEPUP1
	.long	TRSWEEPUP2
	.long	TRSWEEPUP3
	.long	TRSWEEPUP4
	.long	TRSWEEPUP5
	.long	TRSWEEPUP6
	.long	TRSWEEPUP7
	.long	0


TRSWEEPUP1
	.long	TRSWEEPUP1A,TRSWEEPUP1B,0
TRSWEEPUP2
	.long	TRSWEEPUP2A,TRSWEEPUP2B,0
TRSWEEPUP3
	.long	TRSWEEPUP3A,0
TRSWEEPUP4
	.long	TRSWEEPUP4A,0
TRSWEEPUP5
	.long	TRSWEEPUP5A,0
TRSWEEPUP6
	.long	TRSWEEPUP6A,0
TRSWEEPUP7
	.long	TRSWEEPUP7A,0

a_knockdown
	.long	TRKNOCKDOWN1
	.long	TRKNOCKDOWN2
	.long	TRKNOCKDOWN3
	.long	TRKNOCKDOWN4
	.long	TRKNOCKDOWN5
	.long	TRKNOCKDOWN6
	.long	0
	.long	TRKNOCKDOWN7
	.long	TRGETUP1
	.long	0

TRKNOCKDOWN1
	.long	TRKNOCKDOWN1A,TRKNOCKDOWN1B,0
TRKNOCKDOWN2
	.long	TRKNOCKDOWN2A,0
TRKNOCKDOWN3
	.long	TRKNOCKDOWN3A,0
TRKNOCKDOWN4
	.long	TRKNOCKDOWN4A,TRKNOCKDOWN4B,0
TRKNOCKDOWN5
	.long	TRKNOCKDOWN5A,TRKNOCKDOWN5B,0
TRKNOCKDOWN6
	.long	TRKNOCKDOWN6A,TRKNOCKDOWN6B,0
TRKNOCKDOWN7
	.long	TRKNOCKDOWN7A,0

a_sweep_fall
	.long	TRSWEEPFALL1
	.long	TRSWEEPFALL2
	.long	TRSWEEPFALL3
	.long	TRSWEEPFALL4
	.long	0
	.long	TRSWEEPFALL5
	.long	TRSWEEPFALL6
	.long	0

TRSWEEPFALL1
	.long	TRSWEEPFALL1A,TRSWEEPFALL1B,0
TRSWEEPFALL2
	.long	TRSWEEPFALL2A,TRSWEEPFALL2B,0
TRSWEEPFALL3
	.long	TRSWEEPFALL3A,TRSWEEPFALL3B,TRSWEEPFALL3C,0
TRSWEEPFALL4
	.long	TRSWEEPFALL4A,TRSWEEPFALL4B,TRSWEEPFALL4C,0
TRSWEEPFALL5
	.long	TRSWEEPFALL5A,TRSWEEPFALL5B,0
TRSWEEPFALL6
	.long	TRSWEEPFALL6A,0

a_afb_kano
	.long	ani_offset_xy
	.word	->40,->1b
	.long	TRFLIPPED1

	.long	ani_offset_xy
	.word	->3c,->0b
	.long	TRKNOCKDOWN4

	.long	ani_offset_xy
 	.word	->59,>22
	.long	TRKNOCKDOWN5
	.long	0
*
* fall down solo
*
	.long	TRKNOCKDOWN5
	.long	TRKNOCKDOWN6
	.long	TRKNOCKDOWN7
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	->1e,->38
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	>01,->48
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>30,->38
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>49,->1e
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>58,->15
	.long	TRKNOCKDOWN6
	.long	ani_offset_xy
	.word	>62,>1a
	.long	TRKNOCKDOWN6
	.long	0




a_fb_sg
	.long	ani_offset_xy
	.word	->15,->4d
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->01,->50
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	>0e,->44
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>11,->21
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	->17,->11
	.long	TRFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	->26,->09
  	.long	TRKNOCKDOWN7
	.long	0

a_fb_st
	.long	ani_offset_xy
	.word	->48,->08
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->41,>07
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->2a,>0a
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	->07,>03
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>1d,>25
	.long	TRFLIPPED4

	.long	ani_offset_xy
	.word	->0a,>02
	.long	TRKNOCKDOWN6
	.long	ani_offset_xy
	.word	->29,->01
	.long	TRKNOCKDOWN6
	.long	ani_offset_xy
	.word	->38,->04
	.long	TRKNOCKDOWN6

	.long	ani_offset_xy
	.word	->5c,>0a
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->67,->0b
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->3c,->4c
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	>2b,->41
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>4c,->18
	.long	TRFLIPPED5
	.long	ani_offset_xy
	.word	>45,->08
	.long	TRKNOCKDOWN6
	.long	0



a_fb_lk
	.long	ani_offset_xy
	.word	->44,->01
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->3b,>07
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->1a,>0e
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	>10,>06
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>42,->01
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>88,->1f
	.long	TRFLIPPED4
	.long	0

	.long	TRFLIPPED5
	.long	TRKNOCKDOWN5
	.long	TRKNOCKDOWN6
	.long	TRKNOCKDOWN7
	.long	0


a_fb_kano
	.long	ani_offset_xy
	.word	->3f,->1b
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->28,->2e
	.long	TRFLIPPED2
	.long	ani_offset_xy
 	.word	>35,->37
	.long	TRFLIPPED3
	.long	0

	.long	TRFLIPPED4
	.long	TRFLIPPED5
	.long	TRKNOCKDOWN5
	.long	TRKNOCKDOWN6
	.long	TRKNOCKDOWN7
	.long	0


a_fb_sonya
	.long	ani_offset_xy
	.word	->2f,>04
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->1f,>0d
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	>0e,>06
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>5b,->0c
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>8c,->21
	.long	TRFLIPPED4
	.long	0

	.long	TRFLIPPED5
	.long	TRKNOCKDOWN5
	.long	TRKNOCKDOWN6
	.long	TRKNOCKDOWN7
	.long	0


a_fb_jax
	.long	ani_offset_xy
	.word	->43,->1f
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->2b,->36
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	>00,->4b
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>37,->30
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>4e,->0c
	.long	TRKNOCKDOWN6
	.long	ani_offset_xy
	.word	>42,>07
	.long	TRKNOCKDOWN7
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	->5c,->18
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->48,->3e
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	->13,->58
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>2d,->3e
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>4e,->0b
	.long	TRFLIPPED5
	.long	ani_offset_xy
	.word	>4d,->02
	.long	TRKNOCKDOWN7
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	->49,->32
	.long	TRFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	>51,->1f
	.long	TRFLIPPED5

	.long	ani_offset_xy
	.word	>40,>05
	.long	TRFLIPPED5

	.long	ani_offset_xy
	.word	->04,->08
	.long	TRKNOCKDOWN5

	.long	ani_offset_xy
	.word	->47,->33
	.long	TRKNOCKDOWN5

	.long	ani_offset_xy
	.word	->72,->60
	.long	TRKNOCKDOWN5
	.long	0


a_fb_swat
	.long	ani_offset_xy
	.word	->50,->0d
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->3c,->41
	.long	TRFLIPPED2
	.long	ani_offset_xy
	.word	>23,->50
	.long	TRFLIPPED3
	.long	ani_offset_xy
	.word	>56,->13
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>4a,>06
	.long	TRKNOCKDOWN6
	.long	0


a_fb_lia
	.long	ani_offset_xy
	.word	->64,>00
	.long	TRSTUMBLE1
	.long	ani_offset_xy
	.word	->73,>03
	.long	TRSTUMBLE1

	.long	ani_offset_xy
	.word	->75,->1e
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->57,->3d
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	->23,->46
	.long	TRFLIPPED1
	.long	ani_offset_xy
	.word	>1e,->4e
	.long	TRFLIPPED1

	.long	ani_offset_xy
	.word	>a8,>12
	.long	TRFLIPPED4
	.long	ani_offset_xy
	.word	>8d,>00
	.long	TRKNOCKDOWN7
	.long	0


a_fb_robo
	.long	ani_offset_xy
	.word	->52,->0b
	.long	TRFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->4f,->32
	.long	TRFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->38,->48
	.long	TRFLIPPED2		; 3

	.long	ani_offset_xy
	.word	->0a,->6c
	.long	TRFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>38,->62
	.long	TRFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>5c,->50
	.long	TRFLIPPED4		; 6

	.long	ani_offset_xy
	.word	>7b,->13
	.long	TRFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5a,->11
	.long	TRKNOCKDOWN7		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	->30,->07
	.long	TRSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->2c,->1d
	.long	TRFLIPPED1		; 2
	.long	ani_offset_xy
	.word	->0e,->2a
	.long	TRFLIPPED2		; 3
	.long	ani_offset_xy
	.word	>16,->21
	.long	TRFLIPPED3		; 4
	.long	ani_offset_xy
	.word	>25,>03
	.long	TRFLIPPED4		; 5
	.long	ani_offset_xy
	.word	>18,>16
	.long	TRFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->1e,->1e
	.long	TRKNOCKDOWN7		; 7
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	->29,>1a
	.long	TRSTUMBLE1		; 1
	.long	ani_offset_xy
	.word	->12,>30
	.long	TRSTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	->29,>22 
	.long	TRFLIPPED1		; 3
	.long	ani_offset_xy
	.word	->4a,->0f
	.long	TRFLIPPED2		; 4
	.long	ani_offset_xy
	.word	->32,->4f
	.long	TRFLIPPED3		; 5
	.long	ani_offset_xy
	.word	>10,->67
	.long	TRFLIPPED4		; 6
	.long	ani_offset_xy
	.word	>53,->6a
	.long	TRFLIPPED5		; 7
	.long	ani_offset_xy
	.word	>5e,->51
	.long	TRFLIPPED5		; 8
	.long	ani_offset_xy
	.word	>77,>02
	.long	TRFLIPPED5		; 9
	.long	ani_offset_xy
	.word	>77,>52
	.long	TRFLIPPED5		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	->6e,>00
	.long	TRFLIPPED1		; 1
	.long	ani_offset_xy
	.word	->6c,->4a
	.long	TRFLIPPED2		; 2
	.long	ani_offset_xy
	.word	->18,->78
	.long	TRFLIPPED3		; 3
	.long	ani_offset_xy
	.word	>40,->57
	.long	TRFLIPPED4		; 4
	.long	ani_offset_xy
	.word	>44,->15
	.long	TRFLIPPED5		; 5

	.long	ani_offset_xy
	.word	>0f,>1e
	.long	TRFLIPPED5		; 6
	.long	ani_offset_xy
	.word	->31,>03
  	.long	TRKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	->68,>01
	.long	TRFLIPPED1		; 8
	.long	ani_offset_xy
	.word	->58,->5f
	.long	TRFLIPPED2		; 9
	.long	ani_offset_xy
	.word	>17,->6c
	.long	TRFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	>65,->05
	.long	TRFLIPPED5		; 11
	.long	ani_offset_xy
	.word	>64,>09
  	.long	TRKNOCKDOWN6		; 12
	.long	0


a_legged
	.long	ani_offset_xy
	.word	->64,->01
	.long	TRKNOCKDOWN1

	.long	ani_offset_xy
	.word	->51,->22
	.long	TRFLIPPED1

	.long	ani_offset_xy
	.word	->21,->43
	.long	TRFLIPPED3

	.long	ani_offset_xy
	.word	>24,->2d
	.long	TRFLIPPED4

	.long	ani_offset_xy
	.word	>5e,>00
	.long	TRFLIPPED5
	.long	0


a_zoomed
	.long	ani_offset_xy
	.word	>55,->1c
	.long	TRKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	>57,>0f
	.long	TRKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	>27,>1e
	.long	TRKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	->30,>21
	.long	TRKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	->8b,->13
	.long	TRFLIPPED1	; 5

	.long	ani_offset_xy
	.word	->41,->55
	.long	TRFLIPPED3	; 6
	.long	0

	.long	TRFLIPPED3
	.long	TRFLIPPED4
	.long	TRFLIPPED5
	.long	TRKNOCKDOWN5
	.long	TRKNOCKDOWN6
	.long	TRKNOCKDOWN7
	.long	0


a_shook
	.long	ani_offset_xy
	.word	->5a,->06
	.long	TRSTUMBLE2	; 3

	.long	ani_offset_xy
	.word	->41,->1c
	.long	TRSTUMBLE2	; 4

	.long	ani_offset_xy
	.word	->28,->18
	.long	TRSTUMBLE2	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	->26,->19
	.long	TRSTUMBLE2	; 6

	.long	ani_offset_xy
	.word	->42,->27
	.long	TRSTUMBLE2	; 7

	.long	ani_offset_xy
	.word	->4e,->2a	
	.long	TRSTUMBLE2	; 8

	.long	ani_offset_xy
	.word	->3f,->26
	.long	TRSTUMBLE2	; 7
	.long	0



TRFLIPPED1
	.long	TRFLIPPED1A,0
TRFLIPPED2
	.long	TRFLIPPED2A,TRFLIPPED2B,0
TRFLIPPED3
	.long	TRFLIPPED3A,TRFLIPPED3B,0
TRFLIPPED4
	.long	TRFLIPPED4A,0
TRFLIPPED5
	.long	TRFLIPPED5A,0


a_getup
	.long	TRGETUP1
	.long	TRGETUP2
	.long	TRGETUP3
	.long	TRGETUP4
	.long	TRGETUP5
	.long	TRGETUP6
	.long	TRGETUP7
	.long	0

TRGETUP1	.long	TRGETUP1A,0
TRGETUP2	.long	TRGETUP2A,0
TRGETUP3	.long	TRGETUP3A,0
TRGETUP4	.long	TRGETUP4A,0
TRGETUP5	.long	TRGETUP5A,TRGETUP5B,0
TRGETUP6	.long	TRGETUP6A,0
TRGETUP7	.long	TRGETUP7A,TRGETUP7B,0


a_zap	.long	TREYESHOOT1
	.long	TREYESHOOT2
	.long	TREYESHOOT3
	.long	TREYESHOOT4
	.long	0

	.long	ani_sladd,HIGHL5
	.long	TREYESHOOT5
	.long	ani_calla,slave_inviso
	.long	TREYESHOOT5
	.long	ani_calla,slave_viso
	.long	TREYESHOOT5
	.long	ani_calla,slave_inviso
	.long	TREYESHOOT5
	.long	ani_calla,slave_viso
	.long	TREYESHOOT5
	.long	ani_calla,slave_inviso
	.long	TREYESHOOT5
	.long	ani_calla,slave_viso
	.long	TREYESHOOT5
	.long	0

	.long	TREYESHOOT4
	.long	TREYESHOOT3
	.long	TREYESHOOT2
	.long	TREYESHOOT1
	.long	0


a_projectile
	.long	TORP1
	.long	TORP2
j_torp	.long	TORP3
	.long	TORP4
	.long	TORP5
	.long	TORP6
	.long	TORP7
	.long	TORP8
	.long	TORP9
	.long	TORP10
	.long	TORP11
	.long	TORP12
	.long	TORP13
	.long	TORP14
	.long	ani_jump,j_torp


TORP1	.long	TORPEDO1,0
TORP2	.long	TORPEDO2,0
TORP3	.long	TORPEDO3,0
TORP4	.long	TORPEDO4,0
TORP5	.long	TORPEDO5,0
TORP6	.long	TORPEDO6,0
TORP7	.long	TORPEDO7,0
TORP8	.long	TORPEDO8,0
TORP9	.long	TORPEDO9,0
TORP10	.long	TORPEDO10,0
TORP11	.long	TORPEDO11,0
TORP12	.long	TORPEDO12,0
TORP13	.long	TORPEDO13,0
TORP14	.long	TORPEDO14,0

HIGHL5	.long	HIGHLIGHT5,0


TREYESHOOT1
	.long	TREYESHOOT1A,TREYESHOOT1B,0
TREYESHOOT2
	.long	TREYESHOOT2A,TREYESHOOT2B,0
TREYESHOOT3
	.long	TREYESHOOT3A,TREYESHOOT3B,0
TREYESHOOT4
	.long	TREYESHOOT4A,TREYESHOOT4B,0
TREYESHOOT5
	.long	TREYESHOOT5A,TREYESHOOT5B,0

a_run
	.long	TRRUN1
	.long	TRRUN2
	.long	TRRUN3
	.long	TRRUN4
	.long	ani_calla,rsnd_footstep
	.long	TRRUN5
	.long	TRRUN6
	.long	TRRUN7
	.long	TRRUN8
	.long	TRRUN9
	.long	ani_calla,rsnd_footstep
	.long	TRRUN10
	.long	TRRUN11
	.long	TRRUN12

	.long	ani_jump,a_run
	.long	0			; we need this zero !!



TRRUN1
	.long	TRRUN1A,TRRUN1B,0
TRRUN2
	.long	TRRUN2A,TRRUN2B,0
TRRUN3
	.long	TRRUN3A,TRRUN3B,0
TRRUN4
	.long	TRRUN4A,0
TRRUN5
	.long	TRRUN5A,0
TRRUN6
	.long	TRRUN6A,0
TRRUN7
	.long	TRRUN7A,TRRUN7B,0
TRRUN8
	.long	TRRUN8A,TRRUN8B,0
TRRUN9
	.long	TRRUN9A,0
TRRUN10
	.long	TRRUN10A,0
TRRUN11
	.long	TRRUN11A,0
TRRUN12
	.long	TRRUN12A,0


a_victory
	.long	TRVICTORY1
	.long	TRVICTORY2

	.long	TRVICTORY3
	.long	TRVICTORY4
	.long	TRVICTORY5
	.long	TRVICTORY6
	.long	TRVICTORY7
	.long	TRVICTORY8
	.long	TRVICTORY9
	.long	TRVICTORY10
	.long	TRVICTORY11
	.long	TRVICTORY12
	.long	TRVICTORY13
	.long	TRVICTORY14
	.long	TRVICTORY15
	.long	TRVICTORY16
	.long	TRVICTORY17
	.long	TRVICTORY18
	.long	TRVICTORY19
	.long	TRVICTORY20
	.long	0

TRVICTORY1
	.long	TRVICTORY1A,TRVICTORY1B,0
TRVICTORY2
	.long	TRVICTORY2A,TRVICTORY2B,TRVICTORY2C,TRVICTORY2D,0
TRVICTORY3
	.long	TRVICTORYLEG1A,TRVICTORYLEG1B
	.long	TRVICTORY3A,TRVICTORY3B,TRVICTORY3C,0
TRVICTORY4
	.long	TRVICTORYLEG1A,TRVICTORYLEG1B
	.long	TRVICTORY4A,TRVICTORY4B,TRVICTORY4C,0
TRVICTORY5
	.long	TRVICTORYLEG1A,TRVICTORYLEG1B
	.long	TRVICTORY5A,TRVICTORY5B,TRVICTORY5C,0
TRVICTORY6
	.long	TRVICTORYLEG1A,TRVICTORYLEG1B
	.long	TRVICTORY6A,TRVICTORY6B,TRVICTORY6C,0
TRVICTORY7
	.long	TRVICTORYLEG1A,TRVICTORYLEG1B
	.long	TRVICTORY7A,TRVICTORY7B,0
TRVICTORY8
	.long	TRVICTORYLEG1A,TRVICTORYLEG1B
	.long	TRVICTORY8A,0
TRVICTORY9
	.long	TRVICTORY9A,TRVICTORY9B,0
TRVICTORY10
	.long	TRVICTORY10A,TRVICTORY10B,0
TRVICTORY11
	.long	TRVICTORY11A,TRVICTORY11B,0
TRVICTORY12
	.long	TRVICTORY12A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY13
	.long	TRVICTORY13A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY14
	.long	TRVICTORY14A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY15
	.long	TRVICTORY15A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY16
	.long	TRVICTORY16A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY17
	.long	TRVICTORY17A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY18
	.long	TRVICTORY18A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY19
	.long	TRVICTORY19A,TRVICTORY11A,TRVICTORY11B,0
TRVICTORY20
	.long	TRVICTORY20A,TRVICTORY11A,TRVICTORY11B,0

a_throw
	.long	TRFLIP1
	.long	TRFLIP2
	.long	0

	.long	TRFLIP3		; 1
	.long	TRFLIP4		; 2
	.long	ani_ochar_sound
	.word	3
	.long	TRFLIP5		; 3
	.long	TRFLIP6		; 4
	.long	TRFLIP7		; 5
	.long	TRFLIP8		; 6
	.long	TRFLIP2		; 7
	.long	TRFLIP3		; 8
	.long	ani_ochar_sound
	.word	4
	.long	TRFLIP9		; 9
	.long	TRFLIP10	; 10
	.long	TRFLIP11	; 11
	.long	TRFLIP12	; 12    2-gether
	.long	0

	.long	ani_flip
	.long	TRFLIP1
	.long	0


TRFLIP1	.long	TRFLIP1A,TRFLIP1B,0
TRFLIP2	.long	TRFLIP2A,TRFLIP2B,TRFLIP2C,0
TRFLIP3	.long	TRFLIP3A,TRFLIP3B,TRFLIP3C,0
TRFLIP4	.long	TRFLIP4A,TRFLIP4B,0
TRFLIP5	.long	TRFLIP5A,TRFLIP5B,0
TRFLIP6	.long	TRFLIP6A,TRFLIP6B,TRFLIP6C,0
TRFLIP7	.long	TRFLIP7A,TRFLIP7B,0
TRFLIP8	.long	TRFLIP8A,TRFLIP8B,0
TRFLIP9	.long	TRFLIP9A,TRFLIP9B,0
TRFLIP10	.long	TRFLIP10A,TRFLIP10B,TRFLIP10C,0
TRFLIP11	.long	TRFLIP11A,TRFLIP11B,TRFLIP11C,0
TRFLIP12	.long	TRFLIP12A,TRFLIP12B,TRFLIP12C,0


a_tusk_blur
	.long	TRRUN1
	.long	TRRUN2
	.long	TRRUN3
	.long	TRRUN4
	.long	TRRUN5

	.long	TRZOOM1
	.long	TRZOOM2
	.long	TRZOOM3
	.long	TRZOOM4
	.long	TRZOOM5
	.long	TRZOOM6
	.long	TRZOOM6
	.long	TRZOOM6
	.long	TRZOOM6
	.long	TRZOOM6
	.long	TRZOOM6
	.long	TRZOOM6
	.long	TRZOOM5
	.long	TRZOOM5
	.long	TRZOOM5
	.long	TRZOOM4
	.long	TRZOOM4
	.long	TRZOOM4
	.long	0

	.long	TRZOOM3
	.long	TRZOOM2
	.long	TRZOOM1
	.long	0

TRZOOM1	.long	TRZOOM1A,0
TRZOOM2	.long	TRZOOM2A,0
TRZOOM3	.long	TRZOOM3A,0
TRZOOM4	.long	TRZOOM4A,0
TRZOOM5	.long	TRZOOM5A,0
TRZOOM6	.long	TRZOOM6A,0

;*******************************************

a_scared
	.long	TRSCARED3
	.long	0

TRSCARED3
	.long	TRSCARED3A,0


a_thudd
	.long	TRTHUD1
	.long	TRTHUD2
	.long	TRTHUD3
	.long	TRTHUD4
	.long	TRTHUD5
	.long	TRTHUD6
	.long	TRTHUD7
	.long	0

TRTHUD1
	.long	TRTHUD1A,0
TRTHUD2
	.long	TRTHUD2A,0
TRTHUD3
	.long	TRTHUD3A,0
TRTHUD4
	.long	TRTHUD4A,0
TRTHUD5
	.long	TRTHUD5A,0
TRTHUD6
	.long	TRTHUD6A,0
TRTHUD7
	.long	TRTHUD7A,0

;*******************************************

a_glow
	.long	TRDUCK1
	.long	TRDUCK2
	.long	TRDUCK3
	.long	ani_sladd,GLOW1
	.long	ani_slani,GLOW2
	.long	TRUPPERCUT2
	.long	ani_slani,GLOW3
	.long	TRUPPERCUT3
	.long	ani_slani,GLOW4
	.long	TRUPPERCUT4
	.long	0

	.long	ani_slani,GLOW3
	.long	TRUPPERCUT3
	.long	ani_slani,GLOW2
	.long	TRUPPERCUT2
	.long	ani_calla,delete_slave
	.long	TRDUCK3
	.long	TRDUCK2
	.long	TRDUCK1
	.long	0


GLOW1	.long	GLOW1A,GLOW1B,GLOW1C,0
GLOW2	.long	GLOW2A,GLOW2B,GLOW2C,0
GLOW3	.long	GLOW3A,GLOW3B,GLOW3C,GLOW3D,0
GLOW4	.long	GLOW4A,GLOW4B,GLOW4C,0


a_floor_blade
	.long	KLOOP1
	.long	KLOOP2
	.long	KLOOP3
	.long	KLOOP4
	.long	KLOOP5
	.long	KLOOP6
	.long	ani_jump,a_floor_blade

KLOOP1	.long	KLOOP1A,KLOOP1B,KLOOP1C,KLOOP1D
	.long	KLOOP1E,0
KLOOP2	.long	KLOOP2A,KLOOP2B,KLOOP2C,KLOOP2D
	.long	KLOOP2E,0
KLOOP3	.long	KLOOP3A,KLOOP3B,KLOOP3C,KLOOP3D
	.long	KLOOP3E,0
KLOOP4	.long	KLOOP4A,KLOOP4B,KLOOP4C,KLOOP4D
	.long	KLOOP4E,KLOOP4F,0
KLOOP5	.long	KLOOP5A,KLOOP5B,KLOOP5C,KLOOP5D
	.long	KLOOP5E,KLOOP5F,0
KLOOP6	.long	KLOOP6A,KLOOP6B,KLOOP6C,KLOOP6D
	.long	KLOOP6E,0

;**********************************************

ochar_floaters
	.long	KNFLOAT
	.long	SBFLOAT
	.long	JXFLOAT
	.long	INFLOAT
	.long	SZFLOAT
	.long	OBFLOAT
	.long	LIFLOAT
	.long	RBFLOAT
	.long	RB2FLOAT
	.long	KLFLOAT
	.long	TRFLOAT
	.long	SHFLOAT
	.long	TSFLOAT
	.long	LUFLOAT
	.long	RB3FLOAT

KNFLOAT	.long	KNFLOATA,KNFLOATB,0
	.long	BHKANO1,BHKANO2,BHKANO3,BHKANO4,BHKANO5,0

SBFLOAT	.long	SBFLOATA,SBFLOATB,0
	.long	BHBLADE1,BHBLADE2,BHBLADE3,BHBLADE4,BHBLADE5,0

JXFLOAT	.long	JXFLOATA,JXFLOATB,0
	.long	BHJAX1,BHJAX2,BHJAX3,BHJAX4,BHJAX5,0

INFLOAT	.long	INFLOATA,INFLOATB,0
	.long	BHIND1,BHIND2,BHIND3,BHIND4,BHIND5,0

SZFLOAT	.long	SZFLOATA,SZFLOATB,0
	.long	BHSZERO1,BHSZERO2,BHSZERO3,BHSZERO4,BHSZERO5,0

OBFLOAT	.long	OBFLOATA,OBFLOATB,0
	.long	BHSWAT1,BHSWAT2,BHSWAT3,BHSWAT4,BHSWAT5,0

LIFLOAT	.long	LIFLOATA,LIFLOATB,0
	.long	BHLIA1,BHLIA2,BHLIA3,BHLIA4,BHLIA5,0

RBFLOAT	.long	RBFLOATA,RBFLOATB,0
	.long	BHROBO1,BHROBO2,BHROBO3,BHROBO4,BHROBO5,0

RB2FLOAT	.long	RBFLOATA,RBFLOATB,0
	.long	BHROBO21,BHROBO2,BHROBO3,BHROBO4,BHROBO5,0

RB3FLOAT	.long	RBFLOATA,RBFLOATB,0
	.long	BHROBO31,BHROBO2,BHROBO3,BHROBO4,BHROBO5,0

KLFLOAT	.long	KLFLOATA,KLFLOATB,0
	.long	BHLAO1,BHLAO2,BHLAO3,BHLAO4,BHLAO5,0

TRFLOAT	.long	TRFLOATA,TRFLOATB,0
	.long	BHTUSK1,BHTUSK2,BHTUSK3,BHTUSK4,BHTUSK5,0

SHFLOAT	.long	SHFLOATA,SHFLOATB,0
	.long	BHSHGOR1,BHSHGOR2,BHSHGOR3,BHSHGOR4,BHSHGOR5,0

TSFLOAT	.long	TSFLOATA,TSFLOATB,0
	.long	BHTSANG1,BHTSANG2,BHTSANG3,BHTSANG4,BHTSANG5,0

LUFLOAT	.long	LUFLOATA,LUFLOATB,0
	.long	BHLIU1,BHLIU2,BHLIU3,BHLIU4,BHLIU5,0


BHROBO21	.word   21,26,2,-9
	.long   082fc905H
	.word   06080H
	.long   BHYLROB_P

BHROBO31	.word   21,26,2,-9
	.long   082fc905H
	.word   06080H
	.long   BHSMROB_P

BHSMROB_P:
   .word   64 
   .word   00000h,00001h,00002h,00004h,00005h,0084ah,018ceh,02531h
   .word   01cefh,014adh,00007h,00006h,00847h,00425h,00003h,00429h
   .word   00c6bh,018ceh,035b5h,00428h,00c67h,0108ch,02d73h,03df7h
   .word   039d6h,00848h,03194h,014a9h,0210ch,03190h,0252dh,0108ch
   .word   035b1h,03df3h,02110h,02952h,04639h,04e7bh,04a56h,04e77h
   .word   05adah,05addh,0108dh,0631eh,00848h,056bch,00c6ah,014aah
   .word   00c6bh,02950h,02110h,02d72h,0631ch,035b3h,06b5eh,04636h
   .word   0673dh,056b9h,0739fh,06f7fh,018cdh,06f7fh,02951h,05efbh

BHYLROB_P:
   .word   64 
   .word   00000h,00400h,00c20h,01440h,01ca0h,03d40h,04de2h,05a45h
   .word   05203h,049c1h,028c0h,024c0h,01ca4h,01084h,00842h,03520h
   .word   04180h,04de3h,06eaah,03100h,018c6h,045a0h,06688h,0770ch
   .word   072ebh,024c2h,06aa9h,02108h,02d6bh,03defh,0318ch,045a1h
   .word   04210h,04a52h,05624h,05e66h,07f6eh,07f90h,056b5h,05ad6h
   .word   06739h,07f95h,049c0h,07fb8h,02d01h,07f73h,03521h,02d26h
   .word   03d61h,04e09h,04e06h,0522bh,06f7bh,0566dh,077bdh,05a92h
   .word   06f9ch,06317h,07fffh,07bddh,045a3h,07bbeh,05628h,06b59h

;******************************************************************

a_tube
	.long	TRTUBE1
	.long	TRTUBE2
	.long	TRTUBE3
	.long	TRTUBE4
	.long	TRTUBE5
	.long	TRTUBE6
	.long	0

	.long	TRTUBE7
	.long	TRTUBE8
	.long	TRTUBE9
	.long	TRTUBE10
	.long	TRTUBE11
	.long	TRTUBE12
	.long	TRTUBE13	; pump
	.long	0

	.long	TRTUBE14
	.long	TRTUBE15
	.long	0

TRTUBE1
	.long	TRTUBE1A,TRTUBE1B,0
TRTUBE2
	.long	TRTUBE2A,TRTUBE2B,0
TRTUBE3
	.long	TRTUBE3A,TRTUBE3B,0
TRTUBE4
	.long	TRTUBE4A,TRTUBE2A,TRTUBE2B,0
TRTUBE5
	.long	TRTUBE5A,TRTUBE2A,TRTUBE2B,0
TRTUBE6
	.long	TRTUBE6A,TRTUBE2A,TRTUBE2B,0
TRTUBE7
	.long	TRTUBE7A,TRTUBE2A,TRTUBE2B,0
TRTUBE8
	.long	TRTUBE8A,TRTUBE2A,TRTUBE2B,0
TRTUBE9
	.long	TRTUBE9A,TRTUBE2A,TRTUBE2B,0
TRTUBE10
	.long	TRTUBE10A,TRTUBE2A,TRTUBE2B,0
TRTUBE11
	.long	TRTUBE11A,TRTUBE2A,TRTUBE2B,0
TRTUBE12
	.long	TRTUBE12A,TRTUBE2A,TRTUBE2B,0
TRTUBE13
	.long	TRTUBE13A,TRTUBE2A,TRTUBE2B,0
TRTUBE14
	.long	TRTUBE14A,TRTUBE2A,TRTUBE2B,0
TRTUBE15
	.long	TRTUBE15A,TRTUBE15B,0

;*******************

a_sho_yo_ugly_face
	.long	TRUGLY1
	.long	TRUGLY2
	.long	TRUGLY3
	.long	TRUGLY4
	.long	0

	.long	TRUGLY5
	.long	TRUGLY6
	.long	TRUGLY7
	.long	TRUGLY8
	.long	TRUGLY9
	.long	TRUGLY10

;	.long	0

	.long	TRUGLY9
	.long	TRUGLY8
	.long	TRUGLY7
	.long	0


TRUGLY1
	.long	TRUGLY1A,TRUGLYLEG1A,TRUGLYLEG1B,0
TRUGLY2
	.long	TRUGLY2A,TRUGLYLEG1A,TRUGLYLEG1B,0
TRUGLY3
	.long	TRUGLY3A,TRUGLYLEG1A,TRUGLYLEG1B,0
TRUGLY4
	.long	TRUGLY4A,TRUGLYLEG1A,TRUGLYLEG1B,0
TRUGLY5
	.long	TRUGLY5A,TRUGLY5B,UGLYHEAD1,0
TRUGLY6
	.long	TRUGLY6A,TRUGLY6B,UGLYHEAD1,0
TRUGLY7
	.long	TRUGLY7A,TRUGLY7B,UGLYHEAD1,0
TRUGLY8
	.long	TRUGLY8A,TRUGLY8B,0
TRUGLY9
	.long	TRUGLY9A,TRUGLY9B,0
TRUGLY10
	.long	TRUGLY10A,TRUGLY10B,0


a_ugly_head
	.long	UGLYHEAD1
	.long	UGLYHEAD2
	.long	UGLYHEAD3
	.long	UGLYHEAD4
	.long	UGLYHEAD5

	.long	UGLYHEAD6
	.long	UGLYHEAD7
	.long	UGLYHEAD8
	.long	UGLYHEAD9
	.long	UGLYHEAD10

	.long	UGLYHEAD6
	.long	UGLYHEAD7
	.long	UGLYHEAD8
	.long	UGLYHEAD9
	.long	UGLYHEAD10

	.long	UGLYHEAD11
	.long	UGLYHEAD12
	.long	0

	.long	UGLYHEAD13
	.long	UGLYHEAD14
	.long	0

	.long	UGLYHEAD15
	.long	UGLYHEAD16
	.long	UGLYHEAD17

	.long	UGLYHEAD18
	.long	UGLYHEAD19
	.long	UGLYHEAD20
	.long	UGLYHEAD21
	.long	UGLYHEAD20
	.long	UGLYHEAD19
	.long	UGLYHEAD18

	.long	UGLYHEAD19
	.long	UGLYHEAD20
	.long	UGLYHEAD21
	.long	UGLYHEAD20
	.long	UGLYHEAD19
	.long	UGLYHEAD18

	.long	UGLYHEAD19
	.long	UGLYHEAD20
	.long	UGLYHEAD21
	.long	UGLYHEAD20
	.long	UGLYHEAD19
	.long	UGLYHEAD18

	.long	UGLYHEAD19
	.long	UGLYHEAD20
	.long	UGLYHEAD21
	.long	UGLYHEAD22
	.long	0

	.long	UGLYHEAD17
	.long	UGLYHEAD16
	.long	UGLYHEAD15
	.long	0

;*******************

	.end

