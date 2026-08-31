{ config, pkgs, lib, ... }:

# ╭──────────────────────────────────────────────────────────────────────────╮
# │                    Plasma 6 — "Noir & Sapphire" rice                     │
# │                                                                          │
# │  Layout:                                                                │
# │    - Top:    thin, edge-to-edge glass strip — clock left, tray right    │
# │    - Bottom: thick, rounded, floating, glass, CENTERED dock (Kickoff,   │
# │              pinned apps, pager)                                       │
# │    - Left:   floating vertical glass dock of pinned GUI apps           │
# │  All three panels use opacity = "translucent" + kwin blur for a glass  │
# │  look (see known-issue note near the panels block).                    │
# ╰──────────────────────────────────────────────────────────────────────────╯

{
  # plasma-manager *configures* these theme names but doesn't install the
  # theme packages themselves — that's on us.
  home.packages = with pkgs; [
    papirus-icon-theme
    bibata-cursors
    kdePackages.breeze-gtk # keeps GTK apps visually consistent with Breeze-based theming
  ];

  programs.plasma = {
    enable = true;

    # Fail loudly instead of silently drifting if a widget/plugin isn't
    # actually installed on this system.
    overrideConfig = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "NoirSapphire";
      theme = "breeze-dark";
      iconTheme = "Papirus-Dark";

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };

      wallpaper = "${./wallpaper/noir-sapphire.svg}";

      splashScreen.theme = "org.kde.breeze.desktop";
    };

    kwin = {
      # Wayland-first, per hardware/desktop modules from Phase 2.
      # Blur is required for panel opacity = "translucent" to actually read
      # as glass rather than just dimmer-solid.
      titlebarButtons = {
        left = [ "on-all-desktops" ];
        right = [ "minimize" "maximize" "close" ];
      };

      effects = {
        blur.enable = true;
        desktopSwitching.animation = "slide";
        # dimInactive intentionally omitted: its correct submodule shape
        # couldn't be confirmed against source (two guesses already burned),
        # and it's cosmetic rather than load-bearing for the panel layout.
        # Set it later via System Settings > Desktop Effects if you want it,
        # or provide the exact shape from `plasma-manager`'s kwin.nix source.
      };

      virtualDesktops = {
        number = 4;
        rows = 1;
      };

      nightLight = {
        enable = true;
        mode = "location";
        # "location" mode needs an explicit fixed point — NixOS can't do
        # runtime geolocation at build/activation time. Using Milan, to
        # match Europe/Rome in modules/core/locale.nix. Update if the
        # workstation ever moves somewhere else.
        location = {
          latitude = "45.4642";
          longitude = "9.1900";
        };
        temperature = {
          day = 6500;
          night = 4200;
        };
      };
    };

    fonts = {
      general = {
        family = "Noto Sans";
        pointSize = 10;
      };
      fixedWidth = {
        family = "JetBrainsMono Nerd Font";
        pointSize = 10;
      };
      small = {
        family = "Noto Sans";
        pointSize = 8;
      };
      toolbar = {
        family = "Noto Sans";
        pointSize = 10;
      };
      menu = {
        family = "Noto Sans";
        pointSize = 10;
      };
      windowTitle = {
        family = "Noto Sans";
        pointSize = 10;
        weight = "bold";
      };
    };

    # ── Panels ──────────────────────────────────────────────────────────────
    # NOTE: opacity = "translucent" below is the correct plasma-manager/KDE
    # option for a glass panel look, but there's a known upstream flakiness
    # where it doesn't always take effect (nix-community/plasma-manager#551,
    # plus several KDE forum reports across versions/themes). If panels look
    # solid after rebuild + relogin, try toggling opacity manually once via
    # right-click panel > More Options > Opacity, or confirm Background
    # Contrast isn't disabled under Desktop Effects.
    panels = [
      # 1) TOP — thin, full-width utility strip.
      {
        location = "top";
        height = 28;
        alignment = "center";
        lengthMode = "fill"; # edge-to-edge, no gaps
        floating = false; # flush against the screen edge, not a floating pill
        hiding = "none"; # always visible — this is your instrument panel
        opacity = "translucent"; # glass effect (paired with kwin.effects.blur.enable below)

        widgets = [
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
              date.enable = true;
              date.format = "shortDate";
            };
          }

          # Single spacer pushes everything after it to the right edge,
          # leaving the clock pinned left — spreads the strip instead of
          # bunching clock + tray together in one corner.
          "org.kde.plasma.panelspacer"

          {
            name = "org.kde.plasma.systemtray";
            config = {
              General = {
                # Keep the top strip lean: only the essentials you asked for.
                extraItems = [
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.keyboardindicator"
                ];
              };
            };
          }
        ];
      }

      # 2) BOTTOM — thick, rounded, floating, CENTERED dock (Kickoff lives
      #    inside this pill, not pinned to a screen edge).
      {
        location = "bottom";
        height = 56;
        alignment = "center"; # centers the whole pill on the screen
        lengthMode = "fit"; # only as wide as its contents — "occupying only the center"
        floating = true; # detached from the screen edge -> rounded floating pill
        hiding = "none";
        opacity = "translucent"; # glass effect

        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake-white";
              sortAlphabetically = true;
              # Kickoff's popup includes a built-in search field, which
              # covers "research bar" without needing a separate widget —
              # standalone KRunner (Alt+Space, see shortcuts below) remains
              # available for quick launches without opening the menu.
            };
          }

          "org.kde.plasma.marginsseparator"

          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:firefox.desktop"
              ];
              appearance = {
                showTooltips = true;
                highlightWindows = true;
                indicateAudioStreams = true;
              };
            };
          }

          "org.kde.plasma.marginsseparator"

          {
            pager = { };
          }
        ];
      }

      # 3) LEFT — floating vertical dock of pinned GUI apps.
      {
        location = "left";
        # For a vertical panel, plasma-manager's `height` field sets the
        # panel's *thickness* (i.e. its width on screen) — matching the
        # bottom dock's 56px, so both floating docks read as one visual
        # family. Panel *length* (how tall it appears) is controlled by
        # `lengthMode`/`alignment` below, not by this field.
        height = 56;
        alignment = "center";
        lengthMode = "fit"; # only as tall as its contents, floating mid-screen
        floating = true;
        hiding = "none";
        opacity = "translucent"; # glass effect

        widgets = [
          {
            iconTasks = {
              launchers = [
                "applications:firefox.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:code.desktop"
                "applications:org.kde.kate.desktop"
              ];
              appearance = {
                showTooltips = true;
                highlightWindows = true;
                # Icons-only, vertical dock — no task grouping labels needed
                # since it's acting as a launcher, not a full task switcher.
                fill = false;
              };
            };
          }
        ];
      }
    ];

    # ── Shortcuts ───────────────────────────────────────────────────────────
    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = "Alt+Space";
      "kwin"."Window Close" = "Meta+Q";
      "kwin"."Overview" = "Meta+Tab";
      "kwin"."Expose" = "Meta+D";
    };

    # ── Session ─────────────────────────────────────────────────────────────
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
  };

  # Ship the custom color scheme file itself so `workspace.colorScheme =
  # "NoirSapphire"` above has something to resolve to.
  home.file.".local/share/color-schemes/NoirSapphire.colors".source =
    ./color-schemes/NoirSapphire.colors;
}
