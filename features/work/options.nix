{ config, lib, ... }:
let
  # Every work sub-toggle defaults to the master `work.enable` switch, so
  # `myFeatures.work.enable = true` turns on everything, while individual
  # concerns can still be enabled on their own on a non-work host
  # (e.g. `myFeatures.work.git.enable = true` on a personal laptop).
  sub =
    desc:
    lib.mkOption {
      type = lib.types.bool;
      default = config.myFeatures.work.enable;
      defaultText = lib.literalExpression "config.myFeatures.work.enable";
      description = desc;
    };
in
{
  options.myFeatures.work = {
    enable = lib.mkEnableOption "work configuration (master switch for all work.* sub-options)";

    packages.enable = sub "Work toolchain (Go, Python, C, uv, gomplate) and GOPRIVATE.";
    git.enable = sub "Telekom git identity for repositories under ~/work/.";
    glab.enable = sub "GitLab CLI (glab).";
    skills.enable = sub "Work skills from the internal GitLab, merged into opencode.";
    telecontext.enable = sub "telecontext MCP server for opencode.";
    opencode.enable = sub "Allow opencode to read ~/work.";
    network.enable = sub "Telekom corporate proxy, nameservers and SSH ProxyCommand.";
  };
}
