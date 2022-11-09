# Setup fzf
# ---------
if [[ ! "$PATH" == */home/philipp/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/philipp/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/philipp/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/philipp/.fzf/shell/key-bindings.zsh"
