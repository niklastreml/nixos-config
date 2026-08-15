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
  imports = [ inputs.stylix.nixosModules.stylix ];

  # The NixOS module auto-imports stylix into every home-manager.users.* and
  # copies image/scheme/fonts/cursor/polarity down (homeManagerIntegration's
  # autoImport + followSystem, both on by default). It also disables its own
  # overlay when home-manager.useGlobalPkgs is set, so nothing extra is needed
  # on the home-manager side for NixOS hosts.
  config = lib.mkIf cfg.enable {
    stylix.enable = true;
    stylix.polarity = "dark";
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
