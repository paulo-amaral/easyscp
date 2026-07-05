# Command-line usage

easyscp can be started with the following invocation forms:

```sh
easyscp [options]... [protocol://user@address:port:wrkdir] [protocol://user@address:port:wrkdir] [local-wrkdir]
```

OR

```sh
easyscp [options]... -b [bookmark-name] -b [bookmark-name] [local-wrkdir]
```

AND any combination of the two.

If no extra arguments are provided, easyscp shows the authentication form. If an
address argument or a bookmark name is provided, easyscp skips the form and
connects directly to the remote server. When an address or bookmark is given,
you may also provide the starting working directory for the local host as the
last positional argument.

## Options

| Key                  | Description                                                                                                                       |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-b <bookmark-name>` | Resolve the positional address argument as a bookmark name. Repeat the flag to open multiple bookmarks.                           |
| `-D`                 | Enable the `TRACE` log level (debug/verbose logging).                                                                             |
| `-P <password>`      | Provide the password from the CLI. Repeat the flag for multiple remotes; the order must match the address arguments. Discouraged. |
| `-q`                 | Disable logging.                                                                                                                  |
| `-T <ticks>`         | Set the UI tick interval in milliseconds. Default is `10`.                                                                        |
| `--wno-keyring`      | Disable system keyring support.                                                                                                   |
| `-v`                 | Print version info.                                                                                                               |
| `--help`             | Print the help page.                                                                                                              |

The `-P` option is discouraged because the password may be kept in the shell
history. See the bookmarks and password-security chapters for safer ways to
provide credentials.

## Subcommands

easyscp exposes the following subcommands.

### Import a theme

```sh
easyscp theme <theme-file>
```

Import the theme defined in `<theme-file>`.

### Install the latest version

```sh
easyscp update
```

Download and install the latest available version of easyscp.

### Import ssh hosts

```sh
easyscp import-ssh-hosts [ssh-config-file]
```

Import all the hosts from the specified ssh config file as bookmarks in
easyscp. If `[ssh-config-file]` is not provided, the default location
`~/.ssh/config` is used. Identity files are imported as ssh keys in easyscp too.

### Open configuration

```sh
easyscp config
```

Start easyscp directly in the configuration (setup) screen.
