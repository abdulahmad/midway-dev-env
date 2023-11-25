**************************************************************************
*												*
*  video game project:	  mortal kombat 3							*
*												*
*  programmer:		  edward j. boon							*
*												*
*  module: mainequ.asm --  main equate file						*
*												*
*  copyright (c) 1995 Midway Manufacturing							*
*												*
**************************************************************************

; temp
	.global	f_in_dirq,round_loop

	.global	swat_pieces,swat_pieces_end

	.global	robo_data1_start 
	.global	robo_data1_end   
	.global	robo_data2_end   
	.global	robo_data2_start 


	.global	LIFEBOX,FL_TOMB,DROP1
	.global	debug1,round_init,debug2


* mkdisp.asm
	.global	scrtst,floor_code,clock_nums,LIFEBOX,skew_rets
	.global	delobj_lista4
	.global	delobj2,delobj3,scrntl2,objlst2,objlst3,baklst8,baklst9
	.global	ganiof
	.global ofree,worldtlx,ani,scrnlr,scrntl,ani_flag,objlst
	.global insobj2,insobj3,displayon,objstr,setup_score_ram,existobj
	.global	insobj,getobj,delete_shadow,worldtlx8,worldtlx7
	.global worldtlx6worldtlx5,worldtlx4,worldtlx3,worldtlx2
	.global	worldtlx1
	.global	gsagof,scrnlr2,display
	.global worldtlx6,worldtlx5,delobj,last_objlst,dma_interupt
	.global	scrollx,grab_screen,update_pmsg
	.global	scrolly,qdman,worldtly,oinit,qdma
	.global	baklst1
	.global	scrollx1,scrollx2,scrollx3,scrollx4
	.global	scrollx5,scrollx6,scrollx7,scrollx8
	.global	yzsort
	.global	baklst2,baklst3,baklst4,baklst5,baklst6,baklst7,insobj_v
	.global	bkgsagof,dman,kilobj,kilobj2,ani0
	.global	update_knotches,dlists,score_nums_tbl
	.global	qwerty
	.global	draw_boglines

* mkguys.asm
	.global	ochar_ground_offsets,init_p_others
	.global	character_anitabs1
	.global	setup_player_1
	.global	setup_player_2
	.global	death_fade_excludes,setup_players,ground_ochar
	.global	get_walk_info_b,get_walk_info_f
	.global	player_normpal,player_swpal,player_swpal_a0_image
	.global	make_player_1_obj,make_player_2_obj
	.global	character_palettes_1,character_palettes_2
	.global	player_froze_pal
	.global	get_player_palette,ochar_bank_bit

	.global	kano_anitab1,kano_anitab2
	.global	sonya_anitab1,sonya_anitab2
	.global	jax_anitab1,jax_anitab2
	.global	ind_anitab1,ind_anitab2
	.global	sz_anitab1,sz_anitab2
	.global	swat_anitab1,swat_anitab2
	.global	lia_anitab1,lia_anitab2
	.global	robo_anitab1,robo_anitab2
	.global	lao_anitab1,lao_anitab2
	.global	tusk_anitab1,tusk_anitab2
	.global	sg_anitab1,sg_anitab2
	.global	st_anitab1,st_anitab2
	.global	lk_anitab1,lk_anitab2
	.global	mot_anitab1,mot_anitab2
	.global	sk_anitab1,sk_anitab2
	.global	death_fade_excludes


	.global	SBENG1A
	.global	RBCRUSH4BAR
	.global	ROBOFIRE1
	.global	ROBOFIRE2
	.global	ROBOFIRE3
	.global	ROBOFIRE4
	.global	ROBOFIRE5
	.global	ROBOFIRE6
	.global	ROBOFIRE7

	.global	SHDUCKBLOCK1
	.global	SHDUCKBLOCK2
	.global	SHDUCKBLOCK3

	.global	TRZOOM3
	.global	TRZOOM4
	.global	TRZOOM5
	.global	TRZOOM6

	.global	JAXGROWFINA,JAXGROWFINB,JAXBIGBOOT
	.global	ochar_half_bodies,ochar_cutups,ochar_ripped_anis
	.global	ochar_floaters
	.global	KNBROKEN1,SPIKE9,EJBSPIKE,a_earth,SMBOMB1A

* mkmark.asm
	.global	hidden_game,green_grad_pal,ostrich1

* mkend.asm
	.global	mk3_thank_you,mk3_design_team
	.global	show_ending_story,smoke_page,do_the_grad_thang
	.global	red_grad_pal
	.global	show_page_o_the_godz,mk3_cast_o_characters

* mproc.asm
	.global	prcslp
	.globl	kilall,getprc,kill,pinit,sucide,prcslp,prcdsp,prclsp,existp
	.globl	rand,timer,overload,active,free,prcstr
	.globl	sndres,sndresp,qsndrst

* mkinit.asm
	.global	POWERRET
	.global	p1_start_button
	.global	p2_start_button
	.global	set_game_volume,mainlp
	.global	last_switch_ram

* mkboss.asm
	.global	motaro_catagory_table,sk_catagory_table

	.global	motaro_branches,sk_branches

* mkdrone.asm
	.global	random_do,q_is_he_airborn
	.global	q_am_i_cornered,d_front_me_a5
	.global	q_is_he_cornered,q_will_he_reach_me,q_is_he_a_boss,q_am_i_a_boss
	.global	q_is_he_reacting,is_towards_me,is_he_him
	.global	return_to_beware
	.global	drone_proc
	.global	drone_begin
	.global	drone_long_jump
	.global	d_block
	.global	drone_post_duck_hit
	.global	d_getup,d_post_block
	.global	d_beware,d_turnaround
	.global	d_beware_mframew
	.global	drone_entry
	.global	d_land,d_front_me_a5
	.global	d_stalk_a11,d_stance_pause
	.global	boss_branch,d_wait_nonattack,swait_land_jsrp
	.global	stance_wait_yes,stance_wait_no
	.global	wait_proj_spawn,wait_proj_pass

* unzip.asm
	.global	display_zipped_pic

* mkbio.asm
	.global	page_0_zip_setup
	.global	mk3_bio

* mkamode.asm
	.global	amode,background_demo,mk3_cast,gover_amode_entry
	.global	story_print,amode_init_no_score

* mksound
	.global	ochar_sound,borrow_ochar_sound,rsnd_ochar_sound
	.global	hob_ochar_sound
	.global	his_ochar_sound
	.global	send_code_a3,soundup
	.global	triple_sound
	.global	clear_sound_ram
;	.global	punch_sounds
	.global	ochar_sound
	.global	nosounds
	.global	hit_or_blocked_sound

	.global	rsnd_enemy_boom
	.global	rsnd_footstep
	.global	rsnd_stab
	.global	rsnd_big_smack
	.global	rsnd_klang
	.global	rsnd_ground
	.global	rsnd_body_hit
	.global	rsnd_whoosh
	.global	rsnd_smack
	.global	rsnd_med_smack
	.global	rsnd_big_block
	.global	rsnd_small_block
	.global	rsnd_splish,rsnd_sk_bonus_win

	.global	rsnd_big_whoosh
	.global	rsnd_rocks

	.global	sweep_sounds
	.global	group_sound
	.global	his_group_sound

* mkbug.asm
	.global	system_lockup,dpystrt,mk2_court,security_chksum
	.global	TVPATCH,TVPATCHX,security,seccall1,security_chksum2
	.global	colbox_table,victim_box,advance_him,split_screen_line

	.global	background_debug,debug_grid

