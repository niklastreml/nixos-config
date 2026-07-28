{ lib, ... }:
{
  options.myFeatures.fzf.enable = lib.mkEnableOption "fzf feature (packages + config)";
}
