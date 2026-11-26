cask "pocketremote" do
  version "1.0.5"
  sha256 "6d45aa1e5a4eb5302aa6ad2de41f87bbe6b831082477866b92df0aac33e78c79"

  url "https://github.com/rodanr/PocketRemote/releases/download/v#{version}/PocketRemote-#{version}.dmg"
  name "PocketRemote"
  desc "Use your phone as a trackpad, keyboard and media remote"
  homepage "https://github.com/rodanr/PocketRemote"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "PocketRemote.app"

  # PocketRemote is ad-hoc signed, not notarized, so Gatekeeper would block the
  # first launch. Remove this once releases are signed and notarized.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/PocketRemote.app"]
  end

  zap trash: "~/Library/Application Support/pocketremote"

  caveats <<~EOS
    PocketRemote needs Accessibility permission to move the pointer and press keys.
    Follow the steps in its Control Panel, or open
    System Settings > Privacy & Security > Accessibility and switch PocketRemote on.

    The phone app is separate (Android APK):
      https://github.com/rodanr/PocketRemote/releases/latest
  EOS
end
