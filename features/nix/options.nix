{ lib, ... }:
{
  options.myFeatures.nix.enable = lib.mkEnableOption "nix feature (packages + config)";
}
