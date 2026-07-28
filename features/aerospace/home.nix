{ config, lib, ... }:
let
  cfg = config.myFeatures.aerospace;
in
{
  config = lib.mkIf cfg.enable {
    home.file.".config/aerospace/aerospace.toml".source = ./aerospace.toml;
  };
}
