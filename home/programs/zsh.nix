{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    initExtra = "zstyle ':completion:*' rehash true\n";
    history.save = 1000000;
    oh-my-zsh = {
      custom = "${pkgs.stdenv.mkDerivation {
      name = "custom-theme";
      rr = pkgs.writeText "robbyrussell.zsh-theme" ''
  PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) "
  PROMPT+='$(if [ $SHLVL -gt 1 -o ! -z $DIRENV_DIR ] ; then echo "%{$fg[cyan]%}󱄅 %{$reset_color%} "; fi)'
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
