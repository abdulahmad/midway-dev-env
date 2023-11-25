**************************************************************************
*											     *
*  mk3 - Lia											*
*											     *
**************************************************************************
	.FILE	"mklia.asm"
	.WIDTH	132
	.OPTION	B,D,L,T
	.MNOLIST

	.include mainequ.asm
	.include imgtbl.glo
	.include mklia.tbl
	.include mklia2.tbl
	.include mklia3.tbl
	.include mklia4.tbl
	.include mkliatmp.tbl
	.text

lia_anitab1
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


lia_anitab2
	.long	a_lia_scream	; 0 - scream
	.long	a_shock_wave	; 1 - shock wave images
	.long	a_fly_up	; 2 - fly straight up 0
	.long	a_fly_forward  	; 3 - fly forward	  1
	.long	a_fly_backward	; 4 - fly backwards	  2
	.long	a_unforward	; 5 - transition to normal float 3
	.long	a_unbackoff	; 6 -
	.long	a_angle_zap		; 7 - fireball
	.long	a_top	       		; 8
	.long	ochar_ripped_anis	; 9
	.long	a_hair_wrap		; a


a_dummy		
a_stance
	.long	LIASTANCE1
	.long	LIASTANCE2
	.long	LIASTANCE3
	.long	LIASTANCE4
	.long	LIASTANCE5
	.long	LIASTANCE6
	.long	LIASTANCE7
	.long	LIASTANCE8
	.long	LIASTANCE9
	.long	ani_jump,a_stance

LIASTANCE1
	.long	LIASTANCE1A,LIASTANCE1B,0
LIASTANCE2
	.long	LIASTANCE2A,LIASTANCE2B,0
LIASTANCE3
	.long	LIASTANCE3A,LIASTANCE3B,0
LIASTANCE4
	.long	LIASTANCE4A,LIASTANCE4B,0
LIASTANCE5
	.long	LIASTANCE5A,LIASTANCE5B,0
LIASTANCE6
	.long	LIASTANCE6A,LIASTANCE6B,0
LIASTANCE7
	.long	LIASTANCE7A,LIASTANCE7B,0
LIASTANCE8
	.long	LIASTANCE8A,LIASTANCE8B,0
LIASTANCE9
	.long	LIASTANCE9A,LIASTANCE9B,0

;***************************************************************************

a_turn
	.long	LITURN1
	.long	LITURN2
	.long	ani_flip
	.long	LITURN1
	.long	0

LITURN1	.long	LITURN1A,LITURN1B,0
LITURN2	.long	LITURN2A,LITURN2B,0

;***************************************************************************

a_walkf
	.long	LIWALK1
	.long	LIWALK2
	.long	LIWALK3
	.long	LIWALK4
	.long	LIWALK5
	.long	LIWALK6
	.long	LIWALK7
	.long	LIWALK8
	.long	LIWALK9
	.long	ani_jump,a_walkf

a_walkb
	.long	LIWALK9
	.long	LIWALK8
	.long	LIWALK7
	.long	LIWALK6
	.long	LIWALK5
	.long	LIWALK4
	.long	LIWALK3
	.long	LIWALK2
	.long	LIWALK1
	.long	ani_jump,a_walkb

LIWALK1	.long	LIWALKLEG1A,LIWALKLEG1B,LIWALKTORSO1,0
LIWALK2	.long	LIWALKLEG2A,LIWALKLEG2B,LIWALKTORSO2,0
LIWALK3	.long	LIWALKLEG3A,LIWALKTORSO3,0
LIWALK4	.long	LIWALKLEG4A,LIWALKLEG4B,LIWALKTORSO4,0
LIWALK5	.long	LIWALKLEG5A,LIWALKLEG5B,LIWALKTORSO5,0
LIWALK6	.long	LIWALKLEG6A,LIWALKLEG6B,LIWALKTORSO6,0
LIWALK7	.long	LIWALKLEG7A,LIWALKTORSO7,0
LIWALK8	.long	LIWALKLEG8A,LIWALKLEG8B,LIWALKTORSO8,0
LIWALK9	.long	LIWALKLEG9A,LIWALKLEG9B,LIWALKTORSO9,0

;***************************************************************************

a_duck
	.long	LIDUCK1
	.long	LIDUCK2
	.long	LIDUCK3
	.long	0

LIDUCK1	.long	LIDUCK1A,LIDUCK1B,0
LIDUCK2	.long	LIDUCK2A,LIDUCK2B,0
LIDUCK3	.long	LIDUCK3A,LIDUCK3B,0

;***************************************************************************

a_duck_turn
	.long	LIDUCKTURN1
	.long	LIDUCKTURN2
	.long	ani_flip
	.long	LIDUCKTURN1
	.long	LIDUCK3
	.long	0

LIDUCKTURN1
	.long	LIDUCKTURN1A,LIDUCKTURN1B,0
LIDUCKTURN2
	.long	LIDUCKTURN2A,LIDUCKTURN2B,0

;***************************************************************************

a_duck_block
	.long	LIDUCKBLOCK1
	.long	LIDUCKBLOCK2
	.long	LIDUCKBLOCK3
	.long	0

LIDUCKBLOCK1
	.long	LIDUCKBLOCK1A,LIDUCKBLOCK1B,0
LIDUCKBLOCK2
	.long	LIDUCKBLOCK2A,LIDUCKBLOCK2B,0
LIDUCKBLOCK3
	.long	LIDUCKBLOCK3A,LIDUCKBLOCK3B,0

;***************************************************************************

a_duck_punch
	.long	LIDUCKPUNCH1
	.long	LIDUCKPUNCH2
	.long	LIDUCKPUNCH3
	.long	0
	.long	LIDUCKPUNCH2
	.long	LIDUCKPUNCH1
	.long	LIDUCK3
	.long	0

LIDUCKPUNCH1
	.long	LIDUCKPUNCH1A,LIDUCKPUNCH1B,0
LIDUCKPUNCH2
	.long	LIDUCKPUNCH2A,LIDUCKPUNCH2B,0
LIDUCKPUNCH3
	.long	LIDUCKPUNCH3A,LIDUCKPUNCH3B,0

;***************************************************************************

a_duck_kick_lo
	.long	LIDUCKHIKICK1
	.long	LIDUCKHIKICK2
	.long	LIDUCKLOKICK1
	.long	LIDUCKLOKICK2
	.long	0
	.long	LIDUCKLOKICK1
	.long	LIDUCKHIKICK2
	.long	LIDUCKHIKICK1
	.long	LIDUCK3
	.long	0

LIDUCKLOKICK1
	.long	LIDUCKLOKICK1A,LIDUCKLOKICK1B,0
LIDUCKLOKICK2
	.long	LIDUCKLOKICK2A,LIDUCKLOKICK2B,0

;***************************************************************************

a_duck_kick_hi
	.long	LIDUCKHIKICK1
	.long	LIDUCKHIKICK2
	.long	LIDUCKHIKICK3
	.long	LIDUCKHIKICK4
	.long	0
	.long	LIDUCKHIKICK3
	.long	LIDUCKHIKICK2
	.long	LIDUCKHIKICK1
	.long	LIDUCK3
	.long	0

LIDUCKHIKICK1
	.long	LIDUCKHIKICK1A,LIDUCKHIKICK1B,0
LIDUCKHIKICK2
	.long	LIDUCKHIKICK2A,LIDUCKHIKICK2B,0
LIDUCKHIKICK3
	.long	LIDUCKHIKICK3A,LIDUCKHIKICK3B,0
LIDUCKHIKICK4
	.long	LIDUCKHIKICK4A,0

;***************************************************************************

a_uppercut
	.long	LIUPPERCUT2
	.long	LIUPPERCUT3
	.long	LIUPPERCUT4
	.long	LIUPPERCUT5
	.long	ani_nosleep	; dont sleep after next frame
	.long	LIUPPERCUT6
	.long	0
	.long	LIUPPERCUT5
	.long	0

LIUPPERCUT2
	.long	LIUPPERCUT2A,0
LIUPPERCUT3
	.long	LIUPPERCUT3A,LIUPPERCUT3B,0
LIUPPERCUT4
	.long	LIUPPERCUT4A,LIUPPERCUT4B,0
LIUPPERCUT5
	.long	LIUPPERCUT5A,LIUPPERCUT5B,0
LIUPPERCUT6
	.long	LIUPPERCUT6A,LIUPPERCUT6B,0

;***************************************************************************

a_duck_hit
	.long	LIDUCKHIT2
	.long	LIDUCKHIT3
	.long	LIDUCKHIT2
	.long	LIDUCKHIT1
	.long	0

LIDUCKHIT1
	.long	LIDUCKHIT1A,LIDUCKHIT1B,0
LIDUCKHIT2
	.long	LIDUCKHIT2A,LIDUCKHIT2B,0
LIDUCKHIT3
	.long	LIDUCKHIT3A,LIDUCKHIT3B,0

;***************************************************************************

a_hipunch
	.long	LIHIPUNCH1
	.long	LIHIPUNCH2
	.long	LIHIPUNCH3
	.long	0

	.long	LIHIPUNCH4
	.long	LIHIPUNCH5
	.long	LIHIPUNCH6
	.long	0

	.long	LIHIPUNCH5
	.long	LIHIPUNCH4
	.long	ani_jump,a_hipunch+(32*2)
	.long	0					; we NEED this "0"
*
* Unhipunch #1
*
	.long	LIHIPUNCH2
	.long	LIHIPUNCH1
	.long	0
*
* Unhipunch #2
*
	.long	LIHIPUNCH7
	.long	0
