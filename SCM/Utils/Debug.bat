@ECHO OFF

REM + Defined Error Code
REM ------------------------------------
SET /a Err_CannotFound_Tag=1
SET /a Err_CannotFound_Key=2

REM + Defined Mode
REM ------------------------------------
SET mode_dbg=true

REM + Defined Var or Clear
REM ------------------------------------
SET dir_cache=%~dp0cache
SET reg_dbg_func=%dir_cache%\reg-dbg_func
SET guard=0

REM + Arguments
REM ------------------------------------
SET info=%1


:Func_Debug (
    
    REM Register dbg_func = true
    if Exist %reg_dbg_func%-true.bat (
        call :debug "reg-dbg_func = true"
        ECHO %info%
        goto :End
    )

    REM Register dbg_func = false
    if Exist %reg_dbg_func%-false.bat (
        call :debug "reg-dbg_func = false"
        goto :End
    )

    REM No Registered
    goto :Prepare

)

ECHO [Error]: Call by Debug.bat
Pause
Exit /b -1
REM ============================================================================

:Prepare (
    REM + Defined Var or Clear
    REM ------------------------------------
    SET dir_config=%~dp0../../.vscode/config.ini
    SET tag=[Debug]
    SET key=dbg_func

    REM + Arguments
    REM ------------------------------------
    REM -

    REM + Check Arg & Var
    REM ------------------------------------
    if %dir_config% EQU "" (
        REM ECHO [default] config.ini PATH: ...
        SET dir_config=%~dp0../../.vscode/config.ini
    )

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

REM 只要出現 reg-dbg_func-?.bat 無論 true or false，都不可能到此 Func
:Registered (

    if guard == 2 ( Exit /b -1 )
    SET /a guard=%guard%+1

    if "%return%" EQU "true" (
        ECHO >> %reg_dbg_func%-true.bat
        ECHO [Make File]: *** %reg_dbg_func%-true.bat ***
        goto :Func_Debug
    )
    
    if "%return%" EQU "false" (
        ECHO >> %reg_dbg_func%-false.bat
        ECHO [Make File]: *** %reg_dbg_func%-false.bat ***
        goto :Func_Debug
    )
    
    Exit /b -1
)


:End
Exit /b 0


:debug (
    if "%mode_dbg%" EQU "true" ( ECHO ** %1 )
    goto :EOF
)
