{ lib, ... }:
{
  options.myFeatures.starship.enable = lib.mkEnableOption "starship feature (packages + config)";
}
