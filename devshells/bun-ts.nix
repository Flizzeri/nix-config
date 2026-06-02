{ pkgs }:
let
  base = import ./base.nix { inherit pkgs; };
in
pkgs.mkShell {
  inputsFrom = [ base ];

  packages = with pkgs; [
    bun
    biome
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    postgresql.out
    pgformatter
  ];
}
