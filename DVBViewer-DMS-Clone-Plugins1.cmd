@echo off
pushd "%~dp0"

echo This batch makes DVBViewer DMS Plugins2..Plugins32 folders exact copies of the Plugins1 folder.
echo.
echo Existing data in Plugins2..Plugins32 folders is deleted without notification.
echo.
echo.
echo Administrative rights required. Detecting permissions ...
net session >nul 2>&1
if %errorLevel% == 0 (
	echo Success: Administrative permissions confirmed.
	) else (
	echo Failure: Current permissions inadequate. Exiting.
	goto :eof
)
echo Stopping Digital Media Server
net stop DVBVRecorder
echo.
echo.
echo.

if exist "%ProgramFiles(x86)%\DVBViewer\Plugins\plugins1" (
	for /l %%X in (2,1,32) do (
		echo Working on folder "%ProgramFiles(x86)%\DVBViewer\Plugins\plugins%%X"
		echo    delete folder
		if exist "%ProgramFiles(x86)%\DVBViewer\Plugins\plugins%%X" rd /s /q "%ProgramFiles(x86)%\DVBViewer\Plugins\plugins%%X"
	
		echo    ^(re^)create folder
		md "%ProgramFiles(x86)%\DVBViewer\Plugins\plugins%%X"
	
		echo    copy files to folder
		xcopy "%ProgramFiles(x86)%\DVBViewer\Plugins\plugins1" "%ProgramFiles(x86)%\DVBViewer\Plugins\plugins%%X" /I /E /H /R /Y /Q
		echo.
	)
)

echo Starting Digital Media Server
net start DVBVRecorder
echo.
echo.
echo.