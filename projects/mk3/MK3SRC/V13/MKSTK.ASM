**************************************************************************
*											     *
*  video game project:	Mortal Kombat 3							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: strike tables										*
* 											     *
*  copyright (c) 1995 midway manufacturing							*
*											     *
**************************************************************************
	.file	'mkstk.asm'
	.width	132
	.option	b,d,l,t
	.mnolist
*
* get the system stuff
*
	.include	dispequ.asm
	.include	sysequ.asm
	.include	macros.hdr
	.include	mainequ.asm
	.include	imgtbl.glo
	.text

**************************************************************************
*											     *
*  get_char_stk - get a characters strike entry					     *
* 											     *
*  input: a0 = offset									     *
*         a8 = object with "ochar" set						     *
* 											     *
*  returns: a0 = correct "stk" table							     *
*											     *
**************************************************************************
get_char_stk	
	move	*a8(ochar),a1,w
	sll	5,a0
	sll	5,a1
	addi	strike_tables,a1
	move	*a1,a1,l
	add	a1,a0
	move	*a0,a0,l	; a0 = correct "stk" table
	rets

strike_tables
	.long	kano_strikes	; 0
	.long	sonya_strikes	; 1
	.long	jax_strikes	; 2
	.long	indian_strikes	; 3
	.long	sz_strikes	; 4
	.long	swat_strikes	; 5
	.long	lia_strikes	; 6
	.long	robo_strikes	; 7
	.long	robo_strikes	; 8
	.long	lao_strikes	; 9
	.long	tusk_strikes	; 10
	.long	sg_strikes	; 11
	.long	st_strikes	; 12
	.long	lk_strikes	; 13
	.long	robo_strikes	; 14 - smokey the robo ninja
	.long	mot_strikes	; 15
	.long	sk_strikes	; 16
	.long	kano_strikes	; 17
	.long	kano_strikes	; 18


sk_strikes
	.long	stk_sk_punch		; 0 - punch
	.long	stk_sk_kick		; 1 - kick
	.long	stk_sk_hammer		; 2 - hammah time !
	.long	stk_sk_charge		; 3 - charge
	.long	stk_sk_zap		; 4 - zap
	.long	stk_sk_air_charge	; 5 - air charge

stk_sk_punch
	.word	>53		; x offset of collision box
	.word	>12		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>75		; y size of collision box
	.word	>6215		; strike routine
	.word	>2206		; damage
	.word	sf_squeeze

stk_sk_kick
	.word	>6d		; x offset of collision box
	.word	>20		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>3d		; y size of collision box
	.word	>6215		; strike routine
	.word	>2706		; damage
	.word	sf_squeeze

stk_sk_hammer
	.word	>86		; x offset of collision box
	.word	>20		; y offset of collision box
	.word	>77		; x size of collision box
	.word	>39		; y size of collision box
	.word	>6315		; strike routine
	.word	>2706		; damage
	.word	sf_squeeze

stk_sk_charge
	.word	>40		; x offset of collision box
	.word	>11		; y offset of collision box
	.word	>42		; x size of collision box
	.word	>90		; y size of collision box
	.word	>6415		; strike routine
	.word	>2005		; damage
	.word	sf_squeeze

stk_sk_zap
	.word	>78		; x offset of collision box
	.word	>29		; y offset of collision box
	.word	>34		; x size of collision box
	.word	>31		; y size of collision box
	.word	>6415		; strike routine
	.word	>2306		; damage
	.word	sf_squeeze

stk_sk_air_charge
	.word	>4d		; x offset of collision box
	.word	>17		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>4a		; y size of collision box
	.word	>6515		; strike routine
	.word	>2005		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Motaro Strikes									     *
*											     *
**************************************************************************
mot_strikes
	.long	stk_mot_punch		; 0
	.long	stk_mot_kick
	.long	stk_mot_sweep
	.long	stk_mot_zap
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy


stk_mot_punch
	.word	>6b		; x offset of collision box
	.word	>12		; y offset of collision box
	.word	>5f		; x size of collision box
	.word	>75		; y size of collision box
	.word	>6015		; strike routine
	.word	>2809		; damage
	.word	sf_squeeze

stk_mot_kick
	.word	>0b		; x offset of collision box
	.word	>23		; y offset of collision box
	.word	>72		; x size of collision box
	.word	>64		; y size of collision box
	.word	>6115		; strike routine
	.word	>300d		; damage
	.word	sf_squeeze

stk_mot_sweep
	.word	>e3		; x offset of collision box
	.word	>6e		; y offset of collision box
	.word	>bd		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0403		; strike routine
	.word	>2007		; damage
	.word	sf_squeeze

stk_mot_zap
	.word	>0d		; x offset of collision box
	.word	>fff2		; y offset of collision box
	.word	>19		; x size of collision box
	.word	>1c		; y size of collision box
	.word	>6015		; strike routine
	.word	>2005		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Liu Kang strikes 									     *
*											     *
**************************************************************************
lk_strikes
	.long	stk_lk_hikick			; 0
	.long	stk_lk_lokick			; 1
	.long	stk_lk_hi_punch   		; 2
	.long	stk_lk_lo_punch   		; 3
	.long	stk_lk_sweep			; 4
	.long	stk_lk_duck_punch		; 5
	.long	stk_lk_duck_kickh		; 6
	.long	stk_lk_duck_kickl		; 7
	.long	stk_lk_uppercut   		; 8 	
	.long	stk_lk_jump_punch		; 9
	.long	stk_lk_jump_kick		; a
	.long	stk_lk_flip_kick		; d
	.long	stk_lk_flip_punch		; c
	.long	stk_lk_roundh			; d
	.long	stk_lk_knee			; e
	.long	stk_lk_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_lk_zap			; 11
	.long	stk_lk_bike			; 12
	.long	stk_super_kang			; 13
	.long	stk_dummy			; 14
	.long	stk_dummy			;
	.long	stk_dummy			;
	.long	stk_dummy			;

stk_lk_hikick
	.word	>4e		; x offset of collision box
	.word	>0e		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>2a		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_lk_lokick
	.word	>5f		; x offset of collision box
	.word	>30		; y offset of collision box
	.word	>4f		; x size of collision box
	.word	>0f		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_lk_hi_punch
	.word	>48		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>1d		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_lk_lo_punch
	.word	>54		; x offset of collision box
	.word	>20		; y offset of collision box
	.word	>41		; x size of collision box
	.word	>15		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_lk_sweep
	.word	>6a		; x offset of collision box
	.word	>6c		; y offset of collision box
	.word	>4a		; x size of collision box
	.word	>19		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_lk_duck_punch
	.word	>4d		; x offset of collision box
	.word	>49		; y offset of collision box
	.word	>3b		; x size of collision box
	.word	>10		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_lk_duck_kickh
	.word	>50		; x offset of collision box
	.word	>37		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>21		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_lk_duck_kickl
	.word	>51		; x offset of collision box
	.word	>6d		; y offset of collision box
	.word	>3c		; x size of collision box
	.word	>18		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_lk_uppercut
	.word	>46		; x offset of collision box
	.word	>fff6		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>43		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_lk_jump_punch
	.word	>55		; x offset of collision box
	.word	>05		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>28		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_lk_jump_kick
	.word	>3d		; x offset of collision box
	.word	>fffa		; y offset of collision box
	.word	>36		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_lk_flip_kick
	.word	>57		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_lk_flip_punch
	.word	>55		; x offset of collision box
	.word	>05		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>28		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_lk_roundh
	.word	>6b		; x offset of collision box
	.word	>05		; y offset of collision box
	.word	>53		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_lk_knee
	.word	>47		; x offset of collision box
	.word	>21		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>3d		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_lk_elbow
	.word	>40		; x offset of collision box
	.word	>0c		; y offset of collision box
	.word	>2e		; x size of collision box
	.word	>32		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_lk_zap
	.word	>d0		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>51		; x size of collision box
	.word	>14		; y size of collision box
	.word	>5501		; strike routine
	.word	>1603		; damage
	.word	sf_squeeze

stk_lk_bike
	.word	>42		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>41		; x size of collision box
	.word	>2a		; y size of collision box
	.word	>5600		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_super_kang
	.word	>63		; x offset of collision box
	.word	>21		; y offset of collision box
	.word	>4b		; x size of collision box
	.word	>1c		; y size of collision box
	.word	>5700		; strike routine
	.word	>1704		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Shang Tsung strikes 									     *
*											     *
**************************************************************************
st_strikes
	.long	stk_st_hikick			; 0
	.long	stk_st_lokick			; 1
	.long	stk_st_hi_punch   		; 2
	.long	stk_st_lo_punch   		; 3
	.long	stk_st_sweep			; 4
	.long	stk_st_duck_punch		; 5
	.long	stk_st_duck_kickh		; 6
	.long	stk_st_duck_kickl		; 7
	.long	stk_st_uppercut   		; 8 	
	.long	stk_st_jump_punch		; 9
	.long	stk_st_jump_kick		; a
	.long	stk_st_flip_kick		; d
	.long	stk_st_flip_punch		; c
	.long	stk_st_roundh			; d
	.long	stk_st_knee			; e
	.long	stk_st_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_st_zap			; 11
	.long	stk_summon			; 12
	.long	stk_dummy			; 13
	.long	stk_dummy			; 14
	.long	stk_dummy			;
	.long	stk_dummy			;
	.long	stk_dummy			;


