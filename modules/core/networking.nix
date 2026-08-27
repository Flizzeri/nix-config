{ config, pkgs, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Basic firewall on, SSH will be selectively opened in the ssh module.
  networking.firewall.enable = true;
}
