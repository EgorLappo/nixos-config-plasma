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

    emacs-flake = {
      url = github:nix-community/emacs-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, helix-flake, emacs-flake, ... }:
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
                emacs-flake.overlays.default
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
            ];
          };
      };
    };
}