stk_st_hikick
	.word	>55		; x offset of collision box
	.word	>fffb		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>31		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_st_lokick
	.word	>6a		; x offset of collision box
	.word	>27		; y offset of collision box
	.word	>53		; x size of collision box
	.word	>14		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_st_hi_punch
	.word	>54		; x offset of collision box
	.word	>03		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>1d		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_st_lo_punch
	.word	>53		; x offset of collision box
	.word	>18		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>1b		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_st_sweep
	.word	>60		; x offset of collision box
	.word	>67		; y offset of collision box
	.word	>52		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_st_duck_punch
	.word	>4d		; x offset of collision box
	.word	>37		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>10		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_st_duck_kickh
	.word	>59		; x offset of collision box
	.word	>3c		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>1c		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_st_duck_kickl
	.word	>5a		; x offset of collision box
	.word	>69		; y offset of collision box
	.word	>44		; x size of collision box
	.word	>15		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_st_uppercut
	.word	>55		; x offset of collision box
	.word	>fff2		; y offset of collision box
	.word	>3d		; x size of collision box
	.word	>40		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_st_jump_punch
	.word	>57		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>28		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_st_jump_kick
	.word	>5d		; x offset of collision box
	.word	>fff5		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>2d		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_st_flip_kick
	.word	>57		; x offset of collision box
	.word	>17		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_st_flip_punch
	.word	>57		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>28		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_st_roundh
	.word	>65		; x offset of collision box
	.word	>fff6		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>37		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_st_knee
	.word	>4a		; x offset of collision box
	.word	>21		; y offset of collision box
	.word	>36		; x size of collision box
	.word	>3d		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_st_elbow
	.word	>47		; x offset of collision box
	.word	>fffe		; y offset of collision box
	.word	>32		; x size of collision box
	.word	>30		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_st_zap
	.word	>9a		; x offset of collision box
	.word	>15		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>16		; y size of collision box
	.word	>5101		; strike routine
	.word	>0d02		; damage
	.word	sf_squeeze

stk_summon
	.word	>14		; x offset of collision box
	.word	>ff9b		; y offset of collision box
	.word	>27		; x size of collision box
	.word	>5d		; y size of collision box
	.word	>5001		; strike routine
	.word	>0803		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   She Goro strikes    									     *
*											     *
**************************************************************************
sg_strikes
	.long	stk_sg_hikick			; 0
	.long	stk_sg_lokick			; 1
	.long	stk_sg_hi_punch   		; 2
	.long	stk_sg_lo_punch   		; 3
	.long	stk_sg_sweep			; 4
	.long	stk_sg_duck_punch		; 5
	.long	stk_sg_duck_kickh		; 6
	.long	stk_sg_duck_kickl		; 7
	.long	stk_sg_uppercut   		; 8 	
	.long	stk_sg_jump_punch		; 9
	.long	stk_sg_jump_kick		; a
	.long	stk_sg_flip_kick		; d
	.long	stk_sg_flip_punch		; c
	.long	stk_sg_roundh			; d
	.long	stk_sg_knee			; e
	.long	stk_sg_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_sg_zap			; 11
	.long	stk_pounce			; 12
	.long	stk_boss_pounce			; 13
	.long	stk_dummy			; 14
	.long	stk_dummy			;
	.long	stk_dummy			;
	.long	stk_dummy			;


stk_sg_hikick
	.word	>65		; x offset of collision box
	.word	>16		; y offset of collision box
	.word	>50		; x size of collision box
	.word	>2a		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_sg_lokick
	.word	>6b		; x offset of collision box
	.word	>31		; y offset of collision box
	.word	>53		; x size of collision box
	.word	>14		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_sg_hi_punch
	.word	>52		; x offset of collision box
	.word	>12		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_sg_lo_punch
	.word	>4a		; x offset of collision box
	.word	>2b		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>1e		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_sg_sweep
	.word	>63		; x offset of collision box
	.word	>73		; y offset of collision box
	.word	>52		; x size of collision box
	.word	>21		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_sg_duck_punch
	.word	>56		; x offset of collision box
	.word	>4a		; y offset of collision box
	.word	>47		; x size of collision box
	.word	>13		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sg_duck_kickh
	.word	>5d		; x offset of collision box
	.word	>3d		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>2f		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_sg_duck_kickl
	.word	>60		; x offset of collision box
	.word	>7a		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>20		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sg_uppercut
	.word	>56		; x offset of collision box
	.word	>fff0		; y offset of collision box
	.word	>4b		; x size of collision box
	.word	>53		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_sg_jump_punch
	.word	>49		; x offset of collision box
	.word	>0a		; y offset of collision box
	.word	>3d		; x size of collision box
	.word	>2f		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sg_jump_kick
	.word	>5a		; x offset of collision box
	.word	>15		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_sg_flip_kick
	.word	>4f		; x offset of collision box
	.word	>28		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_sg_flip_punch
	.word	>49		; x offset of collision box
	.word	>0a		; y offset of collision box
	.word	>3d		; x size of collision box
	.word	>2f		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sg_roundh
	.word	>77		; x offset of collision box
	.word	>03		; y offset of collision box
	.word	>51		; x size of collision box
	.word	>38		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_sg_knee
	.word	>51		; x offset of collision box
	.word	>21		; y offset of collision box
	.word	>3c		; x size of collision box
	.word	>4a		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_sg_elbow
	.word	>4b		; x offset of collision box
	.word	>18		; y offset of collision box
	.word	>32		; x size of collision box
	.word	>30		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_sg_zap
	.word	>01		; x offset of collision box
	.word	>ffed		; y offset of collision box
	.word	>30		; x size of collision box
	.word	>26		; y size of collision box
	.word	>5c01		; strike routine
	.word	>1a03		; damage
	.word	sf_squeeze

stk_pounce
	.word	>23		; x offset of collision box
	.word	>26		; y offset of collision box
	.word	>32		; x size of collision box
	.word	>4b		; y size of collision box
	.word	>5b0e		; strike routine (unblockable)
	.word	>2020		; damage
	.word	sf_squeeze

stk_boss_pounce
	.word	>23		; x offset of collision box
	.word	>26		; y offset of collision box
	.word	>32		; x size of collision box
	.word	>4b		; y size of collision box
	.word	>5b01		; strike routine (unblockable)
	.word	>2020		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Tusk strikes    									     *
*											     *
**************************************************************************
tusk_strikes
	.long	stk_tusk_hikick			; 0
	.long	stk_tusk_lokick			; 1
	.long	stk_tusk_hi_punch   		; 2
	.long	stk_tusk_lo_punch   		; 3
	.long	stk_tusk_sweep			; 4
	.long	stk_tusk_duck_punch		; 5
	.long	stk_tusk_duck_kickh		; 6
	.long	stk_tusk_duck_kickl		; 7
	.long	stk_tusk_uppercut   		; 8 	
	.long	stk_tusk_jump_punch		; 9
	.long	stk_tusk_jump_kick		; a
	.long	stk_tusk_flip_kick		; d
	.long	stk_tusk_flip_punch		; c
	.long	stk_tusk_roundh			; d
	.long	stk_tusk_knee			; e
	.long	stk_tusk_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_tusk_zap			; 11
	.long	stk_tusk_blur			; 12
	.long	stk_tusk_saw			; 13
	.long	stk_dummy			; 14
	.long	stk_dummy			;
	.long	stk_dummy			;
	.long	stk_dummy			;

stk_tusk_hikick
	.word	>58		; x offset of collision box
	.word	>15		; y offset of collision box
	.word	>50		; x size of collision box
	.word	>2a		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_tusk_lokick
	.word	>63		; x offset of collision box
	.word	>31		; y offset of collision box
	.word	>4c		; x size of collision box
	.word	>14		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_tusk_hi_punch
	.word	>54		; x offset of collision box
	.word	>11		; y offset of collision box
	.word	>34		; x size of collision box
	.word	>21		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_tusk_lo_punch
	.word	>5f		; x offset of collision box
	.word	>28		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>15		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_tusk_sweep
	.word	>68		; x offset of collision box
	.word	>70		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>1c		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_tusk_duck_punch
	.word	>51		; x offset of collision box
	.word	>50		; y offset of collision box
	.word	>3d		; x size of collision box
	.word	>0e		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_tusk_duck_kickh
	.word	>51		; x offset of collision box
	.word	>45		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_tusk_duck_kickl
	.word	>56		; x offset of collision box
	.word	>74		; y offset of collision box
	.word	>43		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_tusk_uppercut
	.word	>47		; x offset of collision box
	.word	>00		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>43		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_tusk_jump_punch
	.word	>56		; x offset of collision box
	.word	>1c		; y offset of collision box
	.word	>34		; x size of collision box
	.word	>29		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_tusk_jump_kick
	.word	>51		; x offset of collision box
	.word	>20		; y offset of collision box
	.word	>42		; x size of collision box
	.word	>24		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_tusk_flip_kick
	.word	>5a		; x offset of collision box
	.word	>2b		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>2d		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_tusk_flip_punch
	.word	>56		; x offset of collision box
	.word	>1c		; y offset of collision box
	.word	>34		; x size of collision box
	.word	>29		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_tusk_roundh
	.word	>65		; x offset of collision box
	.word	>15		; y offset of collision box
	.word	>4d		; x size of collision box
	.word	>30		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_tusk_knee
	.word	>4a		; x offset of collision box
	.word	>3a		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>32		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_tusk_elbow
	.word	>47		; x offset of collision box
	.word	>2c		; y offset of collision box
	.word	>3b		; x size of collision box
	.word	>22		; y size of collision box
	.word	>4c07		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_tusk_zap
	.word	>31		; x offset of collision box
	.word	>ffef		; y offset of collision box
	.word	>2a		; x size of collision box
	.word	>19		; y size of collision box
	.word	>4a01		; strike routine
	.word	>1703		; damage
	.word	sf_squeeze

