# Path to your oh-my-zsh installation.

if [[ $- != *i* ]] ; then
	return
fi

pname(){
    pid=$(ps -p ${1:-$$} -o ppid=;)
    apid=$(echo $pid | tr -d '[:space:]')
    ps -p ${apid} -o comm=;
}

#_parent_name=$(pname)

if [[ $(pname) == "code" ]] ; then
    bash ; exit 0
fi

export SHELL_DIR="$HOME"/.shell

source $SHELL_DIR/zsh/init-zsh.zsh

export LC_ALL="en_US.utf8"
