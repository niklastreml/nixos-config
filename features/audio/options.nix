{ lib, ... }:
{
  options.myFeatures.audio.enable = lib.mkEnableOption "audio feature (packages + config)";
}
