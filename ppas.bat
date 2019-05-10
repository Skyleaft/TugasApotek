@echo off
c:\dev-pas\bin\ldw.exe  E:\REPOSI~1\Pascal\rsrc.o -s   -o e:\reposi~1\pascal\tugasa~1\dataap~1.exe link.res exp.$$$
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
