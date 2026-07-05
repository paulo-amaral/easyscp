#!/usr/bin/env sh
# shellcheck shell=dash

# Options
#
#   -V, --verbose
#     Enable verbose output for the installer
#
#   -f, -y, --force, --yes
#     Skip the confirmation prompt during installation

EASYSCP_VERSION="1.1.1"
GITHUB_URL="https://github.com/paulo-amaral/easyscp/releases/download/v${EASYSCP_VERSION}"
DEB_URL_AMD64="${GITHUB_URL}/easyscp_${EASYSCP_VERSION}-1_amd64.deb"
DEB_URL_AARCH64="${GITHUB_URL}/easyscp_${EASYSCP_VERSION}-1_arm64.deb"

PATH="$PATH:/usr/sbin"

set -eu
printf "\n"

BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

# Functions

set_easyscp_version() {
    EASYSCP_VERSION="$1"
    GITHUB_URL="https://github.com/paulo-amaral/easyscp/releases/download/v${EASYSCP_VERSION}"
    DEB_URL_AMD64="${GITHUB_URL}/easyscp_${EASYSCP_VERSION}-1_amd64.deb"
    DEB_URL_AARCH64="${GITHUB_URL}/easyscp_${EASYSCP_VERSION}-1_arm64.deb"
}

info() {
    printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
    printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
    printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

completed() {
    printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

has() {
    command -v "$1" 1>/dev/null 2>&1
}

get_tmpfile() {
    local suffix
    suffix="$1"
    if has mktemp; then
        printf "%s.%s" "$(mktemp)" "${suffix}"
    else
        # Default location when the caller does not provide a suffix.
        printf "/tmp/easyscp.%s" "${suffix}"
    fi
}

download() {
    output="$1"
    url="$2"
    
    if has curl; then
        cmd="curl --fail --silent --location --output $output $url"
    elif has wget; then
        cmd="wget --quiet --output-document=$output $url"
    elif has fetch; then
        cmd="fetch --quiet --output=$output $url"
    else
        error "No HTTP download program (curl, wget, fetch) found, exiting…"
        return 1
    fi
    $cmd && return 0 || rc=$?

    error "Command failed (exit code $rc): ${BLUE}${cmd}${NO_COLOR}"
    warn "If you believe this is a bug, please report immediately an issue to <https://github.com/paulo-amaral/easyscp/issues/new>"
    return "$rc"
}

test_writeable() {
  local path
  path="${1:-}/test.txt"
  if touch "${path}" 2>/dev/null; then
    rm "${path}"
    return 0
  else
    return 1
  fi
}

elevate_priv() {
    if has sudo; then
      if ! sudo -v; then
        error "Superuser not granted, aborting installation"
        exit 1
      fi
      sudo="sudo"
    elif has doas; then
      sudo="doas"
    else
      error 'Could not find the commands "sudo" or "doas", needed to install easyscp on your system.'
      info "If you are on Windows, please run your shell as an administrator, then"
      info "rerun this script. Otherwise, please run this script as root, or install"
      info "sudo or doas."
      exit 1
    fi
}

elevate_priv_ex() {
    check_dir="$1"
    if test_writeable "$check_dir"; then
        sudo=""
    else
        elevate_priv
    fi
    echo "$sudo"
}

# Currently supporting:
#   - macos
#   - linux
#   - freebsd
detect_platform() {
    local platform
    platform="$(uname -s | tr '[:upper:]' '[:lower:]')"
    
    case "${platform}" in
        linux) platform="linux" ;;
        darwin) platform="macos" ;;
        freebsd) platform="freebsd" ;;
    esac
    
    printf '%s' "${platform}"
}

# Currently supporting:
#   - x86_64
detect_arch() {
    local arch
    arch="$(uname -m | tr '[:upper:]' '[:lower:]')"
    
    case "${arch}" in
        amd64) arch="x86_64" ;;
        armv*) arch="arm" ;;
        arm64) arch="aarch64" ;;
    esac
    
    # `uname -m` in some cases mis-reports 32-bit OS as 64-bit, so double check
    if [ "${arch}" = "x86_64" ] && [ "$(getconf LONG_BIT)" -eq 32 ]; then
        arch="i686"
    elif [ "${arch}" = "aarch64" ] && [ "$(getconf LONG_BIT)" -eq 32 ]; then
        arch="arm"
    fi
    
    printf '%s' "${arch}"
}

