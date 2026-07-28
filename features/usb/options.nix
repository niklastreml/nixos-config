{ lib, ... }:
{
  options.myFeatures.usb.enable = lib.mkEnableOption "usb feature (packages + config)";
}
