# Advanced OpenXR Installation Script
# Handles multiple VR runtimes and edge cases

param(
    [switch]$Silent = $false,
    [string]$RuntimePath = "",
    [switch]$Force = $false
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
Write-Host "Advanced OpenXR Installation" -ForegroundColor Cyan
Write-Host "Windows 11 24H2 and newer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to find VR runtimes
function Find-VRRuntimes {
    $runtimes = @()
    
    # Check for SteamVR
    $steamVRPaths = @(
        "C:\Program Files (x86)\Steam\steamapps\common\SteamVR\steamxr_win64.json",
        "$env:ProgramFiles(x86)\Steam\steamapps\common\SteamVR\steamxr_win64.json"
    )
    
    # Try to find Steam installation from registry
    $steamPath = Get-ItemProperty -Path "HKCU:\Software\Valve\Steam" -Name "SteamPath" -ErrorAction SilentlyContinue
    if ($steamPath) {
        $steamVRJson = Join-Path $steamPath.SteamPath "steamapps\common\SteamVR\steamxr_win64.json"
        $steamVRPaths += $steamVRJson
    }
    
    foreach ($path in $steamVRPaths) {
        if (Test-Path $path) {
            $runtimes += @{
                Name = "SteamVR"
                Path = $path
                Type = "SteamVR"
            }
            break
        }
    }
    
    # Check for Oculus runtime
    $oculusPath = "C:\Program Files\Oculus\Support\oculus-runtime\oculus_openxr_64.json"
    if (Test-Path $oculusPath) {
        $runtimes += @{
            Name = "Oculus"
            Path = $oculusPath
            Type = "Oculus"
        }
    }
    
    # Check for Windows Mixed Reality (if still available)
    $wmrPath = "$env:SystemRoot\System32\MixedRealityRuntime.json"
    if (Test-Path $wmrPath) {
        $runtimes += @{
            Name = "Windows Mixed Reality"
            Path = $wmrPath
            Type = "WindowsMR"
        }
    }
    
    return $runtimes
}

# Function to configure OpenXR registry
function Set-OpenXRRuntime {
    param(
        [string]$RuntimePath
    )
    
    try {
        # Ensure the main OpenXR key exists
        $openXRPath = "HKLM:\SOFTWARE\Khronos\OpenXR\1"
        if (-not (Test-Path $openXRPath)) {
            New-Item -Path $openXRPath -Force | Out-Null
            Write-Host "Created registry path: $openXRPath" -ForegroundColor Green
        }
        
        # Set the active runtime
        Set-ItemProperty -Path $openXRPath -Name "ActiveRuntime" -Value $RuntimePath -Type String
        Write-Host "Set ActiveRuntime to: $RuntimePath" -ForegroundColor Green
        
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
        
        # Clear existing runtimes if Force is specified
        if ($Force) {
            Get-ItemProperty -Path $runtimesPath | Select-Object -Property * -ExcludeProperty PS* | ForEach-Object {
                $_.PSObject.Properties | ForEach-Object {
                    if ($_.Name -notlike "PS*") {
                        Remove-ItemProperty -Path $runtimesPath -Name $_.Name -ErrorAction SilentlyContinue
                    }
                }
            }
        }
        
        Set-ItemProperty -Path $runtimesPath -Name $RuntimePath -Value 0 -Type DWord
        Write-Host "Registered runtime as available" -ForegroundColor Green
        
        return $true
    } catch {
        Write-Error "Failed to configure registry: $_"
        return $false
    }
}

# Check Windows version
$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
$buildNumber = [int]$osInfo.BuildNumber

Write-Host "Windows Build: $buildNumber" -ForegroundColor Cyan
if ($buildNumber -lt 22000) {
    Write-Warning "This script is designed for Windows 11. You are running an older version."
    if (-not $Force) {
        Write-Host "Use -Force to continue anyway." -ForegroundColor Yellow
        exit 1
    }
}
Write-Host ""

# Find available VR runtimes
Write-Host "Scanning for VR runtimes..." -ForegroundColor Yellow
$availableRuntimes = Find-VRRuntimes

if ($availableRuntimes.Count -eq 0 -and -not $RuntimePath) {
    Write-Warning "No VR runtimes found!"
    Write-Host ""
    Write-Host "Please install one of the following:" -ForegroundColor Yellow
    Write-Host "  - SteamVR (recommended): https://store.steampowered.com/app/250820/SteamVR/" -ForegroundColor White
    Write-Host "  - Oculus Runtime: Install Oculus app from Meta" -ForegroundColor White
    Write-Host ""
    Write-Host "Or specify a runtime path manually with -RuntimePath parameter" -ForegroundColor Yellow
    Write-Host ""
    if (-not $Silent) {
        Read-Host "Press Enter to exit"
    }
    exit 1
}

Write-Host "Found $($availableRuntimes.Count) runtime(s):" -ForegroundColor Green
foreach ($runtime in $availableRuntimes) {
    Write-Host "  - $($runtime.Name): $($runtime.Path)" -ForegroundColor White
}
Write-Host ""

# Select runtime
$selectedRuntime = $null

if ($RuntimePath) {
    # Use manually specified path
    if (Test-Path $RuntimePath) {
        $selectedRuntime = $RuntimePath
        Write-Host "Using manually specified runtime: $RuntimePath" -ForegroundColor Cyan
    } else {
        Write-Error "Specified runtime path does not exist: $RuntimePath"
        exit 1
    }
} elseif ($availableRuntimes.Count -eq 1) {
    # Only one runtime found, use it
    $selectedRuntime = $availableRuntimes[0].Path
    Write-Host "Using $($availableRuntimes[0].Name) runtime" -ForegroundColor Cyan
} else {
    # Multiple runtimes found, let user choose
    if ($Silent) {
        # In silent mode, prefer SteamVR
        $steamVR = $availableRuntimes | Where-Object { $_.Type -eq "SteamVR" } | Select-Object -First 1
        if ($steamVR) {
            $selectedRuntime = $steamVR.Path
            Write-Host "Auto-selected SteamVR runtime (silent mode)" -ForegroundColor Cyan
        } else {
            $selectedRuntime = $availableRuntimes[0].Path
            Write-Host "Auto-selected $($availableRuntimes[0].Name) runtime (silent mode)" -ForegroundColor Cyan
        }
    } else {
        Write-Host "Multiple runtimes available. Please select one:" -ForegroundColor Yellow
        for ($i = 0; $i -lt $availableRuntimes.Count; $i++) {
            Write-Host "  [$($i+1)] $($availableRuntimes[$i].Name)" -ForegroundColor White
        }
        Write-Host ""
        
        $selection = 0
        while ($selection -lt 1 -or $selection -gt $availableRuntimes.Count) {
            $input = Read-Host "Enter selection (1-$($availableRuntimes.Count))"
            if ([int]::TryParse($input, [ref]$selection)) {
                if ($selection -ge 1 -and $selection -le $availableRuntimes.Count) {
                    $selectedRuntime = $availableRuntimes[$selection - 1].Path
                    break
                }
            }
            Write-Host "Invalid selection. Please try again." -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "Configuring OpenXR with selected runtime..." -ForegroundColor Yellow
Write-Host ""

# Configure the runtime
$success = Set-OpenXRRuntime -RuntimePath $selectedRuntime

if ($success) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Installation completed successfully!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "OpenXR runtime configured:" -ForegroundColor Cyan
    Write-Host "  $selectedRuntime" -ForegroundColor White
    Write-Host ""
    Write-Host "Please restart your computer for changes to take effect." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You can verify the installation by running:" -ForegroundColor Cyan
    Write-Host "  verify_openxr.ps1" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Installation failed!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please check the errors above and try again." -ForegroundColor Yellow
    Write-Host ""
}

if (-not $Silent) {
    Read-Host "Press Enter to exit"
}
