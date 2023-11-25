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
	.file	"mkstk.asm"
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
	.word	053H		; x offset of collision box
	.word	012H		; y offset of collision box
	.word	046H		; x size of collision box
	.word	075H		; y size of collision box
	.word	06215H		; strike routine
	.word	02206H		; damage
	.word	sf_squeeze

stk_sk_kick
	.word	06dH		; x offset of collision box
	.word	020H		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	03dH		; y size of collision box
	.word	06215H		; strike routine
	.word	02706H		; damage
	.word	sf_squeeze

stk_sk_hammer
	.word	086H		; x offset of collision box
	.word	020H		; y offset of collision box
	.word	077H		; x size of collision box
	.word	039H		; y size of collision box
	.word	06315H		; strike routine
	.word	02706H		; damage
	.word	sf_squeeze

stk_sk_charge
	.word	040H		; x offset of collision box
	.word	011H		; y offset of collision box
	.word	042H		; x size of collision box
	.word	090H		; y size of collision box
	.word	06415H		; strike routine
	.word	02005H		; damage
	.word	sf_squeeze

stk_sk_zap
	.word	078H		; x offset of collision box
	.word	029H		; y offset of collision box
	.word	034H		; x size of collision box
	.word	031H		; y size of collision box
	.word	06415H		; strike routine
	.word	02306H		; damage
	.word	sf_squeeze

stk_sk_air_charge
	.word	04dH		; x offset of collision box
	.word	017H		; y offset of collision box
	.word	046H		; x size of collision box
	.word	04aH		; y size of collision box
	.word	06515H		; strike routine
	.word	02005H		; damage
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
	.word	06bH		; x offset of collision box
	.word	012H		; y offset of collision box
	.word	05fH		; x size of collision box
	.word	075H		; y size of collision box
	.word	06015H		; strike routine
	.word	02809H		; damage
	.word	sf_squeeze

stk_mot_kick
	.word	00bH		; x offset of collision box
	.word	023H		; y offset of collision box
	.word	072H		; x size of collision box
	.word	064H		; y size of collision box
	.word	06115H		; strike routine
	.word	0300dH		; damage
	.word	sf_squeeze

stk_mot_sweep
	.word	0e3H		; x offset of collision box
	.word	06eH		; y offset of collision box
	.word	0bdH		; x size of collision box
	.word	034H		; y size of collision box
	.word	00403H		; strike routine
	.word	02007H		; damage
	.word	sf_squeeze

stk_mot_zap
	.word	00dH		; x offset of collision box
	.word	0fff2H		; y offset of collision box
	.word	019H		; x size of collision box
	.word	01cH		; y size of collision box
	.word	06015H		; strike routine
	.word	02005H		; damage
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
	.word	04eH		; x offset of collision box
	.word	00eH		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	02aH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_lk_lokick
	.word	05fH		; x offset of collision box
	.word	030H		; y offset of collision box
	.word	04fH		; x size of collision box
	.word	00fH		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_lk_hi_punch
	.word	048H		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	035H		; x size of collision box
	.word	01dH		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_lk_lo_punch
	.word	054H		; x offset of collision box
	.word	020H		; y offset of collision box
	.word	041H		; x size of collision box
	.word	015H		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_lk_sweep
	.word	06aH		; x offset of collision box
	.word	06cH		; y offset of collision box
	.word	04aH		; x size of collision box
	.word	019H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_lk_duck_punch
	.word	04dH		; x offset of collision box
	.word	049H		; y offset of collision box
	.word	03bH		; x size of collision box
	.word	010H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_lk_duck_kickh
	.word	050H		; x offset of collision box
	.word	037H		; y offset of collision box
	.word	040H		; x size of collision box
	.word	021H		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_lk_duck_kickl
	.word	051H		; x offset of collision box
	.word	06dH		; y offset of collision box
	.word	03cH		; x size of collision box
	.word	018H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_lk_uppercut
	.word	046H		; x offset of collision box
	.word	0fff6H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	043H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_lk_jump_punch
	.word	055H		; x offset of collision box
	.word	005H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	028H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_lk_jump_kick
	.word	03dH		; x offset of collision box
	.word	0fffaH		; y offset of collision box
	.word	036H		; x size of collision box
	.word	034H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_lk_flip_kick
	.word	057H		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	02cH		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_lk_flip_punch
	.word	055H		; x offset of collision box
	.word	005H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	028H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_lk_roundh
	.word	06bH		; x offset of collision box
	.word	005H		; y offset of collision box
	.word	053H		; x size of collision box
	.word	034H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_lk_knee
	.word	047H		; x offset of collision box
	.word	021H		; y offset of collision box
	.word	033H		; x size of collision box
	.word	03dH		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_lk_elbow
	.word	040H		; x offset of collision box
	.word	00cH		; y offset of collision box
	.word	02eH		; x size of collision box
	.word	032H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_lk_zap
	.word	0d0H		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	051H		; x size of collision box
	.word	014H		; y size of collision box
	.word	05501H		; strike routine
	.word	01603H		; damage
	.word	sf_squeeze

