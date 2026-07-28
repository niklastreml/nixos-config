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
    (import ../../modules/grub-theme.nix {
      theme = "mojave";
      type = "float";
      screen = "2k";
      color = "dark";
    })
    ../../modules/bluetooth.nix
    ../../modules/steam.nix
    ../../modules/networkmanager.nix
    ../../modules/wifi.nix
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
