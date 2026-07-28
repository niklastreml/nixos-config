{
  description = "NixOS + home-manager config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aislop = {
      url = "github:mattpocock/skills";
      flake = false;
    };

    work-skills = {
      url = "git+ssh://git@gitlab.devops.telekom.de/caas/agentic/skills.git";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  outputs =
    { self, nixpkgs, home-manager, nur, nixvim, stylix, noctalia, aislop, work-skills, ... }@inputs:
    let
      lib = nixpkgs.lib;

      # Feature registry. Each directory under ./features is a self-contained
      # feature bundling its NixOS and/or home-manager layers behind a single
      # `myFeatures.<name>.enable` toggle. Every feature is imported into every
      # host; the mkIf gates keep unused ones inert.
      features = import ./lib/features.nix {
        inherit lib;
        featuresDir = ./features;
      };

      # Features whose home.nix imports an upstream module that isn't
      # darwin-safe. On darwin hosts only their options.nix is loaded.
      linuxOnlyFeatures = [ "noctalia" ];

      # Args threaded into every home-manager module (both the NixOS-integrated
      # path and the standalone path). Modules ignore what they don't use.
      homeSpecialArgs = {
        inherit inputs aislop nixvim work-skills;
      };

      # Overlays applied to every host's package set. NUR is exposed as
      # `pkgs.nur` so home-manager modules using `useGlobalPkgs` pick it up.
      mkOverlays =
        system:
        [
          nur.overlays.default
        ];

      # Build a NixOS system with home-manager integrated. `nixos-rebuild switch`
      # rolls out the system config and this host's home config together.
      mkHost =
        { hostname, system ? "x86_64-linux" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.overlays = mkOverlays system; }
            ./system/core.nix
            ./hosts/${hostname}/nixos.nix
            home-manager.nixosModules.home-manager
            (
              { config, ... }:
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = homeSpecialArgs;
                home-manager.users.ntreml = {
                  imports =
                    [ ./home/core.nix ]
                    ++ (features.homeModules { })
                    ++ [ ./hosts/${hostname}/home.nix ];
                  # Bridge the NixOS-level feature toggles into home-manager so a
                  # single `myFeatures.<name>.enable` drives both layers.
                  myFeatures = config.myFeatures;
                };
              }
            )
          ]
          ++ features.nixosModules;
        };

      # Build a standalone home-manager configuration for non-NixOS machines
      # (macOS). Feature toggles are set directly in the host's home.nix.
      mkHome =
        { hostname, system ? "x86_64-linux" }:
        let
          darwin = lib.hasSuffix "darwin" system;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            config.permittedInsecurePackages = [ "electron-40.10.5" ];
            overlays = mkOverlays system;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = homeSpecialArgs;
          modules =
            [ ./home/core.nix ]
            ++ (features.homeModules {
              inherit darwin;
              linuxOnly = linuxOnlyFeatures;
            })
            ++ [ ./hosts/${hostname}/home.nix ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkHost { hostname = "laptop"; };
        desktop = mkHost { hostname = "desktop"; };
        vm = mkHost { hostname = "vm"; };
        wsl = mkHost { hostname = "wsl"; };
      };

      homeConfigurations = {
        # Standalone entry point for the non-NixOS (darwin) machine. The NixOS
        # hosts are activated via nixosConfigurations above.
        "ntreml@macbook" = mkHome {
          hostname = "macbook";
          system = "aarch64-darwin";
        };
      };
    };
}
