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

  myFeatures =
    lib.genAttrs
      [
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
      ]
      (_: {
        enable = true;
      })
    // {
      # Work tooling cherry-picked (master work.enable stays off): the ~/work git
      # identity, glab, and opencode ~/work access.
      work = {
        git.enable = true;
        glab.enable = true;
        opencode.enable = true;
      };
    };

  networking.hostName = "laptop";
  services.libinput.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  # EFI variables and mount point
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  powerManagement.powerDownCommands = ''
    # Gracefully unbind the iwlwifi driver from the device before sleep
    if [ -e "/sys/bus/pci/drivers/iwlwifi/0000:01:00.0" ]; then
      echo "0000:01:00.0" > /sys/bus/pci/drivers/iwlwifi/unbind
    fi
  '';

  powerManagement.resumeCommands = ''
    # Rebind the driver to wake the card back up
    echo "0000:01:00.0" > /sys/bus/pci/drivers/iwlwifi/bind

    # Give the kernel a moment, then restart iwd
    sleep 2
    ${pkgs.systemd}/bin/systemctl restart iwd
  '';
}
