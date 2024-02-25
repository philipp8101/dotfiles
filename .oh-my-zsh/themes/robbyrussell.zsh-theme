function ps1_tail() {
    if [[ ${#${(%):-%~}} -gt 20 ]]; then
        var="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
        [ -n "$var" ] && printf '\n%s ' "$var"
    fi
}

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)$(ps1_tail)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# vim:ft=zsh
