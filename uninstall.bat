@echo off
:: OpenXR Uninstallation Script
:: Removes OpenXR runtime configuration

title OpenXR Uninstallation

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
echo OpenXR Uninstallation
echo ========================================
echo.
echo WARNING: This will remove OpenXR runtime configuration
echo.

choice /C YN /M "Do you want to continue"
if %errorLevel% neq 1 (
    echo.
    echo Uninstallation cancelled.
    echo.
    pause
    exit /b 0
)

echo.
echo Removing OpenXR registry keys...
echo.

:: Remove ActiveRuntime value
reg delete "HKLM\SOFTWARE\Khronos\OpenXR\1" /v ActiveRuntime /f >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Removed ActiveRuntime
) else (
    echo [INFO] ActiveRuntime not found or already removed
)

:: Remove AvailableRuntimes
reg delete "HKLM\SOFTWARE\Khronos\OpenXR\1\AvailableRuntimes" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Removed AvailableRuntimes
) else (
    echo [INFO] AvailableRuntimes not found or already removed
)

:: Remove ApiLayers
reg delete "HKLM\SOFTWARE\Khronos\OpenXR\1\ApiLayers" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Removed ApiLayers
) else (
    echo [INFO] ApiLayers not found or already removed
)

echo.
echo ========================================
echo Uninstallation complete
echo ========================================
echo.
echo The OpenXR registry configuration has been removed.
echo You may need to restart your computer.
echo.

pause
