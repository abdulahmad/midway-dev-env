**************************************************************************
*											     *
*  video game project:	MK3									*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: main.asm ---  main game flow							*
* 											     *
*  copyright (c) 1995 Midway Manufacturing							*
*											     *
**************************************************************************
	.file	"mkend.asm"
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
	.include	diagaudn.asm
	.include	stringh.asm
	.include	mkteam.tbl
	.text

	.ref	f_adc_s



show_page_o_the_godz
	calla	murder_myoinit_score
	calla	display_off
	sleep	3

	calla	view_page_1
	calla	oinit
	calla	page_0_zip_setup
	calla	view_page_1

	movi	02bH,a0
	movi	(01000H*01bH)+(8*0),a10	; a10 = coordinates of movie clip
	jsrp	display_zipped_pic

	movi	011H,a0
	sll	5,a0
	addi	table_o_mods,a0
	move	*a0,a0,l
	calla	init_bakmods
	calla	multi_plane

	movi	000a600c7H,a9
	movi	txt_gods,a8
	clr	a6
	move	a6,@f_auto_erase,w
	jsrp	pds_centered

	calla	display_on
	sleep	3
	calla	display_off
	calla	view_page_0
	sleep	040H*15
	retp

txt_gods
	.string "YOU HAVE PROVEN TO BE THE SUPREME\n"
	.string "MORTAL KOMBAT WARRIOR. THE ELDER\n"
	.string "GODS NOW DECEND UPON YOUR WORLD TO\n"
	.string "GRANT YOU ETERNAL POWER.\n\n"
	.string	"MORE KOMBAT . . . . FALL OF 95"
	.byte	0
	.even

;***********************************

show_ending_story
	move	a0,*a13(p_store7),w

	calla	murder_myoinit_score
	calla	display_off
	sleep	3

	calla	view_page_1
	calla	oinit
	calla	page_0_zip_setup
	calla	view_page_1

	move	*a13(p_store7),a0,w
	addi	013H,a0
	movi	(01000H*010H)+(8*69),a10	; a10 = coordinates of movie clip
	jsrp	display_zipped_pic

	movi	018H,a0
	sll	5,a0
	addi	table_o_mods,a0
	move	*a0,a0,l
	calla	init_bakmods
	calla	multi_plane

	movi	000a000c7H,a9
	move	*a13(p_store7),a8,w
	sll	6,a8
	addi	ochar_endings,a8
	move	*a8,a8,l
	movi	dlists_bogus,a0
	move	a0,@dlists,l

;	jauc	story_print

	clr	a6
	move	a6,@f_auto_erase,w
	jsrp	pds_centered

	calla	display_on
	sleep	3
	calla	display_off
	calla	view_page_0

	sleep	040H*15

	calla	display_on
	movi	oid_text,a0
	calla	dallobj
	sleep	6

	movi	000a000c7H,a9
	move	*a13(p_store7),a8,w
	sll	6,a8
	addi	ochar_endings,a8
	addi	32,a8
	move	*a8,a8,l
	jsrp	pds_centered
	sleep	2
	calla	display_off
	sleep	040H*15
	retp

;	jruc	smooth_black_retp
;	calla	display_on
;	sleep	3
;	calla	view_page_0
;	sleep	040H*13
;	retp

ochar_endings
	.long	txt_kano_ending1
	.long	txt_kano_ending2
	.long	txt_sonya_ending1
	.long	txt_sonya_ending2
	.long	txt_jax_ending1
	.long	txt_jax_ending2
	.long	txt_nightwolf_ending1
	.long	txt_nightwolf_ending2
	.long	txt_subero_ending1
	.long	txt_subero_ending2
	.long	txt_stryker_ending1
	.long	txt_stryker_ending2
	.long	txt_sindel_ending1
	.long	txt_sindel_ending2
	.long	txt_sektor_ending1
	.long	txt_sektor_ending2
	.long	txt_cyrax_ending1
	.long	txt_cyrax_ending2
	.long	txt_lao_ending1
	.long	txt_lao_ending2
	.long	txt_kabal_ending1
	.long	txt_kabal_ending2
	.long	txt_sheeva_ending1
	.long	txt_sheeva_ending2
	.long	txt_st_ending1
	.long	txt_st_ending2
	.long	txt_lk_ending1
	.long	txt_lk_ending2
	.long	txt_smoke_ending1
	.long	txt_smoke_ending2

;*****************

txt_kano_ending1
	.string "WHEN SHAO KAHN LETS KANO LIVE HE FAILS TO\n"
	.string "REALIZE THE RESOURCEFULNESS OF THE SCHEMING\n"
	.string "HUMAN. KANO LURES KAHN'S ARMY AWAY ON A\n"
	.string "FALSE MISSION; THEN NUKES THEM USING A\n"
	.string "STOLEN WEAPON. HE FIGHTS THE REMAINING\n"
	.string "WARRIORS AND FINALLY DEFEATS KAHN HIMSELF.\n"
	.byte	0
	.even

txt_kano_ending2
	.string "KANO'S TRUE INTENTION IS TO TAKE OVER THE\n"
	.string "SOULS WHICH KAHN ONCE POSSESSED. BUT KANO IS\n"
	.string "UNABLE TO CONTROL THE SPIRITS AS THEY ESCAPE\n"
	.string "AND ATTACK HIM. RUMOURED TO HAVE SUFFERED A\n"
	.string "VIOLENT DEATH KANO WAS IGNORANT OF THE FACT\n"
	.string "THAT HE SAVED THE WORLD HE TRIED TO CONQUER.\n"
	.byte	0
	.even

txt_sonya_ending1
	.string "SONYA DEFEATS HER ARCH ENEMY KANO HIGH\n"
	.string "ATOP A SKYSCRAPER NEAR SHAO KAHN'S\n"
	.string "FORTRESS. SHE THEN COMES FACE TO FACE\n"
	.string "WITH THE EMPEROR HIMSELF.\n"
	.string "IN AN INCREDIBLE DISPLAY OF COURAGE\n"
	.string	"SONYA WINS.\n"
	.byte	0
	.even

txt_sonya_ending2
	.string "WHEN THE WORLD RETURNS TO ITS NORMAL STATE,\n"
	.string "SONYA HAS NO TROUBLE CONVINCING HER\n"
	.string "SUPERIORS TO FORM THE OUTER WORLD\n"
	.string "INVESTIGATION AGENCY; DEVOTED TO PROTECTING\n"
	.string "THE EARTH AGAINST POSIBLE FUTURE INVASIONS\n"
	.string	"FROM OTHER REALMS"
	.byte	0
	.even

txt_jax_ending1
	.string "THE SECOND TIME JAX BATTLES THE FORCES OF\n"
	.string "SHAO KAHN HE COMES PREPARED. THOUGHT TO BE\n"
	.string "THE STRONGEST MAN ON EARTH HE HAS NO\n"
	.string "PROBLEM PROVING IT; FIRST BY BEATING KAHN'S\n"
	.string "ARMIES THEN BY DEFEATING THE EMPEROR\n"
	.string	"HIMSELF."
	.byte	0
	.even

