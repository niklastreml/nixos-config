{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.btop ];

  programs.btop = {
    enable = true;
  };
}
