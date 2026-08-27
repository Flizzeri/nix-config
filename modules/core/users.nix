{
  config,
  pkgs,
  usernameLinux,
  ...
}:

{
  users.users.${usernameLinux} = {
    isNormalUser = true;
    description = usernameLinux;
    shell = pkgs.zsh;

    # Sudo + NetworkManager control
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    openssh.authorizedKeys.keyFiles = [
      ../../keys/authorized/workstation_flizzeri.pub
    ];

    # Hashed password, decrypted from secrets/workstation.yaml at
    # activation time. See modules/core/secrets.nix and secrets/README.md.
    hashedPasswordFile = config.sops.secrets."${usernameLinux}-password".path;
  };

  security.sudo.enable = true;
}