*
* Hi to Med #1
*
	.long	LIHIPUNCH4
	.long	LILOPUNCH5
	.long	ani_jump,a_lopunch+(32*6)
	.long	0
*
* Hi to Med #2
*
	.long	LIHIPUNCH5
	.long	LILOPUNCH2
	.long	ani_jump,a_lopunch+(32*2)
	.long	0


a_lopunch
	.long	LIHIPUNCH1
	.long	LILOPUNCH1
	.long	LILOPUNCH2
	.long	0

	.long	LILOPUNCH3
	.long	LILOPUNCH4
	.long	LILOPUNCH5
	.long	0

	.long	LILOPUNCH4
	.long	LILOPUNCH3
	.long	ani_jump,a_lopunch+(32*2)
	.long	0
*
* Unlopunch #1
*
	.long	LILOPUNCH1
	.long	LIHIPUNCH1
	.long	0
*
* Unlopunch #2
*
	.long	LILOPUNCH4
	.long	0
*
* Med to High #1
*
	.long	LILOPUNCH1
	.long	LIHIPUNCH5
	.long	ani_jump,a_hipunch+(32*6)
	.long	0
*
* Med to High #2
*
	.long	LILOPUNCH4
	.long	LIHIPUNCH5
	.long	ani_jump,a_hipunch+(32*2)


LIHIPUNCH1
	.long	LIHIPUNCH1A,LIHIPUNCH1B,0
LIHIPUNCH2
	.long	LIHIPUNCH2A,LIHIPUNCH2B,0
LIHIPUNCH3
	.long	LIHIPUNCH3A,LIHIPUNCH3B,0
LIHIPUNCH4
	.long	LIHIPUNCH4A,LIHIPUNCH4B,0
LIHIPUNCH5
	.long	LIHIPUNCH5A,LIHIPUNCH5B,0
LIHIPUNCH6
	.long	LIHIPUNCH6A,LIHIPUNCH6B,0
LIHIPUNCH7
	.long	LIHIPUNCH7A,LIHIPUNCH7B,0

LILOPUNCH1
	.long	LILOPUNCH1A,LILOPUNCH1B,0
LILOPUNCH2
	.long	LILOPUNCH2A,LILOPUNCH2B,0
LILOPUNCH3
	.long	LILOPUNCH3A,LILOPUNCH3B,0
LILOPUNCH4
	.long	LILOPUNCH4A,LILOPUNCH4B,0
LILOPUNCH5
	.long	LILOPUNCH5A,LILOPUNCH5B,0

;***************************************************************************

a_elbow
	.long	LICOMBO1
	.long	LICOMBO2
	.long	LICOMBO3
	.long	ani_nosleep
	.long	LICOMBO4
	.long	0
	.long	LICOMBO2
	.long	LICOMBO1
	.long	0

	.long	LICOMBO5
	.long	ani_adjustx
	.word	010H
	.long	LICOMBO6
	.long	ani_adjustx
	.word	010H
	.long	LICOMBO7
	.long	LICOMBO8	; part 3 - elbow hit #2
	.long	0

	.long	LICOMBO9
	.long	ani_adjustx
	.word	5
	.long	LICOMBO10
	.long	ani_adjustx
	.word	5
	.long	LICOMBO11
	.long	ani_adjustx
	.word	5
	.long	LICOMBO12
	.long	ani_adjustx
	.word	5
	.long	LICOMBO13
	.long	ani_adjustx
	.word	5
	.long	LICOMBO14
	.long	ani_adjustx
	.word	5
	.long	LICOMBO15	; part 4 - elbow hit #3
	.long	0

	.long	LICOMBO16
	.long	0

LICOMBO1
	.long	LICOMBO1A,LICOMBO1B,0
LICOMBO2
	.long	LICOMBO2A,LICOMBO2B,0
LICOMBO3
	.long	LICOMBO3A,LICOMBO3B,0
LICOMBO4
	.long	LICOMBO4A,LICOMBO4B,0
LICOMBO5
	.long	LICOMBO5A,LICOMBO5B,0
LICOMBO6
	.long	LICOMBO6A,LICOMBO6B,0
LICOMBO7
	.long	LICOMBO7A,LICOMBO7B,0
LICOMBO8
	.long	LICOMBO8A,LICOMBO8B,0
LICOMBO9
	.long	LICOMBO9A,LICOMBO9B,0
LICOMBO10
	.long	LICOMBO10A,LICOMBO10B,0
LICOMBO11
	.long	LICOMBO11A,LICOMBO11B,0
LICOMBO12
	.long	LICOMBO12A,LICOMBO12B,0
LICOMBO13
	.long	LICOMBO13A,LICOMBO13B,0
LICOMBO14
	.long	LICOMBO14A,LICOMBO14B,0
LICOMBO15
	.long	LICOMBO15A,LICOMBO15B,0
LICOMBO16
	.long	LICOMBO16A,LICOMBO16B,0

;***************************************************************************

a_block
	.long	LIHIBLOCK1
	.long	LIHIBLOCK2
	.long	LIHIBLOCK3
	.long	0

LIHIBLOCK1
	.long	LIHIBLOCK1A,LIHIBLOCK1B,0
LIHIBLOCK2
	.long	LIHIBLOCK2A,LIHIBLOCK2B,0
LIHIBLOCK3
	.long	LIHIBLOCK3A,LIHIBLOCK3B,0

; ejbpatch
;LILOBLOCK1
;	.long	LILOBLOCK1A,LILOBLOCK1B,0
;LILOBLOCK2
;	.long	LILOBLOCK2A,LILOBLOCK2B,0

;***************************************************************************

a_lokick 
	.long	LILOKICK1
	.long	LILOKICK2
	.long	LILOKICK3
	.long	LILOKICK4
	.long	LILOKICK5
	.long	LILOKICK6
	.long	0
	.long	LILOKICK5
	.long	LILOKICK4
	.long	LILOKICK3
	.long	LILOKICK2
	.long	LILOKICK1
	.long	0

LILOKICK1
	.long	LILOKICK1A,LILOKICK1B,0
LILOKICK2
	.long	LILOKICK2A,LILOKICK2B,0
LILOKICK3
	.long	LILOKICK3A,LILOKICK3B,0
LILOKICK4
	.long	LILOKICK4A,LILOKICK4B,0
LILOKICK5
	.long	LILOKICK5A,0
LILOKICK6
	.long	LILOKICK6A,LILOKICK6B,0

;***************************************************************************

a_hikick
	.long	LILOKICK1
	.long	LILOKICK2
	.long	LILOKICK3
	.long	LIHIKICK1
	.long	LIHIKICK2
	.long	LIHIKICK3
	.long	0
	.long	LIHIKICK2
	.long	LIHIKICK1
	.long	LILOKICK3
	.long	LILOKICK2
	.long	LILOKICK1
	.long	0

LIHIKICK1
	.long	LIHIKICK1A,LIHIKICK1B,0
LIHIKICK2
	.long	LIHIKICK2A,0
LIHIKICK3
	.long	LIHIKICK3A,LIHIKICK3B,LIHIKICK3C,0

;***************************************************************************

a_knee
	.long	LIKNEECOMBO1
	.long	LIKNEECOMBO2
	.long	LIKNEECOMBO3
	.long	0
	.long	LIKNEECOMBO2
	.long	LIKNEECOMBO1
	.long	0

	.long	LIKNEECOMBO4
	.long	LIKNEECOMBO5
	.long	LIKNEECOMBO6
	.long	LIKNEECOMBO7

LIKNEECOMBO1
	.long	LIKNEECOMBO1A,LIKNEECOMBO1B,0
LIKNEECOMBO2
	.long	LIKNEECOMBO2A,0
LIKNEECOMBO3
	.long	LIKNEECOMBO3A,LIKNEECOMBO3B,0
LIKNEECOMBO4
	.long	LIKNEECOMBO4A,LIKNEECOMBO4B,0
LIKNEECOMBO5
	.long	LIKNEECOMBO5A,LIKNEECOMBO5B,0
LIKNEECOMBO6
	.long	LIKNEECOMBO6A,0
LIKNEECOMBO7
	.long	LIKNEECOMBO7A,LIKNEECOMBO7B,0

;***************************************************************************

a_roundhouse
	.long	LISPINKICK1
	.long	LISPINKICK2
	.long	LISPINKICK3
	.long	LISPINKICK4
	.long	LISPINKICK5
	.long	0
	.long	LISPINKICK6
	.long	LISPINKICK7
	.long	LISPINKICK8
	.long	0

LISPINKICK1
	.long	LISPINKICK1A,LISPINKICK1B,0
LISPINKICK2
	.long	LISPINKICK2A,LISPINKICK2B,0
LISPINKICK3
	.long	LISPINKICK3A,0
LISPINKICK4
	.long	LISPINKICK4A,LISPINKICK4B,0
LISPINKICK5
	.long	LISPINKICK5A,LISPINKICK5B,0
LISPINKICK6
	.long	LISPINKICK6A,0
LISPINKICK7
	.long	LISPINKICK7A,LISPINKICK7B,0
LISPINKICK8
	.long	LISPINKICK8A,LISPINKICK8B,0
;***************************************************************************

a_sweep_kick
	.long	LISWEEPKICK1
	.long	LISWEEPKICK2
	.long	LISWEEPKICK3
	.long	ani_calla,sweep_sounds
	.long	LISWEEPKICK4
	.long	LISWEEPKICK5
	.long	0
	.long	LISWEEPKICK6
	.long	LISWEEPKICK7
	.long	LISWEEPKICK8
	.long	0

LISWEEPKICK1
	.long	LISWEEPKICK1A,LISWEEPKICK1B,0
