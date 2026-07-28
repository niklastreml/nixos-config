{ pkgs, ... }:
{
  home.packages = [ pkgs.obsidian ];

  programs.obsidian.enable = true;
  programs.obsidian.vaults = {
    "notes" = {
            enable = true;
            target = "code/notes";
    };
  };
}