stk_lk_bike
	.word	042H		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	041H		; x size of collision box
	.word	02aH		; y size of collision box
	.word	05600H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_super_kang
	.word	063H		; x offset of collision box
	.word	021H		; y offset of collision box
	.word	04bH		; x size of collision box
	.word	01cH		; y size of collision box
	.word	05700H		; strike routine
	.word	01704H		; damage
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
	.word	055H		; x offset of collision box
	.word	0fffbH		; y offset of collision box
	.word	049H		; x size of collision box
	.word	031H		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_st_lokick
	.word	06aH		; x offset of collision box
	.word	027H		; y offset of collision box
	.word	053H		; x size of collision box
	.word	014H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_st_hi_punch
	.word	054H		; x offset of collision box
	.word	003H		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	01dH		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_st_lo_punch
	.word	053H		; x offset of collision box
	.word	018H		; y offset of collision box
	.word	039H		; x size of collision box
	.word	01bH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_st_sweep
	.word	060H		; x offset of collision box
	.word	067H		; y offset of collision box
	.word	052H		; x size of collision box
	.word	01aH		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_st_duck_punch
	.word	04dH		; x offset of collision box
	.word	037H		; y offset of collision box
	.word	039H		; x size of collision box
	.word	010H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_st_duck_kickh
	.word	059H		; x offset of collision box
	.word	03cH		; y offset of collision box
	.word	040H		; x size of collision box
	.word	01cH		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_st_duck_kickl
	.word	05aH		; x offset of collision box
	.word	069H		; y offset of collision box
	.word	044H		; x size of collision box
	.word	015H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_st_uppercut
	.word	055H		; x offset of collision box
	.word	0fff2H		; y offset of collision box
	.word	03dH		; x size of collision box
	.word	040H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_st_jump_punch
	.word	057H		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	028H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_st_jump_kick
	.word	05dH		; x offset of collision box
	.word	0fff5H		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	02dH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_st_flip_kick
	.word	057H		; x offset of collision box
	.word	017H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	02cH		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_st_flip_punch
	.word	057H		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	028H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_st_roundh
	.word	065H		; x offset of collision box
	.word	0fff6H		; y offset of collision box
	.word	049H		; x size of collision box
	.word	037H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_st_knee
	.word	04aH		; x offset of collision box
	.word	021H		; y offset of collision box
	.word	036H		; x size of collision box
	.word	03dH		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_st_elbow
	.word	047H		; x offset of collision box
	.word	0fffeH		; y offset of collision box
	.word	032H		; x size of collision box
	.word	030H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_st_zap
	.word	09aH		; x offset of collision box
	.word	015H		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	016H		; y size of collision box
	.word	05101H		; strike routine
	.word	00d02H		; damage
	.word	sf_squeeze

stk_summon
	.word	014H		; x offset of collision box
	.word	0ff9bH		; y offset of collision box
	.word	027H		; x size of collision box
	.word	05dH		; y size of collision box
	.word	05001H		; strike routine
	.word	00803H		; damage
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
	.word	065H		; x offset of collision box
	.word	016H		; y offset of collision box
	.word	050H		; x size of collision box
	.word	02aH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_sg_lokick
	.word	06bH		; x offset of collision box
	.word	031H		; y offset of collision box
	.word	053H		; x size of collision box
	.word	014H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_sg_hi_punch
	.word	052H		; x offset of collision box
	.word	012H		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	01aH		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_sg_lo_punch
	.word	04aH		; x offset of collision box
	.word	02bH		; y offset of collision box
	.word	039H		; x size of collision box
	.word	01eH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_sg_sweep
	.word	063H		; x offset of collision box
	.word	073H		; y offset of collision box
	.word	052H		; x size of collision box
	.word	021H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_sg_duck_punch
	.word	056H		; x offset of collision box
	.word	04aH		; y offset of collision box
	.word	047H		; x size of collision box
	.word	013H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sg_duck_kickh
	.word	05dH		; x offset of collision box
	.word	03dH		; y offset of collision box
	.word	046H		; x size of collision box
	.word	02fH		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_sg_duck_kickl
	.word	060H		; x offset of collision box
	.word	07aH		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	020H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sg_uppercut
	.word	056H		; x offset of collision box
	.word	0fff0H		; y offset of collision box
	.word	04bH		; x size of collision box
	.word	053H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_sg_jump_punch
	.word	049H		; x offset of collision box
	.word	00aH		; y offset of collision box
	.word	03dH		; x size of collision box
	.word	02fH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sg_jump_kick
	.word	05aH		; x offset of collision box
	.word	015H		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	02cH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_sg_flip_kick
	.word	04fH		; x offset of collision box
	.word	028H		; y offset of collision box
	.word	049H		; x size of collision box
	.word	034H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_sg_flip_punch
	.word	049H		; x offset of collision box
	.word	00aH		; y offset of collision box
	.word	03dH		; x size of collision box
	.word	02fH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sg_roundh
	.word	077H		; x offset of collision box
	.word	003H		; y offset of collision box
	.word	051H		; x size of collision box
	.word	038H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_sg_knee
	.word	051H		; x offset of collision box
	.word	021H		; y offset of collision box
	.word	03cH		; x size of collision box
	.word	04aH		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_sg_elbow
	.word	04bH		; x offset of collision box
	.word	018H		; y offset of collision box
	.word	032H		; x size of collision box
	.word	030H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_sg_zap
	.word	001H		; x offset of collision box
	.word	0ffedH		; y offset of collision box
	.word	030H		; x size of collision box
	.word	026H		; y size of collision box
	.word	05c01H		; strike routine
	.word	01a03H		; damage
	.word	sf_squeeze

stk_pounce
	.word	023H		; x offset of collision box
	.word	026H		; y offset of collision box
	.word	032H		; x size of collision box
	.word	04bH		; y size of collision box
	.word	05b0eH		; strike routine (unblockable)
	.word	02020H		; damage
	.word	sf_squeeze

