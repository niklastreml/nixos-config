{
  config,
  lib,
  pkgs,
  aislop,
  work-skills,
  ...
}:
let
  cfg = config.myFeatures.work;

  # ── Work skills (work.skills.enable) ────────────────────────────────
  # The opencode feature symlinks the whole personal skills directory
  # (`aislop`) into `.config/opencode/skills`. A directory symlink can't have
  # extra entries merged into it, so here we disable that whole-directory
  # symlink and instead symlink each skill individually. That lets us drop the
  # work skills (from the internal GitLab repo) into the same folder alongside
  # the personal ones.

  # Skills may live at the repo root or under a `skills/` subdirectory.
  skillRoot = repo: if builtins.pathExists "${repo}/skills" then "${repo}/skills" else "${repo}";

  # Only symlink actual skill directories, ignoring dotfiles and loose files
  # (README, CI config, etc.).
  skillDirs =
    repo:
    let
      root = skillRoot repo;
      entries = builtins.readDir root;
    in
    lib.filterAttrs (name: type: type == "directory" && !(lib.hasPrefix "." name)) entries;

  # Build home.file entries mapping <targetDir>/<skill> -> <repo>/.../<skill>.
  mkLinks =
    targetDir: repo:
    let
      root = skillRoot repo;
    in
    lib.mapAttrs' (
      name: _: lib.nameValuePair "${targetDir}/${name}" { source = "${root}/${name}"; }
    ) (skillDirs repo);
in
{
  config = lib.mkMerge [
    # ── Work toolchain (work.packages.enable) ─────────────────────────
    (lib.mkIf cfg.packages.enable {
      home.packages = with pkgs; [
        gcc
        gnumake
        go
        python315
        uv
        gomplate
      ];
      home.sessionVariables.GOPRIVATE = "gitlab.devops.telekom.de/*";
    })

    # ── Work git identity (work.git.enable) ───────────────────────────
    (lib.mkIf cfg.git.enable {
      programs.git.includes = [
        {
          condition = "gitdir:~/work/";
          contents = {
            user.email = "4383-niklas.treml@users.noreply.gitlab.devops.telekom.de";
          };
        }
      ];
    })

    # ── GitLab CLI (work.glab.enable) ─────────────────────────────────
    (lib.mkIf cfg.glab.enable {
      home.packages = [ pkgs.glab ];
    })

    # ── Work skills (work.skills.enable) ──────────────────────────────
    (lib.mkIf cfg.skills.enable {
      home.file =
        {
          # Replace the whole-directory symlink from the opencode feature.
          ".config/opencode/skills".enable = lib.mkForce false;
        }
        // (mkLinks ".config/opencode/skills" aislop)
        // (mkLinks ".config/opencode/skills" work-skills);
    })

    # ── telecontext MCP server (work.telecontext.enable) ──────────────
    (lib.mkIf cfg.telecontext.enable {
      programs.opencode.settings.mcp.telecontext = {
        type = "remote";
        url = "https://telecontext.telekom.de/mcp";
      };
    })

    # ── opencode ~/work access (work.opencode.enable) ─────────────────
    (lib.mkIf cfg.opencode.enable {
      programs.opencode.settings.permission.read."/home/ntreml/work/*" = "allow";
      # Don't prompt on out-of-workspace reads under ~/work (edits still ask,
      # see the edit rules in the opencode feature).
      programs.opencode.settings.permission.external_directory."/home/ntreml/work/**" =
        "allow";
    })
  ];
}
