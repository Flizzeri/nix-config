{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    nodejs_24
    nodePackages_latest.pnpm
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
    nodePackages_latest.eslint
  ];
}

