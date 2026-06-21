{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/common.nix
    ../../modules/audio.nix
    ../../modules/window-manager.nix
    ../../modules/cli.nix
    ../../modules/gui.nix
    ../../modules/bluetooth.nix
    ../../modules/networkmanager.nix
    ../../modules/docker.nix
    ./hardware-configuration.nix
  ];

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
}
