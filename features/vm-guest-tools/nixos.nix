{ config, lib, ... }:
let
  cfg = config.myFeatures.vm-guest-tools;
in
{
  config = lib.mkIf cfg.enable {
    services.spice-vdagentd.enable = true;
    services.qemuGuest.enable = true;
  };
}