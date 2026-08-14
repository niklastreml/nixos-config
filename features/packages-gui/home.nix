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
      easyroam-connect-desktop
      ghostty
      hyprpicker
      hyprpolkitagent
      imagemagick
      nerd-fonts.fira-code
      wvkbd
      xournalpp
    ];
  };
}