stk_tusk_blur
	.word	>21		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>7e		; y size of collision box
	.word	>4b00		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

stk_tusk_saw
	.word	>14		; x offset of collision box
	.word	>ffd4		; y offset of collision box
	.word	>22		; x size of collision box
	.word	>2b		; y size of collision box
	.word	>4d00		; strike routine
	.word	>1202		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Kung Lao strikes    									     *
*											     *
**************************************************************************
lao_strikes
	.long	stk_lao_hikick			; 0
	.long	stk_lao_lokick			; 1
	.long	stk_lao_hi_punch   		; 2
	.long	stk_lao_lo_punch   		; 3
	.long	stk_lao_sweep			; 4
	.long	stk_lao_duck_punch		; 5
	.long	stk_lao_duck_kickh		; 6
	.long	stk_lao_duck_kickl		; 7
	.long	stk_lao_uppercut   		; 8 	
	.long	stk_lao_jump_punch		; 9
	.long	stk_lao_jump_kick		; a
	.long	stk_lao_flip_kick		; d
	.long	stk_lao_flip_punch		; c
	.long	stk_lao_roundh			; d
	.long	stk_lao_knee			; e
	.long	stk_lao_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_lao_zap			; 11
	.long	stk_lao_angle			; 12
	.long	stk_lao_spin			; 13
	.long	stk_dummy			; 14
	.long	stk_dummy			;
	.long	stk_dummy			;
	.long	stk_dummy			;

stk_lao_hikick
	.word	>55		; x offset of collision box
	.word	>06		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>2e		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_lao_lokick
	.word	>64		; x offset of collision box
	.word	>25		; y offset of collision box
	.word	>4c		; x size of collision box
	.word	>14		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_lao_hi_punch
	.word	>4a		; x offset of collision box
	.word	>03		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>23		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_lao_lo_punch
	.word	>51		; x offset of collision box
	.word	>1b		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>1c		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_lao_sweep
	.word	>6e		; x offset of collision box
	.word	>69		; y offset of collision box
	.word	>4c		; x size of collision box
	.word	>18		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_lao_duck_punch
	.word	>4a		; x offset of collision box
	.word	>39		; y offset of collision box
	.word	>3b		; x size of collision box
	.word	>13		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_lao_duck_kickh
	.word	>4b		; x offset of collision box
	.word	>39		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>31		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_lao_duck_kickl
	.word	>57		; x offset of collision box
	.word	>69		; y offset of collision box
	.word	>43		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_lao_uppercut
	.word	>3a		; x offset of collision box
	.word	>ffef		; y offset of collision box
	.word	>34		; x size of collision box
	.word	>46		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_lao_jump_punch
	.word	>68		; x offset of collision box
	.word	>15		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>2e		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_lao_jump_kick
	.word	>52		; x offset of collision box
	.word	>0c		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>3b		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_lao_flip_kick
	.word	>4c		; x offset of collision box
	.word	>2d		; y offset of collision box
	.word	>2c		; x size of collision box
	.word	>1d		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_lao_flip_punch
	.word	>67		; x offset of collision box
	.word	>19		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>2d		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_lao_roundh
	.word	>61		; x offset of collision box
	.word	>07		; y offset of collision box
	.word	>45		; x size of collision box
	.word	>31		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_lao_knee
	.word	>40		; x offset of collision box
	.word	>21		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>30		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_lao_elbow
	.word	>3d		; x offset of collision box
	.word	>0c		; y offset of collision box
	.word	>30		; x size of collision box
	.word	>24		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_lao_zap
	.word	>54		; x offset of collision box
	.word	>24		; y offset of collision box
	.word	>2a		; x size of collision box
	.word	>29		; y size of collision box
	.word	>4504		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_lao_angle
	.word	>56		; x offset of collision box
	.word	>34		; y offset of collision box
	.word	>2d		; x size of collision box
	.word	>09		; y size of collision box
	.word	>4600		; strike routine
	.word	>0f02		; damage
	.word	sf_squeeze

stk_lao_spin
	.word	>28		; x offset of collision box
	.word	>fff9		; y offset of collision box
	.word	>3c		; x size of collision box
	.word	>52		; y size of collision box
	.word	>0801		; strike routine
	.word	>1603		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Robo strikes    									     *
*											     *
**************************************************************************
robo_strikes
	.long	stk_ro_hikick			; 0
	.long	stk_ro_lokick			; 1
	.long	stk_ro_hi_punch			; 2
	.long	stk_ro_lo_punch			; 3
	.long	stk_ro_sweep			; 4
	.long	stk_ro_duck_punch		; 5
	.long	stk_ro_duck_kickh		; 6
	.long	stk_ro_duck_kickl		; 7
	.long	stk_ro_uppercut			; 8 	
	.long	stk_ro_jump_punch		; 9
	.long	stk_ro_jump_kick		; a
	.long	stk_ro_flip_kick		; d
	.long	stk_ro_flip_punch		; c
	.long	stk_ro_roundh			; d
	.long	stk_ro_knee			; e
	.long	stk_ro_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_ro_net			; 11
	.long	stk_ro_zap			; 12
	.long	stk_ro_tele			; 13
	.long	stk_ro_bomb			; 14
	.long	stk_spear			; 15

stk_ro_hikick
	.word	>5f		; x offset of collision box
	.word	>0d		; y offset of collision box
	.word	>47		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_ro_lokick
	.word	>6a		; x offset of collision box
	.word	>30		; y offset of collision box
	.word	>47		; x size of collision box
	.word	>10		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_ro_hi_punch
	.word	>4b		; x offset of collision box
	.word	>0e		; y offset of collision box
	.word	>36		; x size of collision box
	.word	>21		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_ro_lo_punch
	.word	>46		; x offset of collision box
	.word	>23		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>1f		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_ro_sweep
	.word	>6a		; x offset of collision box
	.word	>6b		; y offset of collision box
	.word	>4f		; x size of collision box
	.word	>21		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_ro_duck_punch
	.word	>44		; x offset of collision box
	.word	>3f		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>13		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_ro_duck_kickh
	.word	>48		; x offset of collision box
	.word	>3a		; y offset of collision box
	.word	>3d		; x size of collision box
	.word	>38		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_ro_duck_kickl
	.word	>60		; x offset of collision box
	.word	>70		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>17		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_ro_uppercut
	.word	>3c		; x offset of collision box
	.word	>fffa		; y offset of collision box
	.word	>38		; x size of collision box
	.word	>4a		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_ro_jump_punch
	.word	>4b		; x offset of collision box
	.word	>11		; y offset of collision box
	.word	>32		; x size of collision box
	.word	>31		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_ro_jump_kick
	.word	>4b		; x offset of collision box
	.word	>fff6		; y offset of collision box
	.word	>45		; x size of collision box
	.word	>49		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_ro_flip_kick
	.word	>50		; x offset of collision box
	.word	>2d		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>23		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_ro_flip_punch
	.word	>4b		; x offset of collision box
	.word	>11		; y offset of collision box
	.word	>32		; x size of collision box
	.word	>31		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_ro_roundh
	.word	>68		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>4a		; x size of collision box
	.word	>33		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_ro_knee
	.word	>47		; x offset of collision box
	.word	>2c		; y offset of collision box
	.word	>30		; x size of collision box
	.word	>3f		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_ro_elbow
	.word	>3d		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>36		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_ro_zap
	.word	>10		; x offset of collision box
	.word	>fff1		; y offset of collision box
	.word	>23		; x size of collision box
	.word	>1f		; y size of collision box
	.word	>3b04		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_ro_net
	.word	>37		; x offset of collision box
	.word	>ffe0		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>4a		; y size of collision box
	.word	>3c00		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

stk_ro_tele
	.word	>49		; x offset of collision box
	.word	>fff7		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>57		; y size of collision box
	.word	>3d00		; strike routine
	.word	>1002		; damage
	.word	sf_squeeze

stk_ro_bomb
	.word	>2f		; x offset of collision box
	.word	>ffb8		; y offset of collision box
	.word	>53		; x size of collision box
	.word	>57		; y size of collision box
	.word	>3e09		; strike routine
	.word	>1212		; damage
	.word	0

stk_spear
	.word	>147		; x offset of collision box
	.word	>ffff		; y offset of collision box
	.word	>50		; x size of collision box
	.word	>10		; y size of collision box
	.word	>3f00		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Lia guy strikes    									     *
