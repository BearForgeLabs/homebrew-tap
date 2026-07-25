# Canonical copy of the Homebrew cask. The LIVE cask lives in the public tap repo
# (BearForgeLabs/homebrew-tap → Casks/hither.rb); this copy is the source of truth the release
# workflow seeds/bumps from. `brew install --cask bearforgelabs/tap/hither`.
#
# NOTE: the DMG is self-signed and not notarized, so the postflight strips the quarantine
# attribute — otherwise a direct-download DMG would hit Gatekeeper's "Open Anyway" wall.
# Drop the postflight once the app is Developer-ID signed + notarized.
cask "hither" do
  version "0.2.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://downloads.bearforgelabs.com/Hither-#{version}.dmg"
  name "Hither"
  desc "Keyboard-driven macOS window and Space switcher"
  homepage "https://bearforgelabs.com"

  # Deployment target is macOS 14.0 (Sonoma).
  depends_on macos: ">= :sonoma"

  app "Hither.app"

  # Self-signed (not notarized): remove the quarantine flag so first launch does not hit Gatekeeper.
  # Remove this block once the app is notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Hither.app"]
  end

  uninstall quit: "com.bearforge.hither"

  zap trash: [
    "~/.config/hither",
    "~/Library/Preferences/com.bearforge.hither.plist",
  ]
end
