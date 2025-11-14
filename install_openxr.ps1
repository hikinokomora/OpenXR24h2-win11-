# OpenXR Installation Script for Windows 11 24H2+
# This script configures OpenXR runtime for Windows 11 24H2 and newer

param(
    [switch]$Silent = $false
)

# Require administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script requires administrator privileges. Please run as administrator."
    if (-not $Silent) {
        Read-Host "Press Enter to exit"
    }
    exit 1
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "OpenXR Installation for Windows 11 24H2" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if SteamVR is installed
function Test-SteamVRInstalled {
    $steamVRPaths = @(
        "C:\Program Files (x86)\Steam\steamapps\common\SteamVR\steamxr_win64.json",
        "$env:ProgramFiles(x86)\Steam\steamapps\common\SteamVR\steamxr_win64.json"
    )
    
    foreach ($path in $steamVRPaths) {
        if (Test-Path $path) {
            return $path
        }
    }
    
    # Try to find Steam installation
    $steamPath = Get-ItemProperty -Path "HKCU:\Software\Valve\Steam" -Name "SteamPath" -ErrorAction SilentlyContinue
    if ($steamPath) {
        $steamVRJson = Join-Path $steamPath.SteamPath "steamapps\common\SteamVR\steamxr_win64.json"
        if (Test-Path $steamVRJson) {
            return $steamVRJson
        }
    }
    
    return $null
}

# Check for SteamVR installation
Write-Host "Checking for SteamVR installation..." -ForegroundColor Yellow
$steamVRPath = Test-SteamVRInstalled

if (-not $steamVRPath) {
    Write-Warning "SteamVR installation not found!"
    Write-Host ""
    Write-Host "Please install SteamVR first:" -ForegroundColor Yellow
    Write-Host "1. Install Steam from https://store.steampowered.com/" -ForegroundColor White
    Write-Host "2. Install SteamVR from the Steam Store" -ForegroundColor White
    Write-Host ""
    if (-not $Silent) {
        Read-Host "Press Enter to exit"
    }
    exit 1
}

Write-Host "SteamVR found at: $steamVRPath" -ForegroundColor Green
Write-Host ""

# Create OpenXR registry keys
Write-Host "Configuring OpenXR registry keys..." -ForegroundColor Yellow

try {
    # Ensure the main OpenXR key exists
    $openXRPath = "HKLM:\SOFTWARE\Khronos\OpenXR\1"
    if (-not (Test-Path $openXRPath)) {
        New-Item -Path $openXRPath -Force | Out-Null
        Write-Host "Created registry path: $openXRPath" -ForegroundColor Green
    }
    
    # Set the active runtime
    $escapedPath = $steamVRPath -replace '\\', '\\'
    Set-ItemProperty -Path $openXRPath -Name "ActiveRuntime" -Value $steamVRPath -Type String
    Write-Host "Set ActiveRuntime to: $steamVRPath" -ForegroundColor Green
    
    # Create ApiLayers keys
    $apiLayersPath = "$openXRPath\ApiLayers"
    if (-not (Test-Path $apiLayersPath)) {
        New-Item -Path $apiLayersPath -Force | Out-Null
    }
    
    $implicitPath = "$apiLayersPath\Implicit"
    if (-not (Test-Path $implicitPath)) {
        New-Item -Path $implicitPath -Force | Out-Null
    }
    
    $explicitPath = "$apiLayersPath\Explicit"
    if (-not (Test-Path $explicitPath)) {
        New-Item -Path $explicitPath -Force | Out-Null
    }
    
    # Create AvailableRuntimes key
    $runtimesPath = "$openXRPath\AvailableRuntimes"
    if (-not (Test-Path $runtimesPath)) {
        New-Item -Path $runtimesPath -Force | Out-Null
    }
    
    Set-ItemProperty -Path $runtimesPath -Name $steamVRPath -Value 0 -Type DWord
    Write-Host "Registered SteamVR as available runtime" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Installation completed successfully!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Please restart your computer for changes to take effect." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You can verify the installation by running:" -ForegroundColor Cyan
    Write-Host "  verify_openxr.bat" -ForegroundColor White
    Write-Host ""
    
} catch {
    Write-Error "Failed to configure registry: $_"
    if (-not $Silent) {
        Read-Host "Press Enter to exit"
    }
    exit 1
}

if (-not $Silent) {
    Read-Host "Press Enter to exit"
}
