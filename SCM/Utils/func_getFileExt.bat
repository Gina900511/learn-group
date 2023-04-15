@ECHO OFF
REM Func: Get File Extension

REM Tag: Import (Dir)                   
REM ------------------------------------
SET logger=%~dp0log\logger.bat

REM Tag: Error Code                     
REM ------------------------------------
SET /a Err_NotDefined=1

REM Tag: Debug                          
REM ------------------------------------
SET mode_dbg_func_getFileExt=true
SET mode_chk_func_getFileExt=true

REM Tag: Arguments                      
REM ------------------------------------
SET fileName=%1

REM Tag: Batch Test                     
REM ------------------------------------
REM SET fileName=program.cpp

REM Tag: Main Function                  
REM ------------------------------------
:Main (
    call :log debug o "func_getFileExt()"
    call :mFunc_chkArg

    REM call :log debug + "Defined"
    REM call :log debug p "[Func]: void func_getFileExt(mode_dbg = default = false);"



    for /f "tokens=2 delims=." %%i in ("%fileName%") do (
        call :log debug + "Result"
        call :log debug p "[Ext]: %%i"

        SET return=%%i
        call :log debug e
        Exit /b %ERRORLEVEL%
    )

    SET return=Folder
    call :log debug e
    Exit /b %ERRORLEVEL%
)

REM Tag: Local Function                 
REM ------------------------------------
:mFunc_chkArg (
    call :log debug + "Arguments"
    if "%mode_chk_func_getFileExt%" == "true" (
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
:log (
    SET cmd=%logger% %1 %2 %3
    if defined g_mode_dbg (
        REM Global debug mode
        if "%g_mode_dbg%" == "true" ( CALL %cmd% )
    ) else (
        REM Local debug mode
        if "%mode_dbg_func_getFileExt%" == "true" ( CALL %cmd% )
    )
    goto :EOF
)
