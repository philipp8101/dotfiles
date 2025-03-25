{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      y = ''
        {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
      '';
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    # TODO get completion working with `nr` and `ns`
    initExtra = ''
    zstyle ':completion:*' rehash true\n
    function nr () {
      local first=$1
      shift 1
      nix run nixpkgs#"$first" -- "$@"
    }
    function ns () {
      local result=()
      for arg in $@; do 
        result+="nixpkgs#''${arg}"
      done
      nix shell "''${result[@]}"
    }
    '';
    history.save = 1000000;
    historySubstringSearch.enable = false;
    oh-my-zsh = {
      custom = "${pkgs.stdenv.mkDerivation {
      name = "custom-theme";
      rr = pkgs.writeText "robbyrussell.zsh-theme" ''
  PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) "
  PROMPT+='$(if [ ! -z $DIRENV_DIR ] ; then echo "%{$fg[green]%} %{$reset_color%} "; fi)'
  PROMPT+='$(if [ $SHLVL -gt 1 -a -z $TMUX ] ; then echo "%{$fg[cyan]%}󱄅 %{$reset_color%} "; fi)'
  PROMPT+='$(if [ $SHLVL -gt 2 -a ! -z $TMUX ] ; then echo "%{$fg[cyan]%}󱄅 %{$reset_color%} "; fi)'
  PROMPT+="%{$fg[cyan]%}%c%{$reset_color%}"
  PROMPT+=' $(git_prompt_info)'

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
      '';
      phases = [ "installPhase" ];
      installPhase = ''
      install -Dm755 $rr $out/themes/robbyrussell.zsh-theme
      '';
      }
      }";
      theme = "robbyrussell";
      enable = true;
      plugins = [
        "fzf"
        "timer"
        "history-substring-search"
        "direnv"
      ];
    };
    envExtra = ''
      export TIMER_THRESHOLD="3";
      export TIMER_FORMAT="[%d]";
    '';
  };
}
