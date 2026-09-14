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
3. Runs `brew bundle` against the `Brewfile` to install CLI tools and apps
4. Applies macOS system defaults (`macos-defaults.sh`)

## Not included

- Rippling — no Homebrew cask; install from rippling.com or the App Store
- Pages, Numbers, Keynote, GarageBand, iMovie — pre-bundled with macOS or via the Mac App Store, not brew-installable

## Adding new apps or tools

Edit `Brewfile`, add a `brew "<formula>"` or `cask "<cask-name>"` line, then re-run:

```bash
brew bundle --file=Brewfile
```
