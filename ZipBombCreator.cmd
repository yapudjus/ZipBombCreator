@echo off
Setlocal EnableDelayedExpansion
call set mypath = %~dp0
call set 7z = %~dp07z\7za.exe
call set randomidentifier=%random%%random%%random%%random%%random%
echo mypath = !mypath!
:azedc
if not "%1%"=="" (
    if not "%2%"=="" (
        if not "%3%"=="" (
            if not "%4%"=="" (
                if not "%5%"=="" (
                    call set temporary=%5%
                ) else (
                    call set temporary=%temp%
                )
                @REM @echo off
                call set OutputName=%1
                call set FileToBase=%2
                call set Depth=%3
                call set FileCount=%4
                echo 1 = %1%
                echo 2 = %2%
                echo 3 = %3%
                echo 4 = %4%
                echo 5 = %5%
                echo OutputName = %1%
                echo FileToBase = %2%
                echo Depth = %3%
                echo FileCount = %4%
                echo temporary = %temporary%
                echo:
                echo every variable set
                @REM @echo on
                goto azeda
            )
        )
    ) else (
        call set ConfigFile=%1%
        echo the config file is set to %1%
    )
) else (
    call set ConfigFile=config.cfg
    echo the config file is set to default wich is config.cfg
)

if exist .\config.cfg (
    for /f "tokens=* delims=" %%# in (
        %ConfigFile%
    ) do (
        call set "%%#" 
    )
) else (
    exit
)
:azeda
md %temporary%\%randomidentifier% > nul
echo making the temp file
echo:
echo copiing FileToBase
copy %2.zip %temporary%\%randomidentifier%\%2.zip > nul
echo copied FileToBase
echo:
cd /d %temporary%\%randomidentifier% > nul
echo cded to temp
echo:
ren %2.zip 2_%2.zip > nul
echo renamed %2.zip to 2_%2.zip
for /L %%d in (1, 1, %3%) do (
    echo loop depth : %%d
    for /L %%c in (1, 1, %4%) do (
        cls
        echo loop depth : %%d / %Depth% ^| loop count : %%c / %FileCount%
        call set /a "tempor=%%d-1" > nul
        @REM echo tempor = !tempor!
        echo:
        echo copiing !tempor!_%2.zip --^> !tempor!_%2_%%c.zip
        echo:
        copy !tempor!_%2.zip !tempor!_%2_%%c.zip > nul
        echo copied !tempor!_%2.zip --^> !tempor!_%2_%%c.zip
        echo:
        %~dp07z\7za.exe a %%d_%2.zip !tempor!_%2_%%c.zip -mmt%number_of_processors%
        echo added !tempor!_%2_%%c.zip to %%d_%2.zip
        echo:
        del !tempor!_%2%_%%c.zip > nul
        echo !tempor!_%2%_%%c.zip deleted
    )
)
copy %Depth%_%2.zip %~dp0%1%.zip
echo copied %Depth%_%2.zip --^> %~dp0%1%.zip 
@REM rd /q /s %temporary%%randomidentifier% > nul
echo:
@REM echo deleted %temporary%%randomidentifier%\
cd %~dp0 > nul
echo:
echo cded to %~dp0
:eof