* ram.asm
	.global	round_zero,round_zero_end

	.global	combo_1,c_amodeloop
	.global	combo_2
	.global	combo_3
	.global	combo_4
	.global	combo_5
	.global	combo_6

	.global	entry_5
	.global	entry_6
	.global	entry_11
	.global	entry_12
	.global	entry_13
	.global	entry_14
	.global	entry_15
	.global	entry_16
	.global	entry_17
	.global	entry_18
	.global	entry_19
	.global	entry_20
	.global	entry_21
	.global	entry_22

	.global	skew_y
	.global	skew_constpal
	.global	skew_stack
	.global	skew_height
	.global	skew_scroll
	.global	skew_dx
	.global	skew_oc
	.global	skew_sag
	.global	skew_calla
	.global	skew_scale

	.global	ground_y
	.global	right_edge
	.global	score_1st
	.global	left_edge
	.global	ceiling_y
	.global	pageaddr
	.global	call_every_tick
	.global	swtemp1
	.global	swtemp2
	.global	swtemp3
	.global	swtemp4
	.global	noflip
	.global	score_ram_end

	.global	f_skew,f_mercy
	.global	f_novel
	.global	f_shadows
	.global	f_auto_erase
	.global	f_doscore
	.global	f_no_lb
	.global	f_no_violence
	.global	f_no_blood
	.global	f_only_t
	.global	f_dark,f_smoke
	.global	f_final_act,l_jaxzap2
	.global	dark_dlist

	.global	l_angle,f_aabuse

	.global	p1_xvel
	.global	p1_shape
	.global	p1_knotch1
	.global	p1_knotch2
	.global	p1_shadadj
	.global	p1_matchw

	.global	p2_xvel
	.global	p2_state
	.global	p2_knotch1
	.global	p2_knotch2
	.global	p2_shadadj
	.global	p2_shape
	.global	p1_bar
	.global	p1_turbo
	.global	p2_bar
	.global	p2_turbo
	.global	p1_state
	.global	p1_char
	.global	p1_obj
	.global	p2_matchw
	.global	p2_obj
	.global	p2_char

	.global	palram
	.global	ptrram
	.global	bpalram
	.global	tick
	.global	fpalram
	.global	irqskye

	.global	p2_bar_xpos	
	.global	p2_turbo_xpos	
	.global	gstate
	.global	p2_bar_view
	.global	irqled
	.global	swstack
	.global	syscopy
	.global	p1_proc
	.global	swstmn
	.global	p1_bcq
	.global	swstst
	.global	p2_proc
	.global	p2_bcq
	.global	p1_bar_view
	.global	p1_boq
	.global	p1_jcq
	.global	p2_boq
	.global	p2_jcq
	.global	p1_turbo_view,p2_turbo_view

	.global	clk_ones	
	.global	f_start_pressed
	.global	clk_tens
	.global	p1_hitq
	.global	f_death
	.global	f_secret
	.global	diff
	.global	f_timeout,f_sans_throws,f_sans_block
	.global	round_1_jsrp
	.global	round_23_jsrp
	.global	c_kahn_dummy
	.global	p1_button
	.global	f_thatsall
	.global	p2_hitq
	.global	f_nosound
	.global	f_norepell
	.global	curback

	.global	l_hp
	.global	l_lp
	.global	l_block
	.global	l_hk
	.global	l_lk
	.global	l_up
	.global	l_down
	.global	l_left
	.global	l_right
	.global	l_run

	.global	c_hp
	.global	c_lp
	.global	c_block
	.global	c_hk
	.global	c_lk
	.global	c_up
	.global	c_down
	.global	c_left
	.global	c_right
	.global	c_run

	.global	l_sz_decoy,l_morph,l_slide,l_liazap,l_net

	.global	map_position
	.global	p1_perfect
	.global	c_amode_bio
	.global	perform
	.global	map_start
	.global	p1_wiar
	.global	c_1p_tries
	.global	f_death2
	.global	p2_score
	.global	p2_button
	.global	p2_perfect
	.global	p2_wiar
	.global	p1_rwon
	.global	c_three
	.global	c_sk_taunt
	.global	battle_num
	.global	f_fade
	.global	p1_map
	.global	round_num
	.global	f_warnsound
	.global	winner_status
	.global	c_goro_dummy
	.global	p1_joq
	.global	p2_rwon
	.global	f_start
	.global	f_colbox
	.global	p1_dont_raise,p2_dont_raise
	.global	p2_joq

	.global	f_fastrun,f_nopower
	.global	f_nopmsg,f_upcut_rec,f_unlim_run
	.global	pf_ram
	.global	p1_ram
	.global	p2_ram
	.global	scrtab
	.global	counter_copy

	.global	baklst8_t
	.global	baklst7_t
	.global	baklst6_t
	.global	baklst5_t
	.global	baklst4_t
	.global	baklst3_t
	.global	baklst2_t
	.global	baklst1_t
	.global	objlst_t
	.global	worldtly_t

	.global	worldtlx8_t
	.global	worldtlx7_t
	.global	worldtlx6_t
	.global	worldtlx5_t
	.global	worldtlx4_t
	.global	worldtlx3_t
	.global	worldtlx2_t
	.global	worldtlx1_t
	.global	worldtlx_t

	.global	br_red
	.global	br_white
	.global	br_blue
	.global	br_yellow
	.global	worldtly1
	.global	worldtly2
	.global	worldtly3
	.global	worldtly4
	.global	worldtly5
	.global	worldtly6
	.global	worldtly7
	.global	worldtly8
	.global	last_dma,dv_hangout

;*************
; debug
	.global	debug_last_proc,debug3
	.global	debug_last_id
	.global	debug_last_a8
	.global	debug_last_a9
	.global	debug_last_a10
	.global	debug_last_a11
;*************

	.global	ladder_scale,ladder_y,ladder_y_vel
	.global	ladder_x,ladder_x_vel
	.global	ladder_left_x,ladder_right_x,ladder_order
	.global	ladder_base


* pall.asm
	.global	getfpal,freepal,findpal,palset,delpal,transfer_palettes
	.global	clrpal,blowpal,getbpal
	.global	getfpal_nocheck

* mkbt.asm
         .global	table_o_mods,train_proc,vs_mod,skdie1_mod,skdie2_mod
	.global	pit_mod
	.global	street_mod,roof_mod,tower_mod,bell2_mod
	.global	MKBRICK,MKBRICK2,UPEVILA,UPEVILB
	.global	BELLHOLE1A,BELLHOLE1B,BELLHOLE2
	.global	STBREAK1,STBREAK2,STBREAK3,TOASTY,THRONEWALL
	.global	build_pit_saw,dlists_down_the_pit
	.global	use_next_y

; temp
	.global	setup_floor_info
	.global	chan2pri,chan1pri,chan3pri,chan4pri,chan5pri
; temp

* bgnd.asm
	.global	buyin_mod
	.global	psel_mod
	.global	vs_mod
	.global	scroll_center,scroll_a9
	.global	ss_20000_neg,ss_20000,background_blast
	.global	pit_scroll_proc,pit_scroll_stopped

; temp
	.global	floor_img

	.global	dmawait,stop_scrolling
	.global	clr_scrn	
	.global	random
	.global	setpproc
	.global	scrclr
	.global	join_in_fade1
	.global	scroller
	.global	do_a11_background
	.global	randu
	.global	randper
	.global	fadeout
	.global	skydown
	.global	multi_plane
	.global	background
	.global	fadein
	.global init_bakmods
	.global	blnkarea
	.global	fillarea
	.global	dlists_objlst,dlists_bogus
	.global	clr_scrn
	.global	random
	.global	setpproc
	.global	scrclr
	.global	join_in_fade1
	.global	randu
	.global	randper
	.global	stop_a8
	.global	fadeout
	.global	skydown
	.global	fadein
	.global	blnkarea
	.global	fillarea

	.global	dlists_subway_to_street
	.global	dlists_bank_to_roof
	.global	dlists_soul_to_tower

