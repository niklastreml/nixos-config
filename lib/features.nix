# Feature aggregation helper.
#
# A "feature" is a directory under ../features/<name>/ that may contain:
#   options.nix  - declares `myFeatures.<name>.enable` (imported into BOTH the
#                  NixOS and home-manager evaluations so a host can toggle it).
#   nixos.nix    - system-level config, gated on myFeatures.<name>.enable.
#   home.nix     - home-manager config, gated on myFeatures.<name>.enable.
#
# Every feature is imported into every host; the mkIf gates keep unused ones
# inert. Hosts opt in by setting `myFeatures.<name>.enable = true`.
{ lib, featuresDir }:
let
  names = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir featuresDir)
  );

  existing = paths: lib.filter builtins.pathExists paths;

  featureFile = name: layer: featuresDir + "/${name}/${layer}.nix";
  optionsFile = name: featureFile name "options";
in
{
  inherit names;

  # options.nix + nixos.nix for every feature.
  nixosModules = lib.concatMap (
    name: existing [ (optionsFile name) (featureFile name "nixos") ]
  ) names;

  # options.nix + home.nix for every feature. `linuxOnly` features contribute
  # only their options.nix when building a darwin host (their home.nix imports
  # upstream modules that aren't darwin-safe, e.g. noctalia).
  homeModules =
    { darwin ? false, linuxOnly ? [ ] }:
    lib.concatMap (
      name:
      if darwin && lib.elem name linuxOnly then
        existing [ (optionsFile name) ]
      else
        existing [ (optionsFile name) (featureFile name "home") ]
    ) names;
}
