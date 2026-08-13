{ config, lib, ... }:
let
  cfg = config.myFeatures.networkmanager;
in
{
  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
