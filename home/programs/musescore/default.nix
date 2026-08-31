{ config, pkgs, ... }:

# MuseScore has no dedicated home-manager `programs.musescore` module. Its
# UI theme (Light/Dark) and accent color live in
# $XDG_CONFIG_HOME/MuseScore/MuseScore4.ini, but the exact key/value
# encoding isn't reliably documented and MuseScore's own community forums
# show users struggling even with manual .ini edits to get full custom
# coloring (some settings silently reset on save). Rather than write a
# guessed .ini fragment that risks corrupting the file or silently not
# applying, this module:
#   1. Installs MuseScore as a package.
#   2. Leaves the one-time dark theme + accent color setup as a manual step:
#      Edit > Preferences > Appearance > Theme > Dark, then set the accent
#      color swatch to gold (#D4A017) to match Noir & Sapphire. This is a
#      GUI action that persists to MuseScore4.ini itself, which is more
#      reliable than hand-authoring that file.

{
  home.packages = [ pkgs.musescore ];
}
