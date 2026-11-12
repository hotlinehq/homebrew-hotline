# Written by scripts/update.sh. Do not edit by hand.
class HotlineProxyEdge < Formula
  desc "Hotline proxy, newest build of main (signed and notarized, Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline"
  url "https://github.com/hotlinehq/hotline/releases/download/edge/hotline-proxy_edge_darwin_arm64.tar.gz"
  version "edge-57a2a81146b2"
  sha256 "7cb54f0349b561df765231e3a8f659d439def5ba30781b2512cd7efe1077c3e1"
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
