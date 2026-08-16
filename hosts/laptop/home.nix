{ ... }:
{
  # Host-specific home tweaks. Feature toggles are set at the NixOS level in
  # ./nixos.nix and bridged into home-manager by the flake.

  wayland.windowManager.hyprland.settings.device = [
    {
      name = "elan2513:00-04f3:422a";
      output = "eDP-1";
    }
  ];

  programs.nh = {
    enable = true;
    flake = "/home/ntreml/code/nixos-config";
  };
}
