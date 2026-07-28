{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myFeatures.git;
in
{
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      includes = [
        {
          condition = "gitdir:~/code/";
          contents = {
            user.email = "27763017+niklastreml@users.noreply.github.com";
          };
        }
      ];
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Niklas Treml";
        signingkey = "~/.ssh/id_ed25519.pub";
      };
      merge.tool = "nvimdiff";
      diff = {
        tool = "nvimdiff";
        external = "difft";
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
      rebase.updateRefs = true;
      rerere.enabled = true;
    };
    ignores = [
      ".env"
      ".direnv"
      "result"
      "tmp"
    ];
  };
  };
}
