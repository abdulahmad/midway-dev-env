@echo off
rem this is cheating, the lod file just adds a data chunk.
rem the correct unzip.tbl is already in the source folder, i just need the IRW :)
rem so i can use it with srec exe..
load2.exe mkcmil /P /di /fi /t=c:\tmp\mk3 /x /v
