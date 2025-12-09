{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    python312
    python312Packages.pip
    python312Packages.virtualenv
    ruff
    pyright
  ];
}

