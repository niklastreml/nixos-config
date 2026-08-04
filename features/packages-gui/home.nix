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
    home.pointerCursor.enable = true;
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
