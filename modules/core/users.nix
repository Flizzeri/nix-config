{ config, pkgs, ... }:

{
  users.users.Flizzeri = {
    isNormalUser = true;
    description = "Flizzeri";
    shell = pkgs.zsh;

    # Sudo + NetworkManager control
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    { config, pkgs, ... }:

    openssh.authorizedKeys.keyFiles = [
        ../../keys/authorized/macbook_workstation_flizzeri.pub
    ];

    initialPassword = "changeme";
  };

  security.sudo.enable = true;
}

