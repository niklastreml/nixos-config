{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;
    # interactiveShellInit = ''
    # fenv source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    # '';
    shellInit = ''
      # Load secrets if the file exists
      if test -f ~/.env.fish
        source ~/.env.fish
      end
    '';
    shellAbbrs = {
      gcsm = "git commit --signoff --message";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "async-prompt";
        src = async-prompt.src;
      }
      {
        name = "foreign-env";
        src = foreign-env.src;
      }
      {
        name = "plugin-git";
        src = plugin-git.src;
      }
      {
        name = "kubectl-aliases";
        src = pkgs.fetchFromGitHub {
          owner = "ahmetb";
          repo = "kubectl-aliases";
          rev = "7549fa45bbde7499b927c74cae13bfb9169c9497";
          sha256 = "sha256-NkprSk55aRVHiq9JXduQl6AGZv5pBLHznRToOdm9OUw=";
        };
      }
    ];
    binds = {
      tab.command = "complete-and-search";
      ctrl-j.command = "forward-char";
      ctrl-h.command = "backward-kill-path-component";
    };
  };
}
