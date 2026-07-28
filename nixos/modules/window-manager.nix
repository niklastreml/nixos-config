{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

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
}
