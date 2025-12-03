{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # Basic firewall on, SSH will be selectively opened in the ssh module.
  networking.firewall.enable = true;
}

