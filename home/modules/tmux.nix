{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.tmux ];

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    focusEvents = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g allow-passthrough on
      set -g visual-activity off
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g extended-keys on
    '';

  };
}