stk_boss_pounce
	.word	023H		; x offset of collision box
	.word	026H		; y offset of collision box
	.word	032H		; x size of collision box
	.word	04bH		; y size of collision box
	.word	05b01H		; strike routine (unblockable)
	.word	02020H		; damage
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
	.word	058H		; x offset of collision box
	.word	015H		; y offset of collision box
	.word	050H		; x size of collision box
	.word	02aH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_tusk_lokick
	.word	063H		; x offset of collision box
	.word	031H		; y offset of collision box
	.word	04cH		; x size of collision box
	.word	014H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_tusk_hi_punch
	.word	054H		; x offset of collision box
	.word	011H		; y offset of collision box
	.word	034H		; x size of collision box
	.word	021H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_tusk_lo_punch
	.word	05fH		; x offset of collision box
	.word	028H		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	015H		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_tusk_sweep
	.word	068H		; x offset of collision box
	.word	070H		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	01cH		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_tusk_duck_punch
	.word	051H		; x offset of collision box
	.word	050H		; y offset of collision box
	.word	03dH		; x size of collision box
	.word	00eH		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_tusk_duck_kickh
	.word	051H		; x offset of collision box
	.word	045H		; y offset of collision box
	.word	040H		; x size of collision box
	.word	01aH		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_tusk_duck_kickl
	.word	056H		; x offset of collision box
	.word	074H		; y offset of collision box
	.word	043H		; x size of collision box
	.word	01aH		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_tusk_uppercut
	.word	047H		; x offset of collision box
	.word	000H		; y offset of collision box
	.word	040H		; x size of collision box
	.word	043H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_tusk_jump_punch
	.word	056H		; x offset of collision box
	.word	01cH		; y offset of collision box
	.word	034H		; x size of collision box
	.word	029H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_tusk_jump_kick
	.word	051H		; x offset of collision box
	.word	020H		; y offset of collision box
	.word	042H		; x size of collision box
	.word	024H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_tusk_flip_kick
	.word	05aH		; x offset of collision box
	.word	02bH		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	02dH		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_tusk_flip_punch
	.word	056H		; x offset of collision box
	.word	01cH		; y offset of collision box
	.word	034H		; x size of collision box
	.word	029H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_tusk_roundh
	.word	065H		; x offset of collision box
	.word	015H		; y offset of collision box
	.word	04dH		; x size of collision box
	.word	030H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_tusk_knee
	.word	04aH		; x offset of collision box
	.word	03aH		; y offset of collision box
	.word	031H		; x size of collision box
	.word	032H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_tusk_elbow
	.word	047H		; x offset of collision box
	.word	02cH		; y offset of collision box
	.word	03bH		; x size of collision box
	.word	022H		; y size of collision box
	.word	04c07H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_tusk_zap
	.word	031H		; x offset of collision box
	.word	0ffefH		; y offset of collision box
	.word	02aH		; x size of collision box
	.word	019H		; y size of collision box
	.word	04a01H		; strike routine
	.word	01703H		; damage
	.word	sf_squeeze

stk_tusk_blur
	.word	021H		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	035H		; x size of collision box
	.word	07eH		; y size of collision box
	.word	04b00H		; strike routine
	.word	00000H		; damage
	.word	sf_squeeze

stk_tusk_saw
	.word	014H		; x offset of collision box
	.word	0ffd4H		; y offset of collision box
	.word	022H		; x size of collision box
	.word	02bH		; y size of collision box
	.word	04d00H		; strike routine
	.word	01202H		; damage
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
	.word	055H		; x offset of collision box
	.word	006H		; y offset of collision box
	.word	040H		; x size of collision box
	.word	02eH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_lao_lokick
	.word	064H		; x offset of collision box
	.word	025H		; y offset of collision box
	.word	04cH		; x size of collision box
	.word	014H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_lao_hi_punch
	.word	04aH		; x offset of collision box
	.word	003H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	023H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_lao_lo_punch
	.word	051H		; x offset of collision box
	.word	01bH		; y offset of collision box
	.word	033H		; x size of collision box
	.word	01cH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_lao_sweep
	.word	06eH		; x offset of collision box
	.word	069H		; y offset of collision box
	.word	04cH		; x size of collision box
	.word	018H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_lao_duck_punch
	.word	04aH		; x offset of collision box
	.word	039H		; y offset of collision box
	.word	03bH		; x size of collision box
	.word	013H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_lao_duck_kickh
	.word	04bH		; x offset of collision box
	.word	039H		; y offset of collision box
	.word	046H		; x size of collision box
	.word	031H		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_lao_duck_kickl
	.word	057H		; x offset of collision box
	.word	069H		; y offset of collision box
	.word	043H		; x size of collision box
	.word	01aH		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_lao_uppercut
	.word	03aH		; x offset of collision box
	.word	0ffefH		; y offset of collision box
	.word	034H		; x size of collision box
	.word	046H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_lao_jump_punch
	.word	068H		; x offset of collision box
	.word	015H		; y offset of collision box
	.word	039H		; x size of collision box
	.word	02eH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_lao_jump_kick
	.word	052H		; x offset of collision box
	.word	00cH		; y offset of collision box
	.word	039H		; x size of collision box
	.word	03bH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_lao_flip_kick
	.word	04cH		; x offset of collision box
	.word	02dH		; y offset of collision box
	.word	02cH		; x size of collision box
	.word	01dH		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_lao_flip_punch
	.word	067H		; x offset of collision box
	.word	019H		; y offset of collision box
	.word	039H		; x size of collision box
	.word	02dH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_lao_roundh
	.word	061H		; x offset of collision box
	.word	007H		; y offset of collision box
	.word	045H		; x size of collision box
	.word	031H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_lao_knee
	.word	040H		; x offset of collision box
	.word	021H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	030H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_lao_elbow
	.word	03dH		; x offset of collision box
	.word	00cH		; y offset of collision box
	.word	030H		; x size of collision box
	.word	024H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_lao_zap
	.word	054H		; x offset of collision box
	.word	024H		; y offset of collision box
	.word	02aH		; x size of collision box
	.word	029H		; y size of collision box
	.word	04504H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_lao_angle
	.word	056H		; x offset of collision box
	.word	034H		; y offset of collision box
	.word	02dH		; x size of collision box
	.word	009H		; y size of collision box
	.word	04600H		; strike routine
	.word	00f02H		; damage
	.word	sf_squeeze

