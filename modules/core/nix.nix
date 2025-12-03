{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Weekly GC, delete older than 14 days.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Reduce store size / duplication over time.
  nix.settings.auto-optimise-store = true;
}

