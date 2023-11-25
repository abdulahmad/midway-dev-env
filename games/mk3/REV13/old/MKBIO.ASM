**************************************************************************
*											     *
*  video game project:	mortal kombat 3							*
* 											     *
*  game software:    	ed boon									*
* 											     *
*  module: bio screen stuff									*
* 											     *
*  copyright (c) 1995 Midway Manufacturing							*
*											     *
**************************************************************************
	.file	'mkbio.asm'
	.title	" <<< mortal kombat bio >>> "

	.width	132
	.option	b,d,l
	.mnolist
*
* get the system stuff
*
	.include	dispequ.asm		; display processor equates
	.include	sysequ.asm		; sys.inc and gsp.inc
	.include	macros.hdr		; macros
	.include	mainequ.asm
	.include	dipequ.asm
	.include	stringh.asm
	.text

;**************************************

mk3_bio
	callr	page_0_zip_setup

	move	@c_amode_bio,a0,w

;**********************
	cmpi	9,a0
	jrne	bio4
	movk	10,a0			; patch around kung lao !!
	move	a0,@c_amode_bio,w
bio4
;**********************

	clr	a10
	jsrp	display_zipped_pic

	movi	>0d,a0
	sll	5,a0
	addi	table_o_mods,a0
	move	*a0,a0,l
	calla	init_bakmods
	calla	multi_plane
	clr	a6
	move	a6,@f_auto_erase,w

	move	@c_amode_bio,a0,w
	sll	5,a0
	addi	bio_titles,a0
	movi	>00180103,a9
	move	*a0+,a8,l
	jsrp	pds_centered

	move	@c_amode_bio,a0,w
	addi	>28,a0
	calla	triple_sound		; say the name please
	calla	display_on

	sleep	3

	calla	display_off
	calla	view_page_0
	sleep	>40*12
	retp


page_0_zip_setup
	clr	a6
	move	a6,@f_auto_erase,w
	push	a8
	calla	display_off
	clr	a0
	not	a0
	move	a0,@noflip,w	   	; take control of page flipping !!
	calla	view_page_1
	movi	page0adr+xpadding,a1	; plot to page 0
	move	a1,@pageaddr,l		; plot to page 0
	movi	[253,0],a0
	move	a0,@dmatplft,l 		; set dma window to page 0
	pull	a8
	rets

bio_titles
	.long	txt_kano_bio
	.long	txt_sonya_bio
	.long	txt_jax_bio
	.long	txt_ind_bio
	.long	txt_sz_bio
	.long	txt_swat_bio
	.long	txt_sindel_bio
	.long	txt_sektor_bio
	.long	txt_cyrax_bio
	.long	txt_lao_bio
	.long	txt_kabal_bio
	.long	txt_sg_bio
	.long	txt_st_bio
	.long	txt_lk_bio
	.long	txt_kano_bio
	.long	txt_sindel_bio

txt_kano_bio
	.string	"- KANO -\n"
	.string "KANO IS THOUGHT TO HAVE\n"
	.string "BEEN KILLED IN THE FIRST\n"
	.string "TOURNAMENT. INSTEAD HE'S\n"
	.string "FOUND ALIVE IN THE OUT-\n"
	.string "WORLD WHERE HE ONCE AGAIN\n"
	.string "ESCAPES CAPTURE BY SONYA.\n"
	.string "BEFORE THE ACTUAL OUTWORLD\n"
	.string "INVASION, KANO CONVINCES\n"
	.string "SHAO KAHN TO SPARE HIS\n"
	.string "SOUL. KAHN NEEDS SOMEONE\n"
	.string "TO TEACH HIS WARRIORS HOW\n"
	.string "TO USE EARTH'S WEAPONS.\n"
	.string "KANO IS THE MAN TO DO IT."
	.byte	0
	.even

txt_sonya_bio
	.string "- LT. SONYA BLADE -\n"
	.string "SONYA DISAPPEARED AFTER\n"
	.string "THE FIRST TOURNAMENT BUT\n"
	.string "WAS LATER RESCUED FROM\n"
	.string "THE OUTWORLD BY JAX. AFTER\n"
	.string "RETURNING TO EARTH SHE AND\n"
	.string "JAX TRY TO WARN THE U.S.\n"
	.string "GOVERNMENT OF THE LOOMING\n"
	.string "OUTWORLD MENACE. LACKING\n"
	.string "PROOF, THEY WATCH\n"
	.string "HELPLESSLY AS SHAO KAHN\n"
	.string "BEGINS HIS INVASION."
	.byte	0

