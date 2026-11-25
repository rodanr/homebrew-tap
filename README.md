# rodanr/tap

Homebrew tap for [MacMD](https://github.com/rodanr/MacMD), a native Markdown reader and editor for macOS 26+ on Apple silicon.

```sh
brew install --cask rodanr/tap/macmd   # install (this also trusts the macmd cask)
brew upgrade macmd                     # update
brew uninstall --zap macmd             # remove the app and its settings
```

Installed MacMD from the DMG before? Delete `/Applications/MacMD.app` first, or add `--force` to the install command.

## Why no "Open Anyway"?

MacMD isn't notarized by Apple yet. The cask removes the download quarantine flag from `MacMD.app` after
installing, so macOS opens it without the one-time prompt. This is what the MacMD README's Terminal tip does.
The download is still pinned by its SHA-256 checksum, and every release has a build provenance attestation:

```sh
gh attestation verify MacMD-X.Y.Z.dmg --repo rodanr/MacMD
```

The step goes away once releases are notarized.

## Updates

The MacMD release workflow commits each stable release here (`Casks/macmd.rb`). The daily `brew bump`
workflow is a fallback that opens a pull request if a release was missed.
