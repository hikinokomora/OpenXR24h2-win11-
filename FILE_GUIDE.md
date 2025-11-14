# Repository File Guide / Руководство по файлам репозитория

This document explains what each file in this repository does.

Этот документ объясняет, что делает каждый файл в этом репозитории.

## 📄 Documentation Files / Файлы документации

### README.md
**Purpose:** Main project overview and quick reference  
**Цель:** Основной обзор проекта и краткая справка

The first file you should read. Contains:
- Problem description
- Quick installation instructions
- Links to other documentation

### INSTALLATION.md
**Purpose:** Detailed installation instructions  
**Цель:** Подробные инструкции по установке

Complete guide covering:
- All installation methods
- Prerequisites
- Step-by-step instructions
- Advanced configuration options

### QUICKSTART.md
**Purpose:** Fast-track guide for experienced users  
**Цель:** Быстрое руководство для опытных пользователей

Get up and running in minutes:
- Minimal steps
- Quick reference
- One-liner commands

### FAQ.md
**Purpose:** Frequently Asked Questions  
**Цель:** Часто задаваемые вопросы

Answers to common questions about:
- What this project is
- Compatibility
- Installation issues
- Technical details

### TROUBLESHOOTING.md
**Purpose:** Problem-solving guide  
**Цель:** Руководство по решению проблем

Detailed solutions for:
- Installation failures
- Runtime detection issues
- Performance problems
- Common errors

### CONTRIBUTING.md
**Purpose:** Guidelines for contributors  
**Цель:** Руководство для участников

Information for those who want to:
- Report issues
- Submit improvements
- Translate documentation
- Contribute code

### LICENSE
**Purpose:** Legal license (MIT)  
**Цель:** Юридическая лицензия (MIT)

Defines how you can use, modify, and distribute this software.

## 🔧 Installation Scripts / Скрипты установки

### install.bat
**Type:** Windows Batch file  
**Run as:** Administrator  
**Purpose:** Simple one-click installer

- Easiest installation method
- Automatically calls PowerShell script
- Good for beginners
- Requires SteamVR

**How to use:**
1. Right-click
2. "Run as administrator"
3. Follow prompts

### install_openxr.ps1
**Type:** PowerShell script  
**Run as:** Administrator  
**Purpose:** Standard PowerShell installer

- Detects SteamVR automatically
- Configures OpenXR registry keys
- Provides detailed feedback
- Good for most users

**How to use:**
```powershell
.\install_openxr.ps1
```

### install_advanced.ps1
**Type:** PowerShell script  
**Run as:** Administrator  
**Purpose:** Advanced installer with multi-runtime support

- Detects all VR runtimes
- Lets you choose runtime
- Supports custom paths
- Best for power users

**How to use:**
```powershell
.\install_advanced.ps1
```

**Advanced options:**
```powershell
.\install_advanced.ps1 -Silent              # Auto-select
.\install_advanced.ps1 -RuntimePath "..."   # Custom path
.\install_advanced.ps1 -Force               # Bypass checks
```

### openxr_runtime.reg
**Type:** Windows Registry file  
**Purpose:** Manual registry configuration template

- For manual installation
- Contains registry keys structure
- May need editing for custom paths
- For advanced users only

**How to use:**
1. Edit paths if needed
2. Right-click → Merge
3. Confirm UAC prompt

## ✅ Verification Scripts / Скрипты проверки

### verify_openxr.bat
**Type:** Windows Batch file  
**Run as:** Normal user (no admin needed)  
**Purpose:** Quick verification

- Simple command-line checks
- Verifies registry keys exist
- Checks for SteamVR
- Quick diagnostics

**How to use:**
```cmd
verify_openxr.bat
```

### verify_openxr.ps1
**Type:** PowerShell script  
**Run as:** Normal user (no admin needed)  
**Purpose:** Detailed verification

- Comprehensive checks
- Better formatted output
- More detailed information
- Checks for multiple runtimes

**How to use:**
```powershell
.\verify_openxr.ps1
```

## 🗑️ Uninstallation Scripts / Скрипты удаления

### uninstall.bat
**Type:** Windows Batch file  
**Run as:** Administrator  
**Purpose:** Remove OpenXR configuration

- Removes registry keys
- Asks for confirmation
- Safe uninstallation
- Reverses installation

**How to use:**
1. Right-click
2. "Run as administrator"
3. Confirm when prompted

## 📋 Other Files / Другие файлы

### .gitignore
**Purpose:** Git configuration  
**Цель:** Конфигурация Git

Tells Git which files to ignore (temporary files, backups, etc.)

## 📊 File Decision Tree / Дерево принятия решений

**Want to install?**
- Beginner → Use `install.bat`
- Intermediate → Use `install_openxr.ps1`
- Advanced → Use `install_advanced.ps1`
- Expert → Edit and import `openxr_runtime.reg`

**Need help?**
- Quick start → Read `QUICKSTART.md`
- Full guide → Read `INSTALLATION.md`
- Having issues → Read `TROUBLESHOOTING.md`
- Have questions → Read `FAQ.md`

**After installation?**
- Run `verify_openxr.bat` or `verify_openxr.ps1`

**Want to uninstall?**
- Run `uninstall.bat`

**Want to contribute?**
- Read `CONTRIBUTING.md`

## 🎯 Quick Reference / Быстрая справка

| Task | File to Use |
|------|-------------|
| Install (simple) | `install.bat` |
| Install (advanced) | `install_advanced.ps1` |
| Verify | `verify_openxr.ps1` |
| Uninstall | `uninstall.bat` |
| First time? | `QUICKSTART.md` |
| Problems? | `TROUBLESHOOTING.md` |
| Questions? | `FAQ.md` |

## 📁 Recommended Reading Order / Рекомендуемый порядок чтения

For new users / Для новых пользователей:
1. **README.md** - Understand what this is
2. **QUICKSTART.md** - Get started fast
3. **Run installer** - Actually install
4. **TROUBLESHOOTING.md** - If issues arise

For thorough users / Для тщательных пользователей:
1. **README.md** - Overview
2. **INSTALLATION.md** - Detailed guide
3. **FAQ.md** - Common questions
4. **Run installer** - Install
5. **TROUBLESHOOTING.md** - Reference

For contributors / Для участников:
1. **README.md** - Project overview
2. **CONTRIBUTING.md** - Guidelines
3. **Review all files** - Understand structure
4. **Make improvements** - Contribute!

---

**Still confused?** Start with [QUICKSTART.md](QUICKSTART.md)!
