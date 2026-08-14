{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myFeatures.packages-cli;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      autojump
      bat
      bear
      bitwarden-cli
      chafa
      cloc
      curl
      devenv
      difftastic
      dive
      dnsutils
      eza
      file
      fd
      gh
      ghostscript
      gnumake
      graphviz
      helmfile
      jq
      kubernetes-helm
      home-manager
      kind
      krew
      kubectl
      lua5_1
      luarocks
      mercurial
      net-tools
      nh
      libqalculate
      ripgrep
      texliveBasic
      tree-sitter
      typst
      unzip
      (callPackage ./libtexprintf.nix { })
      vim
      nodejs
      wget
    ];

    # CLI tools whose only config is enabling the home-manager module (which
    # also wires up stylix theming and shell integration).
    programs.rbw.enable = true;
    programs.btop.enable = true;
    programs.fzf.enable = true;
    programs.k9s.enable = true;
  };
}
