{ config, lib, ... }:
let
  cfg = config.myFeatures.wifi;
in
{
  config = lib.mkIf cfg.enable {
    networking.networkmanager.wifi.backend = "iwd";
  };
}
