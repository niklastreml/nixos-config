{ lib, ... }:
{
  options.myFeatures.obsidian.enable = lib.mkEnableOption "obsidian feature (packages + config)";
}
