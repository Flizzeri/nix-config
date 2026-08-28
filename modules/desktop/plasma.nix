{ config, pkgs, lib, ... }:

{
  # Still required even for a Wayland-only Plasma session as of 25.11 —
  # some session/XWayland plumbing lives under services.xserver.
  services.xserver.enable = true;

  services.xserver.xkb.layout = "us"; # mirrors console.keyMap in locale.nix

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # Trim default KDE application bloat you're unlikely to want alongside
  # your existing CLI-first tooling (alacritty, neovim, zellij). Add/remove
  # from this list as you find things you don't use.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa # music player
    khelpcenter
    plasma-browser-integration
    print-manager # drop this line if you set up services.printing later
  ];

  # Dolphin, Konsole, Spectacle, etc. ship with plasma6 by default and are
  # left in place. GUI app choices beyond the DE defaults are handled in
  # home-manager (Phase 5), not here.
}
