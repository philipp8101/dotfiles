{ pkgs, config, ... }:
{
  imports = [
    ./nix-colors.nix
  ];
  xdg.configFile = {
    "tmux/tmux-sessionizer".source = ./tmux/tmux-sessionizer;
    "tmux/custom.conf".source = ./tmux/custom.conf;
  };
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
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
      source-file ~/.config/tmux/custom.conf
      '';
  };
}
