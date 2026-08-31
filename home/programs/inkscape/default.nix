{ config, pkgs, ... }:

# Inkscape has no dedicated home-manager `programs.inkscape` module, and its
# dark/theme setting lives in a GUI-only "Theming" preferences dropdown
# rather than a simple, documented preferences.xml key — writing that file
# by hand risks corrupting or fighting the format. Rather than guess at
# internals, this module:
#   1. Installs Inkscape as a package.
#   2. Relies on the GTK theme set up in plasma/default.nix
#      (breeze-gtk, Papirus-Dark icons) which Inkscape follows automatically
#      on Linux when its own theme preference is left at "Use system theme"
#      (the default on first run).
#   3. Leaves exact accent-color matching to Noir & Sapphire as a manual,
#      one-time step: Edit > Preferences > Interface > Theming > select a
#      dark GTK theme, since Inkscape doesn't expose custom hex theming
#      beyond GTK theme selection.

{
  home.packages = [ pkgs.inkscape ];
}
