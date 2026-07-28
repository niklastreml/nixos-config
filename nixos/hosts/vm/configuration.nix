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
    ../../modules/usb.nix
    ../../modules/networkmanager.nix
    ../../modules/docker.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "vm";
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/vda";
}
