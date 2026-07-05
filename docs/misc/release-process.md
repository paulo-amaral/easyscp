# Release process

Maintainer guide for shipping a new EasySCP version.

## 1. Dry run

Trigger the `Release` workflow from the Actions tab (or CLI) with
`dry_run: true`:

```sh
gh workflow run release.yml -f version=X.Y.Z -f dry_run=true
```

The dry run bumps the version, generates the changelog, and builds the whole
matrix (Linux amd64/arm64 deb + tar.gz, macOS arm64/x86_64 tar.gz, Windows
x64/arm64 zip) without pushing or publishing anything. Do not proceed until it
is fully green.

## 2. Real release

```sh
gh workflow run release.yml -f version=X.Y.Z -f dry_run=false
```

This pushes the `chore: release vX.Y.Z` bump commit to `main`, creates the
GitHub release `vX.Y.Z` with all assets, publishes to crates.io (requires
trusted publishing, see below), and pushes to Chocolatey when the
`CHOCO_API_KEY` secret is configured (skipped otherwise).

After the run, `git pull` locally to fetch the bump commit.

## 3. Homebrew tap

The macOS formula lives in <https://github.com/paulo-amaral/homebrew-easyscp>.
After the release exists, update `Formula/easyscp.rb`:

1. Bump `version`.
2. Recompute both sha256 checksums from the release tarballs:

```sh
curl -sSLf -O https://github.com/paulo-amaral/easyscp/releases/download/vX.Y.Z/easyscp-vX.Y.Z-aarch64-apple-darwin.tar.gz
curl -sSLf -O https://github.com/paulo-amaral/easyscp/releases/download/vX.Y.Z/easyscp-vX.Y.Z-x86_64-apple-darwin.tar.gz
shasum -a 256 easyscp-vX.Y.Z-*.tar.gz
```

3. Commit and push the tap repo.

## Secrets and external setup

- `RELEASE_PAT` (optional): PAT used for the bump push and release creation so
  they can trigger downstream workflows. Falls back to `github.token`.
- `CHOCO_API_KEY` (optional): Chocolatey push; the publish job skips its steps
  when absent.
- crates.io: the `publish-crate` job authenticates via OIDC trusted
  publishing. Configure it on the crate page under Settings → Trusted
  Publishing (owner `paulo-amaral`, repo `easyscp`, workflow `release.yml`).
  The very first crate version must be published manually with a token.

## Version expectations

`install.sh` pins `EASYSCP_VERSION` and downloads
`easyscp_X.Y.Z-1_{amd64,arm64}.deb` from the release, matching the cargo-deb
output. Keep `install.sh`, `install.ps1`, and `Cargo.toml` versions in sync;
`dist/release/bump_version.sh` (invoked by the workflow) takes care of that.
