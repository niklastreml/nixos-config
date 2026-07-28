{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.fzf ];

  programs.fzf = {
    enable = true;
  };
}
