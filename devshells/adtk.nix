{ pkgs }:
let
  nodeShell = import ./web-ts.nix { inherit pkgs; };
  rustShell = import ./rust.nix { inherit pkgs; };
in
pkgs.mkShell {
  inputsFrom = [
    nodeShell
    rustShell
  ];
}
