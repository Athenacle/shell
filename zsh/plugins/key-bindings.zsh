# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

bindkey '\ew' kill-region                                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                                               # [Esc-l] - run command: ls

if [[ "${terminfo[kpp]}" != "" ]]; then
    bindkey "${terminfo[kpp]}" up-line-or-history                     # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
    bindkey "${terminfo[knp]}" down-line-or-history                   # [PageDown] - Down a line of history
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line                    # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}"  end-of-line                          # [End] - Go to end of line
fi

bindkey ' ' magic-space                                               # [Space] - do history expansion

if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete                 # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
    bindkey "${terminfo[kdch1]}" delete-char                          # [Delete] - delete forward
else
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey -s '^X^Z' '%-^M'
bindkey '^[e' expand-cmd-path
bindkey '^[^I' reverse-menu-complete
bindkey '^X^N' accept-and-infer-next-history
bindkey '\eW' emacs-delete-word
bindkey '^I' complete-word
# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'


#####################

eval "f1() {zle push-line;LBUFFER+='fkey_f1';zle accept-line}"
zle -N f1
bindkey '^[OP' f1
#F2
eval "f2() {zle push-line;LBUFFER+='fkey_f2';zle accept-line}"
zle -N f2
bindkey '^[OQ' f2
#F3
eval "f3() {zle push-line;LBUFFER+='fkey_f3';zle accept-line}"
zle -N f3
bindkey '^[OR' f3
#F4
eval "f4() {zle push-line;LBUFFER+='fkey_f4';zle accept-line}"
zle -N f4
bindkey '^[OS' f4
#F5
eval "f5() {zle push-line;LBUFFER+='fkey_f5';zle accept-line}"
zle -N f5
bindkey '^[[15~' f5
#F6
eval "f6() {zle push-line;LBUFFER+='fkey_f6';zle accept-line}"
zle -N f6
bindkey '^[[17~' f6
#F7
eval "f7() {zle push-line;LBUFFER+='fkey_f7';zle accept-line}"
zle -N f7
bindkey '^[[18~' f7
#F8
eval "f8() {zle push-line;LBUFFER+='fkey_f8';zle accept-line}"
zle -N f8
bindkey '^[[19~' f8
#F9
eval "f9() {zle push-line;LBUFFER+='fkey_f9';zle accept-line}"
zle -N f9
bindkey '^[[20~' f9
#F10
eval "f10() {zle push-line;LBUFFER+='fkey_f10';zle accept-line}"
zle -N f10
bindkey '^[[21~' f10
#F11
eval "f11() {zle push-line;LBUFFER+='fkey_f11';zle accept-line}"
zle -N f11
bindkey '^[[23~' f11
#F12
eval "f12() {zle push-line;LBUFFER+='fkey_f12';zle accept-line}"
zle -N f12
bindkey '^[[24~' f12

function fkey_f1 {
         _undefined_fkey
}
function fkey_f2 {
         _undefined_fkey
}
function fkey_f3 {
         _undefined_fkey
}
function fkey_f4 {
         _undefined_fkey
}
function fkey_f5 {
         _undefined_fkey
}
function fkey_f6 {
         _undefined_fkey
}
function fkey_f7 {
         _undefined_fkey
}
function fkey_f8 {
         _undefined_fkey
}
function fkey_f9 {
         _undefined_fkey
}
function fkey_f10 {
         _undefined_fkey
}
function fkey_f11 {
         _undefined_fkey
}
function fkey_f12 {
         ssh $(whoami)@slave.athenacle.xyz
}
function _undefined_fkey {
}
