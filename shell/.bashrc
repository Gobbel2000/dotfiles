#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# PROMPT

source /usr/share/git/completion/git-prompt.sh

# Set the terminal prompt
# setaf = text color, 14=cyan, 15=white, 2=green, 11=yellow, 1=red
cyan="\[$(tput setaf 14)\]"
white="\[$(tput setaf 15)\]"
red="\[$(tput setaf 1)\]"
bold="\[$(tput bold)\]"
reset="\[$(tput sgr0)\]"
yellow="\[$(tput setaf 11)\]"

update_prompt()
{
    local RC=$?
    local p_end
    local p_venv
    if [[ $RC == 0 ]]; then
        p_end="\$"
    else
        p_end="${red}${RC}${reset}"
    fi
    [[ "${VIRTUAL_ENV}" ]] && p_venv="$yellow/$(basename "${VIRTUAL_ENV}")/$reset "
    __git_ps1 "${p_venv}[${cyan}${bold}\u@\h${white} \W" "${reset}]${p_end} " " |${reset} %s"
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"

PROMPT_COMMAND='update_prompt'
#PS1="[${cyan}${bold}\u@\h${white} \W${reset}]\$ "


shopt -s autocd
if [[ -f ~/.shell-common ]]; then
    source ~/.shell-common
fi

source <(kitty + complete setup bash)

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
