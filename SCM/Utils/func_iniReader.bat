@ECHO OFF
REM Func: Init File Reader
REM Return: KeyValue's Value

REM Tag: Import (Dir)                   
REM ------------------------------------
SET logger=%~dp0log\logger.bat
SET dir_config=%~dp0../../.vscode/config.ini
REM config.ini Path

REM Tag: Error Code                     
REM ------------------------------------
SET /a Err_NotDefined=1
SET /a Err_CannotFound_Tag=2
SET /a Err_CannotFound_Key=3

REM Tag: Debug                          
REM ------------------------------------
SET mode_dbg_func_iniReader=true
SET mode_chk_func_iniReader=false

REM Tag: Arguments                      
REM ------------------------------------
SET tag=[%1]
REM Title
SET key=%2
REM Key

REM Tag: Batch Test                     
REM ------------------------------------
SET tag=[Build]
SET key=CM

REM Tag: Main Function                  
REM ------------------------------------
:Main (
    call :log debug o "func_iniReader()"
    REM call :mFunc_chkArg
    goto :Find_Tag
)

:Found (
    SET return=%value%
    call :log debug e
    Exit /b 0
)

REM Tag: Local Function                 
REM ------------------------------------
:mFunc_chkArg (
    call :log debug + "Arguments"
    if "%mode_chk_func_iniReader%" == "true" (
        SETLocal EnableDelayedExpansion
        if not defined fileName ( SET ERRORLEVEL=%Err_NotDefined%
        ) else ( call :log debug c "fileName = %fileName%" )

        if !ERRORLEVEL! NEQ 0 ( 
            call :log debug c "Arg Not Defined!"
            Exit /b !ERRORLEVEL!
        )
        SETLocal
    )
    goto :EOF
)

:Find_Tag (
    for /f "tokens=1,2 delims==" %%i in (%dir_config%) do (
        if %%i == %tag% (
            REM ECHO Found Tag: %%i
            goto :Find_Key
        )
    )
    call :log debug p "[Warning] Cannot Find tag: %tag%"
    SET %ERRORLEVEL% = %Err_CannotFound_Tag%
    call :log debug e
    Exit /b %ERRORLEVEL%
)
:Find_Key (
    for /f "tokens=1,2 delims==" %%i in (%dir_config%) do (
        
        if %%i == %key% (
            call :log debug + "Result"
            SET value=%%j
            SETLocal EnableDelayedExpansion
            call :log debug p "[KV]: %%i = !value!"
            ENDLocal

            goto :Found
        )
        
    )
    call :log debug p "[Warning] Cannot Find key: %key%"
    SET %ERRORLEVEL% = %Err_CannotFound_Key%
    call :log debug e
    Exit /b %ERRORLEVEL%
)
:log (
    SET cmd=%logger% %1 %2 %3
    if defined g_mode_dbg (
        REM Global debug mode
        if "%g_mode_dbg%" == "true" ( CALL %cmd% )
    ) else (
        REM Local debug mode
        if "%mode_dbg_func_iniReader%" == "true" ( CALL %cmd% )
    )
    goto :EOF
)

