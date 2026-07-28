{ config, lib, ... }:
let
  cfg = config.myFeatures.starship;
in
{
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableInteractive = false;
      presets = [ "nerd-font-symbols" ];
    };
  };
}
