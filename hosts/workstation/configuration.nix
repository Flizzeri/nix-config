{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core/boot.nix
    ../../modules/core/nix.nix
    ../../modules/core/locale.nix
    ../../modules/core/networking.nix
    ../../modules/core/secrets.nix
    ../../modules/core/users.nix

    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/audio.nix

    ../../modules/desktop/plasma.nix
    ../../modules/desktop/fonts.nix

    ../../modules/services/ssh.nix
  ];

  networking.hostName = "workstation";

  # Minimal base packages; everything else later via home-manager.
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
  ];

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