LISWEEPKICK2
	.long	LISWEEPKICK2A,LISWEEPKICK2B,0
LISWEEPKICK3
	.long	LISWEEPKICK3A,LISWEEPKICK3B,0
LISWEEPKICK4
	.long	LISWEEPKICK4A,LISWEEPKICK4B,0
LISWEEPKICK5
	.long	LISWEEPKICK5A,LISWEEPKICK5B,0
LISWEEPKICK6
	.long	LISWEEPKICK6A,LISWEEPKICK6B,0
LISWEEPKICK7
	.long	LISWEEPKICK7A,0
LISWEEPKICK8
	.long	LISWEEPKICK8A,LISWEEPKICK8B,0

;***************************************************************************

a_jump
	.long	LIJUMP1
	.long	LIJUMP2
	.long	LIJUMP3
	.long	0
	.long	LIJUMP2
	.long	LIJUMP1
	.long	0

LIJUMP1	.long	LIJUMP1A,LIJUMP1B,0
LIJUMP2	.long	LIJUMP2A,LIJUMP2B,0
LIJUMP3	.long	LIJUMP3A,LIJUMP3B,0

;***************************************************************************

a_jump_kick
	.long	LIJUMPKICK1
	.long	LIJUMPKICK2
	.long	LIJUMPKICK3
	.long	0
	.long	LIJUMPKICK2
	.long	LIJUMPKICK1
	.long	0

LIJUMPKICK1
	.long	LIJUMPKICK1A,0
LIJUMPKICK2
	.long	LIJUMPKICK2A,LIJUMPKICK2B,0
LIJUMPKICK3
	.long	LIJUMPKICK3A,LIJUMPKICK3B,0

;***************************************************************************
a_fflip
	.long	LIJUMPFLIP1
	.long	LIJUMPFLIP2
	.long	LIJUMPFLIP3
	.long	LIJUMPFLIP4
	.long	LIJUMPFLIP5
	.long	LIJUMPFLIP6
	.long	LIJUMPFLIP7
	.long	LIJUMPFLIP8
	.long	ani_jump,a_fflip+32

a_bflip
	.long	LIJUMPFLIP1
	.long	LIJUMPFLIP8
	.long	LIJUMPFLIP7
	.long	LIJUMPFLIP6
	.long	LIJUMPFLIP5
	.long	LIJUMPFLIP4
	.long	LIJUMPFLIP3
	.long	LIJUMPFLIP2
	.long	ani_jump,a_bflip+32

LIJUMPFLIP1
	.long	LIJUMPFLIP1A,0
LIJUMPFLIP2
	.long	LIJUMPFLIP2A,0
LIJUMPFLIP3
	.long	LIJUMPFLIP3A,0
LIJUMPFLIP4
	.long	LIJUMPFLIP4A,0
LIJUMPFLIP5
	.long	LIJUMPFLIP5A,0
LIJUMPFLIP6
	.long	LIJUMPFLIP6A,0
LIJUMPFLIP7
	.long	LIJUMPFLIP7A,0
LIJUMPFLIP8
	.long	LIJUMPFLIP8A,0
;***************************************************************************

a_flip_kick
	.long	LIFLIPKICK1
	.long	LIFLIPKICK2
	.long	LIFLIPKICK3
	.long	0
	.long	LIFLIPKICK2
	.long	LIFLIPKICK1
	.long	0

LIFLIPKICK1
	.long	LIFLIPKICK1A,0
LIFLIPKICK2
	.long	LIFLIPKICK2A,0
LIFLIPKICK3
	.long	LIFLIPKICK3A,LIFLIPKICK3B,0

;***************************************************************************

a_flip_punch
	.long	LIFLIPUNCH1
	.long	LIFLIPUNCH2
	.long	LIFLIPUNCH3
	.long	0
	.long	LIFLIPUNCH2
	.long	LIFLIPUNCH1
	.long	0

LIFLIPUNCH1
	.long	LIFLIPUNCH1A,LIFLIPUNCH1B,0
LIFLIPUNCH2
	.long	LIFLIPUNCH2A,LIFLIPUNCH2B,0
LIFLIPUNCH3
	.long	LIFLIPUNCH3A,LIFLIPUNCH3B,0

;***************************************************************************

a_hit_hi
	.long	LIHIHIT2
	.long	LIHIHIT3
	.long	LIHIHIT2
	.long	LIHIHIT1
	.long	0

LIHIHIT1	.long	LIHIHIT1A,LIHIHIT1B,0
LIHIHIT2	.long	LIHIHIT2A,LIHIHIT2B,0
LIHIHIT3	.long	LIHIHIT3A,LIHIHIT3B,0

;***************************************************************************

a_hit_lo
	.long	LILOHIT2
	.long	LILOHIT3
	.long	LILOHIT2
	.long	LILOHIT1
	.long	0

LILOHIT1	.long	LILOHIT1A,LILOHIT1B,0
LILOHIT2	.long	LILOHIT2A,LILOHIT2B,0
LILOHIT3	.long	LILOHIT3A,LILOHIT3B,0

;***************************************************************************

a_stumble
	.long	LISTUMBLE1
	.long	LISTUMBLE2
	.long	LISTUMBLE3
	.long	LISTUMBLE4
	.long	LISTUMBLE5
	.long	LISTUMBLE6
	.long	LISTUMBLE7
	.long	0

j_stumble
	.long	LISTUMBLE1
	.long	LISTUMBLE2
	.long	LISTUMBLE3
	.long	LISTUMBLE4
	.long	LISTUMBLE5
	.long	LISTUMBLE6
	.long	LISTUMBLE7
	.long	ani_jump,j_stumble

LISTUMBLE1
	.long	LISTUMBLE1A,LISTUMBLE1B,0
LISTUMBLE2
	.long	LISTUMBLE2A,LISTUMBLE2B,0
LISTUMBLE3
	.long	LISTUMBLE3A,0
LISTUMBLE4
	.long	LISTUMBLE4A,LISTUMBLE4B,0
LISTUMBLE5
	.long	LISTUMBLE5A,LISTUMBLE5B,0
LISTUMBLE6
	.long	LISTUMBLE6A,LISTUMBLE6B,0
LISTUMBLE7
	.long	LISTUMBLE7A,LISTUMBLE7B,0

;***************************************************************************

a_dizzy
	.long	LISTUNNED1
	.long	LISTUNNED2
	.long	LISTUNNED3
	.long	LISTUNNED4
	.long	LISTUNNED5
	.long	LISTUNNED6
	.long	LISTUNNED7
	.long	LISTUNNED8
	.long	LISTUNNED9
	.long	ani_jump,a_dizzy

LISTUNNED1
	.long	LISTUNNED1A,LISTUNNED1B,0
LISTUNNED2
	.long	LISTUNNED2A,LISTUNNED2B,0
LISTUNNED3
	.long	LISTUNNED3A,LISTUNNED3B,0
LISTUNNED4
	.long	LISTUNNED4A,LISTUNNED4B,0
LISTUNNED5
	.long	LISTUNNED5A,LISTUNNED5B,0
LISTUNNED6
	.long	LISTUNNED6A,LISTUNNED6B,0
LISTUNNED7
	.long	LISTUNNED7A,LISTUNNED7B,0
LISTUNNED8
	.long	LISTUNNED8A,LISTUNNED8B,0
LISTUNNED9
	.long	LISTUNNED9A,LISTUNNED9B,0
;***************************************************************************

a_knockdown
	.long	LIKNOCKDOWN1
	.long	LIKNOCKDOWN2
	.long	LIKNOCKDOWN3
	.long	LIKNOCKDOWN4
	.long	0
	.long	LIKNOCKDOWN5
	.long	LIKNOCKDOWN6
	.long	0

LIKNOCKDOWN1
	.long	LIKNOCKDOWN1A,0
LIKNOCKDOWN2
	.long	LIKNOCKDOWN2A,0
LIKNOCKDOWN3
	.long	LIKNOCKDOWN3A,0
LIKNOCKDOWN4
	.long	LIKNOCKDOWN4A,LIKNOCKDOWN4B,0
LIKNOCKDOWN5
	.long	LIKNOCKDOWN5A,0
LIKNOCKDOWN6
	.long	LIKNOCKDOWN6A,0

;***************************************************************************

a_getup
	.long	LIGETUP1
	.long	LIGETUP2
	.long	LIGETUP3
	.long	LIGETUP4
	.long	LIGETUP5
	.long	LIGETUP6
	.long	0

LIGETUP1	.long	LIGETUP1A,0
LIGETUP2	.long	LIGETUP2A,LIGETUP2B,0
LIGETUP3	.long	LIGETUP3A,LIGETUP3B,0
LIGETUP4	.long	LIGETUP4A,0
LIGETUP5	.long	LIGETUP5A,0
LIGETUP6	.long	LIGETUP6A,LIGETUP6B,0

;***************************************************************************

a_afb_kano
	.long	ani_offset_xy
	.word	-029H,-003H
	.long	LIKNOCKDOWN1

	.long	ani_offset_xy
	.word	-02dH,005H
	.long	LIKNOCKDOWN3

	.long	ani_offset_xy
 	.word	-036H,014H
	.long	LIKNOCKDOWN4

	.long	0
*
* fall down solo
*
	.long	LIKNOCKDOWN4
	.long	LIKNOCKDOWN5
	.long	LIKNOCKDOWN6
	.long	0

a_fb_smoke
a_afb_robo2
	.long	ani_offset_xy
	.word	-01eH,-032H
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	007H,-047H
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	037H,-04eH
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	055H,-026H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	067H,-015H
	.long	LIKNOCKDOWN6
	.long	ani_offset_xy
	.word	072H,016H
	.long	LIKNOCKDOWN6
	.long	0


