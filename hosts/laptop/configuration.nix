{ config, pkgs, inputs, ... }:

{
	imports = [
		../../modules/common.nix
		../../modules/audio.nix
		../../modules/window-manager.nix
		../../modules/cli.nix
		../../modules/gui.nix
		../../modules/bluetooth.nix
		../../modules/networkmanager.nix
		../../modules/docker.nix
		./hardware-configuration.nix
	];

	networking.hostName = "laptop";
	services.xserver.libinput.enable = true;
}
