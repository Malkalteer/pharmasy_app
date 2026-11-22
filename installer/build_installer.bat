@echo off
REM Build the app and the installer on Windows
REM Requirements: Flutter SDK + Visual Studio 2022 (Desktop development with C++) + Inno Setup 6
setlocal
cd /d "%~dp0\.."

set VERSION=%1
if "%VERSION%"=="" set VERSION=1.0.0

echo === [1/4] flutter pub get ===
call flutter pub get || goto :error

echo === [2/4] Running tests ===
call flutter test || goto :error

echo === [3/4] Building (obfuscated) ===
call flutter build windows --release --obfuscate --split-debug-info=build\symbols --build-name=%VERSION% || goto :error

echo === Copying Visual C++ runtime ===
if not exist installer\vcruntime mkdir installer\vcruntime
copy /Y %SystemRoot%\System32\msvcp140.dll installer\vcruntime\ >nul
copy /Y %SystemRoot%\System32\vcruntime140.dll installer\vcruntime\ >nul
copy /Y %SystemRoot%\System32\vcruntime140_1.dll installer\vcruntime\ >nul

echo === [4/4] Creating installer ===
set ISCC="%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
if not exist %ISCC% set ISCC="%ProgramFiles%\Inno Setup 6\ISCC.exe"
%ISCC% /DAppVersion=%VERSION% installer\pharmacy_setup.iss || goto :error

echo.
echo Done! Installer: build\installer\PharmacyManager-Setup-%VERSION%.exe
goto :eof

:error
echo Build failed
exit /b 1
