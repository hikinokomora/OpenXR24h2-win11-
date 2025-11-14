# Troubleshooting Guide / Руководство по устранению неполадок

## Common Issues / Распространенные проблемы

### 1. OpenXR applications don't detect the runtime / Приложения OpenXR не обнаруживают среду выполнения

**Symptoms / Симптомы:**
- Applications show "No OpenXR runtime found" error
- VR applications fail to start
- Steam shows "VR runtime not detected"

**Solutions / Решения:**

1. **Verify administrator privileges / Проверьте права администратора**
   ```cmd
   # Run verification as administrator
   verify_openxr.bat
   ```

2. **Check SteamVR installation / Проверьте установку SteamVR**
   - Open Steam
   - Go to Library → Tools
   - Find and install SteamVR if not already installed
   - Run SteamVR at least once to complete setup

3. **Restart your computer / Перезагрузите компьютер**
   - Many changes require a system restart to take effect
   - After restart, run `verify_openxr.bat` again

4. **Reinstall the configuration / Переустановите конфигурацию**
   ```cmd
   # Run as administrator
   uninstall.bat
   install.bat
   ```

### 2. SteamVR not found during installation / SteamVR не найден во время установки

**Symptoms / Симптомы:**
- Installation script reports "SteamVR installation not found!"
- Registry configuration is not created

**Solutions / Решения:**

1. **Install SteamVR first / Сначала установите SteamVR**
   - Install Steam from https://store.steampowered.com/
   - Open Steam and go to Library → Tools
   - Install SteamVR
   - Run the installation script again

2. **SteamVR installed in custom location / SteamVR установлен в нестандартном месте**
   - Edit `openxr_runtime.reg` manually
   - Update the path to point to your SteamVR installation
   - Import the registry file: `reg import openxr_runtime.reg`

### 3. Applications crash on startup / Приложения аварийно завершаются при запуске

**Symptoms / Симптомы:**
- VR application starts but immediately crashes
- Error messages about missing DLLs
- Blue screen or system freeze

**Solutions / Решения:**

1. **Update graphics drivers / Обновите драйверы видеокарты**
   - NVIDIA: https://www.nvidia.com/Download/index.aspx
   - AMD: https://www.amd.com/en/support
   - Intel: https://www.intel.com/content/www/us/en/download-center/home.html

2. **Update DirectX / Обновите DirectX**
   - Download from: https://www.microsoft.com/en-us/download/details.aspx?id=35
   - Install and restart

3. **Update VR headset drivers / Обновите драйверы VR-гарнитуры**
   - Check manufacturer's website for latest drivers
   - For Meta Quest: Update via Oculus app
   - For HTC Vive: Update via Vive software
   - For Valve Index: Update via SteamVR

4. **Verify game files / Проверьте файлы игры**
   - In Steam, right-click the game
   - Properties → Local Files → Verify integrity of game files

### 4. Performance issues / Проблемы с производительностью

**Symptoms / Симптомы:**
- Low frame rate
- Stuttering or lag
- Motion sickness due to poor performance

**Solutions / Решения:**

1. **Lower graphics settings / Снизьте настройки графики**
   - In SteamVR Settings → Video
   - Reduce resolution per eye
   - Disable supersampling or reduce it

2. **Close background applications / Закройте фоновые приложения**
   - Close unnecessary programs
   - Disable overlays (Discord, etc.)
   - Check Task Manager for high CPU/GPU usage

3. **Enable Performance Mode / Включите режим производительности**
   - Windows Settings → System → Power & battery
   - Set Power mode to "Best performance"

### 5. Registry permissions error / Ошибка прав доступа к реестру

**Symptoms / Симптомы:**
- "Access denied" error during installation
- Registry keys are not created

**Solutions / Решения:**

1. **Run as administrator / Запустите от имени администратора**
   - Right-click `install.bat`
   - Select "Run as administrator"
   - Confirm UAC prompt

2. **Check antivirus / Проверьте антивирус**
   - Temporarily disable antivirus
   - Run installation again
   - Re-enable antivirus after installation

3. **Manual registry editing / Ручное редактирование реестра**
   - Press Win+R, type `regedit`, press Enter
   - Navigate to: `HKEY_LOCAL_MACHINE\SOFTWARE\Khronos\OpenXR\1`
   - Create keys manually if needed

### 6. Multiple VR runtimes conflict / Конфликт нескольких сред выполнения VR

**Symptoms / Симптомы:**
- Applications launch with wrong runtime
- Inconsistent behavior between applications

**Solutions / Решения:**

1. **Set default runtime / Установите среду выполнения по умолчанию**
   - Run `install.bat` to set SteamVR as default
   - Or manually edit registry to change ActiveRuntime value

2. **Disable conflicting runtimes / Отключите конфликтующие среды выполнения**
   - Close Oculus app if using SteamVR
   - Close SteamVR if using Oculus
   - Only one runtime should be active at a time

### 7. Windows 11 24H2 specific issues / Проблемы, специфичные для Windows 11 24H2

**Symptoms / Симптомы:**
- Everything worked on older Windows version
- Broke after Windows 11 24H2 update

**Solutions / Решения:**

1. **Verify Windows version / Проверьте версию Windows**
   ```cmd
   winver
   ```
   - Build 26100 or higher = Windows 11 24H2

2. **Re-run installation / Повторите установку**
   - The update may have reset registry settings
   - Run `install.bat` again as administrator

3. **Check Windows Update / Проверьте Центр обновления Windows**
   - Settings → Windows Update
   - Install all pending updates
   - Some updates may restore needed components

## Getting Help / Получение помощи

If you continue to experience issues:

1. Run `verify_openxr.ps1` and save the output
2. Check the project issues on GitHub
3. Create a new issue with:
   - Your Windows version (run `winver`)
   - Output from verification script
   - Description of the problem
   - Steps you've already tried

Если проблемы продолжаются:

1. Запустите `verify_openxr.ps1` и сохраните вывод
2. Проверьте проблемы проекта на GitHub
3. Создайте новую проблему с:
   - Вашей версией Windows (запустите `winver`)
   - Выводом из скрипта проверки
   - Описанием проблемы
   - Шагами, которые вы уже попробовали

## Useful Commands / Полезные команды

### Check Windows version / Проверить версию Windows
```cmd
winver
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
```

### Check OpenXR registry / Проверить реестр OpenXR
```cmd
reg query "HKLM\SOFTWARE\Khronos\OpenXR\1" /s
```

### Find SteamVR installation / Найти установку SteamVR
```powershell
Get-ChildItem "C:\Program Files (x86)\Steam" -Recurse -Filter "steamxr_win64.json" -ErrorAction SilentlyContinue
```

### Export current registry settings / Экспортировать текущие настройки реестра
```cmd
reg export "HKLM\SOFTWARE\Khronos\OpenXR" openxr_backup.reg
```

### Restore registry settings / Восстановить настройки реестра
```cmd
reg import openxr_backup.reg
```

## Additional Resources / Дополнительные ресурсы

- [SteamVR Support](https://help.steampowered.com/en/wizard/HelpWithGameIssue/?appid=250820)
- [OpenXR Specification](https://www.khronos.org/openxr/)
- [Microsoft VR Documentation](https://docs.microsoft.com/en-us/windows/mixed-reality/)
