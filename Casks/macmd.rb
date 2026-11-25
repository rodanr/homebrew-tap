cask "macmd" do
  version "0.9.0"
  sha256 "1f52aca984673b1ea42d4343ccad032536892e83a6a2caac33150a7fe9c473e0"

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
