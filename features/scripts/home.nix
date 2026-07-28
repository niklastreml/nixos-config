{ config, lib, ... }:
let
  cfg = config.myFeatures.scripts;
in
{
  config = lib.mkIf cfg.enable {
    # home.packages = with pkgs; [
    #   (writeShellScriptBin "womp" ''
    #     tmux new-session -d 'zsh'
    #   '')
    # ];
  };
}
