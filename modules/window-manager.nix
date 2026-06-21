{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.hyprland.enable = true;

  programs.regreet = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
      size = 14;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "eu";
    variant = "";
  };
}