txt_jax_ending2
	.string "WHEN THE WORLD REVERTS BACK TO NORMAL JAX\n"
	.string "AND SONYA START THE OUTER WORLD INVESTIGATION\n"
	.string "AGENCY. JAX RUNS THE EXPLORATORY DIVISION\n"
	.string	"WHICH LEARNS TO OPEN PORTALS THROUGH SCIENCE\n"
	.string "RATHER THAN MAGIC. HE LEADS THE FIRST EX-\n"
	.string "PEDITION INTO A MYSTERIOUS NEW REALM.\n"
	.byte	0
	.even


txt_sindel_ending1
	.string "SINDEL RECIEVES VISIONS OF HER TRUE PAST\n"
	.string "AND TURNS AGAINST SHAO KAHN. SHE DISCOVERS\n"
	.string "THAT HER TRUE KING WAS NAMED JERROD. THEY\n"
	.string "ONCE HAD A DAUGHTER NAMED KITANA AND RULED\n"
	.string "A REALM CALLED EDENIA; BEFORE KAHN TOOK IT\n"
	.string "AWAY IN THEIR OWN MORTAL KOMBAT.\n"
	.byte	0
	.even

txt_sindel_ending2
	.string "HE USED SINDEL AS A PAWN IN HIS QUEST FOR\n"
	.string "EARTH AND TOOK KITANA AS HIS OWN DAUGHTER.\n"
	.string "BUT IN DEFEATING SHAO KAHN SINDEL FREES\n"
	.string "THE EARTH. IN DOING SO SHE ALSO LIBERATES\n"
	.string "EDENIA AND INSURES A REUNION WITH HER\n"
	.string "10,000 YEAR OLD DAUGHTER- KITANA.\n"
	.byte	0
	.even


txt_nightwolf_ending1
	.string	"NIGHTWOLF HELPS OTHER EARTH WARRIORS ESCAPE\n"
	.string "TO HIS SACRED LAND. ONCE THERE THEY REGROUP\n"
	.string "AND FORM A PLAN OF ATTACK AGAINST SHAO\n"
	.string "KAHN'S INVASION. NIGHTWOLF HAS TRAINED HARD\n"
	.string "FOR THIS BATTLE ; FINALLY HE FACES SHAO\n"
	.string "KAHN AND EMERGES VICTORIOUS.\n"
	.byte	0
	.even

txt_nightwolf_ending2
	.string "WHEN THE EARTH RETURNS TO ITS NORMAL STATE,\n"
	.string "NIGHTWOLF PEACEFULLY REGAINS THE LANDS HIS\n"
	.string "NATIVE-AMERICAN PEOPLE LOST OVER MANY YEARS.\n"
	.string "THEY ESTABLISH THEIR OWN PROUD NATION AND\n"
	.string "SOON BECOME THE GREAT LEADERS OF EARTH.\n"
	.byte	0
	.even


txt_subero_ending1
	.string "IN VICIOUS BATTLE SUB-ZERO FACES CYRAX AND\n"
	.string "SEKTOR; BUT NOT ALONE. HE FINDS HIS THIRD\n"
	.string "LIN KUEI ASSASSIN- THE ELUSIVE SMOKE.\n"
	.string "BEFORE AUTOMATION SMOKE AND SUB-ZERO WERE\n"
	.string "ALLIES. SUB-ZERO HELPS SMOKE RECALL HIS\n"
	.string "PAST AND GAINS HIM AS AN ALLY ONCE AGAIN.\n"
	.byte	0
	.even

txt_subero_ending2
	.string "SUB-ZERO DEFEATS HIS CYBORG ASSASSINS WITH\n"
	.string "THE HELP OF SMOKE AND FINDS IT TAKES ALL\n"
	.string "HIS OWN INNER STRENGTHS TO DEFEAT KAHN AND\n"
	.string "HIS OUTWORLD MINIONS. THE FORMER NINJA ONCE\n"
	.string "AGAIN DISAPPEARS INTO THE SHADOWS.\n"
	.string "HIS LEGACY KNOWN ONLY BY A SELECT FEW."
	.byte	0
	.even

txt_sektor_ending1
	.string "AFTER EVENTUALLY TERMINATING SUB-ZERO,\n"
	.string "SEKTOR IS ATTACKED BY SHAO KAHN'S ARMY.\n"
	.string "UNFAMILIAR WITH THE OUTWORLD WARRIORS,\n"
	.string "SEKTOR FIGHTS BACK. HE TARGETS KAHN AND\n"
	.string "ALL OUTWORLD BEINGS AS THREATS TO THE\n"
	.string	"LIN KUEI."
	.byte	0
	.even

txt_sektor_ending2
	.string "KAHN'S MINIONS ARE NO MATCH FOR SEKTOR WHO\n"
	.string "FIGHTS HIS WAY INTO THE FORTRESS. ONCE INSIDE\n"
	.string "SEKTOR INITIATES HIS SELF DESTRUCT SEQUENCE.\n"
	.string "THE RESULTING EXPLOSION IS SO MASSIVE THAT IT\n"
	.string "CLOSES THE PORTAL AND RETURNS EARTH BACK TO\n"
	.string "NORMAL."
	.byte	0
	.even

txt_cyrax_ending1
	.string "CYRAX IS CAPTURED BY SUB-ZERO AND\n"
	.string "REPROGRAMED WITH NEW ORDERS; DESTROY\n"
	.string "SHAO KAHN. WITH KAHN UNABLE TO DETECT\n"
	.string "THE ASSASSIN'S SOULLESS PRESENCE, CYRAX\n"
	.string "DELIVERS A SUCCUSSFUL SNEAK ATTACK.\n"
	.byte	0
	.even

txt_cyrax_ending2
	.string "BUT, AFTER ELIMINATING KAHN AND SAVING EARTH\n"
	.string "CYRAX AWAITS NEW ORDERS FROM HIS LIN KUEI\n"
	.string "HEADQUARTERS. THE ORDERS NEVER COME AND\n"
	.string "CYRAX MALFUNCTIONS. HE ENDS UP STRANDED IN\n"
	.string "THE MIDDLE OF A VAST DESERT, BLINDLY\n" 
	.string "HEADING TOWARDS HIS BASE.\n"
	.byte	0
	.even

txt_sheeva_ending1
	.string "WHILE SHEEVA SERVES HER MASTER ON EARTH HER\n"
	.string "RACE OF SHOKAN ARE BEING PUNISHED ON THE OUT-\n"
	.string "WORLD. KAHN NOW FAVORS MOTARO'S RACE OF\n"
	.string "CENTAURS AND AIDS THEM IN DEFEATING THE\n" 
	.string "SHOKAN. AFTER LEARNING OF THESE EVENTS\n" 
	.string "SHEEVA TURNS ON HER MASTER."
	.byte	0
	.even

txt_sheeva_ending2
	.string "SHE DEFEATS MOTARO AND IN A RAGE BRINGS\n"
	.string "DOWN KAHN. IN FREEING THE EARTH SHE ALSO\n"
	.string "FREES THE OUTWORLD.	SHE THEN RETURNS HOME\n"
	.string "AND WORKS TO RESTORE THE PRIDE AND RESPECT\n"
	.string	"OF HER RACE."
	.byte	0
	.even


