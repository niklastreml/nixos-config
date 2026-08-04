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
  hardware.graphics.enable32Bit = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = false;
  boot.kernelParams = [
    "nvidia_drm.modeset=1"
    "nvidia_drm.fbdev=1"
  ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
}
