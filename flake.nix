{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.framework-amd-ai-300-series
      ];
    };
  };
}
