# HelloWorld PowerShell Module

A simple PowerShell module and CLI wrapper that demonstrates how to build, install, and distribute your own PowerShell command-line tools.

---

## Features

- Provides a `HelloWorld` command-line interface
- Includes example commands:
  - `HelloWorld Hello [-Name <string>]`
  - `HelloWorld Info`
  - `HelloWorld Help <Command>`
- Installs system-wide and adds the CLI wrapper to your PATH
- Includes uninstall support

---

## Installation

### From Source

Clone this repository and run the installer script:

```powershell
git clone https://github.com/byron-ojua/PSHelloWorld.git
cd HelloWorld
.\Install.ps1
```

### The installer will:

- Copy the module to C:\Program Files\WindowsPowerShell\Modules\HelloWorld
- Copy the CLI wrapper to C:\Program Files\HelloWorld
- Add the CLI wrapper folder to your system PATH
- Update the current session’s PATH so you can use it immediately

## Usage

Run HelloWorld to see available commands:

```powershell
PS> HelloWorld
Available commands:
  Hello
  Help
  Info
  Uninstall
```

Usage:

```powershell
HelloWorld Help <Command>
HelloWorld <Command> [options]
```

Examples

```powershell
PS> HelloWorld Hello
Hello, World!

PS> HelloWorld Hello -Name John
Hello, John!

PS> HelloWorld Info
Module Author Version Purpose
---
HelloWorld Byron Ojua-Nice 1.0.0 Demonstrate a simple PowerShell module
```

## Uninstall

To uninstall, use:

```powershell
PS> HelloWorld Uninstall
```

or use the uninstall function:

```powershell
PS> Uninstall-HelloWorld
```

or run the included uninstall script:

```powershell
PS> .\Uninstall.ps1
```

This will remove the module and CLI wrapper from your system.

## Development

- Module source is in the root folder (HelloWorld.psm1, HelloWorld.psd1)
- CLI wrapper is in bin/
- Installer and uninstaller are provided for easy setup
