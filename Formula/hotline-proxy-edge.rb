# Written by scripts/update.sh. Do not edit by hand.
class HotlineProxyEdge < Formula
  desc "Hotline proxy, newest build of main (signed and notarized, Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline"
  url "https://github.com/hotlinehq/hotline/releases/download/edge/hotline-proxy_edge_darwin_arm64.tar.gz"
  version "edge-0cbb65531e75"
  sha256 "a43971e798671b9d1d3f6ec4449a35016bd6017f14a238e542387b8c6d572fe6"
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
