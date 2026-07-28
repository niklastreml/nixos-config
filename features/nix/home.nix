{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.nix;
in
{
  config = lib.mkIf cfg.enable {
    nix = {
      package = pkgs.nix;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        accept-flake-config = true;
      };
    };
  };
}
