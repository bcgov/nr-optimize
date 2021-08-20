@echo off

set email=Brian.Price@gov.bc.ca
set writePath=%~1
set logPath=logs
For /f "tokens=1-3 delims=/:" %%a in ("%TIME%") do (set fileTime=%%a%%b%%c)

if not exist %writePath% (
	echo Invalid Path: %writePath%
	exit /b 0
)

if not exist %logPath% (
	mkdir %logPath%
)

REM Write 1 MB file to Remote Path
echo ----Testing File Speed With 1MB File to %writePath%----
diskspd.exe -c1m -L -r -o2 -Sr -ft -w50 %writePath%\fileTest1MB.dat > %logPath%/remoteFileTest1MB_%fileTime%.log

REM Write 10 MB file to Remote Path
echo ----Testing File Speed With 10MB File to %writePath%----
diskspd.exe -c10m -L -r -o2 -Sr -ft -w50 %writePath%\fileTest10MB.dat > %logPath%/remoteFileTest10MB_%fileTime%.log

REM Write 100 MB file to Remote Path
echo ----Testing File Speed With 100MB File to %writePath%----
diskspd.exe -c100m -L -r -o2 -Sr -ft -w50 %writePath%\fileTest100MB.dat > %logPath%/remoteFileTest100MB_%fileTime%.log

REM Write 100 MB file to Remote Path
echo ----Testing File Speed With 1GB File to %writePath%----
diskspd.exe -c1g -L -r -o2 -Sr -ft -w50 %writePath%\fileTest1GB.dat > %logPath%/remoteFileTest1GB_%fileTime%.log


echo Please send files in %logPath% to %email%
explorer %logPath%
pause