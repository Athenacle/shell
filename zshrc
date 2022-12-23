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

PATH="/home/wangxiao/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/wangxiao/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/wangxiao/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/wangxiao/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/wangxiao/perl5"; export PERL_MM_OPT;

