{
  config,
  lib,
  pkgs,
  aislop,
  ...
}:
let
  cfg = config.myFeatures.opencode;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bun
    ];

    home.file.".config/opencode/skills".source = "${aislop}/skills";

    programs.opencode = {
    enable = true;
    settings.autoupdate = false;
    settings.permission = {
      # Reading files outside the current workspace normally prompts via the
      # `external_directory` guard (which defaults to "ask"). Allow the trees
      # we routinely browse so reads don't interrupt.
      external_directory = {
        "/home/ntreml/code/**" = "allow";
        "/nix/store/**" = "allow";
      };

      read = {
        "*" = "allow";
        "*.env" = "deny";
        "*.env.*" = "deny";
        "*.env.example" = "allow";
      };

      # `external_directory` only lifts the out-of-workspace guard; the normal
      # tool permissions still apply. Reads are fine, but writes must ask and
      # the read-only nix store must never be edited.
      edit = {
        "/nix/store/**" = "deny";
        "/home/ntreml/code/**" = "ask";
        "/home/ntreml/work/**" = "ask";
      };

      # Kubernetes-adjacent tooling always asks, except clearly read-only
      # verbs. Commands that surface secret material ask again. Patterns are
      # matched last-wins; the attrset is serialized alphabetically, so the
      # specific "kubectl get *" lands after the broad "kubectl *".
      bash = {
        "kubectl *" = "ask";
        "kubectl api-resources*" = "allow";
        "kubectl api-versions*" = "allow";
        "kubectl cluster-info*" = "allow";
        "kubectl config get-*" = "allow";
        "kubectl config view*" = "allow";
        "kubectl describe *" = "allow";
        "kubectl describe secret*" = "ask";
        "kubectl explain *" = "allow";
        "kubectl get *" = "allow";
        "kubectl get secret*" = "ask";
        "kubectl logs *" = "allow";
        "kubectl top *" = "allow";
        "kubectl version*" = "allow";

        "helm *" = "ask";
        "helm history*" = "allow";
        "helm list*" = "allow";
        "helm show*" = "allow";
        "helm status*" = "allow";
        "helm version*" = "allow";

        "k9s*" = "ask";
        "kubectx*" = "ask";
        "kubens*" = "ask";
        "argocd *" = "ask";
        "flux *" = "ask";
        "kustomize *" = "ask";
        "oc *" = "ask";
        "rancher *" = "ask";
        "talosctl *" = "ask";
      };
    };
    settings.mcp = {
      context7 = {
        type = "remote";
        url = "https://mcp.context7.com/mcp";
      };
      exa = {
        type = "remote";
        url = "https://mcp.exa.ai/mcp";
      };
      morph = {
        type = "local";
        command = [
          "bunx"
          "@morphllm/morphmcp"
        ];
        environment = {
          ENABLED_TOOLS = "warp_grep";
        };
      };
      nixos = {
        type = "local";
        command = [
          "nix"
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };
    };

    agents = {
      docs = builtins.readFile ./docs.md;
      review = builtins.readFile ./review.md;
      security-review = builtins.readFile ./security-review.md;
    };

  };
  };
}
