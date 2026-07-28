{ config, lib, ... }:
let
  cfg = config.myFeatures.usb;
in
{
  config = lib.mkIf cfg.enable {
    services.udisks2.enable = true;
  };
}
