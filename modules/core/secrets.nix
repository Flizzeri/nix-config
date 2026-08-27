{
  config,
  pkgs,
  usernameLinux,
  ...
}:

{
  sops = {
    # Personal age key, independent of any SSH host key. Provisioned
    # manually onto each machine — see secrets/README.md.
    age.keyFile = "/home/${usernameLinux}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets/workstation.yaml;

    secrets = {
      "${usernameLinux}-password" = {
        neededForUsers = true;
      };
    };
  };
}
