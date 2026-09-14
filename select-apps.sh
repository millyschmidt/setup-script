#!/usr/bin/env bash
set -euo pipefail

# Reads from the controlling terminal directly so prompts still work when this
# script (via bootstrap.sh) is run as `curl ... | bash`, where stdin is the pipe.
TTY_IN=/dev/tty
if [ ! -r "$TTY_IN" ]; then
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
  read -r -p "Install $name? [y/N] " reply < "$TTY_IN"
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    brew install --cask "$cask"
  fi
done

echo ""
echo "==> Code editor"
echo "Which code editor do you want installed?"
for i in "${!EDITORS[@]}"; do
  echo "  $((i + 1))) ${EDITORS[$i]%%:*}"
done
echo "  0) Skip"
read -r -p "Enter a number: " choice < "$TTY_IN"

if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#EDITORS[@]} )); then
  entry="${EDITORS[$((choice - 1))]}"
  cask="${entry#*:}"
  brew install --cask "$cask"
fi