stk_lao_spin
	.word	028H		; x offset of collision box
	.word	0fff9H		; y offset of collision box
	.word	03cH		; x size of collision box
	.word	052H		; y size of collision box
	.word	00801H		; strike routine
	.word	01603H		; damage
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
	.word	05fH		; x offset of collision box
	.word	00dH		; y offset of collision box
	.word	047H		; x size of collision box
	.word	034H		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_ro_lokick
	.word	06aH		; x offset of collision box
	.word	030H		; y offset of collision box
	.word	047H		; x size of collision box
	.word	010H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_ro_hi_punch
	.word	04bH		; x offset of collision box
	.word	00eH		; y offset of collision box
	.word	036H		; x size of collision box
	.word	021H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_ro_lo_punch
	.word	046H		; x offset of collision box
	.word	023H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	01fH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_ro_sweep
	.word	06aH		; x offset of collision box
	.word	06bH		; y offset of collision box
	.word	04fH		; x size of collision box
	.word	021H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_ro_duck_punch
	.word	044H		; x offset of collision box
	.word	03fH		; y offset of collision box
	.word	037H		; x size of collision box
	.word	013H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_ro_duck_kickh
	.word	048H		; x offset of collision box
	.word	03aH		; y offset of collision box
	.word	03dH		; x size of collision box
	.word	038H		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_ro_duck_kickl
	.word	060H		; x offset of collision box
	.word	070H		; y offset of collision box
	.word	040H		; x size of collision box
	.word	017H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_ro_uppercut
	.word	03cH		; x offset of collision box
	.word	0fffaH		; y offset of collision box
	.word	038H		; x size of collision box
	.word	04aH		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_ro_jump_punch
	.word	04bH		; x offset of collision box
	.word	011H		; y offset of collision box
	.word	032H		; x size of collision box
	.word	031H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_ro_jump_kick
	.word	04bH		; x offset of collision box
	.word	0fff6H		; y offset of collision box
	.word	045H		; x size of collision box
	.word	049H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_ro_flip_kick
	.word	050H		; x offset of collision box
	.word	02dH		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	023H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_ro_flip_punch
	.word	04bH		; x offset of collision box
	.word	011H		; y offset of collision box
	.word	032H		; x size of collision box
	.word	031H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_ro_roundh
	.word	068H		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	04aH		; x size of collision box
	.word	033H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_ro_knee
	.word	047H		; x offset of collision box
	.word	02cH		; y offset of collision box
	.word	030H		; x size of collision box
	.word	03fH		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_ro_elbow
	.word	03dH		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	033H		; x size of collision box
	.word	036H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_ro_zap
	.word	010H		; x offset of collision box
	.word	0fff1H		; y offset of collision box
	.word	023H		; x size of collision box
	.word	01fH		; y size of collision box
	.word	03b04H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_ro_net
	.word	037H		; x offset of collision box
	.word	0ffe0H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	04aH		; y size of collision box
	.word	03c00H		; strike routine
	.word	00000H		; damage
	.word	sf_squeeze

stk_ro_tele
	.word	049H		; x offset of collision box
	.word	0fff7H		; y offset of collision box
	.word	049H		; x size of collision box
	.word	057H		; y size of collision box
	.word	03d00H		; strike routine
	.word	01002H		; damage
	.word	sf_squeeze

stk_ro_bomb
	.word	02fH		; x offset of collision box
	.word	0ffb8H		; y offset of collision box
	.word	053H		; x size of collision box
	.word	057H		; y size of collision box
	.word	03e09H		; strike routine
	.word	01212H		; damage
	.word	0

stk_spear
	.word	0147H		; x offset of collision box
	.word	0ffffH		; y offset of collision box
	.word	050H		; x size of collision box
	.word	010H		; y size of collision box
	.word	03f00H		; strike routine
	.word	00802H		; damage
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
	.word	059H		; x offset of collision box
	.word	00bH		; y offset of collision box
	.word	047H		; x size of collision box
	.word	02dH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_li_lokick
	.word	05fH		; x offset of collision box
	.word	02fH		; y offset of collision box
	.word	042H		; x size of collision box
	.word	00fH		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_li_hi_punch
	.word	054H		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	02fH		; x size of collision box
	.word	023H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_li_lo_punch
	.word	054H		; x offset of collision box
	.word	026H		; y offset of collision box
	.word	033H		; x size of collision box
	.word	016H		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_li_sweep
	.word	06bH		; x offset of collision box
	.word	066H		; y offset of collision box
	.word	04cH		; x size of collision box
	.word	021H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_li_duck_punch
	.word	04dH		; x offset of collision box
	.word	049H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	013H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_li_duck_kickh
	.word	059H		; x offset of collision box
	.word	040H		; y offset of collision box
	.word	047H		; x size of collision box
	.word	02cH		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_li_duck_kickl
	.word	059H		; x offset of collision box
	.word	072H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	018H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_li_uppercut
	.word	04aH		; x offset of collision box
	.word	0fff3H		; y offset of collision box
	.word	034H		; x size of collision box
	.word	047H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_li_jump_punch
	.word	055H		; x offset of collision box
	.word	006H		; y offset of collision box
	.word	02fH		; x size of collision box
	.word	02bH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_li_jump_kick
	.word	04fH		; x offset of collision box
	.word	0fff8H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	048H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_li_flip_kick
	.word	059H		; x offset of collision box
	.word	01aH		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	033H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_li_flip_punch
	.word	056H		; x offset of collision box
	.word	00cH		; y offset of collision box
	.word	035H		; x size of collision box
	.word	02aH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_li_roundh
	.word	04aH		; x offset of collision box
	.word	001H		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	039H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_li_knee
	.word	051H		; x offset of collision box
	.word	022H		; y offset of collision box
	.word	02fH		; x size of collision box
	.word	03aH		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_li_elbow
	.word	04cH		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	02dH		; x size of collision box
	.word	02cH		; y size of collision box

;	.word	00907H		; strike routine
	.word	04c07H		; strike routine

	.word	01003H		; damage
	.word	sf_squeeze

stk_li_angle_zap
	.word	053H		; x offset of collision box
	.word	030H		; y offset of collision box
	.word	025H		; x size of collision box
	.word	025H		; y size of collision box
	.word	03704H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_li_scream
	.word	09aH		; x offset of collision box
	.word	008H		; y offset of collision box
	.word	06aH		; x size of collision box
	.word	042H		; y size of collision box
	.word	03608H		; strike routine
	.word	00000H		; damage
	.word	sf_squeeze

