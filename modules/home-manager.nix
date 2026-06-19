{ config, inputs, pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.ntreml = import "${inputs.dotfiles}/home.nix";
    extraSpecialArgs = { inherit inputs; isWsl = false; };
  };
}
