{ config, pkgs, ... }:

{
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
    ".config/tmux".source = ./.config/tmux;
    ".config/i3".source = ./.config/i3;
    ".config/polybar".source = ./.config/polybar;
    ".config/rofi".source = ./.config/rofi;
    ".config/nvim/init.lua".source = ./.config/nvim/init.lua;
    ".config/nvim/lua".source = ./.config/nvim/lua;
    ".config/nvim/after".source = ./.config/nvim/after;
    ".config/nvim/ftplugins".source = ./.config/nvim/ftplugins;
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
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
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
    #extraLuaConfig = builtins.readFile ( builtins.fetchurl{ url = "https://github.com/nvim-lua/kickstart.nvim/raw/master/init.lua";} ); 
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
    delta.enable = true;
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
  services.picom.enable = true;
    

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
