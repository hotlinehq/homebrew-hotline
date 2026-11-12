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

If the Capture app is already in /Applications (for example from a manual download), `brew install --cask hotline-capture` stops with "already an App". Quit the app, then run `brew install --cask --adopt hotline-capture` to let Homebrew take over the existing copy, or add `--force` to replace it.

Both are signed and notarized. After installing the Capture app, macOS asks you to approve its system extension in System Settings. The first run of a program needs internet, so Apple can confirm its approval.

To remove them: `brew uninstall hotline-proxy-edge`, `brew uninstall --cask hotline-capture`, and `brew untap hotlinehq/hotline`.

## Update

Two things happen in order: first the tap learns about new builds, then your Mac picks them up.

1. **Update the tap** (whoever publishes builds does this, after a new proxy edge build or a new Capture release):
   1. Open the Actions page of this repository: https://github.com/hotlinehq/homebrew-hotline/actions
   2. Choose the workflow "update recipes" on the left.
   3. Press **Run workflow**, keep the branch `main`, and press the green **Run workflow** button.
   4. Wait for the run to turn green. It reads the newest proxy edge release and the newest Capture release, copies each release's own checksum into the recipe, and commits only when something changed. The recipes are written by `scripts/update.sh`; do not edit them by hand.
2. **Update your Mac:**
   ```
   brew update
   brew upgrade
   ```
   `brew update` fetches the tap's new recipes. A plain `brew upgrade` is all that is needed for both the proxy and Capture: it installs the newer builds, and does nothing when you are already current. The proxy version is `edge-<commit time>-<short hash>`, so every new build counts as newer.