*											     *
**************************************************************************
lia_strikes
	.long	stk_li_hikick			; 0
	.long	stk_li_lokick			; 1
	.long	stk_li_hi_punch			; 2
	.long	stk_li_lo_punch			; 3
	.long	stk_li_sweep			; 4
	.long	stk_li_duck_punch		; 5
	.long	stk_li_duck_kickh		; 6
	.long	stk_li_duck_kickl		; 7
	.long	stk_li_uppercut			; 8 	
	.long	stk_li_jump_punch		; 9
	.long	stk_li_jump_kick		; a
	.long	stk_li_flip_kick		; d
	.long	stk_li_flip_punch		; c
	.long	stk_li_roundh			; d
	.long	stk_li_knee			; e
	.long	stk_li_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_li_scream			; 11
	.long	stk_li_angle_zap 		; 12
	.long	stk_li_angle_zap2 		; 13
	.long	stk_li_angle_zap3 		; 14
	.long	stk_li_forward			; 15

stk_li_hikick
	.word	>59		; x offset of collision box
	.word	>0b		; y offset of collision box
	.word	>47		; x size of collision box
	.word	>2d		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_li_lokick
	.word	>5f		; x offset of collision box
	.word	>2f		; y offset of collision box
	.word	>42		; x size of collision box
	.word	>0f		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_li_hi_punch
	.word	>54		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>2f		; x size of collision box
	.word	>23		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_li_lo_punch
	.word	>54		; x offset of collision box
	.word	>26		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>16		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_li_sweep
	.word	>6b		; x offset of collision box
	.word	>66		; y offset of collision box
	.word	>4c		; x size of collision box
	.word	>21		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_li_duck_punch
	.word	>4d		; x offset of collision box
	.word	>49		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>13		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_li_duck_kickh
	.word	>59		; x offset of collision box
	.word	>40		; y offset of collision box
	.word	>47		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_li_duck_kickl
	.word	>59		; x offset of collision box
	.word	>72		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>18		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_li_uppercut
	.word	>4a		; x offset of collision box
	.word	>fff3		; y offset of collision box
	.word	>34		; x size of collision box
	.word	>47		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_li_jump_punch
	.word	>55		; x offset of collision box
	.word	>06		; y offset of collision box
	.word	>2f		; x size of collision box
	.word	>2b		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_li_jump_kick
	.word	>4f		; x offset of collision box
	.word	>fff8		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>48		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_li_flip_kick
	.word	>59		; x offset of collision box
	.word	>1a		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>33		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_li_flip_punch
	.word	>56		; x offset of collision box
	.word	>0c		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>2a		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_li_roundh
	.word	>4a		; x offset of collision box
	.word	>01		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>39		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_li_knee
	.word	>51		; x offset of collision box
	.word	>22		; y offset of collision box
	.word	>2f		; x size of collision box
	.word	>3a		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_li_elbow
	.word	>4c		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>2d		; x size of collision box
	.word	>2c		; y size of collision box

;	.word	>0907		; strike routine
	.word	>4c07		; strike routine

	.word	>1003		; damage
	.word	sf_squeeze

stk_li_angle_zap
	.word	>53		; x offset of collision box
	.word	>30		; y offset of collision box
	.word	>25		; x size of collision box
	.word	>25		; y size of collision box
	.word	>3704		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_li_scream
	.word	>9a		; x offset of collision box
	.word	>08		; y offset of collision box
	.word	>6a		; x size of collision box
	.word	>42		; y size of collision box
	.word	>3608		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

stk_li_angle_zap2
	.word	>7d		; x offset of collision box
	.word	>51		; y offset of collision box
	.word	>2a		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>3704		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_li_angle_zap3
	.word	>85		; x offset of collision box
	.word	>5b		; y offset of collision box
	.word	>2f		; x size of collision box
	.word	>2b		; y size of collision box
	.word	>3704		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_li_forward
	.word	>72		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>2d		; x size of collision box
	.word	>11		; y size of collision box
	.word	>3704		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Swat guy strikes    									     *
*											     *
**************************************************************************
swat_strikes
	.long	stk_sw_hikick			; 0
	.long	stk_sw_lokick			; 1
	.long	stk_sw_hi_punch			; 2
	.long	stk_sw_lo_punch			; 3
	.long	stk_sw_sweep			; 4
	.long	stk_sw_duck_punch		; 5
	.long	stk_sw_duck_kickh		; 6
	.long	stk_sw_duck_kickl		; 7
	.long	stk_sw_uppercut			; 8 	
	.long	stk_sw_jump_punch		; 9
	.long	stk_sw_jump_kick		; a
	.long	stk_sw_flip_kick		; d
	.long	stk_sw_flip_punch		; c
	.long	stk_sw_roundh			; d
	.long	stk_sw_knee			; e
	.long	stk_sw_elbow			; f
	.long	stk_sw_bomb			; 10
	.long	stk_dummy			; 11
	.long	stk_sw_zap			; 12
	.long	stk_sw_prezap1			; 13
	.long	stk_sw_prezap2			; 14
	.long	stk_sw_zoom			; 15
	.long	stk_sw_diag_zap2		; 16
	.long	stk_sw_stick_sweep		; 17

stk_sw_hikick
	.word	>5f		; x offset of collision box
	.word	>0d		; y offset of collision box
	.word	>51		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_sw_lokick
	.word	>67		; x offset of collision box
	.word	>31		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>10		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_sw_hi_punch
	.word	>58		; x offset of collision box
	.word	>0d		; y offset of collision box
	.word	>35  		; x size of collision box
	.word	>24  		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_sw_lo_punch
	.word	>50		; x offset of collision box
	.word	>20		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>14		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_sw_sweep
	.word	>6d		; x offset of collision box
	.word	>66		; y offset of collision box
	.word	>4b		; x size of collision box
	.word	>24		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_sw_duck_punch
	.word	>4d		; x offset of collision box
	.word	>46		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>13		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sw_duck_kickh
	.word	>51		; x offset of collision box
	.word	>3a		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>31		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_sw_duck_kickl
	.word	>5d		; x offset of collision box
	.word	>6f		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>1f		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sw_uppercut
	.word	>4e		; x offset of collision box
	.word	>fff6		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>4d		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_sw_jump_punch
	.word	>5a		; x offset of collision box
	.word	>11		; y offset of collision box
	.word	>3d		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sw_jump_kick
	.word	>4e		; x offset of collision box
	.word	>02		; y offset of collision box
	.word	>3c		; x size of collision box
	.word	>48		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_sw_flip_kick
	.word	>5d		; x offset of collision box
	.word	>1d		; y offset of collision box
	.word	>41		; x size of collision box
	.word	>36		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_sw_flip_punch
	.word	>5a		; x offset of collision box
	.word	>11		; y offset of collision box
	.word	>3d		; x size of collision box
	.word	>2c		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sw_roundh
	.word	>6d		; x offset of collision box
	.word	>fff7		; y offset of collision box
	.word	>48		; x size of collision box
	.word	>3b		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_sw_knee
	.word	>4e		; x offset of collision box
	.word	>27		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>36		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_sw_elbow
	.word	>41		; x offset of collision box
	.word	>0d		; y offset of collision box
	.word	>2c		; x size of collision box
	.word	>28		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_sw_zap
	.word	>e9		; x offset of collision box
	.word	>2b		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>13		; y size of collision box
	.word	>3004		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_sw_prezap1
	.word	>87		; x offset of collision box
	.word	>2b		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>13		; y size of collision box
	.word	>3004		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_sw_prezap2
	.word	>ad		; x offset of collision box
	.word	>2b		; y offset of collision box
	.word	>5b		; x size of collision box
	.word	>13		; y size of collision box
	.word	>3004		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_sw_diag_zap1
	.word	>5f		; x offset of collision box
	.word	>ffe4		; y offset of collision box
	.word	>2b		; x size of collision box
	.word	>30		; y size of collision box
	.word	>3000		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_sw_diag_zap2
	.word	>8c		; x offset of collision box
	.word	>ffbc		; y offset of collision box
	.word	>2b		; x size of collision box
	.word	>30		; y size of collision box
	.word	>3000		; strike routine
	.word	>1402		; damage
	.word	sf_squeeze

stk_sw_bomb
	.word	>17		; x offset of collision box
	.word	>ffed		; y offset of collision box
	.word	>2d		; x size of collision box
	.word	>25		; y size of collision box
	.word	>3104		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_sw_zoom
	.word	>fff2		; x offset of collision box
	.word	>1c		; y offset of collision box
	.word	>28		; x size of collision box
	.word	>24		; y size of collision box
	.word	>3200		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

stk_sw_stick_sweep
	.word	>83		; x offset of collision box
	.word	>64		; y offset of collision box
	.word	>74		; x size of collision box
	.word	>04		; y size of collision box
	.word	>3303		; strike routine
	.word	>1a04		; damage
	.word	sf_duck

**************************************************************************
*											     *
*   subzero strikes    									     *
*											     *
**************************************************************************
sz_strikes
	.long	stk_sz_hikick			; 0
	.long	stk_sz_lokick			; 1
	.long	stk_sz_hi_punch			; 2
	.long	stk_sz_lo_punch			; 3
	.long	stk_sz_sweep			; 4
	.long	stk_sz_duck_punch		; 5
	.long	stk_sz_duck_kickh		; 6
	.long	stk_sz_duck_kickl		; 7
	.long	stk_sz_uppercut			; 8 	
	.long	stk_sz_jump_punch		; 9
	.long	stk_sz_jump_kick		; a
	.long	stk_sz_flip_kick		; d
	.long	stk_sz_flip_punch		; c
	.long	stk_sz_roundh			; d
	.long	stk_sz_knee			; e
	.long	stk_sz_elbow			; f
	.long	stk_sz_slide			; 10
	.long	stk_dummy			; 11
	.long	stk_sz_zap			; 12
	.long	stk_sz_forward_zap		; 13
	.long	stk_dummy			; 14
	.long	stk_dummy			; 15
	.long	stk_dummy			; 16
	.long	stk_dummy			; 17


