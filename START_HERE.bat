@echo off
setlocal
title CareerPluse Marketing - GitHub Setup
cd /d "%~dp0"
echo CareerPluse Public GitHub Repo + 60 Issues Setup (Fixed)
echo --------------------------------------------------------
where gh >nul 2>nul
if errorlevel 1 (
  echo ERROR: Install GitHub CLI: https://cli.github.com/
  pause
  exit /b 1
)
where git >nul 2>nul
if errorlevel 1 (
  echo ERROR: Install Git for Windows: https://git-scm.com/downloads
  pause
  exit /b 1
)
gh auth status >nul 2>nul
if errorlevel 1 (
  echo GitHub login needed.
  gh auth login
  if errorlevel 1 (
    echo GitHub login failed.
    pause
    exit /b 1
  )
)
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\setup-github.ps1"
if errorlevel 1 (
  echo.
  echo Setup encountered an error. Copy the error above into ChatGPT.
  pause
  exit /b 1
)
echo.
echo SUCCESS! Check your repository Issues tab and confirm 60 issues.
pause
