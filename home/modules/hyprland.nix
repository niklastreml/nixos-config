{ pkgs, lib, ... }: {
  home.packages = [ pkgs.rot8 ];
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings = {
      mod._var = "SUPER";

      env = [
        {
          _args = [
            "LIBVA_DRIVER_NAME"
            "nvidia"
          ];
        }
        {
          _args = [
            "__GLX_VENDOR_LIBRARY_NAME"
            "nvidia"
          ];
        }
        {
          _args = [
            "ELECTRON_OZONE_PLATFORM_HINT"
            "auto"
          ];
        }
      ];

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 2;
          bezier = "default";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 7;
          bezier = "default";
          style = "popin 80%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 7;
          bezier = "default";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 1;
          bezier = "default";
        }
      ];

      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      bind = [
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + RETURN\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"ghostty\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + B\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"brave --disable-features=WaylandWpColorManagerV1\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + O\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"obsidian\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + E\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"nautilus\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + D\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg panel-toggle launcher\")")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + p"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprpicker -a -q\")")
          ];
        }
        {
          _args = [
            "KP_Divide"
            (lib.generators.mkLuaInline "hl.dsp.send_shortcut({ mods = \"CTRL SHIFT\", key = \"D\", window = \"class:^(vesktop)$\" })")
          ];
        }
        {
          _args = [
            "KP_Multiply"
            (lib.generators.mkLuaInline "hl.dsp.send_shortcut({ mods = \"CTRL SHIFT\", key = \"M\", window = \"class:^(vesktop)$\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + Q\"")
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + CTRL + SHIFT + E\"")
            (lib.generators.mkLuaInline "hl.dsp.exit()")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + S\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"togglesplit\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + F\"")
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({ mode = \"fullscreen\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + F\"")
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({ mode = \"maximized\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + V\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg panel-toggle clipboard\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + CTRL + L\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg session lock\")")
          ];
        }
        {
          _args = [
            "switch:Lid Switch"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"systemctl hibernate\")")
            (lib.generators.mkLuaInline "{ locked = true }")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + left\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"l\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + right\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"r\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + up\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"u\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + down\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"d\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + H\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"l\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + L\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"r\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + K\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"u\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + J\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"d\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 1\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 1 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 2\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 2 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 3\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 3 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 4\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 4 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 5\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 5 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 6\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 6 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 7\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 7 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 8\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 8 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 9\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 9 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + 0\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 10 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 1\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 1 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 2\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 2 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 3\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 3 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 4\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 4 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 5\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 5 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 6\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 6 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 7\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 7 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 8\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 8 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 9\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 9 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + 0\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 10 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + mouse_down\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"e+1\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + mouse_up\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"e-1\" })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + mouse:272\"")
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
          ];
        }
        {
          _args = [
            "SUPER + CTRL + mouse:272"
            (lib.generators.mkLuaInline "hl.dsp.window.resize()")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + s"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg screenshot-region\")")
          ];
        }
        {
          _args = [
            "XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg volume-up\")")
            (lib.generators.mkLuaInline "{ locked = true, repeating = true }")
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg volume-down\")")
            (lib.generators.mkLuaInline "{ locked = true, repeating = true }")
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg volume-mute\")")
            (lib.generators.mkLuaInline "{ locked = true, repeating = true }")
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg mic-mute\")")
            (lib.generators.mkLuaInline "{ locked = true, repeating = true }")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg brightness-up\")")
            (lib.generators.mkLuaInline "{ locked = true, repeating = true }")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg brightness-down\")")
            (lib.generators.mkLuaInline "{ locked = true, repeating = true }")
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg media next\")")
            (lib.generators.mkLuaInline "{ locked = true }")
          ];
        }
        {
          _args = [
            "XF86AudioPause"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg media toggle\")")
            (lib.generators.mkLuaInline "{ locked = true }")
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg media toggle\")")
            (lib.generators.mkLuaInline "{ locked = true }")
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"noctalia msg media previous\")")
            (lib.generators.mkLuaInline "{ locked = true }")
          ];
        }
      ];

      window_rule = [
        {
          name = "noctalia-settings";
          match = {
            class = "dev.noctalia.Noctalia";
          };
          float = true;
          size = "1080 920";
        }
        {
          match = {
            class = ".*";
          };
          suppress_event = "maximize";
        }
        {
          match = {
            class = "^$";
            title = "^$";
            xwayland = 1;
          };
          no_focus = true;
          float = true;
          fullscreen = false;
          pin = false;
        }
      ];

      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                hl.exec_cmd("noctalia")
                hl.dispatch(hl.dsp.focus({ workspace = "1" }))
              end
            '')
          ];
        }
      ];

      config = {
        cursor = {
          no_hardware_cursors = 1;
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 1;
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
        };
        decoration = {
          rounding = 5;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            # color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        animations = {
          enabled = true;
        };
        dwindle = {
          preserve_split = true;
        };
        master = {
          new_status = "master";
        };
        input = {
          kb_layout = "eu";
          kb_variant = "";
          kb_model = "";
          kb_options = "ctrl:nocaps";
          kb_rules = "";
          follow_mouse = 1;
          accel_profile = "flat";
          sensitivity = 0.0;
          scroll_factor = 0.5;
          touchpad = {
            natural_scroll = true;
          };
        };
      };
    };
  };
}
