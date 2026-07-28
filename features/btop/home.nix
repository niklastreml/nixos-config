{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.btop;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.btop ];
    programs.btop.enable = true;
  };
}
