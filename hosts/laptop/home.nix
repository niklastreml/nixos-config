{ ... }:
{
  # Host-specific home tweaks. Feature toggles are set at the NixOS level in
  # ./nixos.nix and bridged into home-manager by the flake.
  wayland.windowManager.hyprland.settings.monitor = {
    output = "";
    mode = "preferred";
    position = "auto";
    scale = 2;
  };

  programs.nh = {
    enable = true;
    flake = "/home/ntreml/code/nixos-config";
  };
}
