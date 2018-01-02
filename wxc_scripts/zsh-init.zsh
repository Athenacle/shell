#! /bin/zsh


source "$SHELL_DIR"/wxc_scripts/check_shell_type.sh

#initial script.
#include source any other scripts.
ulimit -c 10000

cdlast() {
    cd -
    zle reset-prompt
}

cdhome() {
    cd ~
    zle reset-prompt
}
zle -N cdhome
zle -N cdlast

bindkey '^`' cdhome
bindkey '^Q' cdlast


setopt HIST_IGNORE_DUPS

source "$SHELL_DIR"/wxc_scripts/scripts.sh
source "$SHELL_DIR"/wxc_scripts/alias.sh
source "$SHELL_DIR"/wxc_scripts/exports.sh
source "$SHELL_DIR"/wxc_scripts/agnoster.zsh-theme
