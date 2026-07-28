{ lib, ... }:
{
  options.myFeatures.direnv.enable = lib.mkEnableOption "direnv feature (packages + config)";
}