a_fb_lao
	.long	ani_offset_xy
	.word	-02bH,01aH
	.long	LISTUMBLE1		; 1
	.long	ani_offset_xy
	.word	-00fH,033H
	.long	LISTUMBLE1		; 2
	.long	ani_flip
	.long	ani_offset_xy
	.word	-02bH,01dH
	.long	LIFLIPPED1		; 3
	.long	ani_offset_xy
	.word	-046H,-01eH
	.long	LIFLIPPED2		; 4
	.long	ani_offset_xy
	.word	-02cH,-05eH
	.long	LIFLIPPED3		; 5
	.long	ani_offset_xy
	.word	01dH,-074H
	.long	LIFLIPPED4		; 6
	.long	ani_offset_xy
	.word	054H,-070H
	.long	LIFLIPPED4		; 7
	.long	ani_offset_xy
	.word	060H,-056H
	.long	LIFLIPPED4		; 8
	.long	ani_offset_xy
	.word	077H,002H
	.long	LIFLIPPED4		; 9
	.long	ani_offset_xy
	.word	077H,052H
	.long	LIFLIPPED4		; 10
	.long	0


a_fb_tusk
	.long	ani_offset_xy
	.word	-06eH,000H
	.long	LIFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-05dH,-04aH
	.long	LIFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-00cH,-081H
	.long	LIFLIPPED3		; 3
	.long	ani_offset_xy
	.word	04bH,-061H
	.long	LIFLIPPED4		; 4
	.long	ani_offset_xy
	.word	04aH,-01cH
	.long	LIFLIPPED4		; 5

	.long	ani_offset_xy
	.word	017H,-004H
  	.long	LIKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	-024H,-019H
  	.long	LIKNOCKDOWN6		; 7
	.long	ani_offset_xy
	.word	-068H,001H
	.long	LIFLIPPED1		; 8
	.long	ani_offset_xy
	.word	-04eH,-054H
	.long	LIFLIPPED2		; 9
	.long	ani_offset_xy
	.word	026H,-072H
	.long	LIFLIPPED3		; 10 

	.long	ani_offset_xy
	.word	065H,-005H
	.long	LIFLIPPED4		; 11
	.long	ani_offset_xy
	.word	064H,009H
  	.long	LIKNOCKDOWN6		; 12
	.long	0



a_fb_sg
	.long	ani_offset_xy
	.word	-03dH,-030H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-008H,-052H
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	-001H,-05eH
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	018H,-04fH
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	01aH,-035H
	.long	LIFLIPPED3
	.long	ani_flip
	.long	ani_offset_xy
	.word	-01cH,-009H
  	.long	LIKNOCKDOWN6
	.long	0


a_fb_st
	.long	ani_offset_xy
	.word	-04cH,000H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-041H,007H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-02aH,001H
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	-007H,003H
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	024H,013H
	.long	LIFLIPPED4

	.long	ani_offset_xy
	.word	002H,-004H
	.long	LIKNOCKDOWN6
	.long	ani_offset_xy
	.word	-023H,-004H
	.long	LIKNOCKDOWN6
	.long	ani_offset_xy
	.word	-038H,-004H
	.long	LIKNOCKDOWN6

	.long	ani_offset_xy
	.word	-060H,019H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-067H,-00bH
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-03cH,-04cH
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	03bH,-054H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	04cH,-018H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	05bH,-008H
	.long	LIKNOCKDOWN6
	.long	0



a_fb_lk
	.long	ani_offset_xy
	.word	-044H,-001H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-03bH,007H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-013H,008H
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	001H,010H
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	02cH,-004H
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	088H,-01fH
	.long	LIFLIPPED4
	.long	0

	.long	LIFLIPPED4
	.long	LIKNOCKDOWN5
	.long	LIKNOCKDOWN6
	.long	0



a_fb_kano
	.long	ani_offset_xy
	.word	-03dH,-016H			; we need even # of words here !
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-011H,-02dH
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	033H,-037H
	.long	LIFLIPPED3
	.long	0

	.long	LIFLIPPED4
	.long	LIFLIPPED4
	.long	LIKNOCKDOWN4
	.long	LIKNOCKDOWN5
	.long	0


a_fb_sonya
	.long	ani_offset_xy
	.word	-02dH,005H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-011H,004H
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	019H,-013H
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	071H,-027H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	09fH,-041H
	.long	LIFLIPPED4
	.long	0

	.long	LIFLIPPED4
	.long	LIKNOCKDOWN4
	.long	LIKNOCKDOWN5
	.long	0

a_fb_jax
	.long	ani_offset_xy
	.word	-04aH,-01aH
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-01eH,-03bH
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	015H,-051H
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	04eH,-038H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	05fH,-00bH
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	04cH,006H
	.long	LIKNOCKDOWN6
	.long	0

a_fb_ind
	.long	ani_offset_xy
	.word	-05cH,-010H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-04dH,-03eH
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	-013H,-065H
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	039H,-055H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	057H,-01dH
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	046H,000H
	.long	LIKNOCKDOWN6
	.long	0

a_fb_sz
	.long	ani_offset_xy
	.word	-04aH,-039H
	.long	LIFLIPPED1

	.long	ani_flip
	.long	ani_offset_xy
	.word	055H,-026H
	.long	LIFLIPPED4

	.long	ani_offset_xy
	.word	03aH,-007H
	.long	LIFLIPPED4

	.long	ani_offset_xy
	.word	002H,-016H
	.long	LIKNOCKDOWN5

	.long	ani_offset_xy
	.word	-03aH,-03eH
	.long	LIKNOCKDOWN5

	.long	ani_offset_xy
	.word	-060H,-063H
	.long	LIKNOCKDOWN5
	.long	0

a_fb_swat
	.long	ani_offset_xy
	.word	-04cH,-011H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-036H,-044H
	.long	LIFLIPPED2
	.long	ani_offset_xy
	.word	026H,-05fH
	.long	LIFLIPPED3
	.long	ani_offset_xy
	.word	065H,-026H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	050H,000H
	.long	LIKNOCKDOWN6
	.long	0



a_fb_lia
	.long	ani_offset_xy
	.word	-064H,000H
	.long	LISTUMBLE1
	.long	ani_offset_xy
	.word	-073H,003H
	.long	LISTUMBLE1

	.long	ani_offset_xy
	.word	-075H,-01eH
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-057H,-03dH
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	-023H,-046H
	.long	LIFLIPPED1
	.long	ani_offset_xy
	.word	01eH,-04eH
	.long	LIFLIPPED1

	.long	ani_offset_xy
	.word	0a8H,012H
	.long	LIFLIPPED4
	.long	ani_offset_xy
	.word	08dH,000H
	.long	LIKNOCKDOWN6
	.long	0

a_fb_robo
	.long	ani_offset_xy
	.word	-04fH,-00bH
	.long	LIFLIPPED1		; 1
	.long	ani_offset_xy
	.word	-04dH,-03cH
	.long	LIFLIPPED2		; 2
	.long	ani_offset_xy
	.word	-038H,-051H
	.long	LIFLIPPED2		; 3

	.long	ani_offset_xy
	.word	000H,-074H
	.long	LIFLIPPED3		; 4
	.long	ani_offset_xy
	.word	045H,-079H
	.long	LIFLIPPED4		; 5
	.long	ani_offset_xy
	.word	071H,-067H
	.long	LIFLIPPED4		; 6

	.long	ani_offset_xy
	.word	080H,-01eH
	.long	LIFLIPPED4		; 7
	.long	ani_offset_xy
	.word	06dH,-00eH
	.long	LIKNOCKDOWN6		; 8
	.long	0


a_fb_robo2
	.long	ani_offset_xy
	.word	-029H,-007H
	.long	LISTUMBLE1		; 1
	.long	ani_offset_xy
	.word	-02bH,-01cH
	.long	LIFLIPPED1		; 2
	.long	ani_offset_xy
	.word	-00eH,-024H
	.long	LIFLIPPED2		; 3
	.long	ani_offset_xy
	.word	019H,-026H
	.long	LIFLIPPED3		; 4
	.long	ani_offset_xy
	.word	031H,-00bH
	.long	LIFLIPPED4		; 5
	.long	ani_offset_xy
	.word	025H,006H
	.long	LIFLIPPED4		; 6
	.long	ani_offset_xy
	.word	-00dH,-015H
	.long	LIKNOCKDOWN6		; 7
	.long	0


a_legged
	.long	ani_offset_xy
	.word	-063H,003H
	.long	LIKNOCKDOWN1

	.long	ani_offset_xy
	.word	-054H,-026H
	.long	LIFLIPPED1

	.long	ani_offset_xy
	.word	-01dH,-04aH
	.long	LIFLIPPED3

	.long	ani_offset_xy
	.word	037H,-040H
	.long	LIFLIPPED4

	.long	ani_offset_xy
	.word	05aH,-00aH
	.long	LIFLIPPED4
	.long	0
	


a_zoomed
	.long	ani_offset_xy
	.word	059H,-025H
	.long	LIKNOCKDOWN3	; 1

	.long	ani_offset_xy
	.word	057H,-00aH
	.long	LIKNOCKDOWN4	; 2

	.long	ani_offset_xy
	.word	031H,001H
	.long	LIKNOCKDOWN5	; 3

	.long	ani_offset_xy
	.word	-030H,002H
	.long	LIKNOCKDOWN5	; 4

	.long	ani_offset_xy
	.word	-088H,-013H
	.long	LIFLIPPED1	; 5

	.long	ani_offset_xy
	.word	-02fH,-05fH
	.long	LIFLIPPED3	; 6
	.long	0

	.long	LIFLIPPED3
	.long	LIFLIPPED4
	.long	LIKNOCKDOWN5
	.long	LIKNOCKDOWN6
	.long	0