stk_li_angle_zap2
	.word	07dH		; x offset of collision box
	.word	051H		; y offset of collision box
	.word	02aH		; x size of collision box
	.word	02cH		; y size of collision box
	.word	03704H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_li_angle_zap3
	.word	085H		; x offset of collision box
	.word	05bH		; y offset of collision box
	.word	02fH		; x size of collision box
	.word	02bH		; y size of collision box
	.word	03704H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_li_forward
	.word	072H		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	02dH		; x size of collision box
	.word	011H		; y size of collision box
	.word	03704H		; strike routine
	.word	01402H		; damage
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
	.word	05fH		; x offset of collision box
	.word	00dH		; y offset of collision box
	.word	051H		; x size of collision box
	.word	02cH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_sw_lokick
	.word	067H		; x offset of collision box
	.word	031H		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	010H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_sw_hi_punch
	.word	058H		; x offset of collision box
	.word	00dH		; y offset of collision box
	.word	035H  		; x size of collision box
	.word	024H  		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_sw_lo_punch
	.word	050H		; x offset of collision box
	.word	020H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	014H		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_sw_sweep
	.word	06dH		; x offset of collision box
	.word	066H		; y offset of collision box
	.word	04bH		; x size of collision box
	.word	024H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_sw_duck_punch
	.word	04dH		; x offset of collision box
	.word	046H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	013H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sw_duck_kickh
	.word	051H		; x offset of collision box
	.word	03aH		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	031H		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_sw_duck_kickl
	.word	05dH		; x offset of collision box
	.word	06fH		; y offset of collision box
	.word	046H		; x size of collision box
	.word	01fH		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sw_uppercut
	.word	04eH		; x offset of collision box
	.word	0fff6H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	04dH		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_sw_jump_punch
	.word	05aH		; x offset of collision box
	.word	011H		; y offset of collision box
	.word	03dH		; x size of collision box
	.word	02cH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sw_jump_kick
	.word	04eH		; x offset of collision box
	.word	002H		; y offset of collision box
	.word	03cH		; x size of collision box
	.word	048H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_sw_flip_kick
	.word	05dH		; x offset of collision box
	.word	01dH		; y offset of collision box
	.word	041H		; x size of collision box
	.word	036H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_sw_flip_punch
	.word	05aH		; x offset of collision box
	.word	011H		; y offset of collision box
	.word	03dH		; x size of collision box
	.word	02cH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sw_roundh
	.word	06dH		; x offset of collision box
	.word	0fff7H		; y offset of collision box
	.word	048H		; x size of collision box
	.word	03bH		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_sw_knee
	.word	04eH		; x offset of collision box
	.word	027H		; y offset of collision box
	.word	033H		; x size of collision box
	.word	036H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_sw_elbow
	.word	041H		; x offset of collision box
	.word	00dH		; y offset of collision box
	.word	02cH		; x size of collision box
	.word	028H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_sw_zap
	.word	0e9H		; x offset of collision box
	.word	02bH		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	013H		; y size of collision box
	.word	03004H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_sw_prezap1
	.word	087H		; x offset of collision box
	.word	02bH		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	013H		; y size of collision box
	.word	03004H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_sw_prezap2
	.word	0adH		; x offset of collision box
	.word	02bH		; y offset of collision box
	.word	05bH		; x size of collision box
	.word	013H		; y size of collision box
	.word	03004H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_sw_diag_zap1
	.word	05fH		; x offset of collision box
	.word	0ffe4H		; y offset of collision box
	.word	02bH		; x size of collision box
	.word	030H		; y size of collision box
	.word	03000H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_sw_diag_zap2
	.word	08cH		; x offset of collision box
	.word	0ffbcH		; y offset of collision box
	.word	02bH		; x size of collision box
	.word	030H		; y size of collision box
	.word	03000H		; strike routine
	.word	01402H		; damage
	.word	sf_squeeze

stk_sw_bomb
	.word	017H		; x offset of collision box
	.word	0ffedH		; y offset of collision box
	.word	02dH		; x size of collision box
	.word	025H		; y size of collision box
	.word	03104H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_sw_zoom
	.word	0fff2H		; x offset of collision box
	.word	01cH		; y offset of collision box
	.word	028H		; x size of collision box
	.word	024H		; y size of collision box
	.word	03200H		; strike routine
	.word	00000H		; damage
	.word	sf_squeeze

stk_sw_stick_sweep
	.word	083H		; x offset of collision box
	.word	064H		; y offset of collision box
	.word	074H		; x size of collision box
	.word	004H		; y size of collision box
	.word	03303H		; strike routine
	.word	01a04H		; damage
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
	.word	068H		; x offset of collision box
	.word	00aH		; y offset of collision box
	.word	04eH		; x size of collision box
	.word	02bH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_sz_lokick
	.word	06fH		; x offset of collision box
	.word	02eH		; y offset of collision box
	.word	04dH		; x size of collision box
	.word	00fH		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_sz_hi_punch
	.word	052H		; x offset of collision box
	.word	006H		; y offset of collision box
	.word	035H		; x size of collision box
	.word	025H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
 	.word	sf_squeeze

stk_sz_lo_punch
	.word	057H		; x offset of collision box
	.word	01cH		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	01cH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_sz_sweep
	.word	065H		; x offset of collision box
	.word	067H		; y offset of collision box
	.word	052H		; x size of collision box
	.word	01fH		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_sz_duck_punch
	.word	046H		; x offset of collision box
	.word	03cH		; y offset of collision box
	.word	037H		; x size of collision box
	.word	018H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sz_duck_kickh
	.word	049H		; x offset of collision box
	.word	035H		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	031H		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_sz_duck_kickl
	.word	05eH		; x offset of collision box
	.word	060H		; y offset of collision box
	.word	046H		; x size of collision box
	.word	024H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sz_uppercut
	.word	051H		; x offset of collision box
	.word	0ffeeH		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	048H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_sz_jump_punch
	.word	065H		; x offset of collision box
	.word	0fff4H		; y offset of collision box
	.word	039H		; x size of collision box
	.word	034H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sz_jump_kick
	.word	060H		; x offset of collision box
	.word	0ffefH		; y offset of collision box
	.word	04cH		; x size of collision box
	.word	042H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_sz_flip_kick
	.word	064H		; x offset of collision box
	.word	01aH		; y offset of collision box
	.word	041H		; x size of collision box
	.word	029H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_sz_flip_punch
	.word	065H		; x offset of collision box
	.word	000H		; y offset of collision box
	.word	034H		; x size of collision box
	.word	035H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sz_roundh
	.word	05aH		; x offset of collision box
	.word	000H		; y offset of collision box
	.word	048H		; x size of collision box
	.word	036H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_sz_knee
	.word	041H		; x offset of collision box
	.word	020H		; y offset of collision box
	.word	032H		; x size of collision box
	.word	035H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_sz_elbow
	.word	03eH		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	02bH		; x size of collision box
	.word	024H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_sz_zap
	.word	017H		; x offset of collision box
	.word	03fH		; y offset of collision box
	.word	030H		; x size of collision box
	.word	07eH		; y size of collision box
	.word	02c05H		; strike routine
	.word	00000H		; damage
	.word	sf_squeeze

