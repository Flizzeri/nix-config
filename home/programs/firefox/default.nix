{ config, pkgs, usernameLinux, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.${usernameLinux} = {
      isDefault = true;

      settings = {
        # Force dark UI chrome regardless of GTK/system theme detection,
        # and allow userChrome.css below to actually apply.
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.dark-private-windows" = true;
        "browser.theme.content-theme" = 0; # 0 = dark, 1 = light, 2 = auto
        "browser.theme.toolbar-theme" = 0;

        # Compact UI reads better with a thin custom-styled chrome.
        "browser.uidensity" = 1; # 0 normal, 1 compact, 2 touch
        "browser.tabs.drawInTitlebar" = true;

        # Respect the OS's dark preference for content (websites with
        # prefers-color-scheme: dark).
        "layout.css.prefers-color-scheme.content-override" = 0;
      };

      # Custom browser-chrome styling: recolors tabs, toolbar, and URL bar
      # to Noir & Sapphire instead of default Firefox dark grey.
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
