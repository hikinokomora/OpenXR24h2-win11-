# Changelog / История изменений

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-11-14

### Added / Добавлено

#### Core Features
- Initial release of OpenXR support solution for Windows 11 24H2
- Automatic SteamVR detection and configuration
- Registry-based OpenXR runtime registration
- Support for multiple VR runtimes (SteamVR, Oculus, Windows Mixed Reality)

#### Installation Scripts
- `install.bat` - Simple batch installer for beginners
- `install_openxr.ps1` - Standard PowerShell installer with automatic SteamVR detection
- `install_advanced.ps1` - Advanced PowerShell installer with multi-runtime support
- `openxr_runtime.reg` - Registry configuration template for manual installation

#### Verification Tools
- `verify_openxr.bat` - Quick command-line verification script
- `verify_openxr.ps1` - Comprehensive PowerShell verification with detailed checks

#### Uninstallation
- `uninstall.bat` - Safe removal of OpenXR registry configuration

#### Documentation
- `README.md` - Main project overview with bilingual support (EN/RU)
- `INSTALLATION.md` - Detailed installation guide covering all methods
- `QUICKSTART.md` - Fast-track guide for experienced users
- `FAQ.md` - Comprehensive frequently asked questions (EN/RU)
- `TROUBLESHOOTING.md` - Detailed problem-solving guide (EN/RU)
- `CONTRIBUTING.md` - Guidelines for contributors
- `FILE_GUIDE.md` - Explanation of all repository files
- `LICENSE` - MIT License

#### Features
- Bilingual documentation (English/Russian)
- Multiple installation methods for different user levels
- Automatic VR runtime detection
- Runtime selection for users with multiple VR systems
- Comprehensive error handling and user feedback
- Safe uninstallation process

### Technical Details

- Registry keys configured:
  - `HKLM\SOFTWARE\Khronos\OpenXR\1\ActiveRuntime`
  - `HKLM\SOFTWARE\Khronos\OpenXR\1\ApiLayers`
  - `HKLM\SOFTWARE\Khronos\OpenXR\1\AvailableRuntimes`

- Supported VR Runtimes:
  - SteamVR (primary)
  - Oculus Runtime
  - Windows Mixed Reality (if available)
  - Custom runtimes via manual path specification

### Tested On

- Windows 11 24H2 (Build 26100+)
- SteamVR (latest version)
- Various OpenXR applications

## [Unreleased]

### Planned Features
- GUI installer option
- Automatic update checker
- Additional language translations (Chinese, Japanese, German, French, Spanish)
- Integration with Windows Package Manager (winget)
- Chocolatey package
- Video tutorials
- Community Discord/forum

### Under Consideration
- Automatic SteamVR download and installation
- Backup/restore functionality for registry settings
- Profile management for multiple runtime configurations
- Diagnostic log collection tool
- Integration with VR headset setup wizards

---

## Version History Summary

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2024-11-14 | Initial release with complete OpenXR support solution |

---

## How to Update / Как обновить

### Check for Updates / Проверка обновлений

Visit the [releases page](https://github.com/hikinokomora/OpenXR24h2-win11-/releases) for the latest version.

### Update Process / Процесс обновления

1. Download the latest release
2. Run `uninstall.bat` (if updating from previous version)
3. Extract new version
4. Run `install.bat` or your preferred installer
5. Restart your computer

### Breaking Changes / Критические изменения

This section will list any breaking changes in future versions.

Currently: None (first release)

---

## Support / Поддержка

- **Bug reports:** [GitHub Issues](https://github.com/hikinokomora/OpenXR24h2-win11-/issues)
- **Feature requests:** [GitHub Issues](https://github.com/hikinokomora/OpenXR24h2-win11-/issues)
- **Questions:** See [FAQ.md](FAQ.md)

## Contributing / Участие

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

**Legend / Легенда:**
- Added / Добавлено - New features
- Changed / Изменено - Changes in existing functionality
- Deprecated / Устарело - Soon-to-be removed features
- Removed / Удалено - Removed features
- Fixed / Исправлено - Bug fixes
- Security / Безопасность - Security fixes
