#!/usr/bin/env bash
set -euo pipefail

echo "==> Applying macOS system defaults..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show full path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Faster trackpad tracking speed
defaults write -g com.apple.trackpad.scaling 2.5

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Faster key repeat rate
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

killall Finder >/dev/null 2>&1 || true

echo "==> macOS defaults applied."
