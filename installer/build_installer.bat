@echo off
REM Build the app and the installer on Windows
REM Requirements: Flutter SDK + Visual Studio 2022 (Desktop development with C++) + Inno Setup 6 or 7
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

echo === [4/4] Creating installer ===
set "ISCC="
for %%P in ("%ProgramFiles%\Inno Setup 7\ISCC.exe" "%ProgramFiles(x86)%\Inno Setup 7\ISCC.exe" "%LOCALAPPDATA%\Programs\Inno Setup 7\ISCC.exe" "%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe" "%ProgramFiles%\Inno Setup 6\ISCC.exe" "%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe") do (
  if not defined ISCC if exist %%P set "ISCC=%%~P"
)
if not defined ISCC for /f "delims=" %%I in ('where ISCC.exe 2^>nul') do if not defined ISCC set "ISCC=%%I"
if not defined ISCC (
  echo.
  echo ERROR: Inno Setup was not found.
  echo Install it from https://jrsoftware.org/isdl.php then run this script again.
  goto :error
)
echo Using: "%ISCC%"
"%ISCC%" /DAppVersion=%VERSION% installer\pharmacy_setup.iss || goto :error

echo.
echo Done! Installer: build\installer\PharmacyManager-Setup-%VERSION%.exe
goto :eof

:error
echo Build failed
exit /b 1
