# Written by scripts/update.sh. Do not edit by hand.
cask "hotline-capture" do
  version "0.1.6"
  sha256 "a138465ff5f84a0e20f2654a3ad9a3169a136665b7130ba43c1f3bac892e8d02"

  url "https://github.com/hotlinehq/hotline-macos-capture/releases/download/v#{version}/HotlineCapture.app.tar"
  name "Hotline Capture"
  desc "Hands the secure calls of chosen apps to the Hotline proxy (Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline-macos-capture"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Hotline Capture.app"
end
