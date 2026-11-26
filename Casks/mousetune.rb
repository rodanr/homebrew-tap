cask "mousetune" do
  version "0.1.1"
  sha256 "3d996a57b89f2144e28c15ad1d78984a7d0a0ec1ea8b03a98e46b5ae28df5d19"

  url "https://github.com/rodanr/mousetune-deathadder-essential/releases/download/v#{version}/MouseTune-#{version}-macos-universal.dmg"
  name "MouseTune"
  desc "Set DPI, polling rate and lighting on the Razer DeathAdder Essential"
  homepage "https://github.com/rodanr/mousetune-deathadder-essential"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "MouseTune.app"

  # MouseTune is ad-hoc signed, not notarized, so Gatekeeper would block the
  # first launch. Remove this once releases are signed and notarized.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MouseTune.app"]
  end

  zap trash: "~/Library/Application Support/io.github.rodanr.MouseTune"

  caveats <<~EOS
    MouseTune needs Input Monitoring permission to talk to the mouse.
    Allow it when asked, or in System Settings > Privacy & Security > Input Monitoring.
  EOS
end
