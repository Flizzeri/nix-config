{ config, pkgs, ... }:

# LibreOffice has no dedicated home-manager `programs.libreoffice` module
# (open feature request: nix-community/home-manager#5612, not yet
# implemented). Its theming lives in registrymodifications.xcu using
# decimal (not hex) RGB values, and several community guides for custom
# color schemes there include an explicit backup-file step because a
# malformed edit can corrupt LibreOffice's entire settings state, not just
# fail to theme. That risk isn't worth taking for a guessed value. Instead:
#   1. Installs LibreOffice (fresh, full suite) as a package.
#   2. Relies on Tools > Options > LibreOffice > View > Appearance >
#      "Follow system appearance" (or "Dark"), which — since the desktop
#      is already dark via Plasma's NoirSapphire scheme (see
#      home/programs/plasma) — gives a dark LibreOffice UI with zero
#      manual color entry needed. This is a one-time toggle, not a
#      per-generation manual step: it persists in LibreOffice's own profile.
#   3. Exact accent-color matching to gold/sapphire (beyond "dark") would
#      require hand-authoring registrymodifications.xcu/themes.xcu with
#      decimal RGB triplets — left as an optional manual step under
#      Tools > Options > LibreOffice > Application Colors if wanted later.

{
  home.packages = [ pkgs.libreoffice-fresh ];
}
