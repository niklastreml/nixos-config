{ lib, ... }:
{
  options.myFeatures.noctalia.enable = lib.mkEnableOption "noctalia feature (packages + config)";
}
