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
    ./home/rofi.nix
    ./home/tmux.nix
    ./home/i3.nix
    ./home/lf.nix
    ./home/hyprland.nix
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
    pkgs.go
  ];

  home.file = {
    ".background-image".source = "${bg.outPath}/modified-wallpaper.svg";
  };
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