a_shook
	.long	ani_offset_xy
	.word	-050H,-003H
	.long	LISTUMBLE1	; 3

	.long	ani_offset_xy
	.word	-037H,-01eH
	.long	LISTUMBLE1	; 4

	.long	ani_offset_xy
	.word	-01aH,-014H
	.long	LISTUMBLE1	; 5
	.long	0

; loop
	.long	ani_offset_xy
	.word	-020H,-018H
	.long	LISTUMBLE1	; 6

	.long	ani_offset_xy
	.word	-036H,-022H
	.long	LISTUMBLE1	; 7

	.long	ani_offset_xy
	.word	-045H,-026H
	.long	LISTUMBLE1	; 8

	.long	ani_offset_xy
	.word	-036H,-022H
	.long	LISTUMBLE1	; 7
	.long	0


LIFLIPPED1
	.long	LIFLIPPED1A,0
LIFLIPPED2
	.long	LIFLIPPED2A,LIFLIPPED2B,0
LIFLIPPED3
	.long	LIFLIPPED3A,0
LIFLIPPED4
	.long	LIFLIPPED4A,0
;***************************************************************************

a_sweep_fall
	.long	LISWEEPFALL1
	.long	LISWEEPFALL2
	.long	LISWEEPFALL3
	.long	LISWEEPFALL4
	.long	0
	.long	LISWEEPFALL5
	.long	LISWEEPFALL6
	.long	0

LISWEEPFALL1
	.long	LISWEEPFALL1A,LISWEEPFALL1B,0
LISWEEPFALL2
	.long	LISWEEPFALL2A,LISWEEPFALL2B,0
LISWEEPFALL3
	.long	LISWEEPFALL3A,LISWEEPFALL3B,0
LISWEEPFALL4
	.long	LISWEEPFALL4A,0
LISWEEPFALL5
	.long	LISWEEPFALL5A,0
LISWEEPFALL6
	.long	LISWEEPFALL6A,0
;***************************************************************************

a_sweepup
	.long	LISWEEPUP1
	.long	LISWEEPUP2
	.long	LISWEEPUP3
	.long	LISWEEPUP4
	.long	LISWEEPUP5
	.long	LISWEEPUP6
	.long	0

LISWEEPUP1
	.long	LISWEEPUP1A,0
LISWEEPUP2
	.long	LISWEEPUP2A,0
LISWEEPUP3
	.long	LISWEEPUP3A,0
LISWEEPUP4
	.long	LISWEEPUP4A,0
LISWEEPUP5
	.long	LISWEEPUP5A,0
LISWEEPUP6
	.long	LISWEEPUP6A,LISWEEPUP6B,0

;**************************************************************************

a_victory
	.long	RBVICTORY1
	.long	RBVICTORY2
	.long	RBVICTORY3
	.long	RBVICTORY4
	.long	RBVICTORY5
	.long	RBVICTORY6
	.long	RBVICTORY7
	.long	0
*
* part 2 is for psel
*
	.long	RBVICTORY1
	.long	ani_adjustx
	.word	-3
	.long	RBVICTORY2
	.long	ani_adjustx
	.word	-3
	.long	RBVICTORY3
	.long	ani_adjustx
	.word	-3
	.long	RBVICTORY4
	.long	ani_adjustx
	.word	-3
	.long	RBVICTORY5
	.long	ani_adjustx
	.word	-3
	.long	RBVICTORY6
	.long	RBVICTORY7
	.long	0

RBVICTORY1
	.long	RBVICTORY1A,RBVICTORY1B,0
RBVICTORY2
	.long	RBVICTORY2A,RBVICTORY2B,0
RBVICTORY3
	.long	RBVICTORY3A,0
RBVICTORY4
	.long	RBVICTORY4A,0
RBVICTORY5
	.long	RBVICTORY5A,0
RBVICTORY6
	.long	RBVICTORY6A,0
RBVICTORY7
	.long	RBVICTORY7A,0

;*************************************************************************

a_throw
	.long	LIHAIRTHRO1
	.long	LIHAIRTHRO2
	.long	LIHAIRTHRO3
	.long	LIHAIRTHRO4
	.long	LIHAIRTHRO5
	.long	LIHAIRTHRO6
	.long	0

	.long	LIHAIRTHRO7
	.long	LIHAIRTHRO9
	.long	LIHAIRTHRO11
	.long	LIHAIRTHRO12
	.long	LIHAIRTHRO13
	.long	LIHAIRTHRO14
	.long	LIHAIRTHRO15
	.long	LIHAIRTHRO16
	.long	0

	.long	LIHAIRTHRO17
	.long	LIHAIRTHRO18
	.long	LIHAIRTHRO19
	.long	0

LIHAIRTHRO1
	.long	LIHAIRTHRO1A,LIHAIRTHRO1B,0
LIHAIRTHRO2
	.long	LIHAIRTHRO2A,LIHAIRTHRO2B,0
LIHAIRTHRO3
	.long	LIHAIRBODY1A,LIHAIRBODY1B,LIHAIRTHRO3A,0
LIHAIRTHRO4
	.long	LIHAIRBODY1A,LIHAIRBODY1B,LIHAIRTHRO4A,0
LIHAIRTHRO5
	.long	LIHAIRBODY1A,LIHAIRBODY1B,LIHAIRTHRO5A,0
LIHAIRTHRO6
	.long	LIHAIRBODY1A,LIHAIRBODY1B,LIHAIRTHRO6A,0
LIHAIRTHRO7
	.long	LIHAIRBODY1A,LIHAIRBODY1B,LIHAIRTHRO7A,0
LIHAIRTHRO9
	.long	LIHAIRTHRO9A,LIHAIRTHRO9B,LIHAIRTHRO9C,0
LIHAIRTHRO11
	.long	LIHAIRTHRO11A,LIHAIRTHRO11B,LIHAIRTHRO11C,0
LIHAIRTHRO12
	.long	LIHAIRTHRO12A,LIHAIRTHRO12B,LIHAIRTHRO12C,0
LIHAIRTHRO13
	.long	LIHAIRTHRO13A,LIHAIRTHRO13B,LIHAIRTHRO13C,0
LIHAIRTHRO14
	.long	LIHAIRTHRO14A,LIHAIRTHRO14B,0
LIHAIRTHRO15
	.long	LIHAIRTHRO15A,LIHAIRTHRO15B,LIHAIRBODY2A,LIHAIRBODY2B,0
LIHAIRTHRO16
	.long	LIHAIRTHRO16A,LIHAIRBODY2A,LIHAIRBODY2B,0
LIHAIRTHRO17
	.long	LIHAIRTHRO17A,LIHAIRTHRO17B,LIHAIRTHRO17C,0
LIHAIRTHRO18
	.long	LIHAIRTHRO18A,LIHAIRTHRO18B,LIHAIRTHRO18C,0
LIHAIRTHRO19
	.long	LIHAIRTHRO19A,LIHAIRTHRO19B,0

;**************************************************************************

a_lia_scream
	.long	LIMOUTHPRO1
	.long	LIMOUTHPRO2
	.long	LIMOUTHPRO3
	.long	LIMOUTHPRO5
	.long	0

j_scream
	.long	LIMOUTHPRO6
	.long	LIMOUTHPRO7
	.long	LIMOUTHPRO8
	.long	LIMOUTHPRO9
	.long	LIMOUTHPRO10
	.long	LIMOUTHPRO11
	.long	LIMOUTHPRO12
	.long	LIMOUTHPRO5
	.long	ani_jump,j_scream
	.long	0
	.long	LIMOUTHPRO3
	.long	LIMOUTHPRO2
	.long	LIMOUTHPRO1
	.long	0

LIMOUTHPRO1
	.long	LIMOUTHPRO1A,LIMOUTHPRO1B,0
LIMOUTHPRO2
	.long	LIMOUTHPRO2A,LIMOUTHPRO2B,0
LIMOUTHPRO3
	.long	LIMOUTHPRO3A,LIMOUTHPRO3B,0
LIMOUTHPRO5
	.long	LIMOUTHPRO5A,LIMOUTHPRO4A,LIMOUTHPRO4B,0
LIMOUTHPRO6
	.long	LIMOUTHPRO6A,LIMOUTHPRO4A,LIMOUTHPRO4B,0
LIMOUTHPRO7
	.long	LIMOUTHPRO7A,LIMOUTHPRO4A,LIMOUTHPRO4B,0
LIMOUTHPRO8
	.long	LIMOUTHPRO8A,LIMOUTHPRO4A,LIMOUTHPRO4B,0
LIMOUTHPRO9
	.long	LIMOUTHPRO9A,LIMOUTHPRO4A,LIMOUTHPRO4B,0
LIMOUTHPRO10
	.long	LIMOUTHPRO10A,LIMOUTHPRO4A,LIMOUTHPRO4B,0
LIMOUTHPRO11
	.long	LIMOUTHPRO11A,LIMOUTHPRO4A,LIMOUTHPRO4B,0
LIMOUTHPRO12
	.long	LIMOUTHPRO12A,LIMOUTHPRO4A,LIMOUTHPRO4B,0


a_zap
	.long	LIMOUTHPRO1
	.long	LIMOUTHPRO2
	.long	LIMOUTHPRO3
	.long	LIMOUTHPRO5
	.long	0

	.long	SIDES1
	.long	SIDES2
	.long	SIDES3
	.long	SIDES4
	.long	SIDES5
	.long	SIDES6
	.long	SIDES7
	.long	SIDES8
	.long	SIDES9
	.long	0

