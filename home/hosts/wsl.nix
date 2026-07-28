{ ... }: {
  imports = [
    ../modules/base.nix
    ../modules/bitwarden.nix
    ../modules/btop.nix
    ../modules/fish.nix
    ../modules/fzf.nix
    ../modules/git.nix
    ../modules/k9s.nix
    ../modules/misc-configs.nix
    ../modules/neovim.nix
    ../modules/opencode
    ../modules/packages-cli.nix
    ../modules/packages-work.nix
    ../modules/scripts.nix
    ../modules/starship.nix
    ../modules/stylix.nix
    ../modules/telecontext.nix
    ../modules/tmux.nix
    ../modules/work-skills.nix
  ];

  home.sessionVariables.GOPRIVATE = "gitlab.devops.telekom.de/*";
}
