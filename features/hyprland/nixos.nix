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
    programs.hyprland.enable = true;

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "eu";
    variant = "";
  };
  };
}
