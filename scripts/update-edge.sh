#!/bin/sh
# Rewrites Formula/hotline-proxy-edge.rb for a new edge build.
# Usage: scripts/update-edge.sh <commit> <sha256 of the Mac program tarball>
# The Hotline release workflow calls this after it publishes edge, then
# commits the result. Keeping the recipe text here means the workflow has
# no recipe text of its own to keep in step.
set -eu

commit="${1:?commit of the edge build}"
sha256="${2:?sha256 of hotline-proxy_edge_darwin_arm64.tar.gz}"

# Refuse anything that is not a full commit id or a 64 digit checksum, so a
# wrong argument can never put odd text into the recipe.
printf '%s' "$commit" | grep -Eq '^[0-9a-f]{40}$' || { echo "bad commit: $commit" >&2; exit 1; }
printf '%s' "$sha256" | grep -Eq '^[0-9a-f]{64}$' || { echo "bad sha256: $sha256" >&2; exit 1; }

short=$(printf '%s' "$commit" | cut -c1-12)
out="$(dirname "$0")/../Formula/hotline-proxy-edge.rb"

cat > "$out" <<RECIPE
# Written by scripts/update-edge.sh on every edge build. Do not edit by hand.
class HotlineProxyEdge < Formula
  desc "Hotline proxy, newest build of main (signed and notarized, Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline"
  url "https://github.com/hotlinehq/hotline/releases/download/edge/hotline-proxy_edge_darwin_arm64.tar.gz"
  version "edge-${short}"
  sha256 "${sha256}"
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
RECIPE
echo "wrote $out for ${short}"
