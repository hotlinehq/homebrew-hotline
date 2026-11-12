# Written by scripts/update.sh. Do not edit by hand.
cask "hotline-capture" do
  version "0.2.0"
  sha256 "f43810514f08fb37ea18796ebc7c954f18b9dc0d789f661a1ae76521abc0238f"

  url "https://github.com/hotlinehq/hotline-macos-capture/releases/download/v#{version}/HotlineCapture.app.tar"
  name "Hotline Capture"
  desc "Hands the secure calls of chosen apps to the Hotline proxy (Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline-macos-capture"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Hotline Capture.app"
end
