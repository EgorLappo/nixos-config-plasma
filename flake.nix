{
  description = "egor's nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-flake = {
      url = github:helix-editor/helix;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server = { 
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, helix-flake, vscode-server, ... }:
    let
      system = "x86_64-linux";
    in
    rec {
      nixosConfigurations = {
        lab-dell = nixpkgs.lib.nixosSystem
          {
            system = system;

            pkgs = import nixpkgs {
              system = system;
              overlays = [
                helix-flake.overlays.default
              ];
              config = {
                allowUnfree = true;
              };
            };

            specialArgs = {
              inherit inputs;
            };

            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.egor = import home/home.nix;
              }
              vscode-server.nixosModules.default
              ({ config, pkgs, ... }: {
                services.vscode-server.enable = true;
              })
            ];
          };
      };
    };
}
