# Installation Guide / Руководство по установке

## Table of Contents / Содержание

1. [Prerequisites](#prerequisites--предварительные-требования)
2. [Installation Methods](#installation-methods--методы-установки)
3. [Post-Installation](#post-installation--после-установки)
4. [Advanced Configuration](#advanced-configuration--расширенная-настройка)
5. [Uninstallation](#uninstallation--удаление)

## Prerequisites / Предварительные требования

### System Requirements / Системные требования

- **OS:** Windows 11 Build 26100 (24H2) or newer
- **Privileges:** Administrator access required
- **VR Runtime:** SteamVR, Oculus, or other OpenXR-compatible runtime

### Check Your Windows Version / Проверка версии Windows

Press `Win + R`, type `winver`, and press Enter. You should see:
- Version: 24H2 or newer
- Build: 26100 or higher

Нажмите `Win + R`, введите `winver` и нажмите Enter. Вы должны увидеть:
- Версия: 24H2 или новее
- Сборка: 26100 или выше

### Install VR Runtime First / Сначала установите VR среду

**For SteamVR users:**
1. Install Steam from https://store.steampowered.com/
2. Open Steam → Library → Tools
3. Find and install SteamVR
4. Run SteamVR once to complete setup

**For Oculus users:**
1. Download Oculus app from Meta
2. Install and set up your headset
3. Oculus runtime will be installed automatically

## Installation Methods / Методы установки

### Method 1: Simple Batch Installer (Recommended for Beginners)

**Steps:**

1. Download or clone this repository
2. Extract to a folder (e.g., `C:\OpenXR-Fix`)
3. Navigate to the extracted folder
4. **Right-click** `install.bat`
5. Select **"Run as administrator"**
6. Wait for completion
7. Restart your computer

**Advantages:**
- Simple one-click installation
- No technical knowledge required
- Automatic SteamVR detection

**Disadvantages:**
- Only supports SteamVR by default
- Less control over the process

### Method 2: PowerShell Standard Installer

**Steps:**

1. Open PowerShell as Administrator:
   - Press `Win + X`
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

2. Navigate to the installation folder:
   ```powershell
   cd C:\Path\To\OpenXR-Fix
   ```

3. Run the installer:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   .\install_openxr.ps1
   ```

4. Follow on-screen instructions
5. Restart your computer

**Advantages:**
- More informative output
- Better error messages
- Automatic SteamVR detection

### Method 3: Advanced PowerShell Installer (Recommended for Power Users)

**Steps:**

1. Open PowerShell as Administrator

2. Navigate to installation folder:
   ```powershell
   cd C:\Path\To\OpenXR-Fix
   ```

3. Run the advanced installer:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   .\install_advanced.ps1
   ```

4. The script will:
   - Detect all available VR runtimes
   - Let you choose which one to use
   - Configure the registry accordingly

5. Restart your computer

**Advanced Options:**

**Silent installation (auto-select SteamVR):**
```powershell
.\install_advanced.ps1 -Silent
```

**Specify custom runtime path:**
```powershell
.\install_advanced.ps1 -RuntimePath "C:\Custom\Path\openxr_runtime.json"
```

**Force installation on older Windows:**
```powershell
.\install_advanced.ps1 -Force
```

**Advantages:**
- Supports multiple VR runtimes
- Runtime selection
- Custom path support
- Best for advanced users

### Method 4: Manual Registry Import

**For experts only / Только для экспертов:**

1. Edit `openxr_runtime.reg` in a text editor
2. Update the path to your OpenXR runtime JSON file
3. Save the file
4. Right-click the .reg file
5. Select "Merge" or "Import"
6. Confirm the UAC prompt
7. Restart your computer

**Note:** This method requires manual path editing and doesn't create all necessary registry structures.

## Post-Installation / После установки

### Verify Installation / Проверка установки

Run the verification script to ensure everything is configured correctly:

**Option 1: Batch file**
```cmd
verify_openxr.bat
```

**Option 2: PowerShell (more detailed)**
```powershell
.\verify_openxr.ps1
```

**Expected output:**
- ✅ ActiveRuntime registry key exists
- ✅ ApiLayers registry key exists
- ✅ AvailableRuntimes registry key exists
- ✅ SteamVR OpenXR runtime found

### Test with VR Application / Тест с VR приложением

1. Connect your VR headset
2. Start SteamVR
3. Run a VR game or application
4. Check that it launches correctly

**Test applications:**
- SteamVR Home (free, comes with SteamVR)
- The Lab (free on Steam)
- Any VR game you own

### Troubleshooting Failed Installation / Устранение неполадок неудачной установки

If verification fails, check:

1. **Administrator privileges:** Did you run as administrator?
   ```cmd
   # Check current privileges
   net session
   ```

2. **SteamVR installed:** Is SteamVR actually installed?
   ```powershell
   # Find SteamVR
   Get-ChildItem "C:\Program Files (x86)\Steam" -Recurse -Filter "steamxr_win64.json" -ErrorAction SilentlyContinue
   ```

3. **Antivirus blocking:** Temporarily disable antivirus and try again

4. **Registry permissions:** Check if you have registry write access

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for more solutions.

## Advanced Configuration / Расширенная настройка

### Switch Between VR Runtimes / Переключение между VR средами

If you have multiple VR runtimes installed (e.g., both SteamVR and Oculus):

```powershell
# Switch to different runtime
.\install_advanced.ps1

# Or specify directly
.\install_advanced.ps1 -RuntimePath "C:\Program Files\Oculus\Support\oculus-runtime\oculus_openxr_64.json"
```

### Custom Runtime Configuration / Настройка пользовательской среды

1. Find your runtime's JSON manifest file
2. Run advanced installer with custom path:
   ```powershell
   .\install_advanced.ps1 -RuntimePath "C:\Your\Custom\Runtime\runtime.json"
   ```

### Multiple User Profiles / Несколько профилей пользователей

OpenXR configuration is system-wide (HKEY_LOCAL_MACHINE), so all users on the computer will use the same runtime.

To have per-user configurations, you would need to switch runtimes when changing users.

### Backup Current Configuration / Резервное копирование текущей конфигурации

Before making changes, backup your registry:

```cmd
reg export "HKLM\SOFTWARE\Khronos\OpenXR" openxr_backup.reg
```

To restore:
```cmd
reg import openxr_backup.reg
```

## Uninstallation / Удаление

### Complete Uninstallation / Полное удаление

To remove all OpenXR configuration:

1. **Right-click** `uninstall.bat`
2. Select **"Run as administrator"**
3. Confirm when prompted
4. Restart your computer (optional)

### Manual Uninstallation / Ручное удаление

If the uninstall script doesn't work:

1. Open Registry Editor:
   - Press `Win + R`
   - Type `regedit`
   - Press Enter

2. Navigate to:
   ```
   HKEY_LOCAL_MACHINE\SOFTWARE\Khronos\OpenXR\1
   ```

3. Delete the following:
   - `ActiveRuntime` value
   - `AvailableRuntimes` key
   - `ApiLayers` key (optional)

4. Close Registry Editor
5. Restart your computer

### Restore Windows Mixed Reality (if available) / Восстановление Windows Mixed Reality

If you want to go back to Windows Mixed Reality runtime (if you have it):

1. Uninstall current configuration
2. Reinstall Windows Mixed Reality Portal from Microsoft Store
3. Follow Microsoft's setup instructions

**Note:** Windows Mixed Reality is not available on Windows 11 24H2 by default.

## Verification Checklist / Контрольный список проверки

After installation, verify:

- [ ] Verification script passes all checks
- [ ] SteamVR starts without errors
- [ ] VR headset is detected
- [ ] Sample VR application runs
- [ ] No error messages in Event Viewer
- [ ] Performance is acceptable

## Getting Help / Получение помощи

If you encounter issues:

1. Run `verify_openxr.ps1` and save output
2. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
3. Check [FAQ.md](FAQ.md)
4. Search existing GitHub issues
5. Create a new issue with verification output

## Next Steps / Следующие шаги

- Explore VR content on Steam
- Join VR communities
- Configure SteamVR settings for your hardware
- Enjoy your VR experience!

---

**Still need help?** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) or [FAQ.md](FAQ.md)
