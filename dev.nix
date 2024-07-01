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

  colorScheme = let
  tinted-theming = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "base16-schemes";
    rev = "2b6f2d0677216ddda50c9cabd6ee70fae4665f81";
    sha256 = "sha256-VTczZi1C4WSzejpTFbneMonAdarRLtDnFehVxWs6ad0=";
  };
  unikitty = pkgs.fetchFromGitHub {
    owner = "joshwlewis";
    repo = "base16-unikitty";
    rev = "28362f3a37a0e81b04d844aa5b2923ad63140734";
    sha256 = "sha256-VTczZi1C4WSzejpTFbneMonAdarRLtDnFehVxWs6ad0=";
  };
  theme = src: theme_name: inputs.nix-colors.lib.schemeFromYAML theme_name (builtins.readFile "${src}/${theme_name}.yaml");
  in
  # theme unikitty "unikitty-reversible";
  theme tinted-theming "gigavolt";
  # theme "carbonfox";

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
