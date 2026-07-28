{ lib, ... }:
{
  options.myFeatures.tmux.enable = lib.mkEnableOption "tmux feature (packages + config)";
}
