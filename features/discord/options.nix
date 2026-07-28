{ lib, ... }:
{
  options.myFeatures.discord.enable = lib.mkEnableOption "discord feature (packages + config)";
}
