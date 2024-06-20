{ config, pkgs, inputs, user, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./home/tmux.nix
    ./home/lf.nix
  ];
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  colorScheme = inputs.nix-colors.colorSchemes.gigavolt;
  # colorScheme = inputs.nix-colors.lib.schemeFromYAML "carbonfox" (builtins.readFile(builtins.fetchurl{
  #   url = "https://github.com/EdenEast/nightfox.nvim/raw/main/extra/carbonfox/base16.yaml";
  #   sha256 = "196934b7c57ddfe9427318a51fdc17dc4684e73a33660584fd9afa1486fd717b";
  # }));

  home.packages = with pkgs; [
  ];

  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
    "nvim/after".source = ./nvim/after;
    "nvim/ftplugins".source = ./nvim/ftplugins;
    # kitty -o allow_remote_control=yes
    # kitty @ get-colors
    # "kitty/themes/nix_colors.conf".text = ''
    #   color0 #${config.colorScheme.palette.base00}
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable= true;
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

  programs.home-manager.enable = true;
}
