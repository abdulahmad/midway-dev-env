**************************************************************************
*											     *
*  video game project:	Mortal Kombat 2							*
* 											     *
*  game software:    	Ed Boon								     *
* 											     *
*  module: death blows										*
* 											     *
*  copyright (c) 1993 midway manufacturing							*
*											     *
**************************************************************************
	.file	"mkdeath.asm"
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

db1_table
db2_table
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever
	.long	wait_forever

local_wait_forever
	jauc	wait_forever

;*********************************************************************

	.end
