{ config, lib, ... }:
let
  cfg = config.myFeatures.misc-configs;
in
{
  config = lib.mkIf cfg.enable {
    # xdg.configFile."jj/config.toml".source = ./jj-config.toml;
    # xdg.configFile."k9s/config.yaml".source = ./k9s-config.yaml;
    # xdg.configFile."walker/config.toml".source = ./walker-config.toml;
    # xdg.configFile."brave-flags.conf".source = ./brave-flags.conf;
  };
}
