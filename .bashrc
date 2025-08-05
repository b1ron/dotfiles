#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

git config --replace-all --global core.pager /usr/bin/less
source ~/.local/share/blesh/ble.sh

source ~/.git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
alias config='/usr/bin/git --git-dir=/home/byron/.myconfig/ --work-tree=/home/byron'

if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then
  exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi
