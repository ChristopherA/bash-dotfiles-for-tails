#!/bin/bash

# ~/.bash_profile: executed by the `bash` command interpreter for login shells.

########
### DETAILS:

# When `bash` is invoked for an login shell (such as a new Terminal window)
# this ~/.bash_profile will be the first local file executed by `bash` after
# the system-wide files /etc/profile and /etc/bashrc.

# Bcause of this file's existence, neither ~/.bash_login nor  ~/.profile will
# be automatically sourced unless they are sourced by manually the other
# shell code.

# ~/.bash_profile is not executed by non-login shells, so don't put anything
# here that bash other scripts may need -- instead non-interactive scripts
# should be placed in  ~/.bashrc and common environment variables, paths,
# etc. in  ~/.profile .

# Put all `bash` interface specific functionality as seperate files in
# ~/.bash_profile.d, such as theme, colors & prompt. Any non-bash specific
# items such as enviroment settings and paths should be put in ~/.profile where
# they will be executed by all other kinds of shells (in particular .sh & .zsh).

########
### Script Debugger

SCRIPT_DEBUG=true
#SCRIPT_DEBUG=false

if $SCRIPT_DEBUG; then echo "    ~/.bash_profile sourced."; fi

########
### Source common environment & paths from ~/.profile

# Because of the existence of ~/.bash_profile, neither ~/.bash_login
# nor ~/.profile will be automatically sourced unless they are sourced
# by the shell code. Here we source ~/.profile first to set all environment
# and path settings, as later scripts may need them. Note that ~/.profile
# will also source ~/.profile.local for local and private settings that should
# not be under version control (for instance user credentials) yet should
# be available to all shells (e.g. git credentials).


## tails terminal does a different order! commenting to not load twice
# if [ -f ~/.profile ]; then
#    source ~/.profile;
# fi


# ~/.bash_profile.d/5-bash-aliases.sh: useful aliases for bash

# from dyvers hands

# fast directory navigation
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias ~="cd ~"           # Go home
alias -- -='cd -'        # Go back

# List dir contents aliases
# ref: http://ss64.com/osx/ls.html
# Long form no user group, color
alias ll="ls -oG"
# Order by last modified, long form no user group, color
alias lt="ls -toG"
# List all except . and ..., color, mark file types, long form no user group, file size
alias la="ls -AGFoh"
# List all except . and ..., color, mark file types, long form no use group, order by last modified, file size
alias lat="ls -AGFoth"
# List one entry per line
alias l1='ls -1'

# Concatenate and print content of files (add line numbers)
alias catn="cat -n"

# ~/.bash_profile.d/5-bash-completion.sh: completion scripts for bash
# from http://bash-completion.alioth.debian.org

# If bash-completion is installed (`brew install bash-completion`)

if [ $(uname) = "Darwin" ]
then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# ~/.bash_profile.d/5-grc.sh: more colors for bash

# If Generic Colourizer (GRC) is installed (`brew install grc`)
# adds colors for make, gcc,g++, as, gas, ld, netstat, ping, traceroute, etc.
# http://korpus.juls.savba.sk/~garabik/software/grc.html

if [ $(uname) = "Darwin" ]
then
  if [ -f $(brew --prefix)/etc/grc.bashrc ]; then
    . $(brew --prefix)/etc/grc.bashrc
  fi
fi

# ~/.bash_profile.d/5-bash-colors.sh: colors for bash
# from dyvers hands

export LS_OPTIONS='--color=auto'

if [ $(uname) = "Linux" ]
then
  eval "`dircolors`"
  alias ls='ls $LS_OPTIONS'
  alias ll='ls $LS_OPTIONS -l'
  alias l='ls $LS_OPTIONS -lA'
fi

if [ $(uname) = "Darwin" ]
then
  # Define Mac bash command line colors, compatible with Solarized color
  # themes from http://ethanschoonover.com/solarized
  export CLICOLOR=1
fi

### Solarized-dark 'ls' colors if we are using Mac OSX `ls`
### as per https://github.com/seebi/dircolors-solarized/issues/10
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

### Colors for Light Terminal Themes
### as per http://antesarkkinen.com/blog/add-colors-to-os-x-terminal-including-ls-and-nano/
# export LSCOLORS=ExFxBxDxCxegedabagacad

## grep colors to highlight matches
export GREP_OPTIONS='$LS_OPTIONS'

## Git Colors
git config --global color.ui true
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto

# Solarized Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# ~/.bash_profile.d/5-bash-exports.sh: useful exports for interactive bash

# from dyvers hands

# Ignore duplicate commands in the history
export HISTCONTROL=ignoredups

# Increase the maximum number of lines contained in the history file
# (default is 500)
export HISTFILESIZE=10000

# Increase the maximum number of commands to remember
# (default is 500)
export HISTSIZE=10000

# Make some commands not show up in history
# `&:` prev
export HISTIGNORE="&:ls:ls *:la:la *:lt:lt *:cd:cd -:pwd;exit:date:* --help"

# Don't clear the screen after quitting a manual page
export MANPAGER="less -X"

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# ~/.bash_profile.d/5-bash-options.sh: useful options for interactive bash

# from dyvers hands

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# History verification, so that commands matched by ! !! and !? are not auto
shopt -s histverify


#### ~/ found in Tail's .bashrc

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Source any local and private settings that bash interatictive specific
# that should not be under version control. ~/.bash_profile.local should be
# added to ~/.gitignore

if [ -f ~/.bash_profile.local ]; then
    source ~/.bash_profile.local;
fi

#######
### ~/.profile Complete

# All bash interface specific functionality has been executed.

if $SCRIPT_DEBUG; then echo "    ~/.bash_profile completed."; fi
