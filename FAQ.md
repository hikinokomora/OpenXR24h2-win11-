# Frequently Asked Questions (FAQ) / Часто Задаваемые Вопросы

## General Questions / Общие вопросы

### What is this project? / Что это за проект?

This project provides a solution to restore OpenXR functionality on Windows 11 24H2 and newer, where Microsoft removed the built-in Mixed Reality components.

Этот проект предоставляет решение для восстановления функциональности OpenXR в Windows 11 24H2 и новее, где Microsoft удалил встроенные компоненты Mixed Reality.

### Why do I need this? / Зачем мне это нужно?

If you upgraded to Windows 11 24H2 and your VR applications stopped working, this solution will help restore OpenXR functionality by properly configuring the runtime registry settings.

Если вы обновились до Windows 11 24H2 и ваши VR-приложения перестали работать, это решение поможет восстановить функциональность OpenXR путем правильной настройки параметров реестра среды выполнения.

### Is this official Microsoft software? / Это официальное программное обеспечение Microsoft?

No, this is a community-driven solution. It configures your system to use third-party OpenXR runtimes like SteamVR.

Нет, это решение, созданное сообществом. Оно настраивает вашу систему для использования сторонних сред выполнения OpenXR, таких как SteamVR.

### Is it safe? / Это безопасно?

Yes, the scripts only modify OpenXR-related registry keys and don't install any executables or modify system files. However, always review scripts before running them as administrator.

Да, скрипты изменяют только ключи реестра, связанные с OpenXR, и не устанавливают никаких исполняемых файлов и не изменяют системные файлы. Однако всегда проверяйте скрипты перед их запуском от имени администратора.

## Installation Questions / Вопросы установки

### Do I need SteamVR installed first? / Нужно ли сначала установить SteamVR?

Yes, the installation script looks for SteamVR. If you use a different VR runtime (like Oculus), use the advanced installer with the `-RuntimePath` parameter.

Да, скрипт установки ищет SteamVR. Если вы используете другую VR-среду (например, Oculus), используйте расширенный установщик с параметром `-RuntimePath`.

### Can I use this with Oculus/Meta Quest? / Могу ли я использовать это с Oculus/Meta Quest?

Yes! Use the advanced installer:
```powershell
.\install_advanced.ps1
```
It will detect Oculus runtime if installed.

Да! Используйте расширенный установщик:
```powershell
.\install_advanced.ps1
```
Он обнаружит среду выполнения Oculus, если она установлена.

### Why does it need administrator privileges? / Почему требуются права администратора?

The script modifies system-wide registry keys in HKEY_LOCAL_MACHINE, which requires administrator access.

Скрипт изменяет системные ключи реестра в HKEY_LOCAL_MACHINE, что требует доступа администратора.

### Can I install without administrator rights? / Могу ли я установить без прав администратора?

No, OpenXR runtime configuration requires system-level registry modifications.

Нет, конфигурация среды выполнения OpenXR требует изменений системного реестра.

### The script says "SteamVR not found" but I have it installed / Скрипт говорит "SteamVR не найден", но у меня он установлен

SteamVR might be in a non-standard location. Use:
```powershell
.\install_advanced.ps1 -RuntimePath "C:\Path\To\Your\steamxr_win64.json"
```

SteamVR может находиться в нестандартном месте. Используйте:
```powershell
.\install_advanced.ps1 -RuntimePath "C:\Путь\К\Вашему\steamxr_win64.json"
```

## Compatibility Questions / Вопросы совместимости

### What Windows versions are supported? / Какие версии Windows поддерживаются?

- Windows 11 24H2 (build 26100+) - Primary target
- Windows 11 23H2 and older - May work but not necessary
- Windows 10 - Not needed, has built-in Mixed Reality

### What VR headsets are compatible? / Какие VR-гарнитуры совместимы?

Any headset that works with SteamVR or has OpenXR support:
- Valve Index
- HTC Vive/Vive Pro/Vive Cosmos
- Meta Quest (via Link or Air Link)
- HP Reverb G2
- Oculus Rift/Rift S
- Windows Mixed Reality headsets
- And many others

### Does this work with VRChat, Beat Saber, Half-Life: Alyx? / Работает ли это с VRChat, Beat Saber, Half-Life: Alyx?

