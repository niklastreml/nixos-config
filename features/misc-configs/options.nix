{ lib, ... }:
{
  options.myFeatures.misc-configs.enable = lib.mkEnableOption "misc-configs feature (packages + config)";
}
