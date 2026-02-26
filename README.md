# home.nix

My NixOS configuration with flakes and home-manager.

## Overview

- **WM:** Niri (Wayland compositor)
- **Shell:** Zsh + Starship
- **Terminal:** Alacritty
- **Launcher:** Fuzzel
- **Theming:** Matugen (Material You color generation)
- **Channel:** nixos-unstable

## Structure

```
flake.nix              # Flake entrypoint
install.sh             # Rebuild shortcut
nixos/
  configuration.nix    # System-level config
  home.nix             # Home-manager config
  packages.nix         # System packages
  user-packages.nix    # User packages
  development-packages.nix
  gui.nix              # Display/login/fonts
  sound.nix            # Audio (PipeWire)
  dns.nix              # DNS settings
  programs/            # Per-program configs (alacritty, neovim, niri, zsh, ...)
  scripts/             # Fuzzel scripts (powermenu, emoji, audio, ...)
  icons/               # Custom SVG icons
```

## Install

```shell
./install.sh
# or
sudo nixos-rebuild switch --flake .#nixos-btw
```

## Cleanup

```shell
nix-env -p /nix/var/nix/profiles/system --delete-generations old # delete all previous
nix-collect-garbage -d
nix-env -p /nix/var/nix/profiles/system --list-generations
## Remove entries from /boot/loader/entries:
sudo bash -c "cd /boot/loader/entries; ls | grep -v <current-generation-name> | xargs rm"
```
