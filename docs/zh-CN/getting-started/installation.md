# 安装

EasySCP 支持 Linux、macOS、BSD 和 Windows。请选择与你的平台匹配的安装方式。

## Linux、FreeBSD 与 macOS

使用 shell 安装脚本安装 EasySCP：

```sh
curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.sh | sh
```

在 macOS 上，安装程序会优先使用 [MacPorts](https://www.macports.org/)；如果未安装 MacPorts，则通过 Cargo 从源码构建 EasySCP。

## Windows

在 PowerShell 中安装 EasySCP：

```ps
irm https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.ps1 | iex
```

也可以使用 [Chocolatey](https://chocolatey.org/)：

```ps
choco install easyscp
```

## NetBSD

从官方仓库安装：

```sh
pkgin install easyscp
```

## Arch Linux

从官方仓库安装：

```sh
pacman -S easyscp
```

## 系统要求

需要以下系统依赖。

- Linux 用户：
  - libdbus-1
  - pkg-config
  - libsmbclient
- FreeBSD 和 NetBSD 用户：
  - dbus
  - pkgconf
  - libsmbclient

### 可选依赖

这些依赖是可选项，但会启用桌面集成功能。

- Linux 和 FreeBSD 用户，若要通过 `V` 打开文件（以下至少需要一项）：
  - xdg-open
  - gio
  - gnome-open
  - kde-open
- Linux 用户：一个密钥环管理器。请在[密码安全](../configuration/password-security.md)页面了解更多。
- WSL 用户，若要通过 `V` 打开文件：
  - [wslu](https://github.com/wslutilities/wslu)

## 更新 easyscp

要更新 EasySCP，请运行：

```sh
(sudo) easyscp update
```

有关所有平台和安装方式，请参阅 <https://paulo-amaral.github.io/easyscp/install>。
