# ============================================================
# modules/user/kde-config.nix
# ============================================================
{ config, lib, pkgs, ... }:

{
  home.activation.configureMonitors = lib.hm.dag.entryAfter ["writeBoundary"] ''
    export PATH="${pkgs.kdePackages.libkscreen}/bin:$PATH"
    kscreen-doctor \
      output.DP-3.enable \
      output.DP-3.mode.2560x1440@144 \
      output.DP-3.position.1440,0 \
      output.DP-3.rotation.none \
      output.DP-3.primary \
      output.DP-2.enable \
      output.DP-2.mode.1920x1080@60 \
      output.DP-2.position.4000,180 \
      output.DP-2.rotation.none \
      output.DP-1.enable \
      output.DP-1.mode.2560x1440@75 \
      output.DP-1.position.0,0 \
      output.DP-1.rotation.left
  '';

  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select";
      colorScheme = "BreezeDark";
      cursor.theme = "breeze_cursors";
      iconTheme = "breeze-dark";
      wallpaper = ../../assets/wallpaper/mountain.jpg;
    };

    # System Settings > Text & Fonts > Fonts
    fonts = {
      fixedWidth = {
        family = "FiraCode Nerd Font Mono";
        pointSize = 10;
      };
      general = {
        family = "FiraCode Nerd Font Mono";
        pointSize = 10;
      };
      menu = {
        family = "FiraCode Nerd Font Mono";
        pointSize = 10;
      };
      small = {
        family = "FiraCode Nerd Font Mono";
        pointSize = 8;
      };
      toolbar = {
        family = "FiraCode Nerd Font Mono";
        pointSize = 10;
      };
      windowTitle = {
        family = "FiraCode Nerd Font Mono";
        pointSize = 10;
      };
    };

    # System Settings > Screen Locking > Configure Appearance
    kscreenlocker = {
      appearance = {
        showMediaControls = false;
        wallpaper = ../../assets/wallpaper/mountain.jpg;
      };
      autoLock = false;
    };

    session = {
      general.askForConfirmationOnLogout = false;
    };

    krunner = {
      position = "center";
    };

    panels = [
      {
        location = "bottom";
        floating = false;
        widgets = [
          # Application Launcher (Kickoff)
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake";  # or any icon name
                alphaSort = "true";
              };
            };
          }

          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = builtins.concatStringsSep "," [
                  "applications:org.kde.dolphin.desktop"
                  "applications:kitty.desktop"
                  "file:///nix/store/1yc8l42sy4vavnajl6a9kigdahgvmj48-user-environment/share/applications/zen-beta.desktop"
                  "applications:sublime_text.desktop"
                  "applications:onlyoffice-desktopeditors.desktop"
                ];
                groupingStrategy = "1";       # group windows of same app
                sortingStrategy = "1";        # keep manual order
                showOnlyCurrentDesktop = "false";
                showOnlyCurrentActivity = "false";
              };
            };
          }


          # Spacer
          { name = "org.kde.plasma.panelspacer"; }

          # System Tray
          {
            name = "org.kde.plasma.systemtray";
          }

          # Digital Clock
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                showDate = "true";
                dateFormat = "shortDate";
                use24hFormat = "2"; # 0=locale, 1=12h, 2=24h
              };
            };
          }

        ];
      }
    ];

    input.keyboard = {
      numlockOnStartup = "on";
    };

    kwin = {
      effects.wobblyWindows.enable = false;
      titlebarButtons = {
        right = [ "minimize" "maximize" "close" ];
        left  = [];
      };
    };

    shortcuts = {
      "kwin"."Switch to Desktop 1" = "Meta+1";
      "kwin"."Switch to Desktop 2" = "Meta+2";

      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+L"
        ];
      };
    };
  };
}
