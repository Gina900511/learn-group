@ECHO OFF

REM + Error Code
REM ------------------------------------
SET /a Err_CannotFound_Tag=1
SET /a Err_CannotFound_Key=2

REM + Arguments
REM ------------------------------------
SET tag=[%1]
SET key=%2
SET dir_config=%3
SET mod_dbg=%4

REM + Check Arguments
REM ------------------------------------
if not defined dir_config (
    SET dir_config=%~dp0../../.vscode/config.ini
)

ECHO.
ECHO @ Call func_iniReader()
ECHO **********************************************************************

ECHO.
ECHO + Defined
ECHO ----------------------------------------------------------------------
ECHO value func_iniReader(tag, key, dir_config = default);

ECHO.
ECHO + Arguments
ECHO ----------------------------------------------------------------------
ECHO         [Ref-Tag]: %tag%
ECHO         [Ref-Key]: %key%
ECHO [Ref-Config-Path]: %dir_config%

:Find_Tag
for /f "tokens=1,2 delims==" %%i in (%dir_config%) do (
    if %%i == %tag% (
        REM ECHO %%i = %%j
        goto :Find_Key
    )
)
ECHO [Warning] Cannot Find tag: %tag%
Exit /b %Err_CannotFound_Tag%

:Find_Key
for /f "tokens=1,2 delims==" %%i in (%dir_config%) do (
    
    if %%i == %key% (
        ECHO.
        ECHO + Result
        ECHO ----------------------------------------------------------------------
        SET value=%%j
        SETLocal EnableDelayedExpansion
        ECHO [KV]: %%i = !value!
        ENDLocal
        goto :End
    )
    
)
ECHO [Warning] Cannot Find key: %key%
Exit /b %Err_CannotFound_Key%

:End
ECHO.
SET return=%value%
ECHO ============================= [Func End] =============================
ECHO **********************************************************************
ECHO return %return%
ECHO.

Exit /b 0