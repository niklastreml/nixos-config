{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableInteractive = false;
    presets = [ "nerd-font-symbols" ];
  };
}
