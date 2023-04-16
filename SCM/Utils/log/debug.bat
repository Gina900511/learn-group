@ECHO OFF
REM Func: debug

REM Tag: Import (Dir)                   
REM ------------------------------------
REM None

REM Tag: Error Code                     
REM ------------------------------------
SET /a Err_NotDefined=1

REM Tag: Debug                          
REM ------------------------------------
SET mode_dbg_func_debug=false
SET mode_chk_func_debug=false

REM Tag: Arguments                      
REM ------------------------------------
SET fmt=%~1
SET ref1=%~2
REM %1 = .      // \n
REM %1 = + %2   // Zone
REM %1 = *      // *****
REM %1 = -      // -----
REM %1 = p %2   // Print
REM %1 = o %2   // Opening
REM %1 = e      // Ending
REM %1 = h      // Help
REM Remember to update help tips when change defined.

REM Tag: Batch Test                     
REM ------------------------------------
REM SET fmt=h
REM SET ref1=Test

REM Tag: Main Function                  
REM ------------------------------------
:Main (
    REM Log: Opening
    call :mFunc_chkArg

    if "%fmt%" EQU "." (
        ECHO.

    ) else if "%fmt%" EQU "+" (
        ECHO.
        ECHO . "[debug]: ++ %ref1% >>>>"
        ECHO . "[debug]: |> -----------------------------------"

    ) else if "%fmt%" EQU "*" (
        ECHO . "[debug]: |> ***********************************"

    ) else if "%fmt%" EQU "-" (
        ECHO . "[debug]: |> -----------------------------------"
    ) else if "%fmt%" EQU "c" (
        ECHO * ">>>>>>>>>>> [Check]: %ref1%"

    ) else if "%fmt%" EQU "o" (
        ECHO.
        ECHO . "[debug]: |> *****************************************************************"
        ECHO @ ">>>>>>>>>>> [ Call -> %ref1% ]"
        ECHO . "[debug]: |> -----------------------------------------------------------------"

    ) else if "%fmt%" EQU "e" (
        ECHO.
        ECHO . "[debug]: |> -----------------------------------------------------------------"
        if defined return if "%return%" NEQ "0" if "%return%" NEQ "" (
            ECHO $ ">>>>>>>>>>> [ return -> %return% ]"
        )
        ECHO . "[debug]: |> ========================== [Func End] ==========================="
        ECHO.

    ) else if "%fmt%" EQU "p" (
        ECHO . "[debug]: |> %ref1%"

    ) else if "%fmt%" EQU "h" (
        ECHO "$1 = .      // \n        "
        ECHO "$1 = + $2   // Zone      "
        ECHO "$1 = *      // *****     "
        ECHO "$1 = -      // -----     "
        ECHO "$1 = p $2   // Print     "
        ECHO "$1 = o $2   // Opening   "
        ECHO "$1 = e      // Ending    "
        ECHO "$1 = h      // Help      "

    ) else (
        ECHO # ">>>>>>>>>>> [Warning]: Debug Label Undefined!"

    )

    REM Log: Ending
    Exit /b %ERRORLEVEL%
)

REM Tag: Local Function                 
REM ------------------------------------
:mFunc_chkArg (
    if "%mode_chk_func_debug%" == "true" (
        SETLocal EnableDelayedExpansion
        if not defined fmt ( SET ERRORLEVEL=%Err_NotDefined%
        ) else ( ECHO * ">>>>>>>>>>> [Check]: fmt = %fmt%" )

        if not defined ref1 ( SET ERRORLEVEL=%Err_NotDefined%
        ) else ( ECHO * ">>>>>>>>>>> [Check]: ref1 = %ref1%" )
        
        if !ERRORLEVEL! NEQ 0 ( 
            ECHO * ">>>>>>>>>>> [Check]: Arg Not Defined!"
            Exit /b !ERRORLEVEL!
        )
        SETLocal
    )
    goto :EOF
)
:mFunc_name (
    REM No mFunc
    goto :EOF
)
