#! /bin/sh
# This file could be sourced by both zsh and bash.

lookup() {
    #find ip information from ip.cn
    curl ip.cn/$1
}

nm_print_demangling(){
    if [[ $# -ne 1 ]]; then
        echo "usage nm_print_demangline [ELF|.so|.o]"
    else
        nm $1 | awk '{print $3}' | c++filt | grep -i '^[a-z_0-9]' --color=never
    fi
}

curl_proxy(){
    if [[ $# -ne 1 ]]; then
        echo "curl_proxy: download a file use curl via shadowsocks proxy."
        echo "Usage: curl_proxy http://www.google.com/index.html"
    else
        local url=$1
        local filename=$(basename $1)
        curl --socks5 $ShadowPORT $url -o $filename
    fi
}

digest512Base64(){
    openssl dgst -sha512 -binary $1 | base64
}

sudo_cat_append(){
    echo "==========sudo append to $1==================="
    cat | sudo tee -a $1 > /dev/null
}


#create a git repository at pi-slave.
#note that before call this command, the local repo must have at least one commit.
#sshpis gitinit $name:
#gitinit is a remote script file.
###gitinit#########
#! /bin/sh
#cd /home/git/sandisk/gits/
#sudo mkdir $1.git
#cd $1.git
#sudo git init --bare
#sudo chown git:git . -R

create_git_repo(){
    if [[ $# -ne 0 ]]; then
        echo "create_git_repo: create git repository at athenacle.xyz"
        echo "Usage: create_git_repo "
    else
        local cur_path=$(pwd)
        local name=$(basename $cur_path)
        ssh root@athenacle.xyz gitinit $name
        git remote add vps root@athenacle.xyz:/root/gits/$name.git
        git push vps master
    fi
}

mkdir_time(){
    if [[ $# -ne 0 ]]; then
        echo "mkdir_time: Make a directory which name is current time stamp, and cd into it."
        echo "Usage: mkdir_time"
    else
        local the_time = $(date +"%Y.%m.%d-%H.%m.%S")
        mkdir $the_time && cd $the_time
    fi
}


portage_search_use(){
    #find USE flag in Gentoo distribution.
    find /usr/portage/profiles/ -name "use*desc" -exec grep -i ":$1 |^$1" {}  --no-color \;
}

portage_pkg_cotents(){
    if [[ $# -ne 1 ]]; then
        echo "portage_pkg_contents: Print contents of a pkg"
        echo "Usage: portage_pkg_contents category/pkg-name"
        echo "       portage_pkg_contents pkg-name"
    else
        local parameter=$1
        local categroy=""
        if [[ $1 == *"/"* ]]; then
            categroy=$(dirname $1)
        fi
        local pkg_dir=$(find /var/db/pkg/$category -maxdepth 2  -type d -name "$parameter-*") 2>>/dev/null
        if [[ "$pkg_dir" != "" ]]; then
            local line=$(echo $pkg_dir | wc -l )
            if [[ $line -ne 1 ]]; then
                echo "Deplicate PKG $1. Found $line:"
                echo "$pkg_dir"
            else
                local cfile="$pkg_dir/CONTENTS"
                local filel=$(wc -l $cfile | cut -d ' ' -f 1)
                local tmp=$(mktemp)
                cat >> $tmp << EOF
`echo "==================================$(echo  $pkg_dir | cut -d '/' -f 5,6)================================="`
`gawk '{printf ("%s %s\n",$1, $2)}' $pkg_dir/CONTENTS`
`echo "===================================$filel files============================================"`
EOF
                if [[ $file -lt 500 ]]; then
                    less $tmp
                else
                    cat $tmp
                fi
                rm $tmp
            fi
        else
            echo "pkg $1 not found."
        fi
    fi
}
