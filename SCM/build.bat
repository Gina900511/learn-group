@ECHO OFF
REM Func: build for Windows

REM Tag: Import (Dir)                   
REM ------------------------------------
SET logger=%~dp0\Utils\log\logger.bat

REM Tag: Error Code                     
REM ------------------------------------
REM SET /a Err_NotDefined=1

REM Tag: Debug                          
REM ------------------------------------
SET g_mode_dbg=false
REM SET mode_dbg_func_build=true
REM SET mode_chk_func_build=false

REM Tag: Arguments                      
REM ------------------------------------
SET str_dir_caller=%1
SET target=%2
SET tgt_name=%3

REM Tag: Batch Test                     
REM ------------------------------------

REM Tag: Main Function                  
REM ------------------------------------
:Main (

    :Build (
        ECHO.
        ECHO ***********************************
        ECHO          [Start To Build]         
        ECHO ***********************************
        ECHO.

        ECHO [Main-Program]: %target%

        SET dir_caller=%str_dir_caller:~1,-2%
        ECHO [Build-From]:   %dir_caller%

        REM Project
        SET dir_workspace=%~dp0..
        SET dir_dev=%~dp0Develop
        SET dir_src=%~dp0..\src

        CALL %~dp0\Utils\func_getFileExt.bat %target%
        SET fileExt=%return%

        SETLocal EnableDelayedExpansion
        if "%fileExt%" EQU "c" (
            CALL %~dp0\For_c\build_c.bat %dir_dev% %target% %dir_src% %dir_caller%\%target% %tgt_name%
            SET errCode=!return!

        ) else if "%fileExt%" EQU "cpp" (
            CALL %~dp0\For_cpp\build_cpp.bat %dir_dev% %target% %dir_src% %dir_caller%\%target% %tgt_name%
            SET errCode=!return!

        ) else (
            REM ECHO File Ext = Folder
            SET errCode=1
        )
        SETLocal

        if %errCode% EQU 0 (
            ECHO.
            ECHO ========= [Build Success] =========
            ECHO ***********************************
            ECHO.
        ) else (
            ECHO.
            ECHO =========  [Build Fail] ===========
            ECHO ***********************************
            ECHO.
            goto :End
        )

    )

    ECHO .
    ECHO .
    ECHO .
    ECHO .
    ECHO .
    ECHO .
    ECHO .
    ECHO .
    ECHO .

    :Start_Program (
        ECHO.
        ECHO ***********************************
        ECHO            Start Program           
        ECHO ***********************************

        ECHO.
        ECHO 1. Arguments
        ECHO -----------------------------------
        ECHO - Null
        ECHO - Null

        ECHO.
        ECHO 2. Main Program [%target%] Log
        ECHO -----------------------------------
        ECHO.
        %tgt_name%.exe

        ECHO.
        ECHO.
        ECHO 3. Program Return
        ECHO -----------------------------------
        SET errCode=%ERRORLEVEL%
        ECHO return %errCode%

        ECHO.
        ECHO ============= [Stop] ==============
        ECHO ***********************************

        if %errCode% EQU 0 (
            ECHO "[ ----------- Done ------------ ]"
            ECHO.
            goto :End
        ) else if %errCode% EQU -1073741819 (
            ECHO.
            ECHO "[ ----------- Error ----------- ]"
            ECHO "|> Return Code (-1073741819)"
            ECHO "|> [Info]: Type Incompatible !!! "
            ECHO "[ ----------- ***** ----------- ]"
            ECHO.
            goto :End
        ) else (
            ECHO.
            ECHO "[ ----------- Error ----------- ]"
            ECHO "|> Return Code (%errCode%)"
            ECHO "|> [Info]: Unknown ... "
            ECHO "[ ----------- ***** ----------- ]"
            ECHO.
            goto :End
        )

    )

    :End (
        ECHO * End of run ...
        ECHO.
    )

)