{ config, lib, ... }:
let
  cfg = config.myFeatures.zed;
in
{
  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      userKeymaps = [
        {
          use_key_equivalents = true;
          bindings = {
            f11 = "debugger::StepInto";
            f10 = "debugger::StepOver";
          };
        }
      ];
      userSettings = {
        session.trust_all_worktrees = true;
        vim_mode = true;
        base_keymap = "VSCode";
        disable_ai = true;
        telemetry = {
          diagnostics = true;
          metrics = true;
        };
      };
      extensions = [
        "odin"
        "nix"
      ];
    };
  };
}
