#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.local/share/blesh/ble.sh

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
alias config='/usr/bin/git --git-dir=/home/byron/.myconf/ --work-tree=/home/byron'
PS1='[\u@\h \W]\$ '

git config --replace-all --global core.pager /usr/bin/less
source ~/.git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then
  exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi
