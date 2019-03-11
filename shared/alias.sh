#!/bin/sh
#this file is used for init different kinds of alias names.

SSH_KEY_PATH="$HOME/.ssh/id_rsa"

alias sshmain="ssh wangxiao@127.0.0.1"
alias zshrc="$EDITOR ~/.zshrc; source ~/.zshrc"
alias sftpvps="sftp -P $VPS_SSH_PORT $VPS_USERNAME@$VPS -i $SSH_KEY_PATH"
alias sshpim="ssh $PI_USERNAME@$PI_MASTER -i $SSH_KEY_PATH"
alias sshpis="ssh $PI_USERNAME@$PI_SLAVE -i $SSH_KEY_PATH"
alias sshvps="ssh -p $VPS_SSH_PORT $VPS_USERNAME@$VPS"
alias sshgit="ssh $GIT_USERNAME@$GIT_SERVER"

alias tmux="TERM=screen-256color tmux"

alias ..="cd .."
alias ...="cd ../.."

alias ls="ls --color"
alias ll="ls -l --color"
alias lh="ls -lhSr --color"
alias la="ls -aF --color"
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias formatall="find . -name \"*.[hc]\" | xargs clang-format-wxc -i"
alias diff="diff --color"

if which bat > /dev/null; then

    alias cat="bat"
fi

if which ack > /dev/null;then
    alias grep="ack"
    alias ack="ack --ignore-dir=.git"
fi

if which nvim > /dev/null; then
    alias vim="nvim"
fi

alias sc-poweroff="sudo systemctl poweroff"

