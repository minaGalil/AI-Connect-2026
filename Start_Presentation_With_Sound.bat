@echo off
setlocal
set "PRESENTATION=%~dp0index.html"
set "EDGE=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" (
  echo Microsoft Edge was not found.
  pause
  exit /b 1
)
for %%I in ("%PRESENTATION%") do set "PRESENTATION_URL=file:///%%~fI"
set "PRESENTATION_URL=%PRESENTATION_URL:\=/%"
start "" "%EDGE%" --autoplay-policy=no-user-gesture-required --start-fullscreen "%PRESENTATION_URL%"
endlocal
