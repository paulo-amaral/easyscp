# Installation

EasySCP is available for Linux, macOS, BSD and Windows. Use the method that
matches your platform.

## Linux, FreeBSD, and macOS

Install EasySCP with the shell installer:

```sh
curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.sh | sh
```

On macOS, the installer uses [MacPorts](https://www.macports.org/) when
available. If MacPorts is not installed, it builds EasySCP from source with
Cargo.

## Windows

Install EasySCP from PowerShell:

```ps
irm https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.ps1 | iex
```

Alternatively, use [Chocolatey](https://chocolatey.org/):

```ps
choco install easyscp
```

## NetBSD

Install from the official repositories:

```sh
pkgin install easyscp
```

## Arch Linux

Install from the official repositories:

```sh
pacman -S easyscp
```

## Requirements

The following system dependencies are required.

- Linux users:
  - libdbus-1
  - pkg-config
  - libsmbclient
- FreeBSD and NetBSD users:
  - dbus
  - pkgconf
  - libsmbclient

### Optional requirements

These dependencies are optional, but enable desktop integration features.

- Linux and FreeBSD users, to open files via `V` (at least one of these):
  - xdg-open
  - gio
  - gnome-open
  - kde-open
- Linux users: a keyring manager. Read more in the
  [Password security](../configuration/password-security.md) page.
- WSL users, to open files via `V`:
  - [wslu](https://github.com/wslutilities/wslu)

## Updating easyscp

To update EasySCP, run:

```sh
(sudo) easyscp update
```

For all platforms and methods, see <https://paulo-amaral.github.io/easyscp/install>.
