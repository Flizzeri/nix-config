{ config, pkgs, isDarwin ? false, isLinux ? false, ... }:

let
  # GNU toolchain utilities for macOS (BSD userland differs)
  gnuUserland = with pkgs; [
    coreutils
    gnused
    gawk
    gnutar
    gzip
    findutils
    diffutils
    gnugrep
  ];

  commonCli = with pkgs; [
    git
    gnumake

    ripgrep
    fd
    jq

    tree
    unzip
    zip
    wget
    curl
  ];
in
{
  home.packages =
    commonCli
    # On Linux these are usually already around.
    ++ (if isDarwin then gnuUserland else []);

  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  # Helpful: make man pages work nicely on macOS too
  programs.man.enable = true;
}

