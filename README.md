# midway-dev-env
An attempt to recreate a dev environment for TMS34010 based Midway Arcade Games (Z, T, X, Wolf Unit) in an effort to build the source for games based on this hardware. This project does not include any source code of the Midway games. Do not ask where to get them either.

The initial reason to start this project was to gather knowledge around the Mortal Kombat games in particular, but doing a wider analysis of all of the TMS34010 games as well as the DCS based games on the audio end, will help understand how the Mortal Kombat games works. But at the same time, if you're more interested in the non-MK games, contributing here and understanding those games better is more than welcome.


## Requirement:
Source code should be located at '../midwaysource/\<game\>'

## TODO:
- Figure out which tools to use for Unix->DOS tools
- Create a DOSBOX dev env
- Try to run MK2 Sound build in DOSBox
- Try to use Graphics tools from NBA Hangtime to build MK Graphics roms
- Try to build any game that does have the program rom makefiles available

# Z Unit (1988)
## Narc
Have been told this game is fully buildable.

# Y Unit (1990)

## Trog

## Smash TV

## Total Carnage

# T Unit (1993)
The T Unit introduced DCS. All the games from here on out use the DCS sound system.

## NBA Jam


## Mortal Kombat 2
Program: Makefile is missing but seems like this could be inferred from other games which do have the Program Makefile

GFX: Seems like the tools to build the graphics ROMs are missing, but these tools seem to be available (alongside documentation) in the NBA Hangtime code.

SND: Full sound toolset seems to be here. Need to create the DOSBOX dev env to test to see if this will build. Includes LOADRAM, PLBUILD, QCOMM, HENRY.

## NBA Jam TE

# X Unit (1994)

## Revolution X
Seems to have the TMS34010 asm tools as well as a version of MAKE. Also includes BIGSREC, SREC, TV20

GFX: Includes BGTOOL, LOAD20, NEWWIMP, UNILIST, WLIB, WTARG

# Wolf Unit (1995)

## WWF Wrestlemania

## Mortal Kombat 3
SND: At least some SND data seems to be here. Includes SOX

## 2 on 2 Open Ice Challenge
Includes LOADW, MAKE, AOTB, BW, SAMPLER, W32SOLE

## NBA Hangtime
Includes LOAD2 (not sure what this is for yet)

GFX: Includes the VDASTUFF graphics tooling (VDA2FRM, ZIP2BIN) alongside documentation on how to use

# Tooling
Section which details what we know about different tools

PLBUILD: Reads \<game\>.def to understand where to read sound files from (REGDIR), and then builds sound files into output ROMs (which are also defined in the def file). Unclear if PLBUILD itself runs HENRY to take the sound files from being SND to CMP, or if PLBUILD only deals with CMP files.

HENRY: Converts uncompressed waveform .SND files into compressed .CMP files