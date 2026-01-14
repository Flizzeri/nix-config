{ pkgs }:
let
  base = import ./base.nix { inherit pkgs; };
in
pkgs.mkShell {
  inputsFrom = [ base ];

  packages = with pkgs; [
    nodejs_24
    nodePackages_latest.pnpm
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
    nodePackages_latest.eslint
    nodePackages_latest.eslint_d
  ];
}

