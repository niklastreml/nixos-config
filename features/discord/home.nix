{ config, lib, ... }:
let
  cfg = config.myFeatures.discord;
in
{
  config = lib.mkIf cfg.enable {
    programs.discord.enable = true;
  };
}
