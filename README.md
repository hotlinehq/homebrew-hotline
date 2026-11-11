# homebrew-hotline

Homebrew install recipes for [Hotline](https://github.com/hotlinehq/hotline). A tap is a repository of such recipes.

## Install, step by step

You need a Mac with Apple silicon (an M-series chip).

1. **Get Homebrew** if `brew --version` says "command not found". Follow the one-line install on https://brew.sh, then open a new Terminal window.
2. **Add this tap** (the tap is this repository, which Homebrew reads for recipes). You do this once:
   ```
   brew tap hotlinehq/hotline
   ```
3. **Trust the tap.** Newer Homebrew refuses recipes from a tap it was not told to trust. This tap is yours, so say so once:
   ```
   brew trust hotlinehq/hotline
   ```
4. **Install what you need:**
   ```
   brew install hotline-proxy-edge          # the proxy, newest build of main
   brew install --cask hotline-capture      # the Capture app, into /Applications
   ```
5. **Check it worked:**
   ```
   hotline-proxy version
   ls /Applications | grep "Hotline Capture"
   ```

Both are signed and notarized. After installing the Capture app, macOS asks you to approve its system extension in System Settings. The first run of a program needs internet, so Apple can confirm its approval.

To remove them: `brew uninstall hotline-proxy-edge`, `brew uninstall --cask hotline-capture`, and `brew untap hotlinehq/hotline`.

## Update

```
brew update && brew upgrade hotline-proxy-edge
brew upgrade --cask hotline-capture
```

New builds show up here only after someone presses **Run workflow** on the "update recipes" workflow on this repository's Actions page. It reads the newest proxy edge release and the newest Capture release, copies each release's own checksum into the recipe, and commits only when something changed. The recipes are written by `scripts/update.sh`; do not edit them by hand.