txt_kabal_ending1
	.string "AFTER RETURNING FROM NEAR DEATH KABAL\n"
	.string "SWEARS REVENGE AGAINST HIS ATTACKERS. HE\n"
	.string "FIGHTS ALONGSIDE THE OTHER EARTH WARRIORS.\n"
	.string "WHEN HE DEFEATS MOTARO AND THE MIGHTY SHAO\n" 
	.string "KAHN HE PROVES THAT HE TRULY IS THE CHOSEN\n"
	.string "ONE.\n"
	.byte	0
	.even

txt_kabal_ending2
	.string "BEFORE THE INVASION KABAL LIVED A LIFE OF\n"
	.string "CRIME. HE WAS ONCE A MEMBER OF THE BLACK\n" 
	.string "DRAGON ALONG WITH KANO. NOW KABAL DEVOTES\n" 
	.string "HIS LIFE TO FIGHTING INJUSTICE; HE WILL GIVE\n" 
	.string "CRIMES INNER CIRCLES A NEW REASON TO FEAR.\n"
	.byte	0
	.even

 
txt_stryker_ending1
	.string "IGNORANT OF WHY HIS SOUL WAS SPARED FROM\n"
	.string "THE OUTWORLD INVASION, STRYKER RECEIVES A\n"
	.string "VISION FROM RAIDEN. HE IS INSTRUCTED TO\n"
	.string "TRAVEL WEST. HE EVENTUALLY MEETS THE REST\n"
	.string "OF EARTH'S WARRIORS AND LEARNS THE TRUE\n"
	.string "MEANING OF HIS SURVIVAL.\n"
	.byte	0
	.even

txt_stryker_ending2
	.string "HE TRAVELS BACK TO THE CITY HE SWORE TO\n"
	.string "PROTECT. KAHN IS UNFAMILIAR WITH THIS NEW\n"
	.string "KOMBATANT AND IS CAUGHT OFF GUARD. STRYKER\n"
	.string "DEFEATS THE WARLORD AND SAVES THE ENTIRE\n"
	.string "PLANET. THE CHAOS THAT CONSUMED THE CITY IN\n"
	.string "THE HOURS BEFORE THE INVASION ARE GONE.\n"
	.byte	0
	.even

txt_lao_ending1
	.string "WHEN KAHN INVADES EARTH, KUNG LAO MUST SCRAP\n"
	.string "HIS PLANS OF REUNITING THE WHITE LOTUS\n"
	.string "SOCIETY. HE INSTEAD MUST FOCUS ON THE NEW\n"
	.string "TOURNAMENT. HE SEEKS LIU KANG AND TOGETHER\n"
	.string "THEY BATTLE KAHN'S FORCES FEARLESSLY.\n"
	.byte	0
	.even

txt_lao_ending2
	.string "USING THE KNOWLEDGE HE OBTAINED AS A SHAOLIN\n"
	.string "MONK HE FIGHTS IN THE NAME OF HIS GREAT\n"
	.string "ANCESTOR- THE ORIGINAL KUNG LAO. HE EMERGES\n"
	.string "VICTORIOUS BUT SUFFERS FROM INJURIES DURING\n"
	.string "BATTLE WITH KAHN. BELIEVED TO HAVE PASSED AWAY\n"
	.string "KUNG LAO JOINS HIS ANCESTOR IN A NEW LIFE."
	.byte	0
	.even
																																																				
txt_st_ending1
	.string "WHEN SHAO KAHN OVERTAKES THE EARTH HE\n"
	.string "NEEDS SHANG TSUNG TO HELP LOCATE THE\n"
	.string "SURVIVING HUMANS. GRANTED NEW POWERS HE\n"
	.string "SOON DISCOVERS HIS DARK EMPEROR'S TRUE PLAN;\n"
	.string "AS SOON AS THE REMAINING WARRIORS ARE\n"
	.string "DISPOSED OF, KAHN WILL TAKE TSUNG'S OWN SOUL\n"
	.byte	0
	.even

txt_st_ending2
	.string "AFTER LEARNING OF THIS, TSUNG TURNS ON HIS\n"
	.string "MASTER. HE CATCHES MOTARO OFF GUARD AND THEN\n"
	.string "DEFEATS SHAO KAHN. BUT BEFORE THE EARTH CAN\n"
	.string "RETURN TO NORMAL TSUNG TAKES ALL THE SOULS\n"
	.string "AS HIS OWN. HE WILL FOREVER RULE EARTH\n" 
	.string "WITH HIS OWN BRAND OF EVIL.\n"
	.byte	0
	.even


txt_lk_ending1
	.string "AFTER THWARTING SHAO KAHN IN THE PAST LIU\n"
	.string "KANG FINDS HIMSELF THE MAIN TARGET OF KAHN'S\n"
	.string "EXTERMINATION SQUADS. BUT KANG IS THE\n"
	.string "REIGNING MORTAL KOMBAT CHAMPION AND PROVES\n"
	.string "IT BY EASILY DEFEATING KAHN'S MINIONS.\n"
	.byte	0
	.even

txt_lk_ending2
	.string "BUT IT'S THE APPARENT DEATH OF HIS FRIEND\n"
	.string "KUNG LAO THAT ENRAGES KANG AND ENABLES HIM\n"
	.string "TO FIND THE STRENGTH TO DEFEAT SHAO KAHN.\n"
	.string "THEN BEFORE THE PORTAL CLOSES, LIU KANG IS\n"
	.string "GREETED BY PRINCESS KITANA AND THANKED\n"
	.string "FOR SAVING THE EARTH AND THE OUTWORLD.\n"
	.byte	0
	.even


txt_smoke_ending1
	.string "SMOKE WAS ONCE A FRIEND AND ALLY OF SUB-ZERO\n"
	.string "WHEN THEY BOTH TRIED TO ESCAPE FROM BEING\n"
	.string "TURNED INTO MACHINES BY THEIR NINJA CLAN.\n"
	.string "BUT, SMOKE IS CAPTURED AND TRANSFORMED INTO\n"
	.string "A CYBORG WITH A MISSION TO FIND AND KILL\n"
	.string "HIS OLD PARTNER.\n"
	.byte	0
	.even

txt_smoke_ending2
	.string "BUT SMOKE SOON FINDS HIMSELF BEING PURSUED\n"
	.string "BY SHAO KAHN'S MINIONS. HE LEARNS THAT HE\n"
	.string "STILL HAS A SOUL AND HIS TRUE MISSION IS THE\n"
	.string "DESTRUCTION OF THE OUTWORLD INVADERS. HE\n"
	.string "DEFEATS KAHN AND SAVES THE WORLD BUT IS\n"
	.string "FOREVER TRAPPED IN HIS ARTIFICIAL BODY.\n"
	.byte	0
	.even

**************************************************************************

smoke_page
	movi	adj_smoke,a0
	calla	get_adj
	cmpi	0edb0H,a0
	jreq	ultimate_exit			; already set ---> exit

	movi	gs_unlock_smoke,a0
	move	a0,@gstate,w

	calla	clr_scrn
	calla	murder_myoinit_score
	movi	dlists_bogus,a0
	move	a0,@dlists,l

	calla	page_0_zip_setup
