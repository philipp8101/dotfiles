{ config, pkgs, inputs, ... }:

let 
bg = pkgs.stdenv.mkDerivation {
      name = "modified-wallpaper";
      src = ./nixos-wallpaper-catppuccin-macchiato.svg;
      buildInputs = [ pkgs.gnused ];
      buildCommand = ''
        mkdir -p $out
        sed -e 's/#181926/#${config.colorScheme.palette.base01}/g' -e 's/#f4dbd6/#${config.colorScheme.palette.base06}/g' -e 's/#8bd5ca/#${config.colorScheme.palette.base0C}/g' -e 's/#5b6078/#${config.colorScheme.palette.base04}/g' -e 's/#24273a/${config.colorScheme.palette.base00}/g' $src > $out/modified-wallpaper.svg
      '';
    };
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./home/polybar.nix
    ./home/alacritty.nix
  ];
  colorScheme = inputs.nix-colors.colorSchemes.gigavolt;
  # colorScheme = inputs.nix-colors.lib.schemeFromYAML "carbonfox" (builtins.readFile(builtins.fetchurl{
  #   url = "https://github.com/EdenEast/nightfox.nvim/raw/main/extra/carbonfox/base16.yaml";
  #   sha256 = "196934b7c57ddfe9427318a51fdc17dc4684e73a33660584fd9afa1486fd717b";
  # }));
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
    ".background-image".source = "${bg.outPath}/modified-wallpaper.svg";
  };
  xdg.configFile = {
    "tmux/tmux-sessionizer".source = ./tmux/tmux-sessionizer;
    "tmux/custom.conf".source = ./tmux/custom.conf;
    "i3/config".source = ./i3/config;
    "i3/modes.config".source = ./i3/modes.config;
    "i3/rules.config".source = ./i3/rules.config;
    "i3/scripts".source = ./i3/scripts;
    "polybar/polybar-scripts".source = ./polybar/polybar-scripts;
    "rofi".source = ./rofi;
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
    "nvim/after".source = ./nvim/after;
    "nvim/ftplugins".source = ./nvim/ftplugins;
    # kitty -o allow_remote_control=yes
    # kitty @ get-colors
    # "kitty/themes/nix_colors.conf".text = ''
    #   color0 #${config.colorScheme.palette.base00}
    # '';
    "i3/colors.config".text = ''
      #class                   border                                backgr.                               text                                  indicator                             child_border
      client.focused           #${config.colorScheme.palette.base04}  #${config.colorScheme.palette.base03}  #${config.colorScheme.palette.base05}  #${config.colorScheme.palette.base03}  #${config.colorScheme.palette.base03}
      client.focused_inactive  #${config.colorScheme.palette.base03}  #${config.colorScheme.palette.base02}  #${config.colorScheme.palette.base05}  #${config.colorScheme.palette.base02}  #${config.colorScheme.palette.base02}
      client.unfocused         #${config.colorScheme.palette.base02}  #${config.colorScheme.palette.base00}  #${config.colorScheme.palette.base05}  #${config.colorScheme.palette.base00}  #${config.colorScheme.palette.base00}
      client.urgent            #${config.colorScheme.palette.base04}  #${config.colorScheme.palette.base08}  #${config.colorScheme.palette.base05}  #${config.colorScheme.palette.base08}  #${config.colorScheme.palette.base08}
      client.placeholder       #${config.colorScheme.palette.base00}  #${config.colorScheme.palette.base00}  #${config.colorScheme.palette.base05}  #${config.colorScheme.palette.base00}  #${config.colorScheme.palette.base00}
      client.background        #${config.colorScheme.palette.base00}                                                                                                                    
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
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g mode-style "fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base06}"
      set -g message-style "fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base06}"
      set -g message-command-style "fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base06}"
      set -g pane-border-style "fg=#${config.colorScheme.palette.base06}"
      set -g pane-active-border-style "fg=#${config.colorScheme.palette.base0D}"
      set -g status "on"
      set -g status-justify "left"
      set -g status-style "fg=#${config.colorScheme.palette.base06},bg=#${config.colorScheme.palette.base00}"
      set -g status-left-length "100"
      set -g status-right-length "100"
      set -g status-left-style NONE
      set -g status-right-style NONE
      set -g status-left "#[fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base0D},bold] #S #[fg=#${config.colorScheme.palette.base0D},bg=#${config.colorScheme.palette.base00},nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base00},nobold,nounderscore,noitalics]#[fg=#${config.colorScheme.palette.base0D},bg=#${config.colorScheme.palette.base00}] #{prefix_highlight} #[fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base0D},bold] #h "
      setw -g window-status-activity-style "underscore,fg=#${config.colorScheme.palette.base04},bg=#${config.colorScheme.palette.base00}"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#${config.colorScheme.palette.base04},bg=#${config.colorScheme.palette.base00}"
      setw -g window-status-format "#[fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base00},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base00},nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base06},nobold,nounderscore,noitalics]#[fg=#${config.colorScheme.palette.base00},bg=#${config.colorScheme.palette.base06},bold] #I  #W #F #[fg=#${config.colorScheme.palette.base06},bg=#${config.colorScheme.palette.base00},nobold,nounderscore,noitalics]"
      # set -g status-left "#[fg=colour233,bg=colour39,bold] #S #[fg=colour39,bg=colour233,nobold]#[fg=colour233,bg=colour233] "
      # set -g status-right ""
      source-file ~/.config/tmux/custom.conf
    '';
  };
  services.dunst = {
    enable = true;
    settings = {
      globals = {
        frame_color = "#${config.colorScheme.palette.base04}";
        separator_color = "frame";
      };
      urgency_low = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
        frame_color = "#${config.colorScheme.palette.base03}";
      };
      urgency_normal = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
      };
      urgency_critical = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base0F}";
        frame_color = "#${config.colorScheme.palette.base08}";
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