* mkhstd.asm
	.global	enter_initials
	.global	does_a0_cut_it
	.global	check_hstd_cmos,print_rankings

* mktext.asm
	.global	rd15font,rd7font,font15_nums
;	.global	vfont1,vfont2
	.global	BIGFONT_1,BIGFONT_2
	.global	dave_small_numbers
	.global	dave_small_font

	.global	p7_centered
	.global	p15_centered,pds_centered,pds_right,pds_left


* bakgnd.asm
	.global	bakclr,bt_null

* joy.asm
	.global	enable_all_buttons,switcheroo_wake
	.global	run_setup,reduce_turbo_bar,zero_turbo_bar
	.global	check_winner_status
	.global	bar_reducer,do_backup,check_block_bit
	.global	get_last_button
	.global	joy_block_loop
	.global	joy_getup_entry
	.global	joy_duck_block_loop
	.global	ochar_begin_calls

	.global	is_stick_up
	.global	is_stick_down
	.global	is_stick_left
	.global	is_stick_right
	.global	is_stick_away,is_stick_toward

	.global	joy_up,joy_down
	.global	jump_up_land_jsrp,jump_up_land_jump
	.global	do_hi_kick
	.global	do_duck
	.global	do_duck_kickl
	.global	do_sweep_kick
	.global	do_duck_kickh
	.global	reaction_exit
	.global	retract_strike
	.global	get_char_ani2
	.global	do_jumpup_kick
	.global	do_jumpup_punch
	.global	do_uppercut,do_flip

	.global	stance_setup
	.global	xfer_otherguy
	.global	do_lo_kick
	.global	get_char_ani
	.global	disable_his_buttons
	.global	stop_me
	.global	is_he_airborn
	.global	damage_to_me
	.global	stuff_buttons
	.global	behind_striker
	.global	upcut_striker
	.global	striker
	.global	get_x_dist
	.global	get_y_dist
	.global	me_in_front
	.global	me_in_back

	.global	bt_jump

	.global	set_x_vel
	.global	am_i_airborn
	.global	joy_entry
	.global	disable_all_buttons
	.global	joystick_in_a0
	.global	bak3mods
	.global	noflip_a2
	.global	endurance_wake
	.global	joy_proc,joy_begin
	.global	bak7mods
	.global	bak8mods
	.global	bak1bits
	.global	bak2bits
	.global	bak3bits
	.global	bak4bits
	.global	bak5bits
	.global	dumbgnd
	.global	bak6bits
	.global	bak1mods
	.global	bak7bits
	.global	bak2mods
	.global	bak8bits
	.global	bak4mods
	.global	bak5mods
	.global	bak6mods
	.global	bgnd_ud1
	.global	am_i_joy

* mkbonus.asm
	.global	bonus_count,play_ending_chord,get_winner_ochar
	.global	get_winner_text

* mkscore.asm
	.global	update_clock_ones,update_clock_tens
	.global	update_win_counters,recharge_bars,position_p2_bar
	.global	damage_s,hits_s

* main.asm
	.global	start_a_game
	.global SETUP,game_over,play3
	.global	play_1_round,game_loop,clear_combo_ram
	.global	advance_curback,game_init

	.global	flash_pmsg,results_of_round
	.global	flash_pmsg2
	.global	all_palettes
	.global	start_shadows
	.global	count_active_players
	.global	init_player_variables
	.global	post_sec_trash
	.global	count_active_players,amode_demo_game
	.global	init_player_variables
	.global	post_sec_trash,winner_tunes
	.global	play_background_tune,master_proc_mercy
	.global	fatality_waiting,mercy_start

* mkr1.asm
	.global	do_round_jsrps,lights_on_hit,lights_on_slam

* mkrepell.asm
	.global	repell

* mkbuyin.asm
	.global	do_buyin
	.global	elminate_buyins

* mkanimal.asm
	.global	do_animality

* mkfriend.asm
	.global	do_friendship

* mkfatal.asm
	.global	do_fatality_1
	.global	do_fatality_2
	.global	do_pit_fatality
	.global	wfe_him,RFIRE7
	.global	death_blow_complete,death_scream
	.global	init_death_blow,sans_repell_for_good
	.global	gravity_ani_ysize
	.global	MK2GAME,cutup_correct_pal

	.global	ochar_mini_falls
	.global	ochar_mini_stunned

	.global	make_db_tone
	.global	death_blow_fader


* mkstat.asm
	.global	do_stationary,do_babality

* moves.asm
	.global	switch_close_jumps,switch_open_jumps
	.global	towards_x_vel
	.global	away_x_vel

	.global	do_st_2_ind,do_st_2_lia
	.global	do_st_2_ind
	.global	do_st_2_sonya
	.global	do_st_2_tusk
	.global	do_st_2_lia

	.global	do_block_hi
	.global	duck_turnaround
	.global	do_flip_punch
	.global	do_flip_kick
	.global	do_duck_punch
	.global	do_body_slam
	.global	do_air_slam
	.global	do_axe_up
	.global	do_quake,do_lia_scream
	.global	do_jump_up,angle_jump_land_jsrp
	.global	init_special
	.global	turn_around
	.global	previous_q_entry
	.global	get_bcq_next_pointer
	.global	get_char_stk
	.global	do_roundhouse
	.global	flight_call
	.global	do_unblock_hi
	.global	init_special_act
	.global	air_init_special
	.global	flight
	.global	xfer_him_to_a10_r
	.global	scream_wake,land_on_yer_feet
	.global	ta_speeds

	.global	do_fast_axe_up,scom_axe_up,stick_look_lr

* mkcombo.asm
	.global	do_knee
	.global	do_elbow

* mkprop.asm
	.global	do_body_propell,air_grab_sleep,cyrax_implode

* mkslam.asm
	.global	body_slam_debug,do_back_breaker
	.global	air_slam_debug
	.global	double_mframew_debug
	.global	xfer_him_to_flipped_pause
	.global	body_slam_init
	.global	air_slam_init	
	.global	drop_down_land,drop_down_land_jump

* mkzap.asm
	.global	do_zap,set_proj_vel
	.global	delete_proj_and_die
	.global	robo_open_chest,robo_close_chest

	.global	get_proj_obj_m
	.global	proj_onscreen_test
	.global	create_proj_proc

* mkstk.asm
	.global	strike_check,strike_check_box
	.global	strike_check_a0
	.global	strike_check_a0_test
	.global	combo_strike_table
	.global	react_xfer_him,cbox_squeeze

* mkreact.asm
	.global	net_struggle,inc_p_hit
	.global	get_block_ani_offset
	.global	land_on_my_back
	.global	shake_n_sound
	.global	r_quake
	.global	r_last_noogy
	.global	r_a10_offset
	.global	r_decoy_freeze,r_bike_kicked_done
	.global	getup_reaction_exit
	.global	combo_sitting_duck
	.global	fall_on_my_back,get_my_hitq
	.global	suspend_wait_action,suspend_wait_wake
	.global	r_pounce2,r_zoom_flipped,r_scream,rhat_wake,r_null_speared
	.global	update_his_hit_queue,stumble_back_vel
	.global	back_to_the_fight
	.global	reaction_land
	.global	avoid_corner_trap

* mksel.asm
	.global	join_in_during_psel
	.global	do_ladder
	.global	player_select
	.global	show_credits
	.global	psel_cursor_loop
	.global	auto_player_select
	.global	ochar_order_mugs
	.global	MKCOIN_01,badge_spinner,a_badge_spin
	.global	TXT_NOVICE,TXT_WARRIOR,TXT_MASTER

* mkvs.asm
	.global	vs_or_ladder,symbol_table,setup_direction

* mkladder.asm
	.global	mk_ladder

