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


alias ls='ls --color=auto'
alias ll='ls --color=auto -Alh'
alias rm='rm -I'
alias gerp='grep -rnI --color'

# Set the terminal prompt
# setaf = text color, 14=cyan, 15=white, 2=green, 11=yellow, 1=red
cyan='\[$(tput setaf 14)\]'
green='\[$(tput setaf 2)\]'
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

PROMPT_COMMAND='update_prompt; __git_ps1 "$p_venv[${green}${bold}\u@\h${white} \W" "$reset]$p_end " " | %s"'
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '

# This automatically prepends `cd` when entering just a path
shopt -s autocd
export EDITOR=vim

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.klippo_aliases ]; then
    . ~/.klippo_aliases
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
