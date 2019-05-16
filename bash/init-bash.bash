
for i in $(ls "$SHELL_DIR"/shared 2>/dev/null); do
    source "$SHELL_DIR"/shared/"$i"
done

source "$BASH_DIR/bash-completion.bash"
source "$BASH_DIR/bash-key-bindings.bash"