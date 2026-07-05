# EasySCP

EasySCP is a terminal file transfer client and dual-pane file manager for
Linux, macOS, BSD and Windows.

It supports SCP, SFTP, FTP/FTPS, SMB/CIFS, S3, WebDAV and Kubernetes file
operations from a terminal interface.

## Features

- Dual-pane local and remote file browsing
- Upload, download, create, rename, remove, search, view and edit files
- SCP and SFTP authentication with SSH keys or username/password
- FTP, FTPS, SMB/CIFS, S3, WebDAV and Kubernetes backends
- Bookmarks and recent connections
- External editor and file opener integration
- Optional password storage through the operating system key vault
- Configurable themes, file sorting and explorer layout
- Desktop notifications for long transfers

## Installation

Linux, FreeBSD and macOS:

```sh
curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.sh | sh
```

On macOS, the installer uses MacPorts when available. If MacPorts is not
available, it builds EasySCP with Cargo, installs the binary at
`/opt/easyscp/bin/easyscp`, and links it at `/opt/local/bin/easyscp`.

The Cargo fallback disables SMB support because stock macOS does not ship
`libsmbclient`.

Windows PowerShell:

```powershell
irm https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.ps1 | iex
```

Cargo:

```sh
cargo install easyscp --locked
```

Arch Linux:

```sh
pacman -S easyscp
```

NetBSD:

```sh
pkgin install easyscp
```

Chocolatey:

```powershell
choco install easyscp
```

## Updating

```sh
easyscp update
```

Depending on the installation target, elevated permissions may be required.

## System Requirements

Linux:

- `libdbus-1`
- `pkg-config`
- `libsmbclient`

FreeBSD and NetBSD:

- `dbus`
- `pkgconf`
- `libsmbclient`

Optional desktop integration:

- Linux and FreeBSD file opening: `xdg-open`, `gio`, `gnome-open` or `kde-open`
- WSL file opening: `wslu`
- Linux password storage: a compatible keyring service

## Documentation

- User manual: <https://github.com/paulo-amaral/easyscp/tree/main/docs>
- Issues: <https://github.com/paulo-amaral/easyscp/issues>
- Changelog: [CHANGELOG.md](CHANGELOG.md)

## License

EasySCP is released under the MIT license. See [LICENSE](LICENSE).