;	calla	view_page_1
	calla	display_on

	movi	red_grad_pal,a0
	jsrp	do_the_grad_thang

	movi	txt_smoke1,a8
	movi	0004800c0H,a9
	jsrp	p15_centered

	movi	bpal_blue,a0
	movi	0001500e8H,a3
	calla	make_solid_object
	movi	076H,a0
	move	a0,*a8(oypos),w
	calla	center_obj_x		; backdrop box
	calla	insobja8
	move	*a8(oxpos),a11,w
	move	a8,a10
	addk	2,a11

	move	a13,a3
	addi	p_store1,a3	 	; a3 ---> 1st symbol object

	movk	10,a9
smoke3	movi	symbol_table,a0
	move	*a0,a5,l
	calla	gso_dmawnz
	calla	insobja8
	move	*a10(oypos),a0,w
	addk	2,a0
	move	a0,*a8(oypos),w
	move	a11,*a8(oxpos),w
	move	*a8(osizex),a1,w
	move	a8,*a3+,l	 	; save object here
	clr	a0
	move	a0,*a8(oslink),w 	; symbol offset
	add	a1,a11
	addk	2,a11
	dsj	a9,smoke3

	movi	txt_gameover,a8
	movi	0001000c8H,a9
	jsrp	pds_centered

	calla	display_on
	calla	view_page_0

	movk	3,a10		; pause after fade
	jsrp	fadein_jsrp


ultimate_scan
	create	pid_smoke_timer,count_down_timer

	move	@tick,a0,w
	move	a0,*a13(p_joyport),w

	clr	a0
	movi	c_hp,a1
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l   		; clear out button ram

cproc7	clr	a0
	movi	l_hp,a1
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l
	move	a0,*a1+,l   		; clear out button ram

	sleep	1

	clr	a4			; bit 0 = player 1 stick up
	calla	setup_direction	
	clr	a0
	move	*a13(p_store1),a8,l
	callr	check_button
	move	*a13(p_store2),a8,l
	callr	check_button
	move	*a13(p_store3),a8,l
	callr	check_button
	move	*a13(p_store4),a8,l
	callr	check_button
	move	*a13(p_store5),a8,l
	callr	check_button

	movk	8,a4			; bit 8 = player 2 stick up
	calla	setup_direction
	move	*a13(p_store6),a8,l
	callr	check_button
	move	*a13(p_store7),a8,l
	callr	check_button
	move	*a13(p_store8),a8,l
	callr	check_button
	move	*a13(p_store8+32),a8,l
	callr	check_button
	move	*a13(p_store8+64),a8,l
	callr	check_button

	move	@tick,a0,w
	move	*a13(p_joyport),a1,w
	sub	a1,a0

	clr	a1
	not	a1
	movi	pid_smoke_timer,a0
	calla	existp
	jrne	cproc7			; moe time left

; removed !!

*
* jackpot !!
* 
	movi	0edb0H,a1	 	; write this exact number to activate
	movi	adj_smoke,a0
	calla	put_adj
	calla	f_adc_s			; make checksums kosher !
*
* let em give it a try !!!
*
	movi	024ccH,a3		; outstanding !
	calla	send_code_a3

	calla	reset_proc_stack	; I am taking control here
	calla	murder_myoinit_score
	calla	clr_scrn
	sleep	040H
*
* flash through backgrounds
*
	movk	3,a10
ftb3	movk	10,a11
ftb4	push	a11
	calla	do_a11_background
	pull	a11
	tsound	000H
	tsound	001H
	sleep	8
	calla	murder_myoinit_score
	dsj	a11,ftb4
	dsj	a10,ftb3

	movi	00bH,a11
	calla	do_a11_background

	movi	045H,a3
	calla	send_code_a3		; music...
;	calla	bogus_dlist		; use this list !!

	movi	txt_from_this,a8
	movi	0003000c8H,a9
	jsrp	pds_centered
	sleep	070H
	movi	txt_smoke_is_act,a8
	movi	0004000c8H,a9
	jsrp	pds_centered

	movk	ft_smoke,a0
	push	a0
	sll	5,a0
	addi	ochar_fake_stances,a0
	move	*a0,a9,l
	calla	gmo_proc
	pull	a0
	move	a0,*a8(ochar),w

	move	*a13(p_flags),a0,w
	ori	pm_alt_pal,a0
	move	a0,*a13(p_flags),w	; flag: i am using aleternate palette
	calla	player_normpal
	calla	insobja8
	movi	01fH,a0
	calla	create_fx		; smoke em

	movi	scrrgt/2,a11
	create	pid_fx,take_a_bow
	sleep	040H

	movi	pid_fx,a0
	calla	dallprc			; stop wakeup proc
	sleep	040H*8

	movk	1,a3
	move	a3,@f_smoke,w		; flag: smoke activated
	jauc	amode


sans_ultimate
	movi	50,a0
	calla	randper
	jrc	its_official

	movk	14,a0
	calla	randu
	dec	a0
	move	a0,*a8(ochar),w
	movk	9,a0
	calla	group_sound		; death scream

	movi	txt_wrong,a8
	movi	000e000c8H,a9
	jsrp	pds_centered
	sleep	060H
	calla	rsnd_sk_bonus_win
	sleep	060H

ultimate_exit
	calla	murder_myoinit_score
	sleep	3
	retp


its_official
	tsound	08fH			; its official
	sleep	0a0H
	jruc	ultimate_exit

;***********************

txt_from_this
	.string	"FROM THIS POINT ON....",0
	.even

txt_smoke_is_act
	.string	"I AM AT YOUR CONTROL",0
	.even

count_down_timer
	movi	bpal_black,a0
	movi	000140016H,a3
	calla	make_solid_object
	movi	0a0H-2,a0
	move	a0,*a8(oypos),w
	calla	center_obj_x		; backdrop box
	calla	insobja8

	movk	9,a10
	movi	font15_nums,a0
	move	*a0,a5,l	
	calla	gso_dmawnz
	movi	0a0H,a0
	move	a0,*a8(oypos),w
	calla	center_obj_x		; backdrop box
	calla	insobja8

cdown3	callr	count_shape

	movi	040H,a0
	move	@switch,a2,l
	not	a2
	andi	p1b5|p2b5,a2
	jreq	cdown4
	movk	4,a0
cdown4	calla	prcslp

	dsjs	a10,cdown3
	callr	count_shape
	die

count_shape
	move	a10,a0
	sll	5,a0
	addi	font15_nums,a0
	move	*a0,a1,l
	jauc	ani_flag		; shape #


check_button
	push	a0

	move	a0,a2
	sll	5,a0
	addi	ultimate_button_ram_spots,a0
	move	*a0,a0,l
	move	*a0,a1,w   		; grab it
	jreq	cbut9	   		; not pressed ---> exit

	sll	4,a2
	addi	combo_1,a2		; a2 ---> combo ram to change

	move	*a8(oslink),a0,w
	add	a3,a0
	jrnn	cbut3			; non neg = cool
	movk	9,a0			; neg = back up to 9
	jruc	cbut5
cbut3	cmpi	10,a0
	jrlo	cbut5
     	clr	a0
cbut5	move	a0,*a8(oslink),w
	move	a0,a6			; a6 = new offset for this symbol
	move	a0,a1
	move	a0,*a2,w		; stuff into combo ram as well

	sll	4,a1
	addi	c_hp,a1
	move	a6,*a1,w		; stuff new offset into ram !!!

	sll	5,a0
	addi	symbol_table,a0
	move	*a0,a1,l
	move	*a1(icmap),a0,l
	calla	swpal	    		; new palette
	calla	ani_flag    		; reshape the symbol

