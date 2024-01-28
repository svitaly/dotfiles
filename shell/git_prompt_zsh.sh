# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:git:*' formats '%F{yellow} (%b)%f'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%n %F{green}${PWD/#$HOME/~}%f${vcs_info_msg_0_} $ '
