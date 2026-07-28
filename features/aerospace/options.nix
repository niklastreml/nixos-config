{ lib, ... }:
{
  options.myFeatures.aerospace.enable = lib.mkEnableOption "aerospace feature (packages + config)";
}
