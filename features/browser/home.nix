{ config, lib, pkgs, ... }:
let
  cfg = config.myFeatures.browser;
in
{
  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      ];
    };

    programs.firefox = {
      enable = true;
      profiles.default = {
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            vimium
            bitwarden
            sponsorblock
          ];
        };
      };
    };
  };
}
