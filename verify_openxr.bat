@echo off
:: OpenXR Verification Script
:: Checks if OpenXR runtime is properly configured

title OpenXR Verification

echo.
echo ========================================
echo OpenXR Configuration Verification
echo ========================================
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo WARNING: Not running as administrator
    echo Some checks may not work properly
    echo.
)

:: Check registry keys
echo Checking registry configuration...
echo.

:: Check ActiveRuntime
reg query "HKLM\SOFTWARE\Khronos\OpenXR\1" /v ActiveRuntime >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] ActiveRuntime registry key exists
    reg query "HKLM\SOFTWARE\Khronos\OpenXR\1" /v ActiveRuntime
    echo.
) else (
    echo [FAIL] ActiveRuntime registry key not found
    echo Please run the installation script
    echo.
)

:: Check ApiLayers
reg query "HKLM\SOFTWARE\Khronos\OpenXR\1\ApiLayers" >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] ApiLayers registry key exists
) else (
    echo [FAIL] ApiLayers registry key not found
)
echo.

:: Check AvailableRuntimes
reg query "HKLM\SOFTWARE\Khronos\OpenXR\1\AvailableRuntimes" >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] AvailableRuntimes registry key exists
    reg query "HKLM\SOFTWARE\Khronos\OpenXR\1\AvailableRuntimes"
    echo.
) else (
    echo [FAIL] AvailableRuntimes registry key not found
)
echo.

:: Check for SteamVR
echo Checking for SteamVR installation...
echo.

set STEAMVR_PATH=C:\Program Files (x86)\Steam\steamapps\common\SteamVR\steamxr_win64.json
if exist "%STEAMVR_PATH%" (
    echo [OK] SteamVR OpenXR runtime found at:
    echo     %STEAMVR_PATH%
) else (
    echo [WARNING] SteamVR not found at default location
    echo           This may be normal if SteamVR is installed elsewhere
)
echo.

echo ========================================
echo Verification complete
echo ========================================
echo.
echo If any checks failed, please run install.bat as administrator
echo.

pause
