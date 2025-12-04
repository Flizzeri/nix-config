{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;   # name resolution for .local over IPv4
    openFirewall = true;
  };

  # Basic firewall on, SSH will be selectively opened in the ssh module.
  networking.firewall.enable = true;
}

