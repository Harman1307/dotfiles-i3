#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Pywal colors
(cat ~/.cache/wal/sequences &)
pactl set-sink-volume @DEFAULT_SINK@ -- --use-sample-interval 2

# Media aliases
alias play='mpv'
alias imgs='sxiv'


# Created by `pipx` on 2025-11-15 13:12:21
export PATH="$PATH:/home/harman/.local/bin"
