# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, config, ... }:

with lib.hm.gvariant;

{
  dconf.enable = config.gui;
  dconf.settings = {
    "org/a11y/accerciser" = {
      hpaned = 637;
      vpaned = 350;
      window-height = 843;
      window-width = 1368;
    };

    "org/a11y/accerciser/pluginviews" = {
      bottom-panel-layout = [ "IPython Console" ];
      top-panel-layout = [ "API Browser" "Interface Viewer" "Event Monitor" "Script Recorder" ];
    };

    "org/gnome/2048" = {
      cols = 4;
      rows = 4;
      window-height = 600;
      window-maximized = false;
      window-width = 600;
    };

    "org/gnome/baobab/ui" = {
      active-chart = "rings";
      is-maximized = true;
      window-size = mkTuple [ 960 600 ];
    };

    "org/gnome/builder" = {
      window-maximized = true;
      window-size = mkTuple [ (-1) (-1) ];
    };

    "org/gnome/builder/editor" = {
      style-scheme-name = "Adwaita-dark";
    };

    "org/gnome/builder/editor/language/automake" = {
      insert-spaces-instead-of-tabs = false;
      insert-trailing-newline = true;
      tab-width = 8;
    };

    "org/gnome/builder/editor/language/blueprint" = {
      auto-indent = true;
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = false;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/c-sharp" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = false;
      overwrite-braces = true;
      spaces-style = [ "before-left-paren" ];
      tab-width = 8;
    };

    "org/gnome/builder/editor/language/c" = {
      auto-indent = true;
      indent-width = 2;
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      spaces-style = [ "before-left-paren" ];
      tab-width = 8;
    };

    "org/gnome/builder/editor/language/chdr" = {
      auto-indent = true;
      indent-width = 2;
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      spaces-style = [ "before-left-paren" ];
      tab-width = 8;
    };

    "org/gnome/builder/editor/language/commonlisp" = {
      auto-indent = true;
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      overwrite-braces = true;
      right-margin-position = 100;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/cpp" = {
      auto-indent = true;
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 4;
    };

    "org/gnome/builder/editor/language/css" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/gradle" = {
      auto-indent = true;
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/html" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/java" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/js" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/makefile" = {
      insert-spaces-instead-of-tabs = false;
      insert-trailing-newline = true;
      tab-width = 8;
    };

    "org/gnome/builder/editor/language/markdown" = {
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      tab-width = 4;
      trim-trailing-whitespace = false;
    };

    "org/gnome/builder/editor/language/python" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 4;
    };

    "org/gnome/builder/editor/language/python3" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 4;
    };

    "org/gnome/builder/editor/language/ruby" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/builder/editor/language/rust" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      right-margin-position = 100;
      tab-width = 4;
    };

    "org/gnome/builder/editor/language/vala" = {
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 4;
    };

    "org/gnome/builder/editor/language/xml" = {
      auto-indent = true;
      insert-matching-brace = true;
      insert-spaces-instead-of-tabs = true;
      insert-trailing-newline = true;
      overwrite-braces = true;
      tab-width = 2;
    };

    "org/gnome/calendar" = {
      active-view = "month";
    };

    "org/gnome/cheese" = {
      burst-delay = 1000;
    };

    "org/gnome/clocks/state/window" = {
      maximized = false;
      panel-id = "world";
      size = mkTuple [ 870 690 ];
    };

    "org/gnome/control-center" = {
      last-panel = "sound";
      window-state = mkTuple [ 980 640 true ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" "Pardus" ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/philipp/.local/share/backgrounds/2023-12-07-14-25-06-rick-and-morty-landscape_3840x2160_xtrafondos.com.png";
      picture-uri-dark = "file:///home/philipp/.local/share/backgrounds/2023-12-07-14-25-06-rick-and-morty-landscape_3840x2160_xtrafondos.com.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [ (mkTuple [ "xkb" "de" ]) ];
      sources = [ (mkTuple [ "xkb" "de+workman" ]) (mkTuple [ "xkb" "de" ]) ];
      xkb-options = [];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      color-scheme = "prefer-dark";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "firefox" "gnome-power-panel" "discord" "org-gnome-baobab" "spotify" "gnome-network-panel" "org-gnome-fileroller" "org-gnome-nautilus" "steam" "sonic-visualiser" "org-gnome-epiphany" "org-gnome-settings" "com-nextcloud-desktopclient-nextcloud" "arduino" "org-mozilla-thunderbird" "gnome-printers-panel" ];
    };

    "org/gnome/desktop/notifications/application/arduino" = {
      application-id = "arduino.desktop";
    };

    "org/gnome/desktop/notifications/application/com-nextcloud-desktopclient-nextcloud" = {
      application-id = "com.nextcloud.desktopclient.nextcloud.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-printers-panel" = {
      application-id = "gnome-printers-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-epiphany" = {
      application-id = "org.gnome.Epiphany.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-fileroller" = {
      application-id = "org.gnome.FileRoller.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-mozilla-thunderbird" = {
      application-id = "org.mozilla.Thunderbird.desktop";
    };

    "org/gnome/desktop/notifications/application/sonic-visualiser" = {
      application-id = "sonic-visualiser.desktop";
    };

    "org/gnome/desktop/notifications/application/spotify" = {
      application-id = "spotify.desktop";
    };

    "org/gnome/desktop/notifications/application/steam" = {
      application-id = "steam.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/philipp/.local/share/backgrounds/2023-12-07-14-25-06-rick-and-morty-landscape_3840x2160_xtrafondos.com.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      maximize = [ "<Super>b" ];
      minimize = [ "<Super>h" ];
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-to-workspace-left = [ "<Super>a" ];
      switch-to-workspace-right = [ "<Super>s" ];
      switch-windows = [ "<Super>t" ];
      switch-windows-backward = [ "<Shift><Super>t" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      resize-with-right-button = true;
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = false;
      dual-page-odd-left = true;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = true;
      sidebar-page = "thumbnails";
      sidebar-size = 148;
      sizing-mode = "free";
      window-ratio = mkTuple [ 1.9747899159663866 0.998812351543943 ];
      zoom = 1.6312347853538796;
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/evolution" = {
      version = "3.50.2";
    };

    "org/gnome/evolution/calendar" = {
      week-start-day-name = "monday";
      work-day-friday = true;
      work-day-monday = true;
      work-day-saturday = false;
      work-day-sunday = false;
      work-day-thursday = true;
      work-day-tuesday = true;
      work-day-wednesday = true;
    };

    "org/gnome/evolution/mail" = {
      browser-close-on-reply-policy = "ask";
      forward-style-name = "attached";
      image-loading-policy = "never";
      paned-size = 1259154;
      reply-style-name = "quoted";
    };

    "org/gnome/evolution/shell/window" = {
      height = 480;
      maximized = false;
      width = 640;
      x = 26;
      y = 23;
    };

    "org/gnome/file-roller/dialogs/extract" = {
      height = 800;
      recreate-folders = true;
      skip-newer = false;
      width = 1000;
    };

    "org/gnome/file-roller/file-selector" = {
      show-hidden = false;
      sidebar-size = 300;
      window-size = mkTuple [ (-1) (-1) ];
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 65;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 203;
      window-height = 480;
      window-width = 600;
    };

    "org/gnome/five-or-more" = {
      window-height = 639;
      window-is-maximized = false;
      window-width = 752;
    };

    "org/gnome/gedit/state/window" = {
      bottom-panel-size = 140;
      side-panel-active-page = "GeditWindowDocumentsPanel";
      side-panel-size = 200;
      size = mkTuple [ 900 700 ];
      state = 87168;
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "resources";
      maximized = false;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 1063 500 26 23 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/hitori" = {
      window-maximized = false;
      window-position = mkTuple [ 26 23 ];
      window-size = mkTuple [ 375 391 ];
    };

    "org/gnome/meld/window-state" = {
      height = 301;
      is-maximized = true;
      width = 781;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Super>d" ];
      toggle-tiled-right = [ "<Super>r" ];
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 999 536 ];
      maximized = true;
    };

    "org/gnome/nm-applet/eap/28608880-b828-4415-9e3e-6248ef141258" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/4dffb318-3142-461d-9a1e-f33f7742772d" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/7eb8267c-5e86-49cc-93fa-db267be04a3d" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/b74a3792-cc4d-3ae0-b869-5ce5e1540245" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/c22bd43e-660f-4139-873c-389e2264e6b9" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/portal/filechooser/gnome-network-panel" = {
      last-folder-path = "/home/philipp/Downloads";
    };

    "org/gnome/portal/filechooser/gnome-wifi-panel" = {
      last-folder-path = "/home/philipp/Downloads";
    };

    "org/gnome/portal/filechooser/org/gnome/Settings" = {
      last-folder-path = "/home/philipp/Downloads";
    };

    "org/gnome/recipes" = {
      user = "philipp";
    };

    "org/gnome/settings-daemon/peripherals/touchscreen" = {
      orientation-lock = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;
      night-light-temperature = mkUint32 4500;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false;
      idle-dim = false;
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      command-history = [ "r" ];
      disabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" "light-style@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [ "firefox.desktop" "Alacritty.desktop" "org.gnome.Nautilus.desktop" "obsidian.desktop" "org.mozilla.Thunderbird.desktop" "discord.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "45.2";
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Super>z" ];
      toggle-application-view = [];
      toggle-quick-settings = [];
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/software" = {
      check-timestamp = mkInt64 1729852680;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1728737820;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 140;
      sort-column = "modified";
      sort-directories-first = false;
      sort-order = "descending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 1225 880 ];
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.4 0.0 0.8 1.0 ]) (mkTuple [ 0.8 1.0 1.0 1.0 ]) ];
      selected-color = mkTuple [ true 0.9647058823529412 0.8274509803921568 0.17647058823529413 1.0 ];
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = "24h";
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 157;
      sort-column = "modified";
      sort-directories-first = false;
      sort-order = "descending";
      type-format = "category";
      window-position = mkTuple [ 26 23 ];
      window-size = mkTuple [ 1203 833 ];
    };

    "org/perezdecastro/Revolt/saved-state/main-window" = {
      height = mkUint32 841;
      maximized = true;
      width = mkUint32 1368;
    };

  };
}
