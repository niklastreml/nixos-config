{ config, pkgs, inputs, ... }:
{
  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
      	command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
	user = "greeter";
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "eu";
    variant = "";
  };
}
