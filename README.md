# homebrew-hotline

Homebrew install recipes for [Hotline](https://github.com/hotlinehq/hotline). A tap is a repository of such recipes.

## Install

```
brew tap hotlinehq/hotline
brew install hotline-proxy-edge          # the proxy, newest build of main
brew install --cask hotline-capture      # the Capture app, into /Applications
```

Both are Apple silicon only, signed and notarized. After installing the Capture app, macOS asks you to approve its system extension in System Settings.

## Update

```
brew update && brew upgrade hotline-proxy-edge
brew upgrade --cask hotline-capture
```

New builds show up here only after someone presses **Run workflow** on the "update recipes" workflow on this repository's Actions page. It reads the newest proxy edge release and the newest Capture release, copies each release's own checksum into the recipe, and commits only when something changed. The recipes are written by `scripts/update.sh`; do not edit them by hand.
