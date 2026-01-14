{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    # Needed for node-based CLIs below
    nodejs

    # Shell / misc
    shellcheck
    shfmt

    # Markdown
    nodePackages.markdownlint-cli2

    # TOML
    taplo

    # Prettier daemon (good for json/markdown via conform.nvim)
    nodePackages.prettier

    # YAML
    yamllint

    # Dockerfile
    hadolint
  ];
}

