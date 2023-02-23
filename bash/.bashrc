#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#source /usr/share/blesh/ble.sh --noattach
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

alias ls='ls --color=auto'
alias ll='ls --color=auto -Alh'
alias rm='rm -I'
alias dupe='kitty --single-instance --directory $(pwd)'
alias gerp='grep -rnI --color'
alias kssh='kitty +kitten ssh'
alias icat='kitty +kitten icat'

# Set the terminal prompt
# setaf = text color, 14=cyan, 15=white, 2=green, 11=yellow, 1=red
cyan='\[$(tput setaf 14)\]'
white='\[$(tput setaf 15)\]'
red='\[$(tput setaf 1)\]'
bold='\[$(tput bold)\]'
reset='\[$(tput sgr0)\]'
yellow='\[$(tput setaf 11)\]'

p_end=""
p_venv=""
update_prompt()
{
    if [[ $? == 0 ]]; then
        p_end="\$"
    else
        p_end="$red$?$reset"
    fi

    if [[ -z "${VIRTUAL_ENV}" ]]; then
        p_venv=""
    else
        p_venv="$yellow/$(basename $VIRTUAL_ENV)/$reset "
    fi
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"

PROMPT_COMMAND='update_prompt; __git_ps1 "$p_venv[${cyan}${bold}\u@\h${white} \W" "$reset]$p_end " " | %s"'

#PS1="[${cyan}${bold}\u@\h${white} \W${reset}]\$ "

# This automatically prepends `cd` when entering just a path
shopt -s autocd
export EDITOR=vim
CDPATH=:~:~/3dp
source <(kitty + complete setup bash)


fortune | cowsay | lolcat


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
