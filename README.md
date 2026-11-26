# rodanr/tap

Homebrew tap for apps by [@rodanr](https://github.com/rodanr).

| App | Install | About |
|---|---|---|
| [MacMD](https://github.com/rodanr/MacMD) | `brew install --cask rodanr/tap/macmd` | Native Markdown reader and editor, macOS 26+ on Apple silicon |
| [MouseTune](https://github.com/rodanr/mousetune-deathadder-essential) | `brew install --cask rodanr/tap/mousetune` | DPI, polling rate and lighting for the Razer DeathAdder Essential, macOS 13+ (universal) |
| [PocketRemote](https://github.com/rodanr/PocketRemote) | `brew install --cask rodanr/tap/pocketremote` | Mac host for the PocketRemote phone remote (trackpad, keyboard, media keys), macOS 12+ on Apple silicon |

Installing a fully qualified name (`rodanr/tap/<name>`) trusts just that item. To use short names instead, run
`brew tap rodanr/tap && brew trust rodanr/tap`. Update with `brew upgrade <name>`, remove with
`brew uninstall --zap <name>`.

## Notes per app

### MacMD

MacMD isn't notarized by Apple yet. The cask removes the download quarantine flag from `MacMD.app` after
installing, so macOS opens it without the one-time Open Anyway prompt. The download is still pinned by its
SHA-256 checksum, and every release has a build provenance attestation
(`gh attestation verify MacMD-X.Y.Z.dmg --repo rodanr/MacMD`). The step goes away once releases are notarized.

Installed from the DMG before? Delete `/Applications/MacMD.app` first, or add `--force`.

### MouseTune

MouseTune is ad-hoc signed, not notarized. Like MacMD, the cask removes the download quarantine flag from
`MouseTune.app` after installing, so macOS opens it without the Open Anyway prompt; the download is pinned by
its SHA-256 checksum. On first launch, allow Input Monitoring so it can talk to the mouse. MouseTune is not
affiliated with or endorsed by Razer Inc.

### PocketRemote

This installs the Mac host only; the Android app is a separate APK on the
[releases page](https://github.com/rodanr/PocketRemote/releases/latest). Like the others, the Mac app is ad-hoc
signed and not notarized, so the cask removes the quarantine flag after installing; the download is pinned by
its SHA-256 checksum. After installing, grant Accessibility as the app's Control Panel describes, and press
**Allow this network** the first time on a new network.

## Adding an app

1. Add `Casks/<token>.rb` (GUI app) or `Formula/<name>.rb` (CLI tool). `brew create --cask <url> --tap rodanr/tap`
   gives a starting point.
2. Check it with `brew style rodanr/tap` and `brew audit --strict --online rodanr/tap/<name>`.
3. Keep it current, in one of two ways:
   - Copy the *Update Homebrew tap* step from
     [MacMD's release workflow](https://github.com/rodanr/MacMD/blob/main/.github/workflows/release.yml)
     into the app's release workflow, and give that repo the `HOMEBREW_TAP_DEPLOY_KEY` secret. Give each app repo its
     own write deploy key on this tap (Settings, Deploy keys) and store it as that repo's
     `HOMEBREW_TAP_DEPLOY_KEY` secret, so one leak or rotation affects only one app.
   - Rely on the daily `brew bump` workflow, which uses each cask's `livecheck` to open pull requests.
