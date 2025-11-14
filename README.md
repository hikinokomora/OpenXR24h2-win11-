# OpenXR Support for Windows 11 24H2 and Newer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📚 Documentation

- **[Installation Guide](INSTALLATION.md)** - Detailed installation instructions
- **[Quick Start Guide](QUICKSTART.md)** - Get started quickly
- **[FAQ](FAQ.md)** - Frequently asked questions  
- **[Troubleshooting](TROUBLESHOOTING.md)** - Common issues and solutions
- **[Contributing](CONTRIBUTING.md)** - How to contribute

## Проблема / Problem

Starting with Windows 11 24H2, Microsoft removed the built-in Mixed Reality Portal and Windows Mixed Reality components, which breaks OpenXR applications. This affects VR headsets that rely on the Windows Mixed Reality OpenXR runtime.

Начиная с Windows 11 24H2, Microsoft удалил встроенный Mixed Reality Portal и компоненты Windows Mixed Reality, что приводит к неработоспособности приложений OpenXR. Это влияет на VR-гарнитуры, которые полагаются на среду выполнения Windows Mixed Reality OpenXR.

## Solution / Решение

This repository provides a solution to restore OpenXR functionality on Windows 11 24H2 and newer versions by:

1. Installing the necessary Windows Mixed Reality OpenXR runtime
2. Configuring registry settings to enable OpenXR
3. Providing verification tools to ensure proper installation

Этот репозиторий предоставляет решение для восстановления функциональности OpenXR в Windows 11 24H2 и более новых версиях путем:

1. Установки необходимой среды выполнения Windows Mixed Reality OpenXR
2. Настройки параметров реестра для включения OpenXR
3. Предоставления инструментов проверки для обеспечения правильной установки

## Requirements / Требования

- Windows 11 24H2 or newer / Windows 11 24H2 или новее
- Administrator privileges / Права администратора
- VR headset compatible with Windows Mixed Reality or SteamVR / VR-гарнитура, совместимая с Windows Mixed Reality или SteamVR

## Installation / Установка

### Method 1: Automated Installation (Recommended)

1. Download this repository
2. Right-click on `install.bat` and select "Run as administrator"
3. Follow the on-screen instructions
4. Restart your computer

### Method 2: Manual Installation

1. Run `install_openxr.ps1` PowerShell script as administrator:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   .\install_openxr.ps1
   ```

2. Import registry settings:
   ```cmd
   reg import openxr_runtime.reg
   ```

3. Restart your computer

### Метод 1: Автоматическая установка (рекомендуется)

1. Загрузите этот репозиторий
2. Нажмите правой кнопкой мыши на `install.bat` и выберите "Запуск от имени администратора"
3. Следуйте инструкциям на экране
4. Перезагрузите компьютер

### Метод 2: Ручная установка

1. Запустите PowerShell скрипт `install_openxr.ps1` от имени администратора:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   .\install_openxr.ps1
   ```

2. Импортируйте настройки реестра:
   ```cmd
   reg import openxr_runtime.reg
   ```

3. Перезагрузите компьютер

## Verification / Проверка

After installation, run the verification script:

```cmd
verify_openxr.bat
```

This will check:
- OpenXR runtime registration
- Required registry keys
- Runtime file existence

После установки запустите скрипт проверки:

```cmd
verify_openxr.bat
```

Это проверит:
- Регистрацию среды выполнения OpenXR
- Необходимые ключи реестра
- Наличие файлов среды выполнения

## Uninstallation / Удаление

To remove the OpenXR runtime configuration:

```cmd
uninstall.bat
```

Для удаления конфигурации среды выполнения OpenXR:

```cmd
uninstall.bat
```

## Troubleshooting / Устранение неполадок

### OpenXR applications don't detect the runtime

1. Ensure you ran the installation as administrator
2. Verify the installation using `verify_openxr.bat`
3. Restart your computer
4. Check if SteamVR or other VR runtime is properly installed

### Applications crash on startup

1. Make sure your VR headset drivers are up to date
2. Verify DirectX is installed and updated
3. Check Windows Update for the latest updates

### Приложения OpenXR не обнаруживают среду выполнения

1. Убедитесь, что установка была выполнена от имени администратора
2. Проверьте установку с помощью `verify_openxr.bat`
3. Перезагрузите компьютер
4. Проверьте, правильно ли установлен SteamVR или другая VR-среда

### Приложения аварийно завершаются при запуске

1. Убедитесь, что драйверы VR-гарнитуры обновлены
2. Проверьте, что DirectX установлен и обновлен
3. Проверьте Центр обновления Windows на наличие последних обновлений

## Technical Details / Технические детали

This solution:
- Registers the OpenXR runtime in the Windows registry
- Points to the SteamVR OpenXR runtime or Windows Mixed Reality runtime if available
- Creates necessary registry keys for OpenXR API layer discovery
- Maintains compatibility with existing OpenXR applications

Это решение:
- Регистрирует среду выполнения OpenXR в реестре Windows
- Указывает на среду выполнения SteamVR OpenXR или Windows Mixed Reality, если доступно
- Создает необходимые ключи реестра для обнаружения уровня API OpenXR
- Поддерживает совместимость с существующими приложениями OpenXR

## Compatibility / Совместимость

Tested with:
- Windows 11 24H2
- SteamVR
- Various OpenXR applications

Протестировано с:
- Windows 11 24H2
- SteamVR
- Различными приложениями OpenXR

## License / Лицензия

MIT License - See [LICENSE](LICENSE) for details

## Contributing / Вклад

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Вклады приветствуются! Пожалуйста, прочитайте [CONTRIBUTING.md](CONTRIBUTING.md) для руководства.

## Support / Поддержка

- **Questions?** Check the [FAQ](FAQ.md)
- **Problems?** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Issues?** [Report them on GitHub](https://github.com/hikinokomora/OpenXR24h2-win11-/issues)

## Disclaimer / Отказ от ответственности

This is an unofficial solution. Use at your own risk. Always backup your system before making registry changes.

Это неофициальное решение. Используйте на свой риск. Всегда делайте резервную копию системы перед внесением изменений в реестр.

Это неофициальное решение. Используйте на свой риск. Всегда делайте резервную копию системы перед внесением изменений в реестр.