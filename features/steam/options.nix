{ lib, ... }:
{
  options.myFeatures.steam.enable = lib.mkEnableOption "steam feature (packages + config)";
}