txt_jax_bio
	.string "- MAJ. JAX BRIGGS -\n"
	.string "AFTER FAILING TO CONVINCE\n"
	.string "HIS SUPERIORS OF THE\n"
	.string "COMING OUTWORLD MENACE,\n"
	.string "JAX BEGINS TO COVERTLY\n"
	.string "PREPARE FOR FUTURE BATTLE\n"
	.string "WITH KAHN'S MINIONS. HE\n"
	.string "OUTFITS BOTH ARMS WITH \n"
	.STRING "INDESTRUCTIBLE BIONIC\n"
	.string "IMPLANTS. THIS IS A WAR\n"
	.string "JAX IS PREPARED TO WIN.\n"
	.byte	0

txt_ind_bio
	.string	"- NIGHTWOLF -\n"
	.string "WORKS AS A HISTORIAN AND\n"
	.string "PRESERVER OF HIS PEOPLE'S\n"
	.string "CULTURE. WHEN KAHN'S\n"
	.string "PORTAL OPENS OVER NORTH\n"
	.string "AMERICA, NIGHTWOLF USES\n"
	.string "THE MAGICS OF HIS SHAMEN\n"
	.string "TO PROTECT HIS TRIBE'S\n"
	.string "SACRED LAND. THIS AREA\n"
	.string "BECOMES A VITAL THREAT TO\n"
	.string "KAHN'S OCCUPATION OF THE\n"
	.string "EARTH.\n"
	.byte	0

txt_sz_bio
	.string	"- SUB-ZERO -\n"
	.string "THE NINJA RETURNS UN-\n"
	.string "MASKED. HE WAS BETRAYED\n"
	.string "BY HIS OWN NINJA CLAN-\n"
	.string "THE LIN KUEI. HE BROKE\n"
	.string "SACRED CODES OF HONOR BY\n"
	.string "LEAVING THE CLAN AND IS\n"
	.string "MARKED FOR DEATH. BUT UN-\n"
	.string "LIKE THE NINJA OF OLD HIS\n"
	.string "PURSUERS COME AS MACHINES.\n"
	.string "HE MUST NOT ONLY DEFEND\n"
	.string "AGAINST THE OUTWORLD MEN-\n"
	.string "ACE BUT MUST ALSO ELUDE\n"
	.string	"HIS SOULLESS ASSASSINS.\n"
	.byte	0

txt_swat_bio
	.string	"- STRYKER -\n"
	.string "WHEN THE OUTWORLD PORTAL\n"
	.string "OPENS OVER A LARGE CITY IN\n"
	.string "NORTH AMERICA, PANIC AND\n"
	.string "CHAOS RAGE OUT OF CONTROL.\n"
	.string "KURTIS STRYKER WAS THE\n"
	.string "LEADER OF A RIOT CONTROL\n"
	.string "BRIGADE WHEN SHAO KAHN\n"
	.string "BEGAN TAKING SOULS. HE\n"
	.string "FINDS HIMSELF THE LONE\n"
	.string "SURVIVOR OF A CITY ONCE\n"
	.string "POPULATED BY MILLIONS.\n"
	.byte	0

txt_sektor_bio
	.string "- SEKTOR -\n"
	.string "SEKTOR IS ACTUALLY THE\n"
	.string "CODE NAME FOR UNIT LK-9T9.\n"
	.string "HE WAS THE FIRST OF THREE\n"
	.string "PROTOTYPE CYBERNETIC\n"
	.string "NINJAS BUILT BY THE LIN\n"
	.string "KUEI. SEKTOR WAS ONCE A\n"
	.string "HUMAN ASSASSIN TRAINED BY\n"
	.string "THE LIN KUEI. HE VOLUN-\n"
	.string "TEERED FOR AUTOMATION BE-\n"
	.string "CAUSE OF HIS LOYALTY FOR\n"
	.string "THE CLAN. SEKTOR SURVIVES\n"
	.string "THE OUTWORLD INVASION - HE\n"
	.string "HAS NO SOUL TO TAKE.\n"
	.byte	0

txt_cyrax_bio
	.string "- CYRAX -\n"
	.string "CYRAX IS UNIT LK-4D4.\n"
	.string "THE 2ND OF THREE PROTO-\n"
	.string "TYPE CYBERNETIC NINJAS\n"
	.string "BUILT BY THE LIN KUEI.\n"
	.string "LIKE HIS COUNTERPARTS\n"
	.string "HIS LAST PROGRAMMED COM-\n"
	.string "MAND IS TO FIND AND TER-\n"
	.string "MINATE THE ROGUE NINJA,\n"
	.string "SUB-ZERO. WITHOUT A SOUL,\n"
	.string "CYRAX GOES UNDETECTED BY\n"
	.string "SHAO KAHN AND REMAINS A\n"
	.string "POSSIBLE THREAT AGAINST\n"
	.string "HIS OCCUPATION OF EARTH.\n"
	.byte	0

