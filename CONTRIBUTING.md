# Contributing to OpenXR Windows 11 24H2 Support

Thank you for your interest in contributing to this project! This guide will help you get started.

## How to Contribute

### Reporting Issues

If you encounter problems:

1. Check the [TROUBLESHOOTING.md](TROUBLESHOOTING.md) guide first
2. Search existing [Issues](https://github.com/hikinokomora/OpenXR24h2-win11-/issues) to see if it's already reported
3. If not found, create a new issue with:
   - Your Windows version (run `winver`)
   - Output from `verify_openxr.ps1`
   - Steps to reproduce the problem
   - Expected vs actual behavior

### Suggesting Enhancements

We welcome suggestions for:

- Support for additional VR runtimes
- Improved installation process
- Better error handling
- Documentation improvements
- Localization to other languages

Create an issue with:
- Clear description of the enhancement
- Why it would be useful
- Possible implementation approach (if you have ideas)

### Code Contributions

#### Getting Started

1. Fork the repository
2. Clone your fork
3. Create a new branch for your feature/fix
4. Make your changes
5. Test thoroughly on Windows 11 24H2
6. Submit a pull request

#### Code Guidelines

**PowerShell Scripts:**
- Use clear variable names
- Add comments for complex logic
- Include error handling with try/catch
- Test with both administrator and non-administrator privileges
- Follow PowerShell best practices

**Batch Files:**
- Keep it simple and readable
- Use clear echo messages
- Check for administrator privileges where needed
- Test on different Windows 11 versions

**Registry Files:**
- Always use Windows Registry Editor Version 5.00 format
- Include comments explaining what each section does
- Test imports don't break existing configurations

**Documentation:**
- Use clear, concise language
- Provide examples where helpful
- Include both English and Russian translations for main docs
- Keep formatting consistent

#### Testing Your Changes

Before submitting:

1. Test on clean Windows 11 24H2 installation if possible
2. Test with different VR runtimes (SteamVR, Oculus, etc.)
3. Verify installation script works as administrator
4. Check that uninstallation properly cleans up
5. Run verification scripts to confirm functionality
6. Test error cases (missing SteamVR, wrong permissions, etc.)

#### Pull Request Process

1. Update documentation if you changed functionality
2. Add your changes to a "Changes" section in your PR description
3. Reference any related issues
4. Ensure all files follow the coding guidelines
5. Be responsive to feedback and questions

### Translation Contributions

We welcome translations! To add a new language:

1. Create a new README file: `README.[language-code].md`
2. Translate main sections from README.md
3. Translate QUICKSTART.md and TROUBLESHOOTING.md
4. Update main README.md to link to your translation
5. Submit a pull request

Current languages:
- English (primary)
- Russian (Русский)

Needed:
- Chinese (中文)
- Japanese (日本語)
- German (Deutsch)
- French (Français)
- Spanish (Español)

### Documentation Improvements

Even small improvements help:

- Fix typos
- Clarify confusing sections
- Add missing information
- Improve formatting
- Add helpful examples

### Community Guidelines

- Be respectful and constructive
- Help others when you can
- Share your knowledge
- Give credit where it's due
- Follow the [Code of Conduct](CODE_OF_CONDUCT.md) (to be added)

## Development Setup

### Required Tools

- Windows 11 (preferably 24H2 or newer for testing)
- PowerShell 5.1 or newer
- Text editor (VS Code, Notepad++, etc.)
- Git for version control
- VR headset for testing (optional but recommended)

### Testing Environment

Ideal testing setup:
- Clean Windows 11 24H2 VM
- SteamVR installed
- Sample OpenXR application for testing

### Useful Resources

- [OpenXR Specification](https://www.khronos.org/openxr/)
- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [Windows Registry Documentation](https://docs.microsoft.com/en-us/windows/win32/sysinfo/registry)
- [SteamVR Documentation](https://partner.steamgames.com/doc/features/steamvr)

## Questions?

- Open an issue for questions about contributing
- Check existing issues and discussions
- Be patient - maintainers are volunteers

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Git commit history

Thank you for contributing! 🎉
