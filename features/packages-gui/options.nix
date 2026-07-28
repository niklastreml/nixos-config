{ lib, ... }:
{
  options.myFeatures.packages-gui.enable = lib.mkEnableOption "packages-gui feature (packages + config)";
}
