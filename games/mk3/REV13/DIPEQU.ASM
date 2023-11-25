**************************************************************************
*											     *
*   mortal kombat dip switch mask equates						     *
* 											     *
*   dipswitch located at location 1c00030						     *
*											     *
**************************************************************************
dip_violence 	.set	00001H		; # of players setting
dip_blood	.set	00002H		; blood in game
dip_low_blow	.set	00004H		; low blow
dip_amsounds	.set	00008H		; attract mode sounds
dip_comic	.set	00010H		; comic book offer
dip_bill_val	.set	00020H		; dollar bill validator
dip_skip_test	.set	00040H		; skip rom test
dip_8meg		.set	00080H		; 8 mega bit parts

dip_cmoscoin	.set	00100H		; use cmos coinage
dip_coinage	.set	00e00H		; coinage mask
dip_country	.set	03000H		; country mask
dip_counter	.set	04000H		; number of coin counters
dip_diag  	.set	08000H		; freeze switch (not seen in diag test)

;dip_plyr 	equ	00001H		; # of players setting
;dpusecmos	equ	00002H		; use cmos mask
;dpcoinage	equ	0001cH		; right coin slot mask
;dpcountry	equ	0300h		; country mask
;dip_eogcred	equ	0400h		; end of game credit award "on"
;dpcounter	equ	0800h		; number of coin counters
;dpplayers	equ	3000h		; number of hardware players
;dpfreeze	equ	4000h		; freeze switch
;dptest		equ	8000h		; test switch


;
;	0 = off
;	1 = on
;
;	thanks to mark loffredo for reaming me over and reversing the
;	dip switches
;
;	dpusecmos ( ds1 - 2 )
;
;	0	= dip switch coinage used
;	1	= cmos coinage used
;
;	dprightslot ( ds1 - 5 4 3 )
;
;	000	= 1 coin / 1 credit
;	001	= 2 coin / 1 credit
;	010	= 3 coin / 1 credit
;	011	= 4 coin / 1 credit
;	100	= 1 coin / 2 credit
;	101	= 1 coin / 3 credit
;	110	= 1 coin / 4 credit
;	111	= freeplay
;
;	dprightslot ( ds1 - 8 7 6 )
;
;	000	= 1 coin / 1 credit
;	001	= 2 coin / 1 credit
;	010	= 3 coin / 1 credit
;	011	= 4 coin / 1 credit
;	100	= 1 coin / 2 credit
;	101	= 1 coin / 3 credit
;	110	= 1 coin / 4 credit
;	111	= freeplay
;
;	dip_country ( ds2 - 2 1 )
;
;	00	= usa
;	01	= german
;	10	= french
;	11	= outerspace
;
;	dpunused1 ( ds2 - 3 )
;
;	dip_counter ( ds2 - 4 )
;
;	0	= 1 counter
;	1	= 2 counters
;
;	dpplayers ( ds2 - 6 5 )
;
;	00	= game configured for 4 players
;	01	= game configured for 3 players
;	10	= game configured for 2 players
;	11	= game configured for 1 player
;
;	dpfreeze ( ds2 - 7 )
;
;	0	= don't freeze screen
;	1	= freeze screen ( note : must have a transition to work )
;
;	dptest ( ds2 - 8 )
;
;	0	= normal non-test
;	1	= test mode
;