cbut9	pull	a0
	inc	a0
	rets


txt_gameover
	.string	"GAME OVER"
	.byte	0
	.even

txt_smoke1
	.string	"ENTER\nTHE ULTIMATE KOMBAT KODE",0
	.even

txt_wrong
	.string	"- INCORRECT CODE -",0
	.even

ultimate_button_ram_spots
	.long	l_hp		; symbol #1
	.long	l_lp		; symbol #2
	.long	l_block		; symbol #3
	.long	l_lk		; symbol #4
	.long	l_hk		; symbol #5
	.long	l_hp+16		; symbol #6
	.long	l_lp+16		; symbol #7
	.long	l_block+16	; symbol #8
	.long	l_lk+16		; symbol #9
	.long	l_hk+16		; symbol #10

;*******************************************

do_the_grad_thang
	calla	getfpal
	sleep	2			; time for palette to be put in place

	clr	a3
    	movi	000000202H,a1

	movi	31,a10
loop	movi	000020180H,a2
	movi	02000000H,a4
	movi	0800cH,a5
	calla	dman
	addi	001010000H,a1
	addi	000020000H,a3
	dsj	a10,loop

	addi	000840000H,a3

	movi	32,a10
loop2	movi	000020180H,a2
	movi	02000000H,a4
	movi	0800cH,a5
	calla	dman
	subi	001010000H,a1
	addi	000020000H,a3
	dsj	a10,loop2

	sleep	4
	retp


red_grad_pal
	.word	32

	.word	31*32*32
	.word	30*32*32
	.word	29*32*32
	.word	28*32*32
	.word	27*32*32
	.word	26*32*32
	.word	25*32*32
	.word	24*32*32
	.word	23*32*32
	.word	22*32*32
	.word	21*32*32
	.word	20*32*32
	.word	19*32*32
	.word	18*32*32
	.word	17*32*32
	.word	16*32*32

	.word	15*32*32
	.word	14*32*32
	.word	13*32*32
	.word	12*32*32
	.word	11*32*32
	.word	10*32*32
	.word	9*32*32
	.word	8*32*32
	.word	7*32*32
	.word	6*32*32
	.word	5*32*32
	.word	4*32*32
	.word	3*32*32
	.word	2*32*32
	.word	1*32*32
	.word	0*32*32

**************************************************************************

shao_kahn_death_fx
	move	@p1_obj,a8,l
	move	*a8(oid),a0,w
	ori	08000H,a0
	move	a0,*a8(oid),w

	move	@p2_obj,a8,l
	move	*a8(oid),a0,w
	ori	08000H,a0
	move	a0,*a8(oid),w

	clr	a0
	movi	08000H,a1
	calla	kill_ocp		; kill all obj except players

	move	@p1_proc,a11,l
	move	@p1_char,a1,w
	cmpi	ft_sk,a1
	jreq	skdie1
	move	@p2_proc,a11,l
skdie1	move	*a11(procid),a9,w
	ori	08000H,a9
	move	a9,*a11(procid),w	; protect kahn's proc
	calla	murder
	andni	08000H,a9
	move	a9,*a11(procid),w	; bak 2 the light !!

	move	a11,a0
	movi	wait_forever,a7
	calla	fastxfer		; disable shao kahn proc

	clr	a0
	move	a0,@scrolly,l
	calla	stop_scrolling		; stop screen
	move	@p1_obj,a8,l
	calla	stop_me
	move	a8,a9
	move	@p2_obj,a8,l
	calla	stop_me			; stop both players !!

	movi	dmacnz,a0
	move	a0,*a8(oflags),w
	move	a0,*a9(oflags),w	; both players --> black

	movi	boonpal,a0
	calla	swpal
	push	a8
	move	a9,a8
	calla	swpal
	pull	a8

	calla	stop_scrolling
	move	@baklst1,a1,l
	move	@baklst2,a2,l
	move	@baklst3,a3,l
	move	@baklst4,a4,l
	move	@baklst5,a5,l
	move	@baklst6,a6,l
	move	@baklst7,a7,l
	mmtm	a12,a1,a2,a3,a4,a5,a6,a7

	clr	a0
	move	a0,@baklst1,l
	move	a0,@baklst2,l
	move	a0,@baklst3,l
	move	a0,@baklst4,l
	move	a0,@baklst5,l
	move	a0,@baklst6,l
	move	a0,@baklst7,l
	calla	dont_show_scores
*
* psycho flash !!!
*
	movk	7,a10
skdie3	tsound	07fH
	clr	a0
	movi	bpal_white,a1
	callr	kahn_flash
	movi	0ffffH,a0
	movi	bpal_black,a1
	callr	kahn_flash
	dsj	a10,skdie3

	move	@p1_proc,a11,l
	move	@p1_obj,a8,l
	move	@p2_obj,a0,l
	move	@p1_char,a1,w
	cmpi	ft_sk,a1
	jreq	skdie5
	move	@p2_obj,a8,l		; a8 = shao kahn obj
	move	@p1_obj,a0,l
	move	@p2_proc,a11,l
skdie5

;	calla	delobjp			; delete winner's player object !!
	push	a8
	move	a0,a8
	calla	set_inviso
	pull	a8

*
* fade from white to normal !!
*
	calla	nosounds
	sleep	1
	tsound	000H
	tsound	001H			; ka BOOM !!
	calla	set_inviso		; all white = dont show shao kahn
	sleep	4

;	clr	a0
;	move	a0,@irqskye,w		; black background

	mmfm	a12,a1,a2,a3,a4,a5,a6,a7
	move	a1,@baklst1,l
	move	a2,@baklst2,l
	move	a3,@baklst3,l
	move	a4,@baklst4,l
	move	a5,@baklst5,l
	move	a6,@baklst6,l
	move	a7,@baklst7,l

	move	a11,a0
	movi	shao_kahn_dying,a7
	calla	fastxfer			; kahn ---> dying sequence
	movi	000030040H,a11
	calla	shake_a11

	jsrp	fadein_white_jsrp

	tsound	087H				; start the rumble
	tsound	088H				; start the rumble

	sleep	050H

	movi	skdie1_mod,a0
	callr	init_and_multi_plane
	movi	000030040H,a11
	calla	shake_a11
	sleep	040H

	tsound	087H				; start the rumble
	tsound	088H				; start the rumble

	movi	000060040H,a11
	movi	030H,a10
	jsrp	sk_die_pit

	movi	000060040H,a11
	movi	020H,a10
	jsrp	sk_die_tower
	movi	000080040H,a11
	movi	020H,a10
	jsrp	sk_die_pit

	movi	000060040H,a11
	movi	018H,a10
	jsrp	sk_die_tower
	movi	000080040H,a11
	movi	018H,a10
	jsrp	sk_die_pit

	tsound	087H				; start the rumble
	tsound	088H				; start the rumble

	movi	000060040H,a11
	movi	010H,a10
	jsrp	sk_die_tower
	movi	000080040H,a11
	movi	010H,a10
	jsrp	sk_die_pit

;	tsound	087H				; start the rumble
;	tsound	088H				; start the rumble

	movk	4,a0
