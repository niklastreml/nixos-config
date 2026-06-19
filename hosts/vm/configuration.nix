{ config, pkgs, inputs, ... }:

{
	imports = [
		../../modules/common.nix
		../../modules/audio.nix
		../../modules/window-manager.nix
		../../modules/home-manager.nix
		../../modules/cli.nix
		../../modules/gui.nix
		./hardware-configuration.nix
	];

	networking.hostName = "laptop";
	services.spice-vdagentd.enable = true;
}
