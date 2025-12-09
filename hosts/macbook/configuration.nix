{ pkgs, lib, ... }:

{
  # Basic system settings for macOS
  networking.hostName = "macbook";


  users.users.filippolizzeri = {
    home = "/Users/filippolizzeri";
  };

  nix.enable = false;

  # Ensure the shell exists; macOS default is zsh already
  programs.zsh.enable = true;

  # Useful base packages on macOS too
  environment.systemPackages = with pkgs; [
    git
  ];

  system.stateVersion = 5;
}

