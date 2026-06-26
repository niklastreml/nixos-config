{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # include NixOS-WSL modules
    inputs.nixos-wsl.nixosModules.default

    ../../modules/common.nix
    ../../modules/cli.nix
    ../../modules/docker.nix
  ];

  environment.systemPackages = with pkgs; [
    wsl-open
    xdg-utils
  ];

  networking.hostName = "wsl";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  wsl.interop.register = true;
  wsl.enable = true;
  wsl.defaultUser = "ntreml";
  wsl.wslConf.network.generateResolvConf = false;

  users.users."ntreml" = {
    # weird hack so something with dbus works or something idk
    linger = true;
  };

  networking.proxy.httpProxy = "http://sia-lb.telekom.de:8080";
  networking.proxy.httpsProxy = "http://sia-lb.telekom.de:8080";
  networking.proxy.noProxy = "localhost,127.0.0.1,.telekom.de";
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
}
