{ lib, ... }:
{
  options.myFeatures.hyprland.enable = lib.mkEnableOption "hyprland feature (packages + config)";
}