txt_lao_bio
	.string "- KUNG LAO -\n" 
	.string "KUNG LAO'S PLAN TO REFORM\n"
	.string "THE WHITE LOTUS SOCIETY\n"
	.string "COMES TO A HALT WHEN SHAO\n"
	.string "KAHN'S INVASION TAKES THE\n"
	.string "EARTH BY STORM. AS A\n"
	.string "CHOSEN WARRIOR KUNG LAO\n"
	.string "MUST USE HIS GREATEST\n"
	.string "FIGHTING SKILLS TO BRING\n"
	.string "DOWN SHAO KAHN'S REIGN\n"
	.string "OF TERROR.\n"
	.byte	0

txt_kabal_bio
	.string "- KABAL -\n"
	.string "AS A CHOSEN WARRIOR HIS\n"
	.string "IDENTITY IS A MYSTERY TO\n"
	.string "ALL. IT'S BELIEVED THAT\n"
	.string "HE IS THE SURVIVOR OF AN\n"
	.string "ATTACK BY SHAO KAHN'S EX-\n"
	.string "TERMINATION SQUADS. AS A\n"
	.string "RESULT HE IS VICIOUSLY\n"
	.string "SCARRED AND KEPT ALIVE\n"
	.string "ONLY BY ARTIFICIAL RESPIR-\n"
	.string "ATORS AND A RAGE FOR END-\n"
	.string "ING SHAO KAHN'S CONQUEST.\n"
	.byte	0

txt_sg_bio
	.string "- SHEEVA -\n"
	.string "SHE WAS HAND PICKED BY\n"
	.string "SHAO KAHN TO SERVE AS \n"
	.string "SINDEL'S PERSONAL\n"
	.string "PROTECTOR. SHE BECOMES\n"
	.string "SUSPICIOUS OF SHAO KAHN'S\n"
	.string "LOYALTY TOWARDS HER RACE\n"
	.string "OF SHOKAN WHEN HE PLACES\n"
	.string "MOTARO AS THE LEADER OF\n"
	.string "HIS EXTERMINATION SQUADS.\n"
	.string "ON THE OUTWORLD MOTARO'S\n"
	.string "RACE OF CENTAURIANS ARE\n"
	.string "THE NATURAL ENEMY OF\n"
	.string "SHOKAN.\n"
	.byte	0

txt_st_bio
	.string "-SHANG TSUNG-\n"
	.string "TSUNG IS SHAO KAHN'S LEAD\n"
	.string "SORCEROR. HE ONCE FELL OUT\n"
	.string "OF FAVOR WITH HIS EMPEROR\n"
	.string "AFTER FAILING TO WIN THE\n"
	.string "EARTH REALM THROUGH TOURN-\n"
	.string "AMENT BATTLE. BUT THE EVER\n"
 	.string "SCHEMING SHANG TSUNG IS\n"
 	.string "INSTRUMENTAL IN KAHN'S\n"
 	.string "CONQUEST OF EARTH. HE HAS\n"
 	.string "NOW BEEN GRANTED MORE\n"
 	.string "POWER THAN EVER."
	.byte	0

txt_lk_bio
	.string "- LIU KANG -\n"
	.string "AFTER THE OUTWORLD\n"
	.string "INVASION LIU KANG FINDS\n"
	.string "HIMSELF THE PRIME TARGET\n"
	.string "OF KAHN'S EXTERMINATION\n"
	.string "SQUADS. HE IS THE SHAOLIN\n"
	.string "CHAMPION AND HAS THWARTED\n"
	.string "KAHN'S SCHEMES IN THE\n"
	.string "PAST. OF ALL THE HUMANS,\n"
	.string "KANG POSES THE GREATEST\n"
	.string "THREAT TO SHAO KAHN'S\n"
	.string "RULE.\n"
	.byte	0

txt_sindel_bio
	.string "- SINDEL -\n"
	.string "SHE ONCE RULED THE OUT-\n"
	.string "WORLD AT SHAO KAHN'S SIDE\n"
	.string "AS HIS QUEEN. NOW 10,000\n"
	.string "YEARS AFTER HER UNTIMELY\n"
	.string "DEATH SHE IS REBORN ON\n"
	.string "EARTH. HER EVIL INTENT IS\n"
	.string "EVERY MATCH FOR SHAO\n"
	.string "KAHN'S TYRANNY. SHE IS\n"
	.string "THE KEY TO HIS OCCUPATION\n"
	.string "OF EARTH.\n"
	.byte	0
	.even

;*********************************************

	.end
