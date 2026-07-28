{ pkgs, ... }: {
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
}