fastsk3	move	a0,*a13(p_anirate),w
	movi	000060040H,a11
	movi	008H,a10
	jsrp	sk_die_tower
	movi	000080040H,a11
	movi	008H,a10
	jsrp	sk_die_pit
	move	*a13(p_anirate),a0,w
	dsj	a0,fastsk3

	movi	skdie2_mod,a0
	callr	init_and_multi_plane


	movk	3,a11

last_flash
	tsound	000H
	tsound	001H
	jsrp	white_flash
	sleep	8
	dsj	a11,last_flash

	movi	0fffH,a0
	move	a0,@irqskye,w
	sleep	3

	jsrp	fadein_white_jsrp
	sleep	050H
	movi	045H,a3
	calla	send_code_a3		; victory tune

	jsrp	victory_messages

	movi	021H,a3
	calla	send_code_a3		; tongue / game over tune

	calla	get_winner_ochar
	jsrp	show_ending_story

	move	@ladder_order,a0,w
	cmpi	1,a0
	jrne	skip_godz
	jsrp	show_page_o_the_godz

skip_godz
	calla	murder_myoinit_score
	calla	clr_scrn
	sleep	8
	jsrp	mk3_cast_o_characters
	jsrp	mk3_design_team
	jsrp	mk3_thank_you
	jauc	game_over


sk_die_tower
	movi	skdie1_mod,a0
	callr	init_and_multi_plane
	jruc	dieshk

sk_die_pit
	movi	pit_mod,a0
	callr	init_and_multi_plane
	create	pid_fx,shao_kahn_dying2
dieshk	calla	shake_a11
	move	a10,a0
	calla	prcslp
	retp


init_and_multi_plane
	push	a0
	calla	murder_myoinit_score
	pull	a0
	calla	init_bakmods
	jauc	multi_plane


shao_kahn_dying2
	movi	setup_player_1,b0
	move	@p1_char,a0,w
	cmpi	ft_sk,a0
	jreq	mskd5
	movi	setup_player_2,b0
mskd5	call	b0
	movi	pid_p1,a0
	calla	dallprc
	movi	pid_p2,a0
	calla	dallprc			; kill any controlling procs....
	callr	sk_die_setup
	movk	6,a9
	movk	3,a14
	calla	find_ani_part_a14	; cycle part
	calla	do_next_a9_frame	; switch pals

;	calla	flip_multi

	movi	5,a0
	jsrp	mframew
	jauc	wait_forever


shao_kahn_dying
	callr	sk_die_setup

	move	*a13(p_flags),a4,w
	ori	pm_alt_pal,a4
	move	a4,*a13(p_flags),w
	movi	dmawnz,a0
	move	a0,*a8(oflags),w
	calla	player_normpal
	calla	ground_player

	movk	6,a9
	calla	get_char_ani
	movi	000050007H,a0
	jsrp	animate_a0_frames			; by myself....

	movk	6,a9
	calla	find_ani_part2
	movi	5,a0
	jsrp	mframew
	jauc	wait_forever



sk_die_setup
	calla	clear_inviso
	move	@worldtlx+16,a0,w
	addi	scrrgt/2,a0
	move	a0,*a8(oxpos),w			; me = center of screen
	rets

kahn_flash
	pull	a11
	move	a0,@irqskye,w			; white background
	move	a1,*a8(oconst),w
	move	a1,*a9(oconst),w
	sleep	4
	jump	a11

;***************************************************

victory_messages
	calla	get_winner_text
	move	a8,a0
	movi	019H,a1			; rise time !!
	move	a1,*a13(p_store1),w
	jsrp	winner_msg_rise
	sleep	0a0H

	clr	a0
	movi	013H,a1			; rise time !!
	jsrp	msg_rise
	sleep	0a0H

	movk	1,a0
	movi	00eH,a1			; rise time !!
	jsrp	msg_rise
	sleep	0f0H
	retp



msg_rise
	move	a1,*a13(p_store1),w
	sll	5,a0
	addi	end_winner_text,a0
	move	*a0,a0,l

winner_msg_rise
	push	a0
	movi	pf_rise,a8
	calla	lm_setup
	pull	a8
	jsrp	printf

	movk 	1,a0
	move	a0,@f_novel,w		; avoid race condition

	movi	-080000H,a1
	callr	set_objlst2_vel

	clr	a0
	move	a0,@f_novel,w		; start the letters movin up
	move	*a13(p_store1),a0,w
	calla	prcslp

	movk 	1,a0
	move	a0,@f_novel,w		; stop !!
	clr	a1
	callr	set_objlst2_vel		; stop each letter

	move	@objlst2,a0,l
rise4	move	a0,a5			; a5 = last object list #2
	move	*a0,a0,l
	jrne	rise4

	move	@objlst,a1,l
	move	@objlst2,a2,l

	clr	a0
	move	a0,@objlst,l
	move	a0,@objlst2,l

	move	a1,*a5(olink),l		; link: list2 ----> list1
	move	a2,@objlst,l

	retp


set_objlst2_vel
	move	@objlst2,a0,l
rise3	move	a1,*a0(oyvel),l		; heading upwards
	move	*a0,a0,l
	jrne	rise3
	rets

pf_rise
	mess_mac rd15font,00000ffffH,200,0100H,bpal_white*010000H,strcnrmos_scr,0
	.byte	0
	.even

end_winner_text
	.long	txt_victory1
	.long	txt_victory2

txt_victory1
	.string	"SHAO KAHN IS NO MORE",0
	.even

txt_victory2
	.string	"YOU ARE THE MK3\n"
	.string	"CHAMPION"
	.byte	0
	.even

;*********************************************************************

txt_mk_cast
	.string	"MK3 CAST OF CHARACTERS",0
	.even

mk3_cast_o_characters
	calla	display_on
	calla	murder_myoinit
	calla	dont_show_scores

	movk	3,a11
	calla	do_a11_background

	movi	txt_mk_cast,a8
	movi	0003000c8H,a9
	jsrp	p15_centered
	sleep	070H

	movi	oid_text,a0
	calla	dallobj
	sleep	010H

	movi	cast_table,a11
	move	*a11+,a8,l
coc3	move	*a11+,a9,l
	pushp	a11
	jsrp	pds_centered
	pullp	a11
	move	*a11+,a8,l
	jrne	coc3

	move	*a11+,a0,w
coc7	push	a0
	sll	5,a0
	addi	ochar_fake_stances,a0
	move	*a0,a9,l
	calla	gmo_proc
	pull	a0
	move	a0,*a8(ochar),w

	move	*a13(p_flags),a0,w
	ori	pm_alt_pal,a0
	move	a0,*a13(p_flags),w	; flag: i am using aleternate palette
	calla	player_normpal
	calla	insobja8

	create	pid_fx,take_a_bow
	move	*a11+,a1,w
	move	a1,*a0(pa11),l		; pass x pos

	sleep	1

	move	*a11+,a0,w		; more names ?
	jrne	coc7			; yes

	move	*a11,a0,l
	jreq	coc8

	sleep	0100H

	movi	oid_text,a0
	calla	dallobj
	move	*a11+,a8,l
	jrne	coc3

coc8	sleep	050H
	calla	murder
	sleep	070H
	calla	murder_myoinit_score
	sleep	8
	retp


