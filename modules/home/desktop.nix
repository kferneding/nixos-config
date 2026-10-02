{
  pkgs,
  dotfiles,
  ...
}: {
  home.packages = with pkgs; [
    niri # wm
    xwayland-satellite # port x-dependencies
    nsxiv # images
    thunar # file explorer
    thunar-archive-plugin # zip util
    thunar-media-tags-plugin # see media metadata
    thunar-volman # mounting
    spotify # music player
  ];

  programs.thunderbird = {
    enable = true;
    profiles."hd698uyi.default" = {
      isDefault = true;
    };
  };

  stylix.targets.noctalia-shell.enable = false;
  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 0;
      general = {
        avatarImage = "${dotfiles}/avatar.jpg";
      };
      ui = {
        fontDefault = "Inter";
        fontFixed = "JetBrainsMono Nerd Font";
      };
      location = {
        name = "Bremen";
        showWeekNumberInCalendar = true;
      };
      colorSchemes = {
        predefinedScheme = "Rose Pine";
      };
      wallpaper = {
        enabled = true;
        directory = "${dotfiles}/wallpapers/";
        overviewEnabled = true;
      };
      dock = {
        size = 1.5;
        floatingRatio = 1.5;
        onlySameOutput = false;
      };
      appLauncher = {
        enableClipboardHistory = true;
        iconMode = "native";
        terminalCommand = "kitty -e";
      };
      audio = {
        preferredPlayer = "spotify";
      };
      nightLight = {
        enabled = true;
        autoSchedule = true;
        nightTemp = "5000";
        dayTemp = "6500";
      };
      controlCenter = {
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WallpaperSelector";
            }
            {
              id = "DarkMode";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
      };
      bar = {
        density = "comfortable";
        useSeparateOpacity = true;
        backgroundOpacity = 0;
        showCapsule = true;
        capsuleOpacity = 0.85;
        floating = true;
        marginVertical = 4;
        marginHorizontal = 4;
        showOutline = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "ActiveWindow";
              useFixedWidth = false;
              maxWidth = 800;
            }
          ];
          center = [
            {
              id = "Workspace";
              labelMode = "name";
              characterCount = 1;
              showLabelsOnlyWhenOccupied = false;
            }
          ];
          right = [
            {
              id = "MediaMini";
              showArtistFirst = false;
              showVisualizer = true;
              visualizerType = "linear";
              maxWidth = 200;
            }
            {
              id = "Tray";
              enableDrawer = true;
            }
            # use my own better recorder (still some errors because nixos)
            #{
            #  id = "plugin:screen-recorder-replay";
            #}
            {
              id = "plugin:screen-recorder";
            }
            {
              id = "Volume";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "KeyboardLayout";
            }
            {
              id = "Battery";
              displayMode = "alwaysShow";
            }
            {
              id = "Clock";
            }
          ];
        };
      };
    };
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        #screen-recorder-replay = {
        #  enabled = true;
        #  #sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        #};
        screen-recorder = {
          enabled = false;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        translator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 1;
    };

    pluginSettings = {
      #screen-recorder-replay = {
      #  resolution = "3840x2160";
      #  replayLength = "60";
      #  quality = "ultra";
      #  copyToClipboard = true;
      #};
    };
  };

  programs.mpv.enable = true; # media player

  # password manager
  programs.keepassxc = {
    enable = true;
    autostart = false; # niri handles autostart
    settings = {
      Security = {
        LockDatabaseIdle = false;
      };
      FdoSecrets = {
        Enabled = true;
        ConfirmAccessItem = false;
        UnlockBeforeSearch = false;
      };
      Browser = {
        Enabled = true;
      };
      GUI = {
        ApplicationTheme = "dark";
        CompactMode = true;
        HidePasswords = true;
      };
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      window-title-basename = true;
      recolor = true;
    };
  };

  xdg.configFile."niri".source = "${dotfiles}/niri";
}
