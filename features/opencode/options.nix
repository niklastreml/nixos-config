{ lib, ... }:
{
  options.myFeatures.opencode.enable = lib.mkEnableOption "opencode feature (packages + config)";
}
