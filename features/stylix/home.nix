{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.myFeatures.stylix;
in
{
  imports = [ inputs.stylix.homeModules.stylix ];

  config = lib.mkIf cfg.enable {
    stylix.enable = true;
    stylix.polarity = "dark";
    stylix.image = ../../assets/wallpaper.png;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    stylix.fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    stylix.cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    # stylix.cursor configures home.pointerCursor; HM now requires enabling it
    # explicitly rather than inferring it from the presence of cursor options.
    # stylix only manages the cursor on Linux, so only enable it there (on
    # darwin the name would be left undefined and error).
    home.pointerCursor.enable = lib.mkIf pkgs.stdenv.hostPlatform.isLinux true;

    stylix.targets.firefox.profileNames = [ "default" ];
  };
}
