{ pkgs, ... }:
{
    home.packages = [ pkgs.k9s ];

    programs.k9s.enable = true;
}