* mkfx.asm
	.global	create_fx,shake_a11,a_small_explode,white_flash
	.global	shao_kahn_death_fx,sk_shadow_p

* mkdie.asm
* react.asm
	.global	block_xfers
	.global	reaction_table

* mkcanned.asm
	.global	new_endurance_guy
	.global	player_1_wins,player_2_wins,endurance_trans
	.global	finish_him,victory_animation,dizzy_wake,collapse_on_ground
	.global	psel_victory_animation,lia_victory
	.global	ending_victory_animation

* mkblood.asm
	.global	create_blood_proc
	.global	OIL_P
	.global	SHEEBL_P
	.global	PORK01,a_pork

* mkdeath.asm
	.global	db1_table,db2_table

* util.asm
	.global	fadeblak,srand,fade_all_fast,fade_in_fast,skyup

* mkfade.asm
	.global	fadein_jsrp,fadeproc
	.global	fast_fadeout_jsrp,fadeout_jsrp
	.global	fadein_white_jsrp

	.global	fast_fadein_jsrp
	.global	fade_all_sky
	.global	fade_this_pal,fadeout_mercy

* mkutil.asm

	.global	KNSTANCE1,ochar_fake_stances
	.global	SBSTANCE1
	.global	JXSTANCE1
	.global	INSTANCE1
	.global	SZSTANCE1
	.global	OBSTANCE1
	.global	LIASTANCE1
	.global	RBSTANCE1
	.global	RBSTANCE1
	.global	KLSTANCE1
	.global	TRSTANCE1
	.global	SHSTANCE1
	.global	TSSTANCE1
	.global	LUSTANCE1
	.global	RBSTANCE1
	.global	MOSTANCE1
	.global	BGSTANCE1

	.global	get_ochar_stance1
	.global	bogus_dlist,immune_mpp,unimmune_mpp
	.global	audit_event_check,kill_ocp,multi_dummy_proc
	.global	no_edge_both_players,set_his_noedge
	.global	set_game_state,slave_in_front,refresh_score
	.global	lower_dragon,air_dragon
	.global	get_his_char_long,get_his_dog,get_his_strength
	.global	slave_viso,sonya_zap_pal
	.global	slave_inviso
	.global	add_combo_damage,inc_his_p_hit,dec_his_p_hit,dec_my_p_hit
	.global	zero_my_p_hit
	.global	get_my_matchw,get_his_matchw

	.global	stop_him,back_to_shang_check
	.global	randu_minimum,center_around_me,lineup_on_a9
	.global	get_tsl,distance_off_ground,do_his_next_a9_frame,get_his_dfe
	.global	update_tsl
	.global	calla_for_him,find_ani_part_a14,find_part_a14
	.global	match_ani_points,lineup_1pwm
	.global	delobjp,delobjp2,gmo_proc
	.global	pose_him_a0,pose_a9,pose2_a9
	.global	ani2,get_multi_obj
	.global	create_and_kill,clear_shadow_bit,set_shadow_bit
	.global	clear_bank_bit,set_bank_bit
	.global	fastxfer,murder,takeover_him
	.global	zero_table_o_words,zero_table_o_longs
	.global	set_all_worldtlx
	.global	dallprc,gravity_ani
	.global	am_i_short,adjust_him_a0,adjust_him_xy,adjust_him_x
	.global	away_x_vel_him
	.global	am_i_facing_him,is_he_facing_me
	.global	is_he_joy
	.global	is_he_blocking
	.global	am_i_close_to_edge,is_he_short
	.global	show_scores,sans_repell,sans_repell_3
	.global	insobj2a8
	.global	center_about_x,center_obj_x
	.global	wait_forever,wait_forever_wake
	.global	murder_myoinit,half_x_vel
	.global	boonpal_stuff
	.global	change_oid_list,damage_to_him
	.global	exprc_er
	.global	reset_proc_stack
	.global	object_setup
	.global	gso_dmawnz_ns,gbo_dmawnz
	.global	gso_dmawnz_ns_coor
	.global	gso_dmawnz_coor
	.global	gso_dmawnz_np
	.global	set_xy_coordinates
	.global	murder_myoinit_score
	.global	sans_boonpal
	.global	sync_wait_dma_q
	.global	inc_a0_word
	.global	display_off
	.global	display_on
	.global	set_noscroll,set_nocol,clear_nocol,set_noedge
	.global	set_half_damage,clear_half_damage
	.global	clear_noscroll
	.global	set_inviso,clear_inviso
	.global	clear_ram
	.global	dont_show_scores
	.global	insobja8
	.global	dallobj
	.global	killfx,immune_a0,unimmune_a0
	.global	make_solid_object
	.global	match_him_with_me_f,match_me_with_him
	.global	match_him_with_me
	.global	double_compare
	.global	move_object_list
	.global	freeze_2_pages
	.global	get_single_obj
	.global	delolist
	.global	move_object_list
	.global	freeze_2_pages
	.global	get_single_obj,adjust_xy_a5
	.global	multi_adjust_xy
	.global	delolist
	.global	animate_a0_frames
	.global	face_opponent
	.global	distance_from_ground
	.global	find_part2
	.global	init_anirate
	.global	find_ani_part2,find_ani2_part2
	.global	wait_for_start,wait_for_landing
	.global	is_he_right
	.global	is_he_left
	.global	highest_mpart
	.global	mframew,double_mframew,framew
	.global	double_next_a9
	.global	get_his_action
	.global	get_his_char_word
	.global	get_my_strength
	.global	get_screen_coordinates,screen_a5,world_a5
	.global	do_next_a9_frame
	.global	backwards_ani,backwards_ani2
	.global	p1p2_pick
	.global	lowest_mpart
	.global	get_char_long
	.global	rightmost_mpart
	.global	get_my_height
	.global	get_my_dfe,edge_pick_a0,closest_edge_a5
	.global	leftmost_mpart
	.global	next_anirate
	.global	act_mframew
	.global	get_char_word
	.global	set_no_block,set_noflip,clear_noflip
	.global	ground_player,ground_him
	.global	back_to_normal
	.global	do_first_a9_frame
	.global	wait_for_his_dog
	.global	ochar_jump
	.global	create_if_gone
	.global	olist_noscroll
	.global	solid_object_img
	.global	view_page_0
	.global	view_page_1
	.global	gso_dmawnz
	.global	swpal
	.global	exprc
	.global	gso_dmacnz
	.global	flip_multi,flip_multi_v
	.global	takeover_him_sr
	.global	delete_slave
	.global	get_his_char_ani,get_his_a11_ani
	.global	get_his_char_ani2
	.global	flipped_pause
	.global	ochar_call
	.global	clear_p_ram
	.global	page_0_setup_no_init
	.global	page_0_setup
	.global	freeze_2_pages
	.global	flip_single
	.global	find_ani_last_frame
	.global	animate_a9
	.global	animate2_a9
	.global	find_last_frame
	.global	shake_him_up
	.global	shake_a8_up
	.global	no_edge_limits
	.global	get_curback_mod
	.global	hit_ground_yet,get_rough_hypotenuse
	.global	set_ignore_y,clear_ignore_y
	.global	a8_front_plus_1,a8_back_minus_1,a5_back_minus_1,a5_front_plus_1

* mkani.asm
	.global	frame_a9,ground_multi,pose_him_a9
	.global	lineup_a0_onto_a1

	.global	a_skinny_blood

* diag*.*
	.global	cr_strtp,copy_obj
	.global	go_volume
	.global	diag_jump
	.global	cr_contp
	.global	p_cont
	.global	clear_units
	.global	fs_inits
	.global	p_start
	.global	get_credits
	.global	get_cstr
	.global	mk_octo_menu
	.global	put_adj
	.global	menu_initials
	.global	menu_move_sound
	.global	menu_select_sound
	.global	amode_coin_page

