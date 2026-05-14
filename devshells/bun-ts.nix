{ pkgs }:
let
  base = import ./base.nix { inherit pkgs; };
in
pkgs.mkShell {
  inputsFrom = [ base ];

  packages = with pkgs; [
    bun
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    biome
  ];
}
