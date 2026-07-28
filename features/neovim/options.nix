{ lib, ... }:
{
  options.myFeatures.neovim.enable = lib.mkEnableOption "neovim feature (packages + config)";
}
