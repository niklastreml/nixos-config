{ lib, ... }:
{
  options.myFeatures.stylix.enable = lib.mkEnableOption "stylix feature (packages + config)";
}
