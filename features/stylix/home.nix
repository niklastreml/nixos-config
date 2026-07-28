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
  # This home-manager module is only imported for standalone (non-NixOS) hosts
  # such as the darwin macbook. On NixOS hosts stylix is driven by
  # features/stylix/nixos.nix, which imports the home-manager module itself.
  imports = [ inputs.stylix.homeModules.stylix ];

  config = lib.mkIf cfg.enable {
    stylix.enable = true;
    stylix.polarity = "dark";
    stylix.image = ../../assets/wallpaper.png;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
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
  };
}
