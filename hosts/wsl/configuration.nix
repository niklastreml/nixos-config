{ config, pkgs, inputs, ... }:

{
	imports = [
		../../modules/common.nix
		../../modules/home-manager.nix
		../../modules/cli.nix
		../../modules/docker.nix
		./hardware-configuration.nix
	];

	networking.hostName = "laptop";
	services.xserver.libinput.enable = true;
}