stk_sz_slide
	.word	059H		; x offset of collision box
	.word	065H		; y offset of collision box
	.word	055H		; x size of collision box
	.word	022H		; y size of collision box
	.word	02d00H		; strike routine
	.word	00d03H		; damage
	.word	sf_squeeze

stk_sz_forward_zap
	.word	082H		; x offset of collision box
	.word	0fff5H		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	006H		; y size of collision box
	.word	02c05H		; strike routine
	.word	00000H		; damage
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
	.word	064H		; x offset of collision box
	.word	007H		; y offset of collision box
	.word	053H		; x size of collision box
	.word	02fH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_ind_lokick
	.word	06aH		; x offset of collision box
	.word	02eH		; y offset of collision box
	.word	04dH		; x size of collision box
	.word	013H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_ind_hi_punch
	.word	04bH		; x offset of collision box
	.word	00bH		; y offset of collision box
	.word	035H		; x size of collision box
	.word	025H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
	.word	sf_squeeze

stk_ind_lo_punch
	.word	045H+4		; x offset of collision box
	.word	01fH		; y offset of collision box
	.word	037H		; x size of collision box
	.word	01aH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_ind_sweep
	.word	06dH+4		; x offset of collision box
	.word	068H		; y offset of collision box
	.word	049H		; x size of collision box
	.word	021H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_ind_duck_punch
	.word	045H+4		; x offset of collision box
	.word	041H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	01dH		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_ind_duck_kickh
	.word	03bH+4		; x offset of collision box
	.word	033H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	03cH		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_ind_duck_kickl
	.word	05eH+4		; x offset of collision box
	.word	066H		; y offset of collision box
	.word	046H		; x size of collision box
	.word	020H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_ind_uppercut
	.word	03eH		; x offset of collision box
	.word	0fff3H		; y offset of collision box
	.word	031H		; x size of collision box
	.word	04bH		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_ind_jump_punch
	.word	04dH		; x offset of collision box
	.word	019H		; y offset of collision box
	.word	031H		; x size of collision box
	.word	02bH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_ind_jump_kick
	.word	052H+4		; x offset of collision box
	.word	004H		; y offset of collision box
	.word	046H		; x size of collision box
	.word	047H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_ind_flip_kick
	.word	052H+4		; x offset of collision box
	.word	01bH		; y offset of collision box
	.word	03cH		; x size of collision box
	.word	037H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_ind_flip_punch
	.word	049H+4		; x offset of collision box
	.word	019H		; y offset of collision box
	.word	031H		; x size of collision box
	.word	034H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_ind_roundh
	.word	053H		; x offset of collision box
	.word	00aH		; y offset of collision box
	.word	040H		; x size of collision box
	.word	034H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_ind_knee
	.word	045H		; x offset of collision box
	.word	03aH		; y offset of collision box
	.word	044H		; x size of collision box
	.word	035H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_ind_elbow
	.word	043H		; x offset of collision box
	.word	014H		; y offset of collision box
	.word	02bH		; x size of collision box
	.word	016H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_ind_zap
	.word	074H		; x offset of collision box
	.word	024H		; y offset of collision box
	.word	04cH		; x size of collision box
	.word	012H		; y size of collision box
	.word	02805H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_ind_charge
	.word	034H		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	028H		; y size of collision box
	.word	02901H		; strike routine
	.word	01804H		; damage
	.word	sf_squeeze

stk_axe_horz
	.word	05dH		; x offset of collision box
	.word	022H		; y offset of collision box
	.word	047H		; x size of collision box
	.word	016H		; y size of collision box
	.word	02a01H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_axe_up
	.word	058H		; x offset of collision box
	.word	0fffeH		; y offset of collision box
	.word	049H		; x size of collision box
	.word	03eH		; y size of collision box
	.word	02b01H		; strike routine
	.word	01203H		; damage
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
	.word	05fH		; x offset of collision box
	.word	01eH		; y offset of collision box
	.word	051H		; x size of collision box
	.word	02eH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_jax_lokick
	.word	069H		; x offset of collision box
	.word	039H		; y offset of collision box
	.word	049H		; x size of collision box
	.word	014H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_jax_hi_punch
	.word	050H		; x offset of collision box
	.word	01aH		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	020H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
	.word	sf_squeeze

stk_jax_lo_punch
	.word	04eH		; x offset of collision box
	.word	02dH		; y offset of collision box
	.word	03eH		; x size of collision box
	.word	01dH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_jax_sweep
	.word	065H		; x offset of collision box
	.word	07aH		; y offset of collision box
	.word	049H		; x size of collision box
	.word	01fH		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_jax_duck_punch
	.word	051H		; x offset of collision box
	.word	048H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	01dH		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_jax_duck_kickh
	.word	03cH		; x offset of collision box
	.word	055H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	042H		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_jax_duck_kickl
	.word	063H		; x offset of collision box
	.word	078H		; y offset of collision box
	.word	046H		; x size of collision box
	.word	020H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_jax_uppercut
	.word	04bH		; x offset of collision box
	.word	0fff8H		; y offset of collision box
	.word	031H		; x size of collision box
	.word	04cH		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_jax_jump_punch
	.word	058H		; x offset of collision box
	.word	012H		; y offset of collision box
	.word	033H		; x size of collision box
	.word	039H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_jax_jump_kick
	.word	047H		; x offset of collision box
	.word	00fH		; y offset of collision box
	.word	039H		; x size of collision box
	.word	047H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_jax_flip_kick
	.word	058H		; x offset of collision box
	.word	031H		; y offset of collision box
	.word	042H		; x size of collision box
	.word	029H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_jax_flip_punch
	.word	047H		; x offset of collision box
	.word	00fH		; y offset of collision box
	.word	039H		; x size of collision box
	.word	047H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_jax_roundh
	.word	053H		; x offset of collision box
	.word	009H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	036H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_jax_knee
	.word	052H		; x offset of collision box
	.word	02eH		; y offset of collision box
	.word	030H		; x size of collision box
	.word	037H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_jax_elbow
	.word	041H		; x offset of collision box
	.word	013H		; y offset of collision box
	.word	036H		; x size of collision box
	.word	029H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_jax_zap
	.word	073H		; x offset of collision box
	.word	036H		; y offset of collision box
	.word	05cH		; x size of collision box
	.word	010H		; y size of collision box
	.word	02304H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_jax_prezap
	.word	04fH		; x offset of collision box
	.word	02fH		; y offset of collision box
	.word	04aH		; x size of collision box
	.word	01aH		; y size of collision box
	.word	02304H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_noogy
	.word	060H 		; x offset of collision box
	.word	00cH		; y offset of collision box
	.word	036H		; x size of collision box
	.word	028H		; y size of collision box
	.word	00d00H		; strike routine
	.word	00000H		; damage
	.word	sf_squeeze

