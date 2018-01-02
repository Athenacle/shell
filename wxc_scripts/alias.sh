#!/bin/sh
#this file is used for init different kinds of alias names.

SSH_KEY_PATH="~/.ssh/id_rsa"

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

alias ll="ls -l"
alias lh="ls -lhSr"
alias la="ls -aF"
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias formatall="find . -name \"*.[hc]\" | xargs clang-format-wxc -i"
alias diff="diff --color"
alias appServerEnc="openssl enc -aes-128-cbc  -K 30303132333435363738393031323334 -iv  30444541444245454646454542414544"

SHELL_TYPE=$(check_shell_type)

if [[ "$SHELL_TYPE" == "zsh" ]]; then
    alias -s gz="tar xfz"
    alias -s bz2="tar xfj"
    alias -s xz="tar xfJ"
fi
