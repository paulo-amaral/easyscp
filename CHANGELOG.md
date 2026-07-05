## 1.1.1

Released on 2026-07-05

### CI

- replace MacPorts with Homebrew on macOS runners and fallback to github.token
  > GitHub-hosted macos-latest runners do not ship MacPorts, so 'sudo port
  > install' failed on every run; adopt the Homebrew dependency setup used
  > upstream. Release workflow now falls back to github.token because repo
  > secrets (RELEASE_PAT) were wiped when the repository was recreated.
- skip chocolatey publish when CHOCO_API_KEY is not configured
- fix chocolatey guard, secrets context is not valid in job-level if

### Documentation

- refactor and simplify README files for better readability

### Fixed

- **install:** install via cargo on macOS instead of MacPorts
  > No easyscp port exists in the MacPorts registry, so the port path always
  > failed. macOS now builds from source with cargo, without the smb feature,
  > matching the official x86_64 macOS binary (stock macOS has no libsmbclient).
