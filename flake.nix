{
  description = "Nix based configuration for my dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations.workstation = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/workstation/configuration.nix
        ];
      };
    };
}

