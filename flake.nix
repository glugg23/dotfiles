{
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };
  outputs =
    inputs@{
      self,
      nixpkgs-unstable,
      home-manager,
      nixpkgs-darwin,
      nix-darwin,
      nixos-hardware,
      disko,
      ...
    }:
    {
      nixosConfigurations.nixos-laptop = nixpkgs-unstable.lib.nixosSystem {
        modules = [
          ./modules/hosts/nixos-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users.max = ./modules/hosts/nixos-laptop/home.nix;
            };
          }
          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };

      nixosConfigurations.nixos-vm = nixpkgs-unstable.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./modules/hosts/nixos-vm/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users.max = ./modules/hosts/nixos-vm/home.nix;
            };
          }
        ];
      };

      formatter.x86_64-linux = nixpkgs-unstable.legacyPackages.x86_64-linux.nixfmt-tree;
      formatter.aarch64-darwin = nixpkgs-darwin.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
