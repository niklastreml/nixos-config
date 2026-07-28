{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.fzf;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.fzf ];
    programs.fzf.enable = true;
  };
}