confirm() {
    if [ -z "${FORCE-}" ]; then
        printf "%s " "${MAGENTA}?${NO_COLOR} $* ${BOLD}[y/N]${NO_COLOR}"
        set +e
        read -r yn </dev/tty
        rc=$?
        set -e
        if [ $rc -ne 0 ]; then
            error "Error reading from prompt (please re-run with the '--yes' option)"
            exit 1
        fi
        if [ "$yn" != "y" ] && [ "$yn" != "yes" ]; then
            error 'Aborting (please answer "yes" to continue)'
            exit 1
        fi
    fi
}

# Installers

install_on_bsd() {
    try_with_cargo "packages for freeBSD are distribuited no more. Only cargo installations are supported." "freebsd"
}

install_on_arch_linux() {
    pkg="$1"
    info "Detected ${YELLOW}${pkg}${NO_COLOR} on your system"
    # check if rust is already installed
    if ! has cargo; then
        confirm "${YELLOW}rust${NO_COLOR} is required to install ${GREEN}easyscp${NO_COLOR}; would you like to proceed?"
        $pkg -S rust
    fi
    info "Installing ${GREEN}easyscp${NO_COLOR} AUR package…"
    $pkg -S easyscp
}

install_on_debian() {
    local pkg_manager
    if has apt; then
        pkg_manager="apt"
    elif has "apt-get"; then
        pkg_manager="apt-get"
    else
        pkg_manager="dpkg"
    fi

    info "Detected $pkg_manager on your system"
    case "${ARCH}" in
        x86_64) DEB_URL="$DEB_URL_AMD64" ;;
        aarch64) DEB_URL="$DEB_URL_AARCH64" ;;
        *) try_with_cargo "we don't distribute packages for ${ARCH} at the moment" && return $? ;;
    esac
    info "Installing ${GREEN}easyscp${NO_COLOR} via Debian package"
    archive=$(get_tmpfile "deb")
    download "${archive}" "${DEB_URL}"
    info "Downloaded debian package to ${archive}"
    if test_writeable "/usr/bin"; then
        sudo=""
        msg="Installing ${GREEN}easyscp${NO_COLOR}, please wait…"
    else
        warn "Root permissions are required to install ${GREEN}easyscp${NO_COLOR}…"
        elevate_priv
        sudo="sudo"
        msg="Installing ${GREEN}easyscp${NO_COLOR} as root, please wait…"
    fi
    info "$msg"

    if [ "$pkg_manager" = "apt" ]; then
        $sudo apt install -y "${archive}"
    elif [ "$pkg_manager" = "apt-get" ]; then
        $sudo dpkg -i "${archive}"
        $sudo apt-get -f install
    else
        $sudo dpkg -i "${archive}"
    fi

    rm -f "${archive}"
}

install_on_linux() {
    local msg
    local sudo
    local archive
    if has pacman; then
        install_on_arch_linux pacman
    elif has yay; then
        install_on_arch_linux yay
    elif has pakku; then
        install_on_arch_linux pakku
    elif has paru; then
        install_on_arch_linux paru
    elif has aurutils; then
        install_on_arch_linux aurutils
    elif has pamac; then
        install_on_arch_linux pamac
    elif has pikaur; then
        install_on_arch_linux pikaur
    elif has dpkg; then
        install_on_debian
    else
        try_with_cargo "No suitable installation method found for your Linux distribution; if you're running on Arch linux, please install an AUR package manager (such as yay). Currently only Arch, Debian based and Red Hat based distros are supported" "linux"
    fi
}

install_on_macos() {
    try_with_cargo "easyscp is not distributed as a macOS package at the moment" "macos"
}

# -- cargo installation

install_bsd_cargo_deps() {
    set -e
    confirm "${YELLOW}gcc${NO_COLOR} is required to install ${GREEN}easyscp${NO_COLOR}; would you like to proceed?"
    sudo="$(elevate_priv_ex /usr/local/bin)"
    $sudo pkg install -y curl wget gcc dbus pkgconf libsmbclient
    info "Dependencies installed successfully"
}

install_linux_cargo_deps() {
    local debian_deps="gcc pkg-config libdbus-1-dev libsmbclient-dev"
    local rpm_deps="gcc openssl pkgconfig dbus-devel openssl-devel libsmbclient-devel"
    local arch_deps="gcc openssl pkg-config dbus smbclient"
    local deps_cmd=""
    # Get pkg manager
    if has apt; then
        deps_cmd="apt install -y $debian_deps"
    elif has apt-get; then
        deps_cmd="apt-get install -y $debian_deps"
    elif has yum; then
        deps_cmd="yum -y install $rpm_deps"
    elif has dnf; then
        deps_cmd="dnf -y install $rpm_deps"
    elif has pacman; then
        deps_cmd="pacman -S --noconfirm $arch_deps"
    else
        error "Could not find a supported package manager for your Linux distribution"
        error "Supported package manager are: 'apt', 'apt-get', 'yum', 'dnf', 'pacman'"
        exit 1
    fi
    set -e
    confirm "${YELLOW}gcc, openssl, pkg-config, libdbus${NO_COLOR} are required to install ${GREEN}easyscp${NO_COLOR}. The following command will be used to install the dependencies: '${BOLD}${YELLOW}${deps_cmd}${NO_COLOR}'. Would you like to proceed?"
    sudo="$(elevate_priv_ex /usr/local/bin)"
    # shellcheck disable=SC2086 # deps_cmd is a command with args; word-splitting is intended
    $sudo $deps_cmd
    info "Dependencies installed successfully"
}

