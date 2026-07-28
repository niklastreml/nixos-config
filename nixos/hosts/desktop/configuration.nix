{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../../modules/common.nix
    ../../modules/audio.nix
    ../../modules/window-manager.nix
    ../../modules/cli.nix
    ../../modules/gui.nix
    (import ../../modules/grub-theme.nix {
      theme = "mojave";
      type = "float";
      screen = "2k";
      color = "dark";
    })
    ../../modules/bluetooth.nix
    ../../modules/steam.nix
    ../../modules/networkmanager.nix
    ../../modules/usb.nix
    ../../modules/wifi.nix
    ../../modules/docker.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";
  services.libinput.enable = true;

  # Bootloader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.useOSProber = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.efiSupport = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
}
