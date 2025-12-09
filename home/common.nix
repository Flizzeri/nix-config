{ config, pkgs, usernameLinux, usernameDarwin, isDarwin, isLinux, ... }:

let
  username = if isDarwin then usernameDarwin else usernameLinux;
  homeDir  = if isDarwin then "/Users/${username}" else "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDir;

  home.stateVersion = "25.11";

  imports = [
    ./programs/shell.nix
    ./programs/git/default.nix
    ./programs/cli-tools/default.nix
    ./programs/neovim/default.nix
    ./programs/alacritty/default.nix
    ./programs/zellij/default.nix
  ];

  programs.home-manager.enable = true;
}