stk_jax_dash
	.word	05dH		; x offset of collision box
	.word	024H		; y offset of collision box
	.word	044H		; x size of collision box
	.word	016H		; y size of collision box
	.word	02401H		; strike routine
	.word	01603H		; damage
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
	.word	04bH+8		; x offset of collision box
	.word	00fH		; y offset of collision box
	.word	044H		; x size of collision box
	.word	02eH		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_sonya_lokick
	.word	052H+8		; x offset of collision box
	.word	030H		; y offset of collision box
	.word	049H		; x size of collision box
	.word	01fH		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_sonya_duck_punch
	.word	039H+8		; x offset of collision box
	.word	040H		; y offset of collision box
	.word	033H		; x size of collision box
	.word	022H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sonya_duck_kickh
	.word	047H+8		; x offset of collision box
	.word	033H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	03eH		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_sonya_duck_kickl
	.word	062H+8		; x offset of collision box
	.word	06dH		; y offset of collision box
	.word	046H		; x size of collision box
	.word	01eH		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_sonya_uppercut
	.word	04eH		; x offset of collision box
	.word	0fff9H		; y offset of collision box
	.word	031H		; x size of collision box
	.word	043H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_sonya_elbow
	.word	03dH+8		; x offset of collision box
	.word	013H		; y offset of collision box
	.word	029H		; x size of collision box
	.word	027H		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_sonya_knee
	.word	040H+8		; x offset of collision box
	.word	02eH		; y offset of collision box
	.word	02bH		; x size of collision box
	.word	037H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_sonya_roundh
	.word	048H+8		; x offset of collision box
	.word	00dH		; y offset of collision box
	.word	037H		; x size of collision box
	.word	010H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_sonya_sweep
	.word	05dH+8		; x offset of collision box
	.word	06eH		; y offset of collision box
	.word	049H		; x size of collision box
	.word	01bH		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_sonya_flip_kick
	.word	041H+8		; x offset of collision box
	.word	023H		; y offset of collision box
	.word	042H		; x size of collision box
	.word	022H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_sonya_flip_punch
	.word	03eH+8		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	031H		; x size of collision box
	.word	031H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sonya_jump_punch
	.word	03eH+8		; x offset of collision box
	.word	010H		; y offset of collision box
	.word	031H		; x size of collision box
	.word	031H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_sonya_jump_kick
	.word	03eH+8		; x offset of collision box
	.word	015H		; y offset of collision box
	.word	039H		; x size of collision box
	.word	03fH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_sonya_hi_punch
	.word	041H		; x offset of collision box
	.word	012H		; y offset of collision box
	.word	035H		; x size of collision box
	.word	01eH		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
	.word	sf_squeeze

stk_sonya_lo_punch
	.word	048H		; x offset of collision box
	.word	028H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	013H		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_sonya_leg
	.word	06bH+8		; x offset of collision box
	.word	022H		; y offset of collision box
	.word	048H		; x size of collision box
	.word	04dH		; y size of collision box
	.word	00d00H		; strike routine
	.word	00000H		; damage
	.word	sf_duck

stk_sonya_square
	.word	046H		; x offset of collision box
	.word	00fH		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	034H		; y size of collision box
	.word	01d00H		; strike routine
	.word	01b08H		; damage
	.word	sf_squeeze

stk_sonya_zap
	.word	06cH		; x offset of collision box
	.word	023H		; y offset of collision box
	.word	024H		; x size of collision box
	.word	00bH		; y size of collision box
	.word	01e04H		; strike routine
	.word	01303H		; damage
	.word	sf_squeeze

stk_sonya_prezap
	.word	04dH		; x offset of collision box
	.word	023H		; y offset of collision box
	.word	02fH		; x size of collision box
	.word	01bH		; y size of collision box
	.word	01e04H		; strike routine
	.word	01303H		; damage
	.word	sf_squeeze

stk_sonya_bike
	.word	036H		; x offset of collision box
	.word	003H		; y offset of collision box
	.word	039H		; x size of collision box
	.word	035H		; y size of collision box
	.word	00d01H		; strike routine
	.word	01603H		; damage
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
	.word	059H		; x offset of collision box
	.word	00dH		; y offset of collision box
	.word	040H		; x size of collision box
	.word	029H		; y size of collision box
	.word	00006H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_kano_lokick
	.word	06dH		; x offset of collision box
	.word	02aH		; y offset of collision box
	.word	049H		; x size of collision box
	.word	012H		; y size of collision box
	.word	00106H		; strike routine
	.word	01504H		; damage
	.word	sf_squeeze

stk_kano_duck_punch
	.word	056H		; x offset of collision box
	.word	044H		; y offset of collision box
	.word	03aH		; x size of collision box
	.word	015H		; y size of collision box
	.word	0050aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_kano_duck_kickh
	.word	03aH		; x offset of collision box
	.word	034H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	039H		; y size of collision box
	.word	0060bH		; strike routine
	.word	00c03H		; damage
	.word	sf_squeeze

