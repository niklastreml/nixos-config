{ lib, ... }:
{
  options.myFeatures.fish.enable = lib.mkEnableOption "fish feature (packages + config)";
}
