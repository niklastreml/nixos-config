{ lib, ... }:
{
  options.myFeatures.scripts.enable = lib.mkEnableOption "scripts feature (packages + config)";
}
