{
  config,
  pkgs,
  inputs,
  ...
}:
{

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  users.users."ntreml" = {
    isNormalUser = true;
    description = "Niklas Treml";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };

  programs.fish = {
    enable = true;
    # interactiveShellInit = ''
    #   fenv source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
    # '';
  };
  virtualisation.docker.enable = true;
  virtualisation.vmVariant = {
    users.users.ntreml.initialPassword = "ntreml";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.variables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
  };

  system.stateVersion = "26.05"; # Did you read the comment?
}
