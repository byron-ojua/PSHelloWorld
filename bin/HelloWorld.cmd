@echo off
setlocal
rem Prefer PowerShell 7 if present; fall back to Windows PowerShell
where pwsh >nul 2>&1 && (
  pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0hello.ps1" %*
) || (
  powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0hello.ps1" %*
)
endlocal
