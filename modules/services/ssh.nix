{
  config,
  pkgs,
  lib,
  ...
}:

let
  pubKey = lib.strings.removeSuffix "\n" (
    builtins.readFile ../../keys/hosts/workstation_flizzeri.pub
  );
in
{
  services.openssh = {
    enable = true;

    openFirewall = true;

    settings = {
      # Keys only.
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # Don’t allow root login.
      PermitRootLogin = "no";

      X11Forwarding = false;

      AllowUsers = [ "Flizzeri" ];
    };
  };

  users.users.Flizzeri.openssh.authorizedKeys.keys = [ pubKey ];
}
