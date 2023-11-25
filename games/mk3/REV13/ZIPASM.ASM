echo off
copy %1.zip c:\video\kombat3\oldzips
erase c:\video\kombat3\%1.zip

pkzip %1 -x*.lst -x*.obj -x*.sym
pkzip %1 *.doc
pkzip %1 *.cmd
pkzip %1 macros.hdr
pkzip %1 main.tvs
pkzip %1 makefile
pkzip %1 sndtab.dat
pkzip %1 xcall.dat

pkzip %1 c:\video\kombat2\img\mk*.lod
erase b:*.zip
copy %1.zip b:
echo **************************
echo.
echo  put in the second disk !
echo.
echo **************************
pause
erase b:*.zip
copy %1.zip b:

