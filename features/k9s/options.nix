{ lib, ... }:
{
  options.myFeatures.k9s.enable = lib.mkEnableOption "k9s feature (packages + config)";
}