stk_sz_hikick
	.word	>68		; x offset of collision box
	.word	>0a		; y offset of collision box
	.word	>4e		; x size of collision box
	.word	>2b		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_sz_lokick
	.word	>6f		; x offset of collision box
	.word	>2e		; y offset of collision box
	.word	>4d		; x size of collision box
	.word	>0f		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_sz_hi_punch
	.word	>52		; x offset of collision box
	.word	>06		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>25		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
 	.word	sf_squeeze

stk_sz_lo_punch
	.word	>57		; x offset of collision box
	.word	>1c		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>1c		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_sz_sweep
	.word	>65		; x offset of collision box
	.word	>67		; y offset of collision box
	.word	>52		; x size of collision box
	.word	>1f		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_sz_duck_punch
	.word	>46		; x offset of collision box
	.word	>3c		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>18		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sz_duck_kickh
	.word	>49		; x offset of collision box
	.word	>35		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>31		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_sz_duck_kickl
	.word	>5e		; x offset of collision box
	.word	>60		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>24		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sz_uppercut
	.word	>51		; x offset of collision box
	.word	>ffee		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>48		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_sz_jump_punch
	.word	>65		; x offset of collision box
	.word	>fff4		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sz_jump_kick
	.word	>60		; x offset of collision box
	.word	>ffef		; y offset of collision box
	.word	>4c		; x size of collision box
	.word	>42		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_sz_flip_kick
	.word	>64		; x offset of collision box
	.word	>1a		; y offset of collision box
	.word	>41		; x size of collision box
	.word	>29		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_sz_flip_punch
	.word	>65		; x offset of collision box
	.word	>00		; y offset of collision box
	.word	>34		; x size of collision box
	.word	>35		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sz_roundh
	.word	>5a		; x offset of collision box
	.word	>00		; y offset of collision box
	.word	>48		; x size of collision box
	.word	>36		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_sz_knee
	.word	>41		; x offset of collision box
	.word	>20		; y offset of collision box
	.word	>32		; x size of collision box
	.word	>35		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_sz_elbow
	.word	>3e		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>2b		; x size of collision box
	.word	>24		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_sz_zap
	.word	>17		; x offset of collision box
	.word	>3f		; y offset of collision box
	.word	>30		; x size of collision box
	.word	>7e		; y size of collision box
	.word	>2c05		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

stk_sz_slide
	.word	>59		; x offset of collision box
	.word	>65		; y offset of collision box
	.word	>55		; x size of collision box
	.word	>22		; y size of collision box
	.word	>2d00		; strike routine
	.word	>0d03		; damage
	.word	sf_squeeze

stk_sz_forward_zap
	.word	>82		; x offset of collision box
	.word	>fff5		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>06		; y size of collision box
	.word	>2c05		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   indian strikes    									     *
*											     *
**************************************************************************
indian_strikes
	.long	stk_ind_hikick			; 0
	.long	stk_ind_lokick			; 1
	.long	stk_ind_hi_punch		; 2
	.long	stk_ind_lo_punch		; 3
	.long	stk_ind_sweep			; 4
	.long	stk_ind_duck_punch		; 5
	.long	stk_ind_duck_kickh		; 6
	.long	stk_ind_duck_kickl		; 7
	.long	stk_ind_uppercut		; 8 	
	.long	stk_ind_jump_punch		; 9
	.long	stk_ind_jump_kick		; a
	.long	stk_ind_flip_kick		; d
	.long	stk_ind_flip_punch		; c
	.long	stk_ind_roundh			; d
	.long	stk_ind_knee			; e
	.long	stk_ind_elbow			; f
	.long	stk_dummy			; 10
	.long	stk_ind_charge			; 11
	.long	stk_ind_zap			; 12
	.long	stk_axe_horz			; 13
	.long	stk_dummy			; 14
	.long	stk_axe_up			; 15
	.long	stk_dummy			; 16
	.long	stk_dummy			; 17


stk_ind_hikick
	.word	>64		; x offset of collision box
	.word	>07		; y offset of collision box
	.word	>53		; x size of collision box
	.word	>2f		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_ind_lokick
	.word	>6a		; x offset of collision box
	.word	>2e		; y offset of collision box
	.word	>4d		; x size of collision box
	.word	>13		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_ind_hi_punch
	.word	>4b		; x offset of collision box
	.word	>0b		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>25		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
	.word	sf_squeeze

stk_ind_lo_punch
	.word	>45+4		; x offset of collision box
	.word	>1f		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_ind_sweep
	.word	>6d+4		; x offset of collision box
	.word	>68		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>21		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_ind_duck_punch
	.word	>45+4		; x offset of collision box
	.word	>41		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>1d		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_ind_duck_kickh
	.word	>3b+4		; x offset of collision box
	.word	>33		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>3c		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_ind_duck_kickl
	.word	>5e+4		; x offset of collision box
	.word	>66		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>20		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_ind_uppercut
	.word	>3e		; x offset of collision box
	.word	>fff3		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>4b		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_ind_jump_punch
	.word	>4d		; x offset of collision box
	.word	>19		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>2b		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_ind_jump_kick
	.word	>52+4		; x offset of collision box
	.word	>04		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>47		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_ind_flip_kick
	.word	>52+4		; x offset of collision box
	.word	>1b		; y offset of collision box
	.word	>3c		; x size of collision box
	.word	>37		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_ind_flip_punch
	.word	>49+4		; x offset of collision box
	.word	>19		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_ind_roundh
	.word	>53		; x offset of collision box
	.word	>0a		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>34		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_ind_knee
	.word	>45		; x offset of collision box
	.word	>3a		; y offset of collision box
	.word	>44		; x size of collision box
	.word	>35		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_ind_elbow
	.word	>43		; x offset of collision box
	.word	>14		; y offset of collision box
	.word	>2b		; x size of collision box
	.word	>16		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_ind_zap
	.word	>74		; x offset of collision box
	.word	>24		; y offset of collision box
	.word	>4c		; x size of collision box
	.word	>12		; y size of collision box
	.word	>2805		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_ind_charge
	.word	>34		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>28		; y size of collision box
	.word	>2901		; strike routine
	.word	>1804		; damage
	.word	sf_squeeze

stk_axe_horz
	.word	>5d		; x offset of collision box
	.word	>22		; y offset of collision box
	.word	>47		; x size of collision box
	.word	>16		; y size of collision box
	.word	>2a01		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_axe_up
	.word	>58		; x offset of collision box
	.word	>fffe		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>3e		; y size of collision box
	.word	>2b01		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   jax strikes    									     *
*											     *
**************************************************************************
jax_strikes
	.long	stk_jax_hikick			; 0
	.long	stk_jax_lokick			; 1
	.long	stk_jax_hi_punch		; 2
	.long	stk_jax_lo_punch		; 3
	.long	stk_jax_sweep			; 4
	.long	stk_jax_duck_punch		; 5
	.long	stk_jax_duck_kickh		; 6
	.long	stk_jax_duck_kickl		; 7
	.long	stk_jax_uppercut		; 8 	
	.long	stk_jax_jump_punch		; 9
	.long	stk_jax_jump_kick		; a
	.long	stk_jax_flip_kick		; d
	.long	stk_jax_flip_punch		; c
	.long	stk_jax_roundh			; d
	.long	stk_jax_knee			; e
	.long	stk_jax_elbow			; f
	.long	stk_jax_dash			; 10
	.long	stk_dummy			; 11
	.long	stk_jax_zap			; 12
	.long	stk_jax_prezap			; 13
	.long	stk_noogy			; 14

stk_jax_hikick
	.word	>5f		; x offset of collision box
	.word	>1e		; y offset of collision box
	.word	>51		; x size of collision box
	.word	>2e		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_jax_lokick
	.word	>69		; x offset of collision box
	.word	>39		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>14		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_jax_hi_punch
	.word	>50		; x offset of collision box
	.word	>1a		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>20		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
	.word	sf_squeeze

