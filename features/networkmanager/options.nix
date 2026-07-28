{ lib, ... }:
{
  options.myFeatures.networkmanager.enable = lib.mkEnableOption "networkmanager feature (packages + config)";
}
