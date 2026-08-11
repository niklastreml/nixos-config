{ ... }:
{
  # Host-specific home tweaks. Feature toggles are set at the NixOS level in
  # ./nixos.nix and bridged into home-manager by the flake.
  wayland.windowManager.hyprland.settings.monitor = [
    {
      output = "eDP-1";
      mode = "2880x1800@120";
      position = "0x0";
      scale = 2;
    }
    {
      output = "";
      mode = "preferred";
      position = "auto";
      scale = 1;
    }
  ];

  programs.nh = {
    enable = true;
    flake = "/home/ntreml/code/nixos-config";
  };
}
