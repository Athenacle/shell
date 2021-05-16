
export ZSH_DIR=/home/wangxiao/.shell/zsh/

autoload -U colors select-word-style
colors                                                                # colours
select-word-style bash                                                # ctrl+w on words

##
# Completion
##
autoload -U compinit
compinit
zmodload -i zsh/complist
setopt hash_list_all                                                         # hash everything before completion
setopt completealiases                                                       # complete alisases
setopt always_to_end                                                         # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word                                                      # allow completion from within a word/phrase
#setopt correct                                                               # spelling correction for commands
setopt list_ambiguous                                                        # complete as much of a completion until it gets ambiguous.

zstyle ':completion::complete:*' use-cache on                                # completion caching, use rehash to clear
zstyle ':completion:*' cache-path "$SHELL_DIR"/zshcache                      # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'                    # ignore case
zstyle ':completion:*' menu select=5                                         # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                        # colorz !
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use
zstyle ':completion:*' accept-exact '*(N)'

# sections completion !
zstyle ':completion:*' verbose no
zstyle ':completion:*:descriptions' format $'\e[01;31m%d'
zstyle ':completion:*:messages' format $'\e[00;01m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

#zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*' users $users

#generic completion with --help
compdef _gnu_generic gcc
compdef _gnu_generic r2
compdef _gnu_generic gdb
compdef _gnu_generic openssl

##
# Pushd
##
setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`

##
# History
##
HISTFILE="$SHELL_DIR/history"   #where to store zsh config
HISTSIZE=81920                   # big history
SAVEHIST=81920                	# big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

##
# Various
##
setopt auto_cd                  # if command is a path, cd into it
setopt auto_remove_slash        # self explicit
setopt chase_links              # resolve symlinks
#setopt correct                  # try to correct spelling of commands
setopt extended_glob            # activate complex pattern globbing
setopt glob_dots                # include dotfiles in globbing
#setopt print_exit_value         # print return value if non-zero
unsetopt beep                   # no bell on error
unsetopt bg_nice                # no lower prio for background jobs
setopt clobber                  # must use >| to truncate existing files
unsetopt hist_beep              # no bell on error in history
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt list_beep              # no bell on ambiguous completion
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'

#setxkbmap -option compose:ralt  # compose-key
TERM=xterm-256color             # Colorz!
export GCC_COLORS=1				# Colorz in gcc!

##
# Theme
##
setopt PROMPT_SUBST             # allow funky stuff in prompt
source "$ZSH_DIR"/agnoster.zsh-theme

##
# Keys
##
cdlast() {
    cd -
    zle reset-prompt
}

cdhome() {
    cd ~
    zle reset-prompt
}

backward-kill-sentence(){
    autoload -Uz select-word-style
    select-word-style shell                                            
    zle backward-kill-word

    autoload -Uz select-word-style
    select-word-style bash                                            
}


zle -N cdhome
zle -N cdlast
zle -N backward-kill-sentence

# for keys, refer to https://www.zsh.org/mla/users/2014/msg00266.html
bindkey -e                                # emacs keybindings
bindkey -e '^[^W'    backward-kill-sentence    

bindkey '^`'      cdhome
bindkey '^q'      cdlast
bindkey '\e[2~'   overwrite-mode          # Insert
bindkey '\e[3~'   delete-char             # Del
bindkey '\e[5~'   history-search-backward # PgUp
bindkey '\e[6~'   history-search-forward  # PgDn
bindkey "^V"      cdlast

##
# Other files
##

##
# Some others
##
alias -s gz="tar xfz"
alias -s bz2="tar xfj"
alias -s xz="tar xfJ"
alias -s zip="unzip"


for i in $(ls "$SHELL_DIR"/shared 2>/dev/null); do
    source "$SHELL_DIR"/shared/"$i"
done

for i in $(ls "$ZSH_DIR"/plugins 2>/dev/null); do
    source "$ZSH_DIR"/plugins/"$i"
done

##
# Plugins
##

# sudo
__sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N __sudo-command-line
bindkey "\es" __sudo-command-line

