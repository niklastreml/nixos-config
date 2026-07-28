{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Enable networking
  networking.networkmanager.enable = true;
}
