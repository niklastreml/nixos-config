{ pkgs, ... }:
{
  home.packages = [
    pkgs.direnv
  ];
  programs.direnv = {
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
