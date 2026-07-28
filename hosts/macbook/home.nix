{ lib, ... }:
{
  # Standalone home-manager host (darwin). No NixOS layer, so feature toggles
  # are set directly here instead of being bridged from a NixOS config.
  myFeatures = lib.genAttrs [
    "aerospace"
    "bitwarden"
    "btop"
    "direnv"
    "fish"
    "fzf"
    "git"
    "k9s"
    "misc-configs"
    "neovim"
    "opencode"
    "packages-cli"
    "scripts"
    "starship"
    "stylix"
    "tmux"
  ] (_: { enable = true; });
}
