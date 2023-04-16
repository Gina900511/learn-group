@ECHO OFF

REM Set a string with an arbitrary number of substrings separated by semi colons
SET teststring=The/rain/in/spain
SET spliter=/

REM Do something with each substring
:stringLOOP (
    REM Stop when the string is empty

    setlocal ENABLEDELAYEDEXPANSION
    if "!teststring!" EQU "" goto :End
    for /f "delims=%spliter%" %%a in ("!teststring!") do (
        SET substring=%%a
        ENDLocal
        SET return=%%a
    )
        
        REM Do something with the substring - 
        REM we just echo it for the purposes of demo
        setlocal ENABLEDELAYEDEXPANSION
        ECHO !substring!
        ENDLocal
)

setlocal ENABLEDELAYEDEXPANSION
REM Now strip off the leading substring
:striploop (
    set stripchar=!teststring:~0,1!
    set teststring=!teststring:~1!

    if "!teststring!" EQU "" goto :stringLOOP
    if "!stripchar!" NEQ "%spliter%" goto :striploop

    goto :stringLOOP
)
ENDLocal

:End

ECHO Test: %return%