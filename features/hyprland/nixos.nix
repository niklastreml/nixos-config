{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.myFeatures.hyprland;
in
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprpolkitagent
    ];

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.noctalia-greeter = {
      enable = true;
      settings = {
        cursor = {
          theme = "Bibata-Modern-Classic";
          size = 24;
          package = pkgs.bibata-cursors;
        };
        keyboard = {
          layout = "eu";
        };
      };
    };

    services.gvfs.enable = true;
    security.polkit.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "eu";
      variant = "";
    };
  };
}
