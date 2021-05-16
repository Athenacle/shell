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
    grep "^$1" /usr/portage/profiles/use.desc
    grep ":$1 -" /usr/portage/profiles/use.local.desc
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

docker_rm_exited_container(){
    docker ps --filter=status=exited -q | xargs docker rm
}

sc-reload-start (){
    sudo systemctl daemon-reload && sudo systemctl start "$1"
}

consul_deregister(){
    CONSUL_HTTP_ADDR=https://$(echo "$1" | gawk -F'/' '{print $3}' | sed 's,443,8501,g' | sed 's,v3,consul,g') consul services deregister -id $(echo "$1" | awk -F'/' '{print $6}')
}

disassamble_function(){
    if [ $# != 2 ]; then
        echo "usage: disassamble_function <ELF file> <function>"
        false
    else
        gdb -batch -ex "file $1" -ex "disassemble $2"
    fi
}

anyview_upload(){
    if [ $# != 2 ]; then
        echo "useage: anyview_upload <TXT file> <IP>"
        false
    else
        curl -vv -F "path=/" -F "files[]=@$1" http://"$2"/upload
        curl "http://$2/list?path=%2F" | jq .
    fi
}

weather(){
    curl  -s -H 'accept-language: zh' wttr.in/Jinhua
}

sanitizer(){
    echo -DCMAKE_CXX_FLAGS="'-fsanitize=$1'" -DCMAKE_C_FLAGS="'-fsanitize=$1'" -DCMAKE_EXE_LINKER_FLAGS="'-fsanitize=$1'" -DCMAKE_MODULE_LINKER_FLAGS="'-fsanitize=$1'"
}

spacex(){
    curl --proxy "10.70.20.11:1081" -s https://api.spacexdata.com/v3/launches/latest | jq .
}

