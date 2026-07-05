# easyscp

<p align="center">
  <img src="/assets/images/easyscp.svg" alt="easyscp logo" width="256" height="256" />
</p>

<p align="center">~ 功能丰富的终端文件传输工具 ~</p>
<p align="center">
  <a href="https://paulo-amaral.github.io/easyscp" target="_blank">网站</a>
  ·
  <a href="https://paulo-amaral.github.io/easyscp/install" target="_blank">安装</a>
  ·
  <a href="https://github.com/paulo-amaral/easyscp/tree/main/docs" target="_blank">用户手册</a>
</p>

<p align="center">
  <a
    href="https://github.com/paulo-amaral/easyscp/blob/main/README.md"
    ><img
      height="20"
      src="/assets/images/flags/gb.png"
      alt="English"
  /></a>
</p>

[![License-MIT](https://img.shields.io/crates/l/easyscp.svg?logo=rust)](https://opensource.org/licenses/MIT)
[![Repostars](https://img.shields.io/github/stars/paulo-amaral/easyscp?style=flat&logo=github)](https://github.com/paulo-amaral/easyscp/stargazers)
[![Downloadscounter](https://img.shields.io/crates/d/easyscp.svg?logo=rust)](https://crates.io/crates/easyscp)
[![Latest version](https://img.shields.io/crates/v/easyscp.svg?logo=rust)](https://crates.io/crates/easyscp)
[![CI](https://github.com/paulo-amaral/easyscp/workflows/CI/badge.svg?logo=github)](https://github.com/paulo-amaral/easyscp/actions/workflows/ci.yml)

---

## 关于 easyscp 🖥

easyscp 是一个功能丰富的终端文件浏览和传输工具，支持 SCP/SFTP/FTP/Kube/S3/WebDAV。 简而言之，它是一个带有 TUI 的终端工具，可以连接到远程服务器进行文件的检索和上传，并能够与本地文件系统进行交互。 它兼容 **Linux**、**MacOS**、**FreeBSD**、**NetBSD** 和 **Windows** 操作系统。

---

## 特性 🎁

- 📁  支持多种通信协议
  - **SFTP**
  - **SCP**
  - **FTP** 和 **FTPS**
  - **Kube**
  - **S3**
  - **SMB**
  - **WebDAV**
- 🖥  使用便捷的 UI 在远程和本地文件系统上浏览和操作
  - 创建、删除、重命名、搜索、查看和编辑文件
- ⭐  通过“内置书签”和“最近连接”快速连接到您喜爱的主机
- 📝  使用您喜欢的应用程序查看和编辑文件
- 💁  使用 SSH 密钥和用户名/密码进行 SFTP/SCP 身份验证
- 🐧  兼容 Windows、Linux、FreeBSD、NetBSD 和 MacOS 操作系统
- 🐚  内置终端，可在系统上执行命令。
- 🎨  丰富的个性化设置！
  - 主题
  - 自定义文件浏览器格式
  - 可自定义的文本编辑器
  - 可自定义的文件排序
  - 以及许多其他参数...
- 📫  传输大文件时通过桌面通知获得提醒
- 🔭  与远程主机文件更改保持同步
- 🔐  将密码保存在操作系统密钥保管库中
- 🦀  由 Rust 提供强力支持
- 👀  开发时更注重性能
- 🦄  频繁的精彩更新

---

## 开始 🚀

如果您正在考虑安装 easyscp，谢谢您。希望您会喜欢 easyscp！

如果您是 Linux、FreeBSD 或 MacOS 用户，使用以下简单的 shell 脚本即可通过单行指令在您的系统上安装 easyscp：

```sh
curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.sh | sh
```

> ❗ MacOS 安装会优先使用 [MacPorts](https://www.macports.org/)，否则将通过 Cargo 从源码构建

如果您是 Windows 用户，则可以在 PowerShell 中通过单行指令安装 easyscp：

```ps
irm https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.ps1 | iex
```

或者，使用 [Chocolatey](https://chocolatey.org/)：

```ps
choco install easyscp
```

NetBSD 用户可以从官方仓库安装 easyscp。

```sh
pkgin install easyscp
```

Arch Linux 用户可以从官方仓库安装 easyscp。

```sh
pacman -S easyscp
```

如需更多信息或其他平台支持，请访问 [EasySCP install](https://paulo-amaral.github.io/easyscp/install) 查看所有安装方法。

⚠️ 如果您想了解如何更新 easyscp，只需从 CLI 运行 easyscp： `(sudo) easyscp update` ⚠️

### 依赖 ❗

- **Linux** 用户：
  - libdbus-1
  - pkg-config
  - libsmbclient
- **FreeBSD** 或 **NetBSD** 用户：
  - dbus
  - pkgconf
  - libsmbclient

### 可选依赖 ✔️

这些依赖并非运行 easyscp 的强制要求，但有助于享受其全部功能

- **Linux/FreeBSD** 用户：
  - 用 `V` **打开**文件（至少其中之一）
    - *xdg-open*
    - *gio*
    - *gnome-open*
    - *kde-open*
- **Linux** 用户：
  - 密钥环管理器：在[用户手册](configuration/password-security.md)中阅读更多内容
- **WSL** 用户
  - 用 `V` **打开**文件（至少其中之一）
    - [wslu](https://github.com/wslutilities/wslu)

---

## 用户手册 📚

用户手册可以在 [easyscp 文档网站](https://github.com/paulo-amaral/easyscp/tree/main/docs)上找到。

---

## 即将推出的功能 🧪

请查看 [Milestones](https://github.com/paulo-amaral/easyscp/milestones)

---

## 问题 🤝🏻

欢迎在 issue tracker 中提交 bug 报告、功能想法和问题。

---

## 更新日志 ⏳

查看 easyscp 的更新日志[点此](CHANGELOG.md)

---

## 支持 💪

easyscp 由这些很棒的项目提供支持：

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

## 许可协议 📃

easyscp 使用 MIT 许可证授权。

您可以阅读完整的[许可证](LICENSE)
