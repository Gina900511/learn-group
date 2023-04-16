@ECHO OFF
REM 重新注冊

REM + Defined Error Code
REM ------------------------------------
SET /a Err_CannotFound_Tag=1
SET /a Err_CannotFound_Key=2

REM + Defined Mode
REM ------------------------------------
SET mode_dbg=true

REM + Defined Var or Clear
REM ------------------------------------
SET dir_config=%~dp0../../../.vscode/config.ini
SET tag=[Debug]
SET key=dbg_func

REM + Check Arg & Var
REM ------------------------------------
if %dir_config% EQU "" (
    REM ECHO [default] config.ini PATH: ...
    SET dir_config=%~dp0../../../.vscode/config.ini
)

:Func_Register (
    
    goto :Find_Tag
)

:Find_Tag (
    for /f "tokens=1,2 delims==" %%i in (%dir_config%) do (
        if %%i == %tag% (
            call :debug "%%i"
            goto :Find_Key
        )
    )

    ECHO [Warning] Cannot Find tag: %tag%
    Exit /b %Err_CannotFound_Tag%
)

:Find_Key (
    for /f "tokens=1,2 delims==" %%i in (%dir_config%) do (
        if %%i == %key% (
            SET return=%%j
            call :debug "%key% = %%j"
            goto :Registered
        )
    )

    ECHO [Warning] Cannot Find key: %key%
    Exit /b %Err_CannotFound_Key%
)

:Registered (

    SET swh=%return%
    SET reg=reg-%key%-%swh%

    ECHO >> %reg%
    ECHO [Make File]: *** %reg% ***

    goto :Func_Register
)


:End
Exit /b 0

:debug (
    if "%mode_dbg%" EQU "true" ( ECHO ** %1 )
    goto :EOF
)
