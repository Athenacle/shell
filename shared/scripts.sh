#!/bin/bash
# This file could be sourced by both zsh and bash.

lookup() {
    curl ip.cn/"$1"
}

nm_print_demangling(){
    if [[ $# -ne 1 ]]; then
        echo "usage nm_print_demangline [ELF|.so|.o]"
    else
        nm "$1" | awk '{print $3}' | c++filt | \grep -i '^[a-z_0-9]' --color=never | sort | uniq
    fi
}

curl_proxy(){
    if [[ $# -ne 1 ]]; then
        echo "curl_proxy: download a file use curl via shadowsocks proxy."
        echo "Usage: curl_proxy http://www.google.com/index.html"
    else
        url=$1
        filename=$(basename "$1")
        curl --socks5 "$ShadowPORT" "$url" -o "$filename"
    fi
}

digest512Base64(){
    openssl dgst -sha512 -binary $1 | base64
}

sudo_cat_append(){
    echo "==========sudo append to $1==================="
    cat | sudo tee -a "$1" > /dev/null
}



mkdir_time(){
    if [[ $# -ne 0 ]]; then
        echo "mkdir_time: Make a directory which name is current timestamp, and cd into it."
        echo "Usage: mkdir_time"
    else
        the_time=$(date +"%Y.%m.%d-%H.%m.%S")
        mkdir "$the_time" && cd "$the_time" && exit -1
    fi
}


portage_search_use(){
    grep "^""$1" /usr/portage/profiles/use.desc
    ack ":""$1"" -" /usr/portage/profiles/use.local.desc
    true
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
        local pkg_dir
        "$pkg_dir"=$(find /var/db/pkg/"$categroy" -maxdepth 2  -type d -name "$parameter-*") 2>>/dev/null
        if [[ "$pkg_dir" != "" ]]; then
            local line=$(echo $pkg_dir | wc -l )
            if [[ $line -ne 1 ]]; then
                echo "Deplicate PKG $1. Found $line:"
                echo "$pkg_dir"
            else
                local cfile="$pkg_dir/CONTENTS"
                local filel=$(wc -l $cfile | cut -d ' ' -f 1)
                local tmp=$(mktemp)
                cat >> "$tmp" << EOF
`echo "==================================$(echo  $pkg_dir | cut -d '/' -f 5,6)================================="`
`gawk '{printf ("%s %s\n",$1, $2)}' $pkg_dir/CONTENTS`
`echo "===================================$filel files============================================"`
EOF
if [[ "$file" -lt 500 ]]; then
    less "$tmp"
else
    cat "$tmp"
fi
rm "$tmp"
            fi
        else
            echo "pkg $1 not found."
        fi
    fi
}

take (){
    if [ $# != 1 ]; then
        echo "usage: take <dir>"
        echo "mkdir of <dir> and cd into it."
        exit -1
    else
        mkdir -p "$1" && cd "$1" || exit -1
    fi
    true
}


whatip(){
    curl ipv4bot.whatismyipaddress.com
    echo
}

docker_rm_dangling_images(){
    docker rmi -f $(docker images -f "dangling=true" -q)
}

sc-reload-start (){
    sudo systemctl daemon-reload && sudo systemctl start "$1"
}

consul_deregister(){
    CONSUL_HTTP_ADDR=https://$(echo "$1" | gawk -F'/' '{print $3}' | sed 's,443,8501,g' | sed 's,v3,consul,g') consul services deregister -id $(echo "$1" | awk -F'/' '{print $6}')
}
