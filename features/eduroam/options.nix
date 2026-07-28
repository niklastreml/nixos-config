{ lib, ... }:
{
  options.myFeatures.eduroam.enable = lib.mkEnableOption "eduroam feature (packages + config)";
}
