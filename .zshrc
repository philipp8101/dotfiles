# If you come from bash you might have to change your $PATH.
export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.scripts/:$GOPATH/bin/:$HOME/.local/bin/:$GOPATH/bin:$HOME/.config/composer/vendor/bin
export XDG_CONFIG_HOME=$HOME/.config
# export XKB_CONFIG_ROOT=$XDG_CONFIG_HOME/xkb

export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock
if [ -e $SSH_AUTH_SOCK ]; then
    if [[ ! $(pgrep ssh-agent) ]]; then
        rm "$SSH_AUTH_SOCK"
    fi
fi
if [ ! -e $SSH_AUTH_SOCK ]; then
    ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="crcandy"
# ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf-zsh-plugin command-time zsh-fzf-history-search zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR="nvim"
alias vim=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias git-dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lazygit-dot="lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# fix autocompletion not working for new executables
# see: https://bbs.archlinux.org/viewtopic.php?id=215485
zstyle ':completion:*' rehash true

# fix pearl warning message (when running fzf (ctrl+r))
export LC_ALL=en_US.UTF-8

export ZSH_EXEC=$(which zsh)
# if tmux exists and not already in tmux session
# if command -v tmux &> /dev/null && [[ -z "${TMUX}" ]] && [[ -z "${SSH_CONNECTION}" ]]; then
#     # if session with group 0 that is unattached does not exist
#     if first_unattached=$(tmux ls | grep "group 0" | grep -v "attached" -m 1 | grep "[0-9]*-[0-9]*" -o) ; then
#         # attach to session 0 and spawn new window; close terminal after exiting tmux
#         tmux -f ~/.config/tmux/tmux.conf attach -t"$first_unattached" \; new-window && exit
#     else
#         # if session 0 does not exist create it
#         tmux -f ~/.config/tmux/tmux.conf new-session -t0 && exit
#     fi
# fi

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh --cmd=cd)"
fi
