{ lib, ... }:
{
  options.myFeatures.bitwarden.enable = lib.mkEnableOption "bitwarden feature (packages + config)";
}