cast_table
	.long	txt_rich,0002000c8H,0
	.word	ft_kano,070H
	.word	ft_tusk,0120H
	.word	0

	.long	txt_kerri,000200064H
	.long	txt_johnp,00020012cH,0
	.word	ft_sonya,070H
	.word	ft_jax,0120H
	.word	0

	.long	txt_tony,000200064H
	.long	txt_mike,00020012cH,0
	.word	ft_lao,070H
	.word	ft_swat,0120H
	.word	0

	.long	txt_turk,0002000c8H,0
	.word	ft_subzero,070H
	.word	ft_st,0120H
	.word	0

	.long	txt_lia,000200064H
	.long	txt_wong,00020012cH,0
	.word	ft_lia,070H
	.word	ft_lk,0120H
	.word	0

	.long	txt_sal,0002000c7H,0
	.word	ft_indian,050H
	.word	ft_robo1,0a0H
	.word	ft_robo2,0f0H
	.word	ft_smoke,0140H
	.word	0

	.long	txt_brian,0002000c7H,0
	.word	ft_sk,0c8H,0

	.long	0


txt_rich	.string	"RICHARD DIVIZIO\nAS\nKANO AND KABAL",0
	.even
txt_kerri
	.string	"KERRI HOSKINS\nAS\nSONYA",0
	.even
txt_johnp
	.string	"JOHN PARRISH\nAS\nJAX",0
	.even
txt_tony	.string	"TONY MARQUEZ\nAS\nKUNG LAO",0
	.even
txt_mike	.string	"MICHAEL OBRIEN\nAS\nSTRYKER",0
	.even
txt_turk	.string	"JOHN TURK\nAS\nSUB-ZERO  AND  SHANG TSUNG",0
	.even
txt_lia	.string	"LIA MONTELONGO\nAS\nSINDEL",0
	.even
txt_wong	.string	"EDDIE WONG\nAS\nLIU KANG",0
	.even
txt_sal	.string	"SAL DIVITA\nAS\n"
	.string	"NIGHTWOLF     SEKTOR      CYRAX      SMOKE",0
	.even
txt_brian
	.string	"BRIAN GLYNN\nAS\nSHAO KAHN",0
	.even


take_a_bow
	clr	a0
	move	a0,*a13(p_slave),l

	calla	ground_ochar
	move	*a8(oypos),*a13(p_ganiy),w	; set the grounded y pos

	move	*a8(oypos),a0,w
	addi	090H,a0
	move	a0,*a8(oypos),w
	move	@worldtlx+16,a0,w
	add	a11,a0
	move	a0,*a8(oxpos),w

	movk	016H,a9
	calla	get_char_ani
	addi	32,a9
	calla	do_next_a9_frame

	clr	a0
	move	a0,*a8(ograv),l
	movi	-090000H,a0
	move	a0,*a8(oyvel),l

btf6	sleep	1
	move	*a8(oypos),a0,w
	move	*a13(p_ganiy),a1,w
	cmp	a1,a0
	jrhi	btf6

tab7	sleep	1
	calla	next_anirate
	move	*a8(oyvel),a0,l
	addi	0c000H,a0
	move	a0,*a8(oyvel),l
	move	*a8(oypos),a1,w
	move	*a13(p_ganiy),a0,w	; a0 = grounded ani y
	cmp	a0,a1			; hit ground yet ?
	jrlt	tab7 			; no, keep falling
	calla	ground_player
	calla	stop_a8

	create	pid_fx,wake_me_up
	move	a13,*a0(pa11),l		; pass my proc
	jauc	ending_victory_animation

wake_me_up
	sleep	0c0H
	move	a11,a0
	movi	run_away,a7
	calla	fastxfer
	die

run_away
	calla	delete_slave

	move	*a8(oflags),a4,w
	btst	b_fliph,a4
	jrne	tab3
	calla	flip_multi			; make sure we are not flipped
tab3	movi	-080000H,a11
	move	*a8(oxpos),a0,w
	move	@worldtlx+16,a1,w
	addi	scrrgt/2,a1
	cmp	a1,a0
	jrlo	rleft
	calla	flip_multi
	neg	a11

rleft	movi	03eH,a9
	calla	get_char_ani
	movk	3,a0
	calla	init_anirate

	movi	040H,a10
run3	sleep	1
	move	a11,*a8(oxvel),l
	calla	next_anirate
	dsj	a10,run3

	calla	stop_a8
	move	a8,a0
	callr	delobjp			; delete object and palette
	die

;*********************************************************************

mk3_thank_you
	calla	clr_scrn
	calla	murder_myoinit_score
	sleep	4

	movk	4,a11
	calla	do_a11_background
	create	pid_fx,text_deleter

	movi	mk3_thanx,a11
des3	move	*a11+,a0,l
	cmpi	-1,a0
	jreq	des9

	move	a0,a0
	jreq	des5

	pushp	a11
	move	a0,a8
	movi	000ff00c8H,a9
	jsrp	pds_centered
	pullp	a11

	callr	set_letter_vel

des5	move	*a11+,a0,w
	calla	prcslp
	jruc	des3

des9	sleep	0c0H
	calla	murder

	movk	10,a10
	jauc	fadeout_jsrp



set_letter_vel
	movk	1,a0
	move	a0,@f_novel,w

	move	@objlst2,a0,l
	jreq	slv9
	move	a0,a3
	clr	a1
	move	a1,@objlst2,l
		
	movi	-010000H,a2
scrp4	move	a2,*a0(oyvel),l

	movi	100,a4
	move	a4,*a0(ozpos),w

	move	*a0(olink),a0,l
	jrne	scrp4

	move	@objlst,a4,l
	jreq	scrp6
scrp5	move	a4,a5
	move	*a4(olink),a4,l
	jrne	scrp5
	move	a3,*a5(olink),l
	jruc	slv9
scrp6	move	a3,@objlst,l

slv9	clr	a0
	move	a0,@f_novel,w
	rets


text_deleter
	sleep	08H
	move	@objlst,a0,l
	jreq	text_deleter
objjd	move	*a0(olink),a2,l		; a2 = next
	move	*a0(oypos),a1,w
	sll	16,a1
	sra	16,a1
;	cmpi	07fffH,a1
	cmpi	-12,a1
	jrgt	objjc
	calla	delobjp			; offscreen ----> delete
objjc	move	a2,a0
	jrne	objjd
	jruc	text_deleter

mk3_thanx
	.long	txt_execs
	.word	078H
	.long	txt_hardw
	.word	0a0H
	.long	txt_tech
	.word	060H
	.long	txt_dcs
	.word	060H
	.long	txt_sales_marketing
	.word	0c0H
	.long	txt_ssr
	.word	060H
	.long	txt_voices
	.word	0a0H
	.long	txt_testers
	.word	080H
	.long	txt_thanx_alot
	.word	0100H
	.long	txt_thanx_alot2
	.word	0100H

	.long	-1

txt_execs
	.string	"EXECUTIVE PRODUCERS:\n"
	.string	"NEIL NICASTRO\n"
	.string	"KEN FEDESNA\n"
	.string	"PAUL DUSSAULT"
	.byte	0
	.even

txt_hardw
	.string	"HARDWARE DESIGN:\n"
	.string	"MARK LOFFREDO\n"
	.string	"RAY MACIKA\n"
	.string "PAT COX\n"
	.string	"CARY MEDNICK\n"
	.string "RAY GAY\n"
	.byte	0

