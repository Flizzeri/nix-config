{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;

    settings = {
      # Keys only.
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # Don’t allow root login.
      PermitRootLogin = "no";

      X11Forwarding = false;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}

