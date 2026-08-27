{
  config,
  pkgs,
  lib,
  ...
}:

let
  # Public host keys — not secret, committed as plain files under keys/.
  workstationHostKey = lib.strings.removeSuffix "\n" (
    builtins.readFile ../../../keys/hosts/workstation_host_ed25519.pub
  );

  githubHostKey = lib.strings.removeSuffix "\n" (
    builtins.readFile ../../../keys/github/github_host_ed25519.pub
  );
in
{
  # home-manager's sops module runs as your user, separately from the
  # system-level sops instance (modules/core/secrets.nix, which runs as
  # root during system activation). It needs to be told where the same
  # personal age key lives — see secrets/README.md.
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  # One private key per *destination*, not per (machine, destination) pair.
  # Every machine decrypts every access key uniformly — it doesn't matter
  # that the workstation can see the private key that grants access to
  # itself. Keeping this uniform means adding a new machine later is just
  # "give it the age key," not "go edit this file to add another gate."
  #
  # See secrets/README.md for how to generate and populate these.
  sops.secrets = {
    "ssh_workstation_flizzeri_ed25519" = {
      sopsFile = ../../../secrets/shared.yaml;
      path = "${config.home.homeDirectory}/.ssh/id_ed25519_workstation";
      mode = "0600";
    };

    "ssh_github_ed25519" = {
      sopsFile = ../../../secrets/shared.yaml;
      path = "${config.home.homeDirectory}/.ssh/id_ed25519_github";
      mode = "0600";
    };
  };

  programs.ssh = {
    enable = true;

    knownHosts = {
      "workstation.local" = {
        publicKey = workstationHostKey;
      };

      "github.com" = {
        publicKey = githubHostKey;
      };
    };

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = config.sops.secrets."ssh_github_ed25519".path;
        identitiesOnly = true;
      };

      "workstation" = {
        hostname = "workstation.local";
        user = "Flizzeri";
        identityFile = config.sops.secrets."ssh_workstation_flizzeri_ed25519".path;
        identitiesOnly = true;
      };
    };
  };
}