**************************************************************************
*											     *
* 	switch bits									     *
*											     *
**************************************************************************

p1b0	.set	00000000000000000000000000010000b	; bit 4
;MJL - Shifted to player 3 inputs
;p1b1	.set	00000001000000000000000000000000b	; bit 24
p1b1	.set	00000000000000010000000000000000b	; bit 16
;MJL END
p1b2	.set	00000000000000000000000000100000b	; bit 5
p1b3	.set	00000000000000000000000001000000b	; bit 6
;MJL - Shifted to player 3 inputs
;p1b4	.set	00000010000000000000000000000000b   	; bit 25
;p1b5	.set	00000100000000000000000000000000b	; bit 26
p1b4	.set	00000000000000100000000000000000b   	; bit 17
p1b5	.set	00000000000001000000000000000000b	; bit 18
;MJL END


p1sf2	.set	00000000000000000000000000000000b	;

p2b0	.set	00000000000000000001000000000000b	; bit C
;MJL
;p2b1	.set	00010000000000000000000000000000b   ; bit 1C
p2b1	.set	00000000000100000000000000000000b   	; bit 14
;MJL END
p2b2	.set	00000000000000000010000000000000b	; bit D
p2b3	.set	00000000000000000100000000000000b	; bit E
;MJL
;p2b4	.set	00100000000000000000000000000000b   ; bit 1D
;p2b5	.set	01000000000000000000000000000000b	; bit 1E
p2b4	.set	00000000001000000000000000000000b   	; bit 15
p2b5	.set	00000000010000000000000000000000b	; bit 16
;MJL END
p2sf2	.set	00000000000000000000000000000000b	;

;f1b0	.set	p1b0						; bit 4
;f1b1	.set	p1b1					  	; bit 0 - switch 2
;f1b2	.set	p1b2						; bit 5
;f1b3	.set	p1b3						; bit 6
;f1b4	.set	p1b4						; bit 1 - switch 2
;f1sf2	.set	p1sf2						; bit 2 - switch 2
;f2b0	.set	p2b0						; bit C
;f2b1	.set	00000000000000000000000000000100b   ; bit 2 - switch 2
;f2b2	.set	p2b2						; bit D
;f2b3	.set	p2b3						; bit E
;f2b4	.set	00000000000000000000000000001000b   ; bit 3 - switch 2
;f2sf2	.set	00000000000000000000000010000000b	; bit 7 - switch 2


;button_bits	.set	p1b0|p1b1|p1b2|p1b3|p1b4|p1b5
;button_bits2	.set	p2b0|p2b1|p2b2|p2b3|p2b4|p2b5

bb_nostart	.set	p1b0|p1b1|p1b2|p1b3|p1b4|p1b5|p2b0|p2b1|p2b2|p2b3|p2b4|p2b5

m_p1action	.set	p1b0|p1b1|p1b2|p1b3|p1b4|p1b5
m_p2action	.set	p2b0|p2b1|p2b2|p2b3|p2b4|p2b5

sp_bonusv	.set	063H*0100H

**************************************************************************

pow_flipkp	.set	4

**************************************************************************

b_diag	.set	014H	; switch bit = diagnostics
b_vdown	.set	01bH	; switch bit = volume down
b_vup	.set	01cH	; switch bit = volume up

up_vel	.set	-0a0000H
up_grav	.set	08000H


skip_bakmod	.set	1

sns 	.set	32*6	; score node size


scr_control	.set	000H
scr_sag		.set	020H
scr_coor		.set	040H
scr_size		.set	060H


center_x		.set	-2
null_irqskye	.set	444

zoom_damage	.set	020H

close_to_edge	.set	068H	; this constitutes being close to the edge

full_strength	.set	0a6H		; power bars at max
;full_turbo	.set	028H		; turbo bars at max
full_turbo	.set	030H		; turbo bars at max

b_p1block	.set	005H		; player 1 block button bit
b_p2block	.set	00dH		; player 2 block button bit

m_p1blocks	.set	00000000000000000000000000100000b
m_p2blocks	.set	00000000000000000010000000000000b

bit_jleft	.set	2
bit_jright	.set	3
bit_jdown	.set	1
bit_jup		.set	0

m_jup		.set	1
m_jdown		.set	2
m_jleft		.set	4
m_jright		.set	8

b_jdown		.set	1

angle_grav	.set	08000h
sqs		.set	20		; # of entries in switch queue

front_z		.set	050h
back_z		.set	04fh

never_ani	.set	0fffH
dont_touch	.set	13

sf_squeeze	.set	1	; flag: squeeze
sb_squeeze	.set	0	; flag: squeeze
sf_duck		.set	2	; flag: must duck/block to block

gnull		.set	22

ctg		.set	0e0h   	; ceiling to ground (in pixels)


left_padding	.set	03ah
right_padding	.set	030h

ft_kano		.set	0
ft_sonya		.set	1
ft_jax		.set	2
ft_indian	.set	3
ft_subzero	.set	4
ft_swat		.set	5
ft_lia		.set	6
ft_robo1		.set	7
ft_robo2		.set	8
ft_lao		.set	9
ft_tusk		.set	10
ft_sg		.set	11
ft_st		.set	12
ft_lk		.set	13
ft_smoke		.set	14	; SMOKE the hidden ninja character
ft_motaro	.set	15
ft_sk		.set	16
ft_noob		.set	17

*
* special equates
*
ft_endur2a	.set	020H
ft_endur2b	.set	021H
ft_endur2c	.set	022H
ft_endur2d	.set	023H
ft_endur2e	.set	024H
ft_endur2f	.set	025H
ft_endur3a	.set	026H


sp_end		.set	-1
sp_endur		.set	01000H


fat_fatality	.set	1	; fatality type #1 = normal fatality
fat_pit		.set	2	; fatality type #2 = pit
fat_animality	.set	3	; fatality type #3 = animality
fat_friend	.set	4	; fatality type #4 = friendship
fat_baby		.set	5	; fatality type #5 = babality

*
* secret move bits
*
mm_sound		.set	43dh		; menu move sound call
ms_sound		.set	447h		; menu select sound
menu_bong	.set	01095H

**************************************************************************
*											     *
*     process flag equates								     *
*											     *
**************************************************************************
pb_joy		.set	0	; flag: i am a joystick controlled guy
pb_finish	.set	1	; flag: i get to finish other player off!
pb_reacting	.set	2	; flag: i am reacting to some attack
pb_sitduck	.set	3	; flag: i am a sitting duck
pb_special	.set	4	; flag: i am doing a special move (no doubles)
pb_alt_pal	.set	5	; flag: i am using an alternate palette !!
pb_corpse	.set	6	; flag: i am a wasted drone corpse
pb_emperor	.set	7	; flag: i am the emperor
pb_gninja	.set	8	; flag: i am the green ninja


* make sure you clear this if you ever let the other player
* "get his powers back" (ejbejbejb)

pm_joy		.set	001h	; flag: i am a joystick controlled guy
pm_finish	.set	002h	; flag: i get to finish other player off!
pm_reacting	.set	004h	; flag: i am reacting to some attack
pm_sitduck	.set	008h	; flag: i am a sitting duck
pm_special	.set	010h	; flag: i am doing a special move (no doubles)
pm_alt_pal	.set	020h	; flag: i am using an alternate palette !!
pm_corpse	.set	040h	; flag: i am a wasted drone corpse
pm_emperor	.set	080h	; flag: i am the emperor
pm_gninja	.set	0100h	; flag: i am the green ninja

**************************************************************************
*											     *
*     action equates									     *
*											     *
**************************************************************************