;	.long	LISIDEFLASH


SIDES1	.long	LISIDESPIT1,0
SIDES2	.long	LISIDESPIT2,0
SIDES3	.long	LISIDESPIT3,0
SIDES4	.long	LISIDESPIT4,0
SIDES5	.long	LISIDESPIT5,0
SIDES6	.long	LISIDESPIT6,0
SIDES7	.long	LISIDESPIT7,0
SIDES8	.long	LISIDESPIT8,0
SIDES9	.long	LISIDESPIT9,0


a_shock_wave
	.long	LISHOKWAV1
	.long	LISHOKWAV2
	.long	LISHOKWAV3
	.long	LISHOKWAV4
	.long	LISHOKWAV5
	.long	LISHOKWAV6
	.long	LISHOKWAV7
	.long	LISHOKWAV8
	.long	LISHOKWAV9
	.long	0

LISHOKWAV1
	.long	LISHOKWAV1A,0
LISHOKWAV2
	.long	LISHOKWAV2A,0
LISHOKWAV3
	.long	LISHOKWAV3A,0
LISHOKWAV4
	.long	LISHOKWAV4A,0
LISHOKWAV5
	.long	LISHOKWAV5A,0
LISHOKWAV6
	.long	LISHOKWAV6A,0
LISHOKWAV7
	.long	LISHOKWAV7A,LISHOKWAV7B,0
LISHOKWAV8
	.long	LISHOKWAV8A,0
LISHOKWAV9
	.long	LISHOKWAV9A,0


a_fly_up
	.long	LIHOVR1
	.long	LIHOVR2
	.long	0

	.long	LIHOVR2
	.long	LIHOVR2
	.long	LIHOVR2
	.long	LIHOVR2
	.long	LIHOVR3
	.long	LIHOVR4

j_hair	.long	LIHOVR51
	.long	LIHOVR52
	.long	LIHOVR53
	.long	LIHOVR54
	.long	ani_jump,j_hair


LIHOVR6	.long	LIHOVR6A,0
LIHOVR7	.long	LIHOVR7A,LIHOVR7B,0
LIHOVR8	.long	LIHOVR8A,LIHOVR8B,0
LIHOVR91	.long	LIHOVR9A,LIHOVR9B,LIHOVR9HAIR1A,0
LIHOVR92	.long	LIHOVR9A,LIHOVR9B,LIHOVR9HAIR2A,0
LIHOVR93	.long	LIHOVR9A,LIHOVR9B,LIHOVR9HAIR3A,0

;**************************************************************************

a_fly_backward
	.long	LIHOVRA
	.long	LIHOVRB
j_backw	.long	LIHOVRC1
	.long	LIHOVRC2
	.long	LIHOVRC3
	.long	ani_jump,j_backw


a_fly_forward
	.long	LIHOVR6
	.long	LIHOVR7
	.long	LIHOVR8
j_right	.long	LIHOVR91
	.long	LIHOVR92
	.long	LIHOVR93
	.long	ani_jump,j_right
	.long	0
*
* part 2 = turn around
*
	.long	LIHOVR8
	.long	LIHOVR7
	.long	LIHOVR6
	.long	ani_flip
	.long	ani_jump,a_fly_forward


a_unforward
	.long	LIHOVR8
	.long	LIHOVR7
	.long	LIHOVR6
	.long	ani_calla,new_float_ani
	.long	ani_jump,j_hair

a_unbackoff
	.long	LIHOVRB
	.long	LIHOVRA
	.long	ani_calla,new_float_ani
	.long	ani_jump,j_hair

new_float_ani
	clr	a0
	move	a0,*a13(p_store3),0
	movk	6,a0
	move	a0,*a13(p_anirate),0
	rets


LIHOVR1	.long	LIHOVR1A,0
LIHOVR2	.long	LIHOVR2A,LIHOVR2B,LIHOVR2C,0
LIHOVR3	.long	LIHOVR3A,0
LIHOVR4	.long	LIHOVR4A,0

LIHOVR51	.long	LIHOVR5HAIR1A,LIHOVR5HAIR1B,LIHOVR5A,LIHOVR5B,LIHOVR5C,0
LIHOVR52	.long	LIHOVR5HAIR2A,LIHOVR5HAIR2B,LIHOVR5A,LIHOVR5B,LIHOVR5C,0
LIHOVR53	.long	LIHOVR5HAIR3A,LIHOVR5HAIR3B,LIHOVR5A,LIHOVR5B,LIHOVR5C,0
LIHOVR54	.long	LIHOVR5HAIR4A,LIHOVR5HAIR4B,LIHOVR5A,LIHOVR5B,LIHOVR5C,0


LIHOVRA	.long	LIHOVR10A,LIHOVR10B,0
LIHOVRB	.long	LIHOVR11A,0
LIHOVRC1	.long	LIHOVR12A,LIHOVR11HAIR2A,0
LIHOVRC2	.long	LIHOVR12A,LIHOVR11HAIR3A,0
LIHOVRC3	.long	LIHOVR12A,LIHOVR11HAIR4A,0


a_angle_zap
	.long	LIHOVRPRO1
	.long	LIHOVRPRO2
	.long	LIHOVRPRO3
	.long	ani_sladd,FACELIT	; add object ---> fireball
	.long	LIHOVRPRO4
	.long	0

	.long	ani_calla,slave_inviso
	.long	LIHOVRPRO4
	.long	ani_calla,slave_viso
	.long	LIHOVRPRO4
	.long	ani_calla,slave_inviso
	.long	LIHOVRPRO4

;	.long	ani_calla,slave_viso
;	.long	LIHOVRPRO4
;	.long	ani_calla,slave_inviso
;	.long	LIHOVRPRO4
;	.long	ani_calla,slave_viso
;	.long	LIHOVRPRO4
;	.long	ani_calla,slave_inviso
;	.long	LIHOVRPRO4
;	.long	ani_calla,slave_viso
;	.long	LIHOVRPRO4
	.long	0

	.long	LIHOVRPRO3
	.long	LIHOVRPRO2
	.long	LIHOVRPRO1
	.long	0


LIHOVRPRO1
	.long	LIHOVRPRO1A,LIHOVRPRO1B,LIHOVRPRO1C,0
LIHOVRPRO2
	.long	LIHOVRPRO2A,0
LIHOVRPRO3
	.long	LIHOVRPRO3A,0
LIHOVRPRO4
	.long	LIHOVRPRO4A,LIHOVRPRO4B,0


FACELIT	.long	LIFLASH,0

a_projectile
	.long	LIAFB1
	.long	LIAFB2
	.long	LIAFB3

j_fireball
	.long	LIAFB4
	.long	LIAFB5
	.long	LIAFB6
	.long	ani_jump,j_fireball
	.long	0

	.long	LIAFB7
	.long	LIAFB8
	.long	LIAFB9
	.long	LIABANG1
	.long	LIABANG2
	.long	LIABANG3
	.long	LIABANG4
	.long	LIABANG5
	.long	LIABANG6
	.long	LIABANG7
	.long	LIABANG8
	.long	LIABANG9
	.long	0

LIAFB1	.long	LIASPIT1,0
LIAFB2	.long	LIASPIT2,0
LIAFB3	.long	LIASPIT3,0
LIAFB4	.long	LIASPIT4,0
LIAFB5	.long	LIASPIT5,0
LIAFB6	.long	LIASPIT6,0
LIAFB7	.long	LIASPIT7,0
LIAFB8	.long	LIASPIT8,0
LIAFB9	.long	LIASPIT9,0


LIABANG1	.long	LIAXPLOD1,0
LIABANG2	.long	LIAXPLOD2,0
LIABANG3	.long	LIAXPLOD3,0
LIABANG4	.long	LIAXPLOD4,0
LIABANG5	.long	LIAXPLOD5,0
LIABANG6	.long	LIAXPLOD6,0
LIABANG7	.long	LIAXPLOD7,0
LIABANG8	.long	LIAXPLOD8,0
LIABANG9	.long	LIAXPLOD9,0

a_run	.long	LIRUN1
	.long	LIRUN2
	.long	LIRUN3
	.long	ani_calla,rsnd_footstep
	.long	LIRUN4
	.long	LIRUN5
	.long	LIRUN6
	.long	LIRUN7
	.long	LIRUN8
	.long	ani_calla,rsnd_footstep
	.long	LIRUN9
	.long	LIRUN10
	.long	LIRUN11
	.long	LIRUN12
	.long	ani_jump,a_run
	.long	0			; we need this zero !!


LIRUN1	.long	LIRUN1A,LIRUN1B,0
LIRUN2	.long	LIRUN2A,LIRUN2B,0
LIRUN3	.long	LIRUN3A,0
LIRUN4	.long	LIRUN4A,0
LIRUN5	.long	LIRUN5A,0
LIRUN6	.long	LIRUN6A,LIRUN6B,0
LIRUN7	.long	LIRUN7A,LIRUN7B,0
LIRUN8	.long	LIRUN8A,LIRUN8B,0
LIRUN9	.long	LIRUN9A,LIRUN9B,0
LIRUN10	.long	LIRUN10A,0
LIRUN11	.long	LIRUN11A,0
LIRUN12	.long	LIRUN12A,LIRUN12B,0

