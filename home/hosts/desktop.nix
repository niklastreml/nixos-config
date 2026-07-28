{ ... }: {
  imports = [
    ../modules/base.nix
    ../modules/bitwarden.nix
    ../modules/browser.nix
    ../modules/btop.nix
    ../modules/discord.nix
    ../modules/eduroam.nix
    ../modules/fish.nix
    ../modules/fzf.nix
    ../modules/git.nix
    ../modules/hyprland.nix
    ../modules/k9s.nix
    ../modules/misc-configs.nix
    ../modules/neovim.nix
    ../modules/noctalia.nix
    ../modules/opencode
    ../modules/packages-cli.nix
    ../modules/packages-gui.nix
    ../modules/obsidian.nix
    ../modules/scripts.nix
    ../modules/services.nix
    ../modules/starship.nix
    ../modules/stylix.nix
    ../modules/tmux.nix
    ../modules/usb.nix
    ../modules/vscode.nix
  ];

  wayland.windowManager.hyprland = {

    settings.monitor = [
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
    extraConfig = ''
      hl.workspace_rule({
        workspace = "9",
        monitor = "HDMI-A-1",
        workspace = "9",
        default = true,
      })
    '';
  };

  programs.nh = {
    enable = true;
    # Sets the directory path for the FLAKE environment variable
    homeFlake = "/home/ntreml/code/nixos-config#homeConfigurations.\"ntreml@desktop\"";
  };
}
