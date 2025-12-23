{ config, pkgs, lib, ... }:

let
  pubKey = lib.strings.trimString (builtins.readFile ../../keys/authorized/macbook_workstation_flizzeri.pub);
in
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

  # Install authorized key for that user
  users.users.Flizzeri.openssh.authorizedKeys.keys = [ pubKey ];

  # Allow inbound SSH on the LAN
  networking.firewall.allowedTCPPorts = [ 22 ];
}

