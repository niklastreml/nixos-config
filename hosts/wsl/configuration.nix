{ config, pkgs, inputs, ... }:

{
	imports = [
		../../modules/common.nix
		../../modules/cli.nix
		../../modules/docker.nix
		./hardware-configuration.nix
	];

	networking.hostName = "wsl";

	home-manager = {
	  useGlobalPkgs = true;
	  users.ntreml = "${inputs.dotfiles}/hosts/wsl.nix";
	  extraSpecialArgs = { inherit inputs; };
	};
}