* projectile attacks
act_kano_zap	.set	001H	; kano zap
act_sonya_zap	.set	002H	; sonya zap
act_jax_zap	.set	003H	; jax zap
act_jax_zap2	.set	004H	; jax zap
act_ind_zap	.set	005H	; indian zap
act_sky_ice	.set	006H	; sz zap in the sky
act_sw_zap	.set	007H	; fire gun
act_robo_zap2	.set	008H	; robo tracker rocket
act_robo_zap	.set	009H	; robo zap
act_robo_net	.set	00aH	; projectile net
act_lia_anglez	.set	00bH	; lia angle zap !!
act_lao_zap	.set	00cH	; kung lao zap
act_robo_bomb	.set	00dH	; robo bomb
act_tusk_zap	.set	00eH	; tusk zap
act_floor_zap	.set	00fH	; floor zap
act_st_zap1	.set	010H	; shang tsung zap
act_st_zap2	.set	011H	; shang tsung zap
act_st_zap3	.set	012H	; shang tsung zap
act_lk_zap_hi	.set	013H	;
act_lk_zap_lo	.set	014H	;
act_lk_zap_air	.set	015H	;
act_tusk_zap_air	.set	016H	;
act_sg_zap	.set	017H	;
act_swat_bomb_hi	.set	018H	;
act_swat_bomb_lo	.set	019H	;
act_forward_ice	.set	01aH	;
act_lia_forward	.set	01bH	;
act_floor_blade	.set	01cH	;
act_spear	.set	01dH	; smoke spear

* stationary attacks
act_attacks	.set	0100H	; action catagory: attacks
act_hipunch	.set	0101H	; trying to punch hi
act_lopunch	.set	0102H	; trying to punch low
act_hikick	.set	0103H	; trying to kick high
act_lokick	.set	0104H	; trying to kick low
act_rhouse	.set	0105H	; trying round house kick
act_duck_kickh	.set	0106H	; duck kick
act_duck_kickl	.set	0107H	; duck kick low
act_duckpunch	.set	0108H	; duck punch low
act_knee		.set	0109H	; knee attack
act_elbow	.set	010aH	; elbow
act_jupkick	.set	010bH	; jumpup kick
act_juppunch	.set	010cH	; jumpup punch
act_sweep	.set	010dH	; sweep kicking
act_uppercut	.set	010eH	; uppercut punch
act_lia_scream	.set	010fH	;
act_leg_grab	.set	0110H	; sonya leg grab move
act_shake	.set	0111H	; kano shaker
act_noogy	.set	0112H	; noogy punch
act_quake	.set	0113H	; jax-quake
act_axe_horz	.set	0114H	; horizontal axe swipe
act_axe_up	.set	0115H	; up ax
act_combo	.set	0116H	; in middle of combo mode
act_kano_swipe	.set	0117H	; kano swipe up
act_sg_quake	.set	0118H	;
act_laospin	.set	0119H	;
act_rope_pull	.set	011aH	;

* body propelling attacks
act_body_propell	.set	0200H
act_flykick	.set	0200H	; flying punch
act_flypunch	.set	0201H	; flying punch
act_sz_decoy	.set	0202H	;
act_hover	.set	0203H	; lia hover move
act_sbike  	.set	0204H	; sonya bike
act_jax_dash	.set	0205H	; jax dash punch
act_lao_tele	.set	0206H	; kung lao teleport
act_square	.set	0207H	;
act_robo_tele	.set	0208H	; robo tele
act_robo_airgrab	.set	0209H	;
act_tele_explode	.set	020aH	; 
act_kano_roll	.set	020bH	; kano cannonball roll attack
act_lao_angle	.set	020cH	;
act_bike		.set	020dH	;
act_superkang	.set	020eH	;
act_sg_pounce	.set	020fH	;
act_slide	.set	0210H	; slide
act_zoom		.set	0211H	;
act_stick_sweep	.set	0212H	;
act_tusk_blur	.set	0213H	;
act_ind_charge	.set	0214H	;

* non-attacking actions
act_nonattacks	.set	0300H
act_backup	.set	0301H	; getting backup from crouch position
act_duck		.set	0302H	; duck
act_stance	.set	0303H	; stance
act_land		.set	0304H	; landing on ground
act_walkf	.set	0305H	; walk forward
act_postattack	.set	0306H	; just finished an attack
act_walkb	.set	0307H	; walk backward
act_angle_jump	.set	0308H	; jumping at an angle
act_getup	.set	0309H	; getup from a fall
act_jumpup	.set	030aH	; jump straight up
act_pounced	.set	030bH	;

* specific actions
act_stunned	.set	0400H	; stunned
act_morph	.set	0401H	; shang morph
act_reflect	.set	0402H	; indian projectile reflect move
act_backbreak	.set	0403H	; jax back breaker move

* unrelated actions
act_proj_dead	.set	0500H	; dead projectile
act_ignore_proj	.set	0501H	; ignoring projectile
act_dead		.set	0502H	; i am a dead man
act_reacting	.set	0503H	; reacting to a hit
act_bodyslam	.set	0504H	; body slam
act_proj_passed	.set	0505H	; passed projectile
act_legged	.set	0506H	;
act_react_flipk	.set	0507H	;
act_pitting	.set	0508H	; knocking someone into the pit

*sitting duck states
act_sweep_sd	.set	0600H	; sweep sitting duck mode
act_knee_sd	.set	0601H	; post knee sitting duck
act_kroll_sd	.set	0602H	; sitting duck: kano roll 
act_upcut_sd	.set	0603H	; post uppercut sitting duck
act_proj_sd	.set	0604H	; post proj thrower sitting duck
act_icharge_sd	.set	0605H	; indian charge sitting duck
act_upcutted	.set	0606H	; flying in the air uppercutted
act_caught_net	.set	0607H
act_leg_sd	.set	0608H	; sonya leg grab duck
act_hitfall_sd	.set	0609H	; falling from a hit sitting duck
act_elbow_sd	.set	060aH	; post elbow sitting duck
act_ret_kick	.set	060bH	; retract a kick
act_fk_sd	.set	060cH	; flip kick sitting duck
act_spin_sd	.set	060dH	; post spin sitting duck
act_ref_sd	.set	060eH	; reflect sitting duck
act_lao_sd	.set	060fH	; kung lao superkick sd
act_frozen	.set	0610H	; frozen
act_sbike_sd	.set	0611H	; sonya bike sitting duck
act_superk_sd	.set	0612H	;
act_slide_sd	.set	0613H	;
act_stsw_sd	.set	0614H	; stick sweep sitting duk !!
act_screamed	.set	0615H	; caught in lia scream
act_robo_teled	.set	0616H	;
act_blurred	.set	0617H	;
act_kswipe_sd	.set	0618H	; kano swipe sd
act_airpunched	.set	0619H	;
act_sbike_kicked	.set	061aH	;
act_noogy_sd	.set	061bH	;
act_ssd		.set	061cH	;
act_lk_bike_sd	.set	061dH	;
act_zoom_sd	.set	061eH	; kabal zoom sitting duck
act_tusk_blur_sd	.set	061fH	;
act_dizzy	.set	0620H	;
act_sg_quake_sd	.set	0621H	; 
act_robo_tele_sd	.set	0622H	;
act_speared_sd	.set	0623H	;


* blocks
act_blocks	.set	0700H
act_blockhi	.set	0700H	; trying to block high
act_blocklo	.set	0701H	; trying to duck block

**************************************************************************
*											     *
*  joystick/button equates								     *
*											     *
**************************************************************************
sw_hi_punch	.set	0
sw_lo_punch	.set	1
sw_block		.set	2
sw_hi_kick	.set	3
sw_lo_kick	.set	4
sw_run		.set	5

sw_up		.set	6
sw_down		.set	7
sw_left		.set	8
sw_right		.set	9

