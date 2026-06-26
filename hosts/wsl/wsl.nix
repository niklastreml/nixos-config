# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  net = {
    http_proxy = "http://sia-lb.telekom.de:8080";
    https_proxy = "http://sia-lb.telekom.de:8080";
    no_proxy = "localhost,127.0.0.1,.telekom.de";
  };

in
{
  imports = [
    # include NixOS-WSL modules
    # <nixos-wsl/modules>
    inputs.nixos-wsl.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    vim
    git
    wsl-open
    xdg-utils
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  wsl.enable = true;
  wsl.defaultUser = "ntreml";
  wsl.wslConf.network.generateResolvConf = false;
  wsl.interop.register = true;

  users.users."ntreml" = {
    isNormalUser = true;
    description = "Niklas Treml";
    linger = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    package = pkgs.docker;
    daemon.settings = {
      registry-mirrors = [
        "https://dockerhub.devops.telekom.de"
      ];
    };
  };
  systemd.services.docker.environment = {
    HTTP_PROXY = net.httpProxy;
    HTTPS_PROXY = net.https_proxy;
    NO_PROXY = lib.concatStringsSep "," net.no_proxy;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.fish = {
    enable = true;
    # interactiveShellInit = ''
    #   fenv source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
    # '';
  };

  networking.proxy.httpProxy = net.http_proxy;
  networking.proxy.httpsProxy = net.https_proxy;
  networking.proxy.noProxy = net.no_proxy;
  networking.nameservers = [
    "10.34.255.23"
    "10.33.255.23"
    "10.34.255.29"
    "10.33.255.29"
  ];

  programs.ssh = {
    extraConfig = ''
      	Host github.com
      	  Hostname ssh.github.com
      	  Port 443
      	  ProxyCommand nc -X connect -x sia-lb.telekom.de:8080 %h %p
    '';
  };

  # Enable the system-wide D-Bus service
  services.dbus.enable = true;

  # If you are running GUI apps (GTK/GNOME/etc), dconf is heavily tied to dbus and often required
  programs.dconf.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
