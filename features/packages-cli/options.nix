{ lib, ... }:
{
  options.myFeatures.packages-cli.enable = lib.mkEnableOption "packages-cli feature (packages + config)";
}
