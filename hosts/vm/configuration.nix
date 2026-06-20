{ config, pkgs, inputs, ... }:

{
	imports = [
		../../modules/common.nix
		../../modules/audio.nix
		../../modules/window-manager.nix
		# ../../modules/home-manager.nix
		../../modules/cli.nix
		../../modules/gui.nix
		../../modules/networkmanager.nix
		../../modules/docker.nix
		./hardware-configuration.nix
	];

	networking.hostName = "vm";
	services.spice-vdagentd.enable = true;

	home-manager = {
	  useGlobalPkgs = true;
	  users.ntreml = "${inputs.dotfiles}/hosts/vm.nix";
	  extraSpecialArgs = { inherit inputs; };
	};
}
