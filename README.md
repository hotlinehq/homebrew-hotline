# homebrew-hotline

Homebrew install recipes for [Hotline](https://github.com/hotlinehq/hotline). A tap is a repository of such recipes.

## Install the newest edge build

```
brew tap hotlinehq/hotline
brew install hotline-proxy-edge
hotline-proxy version
```

Update later with `brew update && brew upgrade hotline-proxy-edge`.

Edge is the newest build of the main branch: the signed and notarized Mac program, Apple silicon only. The recipe `Formula/hotline-proxy-edge.rb` is rewritten by Hotline's release workflow with `scripts/update-edge.sh` on every edge build, so do not edit it by hand.
