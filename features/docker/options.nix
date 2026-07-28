{ lib, ... }:
{
  options.myFeatures.docker.enable = lib.mkEnableOption "docker feature (packages + config)";
}
