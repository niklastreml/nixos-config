{ lib, ... }:
{
  options.myFeatures.vscode.enable = lib.mkEnableOption "vscode feature (packages + config)";
}
