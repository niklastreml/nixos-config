{ lib, ... }:
{
  options.myFeatures.vm-guest-tools.enable = lib.mkEnableOption "QEMU guest tools (spice-vdagentd, qemu-guest-agent)";
}