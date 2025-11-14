@echo off
:: OpenXR Installation Script for Windows 11 24H2+
:: Run as administrator

title OpenXR Installation for Windows 11 24H2

:: Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ========================================
    echo ERROR: Administrator privileges required
    echo ========================================
    echo.
    echo Please right-click this file and select "Run as administrator"
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo OpenXR Installation for Windows 11 24H2
echo ========================================
echo.

:: Run PowerShell installation script
echo Starting installation...
echo.

powershell.exe -ExecutionPolicy Bypass -File "%~dp0install_openxr.ps1"

if %errorLevel% equ 0 (
    echo.
    echo Installation script completed.
    echo.
) else (
    echo.
    echo Installation encountered an error.
    echo Please check the output above for details.
    echo.
)

pause
