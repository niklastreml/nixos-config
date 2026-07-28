{ config, lib, pkgs, ... }:

{
  # home.packages = with pkgs; [
  #   (writeShellScriptBin "womp" ''
  #     tmux new-session -d 'zsh'
  #     tmux new-window 'zsh'
  #     tmux send-keys -t 1 'nvim .' Enter
  #     tmux new-window 'zsh'
  #     tmux select-window -t 1
  #     tmux -2 attach-session -d
  #   '')
  # ];

  # home.file."scripts/silent".source = ./scripts/silent;
}
