#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# Set the terminal prompt
# setaf = text color, 14=cyan, 15=white, 2=green, 11=yellow, 1=red
prompt="\[$(tput setaf 161)\]"
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
    __git_ps1 "${p_venv}[${prompt}${bold}\u@\h${white} \W" "${reset}]${p_end} " " |${reset} %s"
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"

PROMPT_COMMAND='update_prompt'
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '

# This automatically prepends `cd` when entering just a path
shopt -s autocd

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.klippo_aliases ]; then
    . ~/.klippo_aliases
fi

if [[ -f ~/.shell-common ]]; then
    source ~/.shell-common
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
