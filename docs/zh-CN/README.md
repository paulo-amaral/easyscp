# EasySCP

EasySCP 是一个终端文件传输客户端和双面板文件管理器，支持 Linux、macOS、BSD 和 Windows。

它支持 SCP、SFTP、FTP/FTPS、SMB/CIFS、S3、WebDAV 和 Kubernetes，可在终端界面中完成本地与远程文件操作。

## 功能

- 双面板本地和远程文件浏览
- 上传、下载、创建、重命名、删除、搜索、查看和编辑文件
- SCP 和 SFTP 支持 SSH 密钥或用户名/密码认证
- 支持 FTP、FTPS、SMB/CIFS、S3、WebDAV 和 Kubernetes 后端
- 书签和最近连接
- 外部编辑器和文件打开器集成
- 可选的系统密钥库密码存储
- 可配置主题、文件排序和浏览器布局
- 长时间传输完成后的桌面通知

## 安装

Linux、FreeBSD 和 macOS：

```sh
curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.sh | sh
```

在 macOS 上，安装程序会优先使用 MacPorts。如果未安装 MacPorts，则通过 Cargo 从源码构建 EasySCP。

Windows PowerShell：

```powershell
irm https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.ps1 | iex
```

Cargo：

```sh
cargo install easyscp --locked
```

Arch Linux：

```sh
pacman -S easyscp
```

NetBSD：

```sh
pkgin install easyscp
```

Chocolatey：

```powershell
choco install easyscp
```

## 更新

```sh
easyscp update
```

部分安装方式可能需要管理员权限。

## 系统依赖

Linux：

- `libdbus-1`
- `pkg-config`
- `libsmbclient`

FreeBSD 和 NetBSD：

- `dbus`
- `pkgconf`
- `libsmbclient`

可选桌面集成：

- Linux 和 FreeBSD 打开文件：`xdg-open`、`gio`、`gnome-open` 或 `kde-open`
- WSL 打开文件：`wslu`
- Linux 密码存储：兼容的密钥环服务

## 文档

- 用户手册：<https://github.com/paulo-amaral/easyscp/tree/main/docs>
- 问题反馈：<https://github.com/paulo-amaral/easyscp/issues>
- 更新日志：[CHANGELOG.md](CHANGELOG.md)

## 许可证

EasySCP 使用 MIT 许可证发布。请参阅 [LICENSE](LICENSE)。
