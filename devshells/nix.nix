{ pkgs }:
let
  base = import ./base.nix { inherit pkgs; };
in
pkgs.mkShell {
  inputsFrom = [ base ];

  packages = with pkgs; [
    # Nix tooling
    statix
    nil
    nixfmt

    # Lua tooling
    lua-language-server
    stylua
    luaPackages.luacheck
  ];
}

