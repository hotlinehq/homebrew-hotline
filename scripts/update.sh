#!/bin/sh
# Brings the recipes up to date with the newest builds. Run by hand from the
# "update recipes" workflow, or on a Mac with the gh tool signed in.
#
# It reads the public releases of the Hotline repositories, copies the
# checksum each release publishes into the matching recipe, and changes
# nothing when the recipe is already current. The Hotline repositories know
# nothing about this tap.
set -eu

root="$(cd "$(dirname "$0")/.." && pwd)"
hotline=hotlinehq/hotline
capture=hotlinehq/hotline-macos-capture

# Refuse anything that is not what we expect, so odd text from a release can
# never end up inside a recipe.
check() { printf '%s' "$2" | grep -Eq "$3" || { echo "unexpected $1: $2" >&2; exit 1; }; }

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# Say which repository a failing step was reading, since "release not found"
# alone does not tell. It also happens when this run's token cannot see a
# private repository.
step() { echo "== $1"; }

# --- Proxy, edge build -------------------------------------------------
step "reading the edge release of $hotline"
gh release download edge --repo "$hotline" --pattern SHA256SUMS --dir "$work"
edge_sha=$(awk '$2=="hotline-proxy_edge_darwin_arm64.tar.gz" {print $1}' "$work/SHA256SUMS")
edge_commit=$(gh release view edge --repo "$hotline" --json body --jq .body | grep -oE '[0-9a-f]{40}' | head -1)
check "edge checksum" "$edge_sha" '^[0-9a-f]{64}$'
check "edge commit" "$edge_commit" '^[0-9a-f]{40}$'
short=$(printf '%s' "$edge_commit" | cut -c1-12)

cat > "$root/Formula/hotline-proxy-edge.rb" <<RECIPE
# Written by scripts/update.sh. Do not edit by hand.
class HotlineProxyEdge < Formula
  desc "Hotline proxy, newest build of main (signed and notarized, Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline"
  url "https://github.com/hotlinehq/hotline/releases/download/edge/hotline-proxy_edge_darwin_arm64.tar.gz"
  version "edge-${short}"
  sha256 "${edge_sha}"
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

# --- Capture app, newest numbered release --------------------------------
step "reading the newest release of $capture"
tag=$(gh release list --repo "$capture" --limit 1 --json tagName --jq '.[0].tagName // empty')
if [ -z "$tag" ]; then
  echo "No release found in $capture, or this run cannot see it (private?). Capture recipe left as is." >&2
  echo "proxy edge-${short}, capture not updated"
  exit 0
fi
check "capture tag" "$tag" '^v[0-9]+\.[0-9]+\.[0-9]+$'
version=${tag#v}
gh release download "$tag" --repo "$capture" --pattern HotlineCapture.app.tar.sha256 --dir "$work"
# The first line is the app file; the SBOM's checksum follows it.
cap_sha=$(awk '$2=="HotlineCapture.app.tar" {print $1}' "$work/HotlineCapture.app.tar.sha256")
check "capture checksum" "$cap_sha" '^[0-9a-f]{64}$'

cat > "$root/Casks/hotline-capture.rb" <<RECIPE
# Written by scripts/update.sh. Do not edit by hand.
cask "hotline-capture" do
  version "${version}"
  sha256 "${cap_sha}"

  url "https://github.com/hotlinehq/hotline-macos-capture/releases/download/v#{version}/HotlineCapture.app.tar"
  name "Hotline Capture"
  desc "Hands the secure calls of chosen apps to the Hotline proxy (Apple silicon)"
  homepage "https://github.com/hotlinehq/hotline-macos-capture"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Hotline Capture.app"
end
RECIPE

echo "proxy edge-${short}, capture ${version}"
