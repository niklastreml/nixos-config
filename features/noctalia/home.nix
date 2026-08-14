{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.myFeatures.noctalia;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf cfg.enable {
    home.file.".face" = {
      source = ../../assets/face.png; # Path relative to your home.nix
    };

    programs.noctalia = {
      enable = true;

      settings = {
        desktop_widgets = {
          enabled = false;
        };
        # ---- Wallpaper (disabled — Stylix manages it) ----
        wallpaper.enabled = false;

        location.auto_locate = true;
        shell.avatar_path = "~/.face";

        # ---- Bar Configuration ----
        bar.order = [ "main" ];

        bar.main = {
          position = "top";
          enabled = true;
          capsule = true;
          start = [
            "control-center"
            "launcher"
            "taskbar"
            "media"
            "audio_visualizer"
            "active_window"
          ];
          center = [
            "notifications"
            "clipboard"
            "clock"
            "caffeine"
            "wvkbd"
          ];
          end = [
            "tray"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "power_profile"
            "battery"

            "spacer"

            "session"
          ];
        };

        brightness = {
          enable_ddcutil = true;
        };

        idle = {
          pre_action_fade_seconds = 2.0;
          behavior = {
            lock = {
              enabled = true;
              timeout = 300;
              action = "lock";
            };
            screen-off = {
              enabled = true;
              timeout = 360;
              action = "screen_off";
            };
          };
        };

        # ---- Widget: Power Profile (cycles on click) ----
        widget.power_profile = {
          type = "power_profile";
        };

        widget.media = {
          hide_when_no_media = true;
        };

        # ---- Widget: On-screen Keyboard Toggle ----
        widget.wvkbd = {
          type = "custom_button";
          glyph = "keyboard";
          tooltip = "Toggle on-screen keyboard";
          actions.left = "pkill wvkbd-mobintl 2>/dev/null || setsid wvkbd-mobintl &";
        };

        widget.taskbar = {
          workspace_group_capsule = false;
          group_by_workspace = true;
          show_all_outputs = true;
          group_single_icon_per_app = true;
          workspace_label_placement = "inside";
          show_active_indicator = false;
        };

        widget.brightness = {
          show_label = false;
        };

        widget.volume = {
          show_label = false;
        };

      };
    };
  };
}