stk_jax_lo_punch
	.word	>4e		; x offset of collision box
	.word	>2d		; y offset of collision box
	.word	>3e		; x size of collision box
	.word	>1d		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_jax_sweep
	.word	>65		; x offset of collision box
	.word	>7a		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>1f		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_jax_duck_punch
	.word	>51		; x offset of collision box
	.word	>48		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>1d		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_jax_duck_kickh
	.word	>3c		; x offset of collision box
	.word	>55		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>42		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_jax_duck_kickl
	.word	>63		; x offset of collision box
	.word	>78		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>20		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_jax_uppercut
	.word	>4b		; x offset of collision box
	.word	>fff8		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>4c		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_jax_jump_punch
	.word	>58		; x offset of collision box
	.word	>12		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>39		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_jax_jump_kick
	.word	>47		; x offset of collision box
	.word	>0f		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>47		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_jax_flip_kick
	.word	>58		; x offset of collision box
	.word	>31		; y offset of collision box
	.word	>42		; x size of collision box
	.word	>29		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_jax_flip_punch
	.word	>47		; x offset of collision box
	.word	>0f		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>47		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_jax_roundh
	.word	>53		; x offset of collision box
	.word	>09		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>36		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_jax_knee
	.word	>52		; x offset of collision box
	.word	>2e		; y offset of collision box
	.word	>30		; x size of collision box
	.word	>37		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_jax_elbow
	.word	>41		; x offset of collision box
	.word	>13		; y offset of collision box
	.word	>36		; x size of collision box
	.word	>29		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_jax_zap
	.word	>73		; x offset of collision box
	.word	>36		; y offset of collision box
	.word	>5c		; x size of collision box
	.word	>10		; y size of collision box
	.word	>2304		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_jax_prezap
	.word	>4f		; x offset of collision box
	.word	>2f		; y offset of collision box
	.word	>4a		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>2304		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_noogy
	.word	>60 		; x offset of collision box
	.word	>0c		; y offset of collision box
	.word	>36		; x size of collision box
	.word	>28		; y size of collision box
	.word	>0d00		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

stk_jax_dash
	.word	>5d		; x offset of collision box
	.word	>24		; y offset of collision box
	.word	>44		; x size of collision box
	.word	>16		; y size of collision box
	.word	>2401		; strike routine
	.word	>1603		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Sonya strikes    									     *
*											     *
**************************************************************************
sonya_strikes
	.long	stk_sonya_hikick		; 0
	.long	stk_sonya_lokick		; 1
	.long	stk_sonya_hi_punch		; 2
	.long	stk_sonya_lo_punch		; 3
	.long	stk_sonya_sweep			; 4
	.long	stk_sonya_duck_punch		; 5
	.long	stk_sonya_duck_kickh		; 6
	.long	stk_sonya_duck_kickl		; 7
	.long	stk_sonya_uppercut		; 8 	
	.long	stk_sonya_jump_punch		; 9
	.long	stk_sonya_jump_kick		; a
	.long	stk_sonya_flip_kick		; d
	.long	stk_sonya_flip_punch		; c
	.long	stk_sonya_roundh		; d
	.long	stk_sonya_knee			; e
	.long	stk_sonya_elbow			; f
	.long	stk_sonya_leg			; 10
	.long	stk_sonya_square		; 11
	.long	stk_sonya_zap			; 12
	.long	stk_sonya_prezap		; 13
	.long	stk_sonya_bike			; 14

; 1. new stk table entry
; 2. set hit/block offsets
; 3. set hit/block damage

stk_sonya_hikick
	.word	>4b+8		; x offset of collision box
	.word	>0f		; y offset of collision box
	.word	>44		; x size of collision box
	.word	>2e		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_sonya_lokick
	.word	>52+8		; x offset of collision box
	.word	>30		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>1f		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_sonya_duck_punch
	.word	>39+8		; x offset of collision box
	.word	>40		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>22		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sonya_duck_kickh
	.word	>47+8		; x offset of collision box
	.word	>33		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>3e		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_sonya_duck_kickl
	.word	>62+8		; x offset of collision box
	.word	>6d		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>1e		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_sonya_uppercut
	.word	>4e		; x offset of collision box
	.word	>fff9		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>43		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_sonya_elbow
	.word	>3d+8		; x offset of collision box
	.word	>13		; y offset of collision box
	.word	>29		; x size of collision box
	.word	>27		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_sonya_knee
	.word	>40+8		; x offset of collision box
	.word	>2e		; y offset of collision box
	.word	>2b		; x size of collision box
	.word	>37		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_sonya_roundh
	.word	>48+8		; x offset of collision box
	.word	>0d		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>10		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_sonya_sweep
	.word	>5d+8		; x offset of collision box
	.word	>6e		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>1b		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_sonya_flip_kick
	.word	>41+8		; x offset of collision box
	.word	>23		; y offset of collision box
	.word	>42		; x size of collision box
	.word	>22		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_sonya_flip_punch
	.word	>3e+8		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>31		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sonya_jump_punch
	.word	>3e+8		; x offset of collision box
	.word	>10		; y offset of collision box
	.word	>31		; x size of collision box
	.word	>31		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_sonya_jump_kick
	.word	>3e+8		; x offset of collision box
	.word	>15		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>3f		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_sonya_hi_punch
	.word	>41		; x offset of collision box
	.word	>12		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>1e		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
	.word	sf_squeeze

stk_sonya_lo_punch
	.word	>48		; x offset of collision box
	.word	>28		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>13		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_sonya_leg
	.word	>6b+8		; x offset of collision box
	.word	>22		; y offset of collision box
	.word	>48		; x size of collision box
	.word	>4d		; y size of collision box
	.word	>0d00		; strike routine
	.word	>0000		; damage
	.word	sf_duck

stk_sonya_square
	.word	>46		; x offset of collision box
	.word	>0f		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>34		; y size of collision box
	.word	>1d00		; strike routine
	.word	>1b08		; damage
	.word	sf_squeeze

stk_sonya_zap
	.word	>6c		; x offset of collision box
	.word	>23		; y offset of collision box
	.word	>24		; x size of collision box
	.word	>0b		; y size of collision box
	.word	>1e04		; strike routine
	.word	>1303		; damage
	.word	sf_squeeze

stk_sonya_prezap
	.word	>4d		; x offset of collision box
	.word	>23		; y offset of collision box
	.word	>2f		; x size of collision box
	.word	>1b		; y size of collision box
	.word	>1e04		; strike routine
	.word	>1303		; damage
	.word	sf_squeeze

stk_sonya_bike
	.word	>36		; x offset of collision box
	.word	>03		; y offset of collision box
	.word	>39		; x size of collision box
	.word	>35		; y size of collision box
	.word	>0d01		; strike routine
	.word	>1603		; damage
	.word	sf_squeeze

**************************************************************************
*											     *
*   Kano strikes										     *
*											     *
**************************************************************************
kano_strikes
	.long	stk_kano_hikick		; 0
	.long	stk_kano_lokick		; 1
	.long	stk_kano_hi_punch	; 2
	.long	stk_kano_lo_punch	; 3
	.long	stk_kano_sweep		; 4
	.long	stk_kano_duck_punch	; 5
	.long	stk_kano_duck_kickh	; 6
	.long	stk_kano_duck_kickl	; 7
	.long	stk_kano_uppercut	; 8
	.long	stk_kano_jump_punch	; 9
	.long	stk_kano_jump_kick	; a
	.long	stk_kano_flip_kick	; d
	.long	stk_kano_flip_punch	; c
	.long	stk_kano_roundh		; d
	.long	stk_kano_knee		; e
	.long	stk_kano_elbow		; f
	.long	stk_kano_shake		;10
	.long	0			;11
	.long	stk_kano_swipe		;12
	.long	stk_kano_roll		;13 - kano ball roll
	.long	stk_kano_prezap		;14
	.long	stk_kano_zap		;15

; 1. new stk table entry
; 2. set hit/block offsets
; 3. set hit/block damage

stk_kano_hikick
	.word	>59		; x offset of collision box
	.word	>0d		; y offset of collision box
	.word	>40		; x size of collision box
	.word	>29		; y size of collision box
	.word	>0006		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_kano_lokick
	.word	>6d		; x offset of collision box
	.word	>2a		; y offset of collision box
	.word	>49		; x size of collision box
	.word	>12		; y size of collision box
	.word	>0106		; strike routine
	.word	>1504		; damage
	.word	sf_squeeze

stk_kano_duck_punch
	.word	>56		; x offset of collision box
	.word	>44		; y offset of collision box
	.word	>3a		; x size of collision box
	.word	>15		; y size of collision box
	.word	>050a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_kano_duck_kickh
	.word	>3a		; x offset of collision box
	.word	>34		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>39		; y size of collision box
	.word	>060b		; strike routine
	.word	>0c03		; damage
	.word	sf_squeeze

stk_kano_duck_kickl
	.word	>5c		; x offset of collision box
	.word	>6d		; y offset of collision box
	.word	>46		; x size of collision box
	.word	>20		; y size of collision box
	.word	>070a		; strike routine
	.word	>0602		; damage
	.word	sf_squeeze

stk_kano_uppercut
	.word	>4d		; x offset of collision box
	.word	>fff7		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>46		; y size of collision box
	.word	>0802		; strike routine
	.word	>2409		; damage
	.word	sf_squeeze

stk_kano_elbow
	.word	>41		; x offset of collision box
	.word	>04		; y offset of collision box
	.word	>29		; x size of collision box
	.word	>2d		; y size of collision box
	.word	>0907		; strike routine
	.word	>1003		; damage
	.word	sf_squeeze

stk_kano_knee
	.word	>53		; x offset of collision box
	.word	>26		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>38		; y size of collision box
	.word	>0907		; strike routine
	.word	>1203		; damage
	.word	sf_squeeze

stk_kano_roundh
	.word	>59		; x offset of collision box
	.word	>06		; y offset of collision box
	.word	>37		; x size of collision box
	.word	>36		; y size of collision box
	.word	>0c01		; strike routine
	.word	>1d04		; damage
	.word	sf_squeeze

