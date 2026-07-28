{ config, lib, ... }:
let
  cfg = config.myFeatures.docker;
in
{
  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        default-address-pools = [
          {
            base = "10.10.0.0/16";
            size = 24;
          }
        ];
      };
    };
  };
}
