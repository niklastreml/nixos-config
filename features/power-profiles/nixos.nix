{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myFeatures.power-profiles;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;
    })

    (lib.mkIf cfg.udev.enable {
      services.udev.extraRules = ''
        # Switch to power-saver when unplugged (Mains online = 0)
        SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"

        # Switch to performance when plugged in (Mains online = 1)
        SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
      '';
    })
  ];
}
