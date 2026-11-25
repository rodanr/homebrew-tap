cask "macmd" do
  version "0.8.0"
  sha256 "a32d9dd0fcb530a5385743fcf538b03014e466706bcfc2a0f781d109c8092289"

  url "https://github.com/rodanr/MacMD/releases/download/v#{version}/MacMD-#{version}.dmg"
  name "MacMD"
  desc "Native Markdown reader and editor"
  homepage "https://github.com/rodanr/MacMD"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "MacMD.app"

  # MacMD is not notarized yet, so Gatekeeper would block the first launch.
  # Remove this once releases are signed with Developer ID and notarized.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MacMD.app"]
  end

  zap trash: [
    "~/Library/Caches/io.github.rodanr.macmd",
    "~/Library/HTTPStorages/io.github.rodanr.macmd",
    "~/Library/Preferences/io.github.rodanr.macmd.plist",
    "~/Library/Saved Application State/io.github.rodanr.macmd.savedState",
    "~/Library/WebKit/io.github.rodanr.macmd",
  ]
end
