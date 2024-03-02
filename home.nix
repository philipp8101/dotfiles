{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./home/polybar.nix
  ];
  # colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  colorScheme = inputs.nix-colors.lib.schemeFromYAML "carbonfox" (builtins.readFile(builtins.fetchurl{
    url = "https://github.com/EdenEast/nightfox.nvim/raw/main/extra/carbonfox/base16.yaml";
    sha256 = "196934b7c57ddfe9427318a51fdc17dc4684e73a33660584fd9afa1486fd717b";
  }));
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

  home.file = {
    ".background-image".source = ./nixos-wallpaper-catppuccin-macchiato.png;
  };
  xdg.configFile = {
    "tmux".source = ./tmux;
    "i3/config".source = ./i3/config;
    "i3/modes.config".source = ./i3/modes.config;
    "i3/rules.config".source = ./i3/rules.config;
    "i3/scripts".source = ./i3/scripts;
    "polybar".source = ./polybar;
    "rofi".source = ./rofi;
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
    "nvim/after".source = ./nvim/after;
    "nvim/ftplugins".source = ./nvim/ftplugins;
    # kitty -o allow_remote_control=yes
    # kitty @ get-colors
    # "kitty/themes/nix_colors.conf".text = ''
    #   color0 #${config.colorScheme.colors.base00}
    # '';
    "i3/colors.config".text = ''
      #class                   border                                backgr.                               text                                  indicator                             child_border
      client.focused           #${config.colorScheme.colors.base04}  #${config.colorScheme.colors.base03}  #${config.colorScheme.colors.base05}  #${config.colorScheme.colors.base03}  #${config.colorScheme.colors.base03}
      client.focused_inactive  #${config.colorScheme.colors.base03}  #${config.colorScheme.colors.base02}  #${config.colorScheme.colors.base05}  #${config.colorScheme.colors.base02}  #${config.colorScheme.colors.base02}
      client.unfocused         #${config.colorScheme.colors.base02}  #${config.colorScheme.colors.base00}  #${config.colorScheme.colors.base05}  #${config.colorScheme.colors.base00}  #${config.colorScheme.colors.base00}
      client.urgent            #${config.colorScheme.colors.base04}  #${config.colorScheme.colors.base08}  #${config.colorScheme.colors.base05}  #${config.colorScheme.colors.base08}  #${config.colorScheme.colors.base08}
      client.placeholder       #${config.colorScheme.colors.base00}  #${config.colorScheme.colors.base00}  #${config.colorScheme.colors.base05}  #${config.colorScheme.colors.base00}  #${config.colorScheme.colors.base00}
      client.background        #${config.colorScheme.colors.base00}                                                                                                                    
    '';
  };
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
        frame_color = "#${config.colorScheme.colors.base04}";
        separator_color = "frame";
      };
      urgency_low = {
        background = "#${config.colorScheme.colors.base00}";
        foreground = "#${config.colorScheme.colors.base05}";
        frame_color = "#${config.colorScheme.colors.base03}";
      };
      urgency_normal = {
        background = "#${config.colorScheme.colors.base00}";
        foreground = "#${config.colorScheme.colors.base05}";
      };
      urgency_critical = {
        background = "#${config.colorScheme.colors.base00}";
        foreground = "#${config.colorScheme.colors.base0F}";
        frame_color = "#${config.colorScheme.colors.base08}";
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
