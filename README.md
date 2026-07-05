# EasySCP - terminal file transfer client

<p align="center">
  <img src="/assets/images/easyscp.svg" alt="easyscp logo" width="256" height="256" />
</p>

<p align="center">Terminal file transfer and dual-pane file manager for SCP, SFTP, FTP, SMB, S3, WebDAV and Kubernetes.</p>
<p align="center">
  <a href="https://paulo-amaral.github.io/easyscp" target="_blank">Website</a>
  ·
  <a href="https://paulo-amaral.github.io/easyscp/install" target="_blank">Installation</a>
  ·
  <a href="https://github.com/paulo-amaral/easyscp/tree/main/docs" target="_blank">User manual</a>
</p>

<p align="center">
  <a
    href="/docs/zh-CN/README.md"
    ><img
      height="20"
      src="/assets/images/flags/cn.png"
      alt="简体中文"
  /></a>
</p>

[![License-MIT](https://img.shields.io/crates/l/easyscp.svg?logo=rust)](https://opensource.org/licenses/MIT)
[![Repostars](https://img.shields.io/github/stars/paulo-amaral/easyscp?style=flat&logo=github)](https://github.com/paulo-amaral/easyscp/stargazers)
[![Downloadscounter](https://img.shields.io/crates/d/easyscp.svg?logo=rust)](https://crates.io/crates/easyscp)
[![Latest version](https://img.shields.io/crates/v/easyscp.svg?logo=rust)](https://crates.io/crates/easyscp)
[![CI](https://github.com/paulo-amaral/easyscp/workflows/CI/badge.svg?logo=github)](https://github.com/paulo-amaral/easyscp/actions/workflows/ci.yml)

---

## About EasySCP

EasySCP is a terminal file transfer client and dual-pane file manager for SCP, SFTP, FTP/FTPS, SMB/CIFS, S3, WebDAV and Kubernetes. It runs on **Linux**, **macOS**, **FreeBSD**, **NetBSD** and **Windows**.

---

## Features

- Protocol support: SFTP, SCP, FTP/FTPS, SMB/CIFS, S3, WebDAV and Kubernetes.
- Dual-pane local and remote file explorer.
- File operations: create, remove, rename, search, view and edit.
- Bookmarks and recent connections for frequently used hosts.
- SSH key and username/password authentication for SFTP and SCP.
- External file opening and editing through system applications.
- Embedded terminal for local command execution.
- Configurable themes, explorer format, editor and sorting.
- Desktop notifications for large transfers.
- File watching for synchronized changes.
- Password storage through the operating system key vault where available.

---

## Installation

Install EasySCP on Linux, FreeBSD or macOS with:

```sh
curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.sh | sh
```

On macOS, the installer uses [MacPorts](https://www.macports.org/) when available. If MacPorts is not installed, it builds EasySCP from source with Cargo.

Install EasySCP on Windows from PowerShell with:

```ps
irm https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.ps1 | iex
```

Or install it with [Chocolatey](https://chocolatey.org/):

```ps
choco install easyscp
```

NetBSD:

```sh
pkgin install easyscp
```

Arch Linux:

```sh
pacman -S easyscp
```

For all supported installation methods, see <https://paulo-amaral.github.io/easyscp/install>.

To update EasySCP, run:

```sh
(sudo) easyscp update
```

### Requirements

- **Linux** users:
  - libdbus-1
  - pkg-config
  - libsmbclient
- **FreeBSD** and **NetBSD** users:
  - dbus
  - pkgconf
  - libsmbclient

### Optional Requirements

These packages are optional, but enable desktop integration features.

- **Linux/FreeBSD** users:
  - To **open** files via `V` (at least one of these)
    - *xdg-open*
    - *gio*
    - *gnome-open*
    - *kde-open*
- **Linux** users:
  - A keyring manager: read more in the [User manual](docs/en-US/configuration/password-security.md)
- **WSL** users
  - To **open** files via `V` (at least one of these)
    - [wslu](https://github.com/wslutilities/wslu)

---

## User manual

The user manual is available at <https://github.com/paulo-amaral/easyscp/tree/main/docs>.

---

## Roadmap

See [Milestones](https://github.com/paulo-amaral/easyscp/milestones)

---

## Issues

Bug reports, feature ideas and questions are welcome in the issue tracker.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

---

## Dependencies

EasySCP uses these open source projects:

- [bytesize](https://github.com/hyunsik/bytesize)
- [crossterm](https://github.com/crossterm-rs/crossterm)
- [edit](https://github.com/milkey-mouse/edit)
- [keyring-rs](https://github.com/hwchen/keyring-rs)
- [kube](https://github.com/kube-rs/kube)
- [open-rs](https://github.com/Byron/open-rs)
- [pavao](https://crates.io/crates/pavao)
- [remotefs](https://crates.io/crates/remotefs)
- [rpassword](https://github.com/conradkleinespel/rpassword)
- [self_update](https://github.com/jaemk/self_update)
- [ratatui](https://github.com/ratatui-org/ratatui)
- [tui-realm](https://crates.io/crates/tuirealm)
- [whoami](https://github.com/libcala/whoami)
- [wildmatch](https://github.com/becheran/wildmatch)

## License

EasySCP is licensed under the MIT license.

See [LICENSE](LICENSE).
