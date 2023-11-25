brief_case_codes
	.long	>100100
	.long	bc_throwing_disabled
	.long	>222222
	.long	bc_blocking_disabled
	.long	>888000
	.long	bc_p1_handicap
	.long	>000888
	.long	bc_p2_handicap
	.long	>333333
	.long	bc_dark_fighting
	.long	>444444
	.long	bc_switcheroo
	.long	>987666
	.long	bc_jackbot
	.long	0


bc_jackbot
	movk	7,a0
	jruc	stuff_round_123

bc_switcheroo
	movk	6,a0
	jruc	stuff_round_123

bc_dark_fighting
	movk	5,a0
	jruc	stuff_round_123

bc_p1_handicap
	movk	3,a0
	jruc	stuff_round_123

bc_p2_handicap
	movk	4,a0
	jruc	stuff_round_123

bc_throwing_disabled
	movk	1,a0
	move	a0,@round_1_jsrp,w
	move	a0,@round_23_jsrp,w
	rets

bc_blocking_disabled
	movk	2,a0

stuff_round_123
	move	a0,@round_1_jsrp,w
	move	a0,@round_23_jsrp,w
	rets

;**********************************************************