# shellcheck source=/dev/null
install_cargo() {
    if has cargo; then
        return 0
    fi
    cargo_env="$HOME/.cargo/env"
    # Check if cargo is already installed (actually), but not loaded
    if [ -f "$cargo_env" ]; then
        . "$cargo_env"
    fi
    # Check again cargo
    if has cargo; then
        return 0
    else
        confirm "${YELLOW}rust${NO_COLOR} is required to build easyscp with cargo; would you like to install it now?"
        set -e
        rustup=$(get_tmpfile "sh")
        info "Downloading rustup.sh…"
        download "${rustup}" "https://sh.rustup.rs"
        chmod +x "$rustup"
        "$rustup" -y
        rm -f "${rustup}"
        info "Rust installed with success"
        . "$cargo_env"
    fi

}

try_with_cargo() {
    err="$1"
    platform="$2"
    # Install cargo
    install_cargo
    if has cargo; then
        info "Installing ${GREEN}easyscp${NO_COLOR} via Cargo…"
        case $platform in
            "freebsd")
                install_bsd_cargo_deps
                cargo install --locked --no-default-features easyscp
            ;;

            "linux")
                install_linux_cargo_deps
                cargo install --locked easyscp
            ;;

            "macos")
                # no libsmbclient on stock macOS: build without SMB, like the
                # official x86_64 macOS binary
                cargo install --locked --no-default-features --features keyring easyscp
            ;;

            *)
                cargo install --locked easyscp
            ;;

        esac
    else
        error "$err"
        error "Alternatively you can opt for installing Cargo <https://www.rust-lang.org/tools/install>"
        return 1
    fi
}

# defaults
if [ -z "${PLATFORM-}" ]; then
    PLATFORM="$(detect_platform)"
fi

if [ -z "${BIN_DIR-}" ]; then
    BIN_DIR=/usr/local/bin
fi

if [ -z "${ARCH-}" ]; then
    ARCH="$(detect_arch)"
fi

# parse argv variables
while [ "$#" -gt 0 ]; do
    case "$1" in
        
        -V | --verbose)
            VERBOSE=1
            shift 1
        ;;
        -f | -y | --force | --yes)
            FORCE=1
            shift 1
        ;;
        -V=* | --verbose=*)
            VERBOSE="${1#*=}"
            shift 1
        ;;
        -f=* | -y=* | --force=* | --yes=*)
            FORCE="${1#*=}"
            shift 1
        ;;
        -v=* | --version=*)
            set_easyscp_version "${1#*=}"
            shift 1
        ;;
        *)
            error "Unknown option: $1"
            exit 1
        ;;
    esac
done

printf "  %s\n" "${UNDERLINE}EasySCP configuration${NO_COLOR}"
info "${BOLD}Platform${NO_COLOR}:      ${GREEN}${PLATFORM}${NO_COLOR}"
info "${BOLD}Arch${NO_COLOR}:          ${GREEN}${ARCH}${NO_COLOR}"

# non-empty VERBOSE enables verbose untarring
if [ -n "${VERBOSE-}" ]; then
    VERBOSE=v
    info "${BOLD}Verbose${NO_COLOR}: yes"
else
    VERBOSE=
fi

printf "\n"

confirm "Install ${GREEN}easyscp ${EASYSCP_VERSION}${NO_COLOR}?"

# Installation based on arch
case $PLATFORM in
    "freebsd")
        install_on_bsd
    ;;
    "linux")
        install_on_linux
    ;;
    "macos")
        install_on_macos
    ;;
    *)
        error "${PLATFORM} is not supported by this installer"
        exit 1
    ;;
esac

completed "EasySCP has been installed successfully."
info "Documentation: <https://github.com/paulo-amaral/easyscp/tree/main/docs>"
info "Issues and feature requests: <https://github.com/paulo-amaral/easyscp/issues/new>"

exit 0
