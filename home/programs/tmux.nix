{ pkgs, config, ... }:
let
  tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/git/ -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
        exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)

    tmux_running=$(pgrep tmux)
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        exit 0
    fi

    if ! tmux has-session -t=$selected_name 2> /dev/null; then
        # new-session [options] [shell-command]   shell-command will not execute in the shell, but REPLACE the shell
        tmux new-session -ds $selected_name -c "$selected"
        selected_name="$selected_name:1"
    fi
    tmux switch-client -t $selected_name
  '';
in
{
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
      # Address vim mode switching delay (http://superuser.com/a/252717/65504)
      set-option -s escape-time 0

      # Increase scrollback buffer size from 2000 to 50000 lines
      set -g history-limit 50000

      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1

      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -g focus-events on

      # The -r flag indicates this key may repeat, see the repeat-time option.
      bind -r -T prefix a prev
      bind -r -T prefix t next
      bind -r -T prefix n prev
      bind -r -T prefix i next
      bind -r -T prefix w killp
      bind -T prefix q killp \; detach
      bind -T prefix r new-window -c "#{pane_current_path}"
      bind -T prefix c split-pane -h -c "#{pane_current_path}"
      bind -T prefix v split-pane -c "#{pane_current_path}"
      bind -T prefix x break-pane
      # bind -r -T prefix x command-prompt -p "join pane from:"  "join-pane -s '%%'"
      bind -T prefix z command-prompt -p "send pane to:"  "join-pane -t '%%'"
      bind-key g run-shell "tmux new-window ${tmux-sessionizer}/bin/tmux-sessionizer"
      bind-key G run-shell "tmux new-window tmux-search"
      bind-key f resize-pane -Z

      # copying via mouse selection to system clipboard
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -i"

      set-option -g set-titles on

      set -g mouse on 

      set -g bell-action none
      set -g visual-bell off
      set -g monitor-bell off
    '';
  };
}
