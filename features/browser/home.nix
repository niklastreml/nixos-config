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

    # stylix firefox theming targets this profile. Lives here (rather than in the
    # stylix feature) because it is an HM-only option that the NixOS stylix
    # module does not copy down to home-manager.
    stylix.targets.firefox.profileNames = [ "default" ];
  };
}
