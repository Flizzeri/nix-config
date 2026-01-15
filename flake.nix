{
  description = "Nix-based configuration (NixOS + nix-darwin + home-manager + devShells)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      flake-utils,
      ...
    }:
    let
      lib = nixpkgs.lib;

      usernameLinux = "Flizzeri";
      usernameDarwin = "filippolizzeri";

      mkNixos =
        hostname: system:
        lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${usernameLinux} = import ./home/common.nix;
              home-manager.extraSpecialArgs = {
                inherit usernameLinux usernameDarwin;
                isDarwin = false;
                isLinux = true;
              };
            }
          ];
        };

      mkDarwin =
        hostname: system:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./hosts/${hostname}/configuration.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${usernameDarwin} = import ./home/common.nix;
              home-manager.extraSpecialArgs = {
                inherit usernameLinux usernameDarwin;
                isDarwin = true;
                isLinux = false;
              };
            }
          ];
        };

    in
    {
      nixosConfigurations.workstation = mkNixos "workstation" "x86_64-linux";

      darwinConfigurations.macbook = mkDarwin "macbook" "x86_64-darwin";

      devShells = {
        x86_64-darwin =
          let
            pkgs = import nixpkgs {
              system = "x86_64-darwin";
              config.allowUnfree = true;
            };
          in
          {
            rust = import ./devshells/rust.nix { inherit pkgs; };
            web-ts = import ./devshells/web-ts.nix { inherit pkgs; };
            python = import ./devshells/python.nix { inherit pkgs; };
            go = import ./devshells/go.nix { inherit pkgs; };
            nix = import ./devshells/nix.nix { inherit pkgs; };
            adtk = import ./devshells/adtk.nix { inherit pkgs; };
            default = pkgs.mkShell {
              packages = with pkgs; [
                git
                ripgrep
                fd
                jq
              ];
            };
          };

        x86_64-linux =
          let
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          in
          {
            rust = import ./devshells/rust.nix { inherit pkgs; };
            web-ts = import ./devshells/web-ts.nix { inherit pkgs; };
            python = import ./devshells/python.nix { inherit pkgs; };
            go = import ./devshells/go.nix { inherit pkgs; };
            nix = import ./devshells/nix.nix { inherit pkgs; };
            adtk = import ./devshells/adtk.nix { inherit pkgs; };
            default = pkgs.mkShell {
              packages = with pkgs; [
                git
                ripgrep
                fd
                jq
              ];
            };
          };
      };

    };
}
