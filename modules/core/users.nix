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

    initialPassword = "changeme";
  };

  security.sudo.enable = true;
}

