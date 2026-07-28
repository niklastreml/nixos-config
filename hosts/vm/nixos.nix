{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  myFeatures = lib.genAttrs [
    # system
    "audio"
    "bluetooth"
    "steam"
    "networkmanager"
    "wifi"
    "docker"
    # combined system + home
    "hyprland"
    "usb"
    "neovim"
    # home
    "browser"
    "discord"
    "direnv"
    "eduroam"
    "fish"
    "git"
    "noctalia"
    "obsidian"
    "opencode"
    "packages-cli"
    "packages-gui"
    "starship"
    "stylix"
    "tmux"
    "vscode"
  ] (_: { enable = true; });

  networking.hostName = "vm";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/vda";
}