Yes, any game or application that supports OpenXR should work after installation.

Да, любая игра или приложение, поддерживающее OpenXR, должны работать после установки.

### Can I use multiple VR headsets? / Могу ли я использовать несколько VR-гарнитур?

Yes, but only one runtime can be active at a time. Use the advanced installer to switch between runtimes.

Да, но только одна среда выполнения может быть активна одновременно. Используйте расширенный установщик для переключения между средами выполнения.

## Technical Questions / Технические вопросы

### What registry keys does this modify? / Какие ключи реестра изменяются?

The scripts modify:
- `HKLM\SOFTWARE\Khronos\OpenXR\1\ActiveRuntime`
- `HKLM\SOFTWARE\Khronos\OpenXR\1\ApiLayers`
- `HKLM\SOFTWARE\Khronos\OpenXR\1\AvailableRuntimes`

### Can I undo the changes? / Могу ли я отменить изменения?

Yes, run `uninstall.bat` as administrator to remove the registry keys.

Да, запустите `uninstall.bat` от имени администратора, чтобы удалить ключи реестра.

### Will Windows Updates undo this? / Отменят ли обновления Windows эти изменения?

Windows Updates typically don't modify third-party registry keys, but it's possible. If VR stops working after an update, run the installer again.

Обновления Windows обычно не изменяют сторонние ключи реестра, но это возможно. Если VR перестанет работать после обновления, запустите установщик снова.

### Does this work with WSL or VirtualBox? / Работает ли это с WSL или VirtualBox?

No, VR requires direct hardware access. You need to run this on a physical Windows 11 installation.

Нет, VR требует прямого доступа к оборудованию. Вам нужно запустить это на физической установке Windows 11.

### Can I use this on a laptop? / Могу ли я использовать это на ноутбуке?

Yes, but ensure your laptop meets VR requirements (powerful GPU, proper ports for headset).

Да, но убедитесь, что ваш ноутбук соответствует требованиям VR (мощный GPU, правильные порты для гарнитуры).

## Troubleshooting Questions / Вопросы устранения неполадок

### The verification script shows failures / Скрипт проверки показывает ошибки

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions to common issues.

См. [TROUBLESHOOTING.md](TROUBLESHOOTING.md) для подробных решений распространенных проблем.

### VR works but has poor performance / VR работает, но с низкой производительностью

This is usually not related to OpenXR configuration. Check:
- Graphics drivers are updated
- Power settings are on "High Performance"
- Background applications are closed
- SteamVR supersampling settings

### Some games work, others don't / Некоторые игры работают, другие нет

Some games might use different VR APIs (OpenVR instead of OpenXR). Ensure SteamVR is running for all VR games.

Некоторые игры могут использовать разные VR API (OpenVR вместо OpenXR). Убедитесь, что SteamVR запущен для всех VR-игр.

## Legal & Licensing Questions / Юридические вопросы и лицензирование

### Is this free? / Это бесплатно?

Yes, this project is free and open source under the MIT License.

Да, этот проект бесплатный и с открытым исходным кодом под лицензией MIT.

### Can I modify and redistribute this? / Могу ли я изменять и распространять это?

Yes, under the terms of the MIT License. See [LICENSE](LICENSE) for details.

Да, в соответствии с условиями лицензии MIT. См. [LICENSE](LICENSE) для подробностей.

### Can I use this commercially? / Могу ли я использовать это коммерчески?

Yes, the MIT License allows commercial use.

Да, лицензия MIT разрешает коммерческое использование.

## Getting Help / Получение помощи

### Where can I get more help? / Где я могу получить дополнительную помощь?

1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Check [QUICKSTART.md](QUICKSTART.md)
3. Search existing GitHub Issues
4. Create a new issue with your problem details
5. VR community forums and Discord servers

### How can I contribute? / Как я могу внести свой вклад?

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on contributing to the project.

См. [CONTRIBUTING.md](CONTRIBUTING.md) для руководства по внесению вклада в проект.

### Is there a Discord/community? / Есть ли Discord/сообщество?

Currently, GitHub Issues is the main communication channel. Community chat may be added in the future.

В настоящее время GitHub Issues является основным каналом связи. Чат сообщества может быть добавлен в будущем.
