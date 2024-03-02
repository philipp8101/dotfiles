{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "philipp";
  home.homeDirectory = "/home/philipp";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".background-image".source = ./nixos-wallpaper-catppuccin-macchiato.png;
  };
  xdg.configFile = {
    "tmux".source = ./tmux;
    "i3".source = ./i3;
    "polybar".source = ./polybar;
    "rofi".source = ./rofi;
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
    "nvim/after".source = ./nvim/after;
    "nvim/ftplugins".source = ./nvim/ftplugins;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };
  gtk = {
    enable = true;
    theme.name = "Adwaita";
    cursorTheme.name = "Adwaita";
    iconTheme.name = "Adwaita";
  };
  xresources.properties = {
    "Xcursor.theme" = "Adwaita";
  };
  xdg.mimeApps.defaultApplications = {
    "text/*" = [ "neovim.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "image/*" = [ "eog.desktop" ];
    "application/pdf" = [ "evince.desktop" ];
  };
  xdg.desktopEntries = {
    neovim = {
      name = "Neovim";
      genericName = "Text editor";
      icon = "nvim";
      exec = "kitty nvim %U";
      mimeType = [ "text/*" ];
    };
    nvim = {
      name = "nvim";
      noDisplay = true;
    };
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    initExtra = "zstyle ':completion:*' rehash true\n";
    history.save = 1000000;
    oh-my-zsh = {
      theme = "robbyrussell";
      enable = true;
      plugins = [
        "fzf"
        "timer"
        "history-substring-search"
      ];
    };
    envExtra = ''
      export TIMER_THRESHOLD="3";
      export TIMER_FORMAT="[%d]";
    '';
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd=cd"
    ];
  };
  programs.git = {
    enable = true;
    userEmail = "philipp8101@gmail.com";
    userName = "Philipp Conrad";
    aliases = {
      graph = "log --all --decorate --oneline --graph";
      nb = "!f() { git checkout -b \"$1\"; }; f";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
      };
    };
    lfs.enable = true;
    extraConfig = {
      core = {
        editor = "nvim";
      };
      push = {
        autoSetupRemote = "true";
      };
      merge = {
        conflictstyle = "diff3";
      };
    };
  };
  programs.kitty = {
    enable = true;
    font = {
      name = "Inconsolata Nerd Font";
      size = 14;
    };
    settings = {
      background_opacity = "0.8";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      colors.bright = {
        black = "0x${config.colorScheme.colors.base01}";
        blue = "0x${config.colorScheme.colors.base0D}";
        cyan = "0x${config.colorScheme.colors.base0C}";
        green = "0x${config.colorScheme.colors.base0B}";
        magenta = "0x${config.colorScheme.colors.base0E}";
        red = "0x${config.colorScheme.colors.base08}";
        white = "0x${config.colorScheme.colors.base05}";
        yellow = "0x${config.colorScheme.colors.base0A}";
      };
      colors.normal = {
        black = "0x${config.colorScheme.colors.base01}";
        blue = "0x${config.colorScheme.colors.base0D}";
        cyan = "0x${config.colorScheme.colors.base0C}";
        green = "0x${config.colorScheme.colors.base0B}";
        magenta = "0x${config.colorScheme.colors.base0E}";
        red = "0x${config.colorScheme.colors.base08}";
        white = "0x${config.colorScheme.colors.base05}";
        yellow = "0x${config.colorScheme.colors.base0A}";
      };
      colors.primary = {
        background = "0x${config.colorScheme.colors.base00}";
        foreground = "0x${config.colorScheme.colors.base05}";
      };
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 14.0;
      };
      font.bold = {
        family = "Inconsolata";
        style = "Bold";
      };
      font.bold_italic = {
        family = "Inconsolata";
        style = "Bold Italic";
      };
      font.italic = {
        family = "Inconsolata";
        style = "Italic";
      };
      font.normal = {
        family = "Inconsolata";
        style = "Regular";
      };
      window = {
        opacity = 0.8;
        startup_mode = "Windowed";
      };
      window.dimensions = {
        columns = 0;
        lines = 0;
      };
    };
  };
  services.dunst = {
    enable = true;
    settings = {
      globals = {
        frame_color = "#8AADF4";
        separator_color = "frame";
      };
      urgency_low = {
        background = "#24273A";
        foreground = "#CAD3F5";
      };
      urgency_normal = {
        background = "#24273A";
        foreground = "#CAD3F5";
      };
      urgency_critical = {
        background = "#24273A";
        foreground = "#CAD3F5";
        frame_color = "#F5A97F";
      };
    };
  };
  services.picom = {
    enable = true;
    # backend = "glx";
    fade = true;
    fadeDelta = 4;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 3;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
