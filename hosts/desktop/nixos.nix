{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    (import ../../system/grub-theme.nix {
      theme = "mojave";
      type = "float";
      screen = "2k";
      color = "dark";
    })
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

  networking.hostName = "desktop";
  services.libinput.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
}
