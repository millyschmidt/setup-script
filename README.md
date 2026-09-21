# setup-script

Personal macOS workstation setup, using Homebrew Bundle.

## Usage

### Fresh machine

```bash
curl -sSL https://raw.githubusercontent.com/millyschmidt/setup-script/main/bootstrap.sh | bash
```

### From a local checkout

```bash
git clone https://github.com/millyschmidt/setup-script.git
cd setup-script
./bootstrap.sh
```

## What it does

1. Installs Xcode Command Line Tools (if missing)
2. Installs Homebrew (if missing)
3. Runs `brew bundle` against the `Brewfile` to install core CLI tools and apps
4. Runs `select-apps.sh` — interactively prompts for optional personal apps and a code editor choice
5. Applies macOS system defaults (`macos-defaults.sh`)

## What gets installed

CLI tools (always):

- git
- gh

Core apps (always):

- 1Password
- Canva
- Claude
- Figma
- Google Chrome
- Linear
- Loom
- Miro
- Notion
- Slack
- Tailscale

Optional personal apps (you'll be prompted for each, y/N):

- Tidal
- WhatsApp
- Spark
- Signal
- Obsidian
- Fantastical
- Arc
- Raycast
- Logi Options+

Code editor (you'll be prompted to pick one, or skip):

- VS Code
- Zed
- Cursor
- PhpStorm

## Not included

- Rippling — no Homebrew cask; install from rippling.com or the App Store
- Attio — no Homebrew cask; it's web-based, use it at attio.com
- Pages, Numbers, Keynote, GarageBand, iMovie — pre-bundled with macOS or via the Mac App Store, not brew-installable

## Adding new apps or tools

For a core app or CLI tool: edit `Brewfile`, add a `brew "<formula>"` or `cask "<cask-name>"` line, then re-run:

```bash
brew bundle --file=Brewfile
```

For an optional personal app or editor choice: edit the `PERSONAL_APPS` or `EDITORS` array in `select-apps.sh`.
