#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Installer for easyscp on Windows.

.DESCRIPTION
    Downloads the latest (or a specified) easyscp release for Windows from
    GitHub, extracts the binary into an install directory and adds it to the
    current user's PATH.

.PARAMETER Version
    The easyscp version to install (defaults to the latest released version).

.PARAMETER InstallDir
    The directory the easyscp.exe binary is installed into.
    Defaults to "$env:LOCALAPPDATA\Programs\easyscp".

.PARAMETER Force
    Skip the confirmation prompt during installation. Alias: -Yes.

.EXAMPLE
    irm https://raw.githubusercontent.com/paulo-amaral/easyscp/main/install.ps1 | iex

.EXAMPLE
    .\install.ps1 -Version 1.0.0 -Force
#>
[CmdletBinding()]
param(
    [string]$Version = "1.1.1",
    [string]$InstallDir = "$env:LOCALAPPDATA\Programs\easyscp",
    [Alias("Yes")]
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$GithubUrl = "https://github.com/paulo-amaral/easyscp/releases/download/v$Version"

# -- output helpers ----------------------------------------------------------

function Write-Info {
    param([string]$Message)
    Write-Host "> " -ForegroundColor DarkGray -NoNewline
    Write-Host $Message
}

function Write-Warn {
    param([string]$Message)
    Write-Host "! $Message" -ForegroundColor Yellow
}

function Write-Err {
    param([string]$Message)
    Write-Host "x $Message" -ForegroundColor Red
}

function Write-Completed {
    param([string]$Message)
    Write-Host "✓ " -ForegroundColor Green -NoNewline
    Write-Host $Message
}

function Confirm-Action {
    param([string]$Message)
    if ($Force) {
        return
    }
    $answer = Read-Host "? $Message [y/N]"
    if ($answer -ne "y" -and $answer -ne "yes") {
        Write-Err 'Aborting (please answer "yes" to continue)'
        exit 1
    }
}

# -- platform detection ------------------------------------------------------

# Currently supporting:
#   - x86_64 (AMD64)
#   - aarch64 (ARM64)
function Get-EasySCPTarget {
    $arch = $env:PROCESSOR_ARCHITECTURE
    if ($env:PROCESSOR_ARCHITEW6432) {
        $arch = $env:PROCESSOR_ARCHITEW6432
    }

    switch ($arch.ToUpper()) {
        "AMD64" { return "x86_64-pc-windows-msvc" }
        "ARM64" { return "aarch64-pc-windows-msvc" }
        default {
            Write-Err "Unsupported architecture: $arch"
            Write-Info "Only x86_64 (AMD64) and aarch64 (ARM64) are supported by this installer."
            Write-Info "Alternatively you can install easyscp with Cargo <https://www.rust-lang.org/tools/install>: cargo install easyscp --locked"
            exit 1
        }
    }
}

# -- installation ------------------------------------------------------------

function Install-EasySCP {
    $target = Get-EasySCPTarget
    $asset = "easyscp-v$Version-$target.zip"
    $url = "$GithubUrl/$asset"

    Write-Host ""
    Write-Host "  EasySCP configuration"
    Write-Info "Version:       $Version"
    Write-Info "Target:        $target"
    Write-Info "Install dir:   $InstallDir"
    Write-Host ""

    Confirm-Action "Install easyscp $Version?"

    $tmpDir = Join-Path ([System.IO.Path]::GetTempPath()) "easyscp-$([System.IO.Path]::GetRandomFileName())"
    New-Item -ItemType Directory -Force -Path $tmpDir | Out-Null

    try {
        $archive = Join-Path $tmpDir $asset
        Write-Info "Downloading easyscp from $url …"
        try {
            Invoke-WebRequest -Uri $url -OutFile $archive -UseBasicParsing
        } catch {
            Write-Err "Failed to download easyscp: $($_.Exception.Message)"
            Write-Warn "If you believe this is a bug, please report an issue at <https://github.com/paulo-amaral/easyscp/issues/new>"
            exit 1
        }

        Write-Info "Extracting archive …"
        Expand-Archive -Path $archive -DestinationPath $tmpDir -Force

        if (-not (Test-Path $InstallDir)) {
            New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
        }

        $binary = Join-Path $tmpDir "easyscp.exe"
        if (-not (Test-Path $binary)) {
            Write-Err "easyscp.exe not found in the downloaded archive"
            exit 1
        }

        Write-Info "Installing easyscp to $InstallDir …"
        Copy-Item -Path $binary -Destination (Join-Path $InstallDir "easyscp.exe") -Force

        Add-ToUserPath -Directory $InstallDir
    } finally {
        Remove-Item -Path $tmpDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Add-ToUserPath {
    param([string]$Directory)

    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $entries = @()
    if ($userPath) {
        $entries = $userPath.Split(";") | Where-Object { $_ -ne "" }
    }

    if ($entries -contains $Directory) {
        return
    }

    Write-Info "Adding $Directory to your user PATH …"
    $newPath = (@($entries) + $Directory) -join ";"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    # make easyscp available in the current session too
    $env:Path = "$env:Path;$Directory"
    Write-Warn "Restart your terminal for the PATH change to take effect in new sessions."
}

# -- main --------------------------------------------------------------------

Install-EasySCP

Write-Completed "EasySCP has been installed successfully."
Write-Info "Documentation: <https://github.com/paulo-amaral/easyscp/tree/main/docs>"
Write-Info "Issues and feature requests: <https://github.com/paulo-amaral/easyscp/issues/new>"

exit 0
