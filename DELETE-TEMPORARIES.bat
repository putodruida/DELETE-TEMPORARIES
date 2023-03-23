@echo off

REM .bat con permisos de administrador
REM .bat with administrator permissions
:-------------------------------------
REM --> Analizando los permisos
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If there is an error, it means that there are no administrator permissions.
if '%errorlevel%' NEQ '0' (

REM not shown --> echo Solicitando permisos de administrador... 

REM not shown --> echo Requesting administrative privileges... 

REM not shown --> echo Anfordern Administratorrechte ...

goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
:--------------------------------------
cls

REM Delete temporaries from current user
REM To use it on a standard user, modify line 40, changing %USERNAME% to the username of C:\users\
rmdir /S /Q "C:\Users\%USERNAME%\AppData\Local\Temp"

REM Delete temporaries from Windows

rmdir /S /Q "C:\Windows\Temp"

cls
echo [ESP]
echo EL EQUIPO SE REINICIARA, CIERRA TODO Y PULSA UNA TECLA...
echo .
echo [ENG]
echo The computer will restart. Save your work and press a key...
echo .
pause

shutdown -r -f
EXIT
