{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.packages-gui;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      brave
      vesktop
      easyroam-connect-desktop
      ghostty
      hyprpicker
      hyprpolkitagent
      imagemagick
      nautilus
      nerd-fonts.fira-code
      seer
      wvkbd
      xournalpp
      ytmdesktop
    ];
  };
}
