{ ... }: {
  home.file.".face" = {
    source = ../assets/face.png; # Path relative to your home.nix
  };

  programs.noctalia = {
    enable = true;

    settings = {
      services.notifications.monitor = "";
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
        start = [
          "control-center"
          "launcher"
          "workspaces"
          "media"
        ];
        center = [ "active_window" ];
        end = [
          "tray"
          "notifications"
          "clipboard"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "power_profile"
          "wvkbd"
          "battery"
          "session"
          "clock"
        ];
      };

      # ---- Widget: Power Profile (cycles on click) ----
      widget.power_profile = {
        type = "power_profile";
      };

      # ---- Widget: On-screen Keyboard Toggle ----
      widget.wvkbd = {
        type = "custom_button";
        glyph = "keyboard";
        tooltip = "Toggle on-screen keyboard";
        command = "pkill wvkbd-mobintl 2>/dev/null || setsid wvkbd-mobintl &";
      };
    };
  };
}
