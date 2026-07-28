{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.k9s;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.k9s ];
    programs.k9s.enable = true;
  };
}
