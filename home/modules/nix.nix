{
  config,
  lib,
  pkgs,
  ...
}:

{
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
}
