{ config, lib, ... }:
let
  cfg = config.myFeatures.bitwarden;
in
{
  config = lib.mkIf cfg.enable {
    programs.rbw.enable = true;
  };
}
