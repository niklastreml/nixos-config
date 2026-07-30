{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # include NixOS-WSL modules
    inputs.nixos-wsl.nixosModules.default
  ];

  myFeatures = lib.genAttrs [
    # system
    "docker"
    # combined system + home
    "neovim"
    # home
    "direnv"
    "fish"
    "git"
    "opencode"
    "packages-cli"
    "starship"
    "stylix"
    "tmux"
    "work"
  ] (_: { enable = true; });

  environment.systemPackages = with pkgs; [
    wsl-open
    xdg-utils
  ];

  networking.hostName = "wsl";

  wsl.interop.register = false;
  wsl.enable = true;
  wsl.defaultUser = "ntreml";
  wsl.wslConf.network.generateResolvConf = false;

  users.users."ntreml" = {
    # Match the UID the WSL instance already assigned; otherwise NixOS defaults
    # the first normal user to 1000 and integrated home-manager activation
    # aborts with "UID is 1001, expected 1000".
    uid = 1001;
    # weird hack so something with dbus works or something idk
    linger = true;
  };

  # Enable the system-wide D-Bus service
  services.dbus.enable = true;

  # If you are running GUI apps (GTK/GNOME/etc), dconf is heavily tied to dbus and often required
  programs.dconf.enable = true;
}