a_top 
	.long	ani_swpal
	.long	SPINNER1
	.long	SPINNER2
	.long	SPINNER3
	.long	SPINNER4
	.long	SPINNER5
	.long	SPINNER6
	.long	ani_jump,a_top
	.long	0

	.long	TOPGONE1
	.long	TOPGONE2
	.long	TOPGONE3
	.long	TOPGONE4
	.long	TOPGONE5
	.long	TOPGONE6
	.long	TOPGONE7
	.long	0

SPINNER1	.long	TOP1,0
SPINNER2	.long	TOP2,0
SPINNER3	.long	TOP3,0
SPINNER4	.long	TOP4,0
SPINNER5	.long	TOP5,0
SPINNER6	.long	TOP6,0

TOPGONE1	.long	TOPOUT1,0
TOPGONE2	.long	TOPOUT2,0
TOPGONE3	.long	TOPOUT3,0
TOPGONE4	.long	TOPOUT4,0
TOPGONE5	.long	TOPOUT5,0
TOPGONE6	.long	TOPOUT6,0
TOPGONE7	.long	TOPOUT7,0

;**************************************************************************

a_scared
	.long	LISCARED3
	.long	0

LISCARED3
	.long	LISCARED3A,0

a_thudd
	.long	LITHUD1
	.long	LITHUD2
	.long	LITHUD3
	.long	LITHUD4
	.long	LITHUD5
	.long	LITHUD6
	.long	LITHUD7
	.long	0

LITHUD1	.long	LITHUD1A,0
LITHUD2	.long	LITHUD2A,0
LITHUD3	.long	LITHUD3A,0
LITHUD4	.long	LITHUD4A,0
LITHUD5	.long	LITHUD5A,0
LITHUD6	.long	LITHUD6A,0
LITHUD7	.long	LITHUD7A,0

;**************************************************************************

a_normal_skel
	.long	SKELRIP1
	.long	SKELRIP2
	.long	SKELRIP3
	.long	0

a_sg_skel
	.long	SGOROSKEL1
	.long	SGOROSKEL2
	.long	SGOROSKEL3
	.long	0

SGOROSKEL1
	.long	SGOROSKEL1A,SGOROSKEL1B,0
SGOROSKEL2
	.long	SGOROSKEL2A,SGOROSKEL2B,0
SGOROSKEL3
	.long	SGOROSKEL3A,SGOROSKEL3B,0
SKELRIP1
	.long	SKELRIP1A,SKELRIP1B,0
SKELRIP2
	.long	SKELRIP2A,SKELRIP2B,0
SKELRIP3
	.long	SKELRIP3A,SKELRIP3B,0


ochar_ripped_anis
	.long	a_kano_rip	; 0
	.long	a_sonya_rip	; 1
	.long	a_jax_rip	; 2
	.long	a_ind_rip	; 3
	.long	a_sz_rip	; 4
	.long	a_swat_rip	; 5
	.long	a_lia_rip	; 6
	.long	a_robo_rip	; 7
	.long	a_robo2_rip	; 8
	.long	a_lao_rip	; 9
	.long	a_tusk_rip	; 10
	.long	a_sg_rip	; 11
	.long	a_st_rip	; 12
	.long	a_lk_rip	; 13
	.long	a_robo3_rip	; 14
	.long	a_lia_p2_rip	; 15 - player 2 lia
	.long	0
*
* part 2 = skeletons
*
	.long	a_normal_skel
	.long	a_sg_skel


a_robo_rip
	.long	RBRIP1
	.long	RBRIP2
	.long	RBRIP3
	.long	RBRIP4
	.long	RBRIP5
	.long	RBRIP6
	.long	RBRIP7
	.long	0

a_robo2_rip
	.long	CYRAX_RBRIP1
	.long	RBRIP2
	.long	RBRIP3
	.long	CYRAX_RBRIP4
	.long	RBRIP5
	.long	RBRIP6
	.long	RBRIP7
	.long	0

a_robo3_rip
	.long	SMOKE_RBRIP1
	.long	RBRIP2
	.long	RBRIP3
	.long	SMOKE_RBRIP4
	.long	RBRIP5
	.long	RBRIP6
	.long	RBRIP7
	.long	0

a_lia_p2_rip
	.long	LIA2_LARIP1
	.long	LARIP2
	.long	LARIP3
	.long	LIA2_LARIP4
	.long	LARIP5
	.long	LARIP6
	.long	LARIP7
	.long	0


LIA2_LARIP1
      	.long	P2_LARIP1A,LARIP1B,0

LIA2_LARIP4
      	.long	P2_LARIP4A,LARIP4B,0

P2_LARIP1A:
	.word   68,113,58,-26
	.long   069ae0dfH
	.word   05680H
	.long   LIALTFA_P
P2_LARIP4A:
	.word   159,113,154,-26
	.long   069c11a8H
	.word   05f80H
	.long   LIALTFB_P

LIALTFA_P:
   .word   32 
   .word   00000h,07fffh,077bdh,06318h,056b5h,04a52h,04210h,0318ch
   .word   0294ah,02108h,018c6h,01084h,00842h,00000h,07f99h,07b14h
   .word   0624fh,05a0bh,051ech,04daah,04dcbh,0458ah,04188h,03526h
   .word   028c5h,02ed6h,01e13h,015f1h,00d8dh,0054bh,00107h,000c4h

LIALTFB_P:
   .word   16 
   .word   0001fh,014a5h,0294ah,0020eh,00252h,00294h,002f9h,05294h
   .word   051ech,03526h,05a0bh,0624fh,07b14h,0739ch,017dfh,028c5h


CYRAX_RBRIP1
	.long	CYRBRIP1A,RBRIP1B,0
SMOKE_RBRIP1
	.long	SMRBRIP1A,RBRIP1B,0
CYRAX_RBRIP4
	.long	CYRBRIP1A,RBRIP1B,0
SMOKE_RBRIP4
	.long	SMRBRIP1A,RBRIP1B,0

RBRIP1	.long	RBRIP1A,RBRIP1B,0
RBRIP2	.long	RBRIP2A,RBRIP2B,0
RBRIP3	.long	RBRIP3A,RBRIP3B,0
RBRIP4	.long	RBRIP4A,RBRIP4B,0
RBRIP5	.long	RBRIP5A,RBRIP5B,0
RBRIP6	.long	RBRIP6A,RBRIP6B,0
RBRIP7	.long	RBRIP7A,0

CYRBRIP1A:
	.word   51,122,41,-21
	.long   085e72a6H
	.word   05680H
	.long   RBYLFLA_P
CYRBRIP4A:
	.word   136,122,127,-21
	.long   085f5a70H
	.word   04f80H
	.long   RBYLFLB_P
SMRBRIP1A:
	.word   51,122,41,-21
	.long   085e72a6H
	.word   05680H
	.long   RBBLFLA_P
SMRBRIP4A:
	.word   136,122,127,-21
	.long   085f5a70H
	.word   04f80H
	.long   RBBLFLB_P

RBYLFLA_P:
   .word   32 
   .word   00000h,07fb8h,07f95h,07b51h,06aaah,06aa7h,06244h,06201h
   .word   059c0h,051a1h,04982h,04561h,04181h,03121h,02ce0h,024c0h
   .word   01060h,07fffh,04a52h,03defh,035adh,02d6bh,0294ah,02108h
   .word   01ce7h,018c6h,014a5h,01084h,00c63h,00842h,00421h,00000h

RBYLFLB_P:
   .word   16 
   .word   00000h,07fb8h,07f95h,07b51h,06244h,06201h,051a1h,024c0h
   .word   0294ah,02108h,014a5h,01084h,00c63h,00842h,00421h,00000h

RBBLFLA_P:
   .word   32 
   .word   00000h,046dfh,0467dh,03e1ah,02d33h,02cf0h,0248dh,0242bh
   .word   01c09h,0140ah,00c2bh,0080ah,0042ah,0000ah,00008h,00009h
   .word   01020h,07fffh,04a52h,03defh,035adh,02d6bh,0294ah,02108h
   .word   01ce7h,018c6h,014a5h,01084h,00c63h,00842h,00421h,00000h

RBBLFLB_P:
   .word   16 
   .word   00000h,049dfh,0497fh,0411dh,02810h,0280eh,0180dh,0000ch
   .word   0294ah,02108h,014a5h,01084h,00c63h,00842h,00421h,00000h

;********************************************************************

a_lao_rip
	.long	KLRIP1
	.long	KLRIP2
	.long	KLRIP3
	.long	KLRIP4
	.long	KLRIP5
	.long	KLRIP6
	.long	KLRIP7
	.long	0

KLRIP1	.long	KLRIP1A,KLRIP1B,0
KLRIP2	.long	KLRIP2A,KLRIP2B,0
KLRIP3	.long	KLRIP3A,KLRIP3B,0
KLRIP4	.long	KLRIP4A,KLRIP4B,0
KLRIP5	.long	KLRIP5A,KLRIP5B,0
KLRIP6	.long	KLRIP6A,KLRIP6B,0
KLRIP7	.long	KLRIP7A,0


a_swat_rip
	.long	OBRIP1
	.long	OBRIP2
	.long	OBRIP3
	.long	OBRIP4
	.long	OBRIP5
	.long	OBRIP6
	.long	OBRIP7
	.long	0

OBRIP1	.long	OBRIP1A,OBRIP1B,0
OBRIP2	.long	OBRIP2A,OBRIP2B,0
OBRIP3	.long	OBRIP3A,OBRIP3B,0
OBRIP4	.long	OBRIP4A,OBRIP4B,0
OBRIP5	.long	OBRIP5A,OBRIP5B,0
OBRIP6	.long	OBRIP6A,OBRIP6B,0
OBRIP7	.long	OBRIP7A,0


