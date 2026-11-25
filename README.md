# rodanr/tap

Homebrew tap for apps by [@rodanr](https://github.com/rodanr).

| App | Install | About |
|---|---|---|
| [MacMD](https://github.com/rodanr/MacMD) | `brew install --cask rodanr/tap/macmd` | Native Markdown reader and editor, macOS 26+ on Apple silicon |

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

## Adding an app

1. Add `Casks/<token>.rb` (GUI app) or `Formula/<name>.rb` (CLI tool). `brew create --cask <url> --tap rodanr/tap`
   gives a starting point.
2. Check it with `brew style rodanr/tap` and `brew audit --strict --online rodanr/tap/<name>`.
3. Keep it current, in one of two ways:
   - Copy the *Update Homebrew tap* step from
     [MacMD's release workflow](https://github.com/rodanr/MacMD/blob/main/.github/workflows/release.yml)
     into the app's release workflow, and give that repo the `HOMEBREW_TAP_DEPLOY_KEY` secret. This tap has
     one write deploy key, and every app repo stores the same private half.
   - Rely on the daily `brew bump` workflow, which uses each cask's `livecheck` to open pull requests.
