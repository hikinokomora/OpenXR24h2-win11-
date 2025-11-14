# OpenXR Verification Script
# Performs detailed verification of OpenXR configuration

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "OpenXR Configuration Verification" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$allChecksPass = $true

# Function to display check result
function Show-CheckResult {
    param(
        [string]$CheckName,
        [bool]$Passed,
        [string]$Details = ""
    )
    
    if ($Passed) {
        Write-Host "[OK]   " -ForegroundColor Green -NoNewline
        Write-Host $CheckName
        if ($Details) {
            Write-Host "       $Details" -ForegroundColor Gray
        }
    } else {
        Write-Host "[FAIL] " -ForegroundColor Red -NoNewline
        Write-Host $CheckName
        if ($Details) {
            Write-Host "       $Details" -ForegroundColor Yellow
        }
        $script:allChecksPass = $false
    }
}

# Check Windows version
Write-Host "Checking Windows version..." -ForegroundColor Yellow
$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
$buildNumber = [int]$osInfo.BuildNumber

Show-CheckResult "Windows Version" ($buildNumber -ge 22631) "Build: $buildNumber (24H2 is build 26100+)"
Write-Host ""

# Check registry keys
Write-Host "Checking registry configuration..." -ForegroundColor Yellow

# Check ActiveRuntime
try {
    $activeRuntime = Get-ItemProperty -Path "HKLM:\SOFTWARE\Khronos\OpenXR\1" -Name "ActiveRuntime" -ErrorAction Stop
    $runtimePath = $activeRuntime.ActiveRuntime
    
    if (Test-Path $runtimePath) {
        Show-CheckResult "ActiveRuntime" $true "Path: $runtimePath"
    } else {
        Show-CheckResult "ActiveRuntime" $false "Path exists in registry but file not found: $runtimePath"
    }
} catch {
    Show-CheckResult "ActiveRuntime" $false "Registry key not found"
}

# Check ApiLayers
try {
    $apiLayers = Test-Path "HKLM:\SOFTWARE\Khronos\OpenXR\1\ApiLayers"
    Show-CheckResult "ApiLayers key" $apiLayers
} catch {
    Show-CheckResult "ApiLayers key" $false
}

# Check AvailableRuntimes
try {
    $runtimes = Get-ItemProperty -Path "HKLM:\SOFTWARE\Khronos\OpenXR\1\AvailableRuntimes" -ErrorAction Stop
    $runtimeCount = ($runtimes.PSObject.Properties | Where-Object { $_.Name -notlike "PS*" }).Count
    Show-CheckResult "AvailableRuntimes" ($runtimeCount -gt 0) "Found $runtimeCount runtime(s)"
    
    foreach ($prop in $runtimes.PSObject.Properties) {
        if ($prop.Name -notlike "PS*") {
            Write-Host "       Runtime: $($prop.Name)" -ForegroundColor Gray
        }
    }
} catch {
    Show-CheckResult "AvailableRuntimes" $false "Registry key not found"
}

Write-Host ""

# Check for SteamVR
Write-Host "Checking for VR runtime installations..." -ForegroundColor Yellow

$steamVRPaths = @(
    "C:\Program Files (x86)\Steam\steamapps\common\SteamVR\steamxr_win64.json"
)

# Try to find Steam installation
try {
    $steamPath = Get-ItemProperty -Path "HKCU:\Software\Valve\Steam" -Name "SteamPath" -ErrorAction SilentlyContinue
    if ($steamPath) {
        $steamVRPaths += Join-Path $steamPath.SteamPath "steamapps\common\SteamVR\steamxr_win64.json"
    }
} catch {
    # Ignore errors
}

$steamVRFound = $false
foreach ($path in $steamVRPaths) {
    if (Test-Path $path) {
        Show-CheckResult "SteamVR" $true "Path: $path"
        $steamVRFound = $true
        break
    }
}

if (-not $steamVRFound) {
    Show-CheckResult "SteamVR" $false "Not found at default locations"
    Write-Host "       Install SteamVR from Steam to use OpenXR" -ForegroundColor Yellow
}

Write-Host ""

# Check for common VR applications
Write-Host "Checking for VR software..." -ForegroundColor Yellow

# Check for Oculus software
$oculusPath = "C:\Program Files\Oculus\Support\oculus-runtime"
if (Test-Path $oculusPath) {
    Write-Host "[INFO] Oculus Runtime detected" -ForegroundColor Cyan
}

# Check for Windows Mixed Reality
$wmrPath = "$env:SystemRoot\System32\MixedRealityRuntime.dll"
if (Test-Path $wmrPath) {
    Write-Host "[INFO] Windows Mixed Reality Runtime detected" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

if ($allChecksPass) {
    Write-Host "All checks passed!" -ForegroundColor Green
    Write-Host "OpenXR should be working correctly." -ForegroundColor Green
} else {
    Write-Host "Some checks failed!" -ForegroundColor Red
    Write-Host "Please run install.bat as administrator to fix the configuration." -ForegroundColor Yellow
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to exit"
