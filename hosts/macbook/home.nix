{ lib, ... }:
{
  # Standalone home-manager host (darwin). No NixOS layer, so feature toggles
  # are set directly here instead of being bridged from a NixOS config.
  myFeatures = lib.genAttrs [
    "aerospace"
    "direnv"
    "fish"
    "git"
    "neovim"
    "opencode"
    "packages-cli"
    "starship"
    "stylix"
    "tmux"
  ] (_: { enable = true; });
}