**************************************************************************
*												*
*		 handy dandy rgb color value equates				*
*												*
**************************************************************************
rgb_black	.set	00000h		; pitch fucking black
rgb_red		.set	07c00h		; blood red
rgb_blue 	.set	0001fh		; blue
rgb_white	.set	07fffh		; white
rgb_grey		.set	0001100011000110b ; game over grey
rgb_yellow	.set	0111111111100000b	; yellow
rgb_green	.set	0000001110000000b	; green
rgb_dark_blue	.set	0000ah		; dark blue


bpal_flash1	.set	00101H		; boonpal flash color #1
bpal_flash2	.set	00202H		; boonpal flash color #2
bpal_flash3	.set	00303H		; boonpal flash color #3
bpal_hot_purple	.set	00404H		; boonpal hot purple
bpal_purple	.set	00505H		; boonpal purple
bpal_green	.set	00606H		; boonpal green
bpal_hot_green	.set	00707H		; boonpal hot green
bpal_bar_color	.set	00808H		; boonpal strength bar color
;bpal		.set	00909H		;
;bpal		.set	00a0aH		;
bpal_blue	.set	00b0bH		; boonpal blue
bpal_yellow 	.set	00c0cH		; boonpal yellow
bpal_red 	.set	00d0dH		; boonpal red
bpal_white 	.set	00e0eH		; boonpal white
bpal_black 	.set	00f0fH		; boonpal black


bog_red		.set	bpal_red+(bpal_red*010000H)
bog_white	.set	bpal_white+(bpal_white*010000H)
bog_blue		.set	bpal_blue+(bpal_blue*010000H)
bog_yellow	.set	bpal_yellow+(bpal_yellow*010000H)


end_stuff	.set	08000h		; marks end of "rbg" table

ani_jump		.set	1		; animation script "jump" command
ani_flip		.set	2		; animation script "flip" command
ani_adjustx	.set	3		; animation script "adjust x" command
ani_adjustxy	.set	4		; animation script "adjust xy" command
ani_nosleep	.set	5		; animation script "skip sleep" command
ani_calla	.set	6		; animation script call routine (next long)
ani_sound	.set	7		; animation script make a sound call
ani_ochar_jump	.set	8		; animation script ochar conditional jump
ani_flip_v	.set	9		; animation script vertical flip
ani_offset_xy	.set	10		; animation script offset xy
ani_sladd	.set	11		; animation script add slave
ani_slani	.set	12		; animation script slave animate
ani_swpal	.set	13		; animation script switch to next img pal
ani_slani_sleep	.set	14		; animation script sleepy time
ani_ochar_sound	.set	15
ani_lastcom	.set	15		; last animation command

ps_active	.set	1		; player state: active
ps_buyin		.set	2		; player state: buyin
ps_psel		.set	3		; player state: selecting a fighter
ps_post_psel	.set	4		; player state: selected a fighter
; when adding entries, add to jump table

**************************************************************************
*												*
*			  process id's                                  *
*												*
**************************************************************************
pid_diagcoin	.set	0	; diagnostix coin proc

*
* constant running procs
*
pid_p1		.set	1	; player 1 process (be careful if these
pid_p2		.set	2	; player 2 process  variables are changed)
pid_master	.set	3	; master game flow process
pid_scroll	.set	4	; scroll process
pid_backg	.set	5	; background process
pid_bani		.set	6	; background object animator
pid_repell	.set	7	; repell players proc
pid_flasher	.set	9	; player message flasher
pid_p1sel	.set	00aH	; player 1 select process
pid_p2sel	.set	00bH	; player 2 select process
pid_cred		.set	00cH	; show credits proc
pid_initials	.set	00dH	; enter initials proc
pid_amode	.set	00eH	; attract mode process
pid_cycle	.set	00fH	; color cycler
pid_oct		.set	010H	; octopus
pid_inviso1	.set	011H	; player 1 inviso proc
pid_inviso2	.set	012H	; player 2 inviso proc
pid_target1	.set	013H	; robo rocket target
pid_target2	.set	014H	; robo rocket target
pid_danger1	.set	016H	; player 1 danger proc
pid_danger2	.set	017H	; player 2 danger proc
pid_smoker	.set	018H	; proc to constantly smoke a dude
pid_1_puff	.set	019H	; 1 puff o smoke
pid_pong_speed	.set	01aH	; pong speed up
pid_green_splash	.set	01bH	;
pid_auto_cycle	.set	01cH	; auto select color cycler
pid_dark		.set	01dH	; darkness fighting proc
pid_comb		.set	01eH	; combination proc
pid_r1		.set	01fH	;
pid_robo_bomb	.set	020H	; cyrax bomb !!
pid_switcheroo	.set	021H	;
pid_psycho	.set	022H	;
pid_smoke_timer	.set	023H

*
* 100 = special effects procs
*
pid_fx		.set	0100H	; generic special f/x
pid_fade		.set	0101H	; fade proc
pid_grow		.set	0102H	; fx grower proc
pid_shaker	.set	0103H	; earth shaker proc
pid_trail1	.set	0104H	; body trail (shadow kick)
pid_scream_wave	.set	0105H	;
pid_shadow1	.set	0106H	; shadow "borrow" proc for player 1
pid_shadow2	.set	0107H	; shadow "borrow" proc for player 2
pid_selspeech	.set	0108H	; player select speech proc
pid_mpo		.set	0109H	; multipart object process
pid_smoke	.set	010aH	; puff of smoke
pid_explode	.set	010bH	; explosion
pid_bolt		.set	010cH	; robo dizzy bolt
pid_poof		.set	010dH	; smoke poof proc
pid_sonic	.set	010eH	; sonic wave proc
pid_forden	.set	010fH	; forden peeker
pid_blast	.set	0110H	; background blast proc
pid_bones	.set	0111H
pid_robo_limb	.set	0112H
pid_rock		.set	0113H
pid_gravp	.set	0114H	; gravity piece
pid_hat_ring	.set	0115H
pid_comment	.set	0116H
pid_combo_msg	.set	0117H
pid_target	.set	0118H
pid_fadepal	.set	0119H
pid_fx_charge	.set	011aH
pid_fblast	.set	011bH
pid_mercy	.set	011cH
pid_trail2	.set	011dH	; body trail (shadow kick)


*
* 200 = procs which control prop objects
*
pid_blood	.set	0201H	; blood spirts
pid_head		.set	0202H	; decapped head
pid_summon	.set	0203H
pid_decoy1	.set	0204H	; sz decoy
pid_decoy2	.set	0205H	; sz decoy
pid_blade	.set	0206H	; 
pid_dead_blade	.set	0207H	; 


*
* 300 = switch spawned procs
*
pid_switch1	.set	0300H	; switch spawned process !!
pid_switch2	.set	0301H	; switch spawned process !!

*
* 700 = player 1 projectile procs
*
pid_proj1	.set	0700H	; generic projectile !!
pid_hat1		.set	0701H	; kung lao hat proc #1
pid_orb1		.set	0702H	; reptile orb
pid_ice1		.set	0703H	; ice proc #1
pid_p1rocket1	.set	0704H
pid_p1rocket2	.set	0705H

*
* 800 = player 2 projectile procs
*
pid_proj2	.set	0800H	; generic projectile !!
pid_hat2		.set	0801H	; kung lao hat proc #2
pid_orb2		.set	0802H	; reptile orb
pid_ice2		.set	0803H	; ice proc #2
pid_p2rocket1	.set	0704H
pid_p2rocket2	.set	0705H


pid_volume	.set	07000H

