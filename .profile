#!/bin/bash

# ~/.profile: executed by Bourne-compatible login shells.

# sourced by ~/.bash_profile or ~/.bashrc or ~/.zshrc

#####
### DETAILS:

# ~/.profile by default is not executed by bash if ~/.bash_profile, ~/.bash_login
# already exists (or on the Mac also if ~/.bashrc). However, as a legacy shell
# file it is executed by many other shells, so we use this file as useful place
# for common exported environmental variables and paths used by all shells.

# In this shell files setup, ~/.profile is either sourced by ~/.bash_profile or
# ~/.zshrc interactively (through a Terminal) or by ~/bashrc non-interactively
# (i.e. ssh, cron, etc.). Any non-interactive functions shoud be as
# lightweight (minimal) as possible to reduce the overhead when starting a
# non-login shell.

########
# Script Debugger

SCRIPT_DEBUG=true
#SCRIPT_DEBUG=false

# Test for a terminal (aka interactive)!

if [[ $- =~ "i" ]]
then # shell is NOT interactive thus echos and other output will not break SCP
  if $SCRIPT_DEBUG; then echo "    ~/.profile sourced."; fi
fi

########
### Source command environment scripts in ~/.profile.d

# Next we source any common environment scripts are need to setup
# both interactive and non-interactive shells, such as
# paths, functions, global aliases, etc.

# ~/.profile.d/0-path-functions.sh: Various path related functions

path_append() {
  if [ -d "$1" ]; then
      PATH=${PATH//":$1:"/:} #delete all instances in the middle
      PATH=${PATH/%":$1"/} #delete any instance at the end
      PATH=${PATH/#"$1:"/} #delete any instance at the beginning
      PATH="${PATH:+"$PATH"}:$1" #prepend $1 or if $PATH is empty set to $1
  fi
}

path_prepend() {
    if [ -d "$1" ]; then
        PATH=${PATH//":$1:"/:} #delete all instances in the middle
        PATH=${PATH/%":$1"/} #delete any instance at the end
        PATH=${PATH/#"$1:"/} #delete any instance at the beginning
        PATH="$1${PATH:+":$PATH"}" #prepend $1 or if $PATH is empty set to $1
    fi
}

# ~/.bash_profile.d/1-path.home-bin.sh: appends ~/.bin to path

# requires ~/.profile.d/0-path-functions.sh

path_append $HOME/bin
path_append $HOME/.bin

# ~/.profile.d/5-bash-aliases.sh: useful aliases for both interactive and
# non-interactive bash

# from dyvers hands

# Allow aliases to be with sudo
alias sudo="sudo "

# ~/.profile.d/5-bash-functions.sh: Various path related functions for both
# interactive and non-interactive bash

# from dyvers hands

# Recursively delete files that match a certain pattern
# (by default delete all `.DS_Store` files)
cleanup() {
    local q="${1:-*.DS_Store}"
    find . -type f -name "$q" -ls -delete
}

########
### Load ~?.profile.local

# ~/.profile.local is sourced for local and private settings that should not be
# under version control (for instance git credentials) yet should be available
# to all shells.

if [ -f ~/.profile.local ]; then
    source ~/.profile.local;
fi


########
### ~/.profile Complete

# All command enviroments scripts have been executed.

if [[ $- =~ "i" ]]
then # shell is NOT interactive thus echos and other output will not break SCP
  if $SCRIPT_DEBUG; then echo "    ~/.profile complete."; fi
fi