stk_kano_sweep
	.word	>6c		; x offset of collision box
	.word	>6d		; y offset of collision box
	.word	>4f		; x size of collision box
	.word	>22		; y size of collision box
	.word	>0403		; strike routine
	.word	>1403		; damage
	.word	sf_duck

stk_kano_flip_kick
	.word	>57		; x offset of collision box
	.word	>2e		; y offset of collision box
	.word	>42		; x size of collision box
	.word	>24		; y size of collision box
	.word	>0a01		; strike routine
	.word	>1a07		; damage
	.word	sf_squeeze

stk_kano_flip_punch
	.word	>4d		; x offset of collision box
	.word	>1f		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>24		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_kano_jump_punch
	.word	>4d		; x offset of collision box
	.word	>1f		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>24		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1005		; damage
	.word	sf_squeeze

stk_kano_jump_kick
	.word	>55		; x offset of collision box
	.word	>24		; y offset of collision box
	.word	>48		; x size of collision box
	.word	>1a		; y size of collision box
	.word	>0b01		; strike routine
	.word	>1306		; damage
	.word	sf_squeeze

stk_kano_hi_punch
	.word	>49		; x offset of collision box
	.word	>0e		; y offset of collision box
	.word	>35		; x size of collision box
	.word	>22		; y size of collision box
	.word	>0211		; strike routine
	.word	>0b03		; damage
	.word	sf_squeeze

stk_kano_lo_punch
	.word	>4f		; x offset of collision box
	.word	>1d		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>1d		; y size of collision box
	.word	>0311		; strike routine
	.word	>0802		; damage
	.word	sf_squeeze

stk_kano_swipe
	.word	>6d		; x offset of collision box
	.word	>14		; y offset of collision box
	.word	>4b		; x size of collision box
	.word	>43		; y size of collision box
	.word	>1c01		; strike routine
	.word	>1a03		; damage
	.word	sf_squeeze

stk_kano_roll
	.word	>39		; x offset of collision box
	.word	>0e		; y offset of collision box
	.word	>48		; x size of collision box
	.word	>1f		; y size of collision box
	.word	>1a00		; strike routine
	.word	>1805		; damage
	.word	sf_squeeze

stk_kano_zap
	.word	>23		; x offset of collision box
	.word	->18		; y offset of collision box
	.word	>33		; x size of collision box
	.word	>32		; y size of collision box
	.word	>1b04		; strike routine
	.word	>1303		; damage
	.word	sf_squeeze

stk_kano_prezap
	.word	>6b		; x offset of collision box
	.word	>04		; y offset of collision box
	.word	>4a		; x size of collision box
	.word	>1e		; y size of collision box
	.word	>1704		; strike routine
	.word	>1303		; damage
	.word	sf_squeeze

stk_kano_shake
	.word	>65		; x offset of collision box
	.word	>20		; y offset of collision box
	.word	>3f		; x size of collision box
	.word	>11		; y size of collision box
	.word	>0d00		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

;*************************************************************************
;*************************************************************************

combo_strike_table
	.long	stk_combo0	; 0
	.long	stk_combo1	; 1
	.long	stk_combo2	; 2
	.long	stk_combo3	; 3
	.long	stk_combo4  	; 4
	.long	stk_combo5  	; 5
	.long	stk_combo_klang	; 6
	.long	stk_combo1_stab	; 7
	.long	stk_combo2_stab	; 8
	.long	stk_combo6  	; 9

	.long	stk_combo0	; a - not used
	.long	stk_combo0	; b - not used
	.long	stk_combo0	; c - not used
	.long	stk_combo0	; d - not used
	.long	stk_combo0	; e - not used
	.long	stk_combo0	; f - not used

	.long	stk_hard_combo0	; 10
	.long	stk_hard_combo1	; 11
	.long	stk_hard_combo2	; 12
	.long	stk_combo3	; 13
	.long	stk_combo4  	; 14
	.long	stk_combo5  	; 15



;weak_damage	.set	>0401
combo_damage	.set	>0701
hard_damage	.set	>0a01

;stk_combo0_weak
;	.word	>51   		; x offset of collision box
;	.word	>00    		; y offset of collision box
;	.word	>43   		; x size of collision box
;	.word	>85   		; y size of collision box
;	.word	>100f 		; strike routine
;	.word	weak_damage	; damage
; 	.word	0

stk_combo0
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>100f 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_hard_combo0
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>100f 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo1
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>110f 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_hard_combo1
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>110f 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo1_stab
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>0f0f 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo2
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>1212 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_hard_combo2
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>1212 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo2_stab
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>0e12 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo3
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>1312 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo4
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>1412 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo5
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>1512 		; strike routine
	.word	combo_damage	; damage
 	.word	0


stk_combo6
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>1712 		; strike routine
	.word	combo_damage	; damage
 	.word	0


stk_combo_klang
	.word	>51   		; x offset of collision box
	.word	>0    		; y offset of collision box
	.word	>43   		; x size of collision box
	.word	>85   		; y size of collision box
	.word	>160f 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo_axeup
	.word	>5a		; x offset of collision box
	.word	->02		; y offset of collision box
	.word	>36		; x size of collision box
	.word	>5c		; y size of collision box
	.word	>2b01		; strike routine
	.word	>1804		; damage
	.word	sf_squeeze

;*************************************************************************

stk_dummy
	.word	10		; x offset of collision box
	.word	10		; y offset of collision box
	.word	10		; x size of collision box
	.word	10		; y size of collision box
	.word	>0000		; strike routine
	.word	>0000		; damage
	.word	sf_squeeze

dummy_strikes
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy
	.long	stk_dummy

;************************************************************************




**************************************************************************
*											     *
*                         STRIKE ROUTINES						     *
*                         STRIKE ROUTINES						     *
*                         STRIKE ROUTINES						     *
*                         STRIKE ROUTINES						     *
*                         STRIKE ROUTINES						     *
*											     *
**************************************************************************

**************************************************************************
*											     *
*  striker - general purpose attack routine.					     *
* 											     *
*  input: a0 = speed	      	returns: carry set = hit		     	*
*  	 a1 = act                        carry clear = miss		     *
*  	 a9 = ani offset       								     *
*  	 a10 = # of frames to look for collision					*
*  	 a11 = stk offset								     *
*											     *
**************************************************************************
upcut_striker
	mmtm	sp,a0,a1
	calla	init_special		; setup stuff
	jruc	attk5

behind_striker
	mmtm	sp,a0,a1
	calla	init_special		; setup stuff
	calla	me_in_back
	jruc	attk3

striker_2
	mmtm	sp,a0,a1
	calla	init_special		; setup stuff
	calla	get_char_ani2		; a9 = animation table
	jruc	attk2

striker
	mmtm	sp,a0,a1
	calla	init_special		; setup stuff
attk3	move	a9,a9
	jrn	attk5			; a9 already loaded

	calla	get_char_ani		; a9 = animation table

attk5
;****************
	.if ejbbug
	clr	a1
	not	a1
	movi	oid_cbox,a0
	calla	kilobj2	   		; kill all other collision box objects
	.endif
;****************

attk2	mmfm	sp,a0,a1
	jsrp	act_mframew    		; attack animation

attk4	move	a11,a0
	callr	strike_check_a0		; look for strike
	jrc	attack_hit		; hit ---> yes
	sleep	1
	dsj	a10,attk4
	clrc				; carry clear ---> sans hit
	jruc	attk9

attack_hit
	setc
attk9	retp

**************************************************************************
*											     *
*  strike_check - look for collisions on "strike" routines		     *
* 											     *
*    input: a0 = stk table      								     *
* 											     *
*  returns: b2 = blocked flag								     *
*											     *
**************************************************************************
strike_check_box
	clr	b1		; flag: this is NOT a test
	clr	b2		; a block must be proven !!

	push	a1
	calla	get_char_stk  	; a0 = strike table
	pull	a1

	mmtm	sp,a0,a10,a11
	move	*a13(p_otherguy),a14,l
	move	*a14(oflags2),a14,w
	btst	b_nocol,a14
	jrne	no_collision	; he is invincible ---> no collision allowed

	move	a2,a3
	move	a1,a2
	sra	16,a2		; a2 = y offset
	sext	a1,w		; a1 = x offset
	move	a3,a4
	sra	16,a4		; a4 = box y size
	sext	a3,w		; a3 = box x size
	addi	16*4,a0		; we already got this info, skip it
	jruc	stck2


strike_check
	clr	b1		; flag: this is NOT a test
	jruc	stck1

strike_check_a0_test
	movk	1,b1		; flag: this is a test, for the next 60 sec...
	jruc	stck3

strike_check_a0
	clr	b1		; flag: this is NOT a test

stck3	calla	get_char_stk  	; a0 = strike table

stck1	mmtm	sp,a0,a10,a11
	clr	b2		; a block must be proven !!

;	move	@p1_bar,a1,w
;	jreq	no_collision
;	move	@p2_bar,a1,w
;	jreq	no_collision	; round is over ---> no more collision checks

	move	*a13(p_otherguy),a1,l
	move	*a1(oflags2),a1,w
	btst	b_nocol,a1
	jrne	no_collision	; he is invincible ---> no collision allowed

	move	*a0+,a1,w	; a1 = x offset
	move	*a0+,a2,w   	; a2 = y offset
	move	*a0+,a3,w	; a3 = strike box x size
	move	*a0+,a4,w	; a4 = strike box y size

