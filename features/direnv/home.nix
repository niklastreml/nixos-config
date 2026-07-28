{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.direnv;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.direnv ];
    programs.direnv = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
