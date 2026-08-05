{ nixvim, ... }: {
  imports = [
    nixvim.homeModules.nixvim
    ./nix-your-shell.nix
  ];
  home.username = "ntreml";

  home.homeDirectory = "/home/ntreml";
  home.stateVersion = "26.05";
  home.shell.enableFishIntegration = true;

  # Reuse home-manager's nixpkgs instance instead of letting nixvim build its
  # own. Avoids a second nixpkgs evaluation and the flake-follows source
  # mismatch warning.
  programs.nixvim.nixpkgs.useGlobalPackages = true;

  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  home.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
}
