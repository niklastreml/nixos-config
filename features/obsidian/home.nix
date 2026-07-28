{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.obsidian;
in
{
  config = lib.mkIf cfg.enable {
    programs.obsidian.enable = true;
    programs.obsidian.vaults."notes" = {
      enable = true;
      target = "code/notes";
    };
  };
}
