{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/nixos-laptop
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.max = ./hosts/nixos-laptop/home.nix;
          };
        }
        nixos-hardware.nixosModules.framework-amd-ai-300-series
      ];
    };
  };
}
