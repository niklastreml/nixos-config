{ ... }:
{
  # Host-specific home tweaks. Feature toggles are set at the NixOS level in
  # ./nixos.nix and bridged into home-manager by the flake.

  wayland.windowManager.hyprland.settings.monitor = [
    {
      output = "DP-1";
      mode = "3440x1440@120";
      position = "0x0";
      scale = 1;
    }
    {
      output = "HDMI-A-1";
      mode = "1920x1080@60";
      position = "3440x0";
      scale = 1;
      transform = 1;
    }
  ];

  programs.nh = {
    enable = true;
    flake = "/home/ntreml/code/nixos-config";
  };
}
