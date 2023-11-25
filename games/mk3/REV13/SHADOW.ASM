**************************************************************************
*											     *
*  Cache aligned code #2 - Shadow code						     *
*											     *
**************************************************************************

;	.sect	"SHADORG"

**************************************************************************
*											     *
*   shadow_a8 - Does multipart shadows THE HARD WAY. Using		     *
* 											     *
*   a5 = page offset to add to coordinates							*
*   a8 = y:x coordinates										*
*   a9 = multipart ram pointer								     *
*  a10 = sag pointer									     *
*  a11 =	x size of piece									     *
*  a13 = scratch											*
*  a14 = control:offset									     *
* 											     *
*   b1 = lead multiplier									     *
*   b2 = ground y										*
*   b3 = counter											*
*   b4 = ani y:x										     *
*   b5 = line counter										*
*											     *
**************************************************************************
	.sect	"SHADORG"

shadow_p1p2
	movi	001000100H,a2
	move	a2,@dmaxscl,l	 	; dma input #1 = scale
	movi	bpal_black*010000H,a2
	move	a2,@dmacmap,l	    	; dma input #2 = const:palette
*
* setup dedicated registers
*
*  b0 = dmactrl
*  b1 = worldtly
*  a2 = dma y:x size pointer
*  a3 = dma control:offset
*  a6 = dma y coordinate pointer
* a12 = dma sag pointer
*

	movi	dmahsize,a2		; a2 = faster dma y:x size
	movk	1,a8

	move	a8,*a2(16),w		; y size is always "1"
	movi	dmaoffst,a3
	clr	a8
	move	a8,*a3+,w     		; offset is always "0"
	movi	dmavert,a6
	movi	dmahoriz,a7
	movi	dmasagl,a12

	movi	dmactrl,b0
	move	@worldtly,b1,l
	move	@ceiling_y,b6,w		; ceiling y

	move	@p2_shadadj,b7,w	; player 2 shadow adjust y
	push	b7
	move	@p1_obj,a8,l
	move	@p1_shadadj,b7,w	; player 1 shadow adjust y
	jruc	shadorg

;******* end of commented stuff

	.sect	"SHADORG"

shadorg	callr	shad0
	move	@p2_obj,a8,l
	pull	b7

shad0	move	*a8(oflags2),a0,w
	btst	b_shadow,a0		; shadow ?
	jreq	shad9			; no

	move	*a8(oimg),a9,l		; a9 ---> multipart ram
	move	*a8(oypos),a13,w
	move	*a8(oxpos),a0,w
	zext	a0,w
	sll	16,a13
	or	a13,a0			; a0 = ani y:x for all pieces (world)

	move	b1,a14			; a14 = worldtly
	move	@worldtlx+16,a13,w

;************ fix elevated shadows
	zext	a13,w			; clear out the Y in case x = neg
;************ fix elevated shadows

	or	a14,a13			; a13 = world y:x
	subxy	a13,a0
	move	a0,b4			; b4 = ani y:x (screen coordinates)

	move	@ground_y,a14,w
	sll	16,a14
	subxy	a13,a14			; a14 = [screen ground y,??]
	move	a14,b2
	srl	16,b2
	add	b7,b2			; personal adjust for each ochar
	sll	16,b2			; b2 = [screen ground y,0]

**************************************************************************
*											     *
*  piece by piece loop									     *
*											     *
**************************************************************************

shad2	move	*a9(mp_sag),a10,l	; a10 = sag of this piece
	jreq	shad9			; sag = 0 ---> we are done

	addi	02000000H,a10		; cpu read = add 2 mil

	move	b4,a0			; get ani y:x
	move	*a9(mp_anixy),a13,l
	subxy	a13,a0			; a0 = y:x of this piece

	move	b2,a13			; a13 = [ground y,0]
	subxy	a0,a13			; a13 = [distance from ground,??]
	srl	16,a13

	sll	16-2,a13	  	; a13 = [1/4 distance,0]
	move	b2,a14			; a14 = [ground y,0]
	subxy	a13,a14			; a14 = [shadow y,0]

	movy	a14,a0			; a0 = shadow [1/4 y:x]
	move	*a9(mp_sizey),a13,w	; a13 = # of lines

	srl	2,a13			; shadows are 1/4 the normal height

	move	a13,b5

	move	*a9(mp_sizex),a11,w
	move	a11,*a2,w		; set a11 = x size for this piece

	move	*a9(mp_control),a14,w
	btst	b_fliph,a14		; flip horizontal ?
	jreq	shad1
	addxy	a11,a0			; yes, adjust coordinates for flip
	dec	a0			; and nudge..

shad1	move	a14,a1
	move	a14,a4
	sll	16+4,a1
	srl	32-2,a1			; a1 = trail multiplier
	sll	16+4+2,a4
	srl	32-2,a4			; a4 = lead multiplier

	ori	dmacnz,a14

	addxy	a5,a0
	move	a0,*a7,w		; set x coordinate here !!
	srl	16,a0

**************************************************************************
*											     *
*  line by line loop									     *
*											     *
**************************************************************************

shad4
shad3	move	*b0,b3,w
	jrn	shad3 	      	; wait for dma while busy

	subi	02000000H,a10
	move	a10,*a12,l	; stuff sag
	addi	02000000H,a10

	move	a0,*a6,w      	; set y coordinate
	move	a14,*a3,w     	; set the GO! bit
	dsjs	b5,shad5

**************************************************************************
*											     *
*  do the last line again to fill in "holes"					     *
*											     *
**************************************************************************
	inc	a0
	move	a0,*a6,w	; set y 1 line down
	dec	a0

shad6	move	*b0,b3,w
	jrn	shad6	    	; wait for dma while busy

	move	a14,*a3,w	; set the GO
	addi	mp_length,a9   	; a9 ---> next multipart piece
	jruc	shad2

*
* skip 4 lines
*
shad5	move	*b0,b3,w
	jrn	shad5	 	; wait for dma while busy

	inc	a0

	movk	4,b3
 	setf	8,0,0	 	; field 0 is 8 bits (zero extend)

shad7	move	*a10+,a8,w	; grab a BYTE !!

	move	a8,a13
	sll	32-4,a13
	srl	32-4,a13	; mask off upper b.s.
	sll	a4,a13		; a13 = lead zeros

	srl	4,a8		
	sll	a1,a8		; a8 = trailing zeros

	add	a8,a13		; a13 = lead + trailing = all compressed zeros
	move	a11,a8		; a8 = x size
	sub	a13,a8		; a8 = uncompressed pixels to skip

	sll	1,a8  		; 2x
	add	a8,a10
	sll	1,a8  		; + 4x = 6 bits per pixel
	add	a8,a10		; a10 ---> sag for next line
	dsjs	b3,shad7

;xx
	setf	16,1,0		; field 0 is back to 16 bits
	jruc	shad4

shad9	rets



