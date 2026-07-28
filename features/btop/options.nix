{ lib, ... }:
{
  options.myFeatures.btop.enable = lib.mkEnableOption "btop feature (packages + config)";
}
