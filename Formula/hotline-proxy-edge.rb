# Written by scripts/update.sh. Do not edit by hand.
class HotlineProxyEdge < Formula
  desc "Hotline proxy, newest build of main (signed and notarized, Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline"
  url "https://github.com/hotlinehq/hotline/releases/download/edge/hotline-proxy_edge_darwin_arm64.tar.gz"
  version "edge-20261117210217-ed2e13192d4d"
  sha256 "3a23d87cd5385460b42f56186ffbe57672c93708550ea057864eea257fb50bc8"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "hotline-proxy"
  end

  test do
    assert_match "hotline-proxy", shell_output("#{bin}/hotline-proxy version")
  end
end
