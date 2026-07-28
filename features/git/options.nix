{ lib, ... }:
{
  options.myFeatures.git.enable = lib.mkEnableOption "git feature (packages + config)";
}
