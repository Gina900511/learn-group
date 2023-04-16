@ECHO OFF
REM Func: logger

REM Tag: Import (Dir)                   
REM ------------------------------------
SET debug=%~dp0debug.bat

REM Tag: Error Code                     
REM ------------------------------------
SET /a Err_NotDefined=1

REM Tag: Debug                          
REM ------------------------------------
SET mode_dbg_func_logger=true
SET mode_chk_func_logger=false

REM Tag: Arguments                      
REM ------------------------------------
SET lbl=%~1
SET fmt=%~2
SET ref1=%~3

REM Tag: Batch Test                     
REM ------------------------------------
REM SET lbl=debug
REM SET fmt=p
REM SET ref1=Test

REM Tag: Main Function                  
REM ------------------------------------
:Main (
    
    REM Log: Opening
    REM call :mFunc_chkArg

    REM COLOR 0A

    if "%lbl%" == "debug" ( call :debug "%fmt%" "%ref1%"
    REM ) else if %lbl% == "warning" ( call :lbl_warning
    REM ) else if %lbl% == "error" ( call :lbl_error
    ) else ( ECHO "[Warning]: log label is not defined!" )
    
    REM Log: Ending
    Exit /b %ERRORLEVEL%
)

REM Tag: Local Function                 
REM ------------------------------------
:mFunc_chkArg (
    REM Bug: 自檢時，ref1 = Test, 但實際確實 Arguments
    call :debug + "Arguments"
    if "%mode_chk_func_logger%" == "true" (
    SETLocal EnableDelayedExpansion
    if not defined lbl ( SET ERRORLEVEL=%Err_NotDefined%
    ) else ( call :debug c "lbl = %lbl%" )
    
    if not defined fmt ( SET ERRORLEVEL=%Err_NotDefined%
    ) else ( call :debug c "fmt = %fmt%" )

    if not defined ref1 ( SET ERRORLEVEL=%Err_NotDefined%
    ) else ( call :debug c "ref1 = %ref1%" )

    if !ERRORLEVEL! NEQ 0 ( 
        call :debug c "Arg Not Defined!"
        Exit /b !ERRORLEVEL!
    )
    SETLocal
    goto :EOF
)
:debug (
    SET cmd=%debug% %1 %2
    if defined g_mode_dbg (
        REM Global debug mode
        if "%g_mode_dbg%" == "true" ( CALL %cmd% )
    ) else (
        REM Local debug mode
        if "%mode_dbg_func_logger%" == "true" ( CALL %cmd% )
    )
    goto :EOF
)