stk_kano_duck_kickl
	.word	05cH		; x offset of collision box
	.word	06dH		; y offset of collision box
	.word	046H		; x size of collision box
	.word	020H		; y size of collision box
	.word	0070aH		; strike routine
	.word	00602H		; damage
	.word	sf_squeeze

stk_kano_uppercut
	.word	04dH		; x offset of collision box
	.word	0fff7H		; y offset of collision box
	.word	035H		; x size of collision box
	.word	046H		; y size of collision box
	.word	00802H		; strike routine
	.word	02409H		; damage
	.word	sf_squeeze

stk_kano_elbow
	.word	041H		; x offset of collision box
	.word	004H		; y offset of collision box
	.word	029H		; x size of collision box
	.word	02dH		; y size of collision box
	.word	00907H		; strike routine
	.word	01003H		; damage
	.word	sf_squeeze

stk_kano_knee
	.word	053H		; x offset of collision box
	.word	026H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	038H		; y size of collision box
	.word	00907H		; strike routine
	.word	01203H		; damage
	.word	sf_squeeze

stk_kano_roundh
	.word	059H		; x offset of collision box
	.word	006H		; y offset of collision box
	.word	037H		; x size of collision box
	.word	036H		; y size of collision box
	.word	00c01H		; strike routine
	.word	01d04H		; damage
	.word	sf_squeeze

stk_kano_sweep
	.word	06cH		; x offset of collision box
	.word	06dH		; y offset of collision box
	.word	04fH		; x size of collision box
	.word	022H		; y size of collision box
	.word	00403H		; strike routine
	.word	01403H		; damage
	.word	sf_duck

stk_kano_flip_kick
	.word	057H		; x offset of collision box
	.word	02eH		; y offset of collision box
	.word	042H		; x size of collision box
	.word	024H		; y size of collision box
	.word	00a01H		; strike routine
	.word	01a07H		; damage
	.word	sf_squeeze

stk_kano_flip_punch
	.word	04dH		; x offset of collision box
	.word	01fH		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	024H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_kano_jump_punch
	.word	04dH		; x offset of collision box
	.word	01fH		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	024H		; y size of collision box
	.word	00b01H		; strike routine
	.word	01005H		; damage
	.word	sf_squeeze

stk_kano_jump_kick
	.word	055H		; x offset of collision box
	.word	024H		; y offset of collision box
	.word	048H		; x size of collision box
	.word	01aH		; y size of collision box
	.word	00b01H		; strike routine
	.word	01306H		; damage
	.word	sf_squeeze

stk_kano_hi_punch
	.word	049H		; x offset of collision box
	.word	00eH		; y offset of collision box
	.word	035H		; x size of collision box
	.word	022H		; y size of collision box
	.word	00211H		; strike routine
	.word	00b03H		; damage
	.word	sf_squeeze

stk_kano_lo_punch
	.word	04fH		; x offset of collision box
	.word	01dH		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	01dH		; y size of collision box
	.word	00311H		; strike routine
	.word	00802H		; damage
	.word	sf_squeeze

stk_kano_swipe
	.word	06dH		; x offset of collision box
	.word	014H		; y offset of collision box
	.word	04bH		; x size of collision box
	.word	043H		; y size of collision box
	.word	01c01H		; strike routine
	.word	01a03H		; damage
	.word	sf_squeeze

stk_kano_roll
	.word	039H		; x offset of collision box
	.word	00eH		; y offset of collision box
	.word	048H		; x size of collision box
	.word	01fH		; y size of collision box
	.word	01a00H		; strike routine
	.word	01805H		; damage
	.word	sf_squeeze

stk_kano_zap
	.word	023H		; x offset of collision box
	.word	-018H		; y offset of collision box
	.word	033H		; x size of collision box
	.word	032H		; y size of collision box
	.word	01b04H		; strike routine
	.word	01303H		; damage
	.word	sf_squeeze

stk_kano_prezap
	.word	06bH		; x offset of collision box
	.word	004H		; y offset of collision box
	.word	04aH		; x size of collision box
	.word	01eH		; y size of collision box
	.word	01704H		; strike routine
	.word	01303H		; damage
	.word	sf_squeeze

stk_kano_shake
	.word	065H		; x offset of collision box
	.word	020H		; y offset of collision box
	.word	03fH		; x size of collision box
	.word	011H		; y size of collision box
	.word	00d00H		; strike routine
	.word	00000H		; damage
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



;weak_damage	.set	00401H
combo_damage	.set	00701H
hard_damage	.set	00a01H

;stk_combo0_weak
;	.word	051H   		; x offset of collision box
;	.word	000H    		; y offset of collision box
;	.word	043H   		; x size of collision box
;	.word	085H   		; y size of collision box
;	.word	0100fH 		; strike routine
;	.word	weak_damage	; damage
; 	.word	0

stk_combo0
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	0100fH 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_hard_combo0
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	0100fH 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo1
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	0110fH 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_hard_combo1
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	0110fH 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo1_stab
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	00f0fH 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo2
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	01212H 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_hard_combo2
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	01212H 		; strike routine
	.word	hard_damage	; damage
 	.word	0

stk_combo2_stab
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	00e12H 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo3
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	01312H 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo4
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	01412H 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo5
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	01512H 		; strike routine
	.word	combo_damage	; damage
 	.word	0


stk_combo6
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	01712H 		; strike routine
	.word	combo_damage	; damage
 	.word	0


stk_combo_klang
	.word	051H   		; x offset of collision box
	.word	00H    		; y offset of collision box
	.word	043H   		; x size of collision box
	.word	085H   		; y size of collision box
	.word	0160fH 		; strike routine
	.word	combo_damage	; damage
 	.word	0

stk_combo_axeup
	.word	05aH		; x offset of collision box
	.word	-002H		; y offset of collision box
	.word	036H		; x size of collision box
	.word	05cH		; y size of collision box
	.word	02b01H		; strike routine
	.word	01804H		; damage
	.word	sf_squeeze

;*************************************************************************

stk_dummy
	.word	10		; x offset of collision box
	.word	10		; y offset of collision box
	.word	10		; x size of collision box
	.word	10		; y size of collision box
	.word	00000H		; strike routine
	.word	00000H		; damage
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

	movi	027H,a0
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

	movi	025H,a5
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