*
* 8000 = coin switch pids
*
pid_lc		.set	08c00H		; left coin	
pid_cc		.set    08c02H		; center coin	
pid_rc		.set    08c04H		; right coin	
pid_xc		.set	08c06H		; fourth coin slot
pid_slam         .set    08c08H	 	; slam tilt process
pid_coinctr	.set	08c0aH		; coin counter process
* JAKE START
pid_dbv		.set	08c0cH		; dbv coin in
* JAKE END
pid_print	.set	0800cH		; background printer process
pid_diag		.set	0800dH		; diagnostics process
pid_secbust	.set	0800eH		; sec bust proc

**************************************************************************
*											     *
*                       object id's							     *
*											     *
**************************************************************************
oid_blood	.set	pid_blood
oid_p1		.set	pid_p1
oid_p2		.set	pid_p2
oid_fx		.set	pid_fx		; special f/x
oid_head		.set	pid_head
oid_grow		.set	pid_grow
oid_bones	.set	pid_bones
oid_1_puff	.set	pid_1_puff
oid_r1		.set	pid_r1
oid_combo_msg	.set	pid_combo_msg
oid_shadow1	.set	pid_shadow1		; rev2.1 change
oid_shadow2	.set	pid_shadow2		; rev2.1 change

************************************************************************
*
*
oid_robo_limb	.set	0200H
oid_bolt		.set	0300H

* when adding more proc's for projectiles make sure you update
* wait_for_prj routine

*
* 700 = projectiles
*
oid_sbzap1	.set	0700H
oid_sbzap2	.set	0701H
oid_slow_proj	.set	0709H	; slow reptile projectile
oid_hat2		.set	070aH	; hathead projectile


*
* 800 = non-game related
*
oid_cbox		.set	0800H	; collision box
oid_text		.set	0801H
oid_cursor1	.set	0802H	; player 1 select cursor
oid_cursor2	.set	0803H	; player 2 select cursor
oid_buyin	.set	0804H	; buyin object
oid_vbox		.set	0805H

gs_amode		.set	001h	; game is in attract mode
gs_fighting	.set	002h
gs_buyin		.set	003h
gs_psel		.set	004h	; fighter select mode
gs_bonus		.set	005h	; bonus count state
gs_pfsetup	.set	006h	; pre-fight setup state
gs_round_intro	.set	007h	; round intro
gs_diag		.set	008h	; game is in diagnostics/audits/adjustments
gs_vs		.set	009h	; vs screen
gs_initials	.set	00ah	; enter initials
gs_gameover	.set	00bh	; game over
gs_octopus	.set	00ch	; octopus mode
gs_post_psel	.set	00dh	; post player select mode
gs_barge		.set	00eh	; player barging in mode
gs_sec_intro	.set	00fh	; intro secret
gs_debug		.set	010H
gs_pitfall	.set	011H	; fallin down the pit
gs_space_game	.set	012H
gs_unlock_smoke	.set	013H	; unlock smoke mode


; when adding entries, add to jump table

*
* process data structure
* note: make sure this is evenly divisible by 32
*
plink	.set	0		;link to next 32 bits
procid	.set	20h		;uhw process id 16 bits
ptime	.set	30h		;uhw sleep time x 16msec 16 bits
psptr	.set	40h		;uhl process stack pointer 32 bits
pa11	.set	60h		;uhl	registers saved
pa10	.set	80h		;uhl
pa9	.set	0a0h		;uhl
pa8	.set	0c0h		;uhl
pwake	.set	0e0h		;uhl
pdata	.set	100h		;process data store
psdata	.set	3d0h		;process stack data (pc, a8-a11)
;prcsiz	.set	5a0h		;end of data structure
prcsiz	.set	6f0h		;end of data structure
nproc	.set	168		;number of processes

**************************************************************************
*											     *
*   process storage equates								     *
*											     *
**************************************************************************
p_joyport	.set	pdata		; (32) - joystick switch port location
p_butport	.set	pdata+020h	; (32) - button port
p_otherguy	.set	pdata+040h	; (32) - other guys object
p_otheract	.set	pdata+060h	; (16) - drone info: other dudes last action
p_otherproc	.set	pdata+070h	; (32) - other guys process
p_slave		.set	pdata+090h	; (32) - slave object
p_anitab		.set	pdata+0b0h	; (32) - current animation table
p_anirate	.set	pdata+0d0h	; (16) - animation speed
p_anicount	.set	pdata+0e0h	; (16) - animation counter
p_action		.set	pdata+0f0h	; (16) - current action
p_ganiy		.set	pdata+100h	; (16) - grounded animation point y
p_flags		.set	pdata+110h	; (16) - more flags
p_downcount	.set	pdata+120h	; (16) - # ticks i have been ducking
p_store1		.set	pdata+130h	; (32) - long word storage #1
p_store2		.set	pdata+150h	; (32) - long word storage #2
p_store3		.set	pdata+170h	; (32) - long word storage #3
p_store4		.set	pdata+190h	; (32) - long word storage #4
p_store5		.set	pdata+1b0h	; (32) - long word storage #5
p_store6		.set	pdata+1d0h	; (32) - long word storage #6
p_store7		.set	pdata+1f0h	; (32) - long word storage #7
p_store8		.set	pdata+210h	; (32) - long word storage #8
p_dronevar1	.set	pdata+230h	; (32) - drone variable #1
p_stk		.set	pdata+250h	; (16) - strike table I am using (ejbpatch-use only 1 word)
p_hitby		.set	pdata+260h	; (16) - i was "hit by" this last
p_damage		.set	pdata+270h	; (16) - damage (for combo message)
p_power		.set	pdata+280h	; (8)  - power (for invincibilities)
p_block		.set	pdata+288h	; (8)  - block count
p_hit		.set	pdata+290h	; (8)  - hit count
p_end		.set	pdata+290h+8	; end of p info

**************************************************************************
*											     *
*  drone variables (local)								     *
* 											     *
*  warning: when adding local equates make sure they are not referenced  *
*           by their global name anywhere in this module !!!		     *
*											     *
**************************************************************************
p_beware_return	.set	p_joyport	; drone_beware return address
p_beware_a10	.set	p_butport	; a10 when drone_beware was called
p_beware_a11	.set	p_store6	; a11 when drone_beware was called

p_dcount		.set	p_store4+16		; local: generic drone counter
p_acc		.set	p_store5		; local: acceleration value
p_dsave1		.set	p_store7		; local: generic save #1
p_maxproj	.set	p_dronevar1		; local: # of projectiles allowed
p_egoro		.set	p_downcount		; local: # of times emp was goro

**************************************************************************
*											     *
*  palette allocator equates								     *
* 											     *
*  palette allocation ram								     *
*  for each color palette id 32 bits, palette count 16 bits		     *
*  if palcnt00H palette is allocated, if palcnt=0 palette is free	     *
*											     *
**************************************************************************
;numpal	.set	60	;number of dynamics allocated palettes
;nmfpal	.set	25	;number of foreground palettes
;nmbpal	.set	35	;number of background palettes

numpal	.set	90	;number of dynamics allocated palettes
nmfpal	.set	35	;number of foreground palettes
nmbpal	.set	55	;number of background palettes

palid	.set	0	; palette i.d.
palcnt	.set	020h	; palette allocation count
paltime	.set	030h	; @tick value when this palette was deleted
palrsiz	.set	040h	; size of palette allocation ram


*
* palette transfer ram
*
pldcnt	.set	0	;color count
palsrc	.set	010h	;source address of palette color data 	
paldest	.set	030h	;destination palette|start color
ptrsiz	.set	040h	;size of each cell
numptr	.set	24	;number of transfers allowed

**************************************************************************
*											     *
*  ascii font miscellaneous equates							     *
*											     *
**************************************************************************
f15sp	equ	7eh		;font 15 sp character, for hs entry
f15rub	equ	f15sp+1		;font 15 rub character,for hs entry
f15end	equ	f15rub+1	;font 15 end character,for hs entry
f15rquot equ	f15end+1	;font 15 right quote


