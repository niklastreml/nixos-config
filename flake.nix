{
  description = "NixOS + home-manager config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
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
      # Args threaded into every home-manager module (both the NixOS-integrated
      # path and the standalone path). Modules ignore what they don't use.
      homeSpecialArgs = {
        inherit aislop nixvim work-skills;
      };

      # NUR is exposed as `pkgs.nur` via its overlay, so home-manager modules
      # that use `useGlobalPkgs` pick it up from the system package set.
      nurOverlayModule = {
        nixpkgs.overlays = [ nur.overlays.default ];
      };

      # Extra home-manager modules per host (stylix everywhere, noctalia on the
      # graphical hosts). Reused by both mkHost and mkHome so there is a single
      # source of truth.
      homeExtraModules = {
        laptop = [ stylix.homeModules.stylix noctalia.homeModules.default ];
        desktop = [ stylix.homeModules.stylix noctalia.homeModules.default ];
        vm = [ stylix.homeModules.stylix ];
        wsl = [ stylix.homeModules.stylix ];
        macbook = [ stylix.homeModules.stylix ];
      };

      # Build a NixOS system with home-manager integrated. `nixos-rebuild switch`
      # rolls out the system config and this host's home config together.
      mkHost =
        { hostname, system ? "x86_64-linux" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            nurOverlayModule
            ./nixos/hosts/${hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = homeSpecialArgs;
              home-manager.users.ntreml = {
                imports = homeExtraModules.${hostname} ++ [
                  ./home/hosts/${hostname}.nix
                ];
              };
            }
          ];
        };

      # Build a standalone home-manager configuration for non-NixOS machines
      # (Ubuntu, macOS) — reuses the same per-host home config.
      mkHome =
        { hostname, system ? "x86_64-linux" }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            config.permittedInsecurePackages = [ "electron-40.10.5" ];
            overlays = [ nur.overlays.default ];
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = homeSpecialArgs;
          modules = homeExtraModules.${hostname} ++ [
            ./home/hosts/${hostname}.nix
          ];
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
        # Standalone entry points. NixOS hosts are normally activated via
        # nixosConfigurations above; these are kept for parity and for
        # non-NixOS machines.
        "ntreml@laptop" = mkHome { hostname = "laptop"; };
        "ntreml@desktop" = mkHome { hostname = "desktop"; };
        "ntreml@vm" = mkHome { hostname = "vm"; };
        "ntreml@wsl" = mkHome { hostname = "wsl"; };
        "ntreml@macbook" = mkHome {
          hostname = "macbook";
          system = "aarch64-darwin";
        };
      };
    };
}