a_lia_rip
	.long	LARIP1
	.long	LARIP2
	.long	LARIP3
	.long	LARIP4
	.long	LARIP5
	.long	LARIP6
	.long	LARIP7
	.long	0

LARIP1	.long	LARIP1A,LARIP1B,0
LARIP2	.long	LARIP2A,LARIP2B,0
LARIP3	.long	LARIP3A,LARIP3B,0
LARIP4	.long	LARIP4A,LARIP4B,0
LARIP5	.long	LARIP5A,LARIP5B,0
LARIP6	.long	LARIP6A,LARIP6B,0
LARIP7	.long	LARIP7A,LARIP7B,0


a_sonya_rip
	.long	SNRIP1
	.long	SNRIP2
	.long	SNRIP3
	.long	SNRIP4
	.long	SNRIP5
	.long	SNRIP6
	.long	SNRIP7
	.long	0

SNRIP1	.long	SNRIP1A,SNRIP1B,0
SNRIP2	.long	SNRIP2A,SNRIP2B,0
SNRIP3	.long	SNRIP3A,SNRIP3B,0
SNRIP4	.long	SNRIP4A,SNRIP4B,0
SNRIP5	.long	SNRIP5A,SNRIP5B,0
SNRIP6	.long	SNRIP6A,SNRIP6B,0
SNRIP7	.long	SNRIP7A,SNRIP7B,0

a_kano_rip
	.long	KARIP1
	.long	KARIP2
	.long	KARIP3
	.long	KARIP4
	.long	KARIP5
	.long	KARIP6
	.long	KARIP7
	.long	0

KARIP1	.long	KARIP1A,KARIP1B,0
KARIP2	.long	KARIP2A,KARIP2B,0
KARIP3	.long	KARIP3A,KARIP3B,0
KARIP4	.long	KARIP4A,KARIP4B,0
KARIP5	.long	KARIP5A,KARIP5B,0
KARIP6	.long	KARIP6A,KARIP6B,0
KARIP7	.long	KARIP7A,0


a_sg_rip
	.long	SGRIP1
	.long	SGRIP2
	.long	SGRIP3
	.long	SGRIP4
	.long	SGRIP5
	.long	SGRIP6
	.long	SGRIP7
	.long	0

SGRIP1	.long	SGRIP1A,SGRIP1B,0
SGRIP2	.long	SGRIP2A,SGRIP2B,0
SGRIP3	.long	SGRIP3A,SGRIP3B,0
SGRIP4	.long	SGRIP4A,SGRIP4B,0
SGRIP5	.long	SGRIP5A,SGRIP5B,0
SGRIP6	.long	SGRIP6A,SGRIP6B,0
SGRIP7	.long	SGRIP7A,0

a_jax_rip
	.long	JXRIP1
	.long	JXRIP2
	.long	JXRIP3
	.long	JXRIP4
	.long	JXRIP5
	.long	JXRIP6
	.long	JXRIP7
	.long	0

JXRIP1	.long	JXRIP1A,JXRIP1B,0
JXRIP2	.long	JXRIP2A,JXRIP2B,0
JXRIP3	.long	JXRIP3A,JXRIP3B,0
JXRIP4	.long	JXRIP4A,JXRIP4B,0
JXRIP5	.long	JXRIP5A,JXRIP5B,0
JXRIP6	.long	JXRIP6A,JXRIP6B,0
JXRIP7	.long	JXRIP7A,0


a_lk_rip
	.long	LURIP1
	.long	LURIP2
	.long	LURIP3
	.long	LURIP4
	.long	LURIP5
	.long	LURIP6
	.long	LURIP7
	.long	0

LURIP1	.long	LURIP1A,LURIP1B,0
LURIP2	.long	LURIP2A,LURIP2B,0
LURIP3	.long	LURIP3A,LURIP3B,0
LURIP4	.long	LURIP4A,LURIP4B,0
LURIP5	.long	LURIP5A,LURIP5B,0
LURIP6	.long	LURIP6A,LURIP6B,0
LURIP7	.long	LURIP7A,LURIP7B,0


a_st_rip
	.long	TSRIP1
	.long	TSRIP2
	.long	TSRIP3
	.long	TSRIP4
	.long	TSRIP5
	.long	TSRIP6
	.long	TSRIP7
	.long	0

TSRIP1	.long	TSRIP1A,TSRIP1B,0
TSRIP2	.long	TSRIP2A,TSRIP2B,0
TSRIP3	.long	TSRIP3A,TSRIP3B,0
TSRIP4	.long	TSRIP4A,TSRIP4B,0
TSRIP5	.long	TSRIP5A,TSRIP5B,0
TSRIP6	.long	TSRIP6A,TSRIP6B,0
TSRIP7	.long	TSRIP7A,0


a_tusk_rip
	.long	TRRIP1
	.long	TRRIP2
	.long	TRRIP3
	.long	TRRIP4
	.long	TRRIP5
	.long	TRRIP6
	.long	TRRIP7
	.long	0

TRRIP1	.long	TRRIP1A,TRRIP1B,0
TRRIP2	.long	TRRIP2A,TRRIP2B,0
TRRIP3	.long	TRRIP3A,TRRIP3B,0
TRRIP4	.long	TRRIP4A,TRRIP4B,0
TRRIP5	.long	TRRIP5A,TRRIP5B,0
TRRIP6	.long	TRRIP6A,TRRIP6B,0
TRRIP7	.long	TRRIP7A,TRRIP7B,0


a_ind_rip
	.long	INRIP1
	.long	INRIP2
	.long	INRIP3
	.long	INRIP4
	.long	INRIP5
	.long	INRIP6
	.long	INRIP7
	.long	0

INRIP1	.long	INRIP1A,INRIP1B,0
INRIP2	.long	INRIP2A,INRIP2B,0
INRIP3	.long	INRIP3A,INRIP3B,0
INRIP4	.long	INRIP4A,INRIP4B,0
INRIP5	.long	INRIP5A,INRIP5B,0
INRIP6	.long	INRIP6A,INRIP6B,0
INRIP7	.long	INRIP7A,0

a_sz_rip
	.long	SZRIP1
	.long	SZRIP2
	.long	SZRIP3
	.long	SZRIP4
	.long	SZRIP5
	.long	SZRIP6
	.long	SZRIP7
	.long	0

SZRIP1	.long	SZRIP1A,SZRIP1B,0
SZRIP2	.long	SZRIP2A,SZRIP2B,0
SZRIP3	.long	SZRIP3A,SZRIP3B,0
SZRIP4	.long	SZRIP4A,SZRIP4B,0
SZRIP5	.long	SZRIP5A,SZRIP5B,0
SZRIP6	.long	SZRIP6A,SZRIP6B,0
SZRIP7	.long	SZRIP7A,0


a_skinny_blood
	.long	SMDRIP1
	.long	SMDRIP2
	.long	SMDRIP3
	.long	0
	.long	SMDRIP4
	.long	SMDRIP5
	.long	SMDRIP6
	.long	SMDRIP7
	.long	0

	.long	SMDRIP8
	.long	SMDRIP9
	.long	0


a_hair_wrap
	.long	LILGHAIR1
	.long	LILGHAIR2
	.long	LILGHAIR3
	.long	LILGHAIR4
	.long	LILGHAIR5
	.long	LILGHAIR6
	.long	LILGHAIR7
	.long	LILGHAIR8
	.long	LILGHAIR9
	.long	LILGHAIR10
	.long	LILGHAIR11
	.long	LILGHAIR12
	.long	LILGHAIR13
	.long	0

	.long	LILGHAIR14
	.long	LILGHAIR15
	.long	LILGHAIR16
	.long	LILGHAIR17
	.long	LILGHAIR18
	.long	LILGHAIR19
	.long	LILGHAIR20
	.long	0

LILGHAIR1
	.long	LILGHAIR1A,LIABODY1A,LIABODY1B,0
LILGHAIR2
	.long	LILGHAIR2A,LILGHAIR2B,LIABODY1A,LIABODY1B,0
LILGHAIR3
	.long	LILGHAIR3A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR4
	.long	LILGHAIR4A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR5
	.long	LILGHAIR5A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR6
	.long	LILGHAIR6A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR7
	.long	LILGHAIR7A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR8
	.long	LILGHAIR8A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR9
	.long	LILGHAIR9A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR10
	.long	LILGHAIR10A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR11
	.long	LILGHAIR11A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR12
	.long	LILGHAIR12A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0
LILGHAIR13
	.long	LILGHAIR13A,LIABODY1A,LIABODY1B,LILGHAIR2A,LILGHAIR2B,0


LILGHAIR14
	.long	LILGHAIR14A,LILGHAIR14B,LILGHAIR14C,0
LILGHAIR15
	.long	LILGHAIR15A,LILGHAIR15B,LILGHAIR15C,0


LILGHAIR16
	.long	LILGHAIR16A,LILGHAIR16B
	.long	LIBODYPULL1A,LIBODYPULL1B,LIBODYPULL1C,0
LILGHAIR17
	.long	LILGHAIR17A,LILGHAIR17B,LILGHAIR17C
	.long	LIBODYPULL1A,LIBODYPULL1B,LIBODYPULL1C,0
LILGHAIR18
	.long	LILGHAIR18A,LILGHAIR18B
	.long	LIBODYPULL1A,LIBODYPULL1B,LIBODYPULL1C,0

LILGHAIR19
	.long	LILGHAIR19A
	.long	LIBODYPULL1A,LIBODYPULL1B,LIBODYPULL1C,0

LILGHAIR20
	.long	LILGHAIR20A,LILGHAIR20B,LILGHAIR20C,0

;**************************************************************************

	.end
