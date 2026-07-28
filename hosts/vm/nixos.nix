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
    "networkmanager"
    "docker"
    # combined system + home
    "hyprland"
    "usb"
    "neovim"
    # home
    "direnv"
    "fish"
    "git"
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
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/vda";
}
