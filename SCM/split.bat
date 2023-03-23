@ECHO off

SET string=d:\Waylon\Ali\learn-group\SCM\Develop
:split
for /f "tokens=1,* delims=\" %%i in (%string%) do (
    echo Test1 %%i
    echo Test2 %%j

    if not "%%j"=="" (
        echo yes
        set string=%%j
        goto :split
    ) else (
        echo no
    )
)
ECHO target: %string%
goto :end