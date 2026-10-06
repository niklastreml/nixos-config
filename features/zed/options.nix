{ lib, ... }:
{
  options.myFeatures.zed.enable = lib.mkEnableOption "zed feature (packages + config)";
}
