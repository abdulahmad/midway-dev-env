@echo off
rem mk321u54 63
rem uncomment and add orig roms to build flat merged bin.
rem c:\bin\far\srec_cat -o ROM_ORIG.bin -binary mk321u54.bin -binary -unsplit 2 0 mk321u63.bin -binary -unsplit 2 1
copy /b mk321f8.0 + mk321fc.0  mk321u54.bin
copy /b mk321f8.1 + mk321fc.1  mk321u63.bin
del *.0 *.1