stck2	move	*a0+,a11,w	; a11 = [strike routine, block routine]
	move	*a0+,a7,w	; a7 = [hit damage,blocked damage]

	move	*a0+,a5,w	; a5 = flags
	pushp	a5

	neg	a1
	move	*a8(oflags),a5,w
	btst	b_fliph,a5
	jrne	stck5
	neg	a1
	sub	a3,a1		; not flipped --> subtract x size for xpos

stck5	mmtm	sp,a1,a2,a3
	move	*a8(oypos),a5,w		; a5 = my ani y
	move	*a8(oxpos),a6,w		; a6 = my ani x
	mmfm	sp,a1,a2,a3
	add	a6,a1	     		; a1 = x position of collision box
	add	a5,a2	     		; a2 = y position

	.if ejbbug
	move	b1,b1			; is this a test
	jrne	stck8			; yes ---> no collision box !!
	move	@f_colbox,a14,w		; collision box object ?
	jane	colbox_table
stck8
	.endif

	add	a1,a3
	add	a2,a4
	sll	16,a2
	movy	a2,a1			; a1 = "strike" top left [y,x]
	sll	16,a4
	movy	a4,a3			; a3 = "strike" bottom right [y,x]

	mmtm	sp,a1,a3
	move	*a13(p_otherguy),a10,l
	mmtm	sp,a7,a8
	move	a10,a8
	calla	highest_mpart		; a0 = high point
	calla	lowest_mpart		; a1 = low point
	calla	leftmost_mpart		; a2 = left point
	calla	rightmost_mpart		; a3 = right point
	mmfm	sp,a7,a8

	move	a3,a4
	sub	a2,a4
	abs	a4			; a4 = x size of other dude
	pullp	a6

	callr	cbox_squeeze		; yea

	.if ejbbug
	move	b1,b1			; is this a test
	jrne	novicbox		; yes ---> no vic box !!
	calla	victim_box
novicbox
	.endif

	sll	16,a0
	movy	a0,a2			; a2 = top left [y,x]
	sll	16,a1
	movy	a1,a3			; a3 = bottom right [y,x]
	mmfm	sp,a4,a5
*
* a2 = victim top left [y,x]
* a3 = victim bottom right [y,x]
* a4 = strike top left [y,x]
* a5 = strike bottom right [y,x]
*
	cmpxy	a5,a2			; compare: top left / bottom right
	jryge	no_collision
	jrxge	no_collision
	cmpxy	a4,a3			; compare: bottom right / top left
	jrxle	no_collision
	jryle	no_collision
*
* collision = yes
*
	move	b1,b1			; is this just a test ?
	jrne	yes_collision		; yes ---> set carry and boogie on !!

	calla	disable_his_buttons			; no --> disable this chump !!
	move	*a13(p_otherproc),a0,l
	move	*a13(p_action),*a0(p_hitby),w	; update: last hit by !

	move	a6,a5			; a5 = strike flags
	clr	a6			; reduce bar #1
	move	*a13(p_otherguy),a0,l
	move	@p1_obj,a1,l
	cmp	a0,a1
	jreq	stck7
	movk	1,a6			; reduce bar #2

stck7	calla	is_he_blocking
	jrc	strike_blocked		; blocked !

block_is_useless
	move	a7,a10
	sll	16,a10
	srl	24,a10			; a10 = use "hit damage" half

;************************** no damage
;	.if ejbbug
;	clr 	a10
;	.endif
;************************** no damage

	calla	bar_reducer
	move	a10,a14
	calla	add_combo_damage

	sll	16,a11
	srl	24,a11			; a11 = "hit" routine offset
	sll	5,a11
	addi	reaction_table,a11
	move	*a11,a7,l
	callr	react_xfer_him

yes_collision
	setc
	jruc	sc_exit

no_collision
	clrc

sc_exit	mmfm	sp,a0,a10,a11
	rets

*
* Input: a7 = address to xfer him to !
*
react_xfer_him
	movi	pid_switch1,a0
	move	*a13(p_otherproc),a1,l
	move	*a1(procid),a1,w
	cmpi	pid_p1,a1
	jreq	rx4
	movi	pid_switch2,a0
rx4	calla	dallprc			; kill his switch procs
	calla	xfer_otherguy		; and xfer him away

	move	*a0(p_flags),a4,w
	ori	pm_reacting,a4
	move	a4,*a0(p_flags),w	; otherguy = flag: reactiing !!
	rets
*
* a5 = middle y of strike box
* a7 = [hit,blocked] damage
*
strike_blocked
	move	a7,a10			; a10 = damage
	sll	32-8,a10	
	srl	32-8,a10		; use "blocked damage" half

	push	a8
	move	*a13(p_otherguy),a8,l	; a little trickery here !!
	move	*a8(ochar),a3,w			; a3 = his ochar
	calla	get_my_strength			; a0 = other dudes strength
	pull	a8
	sub	a10,a0				; subtract block damage
	jrn	block_is_useless		; block or no ---> he's screwed!
	jreq	block_is_useless		; block or no ---> he's screwed!

	movk	1,b2				; flag: strike was blocked !!
	sll	24,a11
	srl	24-5,a11			; a11 = "blocked" offset
	addi	block_xfers,a11
	move	*a11,a7,l			; a7 = block address to xfer

	move	*a13(p_otherproc),a0,l
	calla	fastxfer
*
* block damage
*
	callr	bar_reducer
	jruc	yes_collision

**************************************************************************
*											     *
*  bar_reducer - add to players drop ram while is subtracted from his	*
*	        power										*
* 											     *
*  input:  a6 = 0/1 for player 1 or 2							     *
*         a10 = amount to subtract from p?_bar					     *
* 											     *
*  returns: carry set = round is over							     *
*											     *
**************************************************************************
bar_reducer
	move	@p1_bar,a0,w
	jreq	bred5
	move	@p2_bar,a0,w
	jreq	bred5			; zero already ---> mute point !

	movi	p1_bar,a7
	move	@p1_obj,a1,l
	move	@p1_char,a2,w
	move	a6,a6			; damage to player 1 ?
	jreq	bred3	    		; yes

	movi	p2_bar,a7
	move	@p2_obj,a1,l		; no, player 2 !!
	move	@p2_char,a2,w
bred3	callr	ochar_xlate_damage

	move	*a1(oflags2),a1,w
	btst	b_half_damage,a1	; half damage protection ?
	jreq	bred2			; no
	sra	1,a10			; yes ---> slice it

bred2	move	*a7,a1,w		; a1 = current bar value
	sub	a10,a1			; take off damage
	jrnn	bred4			; non-neg ----> stuff back into bar !
	clr	a1			; nothing smaller than zero allowed
bred4	move	a1,*a7,w		; stuff back into bar value
	jrp	not_dead_yet
bred5	setc				; carry set ---> round iz over
	rets

;**************************************************************************

ochar_xlate_damage
	sll	5,a2
	addi	ochar_damage_table,a2
	move	*a2,a2,l		; do something to damage ?
	jrne	oxd3
    	rets
oxd3	jump	a2


ochar_damage_table
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.long	motaro_xlate
	.long	sk_xlate
	.long	0
	.long	0
	.long	0

motaro_xlate
sk_xlate
	move	a10,a2
	srl	1,a10			; 1/2
	srl	2,a2			; 1/4
	add	a2,a10
	rets

;**************************************************************************

not_dead_yet
	cmpi	6,a1			; dude in danger ?
	jrhi	bred6			; no

	move	a6,a5
	inc	a5			; a5 = 1 or 2 (player 1 or 2)
	move	@f_warnsound,a1,w
	and	a5,a1			; look at bit for this player
	jrne	bred6			; sound call already made
	
	or	a5,a1
	move	a1,@f_warnsound,w	; set flag for this player

	movi	>27,a0
	calla	create_fx
	move	a5,*a0(pa11),l		; pass "who is in danger"

bred6	clrc
	rets


pbar_table
	.long	p1_bar
	.long	p2_bar

**************************************************************************
*											     *
*  Input: a0 = top									     *
*         a1 = bottom									     *
*         a2 = left									     *
*         a3 = right									     *
*         a4 = x size of player									*
*											     *
**************************************************************************
cbox_squeeze
	btst	sb_squeeze,a6 		; squeeze flag ?
	jreq	cbs9			; no

	move	*a10(ochar),a14,w
	cmpi	ft_motaro,a14
	jrne	cbs6

	move	a1,a5
	sub	a0,a5
	abs	a5
	sra	3,a5			; a5 = 1/8 his total height !!
	add	a5,a0
	sub	a5,a1			; adjust o rama

	movi	>25,a5
	move	*a10(oflags),a14,w
	btst	b_fliph,a14
	jreq	cbs4
	neg	a5
cbs4	add	a5,a2
	add	a5,a3			; adjust for motaro's wierd body

cbs6	push	a7
	move	a4,a7
	srl	3,a7			; a7 = 1/8 wideness
	srl	2,a4			; a4 = 1/2 wideness
	add	a7,a4			; a4 = 4/8 + 1/8 = 5/8 wideness
	add	a4,a2			; a2 = dudes left collision x
	sub	a4,a3			; a3 = dudes right collision x
	pull	a7
cbs9	rets

;*************************************************************************

	.end
