#!/usr/bin/env bash
set -euo pipefail

# Reads from the controlling terminal directly (fd 3) so prompts still work
# when this script (via bootstrap.sh) is run as `curl ... | bash`, where
# stdin is the pipe rather than a terminal. A permission check on /dev/tty
# isn't enough (it can exist and be "readable" but still fail to open when
# there's no real controlling terminal), so we test the actual open instead.
if ! exec 3<>/dev/tty 2>/dev/null; then
  echo "==> No interactive terminal detected; skipping optional app selection."
  exit 0
fi

PERSONAL_APPS=(
  "Tidal:tidal"
  "WhatsApp:whatsapp"
  "Spark:spark"
  "Signal:signal"
  "Obsidian:obsidian"
  "Fantastical:fantastical"
  "Arc:arc"
  "Raycast:raycast"
)

EDITORS=(
  "VS Code:visual-studio-code"
  "Zed:zed"
  "Cursor:cursor"
  "PhpStorm:phpstorm"
)

echo ""
echo "==> Optional personal apps"
for entry in "${PERSONAL_APPS[@]}"; do
  name="${entry%%:*}"
  cask="${entry#*:}"
  read -r -p "Install $name? [y/N] " reply <&3
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    brew install --cask "$cask" || echo "==> Warning: failed to install $name, continuing."
  fi
done

echo ""
echo "==> Code editor"
echo "Which code editor do you want installed?"
for i in "${!EDITORS[@]}"; do
  echo "  $((i + 1))) ${EDITORS[$i]%%:*}"
done
echo "  0) Skip"
read -r -p "Enter a number: " choice <&3

if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#EDITORS[@]} )); then
  entry="${EDITORS[$((choice - 1))]}"
  name="${entry%%:*}"
  cask="${entry#*:}"
  brew install --cask "$cask" || echo "==> Warning: failed to install $name, continuing."
fi
