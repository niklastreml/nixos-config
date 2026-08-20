{ config, lib, ... }:
let
  sub =
    desc:
    lib.mkOption {
      type = lib.types.bool;
      default = config.myFeatures.power-profiles.enable;
      description = desc;
    };
in
{
  options.myFeatures.power-profiles = {
    enable = lib.mkEnableOption "install powerprofiles daemon and setup udev rules for switching automatically between profiles when charger is plugged in";

    udev.enable = sub "Enable udev rules for switching between profiles on charging events";
  };
}
