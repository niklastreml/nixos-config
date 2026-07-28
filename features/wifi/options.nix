{ lib, ... }:
{
  options.myFeatures.wifi.enable = lib.mkEnableOption "wifi feature (packages + config)";
}
