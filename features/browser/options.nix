{ lib, ... }:
{
  options.myFeatures.browser.enable = lib.mkEnableOption "browser feature (packages + config)";
}
