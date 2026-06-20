{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    home-manager
    wget
    curl
    git
  ];
}
