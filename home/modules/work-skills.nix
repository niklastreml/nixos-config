{
  lib,
  aislop,
  work-skills,
  ...
}:

# The opencode module symlinks the whole personal skills directory (`aislop`)
# into `.config/opencode/skills`. A directory symlink can't have extra entries
# merged into it, so here we disable that whole-directory symlink and instead
# symlink each skill individually. That lets us drop the work skills (from the
# internal GitLab repo) into the same folder alongside the personal ones.
let
  # Skills may live at the repo root or under a `skills/` subdirectory.
  skillRoot =
    repo: if builtins.pathExists "${repo}/skills" then "${repo}/skills" else "${repo}";

  # Only symlink actual skill directories, ignoring dotfiles and loose files
  # (README, CI config, etc.).
  skillDirs =
    repo:
    let
      root = skillRoot repo;
      entries = builtins.readDir root;
    in
    lib.filterAttrs (
      name: type: type == "directory" && !(lib.hasPrefix "." name)
    ) entries;

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
  home.file =
    {
      # Replace the whole-directory symlink from modules/opencode.
      ".config/opencode/skills".enable = lib.mkForce false;
    }
    // (mkLinks ".config/opencode/skills" aislop)
    // (mkLinks ".config/opencode/skills" work-skills);
}
