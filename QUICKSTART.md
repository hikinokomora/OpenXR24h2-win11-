# Quick Start Guide / Краткое руководство

## For Windows Users / Для пользователей Windows

### Step 1: Check Requirements / Шаг 1: Проверьте требования

Before installing, make sure you have:

- Windows 11 24H2 or newer
- SteamVR or other VR runtime installed
- Administrator access to your computer

Перед установкой убедитесь, что у вас есть:

- Windows 11 24H2 или новее
- Установленный SteamVR или другая VR-среда
- Доступ администратора к компьютеру

### Step 2: Download / Шаг 2: Загрузите

1. Click the green "Code" button on the repository page
2. Select "Download ZIP"
3. Extract the ZIP file to a folder (e.g., Downloads)

### Step 3: Install / Шаг 3: Установите

**IMPORTANT: You MUST run as administrator!**
**ВАЖНО: Вы ДОЛЖНЫ запустить от имени администратора!**

1. Open the extracted folder
2. Find `install.bat`
3. **Right-click** on `install.bat`
4. Select **"Run as administrator"**
5. Follow the on-screen instructions
6. Restart your computer when complete

### Step 4: Verify / Шаг 4: Проверьте

After restarting:

1. Open the installation folder
2. Double-click `verify_openxr.bat`
3. Check that all tests pass

После перезагрузки:

1. Откройте папку установки
2. Дважды щелкните `verify_openxr.bat`
3. Проверьте, что все тесты пройдены

### Step 5: Test with VR / Шаг 5: Протестируйте с VR

1. Connect your VR headset
2. Start SteamVR
3. Try running a VR game or application
4. OpenXR applications should now work!

## Alternative Installation Methods / Альтернативные методы установки

### Method A: PowerShell Advanced Installer

For more control over the installation:

```powershell
# Open PowerShell as administrator
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
.\install_advanced.ps1
```

This will:
- Auto-detect all VR runtimes on your system
- Let you choose which runtime to use
- Provide more detailed feedback

### Method B: Manual Registry Import

If you just need to restore previous settings:

```cmd
# Run as administrator
reg import openxr_runtime.reg
```

Note: You may need to edit the .reg file to match your SteamVR installation path.

## Common First-Time Issues / Распространенные проблемы при первом использовании

### "Access Denied" error / Ошибка "Доступ запрещен"

**Solution:** You didn't run as administrator. Right-click and select "Run as administrator"

### "SteamVR not found" / "SteamVR не найден"

**Solution:** Install SteamVR first:
1. Open Steam
2. Go to Library → Tools
3. Find and install SteamVR
4. Run the installer again

### Scripts won't run / Скрипты не запускаются

**Solution:** Windows is blocking the files. 
1. Right-click the .bat or .ps1 file
2. Select Properties
3. Check "Unblock" at the bottom
4. Click Apply

## Next Steps / Следующие шаги

Once installed and verified:

1. **Test with simple VR apps first**
   - Try SteamVR Home
   - Test with free VR demos

2. **Configure your VR headset**
   - Follow manufacturer's setup guide
   - Calibrate room-scale if needed

3. **Enjoy your VR games!**
   - Browse VR games on Steam
   - Most OpenXR games should work

## Need Help? / Нужна помощь?

- See **TROUBLESHOOTING.md** for detailed solutions
- Check the Issues page on GitHub
- Run `verify_openxr.ps1` for diagnostic information

## Video Tutorial / Видео-инструкция

(To be added - community contributions welcome!)

## One-Line Summary / Краткая суммарная инструкция

**For experienced users / Для опытных пользователей:**

```cmd
Right-click install.bat → Run as administrator → Restart computer
```

That's it! / Вот и всё!
