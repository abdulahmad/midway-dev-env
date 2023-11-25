/*	Game linker command file				*/
-e POWERUP		/* entry point of program		*/
-f 0xFFFF		/* fill unspecified memory with value	*/
-o mk3.out		/* specify output file			*/
-m mk3.map		/* map file				*/
-s			/* Kill the symbol table		*/

/* Restructured link order! 					*/
/* From tracing MK3 2.1 production code. 			*/
/* RAM.OBJ was matched with code at FF804000 f_skew		*/

MKDISP.OBJ		/* FF804000 IMAGE HANDLER		*/
RAM.obj			/* MEMORY */
MAIN.OBJ                /* FF8082A0 */
MKZAP.OBJ 		/* FF8085C0 */
BGND.OBJ 
BGNDPAL.OBJ		/* no .text section in this - BACKGROUND TABLES */
BGNDTBL.OBJ		/* no .text section in this - BACKGROUND PALETTES */

MKINIT.OBJ		/* FF8148B0 */
JOY.OBJ 		/* FF81BB50 */
MKBT.OBJ 		/* FF910780 - BACKGROUND TABLES */
BAKGND.OBJ		/* FF9237D0 - background handlers 	*/
PALL.OBJ 		/* FF925280 - PALETTE ROUTINES		*/
MPROC.OBJ               /* FF926780 - MULTI-TASKER		*/ 
UTIL.OBJ		/* FF927400 */
MKFADE.OBJ 		/* FF92AB10 */
MKEND.OBJ 		/* FF92EA10 */
MKBUYIN.OBJ 		/* FF955390 */
MKUTIL.OBJ 		/* FF958110 */
MKANI.OBJ 		/* FF963020 */
MKBT.OBJ 		/* FF910780 - BACKGROUND TABLES */
UNZIP.OBJ 		/* FF928340 */
MKAMODE.OBJ 		/* FF966860 */
MOVES.OBJ 		/* FF977980 */
MKFATAL.OBJ		/* FF998750 */
MKFRIEND.OBJ		/* FF9CCCE0 */
MKPROP.OBJ 		/* FF9D9BA0 */
MKSEL.OBJ 		/* FF9E8690 */
MKREACT.OBJ             /* FFA06C90 */
MKSLAM.OBJ		/* FFA220C0 */
MKSTAT.OBJ  		/* FFA29AB0 */
MKMARK.OBJ 		/* FFA31280 galaga etc */
MKGUYS.OBJ 		/* FFA5DCD0 */
MKBLOOD.OBJ 		/* FFA66830 */
MKBOSS.OBJ 		/* FFA6B740 */
MKDRONE.OBJ		/* FFA77760 */
MKFX.OBJ 		/* FFA8C3D0 */
MKSOUND.OBJ 		/* FFAA3A60 */
MKBUG.OBJ 		/* FFAAD6F0 security+checksummed code.*/

MKDEATH.OBJ 		/* just two tables */



IMGTBL.OBJ 
IMGPAL.OBJ 
IMGPAL2.OBJ 
IMGPAL3.OBJ 
IMGPAL4.OBJ 
IMGPAL5.OBJ 
IMGPAL6.OBJ 
IMGPAL7.OBJ 
IMGPAL8.OBJ 
IMGPAL9.OBJ 
IMGPALA.OBJ 

MKCANNED.OBJ 
/* toast */
MKTEXT.OBJ 
MKHSTD.OBJ 

MKVS.OBJ 
MKANIMAL.OBJ 
MKCOMBO.OBJ 
MKREPELL.OBJ 




/* pong */
/* baby */


MKROBO.OBJ 
MKSCORE.OBJ 

MKLADDER.OBJ 

MKBONUS.OBJ 


MKBIO.OBJ 

MKIND.OBJ 
MKJAX.OBJ 
MKKANO.OBJ 
MKLAO.OBJ 
MKLIA.OBJ 
MKLK.OBJ 
MKMOT.OBJ 
MKR1.OBJ 



MKSG.OBJ 
MKSK.OBJ 
MKSONYA.OBJ 
MKST.OBJ 

MKSTK.OBJ 
MKSWAT.OBJ 
MKSZ.OBJ 
MKTUSK.OBJ 


DIAGADJ.OBJ
DIAGAUDN.OBJ 
DIAGCMOS.OBJ
DIAGCOIN.OBJ 
DIAGDICT.OBJ 
DIAGDTST.OBJ
DIAGDUTL.OBJ 
DIAGFONT.OBJ 
DIAGHSTD.OBJ 
DIAGMENU.OBJ 	
DIAGPIC.OBJ 
DIAGPRNT.OBJ 
DIAGTEXT.OBJ 
DIAGWORD.OBJ


MEMORY        			/* set up memory for sdb board */
{
/*  SCRATCH	: org = 0x01000000,	len = 0x3fffff */
 SCRATCH	: org = 0x01000000,	len = 0x3f7300
 ROM0		: org = 0xFF800000,	len = 0x1000
 ROM1		: org = 0xFF801000,	len = 0x1000
 ROM2		: org = 0xFF804000,	len = 0x7F2F00
 ROM3		: org = 0xFFFF6F00,	len = 0x8D00
 TRAP31		: org = 0xFFFFFC00,	len = 0x400
 IROM		: org = 0x02000000,	len = 0x600000
}

SECTIONS       /* linker sections directive */
 {
	VECTORS:  {} 	> TRAP31
	IMAGES:   {}    > IROM
	GROUP:
	      {
		unzip: {}
		OFIXED: {}
	       .BSS: {}
	       .bss: {}
	      } > SCRATCH

	GROUP:
	      {	
	       FLOORORG: {}
	      } > ROM0

	GROUP:
	      {	
	       SHADORG: {}
	      } > ROM1

	GROUP:
	      {	
	       .text: {}
	       .TEXT: {}
	       .data: {}
	       .DATA: {}
		img_tbl: {}
	      } > ROM2	

 }