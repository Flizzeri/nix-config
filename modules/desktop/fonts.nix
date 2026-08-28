{ config, pkgs, lib, ... }:

{
  fonts = {
    packages = with pkgs; [
      # Nerd Font: gives glyph/icon coverage consistent with your existing
      # starship + fastfetch + neovim setup so icons render the same in
      # GUI apps as they already do in the terminal.
      nerd-fonts.jetbrains-mono

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      liberation_ttf # metric-compatible with common Microsoft fonts, avoids layout breakage in office docs/PDFs
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
