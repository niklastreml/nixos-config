{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myFeatures.packages-gui;
in
{
  config = lib.mkIf cfg.enable {
    programs.thunar.enable = true;

    programs.thunar.plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