txt_tech
	.string	"SENIOR HARDWARE TECHNICIANS:\n"
	.string	"SHERIDAN OURSLER\n"
	.string	"AL LASKO\n"
	.string	"JEFF PETERS"
	.byte	0
	.even

txt_dcs
	.string	"DCS SOUND SYSTEM:\n"
	.string	"MATT BOOTY\n"
	.string	"ED KEENAN\n"
	.string	"JOHN LOWES",0
	.even

txt_ssr
	.string	"STEVE RITCHIE\nAS\nTHE VOICE OF SHAO KAHN",0
	.even

txt_voices
	.string	"GRUNTS, SCREAMS, GROANS AND GIBBERISH:\n"
	.string	"JON HEY\n"
	.string	"PEG BURR\n"
	.string	"DAN FORDEN\n"
	.string	"ANN MAZZA\n"
	.string	"VINCE PONTARELLI\n"
	.string	"ED BOON\n"
	.byte	0	


txt_sales_marketing
	.string	"SALES AND MARKETING:\n"
	.string	"JOE DILLON\n"
	.string	"RACHEL DAVIES\n"
	.string	"LENORE SAYERS\n"
	.string	"MARK CHAN\n"
	.string	"ROGER SHARPE\n"
	.string	"BARB ROSENTHAL\n"
	.string	"TAMMY RUSO\n"
	.string	"CRISTA WOSS\n"
	.byte	0


txt_thanx_alot
	.string	"MANY THANKS GO TO:\n\n"
	.string	"MARK PENACHO\n\n"
	.string	"SAL DIVITA\n\n"
	.string	"MIKE LYNCH\n\n"
	.string	"JAKE SIMPSON\n\n"
	.string	"JASON SKILES\n\n"
	.string	"MARK TURMELL\n\n"
	.string	"WARREN DAVIS\n\n"
	.byte	0

txt_thanx_alot2
	.string	"EUGENE JARVIS\n\n"
	.string	"ERIC PRYBIL\n\n"
	.string	"JOHN MCCAFFER\n\n"
	.string	"L.E.D\n\n"
	.string	"TED ESTES\n\n"
	.string	"JOSH WEXLER\n\n"
	.string	"DAVE SCHWARTZ\n\n"
	.string	"GARY PENACHO\n\n"
	.string	"KENT MILLER\n\n"
	.string	"SHAWN AND JASON\n\n"
	.string	"ANTONY ESPINDOLA\n\n"
	.string	"STACY\n\n"
	.byte	0


txt_testers
	.string	"UNBEATABLE KOMBAT MASTERS\n(GAME TESTERS)\n\n"
	.string	"EDDIE FERRIER\nAND\n"
	.string	"MIKE VINIKOUR",0
	.even

	.string	"MK4 COMING IN 1996",0
	.even

;----------
;  Team
;----------
;   - Mike Lynch (credit him)
;   - Steve Corell (sp?) (credit him)
;   - Game Testers / "Unbeatable Kombat Masters"
;              - Eddie Ferrier
;              - Mike Vinikour
;
;----------
;Thanks to: 
;----------
;
;
;    - tour
;    - movie
;
;    - Random order
;    - EGM
;    - Video Games
;    - Gamepro
;    - Die Hard Game Fan
;    - Gamesmaster

;*********************************************************************

mk3_design_team
	calla	clr_scrn
	calla	murder_myoinit_score
	sleep	4
	movi	dlists_bogus,a0
	move	a0,@dlists,l

	movi	txt_mk3_dteam,a8
	movi	0001800c8H,a9
	jsrp	pds_centered

	move	@objlst2,a0,l
	movi	oid_fx,a1
team0	move	a1,*a0(oid),w
	move	*a0,a0,l
	jrne	team0			; keep title text up there

	sleep	030H
	
	movk	10,a10
	movi	team_table,a11
team2	jsrp	team_print
	jsrp	team_print

team3	move	*a11+,a5,l	
	calla	gso_dmawnz_ns
	dec	a10
	move	a10,*a8(ozpos),w
	calla	insobja8
	move	*a11+,a4,l	
	calla	set_xy_coordinates

	move	a8,a0
	calla	delpal	      		; delete old palette
	movi	MKTEAM_P,a0
 	calla	getfpal_nocheck		; get my own pal
	move	a0,*a8(opal),w		; store new palette "double" #'s

	push	a11
	move	*a8(opal),a9,w
	move	a9,a0
	andi	0ffH,a0
	sll	6,a0
	addi	palram,a0
	move	*a0(palid),a8,l		; ptr to palette
	movi	team_fade_in,a11
	create	pid_fade,fadeproc
	pull	a11

	move	*a11,a0,l
	cmpi	-1,a0
	jrne	team3

	move	*a11(32),a0,l
	cmpi	-2,a0
	jreq	team9

	addi	32,a11			;

	tsound	08eH			; bell sound

	sleep	0c0H
	movi	oid_text,a0
	calla	dallobj
	jruc	team2

team9	tsound	08eH			; bell sound
	sleep	0c0H	
	movi	oid_text,a0
	calla	dallobj
	sleep	020H

	calla	murder_myoinit_score
	calla	clr_scrn
	sleep	8
	retp


team_fade_in
	.word	0,0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128,0ffffH

team_print
	move	*a11+,a8,l
	jreq	tprnt6
	move	*a11+,a9,l
	mmtm	a12,a10,a11
	jsrp	pds_centered
	mmfm	a12,a10,a11
tprnt6	retp


teamyx	.set	00066006aH

team_table
	.long	txt_ed,000dd0090H
	.long	txt_johnt,000dd0108H
	.long	T_ED,teamyx+0
	.long	T_TOBIAS,teamyx+(010000H*9)+101
	.long	-1

	.long	txt_steve,000dd00c8H
	.long	0
	.long	T_BERAN,teamyx+(010000H*-19)+46
	.long	-1

	.long	txt_dan,000dd00c8H
	.long	0
	.long	T_DFORDEN,teamyx+(010000H*-34)-50
	.long	-1

	.long	txt_tonyg,000dd0090H
	.long	txt_dave,000dd0108H
	.long	T_GOSKIE,teamyx+(010000H*-59)+16
	.long	T_MICHIC,teamyx+(010000H*-61)+79
	.long	-1

	.long	txt_johnv,000dd00c8H
	.long	0
	.long	T_JOHNV,teamyx+(010000H*-42)+154
	.long	-1,-2

txt_mk3_dteam
	.string	"MORTAL KOMBAT 3 DESIGN TEAM",0
	.even

txt_ed
	.string	"ED BOON\nSOFTWARE"
	.even

txt_johnt
	.string	"JOHN TOBIAS\nGRAPHICS",0
	.even

txt_steve
	.string	"STEVE BERAN\nGRAPHICS",0
	.even

txt_dan
	.string	"DAN FORDEN\nSOUNDS AND MUSIC",0
	.even

txt_tonyg
	.string	"TONY GOSKIE\nGRAPHICS",0
	.even

txt_dave
	.string	"DAVE MICHICICH\nGRAPHICS",0
	.even

txt_johnv
	.string	"JOHN VOGEL\nGRAPHICS",0
	.even

;**********************************************************************

	.end
