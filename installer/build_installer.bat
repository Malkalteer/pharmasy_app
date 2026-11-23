@echo off
REM Build the app and the installer on Windows
REM Requirements: Flutter SDK + Visual Studio (Desktop development with C++) + NSIS 3 (free, also for commercial use)
setlocal
cd /d "%~dp0\.."

set VERSION=%1
if "%VERSION%"=="" set VERSION=1.0.0

if /I "%2"=="skipbuild" goto :package

echo === [1/4] flutter pub get ===
call flutter pub get || goto :error

echo === [2/4] Running tests ===
call flutter test || goto :error

echo === [3/4] Building (obfuscated) ===
call flutter build windows --release --obfuscate --split-debug-info=build\symbols --build-name=%VERSION% || goto :error

:package
if not exist build\windows\x64\runner\Release\PharmacyManager.exe (
  echo ERROR: app is not built yet. Run without "skipbuild" first.
  goto :error
)
echo === Copying Visual C++ runtime ===
if not exist installer\vcruntime mkdir installer\vcruntime
copy /Y %SystemRoot%\System32\msvcp140.dll installer\vcruntime\ >nul
copy /Y %SystemRoot%\System32\vcruntime140.dll installer\vcruntime\ >nul
copy /Y %SystemRoot%\System32\vcruntime140_1.dll installer\vcruntime\ >nul

echo === [4/4] Creating installer (NSIS) ===
set "MAKENSIS="
for %%P in ("%ProgramFiles(x86)%\NSIS\makensis.exe" "%ProgramFiles%\NSIS\makensis.exe" "%LOCALAPPDATA%\Programs\NSIS\makensis.exe") do (
  if not defined MAKENSIS if exist %%P set "MAKENSIS=%%~P"
)
if not defined MAKENSIS for /f "delims=" %%I in ('where makensis.exe 2^>nul') do if not defined MAKENSIS set "MAKENSIS=%%I"
if not defined MAKENSIS (
  echo.
  echo ERROR: NSIS was not found.
  echo Install it from https://nsis.sourceforge.io/Download then run this script again.
  goto :error
)
echo Using: "%MAKENSIS%"
if not exist build\installer mkdir build\installer
"%MAKENSIS%" /V2 /DAPP_VERSION=%VERSION% installer\pharmacy_setup.nsi || goto :error

echo.
echo Done! Installer: build\installer\PharmacyManager-Setup-%VERSION%.exe
goto :eof

:error
echo Build failed
exit /b 1
