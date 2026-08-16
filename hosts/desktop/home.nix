{ ... }:
{
  # Host-specific home tweaks. Feature toggles are set at the NixOS level in
  # ./nixos.nix and bridged into home-manager by the flake.

  programs.nh = {
    enable = true;
    flake = "/home/ntreml/code/nixos-config";
  };
}
