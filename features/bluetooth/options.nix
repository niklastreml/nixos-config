{ lib, ... }:
{
  options.myFeatures.bluetooth.enable = lib.mkEnableOption "bluetooth feature (packages + config)";
}
