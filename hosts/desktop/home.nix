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
      mode = "preferred";
      position = "3440x0";
      scale = 1.5;
      transform = 1;
    }
    {
      output = "";
      mode = "preferred";
      position = "auto";
      scale = 1;
    }
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1", default = true })
    hl.workspace_rule({ workspace = "1",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "2",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "3",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "4",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "5",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "6",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "7",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "8",  monitor = "DP-1"})
    hl.workspace_rule({ workspace = "9",  monitor = "DP-1"})
  '';

  programs.nh = {
    enable = true;
    flake = "/home/ntreml/code/nixos-config";
  };
}
