#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/millyschmidt/setup-script.git"
REPO_DIR="${SETUP_SCRIPT_DIR:-$HOME/.setup-script}"

echo "==> Checking for Xcode Command Line Tools..."
if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools (a GUI prompt will appear)..."
  xcode-select --install
  echo "Re-run this script once the Xcode CLT install finishes."
  exit 1
fi

echo "==> Checking for Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -d /opt/homebrew/bin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -d /usr/local/bin ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Find the Brewfile etc: use a local checkout if running ./bootstrap.sh from one,
# otherwise (curl | bash) clone the repo first.
SCRIPT_SOURCE="${BASH_SOURCE[0]:-}"
if [[ -n "$SCRIPT_SOURCE" && -f "$(dirname "$SCRIPT_SOURCE")/Brewfile" ]]; then
  WORKDIR="$(cd "$(dirname "$SCRIPT_SOURCE")" && pwd)"
else
  echo "==> Cloning setup-script..."
  if [[ -d "$REPO_DIR/.git" ]]; then
    git -C "$REPO_DIR" pull --ff-only
  else
    git clone "$REPO_URL" "$REPO_DIR"
  fi
  WORKDIR="$REPO_DIR"
fi

cd "$WORKDIR"

echo "==> Installing apps and tools from Brewfile..."
brew bundle --file=Brewfile

echo "==> Applying macOS defaults..."
./macos-defaults.sh

echo "==> Done. Log out/in for some macOS defaults to fully apply."
